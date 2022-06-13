Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37F7549C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbiFMSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245063AbiFMSzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:23 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F5FC83C;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 071F243194;
        Mon, 13 Jun 2022 11:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135632;
        bh=MTBFqtYh8vFqi/JPaarIPLoyKboTzrz+Y7pswS/tquw=;
        h=From:To:CC:Subject:Date:From;
        b=TZ/zgaRe7hf0qksdwP7DMkjvez1ETKht2Y7kbgb20D0+HFNzonsQwi2KDvekQcpL9
         tiulLR1yz071OQr/rIRExLGY3OXWpDUFRFv27wThhOPXu/FhJq+VjaDqEtNsc7iNtw
         BGVmj8Ri89xTw6ZXFlxgAaeDi4IAzl//UK1OE310TgZuYewkCZcM9zFKIPmq7VFFwQ
         GERwyRsiPYhre4+bXokU0+G7l7SiFz3oypwnTm4X+LJASTyTsg8QUeaPSJ4T8T6n1o
         bTnMGfg4Xvhk9uXkKsPdF7GqG+ubn+y6IBb+IZ5FnVHzggqAdnB3trsTfr6MYuEtnM
         AVaYCU781r+Pg==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:53:49 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 00/20] blksnap - creating non-persistent snapshots for backup
Date:   Mon, 13 Jun 2022 18:52:53 +0300
Message-ID: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I suggest the blksnap kernel module for consideration. It allows to create
non-persistent snapshots of any block devices. The main purpose of such
snapshots is to create a backup of block devices.

A snapshot is created simultaneously for several block devices, ensuring
their mutual consistency in the backup.

A change tracker is implemented in the module. It allows to determine
which blocks were changed during the time between the last snapshot
created and any of the previous snapshots of the same generation.
This allows to implement incremental and differential backups.

An arbitrary range of sectors on any block device can be used to store
snapshot changes. The size of the storage for changes can be increased after the
snapshot is created by adding new sector ranges. This allows to create a
storage of differences in individual files on a file system that can occupy
the entire space of a block device and increase the storage of differences
as needed.

To create images of snapshots of block devices, the module stores blocks
of the original block device that have been changed since the snapshot was
taken. To do this, the module intercepts write requests and reads blocks
that need to be overwritten. This algorithm guarantees the safety of the
data of the original block device in case of overflow of the snapshot and
even in case of unpredictable critical errors.

To connect and disconnect the module to the block layer, the concept of a
block device filter is introduced. Functions for connecting filters are
added to the block layer and the ability to intercept I/O requests is
provided.

The blksnap module was created specifically for upstream based on the
experience of operating the out-of-tree veeamsnap module, which is part of
the Veeam Agent for Linux product. I am sure that the module will be in
demand by other creators of backup tools and will save them from having to
use their out-of-tree kernel modules.

A tool, a library for working with blksnap, tests and some documentations
can be found at www.github.com/veeam/blksnap.

Sergei Shtepa (20):
  block, blk_filter: enable block device filters
  block, blksnap: header file of the module interface
  block, blksnap: module management interface functions
  block, blksnap: init() and exit() functions
  block, blksnap: interaction with sysfs
  block, blksnap: attaching and detaching the filter and handling a bios
  block, blksnap: map of change block tracking
  block, blksnap: big buffer in the form of an array of pages
  block, blksnap: minimum data storage unit of the original block device
  block, blksnap: buffer in memory for the minimum data storage unit
  block, blksnap: functions and structures for performing block I/O
    operations
  block, blksnap: storage for storing difference blocks
  block, blksnap: event queue from the difference storage
  block, blksnap: owner of information about overwritten blocks of the
    original block device
  block, blksnap: snapshot image block device
  block, blksnap: snapshot
  block, blksnap: debugging mechanism for monitoring memory consumption
  block, blksnap: Kconfig
  block, blksnap: Makefile
  block, blksnap: adds a blksnap to the kernel tree

 block/Kconfig                          |   8 +
 block/bdev.c                           | 129 +++++
 block/blk-core.c                       |  88 ++++
 drivers/block/Kconfig                  |   2 +
 drivers/block/Makefile                 |   1 +
 drivers/block/blksnap/Kconfig          | 101 ++++
 drivers/block/blksnap/Makefile         |  20 +
 drivers/block/blksnap/big_buffer.c     | 218 ++++++++
 drivers/block/blksnap/big_buffer.h     |  27 +
 drivers/block/blksnap/cbt_map.c        | 280 ++++++++++
 drivers/block/blksnap/cbt_map.h        | 112 ++++
 drivers/block/blksnap/chunk.c          | 352 +++++++++++++
 drivers/block/blksnap/chunk.h          | 129 +++++
 drivers/block/blksnap/ctrl.c           | 445 ++++++++++++++++
 drivers/block/blksnap/ctrl.h           |   7 +
 drivers/block/blksnap/diff_area.c      | 602 +++++++++++++++++++++
 drivers/block/blksnap/diff_area.h      | 179 +++++++
 drivers/block/blksnap/diff_buffer.c    | 146 ++++++
 drivers/block/blksnap/diff_buffer.h    |  78 +++
 drivers/block/blksnap/diff_io.c        | 204 ++++++++
 drivers/block/blksnap/diff_io.h        | 122 +++++
 drivers/block/blksnap/diff_storage.c   | 316 +++++++++++
 drivers/block/blksnap/diff_storage.h   |  94 ++++
 drivers/block/blksnap/event_queue.c    |  90 ++++
 drivers/block/blksnap/event_queue.h    |  64 +++
 drivers/block/blksnap/main.c           | 109 ++++
 drivers/block/blksnap/memory_checker.c | 100 ++++
 drivers/block/blksnap/memory_checker.h |  41 ++
 drivers/block/blksnap/params.h         |  10 +
 drivers/block/blksnap/snapimage.c      | 345 ++++++++++++
 drivers/block/blksnap/snapimage.h      |  65 +++
 drivers/block/blksnap/snapshot.c       | 671 ++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h       |  76 +++
 drivers/block/blksnap/sysfs.c          |  81 +++
 drivers/block/blksnap/sysfs.h          |   5 +
 drivers/block/blksnap/tracker.c        | 693 +++++++++++++++++++++++++
 drivers/block/blksnap/tracker.h        |  71 +++
 drivers/block/blksnap/version.h        |   8 +
 include/linux/blk_snap.h               | 460 ++++++++++++++++
 include/linux/blk_types.h              |  22 +
 include/linux/blkdev.h                 |  81 +++
 41 files changed, 6652 insertions(+)
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile
 create mode 100644 drivers/block/blksnap/big_buffer.c
 create mode 100644 drivers/block/blksnap/big_buffer.h
 create mode 100644 drivers/block/blksnap/cbt_map.c
 create mode 100644 drivers/block/blksnap/cbt_map.h
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h
 create mode 100644 drivers/block/blksnap/ctrl.c
 create mode 100644 drivers/block/blksnap/ctrl.h
 create mode 100644 drivers/block/blksnap/diff_area.c
 create mode 100644 drivers/block/blksnap/diff_area.h
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h
 create mode 100644 drivers/block/blksnap/diff_io.c
 create mode 100644 drivers/block/blksnap/diff_io.h
 create mode 100644 drivers/block/blksnap/diff_storage.c
 create mode 100644 drivers/block/blksnap/diff_storage.h
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/memory_checker.c
 create mode 100644 drivers/block/blksnap/memory_checker.h
 create mode 100644 drivers/block/blksnap/params.h
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h
 create mode 100644 drivers/block/blksnap/sysfs.c
 create mode 100644 drivers/block/blksnap/sysfs.h
 create mode 100644 drivers/block/blksnap/tracker.c
 create mode 100644 drivers/block/blksnap/tracker.h
 create mode 100644 drivers/block/blksnap/version.h
 create mode 100644 include/linux/blk_snap.h

-- 
2.20.1


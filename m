Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF14EE8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbiDAHGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiDAHGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:06:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0C65D29
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:04:27 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVB3n2CpVzdZQQ;
        Fri,  1 Apr 2022 15:04:05 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:04:25 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 15:04:25 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <yuyufen@huawei.com>
Subject: [PATCH 0/5] f2fs: try to use common fault injection framework
Date:   Fri, 1 Apr 2022 15:19:04 +0800
Message-ID: <20220401071909.505086-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Kernel fault injection framework have provided a a systematic
  way to support error injection via debugfs in the /sys/kernel/debug
  directory.

  Compared to the current fault injection by mount options and sysfs,
  fault injection framework can provide more easy used fault injection
  control means.

  Thus, this patchset try to use common fault injection for f2fs.

Yufen Yu (5):
  f2fs: extract f2fs root debugfs to init_f2fs_fs
  f2fs: use common fault injection frmework
  f2fs: replace function time_to_inject by f2fs_should_fail
  f2fs: get rid of stale fault injection code
  f2fs: update doc for f2fs fault injection

 Documentation/filesystems/f2fs.rst | 118 ++++++++++++++++++++++-------
 fs/f2fs/Kconfig                    |   2 +-
 fs/f2fs/Makefile                   |   1 +
 fs/f2fs/checkpoint.c               |   4 +-
 fs/f2fs/data.c                     |   4 +-
 fs/f2fs/debug.c                    |  19 +----
 fs/f2fs/dir.c                      |   2 +-
 fs/f2fs/f2fs.h                     |  81 ++++++++------------
 fs/f2fs/fault_inject.c             |  67 ++++++++++++++++
 fs/f2fs/file.c                     |   2 +-
 fs/f2fs/gc.c                       |   2 +-
 fs/f2fs/inode.c                    |   2 +-
 fs/f2fs/node.c                     |   2 +-
 fs/f2fs/segment.c                  |   4 +-
 fs/f2fs/super.c                    |  82 ++++++--------------
 fs/f2fs/sysfs.c                    |  23 ------
 16 files changed, 227 insertions(+), 188 deletions(-)
 create mode 100644 fs/f2fs/fault_inject.c

-- 
2.31.1


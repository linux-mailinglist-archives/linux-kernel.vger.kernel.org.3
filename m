Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6921749A54D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2372918AbiAYAMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 19:12:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47058 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578846AbiAXWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:04:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4724B615A3;
        Mon, 24 Jan 2022 22:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6D5C340E9;
        Mon, 24 Jan 2022 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643061828;
        bh=torCgvUQ4OjZaj/EDgDlqqHx/5njlYExaA/ynIldKoI=;
        h=From:To:Cc:Subject:Date:From;
        b=V5M2s7HimfXibF9pbGSiOOxJaSEFUHGjJqs8UiMM1ZO9NF8YE7aLWF5VMQ9wS0NlU
         E21D1/wKhH1z1c0pnyupmPh/x/qSMHey4ZPETUd7xp3R0T8PZkZPD3kpDrd7Q0T9jG
         kbDkNLZhMWlwq65T4jUbaBQPmxMHzlTWhQrp9jvKBtOARhTZYGByJj2X6BrPKxVJcQ
         4SppDB4vqcnwx7coNu/W+LQTX/qSY1dFyppLvD+b9nFe2Lcc1zRXU1M9qc/miuauZc
         dkAUmFRmNt46r3JQqfVFpur9a99kWjPrLucuUjKjeN0JYaDL9qDT8S2XgwO1b0b9R7
         VKmJbaS8T+GeQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/3] block: show crypto capabilities in sysfs
Date:   Mon, 24 Jan 2022 13:59:35 -0800
Message-Id: <20220124215938.2769-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sysfs files that expose the inline encryption
capabilities of request queues.

Patches 1 and 2 are some related cleanups for existing blk-sysfs code.
Patch 3 is the real change; see there for more details.

This series applies to v5.17-rc1.

Changed v3 => v4:
   - Reworded a comment in patch 2.
   - Updated dates in sysfs documentation.
   - Added more Reviewed-by tags.

Changed v2 => v3:
   - Moved the documentation into Documentation/ABI/stable/sysfs-block,
     and improved it a bit.
   - Write "/sys/block/" instead of "/sys/class/block/".
   - Added Reviewed-by tags.

Changed v1 => v2:
   - Use sysfs_emit() instead of sprintf().
   - Use __ATTR_RO().

Eric Biggers (3):
  block: simplify calling convention of elv_unregister_queue()
  block: don't delete queue kobject before its children
  blk-crypto: show crypto capabilities in sysfs

 Documentation/ABI/stable/sysfs-block |  49 ++++++++
 block/Makefile                       |   3 +-
 block/blk-crypto-internal.h          |  12 ++
 block/blk-crypto-sysfs.c             | 172 +++++++++++++++++++++++++++
 block/blk-crypto.c                   |   3 +
 block/blk-sysfs.c                    |  17 ++-
 block/elevator.c                     |   8 +-
 include/linux/blkdev.h               |   1 +
 8 files changed, 255 insertions(+), 10 deletions(-)
 create mode 100644 block/blk-crypto-sysfs.c


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.34.1


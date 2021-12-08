Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3735146CA1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbhLHBkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:40:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhLHBkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:40:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 989E0B81EBA;
        Wed,  8 Dec 2021 01:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B2CC341C5;
        Wed,  8 Dec 2021 01:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638927403;
        bh=O5wE9+3ULZmhOnsEESu1m4V7ztbE6p5LfhS0yA36me0=;
        h=From:To:Cc:Subject:Date:From;
        b=KFztRX1RL8+lQQfHnzjQWu7UE3ehD9VZ8nvJ1W7U3ghFzxhtwxsOV90PqajMrdURb
         ITEWs7SmUbpIFIimCjCZnR6+DlNgfsco1yMQTWL1xNBTJhBdK/reg0SQtzoYpho1AG
         Bgj13m15U18EpS+5qgF2kvt7zLy+G8t1wz66vjR2kwfbXpCUGsZk7Lv7X3uD+aDMOg
         bOKGTwFTD6yXjuIW7DYFy8IaYcxh1Jord3atrqQcxaCQRHuj/cz7uXDz9CKVLY1goz
         K4FDszwJqUbsgbiX5eZ2QzuB2KPFsTLFg3GYr3HIS08K9AuLNi+Nrq0MRVKW6qmM8d
         W43malhVRkM9w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/3] block: show crypto capabilities in sysfs
Date:   Tue,  7 Dec 2021 17:35:31 -0800
Message-Id: <20211208013534.136590-1-ebiggers@kernel.org>
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

This is based on top of my other patch series
"[PATCH v2 0/8] docs: consolidate sysfs-block into Documentation/ABI/"
(https://lore.kernel.org/r/20211208005640.102814-1-ebiggers@kernel.org).

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

-- 
2.34.1


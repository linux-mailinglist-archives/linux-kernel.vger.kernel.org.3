Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A04613C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhK2LY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:24:27 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59539 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240175AbhK2LWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:22:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uyht2tS_1638184736;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0Uyht2tS_1638184736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Nov 2021 19:19:04 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] nvme: duplicate NQNs check if devices needed
Date:   Mon, 29 Nov 2021 19:18:54 +0800
Message-Id: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device provides an NQN it is expected to be globally unique.
Unfortunately some firmware revisions for Intel P4500/P4510 and some
other old devices did not satisfy this requirement. If devices have the
same subnqn field, after a kernel upgrade from 4.19 to 5.10, if a system
has >1 affected device then only one device is enabled. Error like this:

nvme nvme2: Duplicate cntlid 0 with nvme0, rejecting
nvme nvme3: Duplicate cntlid 1 with nvme1, rejecting

In these circumstances, if subnqn did not begin with "nqn.", we assume
that devices did not need subnqn check.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4c63564adeaa..80abb4526932 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 
 	lockdep_assert_held(&nvme_subsystems_lock);
 
+	if (strncmp(subsysnqn, "nqn.", 4))
+		return NULL;
+
 	/*
 	 * Fail matches for discovery subsystems. This results
 	 * in each discovery controller bound to a unique subsystem.
-- 
2.19.1.6.gb485710b


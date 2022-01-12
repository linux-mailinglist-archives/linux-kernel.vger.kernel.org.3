Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090BE48BC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347783AbiALBcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:32:11 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:54432
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235678AbiALBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:32:10 -0500
Received: from HP-EliteBook-840-G7.. (36-229-237-100.dynamic-ip.hinet.net [36.229.237.100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DD30541941;
        Wed, 12 Jan 2022 01:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641951123;
        bh=Jd9ClsZn8dY52Thwduiwucevo5VuBYcc8qo3tnNAMNw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Xb1Bjh4x9tA2CLxIgjsBPbs9Bfk5iWUaVfSZVwZn8dwF7XkY55BasZkGZxs760GS7
         Jy+iix38ttC+Q50SvYSEKojrLhLpY84Io23p8mhf2wsx0lGrzdiX+qpxkS1sS7WaMT
         qe8id+jmJDUJhJqtrEeRg9XU2WlJBswbbu534i0mO6KIv8LYzuldV3JvSya72b8mRy
         esBma+1J+W6+I1dXuI2UzDmuFQJrZaIpGcWXXIER7XN7dG+RNASqv5NCTul9vu+rRC
         GE0IGAuOESTBrH1NqW2dtSCjK6MOpimcTmo/a4dC5a7VJ1cKze1LgiZCTE3qlM/V7C
         gsNcoCbXRlo5Q==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Mark external NVMe devices as removable
Date:   Wed, 12 Jan 2022 09:31:54 +0800
Message-Id: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c037b6c818c3 ("PCI: Add sysfs "removable" attribute") can mark
entire Thunderbolt hierarchy as removable, if system firmware provides
correct attribute.

So apply GENHD_FL_REMOVABLE for NVMe if removable bit is set, to make
userspace daemon like Udisks knows it can be automount.

Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1af8a4513708a..1c3b04883965f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3851,6 +3851,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->disk = disk;
 	ns->queue = disk->queue;
 
+	if (dev_is_removable(ctrl->dev))
+		ns->disk->flags |= GENHD_FL_REMOVABLE;
+
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
 
-- 
2.33.1


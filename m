Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50137513146
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiD1Kae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiD1Kac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:30:32 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 03:27:16 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F53E0D9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:27:16 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1651141165;
        bh=HDPmPUonfLA18N3RXFt5kVLnPCi7amyMZQTy67dXQwc=;
        h=From:To:Cc:Subject:Date:From;
        b=P8aClK6Y0g1CHjYNxqx8xMgauuxlIqa6OfRoobMHCHTXG9xjBjjn8tiNM8DUx5OnE
         xamrBg2R/Lo2vMt/tzrqJ69VyX4+jmZLqlQIZp1qaTrhe8F0DFWiOcweVmwLhLY/2p
         0upI/wdk01BVAItbB9EvqqedIndHQaK88SmPSiW4=
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] nvme-pci: fix host memory buffer allocation size
Date:   Thu, 28 Apr 2022 12:19:22 +0200
Message-Id: <20220428101922.14216-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651141162; l=1214; s=20211113; h=from:subject; bh=HDPmPUonfLA18N3RXFt5kVLnPCi7amyMZQTy67dXQwc=; b=OiwSDn/v0nel5RXEG7W+KHVEVkvgcbHiVXm+yYEAd5FC4Uc0EuTF1Bc4BT4EmxhFl3URAIeaUSar WqhLdmDgADR5QqlPiuV66HUNIO7gCIYQd5x4wifwMCtLXLp4B9q9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to allocate the smallest possible amount of buffers with the
largest possible size (1 buffer of size "hmpre").

Previously we were allocating as many buffers as possible of the smallest
possible size.
This also lead to "hmpre" to not be satisifed as not enough buffer slots
where available.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

Also discussed at https://lore.kernel.org/linux-nvme/f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de/

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..0546523cc20b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2090,7 +2090,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 {
-	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
+	u64 min_chunk = max_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
 	u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
 	u64 chunk_size;
 

base-commit: 46cf2c613f4b10eb12f749207b0fd2c1bfae3088
-- 
2.36.0


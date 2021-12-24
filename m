Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE347EACB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351070AbhLXDTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:19:02 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:56336 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350989AbhLXDTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:19:01 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowAAH6RUTPMVhaMXHBA--.3002S2;
        Fri, 24 Dec 2021 11:18:43 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] usb: dwc2: host: Check for error map
Date:   Fri, 24 Dec 2021 11:18:42 +0800
Message-Id: <20211224031842.1564705-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAH6RUTPMVhaMXHBA--.3002S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWDZF1fCF4UWF45JFW7XFb_yoW8Gr45p3
        yUKFyFkF1Utrn2vw45tF98XFyrJan3X3sFkrW7C39Y9ws5Xr45GrnxGas8XrW5tF92k3Wa
        kF47Ar1rCF45JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU0NtcUUU
        UU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the possible failure of the dma_map_single(), it should be better to
check the return map address by using dma_mapping_error() to guarantee
the valid of the map address.

Fixes: 197ba5f406cc ("Move DWC2 driver out of staging")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/usb/dwc2/hcd_ddma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_ddma.c b/drivers/usb/dwc2/hcd_ddma.c
index a858b5f9c1d6..89ed93a67c8a 100644
--- a/drivers/usb/dwc2/hcd_ddma.c
+++ b/drivers/usb/dwc2/hcd_ddma.c
@@ -143,6 +143,7 @@ static void dwc2_desc_list_free(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 
 static int dwc2_frame_list_alloc(struct dwc2_hsotg *hsotg, gfp_t mem_flags)
 {
+	dma_addr_t addr;
 	if (hsotg->frame_list)
 		return 0;
 
@@ -151,9 +152,13 @@ static int dwc2_frame_list_alloc(struct dwc2_hsotg *hsotg, gfp_t mem_flags)
 	if (!hsotg->frame_list)
 		return -ENOMEM;
 
-	hsotg->frame_list_dma = dma_map_single(hsotg->dev, hsotg->frame_list,
-					       hsotg->frame_list_sz,
-					       DMA_TO_DEVICE);
+	addr = dma_map_single(hsotg->dev, hsotg->frame_list,
+			      hsotg->frame_list_sz,
+			      DMA_TO_DEVICE);
+	if (dma_mapping_error(hsotg->dev, addr))
+		return -ENOMEM;
+
+	hsotg->frame_list_dma = addr;
 
 	return 0;
 }
-- 
2.25.1


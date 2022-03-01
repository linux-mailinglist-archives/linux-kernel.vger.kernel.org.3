Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F874C872C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiCAI4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiCAI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:56:40 -0500
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24344CD62
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:55:55 -0800 (PST)
X-QQ-mid: bizesmtp72t1646124947t9a9zs3n
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Mar 2022 16:55:42 +0800 (CST)
X-QQ-SSF: 0140000000800050D000B00B0000000
X-QQ-FEAT: Mx1dxJbW4IWBoPudVZz/5q9bo01rO9o9bK3W/8F7ds9vRdzxmheGoY543WGL3
        jbPXzUhhuCNdKKHuLozaT23OJHKYAt8QW6foFXYvus/lbfbkGhSFRf0+Ug11ZLxDrrxgAGI
        MySXFsvsgKmWIin8kEafaQpMUNwDokN/yM0XqEhIkiTitC2d7RqD5Vn9m1P2QS8pNIjWds2
        1ML05bpuRBCLRPUjaPXqL6l2I0IXZr4CXcoL0mxFnlfZTNZKWJmBe8IrUFqnNIidsXUI6U/
        4v8DBp3FDzsUSF7iB7e3Br5WZXKlSaDT42kf1e/eNphncPDEEnCpOVwsc7n2Baxgv06zEKG
        5ipd7gNM8FJ0JHe05A=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] ALSA: n64: Use platform_get_irq() to get the interrupt
Date:   Tue,  1 Mar 2022 16:55:36 +0800
Message-Id: <20220301085536.24599-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/mips/snd-n64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/mips/snd-n64.c b/sound/mips/snd-n64.c
index 463a6fe589eb..19365aab15ba 100644
--- a/sound/mips/snd-n64.c
+++ b/sound/mips/snd-n64.c
@@ -289,7 +289,7 @@ static int __init n64audio_probe(struct platform_device *pdev)
 	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct n64audio *priv;
-	struct resource *res;
+	int irq;
 	int err;
 
 	err = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
@@ -337,12 +337,12 @@ static int __init n64audio_probe(struct platform_device *pdev)
 	strcpy(card->shortname, "N64 Audio");
 	strcpy(card->longname, "N64 Audio");
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		err = -EINVAL;
 		goto fail_dma_alloc;
 	}
-	if (devm_request_irq(&pdev->dev, res->start, n64audio_isr,
+	if (devm_request_irq(&pdev->dev, irq, n64audio_isr,
 				IRQF_SHARED, "N64 Audio", priv)) {
 		err = -EBUSY;
 		goto fail_dma_alloc;
-- 
2.20.1




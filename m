Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E91577896
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiGQWUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiGQWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:20:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9C12AF6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id oy13so18291362ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnSb4cWLjt1pnom/8Wk4obyvClEVJICo+D/S3R4PBI4=;
        b=G3FtfebYwFbuog5iXivUQ61G4ZOlpCRwTGQJbG8p7Op3yRfieh7Csn5gpHNJ8nNw2e
         OAVyuIeQ1ddoC7cGyxbviPgL87LtvxPN5+ZiLDyflV8mlYtxeT0kVZj0P9vIvN2Nvp3X
         SWO4XRRbZ/BGWbETa3Z5FC5cGPPBxMVv+Q0RviL7RnJCHVBg+g+WrZBQhc41COjgPcbp
         6bfiDj1C7SwbuQR9KYIuoaeL7s7rBdYliBbCDPc1lFcuasjxPKGIje5/rTQVCegRmVIV
         dRBzYkMPmbocw3xCLfkn35kqCWCwJzy8M6b1kEOvtqS0mUge4LVryBxbIA/xoo0gQI98
         1yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnSb4cWLjt1pnom/8Wk4obyvClEVJICo+D/S3R4PBI4=;
        b=Xrf/TojMIyP/bvJuIVGGdca8rIrjK8/v09HftNVKZMLQLUVgpQ2NsMI7rqQYkC5qMM
         mDT/HwEFfMnpF6bbmlxp1F+MQdsHz/UNEnkaTywOAN91nXoma9XdzYDP3qeEdSRKP/q3
         dxmtVwTFy7Q9gp0/qRvxKh9W/cFWaMucAAT72rfgFi//oAnjruUbU9kixxlM8bp9L4ZR
         1j3636xd6mP2pCGFTKm2aHBmt8DKPekYKU1zkAH+GCgSLqw1N935H+PVH491wmae5kGx
         BC4jZdZoZdlSPoA/nuzMVK1fTgQ5iDeXvZGJnFWH0FKVkF0RkJ43TuttByH6mGz9syUh
         4BBw==
X-Gm-Message-State: AJIora85uFNBJruD52cpJgBHwDP/tmpdsyeyYLWvx5KM4uMkUY/EQFa1
        wdHOs0yFCgoPm68z3TnLAiM=
X-Google-Smtp-Source: AGRyM1t/ChPmaw/+zDHud+lvcfgi6W8mcKEtpJXF/7FFipoDl0OeyHnCUKiNZxmT/Dg363MAwymUsw==
X-Received: by 2002:a17:907:60c7:b0:72e:d01f:b884 with SMTP id hv7-20020a17090760c700b0072ed01fb884mr19613051ejc.550.1658096427670;
        Sun, 17 Jul 2022 15:20:27 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0070b7875aa6asm4715913ejh.166.2022.07.17.15.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 15:20:27 -0700 (PDT)
Date:   Mon, 18 Jul 2022 00:20:25 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: vt6655: Replace MACvReceive1 with function
 vt6655_mac_dma_ctl
Message-ID: <c433e54f0fae051fc8ba9050aa094d6f7141e8d4.1658094708.git.philipp.g.hortmann@gmail.com>
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c |  4 ++--
 drivers/staging/vt6655/mac.h         | 10 ----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 31e0e55b9220..01ce1c90ab09 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -434,7 +434,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 	/* Turn On Rx DMA */
 	vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL0);
-	MACvReceive1(priv->port_offset);
+	vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL1);
 
 	/* start the adapter */
 	iowrite8(HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON, priv->port_offset + MAC_REG_HOSTCR);
@@ -1149,7 +1149,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 		isr = ioread32(priv->port_offset + MAC_REG_ISR);
 
 		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL0);
-		MACvReceive1(priv->port_offset);
+		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL1);
 
 		if (max_count > priv->opts.int_works)
 			break;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 5747de436911..129a6602f6f0 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,16 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvReceive1(iobase)						\
-do {									\
-	unsigned long reg_value;					\
-	reg_value = ioread32(iobase + MAC_REG_RXDMACTL1);		\
-	if (reg_value & DMACTL_RUN)					\
-		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
-	else								\
-		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
-} while (0)
-
 #define MACvTransmit0(iobase)						\
 do {									\
 	unsigned long reg_value;					\
-- 
2.37.1


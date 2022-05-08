Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230C851F11C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiEHU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiEHU3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 16:29:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F5D9FF6;
        Sun,  8 May 2022 13:25:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so23300457ejb.6;
        Sun, 08 May 2022 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NOFbdT3mNIgyFAIKrwcDEJuF9jKNTCP//3ahUJPp78=;
        b=WyO4/C36wM9968QwGY5RgZRzNbhVS3krMRQtFcvJbMqaTv1uvtZPVg7kLKhY0S43NZ
         EL9r7mOUAQFaa9GdsUJVahcIt59a50I4K+V+8KSgk/W9Fhrf+WjkHJ03SAHQLMYvpzjw
         eUfO/jE3oYC0uzLfBeVB2cj3TAyAGiOsClPEBlkOgVZwWJiR8em5NnLJxpFHzO/KJ/I2
         qwg1Y9ECSYOFf7bZuKTkN86diialKoZTMQMTHyWA7wb2p1YTv4MXFh77nOYXJD5ZtaD9
         yIcBdwzAkUS2d/eAeVaS1yx4+L/2lKPpf1bTxb8YWqaBOLUrLPmm0Zn8RrD4T42uMJGd
         uiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NOFbdT3mNIgyFAIKrwcDEJuF9jKNTCP//3ahUJPp78=;
        b=2l+2qJEGYdfNle00EoBZ/npuN/y7nA9h9utQnLfmvQc61PDyCWUJmFsAVYYjDUOAqu
         amfzFYsdWYU22lsmT0c8nx1TWhOy7ulXiJnDds+e+j6Xm0y6Ui6ePMkmG2t1NrVtAe52
         fKoGVRUFNFZmZWoJpSxqodyvi0zCbHrN8OAuDtqhqVS65H3pmtNdIk2CUiWGGlg2Idxy
         k5EWiOvXP/KkgWNyNlrxCGlfoId6PA6/Ob5MxttXOscXnYgW22K9AvlpCkO3hFY2Ju1B
         kXgn4L9wCIAZ4/PDFZek3dUK62PccdvDwJ/O/9ActNADRowY0wDMr2EWLdwGxotLdNe6
         ctVA==
X-Gm-Message-State: AOAM532WHORlwsH9CKd9MW1tsLJUW2BTL+3VED0L2QFS7WsIl33vTxDv
        vlBSMOt4PA26RQ7CXgijplQPZjzhybgqPg==
X-Google-Smtp-Source: ABdhPJysbxv09e76DYl7jtFHVmOuBwQvAMBUFtHcjvEtdkVaMifCLWkVHXJPBMHiZu6T+34pBfv+TQ==
X-Received: by 2002:a17:906:c102:b0:6f8:d325:bb82 with SMTP id do2-20020a170906c10200b006f8d325bb82mr5638687ejc.197.1652041548125;
        Sun, 08 May 2022 13:25:48 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id eo10-20020a1709069b0a00b006f3ef214e1esm4341459ejc.132.2022.05.08.13.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 13:25:47 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 0/3] Enable JPEG Encoder on RK3566/RK3568
Date:   Sun,  8 May 2022 22:25:41 +0200
Message-Id: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following series adds support for and enables one of the hardware
video encoders on the RK3566 and RK3568 line of SoCs by Rockchip,
initially just for the JPEG format in line with what the kernel supports.

The encoder block is separate from the Hantro decoder instance, as they
are in different power domains and have wildly different memory addresses
as well.

The encoder hardware seemingly also supports VP8 and H.264 in addition
to just JPEG, as is evident from both the downstream vendor stack and the
register listing in the TRM. The hantro driver in Linux, however, does
not yet support encoding these formats.

The first patch modifies the bindings with a new compatible, and adds
the ability to just have a vepu interrupt without a vdpu interrupt.

The second patch makes the actual driver changes to support this variant.

The third and final patch makes the necessary device tree changes for
the rk356x device tree file to add both the node for the encoder and
its MMU.

The series has been tested on a PINE64 Quartz64 Model A with an RK3566
SoC using GStreamer.

Below you'll also find an interdiff against V1, which falsely assumed
this encoder instance only did JPEG.

Regards,
Nicolas Frattaroli

Changes in v2:
 - rename compatible as it's not JPEG only
 - rename device tree nodes as it's not JPEG only
 - reword commits as it's not JPEG only
 - get rid of a whole bunch of redundant struct definitions, as, you
   guessed it, it's not JPEG only

Nicolas Frattaroli (3):
  dt-bindings: media: rockchip-vpu: Add RK3568 VEPU compatible
  media: hantro: Add support for RK356x encoder
  arm64: dts: rockchip: Add Hantro encoder node to rk356x

 .../bindings/media/rockchip-vpu.yaml          |  2 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 21 ++++++++++++++++
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 .../staging/media/hantro/rockchip_vpu_hw.c    | 25 +++++++++++++++++++
 5 files changed, 50 insertions(+)

Interdiff against v1:
diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index cd62b44c34c3..4045f107ca4e 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -22,7 +22,7 @@ properties:
           - rockchip,rk3288-vpu
           - rockchip,rk3328-vpu
           - rockchip,rk3399-vpu
-          - rockchip,rk3568-jpeg-vepu
+          - rockchip,rk3568-vepu
           - rockchip,px30-vpu
       - items:
           - const: rockchip,rk3188-vpu
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 276b76d5f3fb..2e3c9e1887e3 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -508,18 +508,18 @@ gpu: gpu@fde60000 {
 		status = "disabled";
 	};
 
-	vepu_jpeg: video-codec@fdee0000 {
-		compatible = "rockchip,rk3568-jpeg-vepu";
+	vepu: video-codec@fdee0000 {
+		compatible = "rockchip,rk3568-vepu";
 		reg = <0x0 0xfdee0000 0x0 0x800>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vepu";
 		clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
 		clock-names = "aclk", "hclk";
-		iommus = <&vepu_jpeg_mmu>;
+		iommus = <&vepu_mmu>;
 		power-domains = <&power RK3568_PD_RGA>;
 	};
 
-	vepu_jpeg_mmu: iommu@fdee0800 {
+	vepu_mmu: iommu@fdee0800 {
 		compatible = "rockchip,rk3568-iommu";
 		reg = <0x0 0xfdee0800 0x0 0x40>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 3add9babd7bb..0b38b41136e2 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -628,7 +628,7 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
 	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
-	{ .compatible = "rockchip,rk3568-jpeg-vepu", .data = &rk3568_jpeg_vepu_variant, },
+	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
 	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index dd7f1edfacf2..b312da654d38 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -300,7 +300,7 @@ extern const struct hantro_variant rk3066_vpu_variant;
 extern const struct hantro_variant rk3288_vpu_variant;
 extern const struct hantro_variant rk3328_vpu_variant;
 extern const struct hantro_variant rk3399_vpu_variant;
-extern const struct hantro_variant rk3568_jpeg_vepu_variant;
+extern const struct hantro_variant rk3568_vepu_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
 extern const struct hantro_variant sunxi_vpu_variant;
 
diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/staging/media/hantro/rockchip_vpu_hw.c
index 10d3ea92a954..a97a4ea8ede4 100644
--- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
+++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
@@ -204,43 +204,6 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts[] = {
 	},
 };
 
-static const struct hantro_fmt rk3568_jpeg_vepu_enc_fmts[] = {
-	{
-		.fourcc = V4L2_PIX_FMT_YUV420M,
-		.codec_mode = HANTRO_MODE_NONE,
-		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420P,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_NV12M,
-		.codec_mode = HANTRO_MODE_NONE,
-		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420SP,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_YUYV,
-		.codec_mode = HANTRO_MODE_NONE,
-		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUYV422,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_UYVY,
-		.codec_mode = HANTRO_MODE_NONE,
-		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_UYVY422,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_JPEG,
-		.codec_mode = HANTRO_MODE_JPEG_ENC,
-		.max_depth = 2,
-		.header_size = JPEG_HEADER_SIZE,
-		.frmsize = {
-			.min_width = 96,
-			.max_width = 8192,
-			.step_width = MB_DIM,
-			.min_height = 32,
-			.max_height = 8192,
-			.step_height = MB_DIM,
-		},
-	},
-};
-
 static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
 {
 	struct hantro_dev *vpu = dev_id;
@@ -484,7 +447,7 @@ static const struct hantro_irq rockchip_vpu2_irqs[] = {
 	{ "vdpu", rockchip_vpu2_vdpu_irq },
 };
 
-static const struct hantro_irq rk3568_jpeg_vepu_irqs[] = {
+static const struct hantro_irq rk3568_vepu_irqs[] = {
 	{ "vepu", rockchip_vpu2_vepu_irq },
 };
 
@@ -594,14 +557,14 @@ const struct hantro_variant rk3399_vpu_variant = {
 	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
 };
 
-const struct hantro_variant rk3568_jpeg_vepu_variant = {
+const struct hantro_variant rk3568_vepu_variant = {
 	.enc_offset = 0x0,
-	.enc_fmts = rk3568_jpeg_vepu_enc_fmts,
-	.num_enc_fmts = ARRAY_SIZE(rk3568_jpeg_vepu_enc_fmts),
+	.enc_fmts = rockchip_vpu_enc_fmts,
+	.num_enc_fmts = ARRAY_SIZE(rockchip_vpu_enc_fmts),
 	.codec = HANTRO_JPEG_ENCODER,
 	.codec_ops = rk3568_jpeg_enc_codec_ops,
-	.irqs = rk3568_jpeg_vepu_irqs,
-	.num_irqs = ARRAY_SIZE(rk3568_jpeg_vepu_irqs),
+	.irqs = rk3568_vepu_irqs,
+	.num_irqs = ARRAY_SIZE(rk3568_vepu_irqs),
 	.init = rockchip_vpu_hw_init,
 	.clk_names = rockchip_vpu_clk_names,
 	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
-- 
2.36.0


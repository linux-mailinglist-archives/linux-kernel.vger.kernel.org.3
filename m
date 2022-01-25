Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0E49BA12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587514AbiAYRSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351917AbiAYRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:50 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3436FC0617A4;
        Tue, 25 Jan 2022 09:12:49 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d188so10163085iof.7;
        Tue, 25 Jan 2022 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XdxEZ7YOE8VCe+Ly6ca0cU/orZy3e2bgmci5GFke7S4=;
        b=Nf/57L7y2j6kymmxNnIEbBlYSt3knUksoS+BuxMQ/gMtOGsDWiNXTF+NovrOH6T9R0
         5nxuHmzxDb1qNm0qbxAKkfFWqK9ClBgIPADGPG96ccn2T+NVvKEFsG5Kjt80egTfm89X
         xO1BlhMa9ziZ7eL6OmnRHjZKwzMHa8IednpTfriJ4PBuuFGOuISgxhHbYoSayQtJ3oIG
         jwA+oF1Jtzrs4XRG0CTdNqgBS3QZL0qEN5Sbq1H5281AaDOlIBfMeNtqdmj2rkbeyFVt
         hveJXHXr8iiBAeMSdH6ghTdWccf1xw6+ohFe831H2J14+HM50hsovnVwio6S7fMR+4qb
         YYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XdxEZ7YOE8VCe+Ly6ca0cU/orZy3e2bgmci5GFke7S4=;
        b=ev1JsF8bG0PdysEohIqgtifNFAhIvOvKC9akKmshO7Ud8VRsf5lABBoe2DaUOCxJWR
         J3TdPbRSxzvu4oHuzH0aCIPv/2/uFLKghrHvKum4ZUx4uWXJc6GcyjcK3jDM53cWAaCH
         Q3ylM2/AHdcaRxCwAUIt+KX8+Abb+hdbNkD8rahD48eilVzNTfiHK4FHd5zHmiJjA46C
         +5EBuHkimfLvEdF0XrrWg/E0QyGPup1+q1kq62U9ZSac3/H0sQTvbQY/GBidwOF3zfC6
         d25BN+QLfc3iGDvSl7K/FM2efUZ7WUj1I5VvgJ3Fud+SpZsFNfqc140rK7Mhp9p5hysE
         KBOQ==
X-Gm-Message-State: AOAM530wYGINVVQqEBGUrnKbsLLBppWCdU9ltUXsN/n/p1u4gnDGDAwf
        qoZ2Dd97g/SPFSGQwJao7J4mqQMjUDs=
X-Google-Smtp-Source: ABdhPJwZ3uFCY2UY3PIrcdmD6IkV07uqs3j1K+i9dUSqnDgifh7kXW2qt7LOwNYp7nowhjXrJwqaXQ==
X-Received: by 2002:a02:cb01:: with SMTP id j1mr3442600jap.194.1643130768156;
        Tue, 25 Jan 2022 09:12:48 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V4 10/11] media: hantro: Add support for i.MX8MM Hantro-G1
Date:   Tue, 25 Jan 2022 11:11:27 -0600
Message-Id: <20220125171129.472775-11-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MM has a Hantro G1 video decoder similar to the
imx8mq but lacks the post-processor present in the imx8mq.
Add support in the driver for it with the post-processing
removed.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index f56e8b3efada..8f020ba15194 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -615,6 +615,7 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
+	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
 	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
 	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant },
 	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index f0bd2ffe290b..c00b46e06055 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -299,6 +299,7 @@ enum hantro_enc_fmt {
 	ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
 };
 
+extern const struct hantro_variant imx8mm_vpu_g1_variant;
 extern const struct hantro_variant imx8mq_vpu_g1_variant;
 extern const struct hantro_variant imx8mq_vpu_g2_variant;
 extern const struct hantro_variant imx8mq_vpu_variant;
diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
index 849ea7122d47..9802508bade2 100644
--- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
+++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
@@ -327,3 +327,15 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
 	.clk_names = imx8mq_g2_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
 };
+
+const struct hantro_variant imx8mm_vpu_g1_variant = {
+	.dec_fmts = imx8m_vpu_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
+	.codec = HANTRO_MPEG2_DECODER | HANTRO_VP8_DECODER |
+		 HANTRO_H264_DECODER,
+	.codec_ops = imx8mq_vpu_g1_codec_ops,
+	.irqs = imx8mq_irqs,
+	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
+	.clk_names = imx8mq_g1_clk_names,
+	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
+};
-- 
2.32.0


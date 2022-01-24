Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE77497760
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiAXCcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbiAXCby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:54 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD8C061401;
        Sun, 23 Jan 2022 18:31:54 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n17so1908489iod.4;
        Sun, 23 Jan 2022 18:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=py21+nfXCxvH9ed7Sw22S2QRAUR7jaIm1Q/EYwP+WYo=;
        b=da5jAzAfPPfk7mp4wncKvvJCkduKpIsOZSGZ4OC4dqDZ/6Md4hsvMmGsFAXJBLgQLJ
         P5mPJjhdeaaoS7l/uzxg0e/NbeInrpL4Ikdy7c19AhUAZBVGHP2oKNz5K5MzKyuxsJxl
         2ivf5v7yHpBAw75VUsuSnqcH16Djq+vyvLo9jmPMpgoXYoLfkBZFv2iO7tuyvD19k3b1
         s7qmOLY1siN8qT/ycFjkm65zbIq0f2/IQm1sZP8w1pAI9WHUvk/bwae694GpdWMZObv8
         psFvVslJeDiGo9C30C+SE+i/cLLG6mFsrIw++B1UVOLdnA9Yhv5hoX1sv2yZDMzbRGn7
         W/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=py21+nfXCxvH9ed7Sw22S2QRAUR7jaIm1Q/EYwP+WYo=;
        b=couxggUQBESYh359pmuJmwoNRPDpw86IbNQ8iiDMXqhoaoXJYkjTyapwOlWGHhGnqp
         jnwVdKvd/1Q+nsFEPSiKsA+FdLd9nmZ7Pe71H0Quw4O5OFNKHUrwD60skxNMqib6jQpD
         5T6kDbvMMo0IvK32V9thaMf6DJ3JJ1zdIw7Wg+JXGUyZ7bzO4SMymud8E5qOjAywVNM2
         kYReW2nwSQNJDUZp05wl8h0iSK2hb/uM+czBBELoIV3SkFPocbDHmerGjQJNwOfhd6eU
         /bsar+qfXBTjagqJTzeGyQaub8nLmUScZWBw3dnEGbnuPQeEr6RtS3pSNOcVDR4O8BfP
         XmTQ==
X-Gm-Message-State: AOAM530YphnWJ/FVsCgIT/mTVqKBo4pOcZaWHXWgdIPL4dC/PfdhUS1A
        QJLRcChvzQNa769ouFJcC8ZMAyCy9Jg=
X-Google-Smtp-Source: ABdhPJwUjw8XT5/iEV0iZ2cPeS0gZ9iHkopEETPmY56ydUqeJ6JKeUC8o3B9CTZsNY/bhPBfUXxbHg==
X-Received: by 2002:a02:29cc:: with SMTP id p195mr5841271jap.134.1642991513028;
        Sun, 23 Jan 2022 18:31:53 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:52 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 09/10] media: hantro: Add support for i.MX8MM Hantro-G1
Date:   Sun, 23 Jan 2022 20:31:23 -0600
Message-Id: <20220124023125.414794-10-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
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

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index a670ddd29c4c..b281ac4fb79c 100644
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


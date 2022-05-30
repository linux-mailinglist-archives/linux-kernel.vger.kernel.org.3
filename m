Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF0538820
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbiE3UP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbiE3UPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:15:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B73E68F8A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h5so7932095wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dM1Miawze8sKsOoDP6eNmyD3lGqsAxM4OZW/CsiBCqQ=;
        b=DV2NtNINZimMJqxbhbxmkjmSZbFIXt24MmqWcuL8/ZvoThgLXtp65oYm46Qeakffzp
         8YiwMlunn2bwit89barcdfiiBdM1VgK6D127PSqRqZPGniRfU8r4b2fPz4sDdo5G9y77
         Kl3OQVuwTNBNkTr5qh/edlV6c4xN3cHk3LXZAqoB6py0WCQHzq5ovmoWOWF31g7x2Ntx
         r2DOWTOIsoO7MxsUbK5Bpu2HFOYlbuAdMIx7iyTj/RHJpvNIEwW+E6NxPl/2nCVgsBQC
         2OjX2o7X8EMlkC0ZIOh+kdfCyv+s2p1+KbPalUDTcj0g2XgHloTLysG/DR4T1qKo37IF
         REog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dM1Miawze8sKsOoDP6eNmyD3lGqsAxM4OZW/CsiBCqQ=;
        b=PXCLTNSOZlu3DIL4py/8Gf0j98m9nqevn+iMdiNvr1XuArsCCd7plKat65c8dqnw1O
         Wz60T4S8kun0nx5SEeEk6u4nGZluhZj4Yrr94XyFiC3c91IEj1WmS35wKRFMQw2kigFC
         DQa7mSyUqKj7TaiBy/eE8/QF9ZTSnot9z9vCSXPFjYU/mUsEKOIyunZlMlSZujaP2JXR
         t1r0tgCk/PxqeaqLXTvRrBA5BTZ4U19HEFi27D0mVYwn97xzpN8w21ikI7TSLJAUm75w
         niM3+9hP08QKpp7x1j+ZrGTok7LiErkzetboiXcZlICaNL/MFEH6yIbuJTVCOnKam+ja
         ZgrA==
X-Gm-Message-State: AOAM5320VvJNKiw+3qIJubhTr75XPGM8xCHHRP01hO3LiLX1C/TsCtm5
        3Ht6Z/L42i4y13pGqwasG87ahw==
X-Google-Smtp-Source: ABdhPJwSSjliAbJddGUfeFIGpLGf9IXHfVrDvhvqnHzFPZT6n2sJsLeNwQeWBnxlnJ7JxvHZVTrllw==
X-Received: by 2002:a5d:6051:0:b0:20d:d49:26b8 with SMTP id j17-20020a5d6051000000b0020d0d4926b8mr45843588wrt.454.1653941705665;
        Mon, 30 May 2022 13:15:05 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe101000000b0020d110bc39esm9770401wrz.64.2022.05.30.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:15:04 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 5/7] soc: mediatek: mt8365-mmsys: add DPI/HDMI display path
Date:   Mon, 30 May 2022 22:14:34 +0200
Message-Id: <20220530201436.902505-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530201436.902505-1-fparent@baylibre.com>
References: <20220530201436.902505-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now only the DSI path connections are described in the mt8365
mmsys driver. The external path will be DPI/HDMI. This commit adds
the connections for DPI/HDMI.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mt8365-mmsys.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/mediatek/mt8365-mmsys.h b/drivers/soc/mediatek/mt8365-mmsys.h
index 24129a6c25f8..7abaf048d91e 100644
--- a/drivers/soc/mediatek/mt8365-mmsys.h
+++ b/drivers/soc/mediatek/mt8365-mmsys.h
@@ -10,6 +10,9 @@
 #define MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN	0xf60
 #define MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0xf64
 #define MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0xf68
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA1_SOUT_SEL	0xfd0
+#define MT8365_DISP_REG_CONFIG_DISP_DPI0_SEL_IN		0xfd8
+#define MT8365_DISP_REG_CONFIG_DISP_LVDS_SYS_CFG_00	0xfdc
 
 #define MT8365_RDMA0_SOUT_COLOR0			0x1
 #define MT8365_DITHER_MOUT_EN_DSI0			0x1
@@ -18,6 +21,10 @@
 #define MT8365_RDMA0_RSZ0_SEL_IN_RDMA0			0x0
 #define MT8365_DISP_COLOR_SEL_IN_COLOR0			0x0
 #define MT8365_OVL0_MOUT_PATH0_SEL			BIT(0)
+#define MT8365_RDMA1_SOUT_DPI0				0x1
+#define MT8365_DPI0_SEL_IN_RDMA1			0x0
+#define MT8365_LVDS_SYS_CFG_00_SEL_LVDS_PXL_CLK		0x1
+#define MT8365_DPI0_SEL_IN_RDMA1			0x0
 
 static const struct mtk_mmsys_routes mt8365_mmsys_routing_table[] = {
 	{
@@ -55,6 +62,21 @@ static const struct mtk_mmsys_routes mt8365_mmsys_routing_table[] = {
 		MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN,
 		MT8365_RDMA0_RSZ0_SEL_IN_RDMA0, MT8365_RDMA0_RSZ0_SEL_IN_RDMA0
 	},
+	{
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		MT8365_DISP_REG_CONFIG_DISP_LVDS_SYS_CFG_00,
+		MT8365_LVDS_SYS_CFG_00_SEL_LVDS_PXL_CLK, MT8365_LVDS_SYS_CFG_00_SEL_LVDS_PXL_CLK
+	},
+	{
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		MT8365_DISP_REG_CONFIG_DISP_DPI0_SEL_IN,
+		MT8365_DPI0_SEL_IN_RDMA1, MT8365_DPI0_SEL_IN_RDMA1
+	},
+	{
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		MT8365_DISP_REG_CONFIG_DISP_RDMA1_SOUT_SEL,
+		MT8365_RDMA1_SOUT_DPI0, MT8365_RDMA1_SOUT_DPI0
+	},
 };
 
 #endif /* __SOC_MEDIATEK_MT8365_MMSYS_H */
-- 
2.36.1


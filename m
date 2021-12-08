Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4D46DEB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhLHWyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbhLHWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:54:36 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B1C0698C5;
        Wed,  8 Dec 2021 14:51:03 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y16so4573979ioc.8;
        Wed, 08 Dec 2021 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmYKrk6BY+JkB/hlDlt3q1jLnYSH9OFSxGsl7p/faDY=;
        b=g/I4+F+JXnzH/TubCYTX76MFnsz+ZsY2EqNzT1DTl+068Y3W5T5xKg5k8zT5az8lhy
         Kl1+ZyGfSPXGYsIOqQf8C5JdzbjscEZwDhs8hqY9OjcS/hOlW/nPj7nY5BWE9qkGxifi
         jP0lvHHCW2w5WiW1wrw0hyssDH+Gie8/xln4hA3Gj7ZTNT2JHu7kql7ZzG8+d4PGDuob
         DKtBRa/yi7ScSqeUjOrx5AHvZy3Lnh8l7Odt1XqODPb+bsaHbBQeR+7VD+DiTph7ShWq
         VURawxVCm84z8SQ8h74V/wL5wJQsXSfDgCy+YUjjaK/gt8Yfc8nzNjoGF+GXxxStrKde
         F3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmYKrk6BY+JkB/hlDlt3q1jLnYSH9OFSxGsl7p/faDY=;
        b=YA4TPmh+e++pM49MZR2tNTF/xe55DeyKyHgiZaEo/HsDu7rr3dWS6AEvCIBsz1jVXB
         x+5b9BLCiBjE35JROPy5cVUXy4aJGolfKyfKggSq8Fs/CJkj8TV2iSEMJqRpnxW5N1x+
         ve29+w28SXwjeWb7RsQJRX8ZvActDRkDgpf9HyaFwG1m0rc+P0FFrIC/9U02+XJsN3NY
         rvX8PVAi5qOAv0977ByGBAXT1ZoT5A9ey7j9VwPnj+GT+N1OjHI0El+zcyF63c/8djTZ
         nquDxh3IEFuRyPbE0uPQnGzXZA6l6n6Lyi1SGPsIG8pDIBu1nLisvMgbu52zxcPJDwd1
         8DYg==
X-Gm-Message-State: AOAM531Ec0Px2TTZCxlp0fvgpUsTXal41aQYi1gCfAnJKy0GoNBfM6cM
        +I2iep97c7k7PWBSe4jtrC1wd5JeOAmATg==
X-Google-Smtp-Source: ABdhPJxiaJAYaeU0Z9vSpYSyUwXqVRBqeiOQq85i/0XyqKBA/pEz+No5RNx2VUK0NfXDTsaq0yOICA==
X-Received: by 2002:a05:6602:3c2:: with SMTP id g2mr11081040iov.65.1639003862036;
        Wed, 08 Dec 2021 14:51:02 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:269a:1aa2:f1d9:8dbb])
        by smtp.gmail.com with ESMTPSA id t6sm2378751ioi.51.2021.12.08.14.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:51:01 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        aford@beaconembedded.com, nicolas@ndufresne.ca,
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
Subject: [PATCH 10/10] arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders
Date:   Wed,  8 Dec 2021 16:50:29 -0600
Message-Id: <20211208225030.2018923-11-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208225030.2018923-1-aford173@gmail.com>
References: <20211208225030.2018923-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two decoders on the i.MX8M Mini controlled by the
vpu-blk-ctrl.  The G1 supports H264 and VP8 while the
G2 support HEVC and VP9.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index f13d31ebfcbd..4682f1f5238d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1196,6 +1196,28 @@ gpu_2d: gpu@38008000 {
 			power-domains = <&pgc_gpu>;
 		};
 
+		vpu_g1: video-codec@38300000 {
+			compatible = "nxp,imx8mm-vpu-g1";
+			reg = <0x38300000 0x10000>;
+			reg-names = "g1";
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g1";
+			clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>;
+			clock-names = "g1";
+			power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G1>;
+		};
+
+		vpu_g2: video-codec@38310000 {
+			compatible = "nxp,imx8mm-vpu-g2";
+			reg = <0x38310000 0x10000>;
+			reg-names = "g2";
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g2";
+			clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>;
+			clock-names = "g2";
+			power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G2>;
+		};
+
 		vpu_blk_ctrl: blk-ctrl@38330000 {
 			compatible = "fsl,imx8mm-vpu-blk-ctrl", "syscon";
 			reg = <0x38330000 0x100>;
@@ -1206,6 +1228,12 @@ vpu_blk_ctrl: blk-ctrl@38330000 {
 				 <&clk IMX8MM_CLK_VPU_G2_ROOT>,
 				 <&clk IMX8MM_CLK_VPU_H1_ROOT>;
 			clock-names = "g1", "g2", "h1";
+			assigned-clocks = <&clk IMX8MM_CLK_VPU_G1>,
+					  <&clk IMX8MM_CLK_VPU_G2>;
+			assigned-clock-parents = <&clk IMX8MM_VPU_PLL_OUT>,
+						 <&clk IMX8MM_VPU_PLL_OUT>;
+			assigned-clock-rates = <600000000>,
+					       <600000000>;
 			#power-domain-cells = <1>;
 		};
 
-- 
2.32.0


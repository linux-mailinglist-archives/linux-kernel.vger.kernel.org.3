Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929C3476FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbhLPLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhLPLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:35 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9248C061759;
        Thu, 16 Dec 2021 03:13:32 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 14so34525846ioe.2;
        Thu, 16 Dec 2021 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TbuArxHhnw2NqzqpC678dLXDest9qrzIVawU/F9j8Q=;
        b=c7c5AUqscKuwonxjAAu6GNkrIrX/IF7LrlWWVMPz5UemowmrXucK7FkuhZIGIRGzt1
         GQJPYBo5Qt6nhgS6gT6fBSiQtets2bXuqlFAnLAFN70TZNC+gG+EAHejVr5ce+i8ovXG
         Os6j1vre3Rl+jpAFdoVx3iUab3zIjVJtqnvU1iZ//JYFc3AMDyS+pfXirWE1ZY2SlUa6
         8x0Ba2EUvmM0M8ErtWryT8gSJYvP1Jk//AxnTONrq5haRQXGXy67tGDP2VWNfd1G3j7Y
         fp09JwuwLqYZ70VePxar96Mw6w66JsT6MdUkerjlUtdwfaxuWlR/qip4LRzHcjOpd7uK
         NwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TbuArxHhnw2NqzqpC678dLXDest9qrzIVawU/F9j8Q=;
        b=ZV6dhF5zfdQB5PSJjibaCzLPYQkaB7DyyAxsDf3/JnCbSktyaV9p4F9GfdZ79tNdv7
         WbLTo3EpwLqdZqo9tP8zertI4Ag275CnDvvWIKXMeRqlsMr7dK6SYhArcpL084uS4isa
         allgKBtAPZjoHQG0iTl/A/H3bmScAb24Hxrt1HxcBLMt62hb34pyCM0Zv0MCfYoz6SXa
         98YklrR8iwo5HZIgGAMiPpItdkIcViEFWRTxqffpZR9kw1Zo1Ma+6P0zVHoaCZrBbtU0
         /padX+/xe8spMW4mPGfNnTHYjUfAIW8EmRJtvLvBm/RldDpEV9721Bnc10yc1T5KJjJN
         wY2w==
X-Gm-Message-State: AOAM531zOnkAZGEOx7mnaLs3gLQqN9WeX2TtjPNRILc0ZpLCPNjiUMEz
        M2PGlbCb3Q1TTT29LkNSKb7R2Tdv2r1eye9W
X-Google-Smtp-Source: ABdhPJxedNBamHheqxed8H6owY3Y6xwLktxG1rqCkzncbtyaENC9+7PwVJWipBKw16ZRt4uLl+pOZA==
X-Received: by 2002:a6b:740b:: with SMTP id s11mr9121160iog.120.1639653211807;
        Thu, 16 Dec 2021 03:13:31 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:fe22:1652:55f7:5197])
        by smtp.gmail.com with ESMTPSA id h1sm3090946iow.31.2021.12.16.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:13:31 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        benjamin.gaignard@collabora.com, hverkuil-cisco@xs4all.nl,
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
Subject: [PATCH V2 07/10] arm64: dts: imx8mm: Fix VPU Hanging
Date:   Thu, 16 Dec 2021 05:12:52 -0600
Message-Id: <20211216111256.2362683-8-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216111256.2362683-1-aford173@gmail.com>
References: <20211216111256.2362683-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpumix power domain has a reset assigned to it, however
when used, it causes a system hang.  Testing has shown that
it does not appear to be needed anywhere.

Fixes: d39d4bb15310 ("arm64: dts: imx8mm: add GPC node")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..f13d31ebfcbd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -681,7 +681,6 @@ pgc_vpumix: power-domain@6 {
 						clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
 						assigned-clocks = <&clk IMX8MM_CLK_VPU_BUS>;
 						assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>;
-						resets = <&src IMX8MQ_RESET_VPU_RESET>;
 					};
 
 					pgc_vpu_g1: power-domain@7 {
-- 
2.32.0


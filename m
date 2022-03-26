Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A14E7EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 05:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiCZEZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 00:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCZEZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:25:33 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6235424CEC9;
        Fri, 25 Mar 2022 21:23:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b13so6283225pfv.0;
        Fri, 25 Mar 2022 21:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=no5zVlNN2+nYdfxfk03szGsm0djF7V5HA+HKzA4dT0k=;
        b=mi6tnMMcp/sODd4TZHeEDcdtKlKjpFiDoQvBfp2oFR3eE8TbuI6UQchXI7GyAzJ1gT
         MZp78KNwIelQo4fw9TP/qWe/NxZDAJEgf6PQc3PIRaWw9SvWfWL5gni7uBOax7oBpwzW
         tzDPiWD0qxmCFEQkIo7kEZEEvEXB69t7n2J+CKyZlJQ1bNSBLbOiqCm2SlKvcJ236Ds3
         ScM2rFDv+lYDMb2mcKofp1eAjdzmiG20TkMfIVcxD8jjAtPArjmV5/qn0miaO7O4xHC0
         ekN0dqnQrfe7t9BYOX3GkrzwP9IhgrKFv2sYnV/egb6QLh+R89EWgRfzQXwTFzHHPcKm
         HSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=no5zVlNN2+nYdfxfk03szGsm0djF7V5HA+HKzA4dT0k=;
        b=2spp3c0WFwemDtMx37prqzA1Nis1FV75+6jtJ3ql1ujrB9rlopsq43Jtj3kYRRSYrt
         o0MTEljNwc6xyOdY+3Xvy81MbfScf2LS17C3/8Y/JgQB0F7YiFRec14nQ0f4GdMOP8/g
         90EM6NoP0ESRs6oILjOwzuMEyZEN0pZ7XFxt+cvjSYCabPKn8hFWMpguafijdjxSoiio
         xALGk5jOuczNfMr4o3mWkHFMrnt9mUlQQJilFhZ44DLeJ0pWCYBUqsXMZAY7jeZMedmT
         qqBTk63h9Mg0fkT84UJeLzbU+n1ywGYA37ffvZKmhZlyX484mbgBhQqlWcm8fRn42MUP
         ZisA==
X-Gm-Message-State: AOAM531KEfyaxBkjldl/6vzEKmPV2hXZVvNWngimQUf2h+P/S8b+26lW
        gHcQbpByYxpKss3+vNFKyFY=
X-Google-Smtp-Source: ABdhPJwS8X8wIe3tqpoHerYo9sSMvdEjMD9ikw2WKJc60CtUqYOapfdW3W7jym3Am2N/VjgpKu1DeQ==
X-Received: by 2002:a05:6a00:10cb:b0:4f7:942:6a22 with SMTP id d11-20020a056a0010cb00b004f709426a22mr13581398pfu.84.1648268633767;
        Fri, 25 Mar 2022 21:23:53 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b001c75d6a4b18sm7457544pjb.14.2022.03.25.21.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 21:23:53 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Gong Qianyu <Qianyu.Gong@nxp.com>,
        Chenhui Zhao <chenhui.zhao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Mihai Bantea <mihai.bantea@nxp.com>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingkai Hu <Mingkai.Hu@nxp.com>,
        "Horia Geant?" <horia.geanta@nxp.com>
Subject: [PATCH 4/4] arm64: dts: ls1046a: Update i2c node dma properties
Date:   Sat, 26 Mar 2022 09:53:12 +0530
Message-Id: <20220326042313.97862-5-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220326042313.97862-1-singh.kuldeep87k@gmail.com>
References: <20220326042313.97862-1-singh.kuldeep87k@gmail.com>
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

Reorder dmas and dma-names properties for i2c controller node to make it
compliant with bindings.

Fixes: 8126d88162a5 ("arm64: dts: add QorIQ LS1046A SoC support")
CC: soc@kernel.org
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 687fea6d8afa..4e7bd04d9798 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -499,9 +499,9 @@ i2c0: i2c@2180000 {
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
-			dmas = <&edma0 1 39>,
-			       <&edma0 1 38>;
-			dma-names = "tx", "rx";
+			dmas = <&edma0 1 38>,
+			       <&edma0 1 39>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.25.1


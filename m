Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E254E7EE9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 05:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiCZEZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 00:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiCZEZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:25:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE43AA60;
        Fri, 25 Mar 2022 21:23:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso10358054pjb.5;
        Fri, 25 Mar 2022 21:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2x1QLeSL0TPizJtvpZQMqel8kUAcARC4zTfNPXgREyY=;
        b=dLjXtbRTA1rTY59+y2Oa7WR2SrevLu/VPySkTlUm6i3CXbv1+lNs6hGfkWYSECjsZw
         YNS+jFyrK92XkUTnp7H0tpZAjvGlNWWPpSYgovuqLBGOL6GW0Gx1O1mlXV1z6QxtQUWd
         56BkFPDvSfmIV/0RA+K/5WsGWF5cG8mooC5L31qjtqkljE7Jgm/W2qlzz/Hj3AEwYqj+
         BuCwubtN21l1WQeYL4LjJtR972LqmbCkj1y/ZzOCW9y1WQGxzfWFGHBfubiGrxvzjzF5
         GJ3+qun5h7vHBa3nCrpx1JJOqGMHYnc4Sm41WX+bk8JCLM23tY+9SjczHjcfTwE8EHYT
         CWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2x1QLeSL0TPizJtvpZQMqel8kUAcARC4zTfNPXgREyY=;
        b=C5OO88cY+8QiPdQt7DAH6WuXBgOagbSHfUdUFxOh61Ra4SEM3Yp38FjGcVi+YtVicb
         xt3GPy+55jgAmi2MoWqgmHwdDjRyoXMGyWtesgBNYdduTaEYfdE0hIZ2SydPtgN0C64T
         +QZRecDc2Tqud4lCx44TgE+Aa5FEnis5FlatpI63NYaqNl/WZ+4lE9Nsnc1MufUadNwi
         ZA5ahf6Fuho13DODkpe5Oipbtd+gNwY/UhHovLbFhdK+Db0bqXgiRdKGPiglC4MiCUA5
         MMba6vRVGL6/d5FmnLEQPVy+N/MVCH5AW+2Okngg10fHBOCuQbyVHV2pI3aWqTJcer98
         0ymQ==
X-Gm-Message-State: AOAM5313qA2O+6x3OduEgyksBiDkvrxOtVFMeVdPnm8lOSuNiOH3ObVp
        8lvUDhlhKZZC0HUx0KZeu1o=
X-Google-Smtp-Source: ABdhPJyq/uoDr9lMsytT1OHA2wXEQo0TBJx9ar/j4AfSBHvCl59R1vdwDpkXiL0w95H1bkF094nGuw==
X-Received: by 2002:a17:902:c713:b0:153:f75d:253b with SMTP id p19-20020a170902c71300b00153f75d253bmr15097410plp.99.1648268629122;
        Fri, 25 Mar 2022 21:23:49 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b001c75d6a4b18sm7457544pjb.14.2022.03.25.21.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 21:23:48 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mingkai Hu <Mingkai.Hu@freescale.com>,
        Hou Zhiqiang <B48286@freescale.com>,
        Wenbin Song <Wenbin.Song@freescale.com>,
        Olof Johansson <olof@lixom.net>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: ls1043a: Update i2c dma properties
Date:   Sat, 26 Mar 2022 09:53:11 +0530
Message-Id: <20220326042313.97862-4-singh.kuldeep87k@gmail.com>
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

Fixes: 6d453cd22357 ("arm64: dts: add Freescale LS1043a SoC support")
CC: soc@kernel.org
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 01b01e320411..35d1939e690b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -536,9 +536,9 @@ i2c0: i2c@2180000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
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


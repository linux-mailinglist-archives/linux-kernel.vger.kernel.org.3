Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512F4FE15C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351526AbiDLM44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355257AbiDLMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:53:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8419B;
        Tue, 12 Apr 2022 05:27:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m14so3086846wrb.6;
        Tue, 12 Apr 2022 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qRlr8ZfTQ3raGd+E44T5DsXd8r35uC0pnPSIlIhBAM=;
        b=EN/LEY3ulBnf+PHMFdD98Rpb6d4Ng3RGFht/2ksnjxcf45HDGl2Us7uVW5mwIunbol
         BjU3fWy9y64h030HvJYdfMtbhpxo8voIkrirbxh7IWkoa5G5IdoLp0piKCoCanlbaJpM
         PeIujo/ahlHkIZC/VNqWiuYJK3fEcb8DX4tmds3RvDe71SzR0MfzJepVF9LrztaDfQSK
         youJkZ4/6rx2JZfMkq5T3Nmc2KqBYWyp/PE4F7+qX0te4TyFgAvtkCxcmMwwCailzpe7
         XnwBue2uPr/RG95mUE8goezxT9eXN7OX/kPg9w6MlClQc/3VLwYvoEWCJ7TbDt9DiNT/
         9uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qRlr8ZfTQ3raGd+E44T5DsXd8r35uC0pnPSIlIhBAM=;
        b=S862U+xJ79OHRqIekyJsly8V3rSZI7C0NvxorCRqZbjBlmVppupR1aBUZv10e6BB36
         VX9IcPSQe5ecWlvzFVYzvIWdkfMTo8c4tQh/tuyfHgke4KCMuqJq/EC3QS8O2+Kpqyqa
         +1LpBZXtBtfnSnFEsBR2dbXLFo0rWHHnyrCfJyFCC2EqBtsJFc+UOCCLfi8bsDu/DpQ+
         zBHdXwLeguzBH8O/ueghiM3Lc1oi6x3SXivgSf1LOENOiyv4xtm+KOSkRzVSpiTah3t7
         gcR/BWz+yrjlZvgY6Q5d2yFXVw9UCkyYvFcpeFy4tt5fGCQ/Qa1aG/G0XpD3Nu4AwXQH
         yzPQ==
X-Gm-Message-State: AOAM533ja/hLDh1m5j95rvw1k8UrHgSl9PVpHjJjrfofDIbgy3vyTMqU
        giLQZoYb8sVZnmh+EU3pKpE=
X-Google-Smtp-Source: ABdhPJxw0wxEUimfooH4UNCLaWh+5ilUFFKFnVX8NNBhhnaso2YvVnJNDywodS+Qryt1hqmTJNPUeQ==
X-Received: by 2002:a5d:6910:0:b0:206:a03:35c with SMTP id t16-20020a5d6910000000b002060a03035cmr28034156wru.174.1649766440296;
        Tue, 12 Apr 2022 05:27:20 -0700 (PDT)
Received: from localhost (92.40.203.131.threembb.co.uk. [92.40.203.131])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b0038eb596ab10sm2296064wmq.2.2022.04.12.05.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:27:19 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH v5 1/2] mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node
Date:   Tue, 12 Apr 2022 13:27:49 +0100
Message-Id: <20220412122750.279058-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com>
References: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock is a gate for the TCU hardware block on these SoCs, but
it wasn't included in the device tree since the ingenic-tcu driver
erroneously did not request it.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..c69df8eb158e 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -111,8 +111,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1000_CLK_RTCLK>,
 			 <&cgu X1000_CLK_EXCLK>,
-			 <&cgu X1000_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1000_CLK_PCLK>,
+			 <&cgu X1000_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
index 2595df8671c7..4408df24ca98 100644
--- a/arch/mips/boot/dts/ingenic/x1830.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
@@ -104,8 +104,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1830_CLK_RTCLK>,
 			 <&cgu X1830_CLK_EXCLK>,
-			 <&cgu X1830_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1830_CLK_PCLK>,
+			 <&cgu X1830_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0155B076A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIGOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIGOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:46:38 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1BD8048A;
        Wed,  7 Sep 2022 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561997; x=1694097997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcbrCYTDMmAmjpK0PSlD7QA+1uZkZ5/KbbIAh3KJVI8=;
  b=inHvx/ePUXtQsrwbt9L4WyyY57FNzqdRsFo7ztz/Z5zQXfV8Nb9VGcS1
   qi4hHu7l+bR0+AE54eUHAN5OgVC2ZxSzRjaJNdgBgvr+Wj2DMzgbkkTWg
   7vQU04GZPzcllMVfNYUMHsSis4ZfIxhetJJg+G09WU1EkaR5gtcShSTbz
   1GHGlh1tbPtkmVgMP8CHd04C4UhnV/ALA3vNoSnb7JijVbCaPU5MBlmin
   MEnDzOKEtgPhAvvzaDv8Tuv75Po3LInE9CQJ+095n18r2j7q0H3XIwhrF
   5kujz9LfRC4utDD0e9yNQyrk0bOPTeAElZo+M+V/AMQjluR/MHKgbWqGY
   A==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047488"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2022 16:46:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Sep 2022 16:46:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Sep 2022 16:46:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561991; x=1694097991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcbrCYTDMmAmjpK0PSlD7QA+1uZkZ5/KbbIAh3KJVI8=;
  b=F7c+na8qmc4sqAIzRxUFrElUKEA4J6+yjfjzvjmDjJaE4u27z4i6ucvc
   8BlHTfdFrocoBcZHmBs4Braox+KyolLt3w0zYetK1SCydLagPLabd/xcL
   l/Mpzx3nRzCCKHtWL2J1587J7DvmMJyVE6ETwG/Y4iQ/CJH3eIlqmHT68
   jh2DODUPxU+rWdMzHTkFrZY7OYwcjKOt4VndXiOuUWQ82a6TvcnjLuBOM
   CtjnUxyiu8JA4GNuFf+cih26yeYdXh5ozGXvyoCJs3qP9j5XbiGRdnjNg
   YFdSDx9t3IrSgXhIYTlKMyXCFSy4OfR5L9XICVz53eM9Uf5n+kxxxNwq9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047487"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2022 16:46:31 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id EF8A3280072;
        Wed,  7 Sep 2022 16:46:30 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes
Date:   Wed,  7 Sep 2022 16:46:23 +0200
Message-Id: <20220907144624.2810117-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this set the SOF/ITP counter is based on ref_clk when 2.0 ports are
suspended.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 53493dc7d976..0e7f5842a3e4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1300,6 +1300,7 @@ usb_dwc3_0: usb@38100000 {
 				phys = <&usb3_phy0>, <&usb3_phy0>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,dis-u2-freeclk-exists-quirk;
+				snps,gfladj-refclk-lpm-sel-quirk;
 			};
 
 		};
@@ -1342,6 +1343,7 @@ usb_dwc3_1: usb@38200000 {
 				phys = <&usb3_phy1>, <&usb3_phy1>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,dis-u2-freeclk-exists-quirk;
+				snps,gfladj-refclk-lpm-sel-quirk;
 			};
 		};
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F6502EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbiDOTGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348089AbiDOTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:06:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B7DA09E;
        Fri, 15 Apr 2022 12:04:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FJ4CNZ058968;
        Fri, 15 Apr 2022 14:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650049452;
        bh=ijQrP5XfHZn4TmCcFge6Wg+R2+udXFBDZkxgCKeVqqs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JFA+eMVpZ5U+jiawxCIsgpzdNbNlnTBmup2XxVWHhGcpB9E4dwozBankXvv6xlOLu
         R8bPf9RAU0pG9+MEu3IKPYDufbCvd7e4CrnCvB846Syd/gxUj1nA1mlRYKAM016QHm
         ++O633dnZfLL3R38+uhq7rKAWnqO+RRa7v+8u04E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FJ4C3K041200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 14:04:12 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 14:04:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 14:04:11 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FJ3mfd067536;
        Fri, 15 Apr 2022 14:04:05 -0500
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     <ssantosh@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v2 2/2] clk: keystone: syscon-clk: Add support for AM62 epwm-tbclk
Date:   Fri, 15 Apr 2022 22:03:43 +0300
Message-ID: <20220415190343.6284-3-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415190343.6284-1-g-vlaev@ti.com>
References: <20220415190343.6284-1-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 has 3 instances of EPWM modules. Each EPWM module has
an EPWM TBCLKEN module input used to individually enable or
disable its EPWM time-base clock. The EPWM time-base clock
enable input comes from the CTRLMMR_EPWM_TB_CLKEN register
bits 0 to 2 in CTRL_MMR0 module (6.1.1.4.1.48 [1]). This
is virtually the same setup as in AM64 but with 3 instead
of 9 clock providers on AM62.

Update the driver with the 3 instances of clocks associated
to a new compatible: "ti,am62-epwm-tbclk".

[1] https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/clk/keystone/syscon-clk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index aae1a4076281..19198325b909 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -162,6 +162,13 @@ static const struct ti_syscon_gate_clk_data am64_clk_data[] = {
 	{ /* Sentinel */ },
 };
 
+static const struct ti_syscon_gate_clk_data am62_clk_data[] = {
+	TI_SYSCON_CLK_GATE("epwm_tbclk0", 0x0, 0),
+	TI_SYSCON_CLK_GATE("epwm_tbclk1", 0x0, 1),
+	TI_SYSCON_CLK_GATE("epwm_tbclk2", 0x0, 2),
+	{ /* Sentinel */ },
+};
+
 static const struct of_device_id ti_syscon_gate_clk_ids[] = {
 	{
 		.compatible = "ti,am654-ehrpwm-tbclk",
@@ -171,6 +178,10 @@ static const struct of_device_id ti_syscon_gate_clk_ids[] = {
 		.compatible = "ti,am64-epwm-tbclk",
 		.data = &am64_clk_data,
 	},
+	{
+		.compatible = "ti,am62-epwm-tbclk",
+		.data = &am62_clk_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_syscon_gate_clk_ids);
-- 
2.30.2


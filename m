Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C253B8C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiFBMGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiFBMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:06:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996A1243196;
        Thu,  2 Jun 2022 05:06:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 252C6R0i033794;
        Thu, 2 Jun 2022 07:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654171587;
        bh=ARdQkLElrFVvSEbZbrN4spf/dQGX9cYcMBiv5qGTtCI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nESowFcRH5xNvm/Q0UyQDoiJK4qvmb4p7Ux9IvYiQx+PRT0I/BjxhIdU5z83Fdbe6
         TAE1N6MwSl6MPQo9WmeB3ASyk7uJxQZhOhlrCQPSol6pnCsPi2EQlX2iog/yzngG0t
         NjJi7B2Au5FIwvA/6k5hm1VcIi4YTg63fuASbs60=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 252C6RAw099095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jun 2022 07:06:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Jun 2022 07:06:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Jun 2022 07:06:27 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 252C6EEp054710;
        Thu, 2 Jun 2022 07:06:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/3] soc: ti: pruss: Enable support for PRUSS-M subsystem on K3 AM62x SoCs
Date:   Thu, 2 Jun 2022 17:36:13 +0530
Message-ID: <20220602120613.2175-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220602120613.2175-1-kishon@ti.com>
References: <20220602120613.2175-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The K3 AM62x family of SoC has one PRUSS-M instance and it has two
Programmable Real-Time Units (PRU0 and PRU1). This does not support
Industrial Communications Subsystem features like Ethernet.

The existing pruss platform driver has been updated to support this
through a new AM62x specific compatible.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/soc/ti/pruss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 0e4ba0f89533..6882c86b3ce5 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -338,6 +338,7 @@ static const struct of_device_id pruss_of_match[] = {
 	{ .compatible = "ti,am654-icssg", .data = &am65x_j721e_pruss_data, },
 	{ .compatible = "ti,j721e-icssg", .data = &am65x_j721e_pruss_data, },
 	{ .compatible = "ti,am642-icssg", .data = &am65x_j721e_pruss_data, },
+	{ .compatible = "ti,am625-pruss", .data = &am65x_j721e_pruss_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pruss_of_match);
-- 
2.17.1


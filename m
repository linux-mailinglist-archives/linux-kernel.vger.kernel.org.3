Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA451125A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358786AbiD0Han (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358765AbiD0Haf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:30:35 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC34579B;
        Wed, 27 Apr 2022 00:27:25 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R7RLFf069288;
        Wed, 27 Apr 2022 02:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651044441;
        bh=NpGexD1UFG5t4/zbSWlZsOFh1ESxB6cMXNhFQ5GSDfI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JsAxZUM+fIeRdhWxJQDBE/+MOHBDrffTHDhnqdIqy67TQMviVwH95PmYB6jmy235P
         LK47+3KoLiOw7luHGFkOuIRaheVcfjq2gMAP9K1Nc6qb10PmoZ3JNkxQlXyhhFkmgM
         qsowkrsZU5UxXq5spfYTRo83QGAzUaSXuul3RNhQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R7RLge010727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 02:27:21 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 02:27:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 02:27:21 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R7RBgR088380;
        Wed, 27 Apr 2022 02:27:18 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] soc: ti: pruss: Enable support for PRUSS-M subsystem on K3 AM62x SoCs
Date:   Wed, 27 Apr 2022 12:57:03 +0530
Message-ID: <20220427072703.4898-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427072703.4898-1-kishon@ti.com>
References: <20220427072703.4898-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index b36779309e49..7c8111ca2b72 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -339,6 +339,7 @@ static const struct of_device_id pruss_of_match[] = {
 	{ .compatible = "ti,am654-icssg", .data = &am65x_j721e_pruss_data, },
 	{ .compatible = "ti,j721e-icssg", .data = &am65x_j721e_pruss_data, },
 	{ .compatible = "ti,am642-icssg", .data = &am65x_j721e_pruss_data, },
+	{ .compatible = "ti,am625-pruss", .data = &am65x_j721e_pruss_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pruss_of_match);
-- 
2.17.1


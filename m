Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2000151138B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359457AbiD0Iil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359430AbiD0Iif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:38:35 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8342641F97;
        Wed, 27 Apr 2022 01:35:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R8ZL58087677;
        Wed, 27 Apr 2022 03:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651048521;
        bh=TcQDl1uLZdWGzW+QJb1P8sNXIjyeW2FbcvT3/624XIc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GgEh65q1nIjXl5IwxCMkDtl3VqjIgQET0SDvkhpY7XpczUrKI+BK4Ep0uiHBFnvrv
         C3wvQMxRGKaTQQi9m+yJpa+dbyNeLQw9vmwJESCHiHEeco0N8cH7sVrMXP7cd/vdmi
         ayuhWZ2J/c4tDIXxM4L+Wv3lOYXDjeW4U2ZIQeK4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R8ZLtd103096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 03:35:21 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 03:35:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 03:35:21 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R8ZBCh009219;
        Wed, 27 Apr 2022 03:35:18 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Suman Anna <s-anna@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/2] remoteproc: pru: Add support for various PRU cores on K3 AM62x SoCs
Date:   Wed, 27 Apr 2022 14:05:09 +0530
Message-ID: <20220427083509.14458-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427083509.14458-1-kishon@ti.com>
References: <20220427083509.14458-1-kishon@ti.com>
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

Enhance the existing PRU remoteproc driver to support the PRU cores
by using specific compatibles. The initial names for the firmware
images for each PRU core are retrieved from DT nodes, and can be adjusted
through sysfs if required.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 1777a01fa84e..128bf9912f2c 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -897,6 +897,7 @@ static const struct of_device_id pru_rproc_match[] = {
 	{ .compatible = "ti,j721e-pru",		.data = &k3_pru_data },
 	{ .compatible = "ti,j721e-rtu",		.data = &k3_rtu_data },
 	{ .compatible = "ti,j721e-tx-pru",	.data = &k3_tx_pru_data },
+	{ .compatible = "ti,am625-pru",		.data = &k3_pru_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pru_rproc_match);
-- 
2.17.1


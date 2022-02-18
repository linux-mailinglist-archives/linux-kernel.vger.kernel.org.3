Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F44BB333
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiBRH3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:29:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiBRH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:29:09 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED825DA44;
        Thu, 17 Feb 2022 23:28:53 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21I7Snr0041259;
        Fri, 18 Feb 2022 01:28:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645169329;
        bh=ODXi2GRB6vVlNvxT0xvqYttksAAVTdslLMAf5LSA4S0=;
        h=From:To:CC:Subject:Date;
        b=LgocO4bXvHI/6NHM6rSH4fewkExxB87L+Z1J63C7GWNEMvUYVCHn65q3pyYa0OCTM
         UJvM5RKl3gDFS26pxS4YTxWzgFy+MNGCJII+QqpoZJwzpIooisI1wrKiwSMjvcURTk
         2UyoL3/nKg6jnEFZAjzWMkBIYGqxMo5l8wgE1Xds=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21I7SnEC056660
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Feb 2022 01:28:49 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 18
 Feb 2022 01:28:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 18 Feb 2022 01:28:48 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21I7SkjA022777;
        Fri, 18 Feb 2022 01:28:46 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: sdhci_am654: Add Support for TI's AM62 SoC
Date:   Fri, 18 Feb 2022 12:58:40 +0530
Message-ID: <20220218072840.5629-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the controller present on the AM62x SoC.

There are instances:
sdhci0: 8bit bus width, max 200 MBps
sdhci1: 4bit bus width, max 100 MBps
sdhci2: 4bit bus width, max 100 MBps

The PHY used for 8 bit instance is same as the PHY for the 4 bit instance.
Therefore, introduce a new bus width independent compatible for AM62 SoC
that uses the driver data required for 4 bit instance.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index b4891bb26648..e54fe24d47e7 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -745,6 +745,10 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 		.compatible = "ti,am64-sdhci-4bit",
 		.data = &sdhci_j721e_4bit_drvdata,
 	},
+	{
+		.compatible = "ti,am62-sdhci",
+		.data = &sdhci_j721e_4bit_drvdata,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_am654_of_match);
-- 
2.17.1


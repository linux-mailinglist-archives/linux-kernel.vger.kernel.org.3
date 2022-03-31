Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC04ED4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiCaHao convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiCaHai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:30:38 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4E377D6;
        Thu, 31 Mar 2022 00:28:50 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 02F36462580;
        Thu, 31 Mar 2022 09:28:48 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E8153462537;
        Thu, 31 Mar 2022 09:28:47 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Thu, 31 Mar 2022 09:28:47 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 09:28:47 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.022; Thu, 31 Mar 2022 09:28:47 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
Subject: [PATCH 1/2] mmc: mmc_spi: parse speed mode options
Thread-Topic: [PATCH 1/2] mmc: mmc_spi: parse speed mode options
Thread-Index: AQHYRNACkgNu3ZFsJkmPWUm4Hk64og==
Date:   Thu, 31 Mar 2022 07:28:47 +0000
Message-ID: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1000-26804.006
X-TMASE-Result: 10--0.036500-10.000000
X-TMASE-MatchedRID: Pcf9tAO75fCjw14NC3gXsBF4zyLyne+ATJDl9FKHbrkFDK6GZYQJfeWs
        WsO3yC+R3QLokIDIx5AEE2WBGwi7GEkjllSXrjtQEzQnFLEeMUljFT88f69nG/oLR4+zsDTtjoc
        zmuoPCq3Cm3CnLLVUv6sY7DmQqcN3sXAiAjufsEOba5xi6u49NCGz5f1YHY3o
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 0ba8af54-7a4e-45e3-ad95-daac4f8d37d4-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since SD and MMC Highspeed modes are also valid for SPI let's parse
them too.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/host/of_mmc_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 3629550528b6..bf54776fb26c 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -70,6 +70,10 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	} else {
 		oms->pdata.caps |= MMC_CAP_NEEDS_POLL;
 	}
+	if (device_property_read_bool(dev, "cap-sd-highspeed"))
+		oms->pdata.caps |= MMC_CAP_SD_HIGHSPEED;
+	if (device_property_read_bool(dev, "cap-mmc-highspeed"))
+		oms->pdata.caps |= MMC_CAP_MMC_HIGHSPEED;
 
 	dev->platform_data = &oms->pdata;
 	return dev->platform_data;
-- 
2.34.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111DF584E81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiG2KFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiG2KFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:05:41 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2108.outbound.protection.outlook.com [40.107.96.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360B31CB0E;
        Fri, 29 Jul 2022 03:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR3wRhWklOPH4MVD+o8vSzjRVPwuG+ZCk1S+fCK25gT0Ky4O/sgqgYWylvnTe2Yf+D9+kEoyvpKieHPTDjaqKvNQrAR15+8SdVP7AyQlsiSAsjZAdeeSZkd4qYYRXhg1l5UushMM4Mle4Tcvk9p3dtPxHgof+7I3QbtRT4IZOB5pMgVdTREsLqKfSycm3dLcBPnMWLtsL9xOg/b70EabY/XM7Z0p3LDtmtmjJqWSTmuoaWXk9SI4dcpCLg4OLcsU6RkSl49kS3ZMtJJiZPa4IIlArNSOtWaEl1a3QtpEcRR0nbJciQ0LkriI8na2bcRXI3ST710JlBaMMZvMEuk2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0689ZcXDzTIfMvz6Srdrqw3BVcmfoVEYBGlHJQpI5c=;
 b=f0HLO/MoLQgQwMhtoQu8slIsMtsmmMWzKKIxaamtB/e5UxX8eqbPpaAeYZnB9yYhGA1qyBj9URSSco8RfXBXINQnt9KOIfMMhNgazMCWefW0sJBtnF1WmyrcEc6hh2T7nARZIEeZDpcMnn5GcaU4sACKgxG5L2QIp9Vws0A3f9jQcUNScrDXu2my6bhyt38IVSwgutEfbjWLJqSwqpI9TMVeMjsN8C1x7ma9qHr6mXjGLoVEyh5gnL905OvsGdReHhggbcBgtdYzSQld3dyUq5nL6wCyH1aVkUntioxoamauk/dLZmgerGya7mEbvSDrJl5ZJJ07ugEEFAxfQRHnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0689ZcXDzTIfMvz6Srdrqw3BVcmfoVEYBGlHJQpI5c=;
 b=spErkd+ExX7raXj7pEfZhTVEHNN/EeD/W3cR3uzUOGyq/WHIqvTK6JWqghzIJy+vkOoijxnJpeONZLe3dAtjyQ6hrze2mM0kb6ANL82q+ayEtlnWkCPN2dhqdmOtBjll9peQM1T2LPMidxUv1iL0f0qcNM7tABzq1nEVQC9znOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by BL0PR16MB2196.namprd16.prod.outlook.com (2603:10b6:207:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 10:05:36 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::b0e8:64bc:dcd2:39c5]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::b0e8:64bc:dcd2:39c5%7]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 10:05:36 +0000
From:   Chevron Li <chevron.li@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com
Subject: [PATCH V2 1/1] mmc: sdhci-pci-o2micro: fix some SD cards compatibility issue at DDR50 mode
Date:   Fri, 29 Jul 2022 03:05:24 -0700
Message-Id: <20220729100524.387-1-chevron.li@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0153.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::12) To PH0PR16MB4248.namprd16.prod.outlook.com
 (2603:10b6:510:4c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 632964e2-f981-4666-a13d-08da7149e1c6
X-MS-TrafficTypeDiagnostic: BL0PR16MB2196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuu0nrRNBx8D4xHQchkQrymziCCbCtjsu9As1bLlvztXF+Ea9mjmKcqdTF7k5J9LbWDraEwY9jd6HrMpQ82wJA3s+UbHgl/Sc3atDCQBGl1zZqAGtOaBiKmb3Y1+SMae3+UjMJDpue9NNMYQl7JU6nZoYDZxhvaWNMXHzM4A3LE17eZ9UopMUMaEY7GDlYy8ylIinfvNIrXo9QLgWEeN3o8HHuhNwV3/cV15a2l/Ke/L9F69/TvY93vP0kOn2VCwxAaMek22JqeCDJOc+104ddla9G4vA+35pT98TMfKjc5D+4zFpP2pp8kiMds9ty3+X670Gxk4nHtdpcDh64xKMxd0tPmrLZ4qr2+DmcUIMe27IhLVdHGVKfS6I0CplktFSDaNXsKs3DpW+IPPCb10Hc5lETVsl+9gHnfnyjGZ0WC8xN8amm1JcIZw66+p+Q2YKrpOwcZ3jjgGpCZYNUHWSshUkH+JrdXHSfD4uCjVH7Kgl599i1EoswcG9Is175UPXbaqVQV4R77T607jFpMK0YjuFPhodf961nF7ClbsjanEy0LPWs3+9v5uxP7Bfx86Nx3l7ccFAJ+gEq1QYKXfSIQ5m9XO6yfoTmxws4O50gjJmipcWXKWdFnDsqtLmpjJ2yTj1IKMGuTiIZhV6xu8+mbzj2oMeQJ104AVv2g4sPBCplYDcYI+vRIZLEdxnJV4kpHWbaYnqdSPz87o6C7IGlJfVL5lCDKkWa0nGmxhy198gGDtLomNDVBAyCaWMwkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39830400003)(366004)(396003)(107886003)(1076003)(186003)(2616005)(316002)(36756003)(38100700002)(83380400001)(6512007)(8676002)(52116002)(66946007)(66476007)(86362001)(2906002)(8936002)(4326008)(6486002)(478600001)(44832011)(6666004)(66556008)(41300700001)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mgmq87LL++eszrdAKeQYqrBe1HAfEjHENn8mKBJZkFjudvdw7EQI9MnOrWhB?=
 =?us-ascii?Q?If35manfMRkTtyuLxrknbAwaYKiGABHw4DroO3s2ffo7q0LDzwSNplfWG6bB?=
 =?us-ascii?Q?GzH27E1Qj5Hu65KEFF68Oii1c118pBHEQhHUIGaAB1w6xotLx9akoUxlZXIl?=
 =?us-ascii?Q?9kZpjPvKcWO/PDaY9F+3NLx2HkHxGz0iYU5hUpQVI4pPJWPTBd5BV1ebeOcX?=
 =?us-ascii?Q?h/QVdyylRnB4bhlcC9iTL0p+ctCRi4yWYzUbfbLlxAHr0BanZ0l5EZmWduoU?=
 =?us-ascii?Q?sQL2f7MtM13Jl6tUnmtLWTT+NZYLRCMiZciR+7unWJoNsZ8xTTNwd07uOBOW?=
 =?us-ascii?Q?H756HV4bCjoLk/TelVPUSYAHuE6SWo5HSGaLFQmMR/3SHpNOKzC7ioZKdf3H?=
 =?us-ascii?Q?n1oo+O5Ao5tcxp/kouzJCTtzKbV9eBahEV8GPcQoWHEEx6e6UBLmtaUjtiSL?=
 =?us-ascii?Q?iZlpwscYNtSTuYvx1Edxeg/C8kLpJogLIBMBItpVwYL2OCwUctaPnyy2txh7?=
 =?us-ascii?Q?3p7xZVlscM33QiBIh8W+opZkXjTsJchbd0fJ9fir7pEHmQS5qNmtQAt/dmyC?=
 =?us-ascii?Q?PVz3qcWL2jaKIH4/XTfUIHw2SfaS4jPEAdKsAJEnO9qemTzPpfG7+pONkur3?=
 =?us-ascii?Q?cPwIMqfzPTeJNHHl3pmWnoJHX30YmQ/oHUqx+3LthpCIo5E6qKZ4rAbiifLF?=
 =?us-ascii?Q?y/aoaHz9K2nXFEcxe/EOJ2ixuKBM7n9U9epoRbpWRzcO0j5sGw+4DElMh6aC?=
 =?us-ascii?Q?zPzvYVmQ0aLp/2/BaxlH177+VHb7eRp/s3It/QMKIl9W1TMzDXMx2K63u9ug?=
 =?us-ascii?Q?SsJm+M/K5xjzbim+j8zXX0T460ZK4neo0bvmm1Xt8+FjPezXWAvtdu208oSs?=
 =?us-ascii?Q?YuLzIRXmqJ+vLqF5polMDDMjctw3DbsPvLuFcSxhFM67eHGwLZKup2uzrpMY?=
 =?us-ascii?Q?RNT/fHShrXBzwwRvnzgzDa8nA1Xs4XEFT8xARENRuqtKWuYD1FxmmXdZ+hE4?=
 =?us-ascii?Q?VPm7TLVms1QNl/VHzCPg4zkZyo/C/D15jKmSLgCPjE6W1IU8b0pIVpIWZ6vf?=
 =?us-ascii?Q?+2h6iG6KcaHe/rFC1O+RGN5mPAdUvGq2jkcfWPNA2AXUKWm3Rpk/YWwVDGXp?=
 =?us-ascii?Q?1q41c3UBv6j24V57nMfOG6E5EYnnvDiqeJjOds/Fr0uggbg9ZcBz3KLx84hO?=
 =?us-ascii?Q?m6HMl+oGX7vqm/biscORb1Potkio+1N3tQytucgK8wvBzoECe1aHeem7YCp1?=
 =?us-ascii?Q?zqoZuG1E5f+2VyAyzYpcGoINC+6Qc5MOTYYMXCzGw4NYXLt7NLcslzNc310C?=
 =?us-ascii?Q?vxgx/7fG/sG2Q2T3xHDn9RPgRvSJeLNqOLylCOsi0kK0fZaeJN7JdsPKMiv8?=
 =?us-ascii?Q?CuKuSk+7/uzaiErvJCSxBOYBvQWfH2spL4iSvba08fQfM7uKDMQYV+jBfjyL?=
 =?us-ascii?Q?PjHHufDT2NB/a2VzckO/RrDTytGRcLERNLyi29hrlJWlue8jqujchiN4+/4F?=
 =?us-ascii?Q?sSBDxpq75gTJMmYmE9jkAt7kSiEr1meiKYQKu558Ag/ZmI/DoOXooqgS+Uxa?=
 =?us-ascii?Q?gIOxrN1rlm7J30zmayL98K3i5e4qeFYqnKODFvwT4zWxMRRqmzUMHPND+nGv?=
 =?us-ascii?Q?cCQyONft55dMNUAF8r16a/mPfdGncQUrZVNq8cuCrR2SXx0GhpiojB1KZVPK?=
 =?us-ascii?Q?0G2UDw=3D=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632964e2-f981-4666-a13d-08da7149e1c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 10:05:36.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BEx5p/XAHaTjXcNno30A2Hj74VM49dXK6x8XA0FFsybhhyGGpZKDNJzS1nNZmfbC1uggA2v4P9ylD+lyDPxqxOsfQ9MQDF30Z+cZxVHQIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR16MB2196
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bayhub chips have better compatibility support for SDR50 than DDR50
and both mode have the same R/W performance when clock frequency >= 100MHz.
Disable DDR50 mode and use SDR50 instead.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Changes on V1:
1.Set quirks2 flag SDHCI_QUIRK2_BROKEN_DDR50 for bayhub chips.
2.Use bayhub hardware input tuning for SDR50 mode instead of standard tuning flow.

Changes on V2:
Update commit format and information.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 0d4d343dbb77..ad457cd9cbaa 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -317,11 +317,12 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	u32 reg_val;
 
 	/*
-	 * This handler only implements the eMMC tuning that is specific to
+	 * This handler implements the hardware tuning that is specific to
 	 * this controller.  Fall back to the standard method for other TIMING.
 	 */
 	if ((host->timing != MMC_TIMING_MMC_HS200) &&
-		(host->timing != MMC_TIMING_UHS_SDR104))
+		(host->timing != MMC_TIMING_UHS_SDR104) &&
+		(host->timing != MMC_TIMING_UHS_SDR50))
 		return sdhci_execute_tuning(mmc, opcode);
 
 	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
@@ -631,6 +632,8 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
+
 		sdhci_pci_o2_enable_msi(chip, host);
 
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {

base-commit: 68e77ffbfd06ae3ef8f2abf1c3b971383c866983
-- 
2.32.0


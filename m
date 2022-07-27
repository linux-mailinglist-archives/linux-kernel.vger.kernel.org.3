Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7762581E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiG0Dbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiG0Dbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:31:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83DE17A8B;
        Tue, 26 Jul 2022 20:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHEh4WJu0KLlUOTfR3PuNHHpxVnRs40mD8HXeIOxOXoMrzLy4Ye8jF+EF04sBTOKOrYMkxOT7TmRI11N1O+63w2EdspHA/X3z8LLHOz1dKt0+MNAyzi7+bPcyKo3xAGsrEBPwZ8zqLum3cPYFKdaHz2p0kx4PVjyIDcC4MzIrKg5QmxfyDwB5igUUQ5rArQgT0qfK0Oy3hfDgnViEs8+Sb0eJj+VTf/z/wuLVdURZ0M+vsB9aNWwiUv6VNvW5gW6QRHPqJXilbqsxanSS27BXuCpKj/C8q0mjkj+aj4CiW9tqLIkujtP8RHrPVb2LxF94SopQG+PyPiHWcK8Ofyrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIWJZ1KyBu8GQWDeDdfF4C20MPu54aMSMvFocyRoe6Q=;
 b=Se3T7LnqmMuJdsDXWIy3W0rw50rk9in+IrNNFMlz8VmXoPVoek43uz8coPyv/SHVNmWavgLCBfqAYfNl/D0X+jbVyiQOjEw7U2jGnOVqiF3Ck4/wWNWCd3eMBw/dYub9vlKwJw2l4gNlw0hvu99Ahg9kA7bUfTGZ5+fBFjbkQcuDkSd0H4MxjJpZL7dkPwvjDwwp2+Bh+Wdj7x0F76ke12u0Styvu4ybJK9GBnVPkcQF0nvcTXc4Y0s4UhK1zRkPOSotQLqj9fiMEC+rt8d//YRUhLwbMc6lPPh45sgLdvoJ8D7y1h/1W48Ukw++ISMEqkJOUjoa3dAOb2gxmFrYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIWJZ1KyBu8GQWDeDdfF4C20MPu54aMSMvFocyRoe6Q=;
 b=sLh4ykyOZrzci8NpkYqRqHLVlLhSX3ra6TfSVkakZFFebHy425iCIn+rMvvoYv3jP6FKeBcIOVnbYMk97zUZbTNOzaxYgFYC62Tz1xMvi5XC+nA2DWbbGof03kc+SH0ZPbcAHNzHZV0wY99csEDsF8IgwgavyeeHFg2DR76o9O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by MN2PR16MB3421.namprd16.prod.outlook.com (2603:10b6:208:159::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 03:31:37 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::f03a:62c6:18bd:b140]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::f03a:62c6:18bd:b140%4]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 03:31:36 +0000
From:   Chevron Li <chevron.li@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com
Subject: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix some SD cards compatibility issue at ddr50 mode
Date:   Tue, 26 Jul 2022 20:31:23 -0700
Message-Id: <20220727033123.304-1-chevron.li@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::35) To PH0PR16MB4248.namprd16.prod.outlook.com
 (2603:10b6:510:4c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7caa3830-6194-464b-6d14-08da6f8082b7
X-MS-TrafficTypeDiagnostic: MN2PR16MB3421:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7y1NAjdXIGouKr/rmQv5w9dVv2pgvmp0Ia96FTDElr7ZOI2toHf/Ih+7pR0FoOkbUXPNdZFnzJPgXNcrNH6XAIifI/MIZ10/J6eHdf2XLZtAAR7+VDLM7RXpEWIe54xgnApHCG+QaCEu+lBX/9Xq26vcj0FA43YZp06yFzm9H53MugdtDf2holZ9qt0rvCVGQ1sWGfb5iWfM6PSXyEYzwElthl8l+hZrDs1C3WZkOT/smEdWzqtspz5Q9JmOUqRcxPe5P7yM6EZGIqdacoDFbSJTDioshD0r7drSxWP0r8rYUIrPAa/DmrqMhU457uFwE7zMj1GqlFyU85nkTJVSFe1P3uGAlLo9WWAXlrQ0Ge/TpV/bhJSLCreq5Kx7gkDukx8IU2AnR2FvRo9/r+5zjN5BPMYAoykCem5s8Gd6jGObcX4/7BKMDqHpBNL2rCs4QsiKZiY9bIEu572aAztufblPA/kDRjY7B9uB56e9AyrNxeY85YQup0MNBNcBW2ipsxbSet2Qe92AtBdmKcBPzNIRY08Z1zcBafGk6mpfb/EW4fa7P1WTW4hlprkdWyaRuvTti5IMUrVyuwabqNH76WjPgoFRTBqcOdlFLnkCrk3apcbFHsxFET3IVucm7k7xV8wHHVJNm0iAiMtsMfGcQHn6e7ysDdbF9heUGl2wkvwIpTYfqTSaLak7hq1EeXOT6/6wvdF6kVFc6L2vXxxv4z8x014kfwkErmCJj4CG3UXP72r2pOug+Bbf1mJpUlC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(39830400003)(396003)(346002)(38100700002)(86362001)(478600001)(316002)(52116002)(6486002)(107886003)(36756003)(186003)(2906002)(66946007)(8676002)(6666004)(41300700001)(44832011)(5660300002)(6512007)(2616005)(8936002)(83380400001)(6506007)(4326008)(66556008)(1076003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ualiyWScu/ahVfCkSKyaYUTDuWNSFn+kUP4jxSz61r7s4aqWwfot1xWqtkmy?=
 =?us-ascii?Q?yLWJcfMWmvfe78KyoY3SD07tkiAN2r7Be+aESTT8yEQxv4si3FTygJdZsPXM?=
 =?us-ascii?Q?kekm4xWkYa+wCKM5SgyEZHBePVWI6t3YLlrGTIp4zcvT7eeukFJZlTSFfU9U?=
 =?us-ascii?Q?Jt/6aTtZY2R4rIhe52FcpK4seBmjFcEnYB0AlnoN2a05qawZedsNpt4UgfVd?=
 =?us-ascii?Q?T03MWH5+otaK8/MyYsXo/moU1qu/ndNhSCeZHQONiqZKcD+gEnPaAcdbhdvs?=
 =?us-ascii?Q?06rNJ4a/8YCLgIg+8ec0ViALzRkcD5ENgo+x/fOibJTeTdPeEcH8Qw4Gp/Lx?=
 =?us-ascii?Q?bel/lxZUO+yq2/HrFeKwWNB+sMwMziHHa1NpDT2i0mp3ulxs5qSsm4FgvMen?=
 =?us-ascii?Q?h7cTqLyi+S5x6I3cjvP1rgkBDynEr9FKHnGxnDgtk7hEtllmaS6NBknomNrt?=
 =?us-ascii?Q?iXu7q0Co0CEUlN5129t7E8XGpXzjeOmtOFfrldaJ8/k1qvFMzBxpsqdPlyNR?=
 =?us-ascii?Q?y0D6T0p6VS9da5tVBhppF1jZXc99nQulOfBdDkpqyQ2boQDRmcNSHsvFV4K5?=
 =?us-ascii?Q?mCcsHy3pM0vYfVxZ8Ik+xft17YsU9ohTsDFrkqT5V6InsueUAVbBkPKYpmJZ?=
 =?us-ascii?Q?RCmNyivDjQS66ifsrPb21MIIyb1vkw5v6Kyezl8GvzNHwyog1XY+HUxz7CJa?=
 =?us-ascii?Q?A26SKga4bMPqbFGKOQb+zBAgivbM2vobzhLmRkBZ95hNlB4PquOp9Yl2Ozoo?=
 =?us-ascii?Q?QfHI90Uq7KKputkunVAY7iwA0psIESv3IYJS5AOKGxhQsQha3PeXeek5X912?=
 =?us-ascii?Q?Ok54BTzABDvJV7TkBCbJiiVoFFKebWQCOhORD26SEZezsFf/l12T69xGB6CW?=
 =?us-ascii?Q?OilINwfoMv/GuGUcn30GnkH8BoFkMRBOuJkQ2FhrYaf3tvBg9hvDqTX5EPEq?=
 =?us-ascii?Q?bJN2d0B/aOpXHx4AlJUG2Gw0YqqNHt6LOr4CMUPqtfvkv8P9QbeLLJoaPGCV?=
 =?us-ascii?Q?RabogMMX0rhZB956JD4+f8V2KP1ct8XGSDRPBSmAJ9/d4ISScNhT1M4TDMgk?=
 =?us-ascii?Q?wb7Zx+R4nrdx2nsIuPxNiGLm4ifqDHdQtvDpowK1LucY1C0epUKBOlj4SgDa?=
 =?us-ascii?Q?21xuig71mOtamCdkc/UenY7HMwb9x2Rg9EIpSulbT97vQuq6Xhmg2cEBEpt2?=
 =?us-ascii?Q?zWOgWiXmG8mrpIHSeXJUV98Cku5telMEhAFdepZ/qFYw6NMtFlAKFqngEQFE?=
 =?us-ascii?Q?ALUriRjIWN8gpGjPLlRvfXmrEiDmz/tTHWug/Tk+VdHmW5avUnkuWZhEZ53i?=
 =?us-ascii?Q?MHiEIkGu0yKzS1R83K/3m48+fbdF+FrTICNqlDRPQvDAj18oYyraTad3r7wM?=
 =?us-ascii?Q?GAxlkhGHo2c1qqwcO08RApe4CBBU++s9JJYMJsrEUbRx4/cA0FwPWbEgOgCW?=
 =?us-ascii?Q?8qtrXvFkQoQat3AzfPW+JGoW8rcp7YkCx9HoM5WJ0cqb5EhU23YXcaFV8d1h?=
 =?us-ascii?Q?4TIrCxM0h+yu+j4itaZgft1GCOnUF0ueytnurFyf3S/XVR7t/ou/IzD7UPhG?=
 =?us-ascii?Q?xu7j52rvmX4qxTSNg15CL/am5eXdSzAIRi3zvH4s9IrG3qM/0xNql21n2Uz8?=
 =?us-ascii?Q?GOgBhwMEYBjqMMTah5tofBaK7MY32NFcCvfanxdxeaxiH6Qd+kPtyilLne51?=
 =?us-ascii?Q?nFqoJA=3D=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caa3830-6194-464b-6d14-08da6f8082b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 03:31:36.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyCZhz8+MhpsSlSXQ2nJayD/BwpmUgH799A8iEnt2z+Nrd9bX+yPXTAhvKCb4D3nbrXgbNR46g1yR5Rl2wswIKtwmel4ykTkMnXux0O875A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR16MB3421
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bayhub chips have better compatibility support for sdr50 than ddr50
and both mode have the same R/W performance.
Disable ddr50 mode and use sdr50 instead.

Signed-off-by: Chevron Li<chevron.li@bayhubtech.com>
---
Changes on V1:
1.Set quirks2 flag SDHCI_QUIRK2_BROKEN_DDR50 for bayhub chips.
2.Use bayhub hardware input tuning for SDR50 mode instead of standard tuning flow.
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


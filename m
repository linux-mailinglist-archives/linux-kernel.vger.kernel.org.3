Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53084E8B72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiC1BE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC1BEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:04:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2096.outbound.protection.outlook.com [40.92.19.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF78BE23
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRQHPlCRQVy57qr9OfaPRCqFeY5rCck0LQGSyyDJXS+XiOI27LscIIBeefmk8wXVYfc/j+HGQCZWCbciJExTVQjo9P6p+E3JKuALwCSKgDstD56071ItJ7OvtCrMDNNXvaXgmLCR39fJnuUliCwdS4H5ZiXVAdyMWGLwcPoZX3/U3bpIP2qBIgqODd8OYPeNkuldF5l0Mfp9gIl4NaYdI436D2jN4aq+QZyPJc0bH/hCLliTR1mx6wrCLWd1aNy6gw6vgIDxrsHijT9Nw2dsptlAXnOCEKJDwKh/j9Neo3xKO0vmfoF5SJufCHriA1CG5/WVVPKF0c3inPOhTBdupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCTrfxLfcXagVwsR8LMCGXPFzqm1g2iyi+7Iqer8zKA=;
 b=Z/pmyAwYGeYB9ZPLSfihPUj1iUTbzTEHX1pqdATUpRTenxfX7V08qO9y6gLduxrvpdPvJZttvqhZ2GEpQTmvAF0KOcj1RTnYQxkrv4SqCR22ktI2soEpfdDQjYeWG4UAYLXGVa71X7J5ha7YIhMTwX4d/tdoHyk4tZS8PqIqMwxZZfjbP2FfooQwm15QLlYG3cWHM6a/kBTH3Jf6MbGDZVRg5BnUG3CBaYT0j3u6ZNlFxE2SEr/9Xb8dzR/vZKyb6+u7GN/NCXCinxJhM6yh79H5rlho/PSAhIR93ZqPWiE5vsXBNlPIuYH66/bx5WBrYkJ+dO2ewdzpDg0n47ketg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by DM8PR04MB8071.namprd04.prod.outlook.com (2603:10b6:8:2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Mon, 28 Mar 2022 01:03:11 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 01:03:11 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2] regulator: wm8994: Add an off-on delay for WM8994 variant
Date:   Sun, 27 Mar 2022 18:01:54 -0700
Message-ID: <CY4PR04MB056771CFB80DC447C30D5A31CB1D9@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YkDpozx+ZmSWwwH0@sirena.org.uk>
References: <YkDpozx+ZmSWwwH0@sirena.org.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [DFlsxIhcIiBjeNCWRwyhmwb4ftg0F3kGFrkDbtYVBBXIICKviwjDZR5VnyQfmhWB]
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220328010154.8274-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc72d361-632a-4bc7-481f-08da1056ba4c
X-MS-TrafficTypeDiagnostic: DM8PR04MB8071:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dR4W3gz6PVigrE3DQSrpa0fP1AxnC8bvwr93p6ZgjsNhVMvBVaMJ63/0Y+8VcHZi9phevJLmkqjuaKVZLzdQNWve+ztIFn2Dw6aC3C8oDH4jHyNi271W5WnBkZAdKO+xsuCzYo7Wa9M709XBAIwqa1NpnPIiex18bHsxnn9I4OZNJSNK+3W00vSS3ODSvBYQ8AJ5pTs5xLYoB5qjfKZ+LXSa84IJBovup3vBtxfBmslCw1Ml+bR+nwJXbyjILj/l0JFWTGaW72WZ3h5L4kLlCd9sCz9VBLjVA95Yek3b2+6KcIkev88tg1fuMHb/Qx5FEAXENB/nBZZ7s87SIcjvaf9SYf2lHqH4avxbrojSI+BDssoUI8h1AUzFkpWkxinpmcHJUkrMNWBhtM6dRdFtM/Go3x5tQfH/7PeWYz123C1xS+vri5gXbDflgvRsM+BfdhEjg+Kxlkd/kd+NTYntOmYtDkgStuPQePrzry10/sisyiuRB4eTwldZb8+EXZD9dTQawnw+im6gmHs1kq4tN4DT+EwSkdEML5iLoPhchILX8j97jSYMRuPG8Tbmk2NJegiQYPakz8WN8ipe2pmEvQkhs8wHpjbHUFShaTmhPcAjpCaHRyTCteFx3da8xPvU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VJFsJ+1L0O/Tvu+GrwLNJNM/3Ht4erHERCaFptCVqNZ4LQZi00aiKf+ld4b3?=
 =?us-ascii?Q?zPmkGhrESUeZCTIGqpL7nPM9SNsI+80IXRaJrd/scaKQcjXbq4cwi94rg+Gi?=
 =?us-ascii?Q?LKzpL1Rfu5yQC9Scpbdv6Ohg8TxewdDivwP8fm1mK72HDSDrzN3K7ooRcuR/?=
 =?us-ascii?Q?WpkgMRKE0qroe3khZFL0eS5hGda8BH8PEJzw7VMZWwJW8edfD+1qg8MTuX3e?=
 =?us-ascii?Q?FgqvIUb/vrpqsgAUi8eUwPMf2XsODDFnLV+kM4f/NL6EIs0/4j9oWpEvmMb2?=
 =?us-ascii?Q?4p4D9sx6SCnRHsmcLo4c7Yar35665W9ndnP0XGqJIWLeUCGtrD6pPBnYnAD7?=
 =?us-ascii?Q?1LJnFjVLL9oKkeloWD6YCLnQ4Zeq70bSWWH5Jq/RJgv3ND8Ej1LqxXWTRZBj?=
 =?us-ascii?Q?HQAW7DajURIMMySIsXClq/4jdsl1vSJVyQ7T+HLXRt7zNwg/jyxK2YfAD7Rh?=
 =?us-ascii?Q?oyblsWW3eXi9LuhNZyNedbfN9BtBY7AtQN6bwI3bfsbTZIBZCTQ7rtdSuF7g?=
 =?us-ascii?Q?E/ZTojp4uwS1ORNaMZubt0Vb4HWfKHsgjDUj9AI9jWDtEUZvotHQH0fFz1R3?=
 =?us-ascii?Q?3M9R2PEWxJLTcjuLt8AYspA/1NjxpEOP51wPJ/YoLIYyW8qGF+CmJrp5LkyL?=
 =?us-ascii?Q?iQyGZGMz7olrPd9bLlI/CF7/yH35FSi5/UCipEK64OSSDVe5zxSLgb5mMGqC?=
 =?us-ascii?Q?MvWx8F39gWDWzQyACl1e2s23UfX1WRrmAk4PJAWllpU6V2mCUbh4UunEgWkQ?=
 =?us-ascii?Q?2iIAkogZ9fOIW5pUPGDpYkPHlon6Qh/MhOpEGTEiOomacespThxBQ7BeqVEL?=
 =?us-ascii?Q?BL7EWAKNODHKaUXE4OHczzXVa34MeJhp6+g8oZUjv96a6PxJDhQF9KRbcmNn?=
 =?us-ascii?Q?JrbA69zEdojEUg7q0eoyad5imtJN1ROVfihDQS0VoPbYH9qjImMnsOcmUUpa?=
 =?us-ascii?Q?qrI0XCzbyQiM0f2vlXlV3Ys5M2OYZj7jiySkrB8LcNiMtJdV/hZW0gJ4ZuDH?=
 =?us-ascii?Q?EIah5Ne/24ukmZ4e/UoAeQV4XxDPKLH8DCeXr/IQyP56wVc0Ip7xaXqTcLXY?=
 =?us-ascii?Q?KCr5bZULjo3JjLEmmKHEqU/JjpXV3gj3U/HvQQSS4TGysQdamXKrK98mq43h?=
 =?us-ascii?Q?OfSd1g3Ky0MeZ8rlh5iaWobtVBJuAJXx4wpFfhzAF72Tfvu+xds5e0nYqvNH?=
 =?us-ascii?Q?QNIeX4G1G/gOkBtAZV+FHfWAhfidpl6hSBXCryO3fo+/6uvgWnug1hn8Gz2n?=
 =?us-ascii?Q?sFSxrq+qOym7IENxHAsMUOxmuOl/FVvoqwDJER8a3rbAdNxqbEq3d5k06kqQ?=
 =?us-ascii?Q?SdHJ/nJbENWUnEMcajrI9JH5d2dR9Mv9KENMLIP7rX/l1q+ZnYQv2OZxFL2r?=
 =?us-ascii?Q?+5g9V/nVeZJAqx9I3yhdpOu85mNO6JOa7OrgfeiuvH33l8UMoPGpWdsmRmxX?=
 =?us-ascii?Q?Cgt12vlPKiS1OowrDKOlJsJBWpdkbpUiJOxhUVG0Gd3Z9nYU9a6cbtDzOV38?=
 =?us-ascii?Q?3lzyJoC59cSZzXs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc72d361-632a-4bc7-481f-08da1056ba4c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 01:03:11.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8071
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Table 130 of the wm8994 datasheet at [1], there is an off-on
delay for LDO1 and LDO2.  In the wm8958 datasheet [2], I could not
find any reference to it.  I could not find a wm1811 datasheet to
double-check there, but as no one has complained presumably it works
without it.

This solves the issue on Samsung Aries boards with a wm8994 where
register writes fail when the device is powered off and back-on
quickly.

[1] https://statics.cirrus.com/pubs/proDatasheet/WM8994_Rev4.6.pdf
[2] https://statics.cirrus.com/pubs/proDatasheet/WM8958_v3.5.pdf

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
Changes in v2
- Duplicate regulator_desc, keep it const, and select which one
  instead of modifying the one existing one
---
 drivers/regulator/wm8994-regulator.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index cadea0344486..40befdd9dfa9 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -71,6 +71,35 @@ static const struct regulator_ops wm8994_ldo2_ops = {
 };
 
 static const struct regulator_desc wm8994_ldo_desc[] = {
+	{
+		.name = "LDO1",
+		.id = 1,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = WM8994_LDO1_MAX_SELECTOR + 1,
+		.vsel_reg = WM8994_LDO_1,
+		.vsel_mask = WM8994_LDO1_VSEL_MASK,
+		.ops = &wm8994_ldo1_ops,
+		.min_uV = 2400000,
+		.uV_step = 100000,
+		.enable_time = 3000,
+		.off_on_delay = 36000,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "LDO2",
+		.id = 2,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = WM8994_LDO2_MAX_SELECTOR + 1,
+		.vsel_reg = WM8994_LDO_2,
+		.vsel_mask = WM8994_LDO2_VSEL_MASK,
+		.ops = &wm8994_ldo2_ops,
+		.enable_time = 3000,
+		.off_on_delay = 36000,
+		.owner = THIS_MODULE,
+	},
+};
+
+static const struct regulator_desc wm8958_ldo_desc[] = {
 	{
 		.name = "LDO1",
 		.id = 1,
@@ -172,9 +201,16 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	 * regulator core and we need not worry about it on the
 	 * error path.
 	 */
-	ldo->regulator = devm_regulator_register(&pdev->dev,
-						 &wm8994_ldo_desc[id],
-						 &config);
+	if (ldo->wm8994->type == WM8994) {
+		ldo->regulator = devm_regulator_register(&pdev->dev,
+							 &wm8994_ldo_desc[id],
+							 &config);
+	} else {
+		ldo->regulator = devm_regulator_register(&pdev->dev,
+							 &wm8958_ldo_desc[id],
+							 &config);
+	}
+
 	if (IS_ERR(ldo->regulator)) {
 		ret = PTR_ERR(ldo->regulator);
 		dev_err(wm8994->dev, "Failed to register LDO%d: %d\n",
-- 
2.20.1


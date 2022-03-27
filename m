Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DE4E8A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiC0W0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC0W0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:26:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2050.outbound.protection.outlook.com [40.92.18.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3494EF55
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmVzwTOKgEwHx/TjxqMV2mGJ3uJuhfybeFH6PiIGWkc1VwoznuFgXlo/NqdNrPl3ins5adQqMIlLumwHMXD+wytN8fk48OjhJLkDw6qdoDhth2Z7D3P2gIKfmzpoyRvWLz3wRkXKUq9eHa12u+pKP+/6lhhKZVMp8NThh1zTuwTTmVHm2nctkP9R1SSCH7PibvVXg+N0UBPwqR7xmp6nRZncBzYVQ/YW2kZk/utyhz24QbazyV2GirEFcUjPvtmws/3uXBwhknbMRP/A6y39bq8tjwB+q9NeesJl/kWPz1Bmn7Fq7VKV+sG0FAGn50Qww2EA/fPgKFNMJKof7+qt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt7M98AlgaElGfNWsvjQ92Xn6gngCYut9KKYMGDS04o=;
 b=XLl2BtNrzEln+jGHace2xf6eDxQdErewEZs2YqF36IgspcI07OeNUudq3+QqFokdJqDzj9AIHgKMkUcbARyEgMdUaUQG9/zO5a7uBXwrJY3xRGFQkbSvcd9dsA3n9a3mrHmnJ2S4Xu3CGxnQdxoCEwfqYrP1RYy7ZLnMIXh4YMzK2/0GBofvyPB5w9uoA//q6POY/HLI8Q0VM1ME0j8AUeDY2QhivGzDxr6A4KOUes5aAsFYBNZOCg8ZKlXbbAMnAY0eE9HW1GldSHKSjzZDUpZx8hFMcA48IQYmTCM/ycJDBJ8+jiVwseOhsXswwY1HNIku3ExvzqbwGxROkNTFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BN6PR04MB0835.namprd04.prod.outlook.com (2603:10b6:404:d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Sun, 27 Mar
 2022 22:25:05 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 22:25:05 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] regulator: wm8994: Add an off-on delay for WM8994 variant
Date:   Sun, 27 Mar 2022 15:15:53 -0700
Message-ID: <CY4PR04MB05676D46494F722485CE7551CB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [MwdMb2s7ZTyY8vIzb+/Eb1XfSO67wd68m31Jeeeg+t5StVSAjvSTIe5fnWzjZufj]
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220327221553.4441-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2646ed27-0991-42e1-afcd-08da1040a439
X-MS-TrafficTypeDiagnostic: BN6PR04MB0835:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5o4sDij0jIREg4zQJ5ab+widkh0vPR5Ck3pIUykwwjGrDsa/ed9kxx2GyySSxlZ4952NcEQA19605gz3+5ACMvAgrcU/B0KpG0lJw06nEfgTj2vvYaxDmVQ9HKajbuAmANnAzrp0P16KKZH/hrtIDgMwhGiloZgbsHf0xmYnHheUFgAWdUAFgwUabIoNarbsyNxnpoIxVExkedD0jG9GfCuHunfcAnAy2LFvV30R54xgzvf7pbL7+mcemdmB/tNP+J/XsUCrQqyJLne5Z2ipaJCav4R3Bd+t8SVv4gSbHvJiUnKLF2PgJ8eQ9ufS47DHW8Ux9jiREJIDmorFiHqoSxPzpPt2kyvk4jhn6A7WPYW3+/IsSleBnp7wi/glsNHYVAovujlPdaHieItnA5YqBv6yXN7D17UDo4NdUoF73sOqER/l/8N60Om7ZJd1PJ6C2aEpRNxHskDyvPcmVJhaVFGFfNPabXshxr7ILbZe8Z0MJUne25/qlhKuvIXpTt6inosd9O09pqF4iRLhhDn64fDYW34PKfqIYUg7S9DA/L3xSV9B7s8AaRuSjn/Ho8qHdoxVosX/t1I6vWazDrhu8tIQcxEWn5F+YRH0apJMJ706v/Gh7s3X0XIHVyDhTCLM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FEQ/9i4fi7kcjuVm+KXoB0REmcMDHTSokESTtSJt8zfItj0IsXoY8rlELwF?=
 =?us-ascii?Q?g8NBncqIlgDGdcAJRM3QjMqGBOjjXngEZ21CuBvSqO5OAtWA5CfldS7U8nCS?=
 =?us-ascii?Q?ng2BxYSPTn/3fRkwabcKpSRNaCRl30Jo3dJWic1vyU1FIsnOUrapTOhpmCUC?=
 =?us-ascii?Q?F5pm2hB9OXDV24TY4Bin01qV5unux41h/OhBtB1H8cSmLUFCTOhwuIAE0WqQ?=
 =?us-ascii?Q?C5+u0Qc+FmjGvrzD0ph28FM0yihDZhulh3tx52qo1nlGQFPDsC8VhiYAkQjY?=
 =?us-ascii?Q?3aaSHNrE/48TcwtsXNwGQlm1CK8aDTy/oUZMwtupiXUdfwNAh5pVz/KJ2UzP?=
 =?us-ascii?Q?Pw3I2lk4UGgd9IwALmjCEFecW+1hncuRQHfs40qh3dHfB7W+COZ/rMVShT9P?=
 =?us-ascii?Q?xTRUF48oPpQVzPTzO8pqitUyw7rNt0ovQvkG/1wpLkBrT4aKnV3Gw0mZwx8z?=
 =?us-ascii?Q?yF6PoqflrlvmFs//xZczkHmIDEhGLk2irzLaD1nf0xFFVgRZZe8jYuIHVlMu?=
 =?us-ascii?Q?fq1CJ11FvhHCSdwCYmjMvQglkpfPsuQ7+jdmv5jaUhuuosxqOoCoPY0cY7si?=
 =?us-ascii?Q?vFUOA+/bkAHKazLRq861kqD/DONybX4zoaufUWEQeMfHsSQzH56PwvIQarDs?=
 =?us-ascii?Q?0xpLrKRuGpKPCigsX3TS4cBrlsPGZ4fz572xoZFS6djGrDfJft2+vFXS6tY7?=
 =?us-ascii?Q?dV5PfeRGyHb9BXDYbRKx15rrEeMN0JPRHOYfCsJ7dGMBlpbO8vUHkhYLGMz1?=
 =?us-ascii?Q?KlodiQA5um1BC0/2+f8YtXrVrBhWl0OGaaT9eC2X+0F5MPfrAJth4LjjnrGM?=
 =?us-ascii?Q?PDQKeAWsR/Ys28E25+ToinT/C+WYONWc/Qg+EdR8aCz5JEdAgQCyCHF7bCYj?=
 =?us-ascii?Q?/gdv8tBWj6TNbs5o7qx6c6OnKAafJiakMPUOaMJ4hgEDPYdGmQ58/81+2NXb?=
 =?us-ascii?Q?yIUS2jLXdfjG2ufcHEmb9OAxOwjAXyEDphph+sU3yiO6fDYt9g7SseVg38yX?=
 =?us-ascii?Q?qXbSLaEF99NQI0TJfFx0a0zuwu8KC7guXM5eMFAg6UuBEEHu5iR/Xh2bZiPc?=
 =?us-ascii?Q?qVzJTidTAlz7zkg2ZDmHgO5v1+qf8b/QDSqqDK+NtbG5farhCx6sdHHdrCxq?=
 =?us-ascii?Q?lPccXUhOiCPFVoiTmdrHC3wQoSTVHrAUHasLxDIy+jLW9YqOyxAUvzv0UviR?=
 =?us-ascii?Q?6ZtorSZeiSsbAqpeNV8wBHxeRuDhW6tSruAH6o+ss/HX5EbSRntR2TkVROWg?=
 =?us-ascii?Q?tIy0GHgDoBCbRjIBGdmfRFhvrdCIUczRi7GYkuXRJABgwrqK8COD0sp3ht8O?=
 =?us-ascii?Q?ul9vCZxkNI1VQdmQDTldkHeRCRwdop9Z4r/9ZyHWn1xQxl5tQvrZa/1azVRG?=
 =?us-ascii?Q?7yzelFK4RKdkFDA3lecErG0/PXTk5FzdJsE0Q4CcdAvlghjqbkG6uRU1mMc+?=
 =?us-ascii?Q?0Vrysx3mMEuY6+eYCsZYHRJ5aXliKOx0Oc15OQi0lVFgSqOQFOd/dKXC4MEZ?=
 =?us-ascii?Q?QjTPtvvt2x9RWnU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2646ed27-0991-42e1-afcd-08da1040a439
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 22:25:05.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0835
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
 drivers/regulator/wm8994-regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index cadea0344486..135fdf3f9fdd 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -70,7 +70,7 @@ static const struct regulator_ops wm8994_ldo2_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static const struct regulator_desc wm8994_ldo_desc[] = {
+static struct regulator_desc wm8994_ldo_desc[] = {
 	{
 		.name = "LDO1",
 		.id = 1,
@@ -167,6 +167,10 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 		ldo->init_data = *pdata->ldo[id].init_data;
 	}
 
+	/* WM8994 requires an off-on delay while others do not */
+	if (ldo->wm8994->type == WM8994)
+		wm8994_ldo_desc[id].off_on_delay = 36000;
+
 	/*
 	 * At this point the GPIO descriptor is handled over to the
 	 * regulator core and we need not worry about it on the
-- 
2.20.1


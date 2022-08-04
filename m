Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401F5897A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiHDGKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbiHDGKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:10:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F261116;
        Wed,  3 Aug 2022 23:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbAvvc2xUbSK9LyluV0p90klBDS0OORSC74N/3A7j8dqdgHCUY7jp2N31GxJE3WCGggYsaNytvodX0BBzhA+1U6K88wV6eZyf93IeOHGRXdSE8H12FM9uD8pFEKNEaASuEw8E3hcO+3sc3q7FowAtho8jBLEEN2TTqb60ReVtJp2A08H8m9vbAWWBKgeImsF5lLzfrt8s2irMoBgjHyNI7KNFGE/8nstm2tF7NeJbxIa5jUhtdAg18EXQQ/bXIXGU3lASb/S1YTr/boNucFy3a11ysB59P5+DJbgjmnjN60fNi4x0qTpihEsr1vNp7v4+V9bFxi51vTl+Fu1y9acOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWYG3po13cDVDOS3mxdIqYHUJ2HrZYlyJXjrWF0yZ+w=;
 b=m6qhnektr0BswaV0DYaFWJHiJOSv0EIWop4nsWGqschCM4Rz4T8awupkXcZxIJjpt7ImWlmHOlsGhkmXfNaYt2eBWxyAQN9g1y94C8p5cL4ol7GfG/wJLGWXgsPY9vEXIinjoEMHifrlN2IbdcdhZ1DV1KVp2Wzk0v5Jog6D2/n+Zr+XrbtwFSKyUB9HpEYMKIhUrhZRuODvGdJ1xmcfER1eyTuh8PA0IGfvolgPWrChNdG9o3DOiDmQDxGA/fuVV1n3Nv6eYnXirAC+hrtw9fLGamWlamWx2z2vNMnHetkwgJlcjKObQ3R696QR1sejkECT7EL0Cs95cHFvp69T6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWYG3po13cDVDOS3mxdIqYHUJ2HrZYlyJXjrWF0yZ+w=;
 b=HraLyZBgwMK4tcY9iGkIYPnl3s3FIdug1DLPXmZ6Ohl7SiBjjflBQnYJ5jZcdoBiQAT6QD2Rw8O6lEKe4PMcZ4Cuym5HyeQNN+QoMKE8GNEMKihOghtPGg6FMtxQn2iRV/8a0OeETNpQ7lzEfFx8pQPORoFHF5Vx6atwQLOLkO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 06:10:02 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 06:10:02 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v3 1/3] drivers: bus: simple-pm-bus: Populate simple MFD child devices
Date:   Thu,  4 Aug 2022 14:11:31 +0800
Message-Id: <20220804061133.4110734-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804061133.4110734-1-victor.liu@nxp.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e68fa8a4-dff1-43ab-78c6-08da75dff7d7
X-MS-TrafficTypeDiagnostic: DBBPR04MB7721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mv9Fx9GOZzNXxEkWwHljM0HUnDcZRq7b1F1QsdnEyJYmIxF7r+0oGS1Yzu+d2OR5hI1yABV/2I1k8QqL+WiizbvhBKPkL3RKChvsHAKLpV8F1qoiXExd3IJVJcScbqnkjS7z8USAi3WnD5h8ZOYJlVcqBcHtHbv4/AF3wlM2AbtV6Aj/UFYFp5J9BbFj7EOfDzkZQczmDty26w/tRRkahyvNdHW8qqx4al+3oNl/4ALLHcR1TFJiZhDs4iWnr/9oU3VDfx9KQmsDuJTO9Lu6yTUqYH3mBzVn9gUSeIzFeuVoQIesjVwBUItoGDf2HkSD4iWEltNkJAfiJyTHwinyml89eL7jfdrohpODIUl10izf6jeT4Szgyx+MRD4z6ldojvw5jyzMpulE64dWONK0EKQJCOexDLSgy/GGgCfwdUWwsrZCIjIRygc5Cl48esTMC7zyrfOZmFiybZ/CzybFGWvaIiDbL8DbsKynM+06Ku5QD8MviEtQyfc3iXWLZUTKyeKBVYDu0v3p8z0x8o84+yU07owSGV4V/cs36gunzJp6AZ9qBnfERshaexJZx0yAyVYaJVP8Z4SuMWU4KBMMQjVpmFoVb8exmXCXu4beBZEu01XKzl/TDQep79EfiKRKIGW0WzkcD5RoOhfegtd2vraxg+C1sAS1gCPAovkcPD6BEjCL8qwMIaRaeG6O775PAf6nZb1RCHT1jlrxO6+jSmuyfeCqItT1uqlrmEBnAubzqArfnvqLbHaTfWWmmSaaTNoN+qvDb/yj6xD9x06wuFWlU02xO96uv4HQpaGRcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(52116002)(6506007)(41300700001)(2906002)(6666004)(2616005)(26005)(86362001)(6512007)(1076003)(38100700002)(186003)(83380400001)(38350700002)(36756003)(5660300002)(7416002)(66946007)(6486002)(478600001)(4326008)(66556008)(66476007)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/v/i4LSO898XXU0q6QMz7bNeFhlcQv0SmmJ4tpXv+TIR6alqzPQofleDRrL?=
 =?us-ascii?Q?EDlfBC2CRQZ6ml1ieYtm0c5dAmTuZUHsGOWrA0rY7z07niH+/GysTs+DXSik?=
 =?us-ascii?Q?WPt91L/mNY0M90VDNjBUAkdt0FSGMdboPtbz1VFJWe8k/EbzBgLboU3wy2xY?=
 =?us-ascii?Q?o8usdkO7GopDnGRDbHyPOIA86Zi+V9SvzSpj1Xsv/Mn++oqW/CvnjuMqGgxG?=
 =?us-ascii?Q?rZxcP57tCYWyUGs98pd2dTb4XPKuCdc1mMh2PL3wcD6lqufRWN8psgGRS57P?=
 =?us-ascii?Q?MP/K+g2kJci+AXwtt8TX0iO1pO059dzRkfMSqr4jUAgw8znSj1Bbqva28K5E?=
 =?us-ascii?Q?1WYMxz1vY+5ixZMS5LXt1idxp+wBHXV/0t+2LfZMW901IcE1OMEp4ZmdvRv3?=
 =?us-ascii?Q?L8M0a8os4dWTTZhmW/Hea3JtOc5my3QMR3rvlBQkCElk2jSIwwO4D3tLwGGg?=
 =?us-ascii?Q?98L//qqpopto87Sn9W3MYP1Fr63tsVLNncHuuCk9sPNXPHkOfeAXEkXKyfba?=
 =?us-ascii?Q?JsZNUPyQO9FWwjgrnj7J+HGtyFNHkuVK4mPHSNWCHODHQv3bR4/B9YOZcjXv?=
 =?us-ascii?Q?WqbQPowYRV66XpHbeFxwJIRQJxaqDMvEC7kMAoily//SJTZkwaZk6mZPHqFm?=
 =?us-ascii?Q?ifQPeNSLyiWEndxE2sWIZivAuA98Nd8XHUlsokoseWih8XqtK5KB8g0UFJ8j?=
 =?us-ascii?Q?ZpFzV5nQ1UsYLo87ypd7anthrBfzcl9/P6OE2Hn5FEWdsXl4R8cAUyYfmIwI?=
 =?us-ascii?Q?41XNCvAl8e/zlMThWEtAxCYZAzJSmdKs5n0kMHqWWbRfDsaT5fGi1g5mBb6S?=
 =?us-ascii?Q?eJZh7E6CFA0uTq4uKr58hovlFAS484rbJxKqju7xYE1mrWMWWdV+8eB6rI5F?=
 =?us-ascii?Q?/YihSCJdGFXKFEje+viEBEgl7u1aNLSG0LjD+8GDRsUWXFQG0D1bTf0WBhXj?=
 =?us-ascii?Q?6nEGuDThz0Rg/vFFhwet9tikqbqLkSMl8/7at2yHSClfOLksUxjAnxd40eqi?=
 =?us-ascii?Q?AlaY/rt3m0px8lNzl+f2+xks9kXQFFAVPJ8oFAyej8BICGRQ1XGbrSscT2Mv?=
 =?us-ascii?Q?mj9nvszIpDcGh5NvM5LVYbfV6MVtCHUknSzvzWzLkey4+5GZJQLmXjXE+yJP?=
 =?us-ascii?Q?aZeoHv9wqf8JYy6t/St2rNgK/IaU338soetCkZvmCjW+i8NAsBHP3SAdm5UO?=
 =?us-ascii?Q?jpB+bprGmKBvuVv7L+uxwZPXD7S1VOjUj8DIRLrHKt3s2Xwq6n/qIZkmnZ2I?=
 =?us-ascii?Q?F8cThdgaPydqPX/e08/k3yvXO0ecHorsau5Gg73A5ocbBE91bewrQ53Tk+ba?=
 =?us-ascii?Q?H57qa5/Cx68YKrgiAup5m+j9tJmgsw66Q42cpxIBytsKuiRun2MYyAudJYRp?=
 =?us-ascii?Q?+4Hssaa1w0RYjRxVLX2hzj8JuvR/seQeA5yia+fbmeWbGyrxm0KKn713iJ27?=
 =?us-ascii?Q?wHOD0u/0IKAZtyNVVtvNRzkXnik0wAEE76UeFbJEV8nEFnNZhzpVr0clAcT/?=
 =?us-ascii?Q?8ImSKLH5D2COgOrjhI0tIFyYL/lYySqeJpjBdBNpduqFQ2sXdkyn60T+psPr?=
 =?us-ascii?Q?Xd1G0c4tuKBA69XT+loMQfbGXXO5IH3Xwu4GM8dI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68fa8a4-dff1-43ab-78c6-08da75dff7d7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 06:10:02.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIQAsjo/mYbdMX8h3xS9OFLqqVMSgoyzv30g54Yc/say0b56nxz6bDQ83xB8mZZz2TGya4P25EkJQctIKu+Edw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be simple MFD device(s) connected to a simple PM bus as child
node(s), like Freescale i.MX8qxp pixel link MSI bus. Add a child match
table as an argument to of_platform_populate() function call to specify
the simple MFD devices so that they can be populated.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v3:
* No change.

 drivers/bus/simple-pm-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..ff5f8ca5c024 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -13,6 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+static const struct of_device_id simple_pm_bus_child_matches[] = {
+	{ .compatible = "simple-mfd", },
+	{}
+};
+
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
@@ -49,7 +54,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (np)
-		of_platform_populate(np, NULL, lookup, &pdev->dev);
+		of_platform_populate(np, simple_pm_bus_child_matches, lookup, &pdev->dev);
 
 	return 0;
 }
-- 
2.25.1


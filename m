Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA64B1B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347100AbiBKBoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346975AbiBKBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:22 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300092.outbound.protection.outlook.com [40.107.130.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6EA5F9B;
        Thu, 10 Feb 2022 17:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlxVqlvwezHSMRWGExk8r1uZaY5dErU0oBGaOb6TUGBi3DqilYCOIkwAlPjSq2FKvGRjFAtBkRzfIzMS2Kz8Q1VPuIf59XH3hs6VUYw+YY/4X/7Km1IN1szbLnNWzW+JUEeXDcEKJfaLL8w/gNAGFG5jTRBErICS/40Ht1puzman9bRThp7JD0s6Z2N3JQvWonYtfewa+qERbOEZF4Nnok+Jt/i+IpEKGX+5+zDXxIjozp6j5XpCXTscl8Qva0t/r5oN5PvcIy61xiM562FJ8oRrZ5o6WDX9P0vQ55whLM19wighBzkW+rP+ojiAGALYxsHzdqi5q5hwggDTKHq9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+PhkdPbF9OOYJcM+200PXMui6uN8XsO2KXH8pDU/qU=;
 b=GxB4JDaRjacgiMaw7FqNxQUZJRUewDBdDKkmTawgVCr0E78hmLGIZWN8puuV11gXfIl4W+T7QajZRukl9Sw1Z6b7kjwXOftkghhnq2BurB2Aq4VWrxfUYqcf72rMSm8MKmx3g2nDPtyMYxJse9vVJOzLBZOaKye2FIUDJx1catFpwmfFMPm/DbpEN5DJoH4ZqoshHjRRuopHXHbl+Xo8MXt518rgCdKRKsWTfnTtW4G+W6MumIa6H8FgXZ99XhDPsIP4I7FYPRCcEjWPqzFSgpv/5PAvhnc9G/ZK6U06cZrGhfYRwFIeOfvXW51yQ4l/z+WoQN7lZD1cWRflDa7cvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+PhkdPbF9OOYJcM+200PXMui6uN8XsO2KXH8pDU/qU=;
 b=rsLMlDMow/OAyxws7ouTM4wu8xgtNgKxuucZT0adddy0mND7Z9oQ/zlRCkA4jB6Mz1cbG5Fvn3MOEpDmtqkI3CalzXiyBWGTtpYV+AD66Y/+GkMNqqZWO1P5owkBt17/1cZwzHnAe162fmdkcflcpB4wbY4PieeXdOK5f3V5RBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:19 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:18 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 09/10] arch: arm: dts: bletchley: enable mdio3 bus
Date:   Fri, 11 Feb 2022 09:43:46 +0800
Message-Id: <20220211014347.24841-10-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e80a2a9-e977-4afe-2007-08d9ed0003ee
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB357715421A279EDDEEE252288E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUIHiUXnOZo9SNiPWtMDSk4l06sZbpwV+IXE1ftKrw0Fi5lq3Lr0dRXq0P676aACtHW3Jmfpf80tTAsS8xM0FPUtYlVDgeLlLeLZ5WaPCneLl8H4gQ19klKLxs8B1ksMkAOj5HScoxWForyV33ByPinYIHcaIJ9CuGta5QHyTRV/c9mXQnVZhjhfNl3ErFXZUz46d2UMWFTUrFK/T3pyhmQ4Jhp8G5jfrgP6PFJMTaYenIRyo031O+1KijlHG/cN/mCOT9dRFxcADgACNj2JLPb3YNUI64flSQyJdsY32ju9TVM5W1OXKNRH+fV1BMUEJNfQUadAOn6NnslPl8yXjaNDXoSS+X7LsgXUVwQqZYDSwRaNJPRoT+Ea3phkH4kbjWa5+RgvZ6s8GiCnoXnWgKIbig4cabE6paE3BtY3mFgND49YxkHWrbtATEE9cAXfL4X9XnUmasi+Ytqd0xYEb+oPioNoOKHhFVwcxyAvEDeSymDjYJ5Yln0wMWJgAeM+CakKHhbsvPi0EUeqxhan55lU5CAjlnDh+9NQbQ+Uw1gm1rfxxWg6yJuP0IuZPcrpZP8gSdOFitnJxNNaTsEWdBz9EkrPocsZ+QMC3dUIVIgr5aq2hA4Ou9Ppsf+dXvJ+UMyTRsgHDoqsZTXz2YktylaPeb6QhV0Ik5n9FoHI6b6VhiAtdxEMGb2ULiafxfKOmATZ4LULsBCAli0ityAAUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(4744005)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+BrgirkLOYooeE+PhVcvNEQFQH3ePjP6kCdWUx3C0nkkCJY6HkJy/8X2Tak?=
 =?us-ascii?Q?OejEd/j7gXv5AcWYaCSoGygCI5KYAm90mtQPiwSK3JslTepcVj2Cgb4n11Hw?=
 =?us-ascii?Q?LEwCCJ8XO3T5vObr6SkEtCGKHH0gEc458TD5/agTZLJv7MEwuHh3OeaYcBAh?=
 =?us-ascii?Q?IlkAeXxnWnVauvZSjuhfgKYSt5bDf6AFb/u8M5DZESDisbmb8k9DFXdJUu37?=
 =?us-ascii?Q?KiAPJArBTjqIecD7qG4izMoH0o70vTpEZXM7g+FUqa+92pximQ6GchrAO2D2?=
 =?us-ascii?Q?QPQv0lM7jEth8SXEKVNHb4NMDb5iF4G7Hso7noFSCD/5bLqXdsl2phBzwbwY?=
 =?us-ascii?Q?Sr5m7eWOnXE9oNNaJqduYOHOVpQ0fgG3E7oLENK95EIn3jO+VElqHruXc8c2?=
 =?us-ascii?Q?4SAFaD2Sa4QPe/Wh9M3PAQx7QPRc27mNTWKA8JMUSpsTg61SG2hiMS2vjFbD?=
 =?us-ascii?Q?8vw9MzJxo5C0dPMlf8EbcnUarpxFAhXtRGBU4aS06qYETSJOzEXCAKS+kw0F?=
 =?us-ascii?Q?mrJleReFo1b345GZKcsHZj9LdTU7ONWtCjx6fVnjhmMZ5C6oioZAH5MjHZlF?=
 =?us-ascii?Q?fTczsSiiCq9VdEAQKkddVmpFE8Gc70Chfp3A70J7rddntNhDEJqG6zUGN4id?=
 =?us-ascii?Q?imDxorl66C5VpQ7K2EnaKyAjk9U9QDDZPYmMVayYsb0M4BnG2SxJdH3jIJK9?=
 =?us-ascii?Q?qyhdNG910N3mzSBbQ2TDCAiNgQPtdoDJ/DkGpu9AkDP3/g6MjNk/PxshwSEN?=
 =?us-ascii?Q?7hZgiGZoxeX5Wqwmouqbf8DTlkNx4dEOnYScGLyHS9w02unSkZiTzgIf+Vf7?=
 =?us-ascii?Q?Bf0Q3RWrarp1B8lrjb976GYwTDWaff/1RrONDmDFdhLndee91U3TD1/rm5sh?=
 =?us-ascii?Q?bhCYyu+7c6wyIdTS04Lea55nbjejCIO8ZW/cYkjp3M3QqfgvLsggYj5fJ29g?=
 =?us-ascii?Q?v6Xi9gnDcgrBFpCa0NgOERjfliSAqhVPh9G0igvZUwg+inOUAvGGwxrIHpxD?=
 =?us-ascii?Q?kLw7bHGaONMyMloAGjoQJB1dNtOHLDNjUI1KLsxS4MtctxICcLAAWxdjBEbo?=
 =?us-ascii?Q?BqgGVC5gBvP98AzaGY3wDswEq2qn1EKxtEQoDtKuqd8hJFJek451EPeSBOx9?=
 =?us-ascii?Q?+rjZGpxM8HT/yZpT4hp3xWXvFfSQAyGnRlKIcOgG1Y39RB1C1REEeIohnKLa?=
 =?us-ascii?Q?OYv4DYkgi9xd7X9jKg7ViXITIOxmSV+s2Vd38vrYcJtQDOR7KaoNSpQJK21B?=
 =?us-ascii?Q?vFpLa0rTOjP4s0/efIEmezGsjoLW237czgm/W+xIbzZIKnJZR7mumoP8ZLGe?=
 =?us-ascii?Q?RY1wgipucYdQhzregEIltJFWi45z8dRKzaSZixNbNVEf35MtMFYQuqg2f0nZ?=
 =?us-ascii?Q?pE6M6STlX0/k+bFat/4pMKz7GOKVFUbUNbzOWi8/nfb267ZJFXqJoXiPU8yH?=
 =?us-ascii?Q?qFfnWPPSbIMvHG5d7uixOLcEKS4GGXlM6Erv7D/oxWhBGbydS7pkBBGFwymp?=
 =?us-ascii?Q?kjtgzU0xCyxiZhPDhPPsDd1G49gFcEcLI0IPJRBTirLvoGnQPsk402uPQ5fv?=
 =?us-ascii?Q?fq5mVy8mBkSOv92KdpQ1RWI1NZoEk91vrZMGwQ/FMzxXO0po3O8xdqT5W3I2?=
 =?us-ascii?Q?u/3ijNuv9N0UwmgOz+Xooik=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e80a2a9-e977-4afe-2007-08d9ed0003ee
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:17.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4idCR1MVCwva+HIJeC8wjOHMYVPic3iDkv3AbZkptq5j6BA48cyfI/D2cNnQwO+MK19mGJp62EX0qMaZ4pej0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable mdio3 bus based on EVT HW
So far lack of c45 support in mdio-aspeed, at least can access mdio bus
by read/write register

TODO: Add Marvell PHY 88X3310 and mdio-aspeed driver c45 support

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 8c8fbfcbb257..946107bd8bc7 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -841,3 +841,8 @@
 		&pinctrl_adc12_default &pinctrl_adc13_default
 		&pinctrl_adc14_default &pinctrl_adc15_default>;
 };
+
+&mdio3 {
+	status = "okay";
+	/* TODO: Add Marvell 88X3310 */
+};
-- 
2.17.1


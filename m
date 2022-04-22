Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33AC50BAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448980AbiDVOzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448924AbiDVOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:03 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610DA5BE79;
        Fri, 22 Apr 2022 07:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvYgXMPP0of7Ko49lzHVGtVxQXzKW++wtpAs6u2OUz4fCEqKlYipOUXjWylfMuaBj6U7MR3o8ANLdKgIB5f/UJexRyzA4oYiYatV+eORaGc9TuRb1ik2syzkulygnyDmLenjbUl7d2FlZM+R4GU5PUgNhukyBch1jJr18xfACKgzKiGMjLDujpUuuWc/91dvrxIPEHbMWjcEUyrpHGIRUlE3wbELrMOseDn5CbXYoUhulddITBMubet62rWDxjMYf7Sgyc84bANo3gAN7uNlcckei12+OEZ+xCeAUestYfP4Y729EZ/mbO4uaQ2u5x/jIJF7KWRidlY76L58aT+FJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuEdqAkA/RqBkFNHf5vufPhgbnTFhycZdX+nFQyU9P4=;
 b=HcTWm3YIqUpHxDTg3EuPax+cigBQEYr43XlePxbaM1eNYK7n5JxHhamCxoJGBIt63A8dbnNhfJ6jyCJMoW2oMhSAxU/X57vZnC//r45PsoWobzZD6eSgiJbp/e81qYV9MdL2XUqF3Wx8TKvgLXW5dJKOl1P1g0gqoxOUafeHTYbeXcYD0DNnO3YjbHzbqExKRWDmZq/RtpEx5hHCJ/Iz/eUR5OJI5QpZ8XeyuTgKV9qjKGevBsTeumkhVeag1QcgRM+tVs9A+yVyfJKHa9dnXNkQheL/q+7iUghictgjrTiy8qYnTJKdR4jejx/o1c3ySik8/BPXX/1tUKUN6nJyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuEdqAkA/RqBkFNHf5vufPhgbnTFhycZdX+nFQyU9P4=;
 b=GBKNsyw17oNzQGJSiJd6TWr4GVfovoftUbYqqO1RM16gXlIfv9M03w747CEqBinelORdvt8fVToWp0BUqDmEBBlsGXJSgCh6lACRYJwxNbhodEdbv/YFDpvPJ2IRXomkHb8Cpz1Ve6V2uTeUunUe83i/EzWTwJVZPt01MhShcR+ciq6a4Y97j2pTwbvIcylRRoU6DtshtxfgFTk4VbrWxyCFQOugs/1tIMoSq8CPQlADCJvOYgTS6ht9gkECMvLfCpvsbHywcbd26SP4DCT4vNAciB05iO/dhmKlXgw4S4LfRAu39hgujVgMNENvxBWdpP2YR2feWaBX5xElUml2RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB6PR0302MB2792.eurprd03.prod.outlook.com (2603:10a6:4:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:06 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:06 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 5/9] arm64: dts: ls1028a: Update SFP binding to include clock
Date:   Fri, 22 Apr 2022 10:51:43 -0400
Message-Id: <20220422145147.2210587-6-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f57c6c3-7209-4b17-4533-08da246fab9a
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0302MB27920C92A7A96CB443BC3DB996F79@DB6PR0302MB2792.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbE8AugA1AyJEOe7i8T7Ur8mYtaNt5FmGSvL1YfpyGYRkCnniXoHWBMoFqPRQVmdvVxsGS10KIkxsgrzq36Ob8UPQEYwgAoP3FcE9lh53y4bUbpp03mJc6RANMBiIZvo/pCL6Op1PE48MFL3BYvIOXcHNDKVkTMWGNB4oqz1MAYnKAvwAvSDjD9h+KETauBu7M2LfkvIJDMlFidx66cYw+3gzYB5t5Q+zBU/JKgUicn5jOmOdxuGcycwSXtu0yQvyyM3oTRTpVT3D73VTYAPOY4ohhbJfcqQKe786J7O5vhaupE+hAfMOqgdCWuqUhT10OGqzl1ZeMQFbSjxZ04fgp1bnC75uYZxRDIH88m80l8twIY/9p5kHa/NulvCnBxVM4q+osQote2Wlk+dJbtKvnlOyDAUYWGHH3PmYSmIqJ5hQb7pCoSX/aAMZGqO3UF6UXx6lVhUfsDTkKURr0XNNpn13Ik+vJROmB8dH1SJWEebRXFIJK4yZQ0N5ztYvmOOdRpBFNDzkso8QoQJrS01M/3bUcNwnaL0ugRLUe0Unokax9WXJH0cLAnsSHAEo+/pRcKr4NAATlQoaF/XymbdwmIQRU0IYEC7ZpqYYb1j4v3hmf3n4USjK5iD+JnRjlcrNCSGd1e6b+jqO48BGvUMK1Kp/mgseWklwclFpmAwz9XLFTdtCm3onOGO0yGE5FQSj6rmbVjvOW80kWtcV6VQNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(36756003)(6486002)(508600001)(186003)(38100700002)(52116002)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(86362001)(6506007)(316002)(2616005)(8936002)(26005)(1076003)(107886003)(54906003)(44832011)(7416002)(4744005)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?czwSGCU7aqQWM+q+ztMqTCB3L3+24Z1qt5r854lUijzABJf1/RYWb3TUkh95?=
 =?us-ascii?Q?aUR85+hBZDdkK2fLS5BBn1m86gCw55iZZxtboS+s4JP10zjJfyU0I7eKoWFM?=
 =?us-ascii?Q?TLOtWkt5XHpq02Us10x57vOtq3SM+V0XPNcNXbVfMEWMB8nVAq6uQhTLHiW+?=
 =?us-ascii?Q?ViRXBydpgaYL/TgE4Vi78f5wg9ECr/wMWNClFnQy0pzYmGErC5h32D7h6dl5?=
 =?us-ascii?Q?f/nub7Idmo0ImYt7fBa89YVKmICr9vPL+0Cli4jFJuyqnmWcYZA8yW6Am6c+?=
 =?us-ascii?Q?5/OB0ANTQM4mHiNqfSsVA7uqHnEoOn/k0hGlVI3RW5k7VQTcPtSS74mdbgI/?=
 =?us-ascii?Q?0fTJ2wmzPP2fTJemmtKImJyVzeUuWIbdxiYsnY09L5utWpqp/79+VqkN8QGy?=
 =?us-ascii?Q?e6UKJm7z8MUzANZqXcfcf7Q9zOJ+2YsIpvh1RNfDYRz3F6/APKaMJ8+gl+om?=
 =?us-ascii?Q?M5Nxhec9UDOQYOKEZ+F14ysUrB3171ENJiRFMpKPl2CnnJLZ2hEhmbDs5dIm?=
 =?us-ascii?Q?kkUlGj6MAtvbx3YOczlP8RvLAELtpUSCVL16BjeTiNJAbK/cWLCCX5GG848b?=
 =?us-ascii?Q?ZLnMsoKLM2znfm2OuT9+ui8ZyiIvC2NgU8KdP7vNK8jI1ygjO2MoDewMINvL?=
 =?us-ascii?Q?92cWbuZAc6TlAsIo7GGKhnXOm6EWNIci4k1X1acGRMGwbdrhbIiHoZ3BX5HJ?=
 =?us-ascii?Q?HtOtKbCE1sGoSDZvXQNBoKHT6MR6oTO2MkXU+xDaPSxlfLe7zNZ2Cw2S+zpm?=
 =?us-ascii?Q?MJ/MBiCRuJwtUFRjsAqJ0tqTQ1pEIf+a3J0M9joCJDlGGI0M8A3H+3o598ij?=
 =?us-ascii?Q?qmBS1BTXCZfaaEVldad7ZXA/CzpriT0qUMTU4ht9KLQoWU6aKo1IfmGizdGS?=
 =?us-ascii?Q?hYP1tqtxEzLD4CBybdAwdRvQbkhoNKNiwFML9rDz8OhEwqSxy7AgHcRzTzpN?=
 =?us-ascii?Q?fLdyTTYOZlK2DLOKrIYzjcS48LI0W7LHPRLE2xrKFH1FVe8dlW6PyLDdddQ/?=
 =?us-ascii?Q?3soQ/lCPc3TFbPkI+D0Ish+s4j6AhmecOSfXkTCX36PhfUTNLWevBizHxpln?=
 =?us-ascii?Q?ays+zuusf/sCCmpnsAZCznwLKXMAB0sVPvQU2YVRQdIzknIjAlyYMLV07bnC?=
 =?us-ascii?Q?F9AwDLeKA8uZHsDrZDykLrLfjFI+aO5IxGseo8dQltexR+qZbap3bgfZH9Dv?=
 =?us-ascii?Q?T0Wog/rhzb5BbouJaHnxKn0BJ0chz3SmUyy/Sv/mfSIgoVtCuIUtCOEH+SeR?=
 =?us-ascii?Q?mqja4CKu4Rb2WKLQ5ICgSjZ8g5LE1Zd5r39bxCt5S22rHwCCtVZRbrfuz9zg?=
 =?us-ascii?Q?gdTmhU5BDh/k5PgFyRl8TTqIyaCiHIMtYy0T/w91MLht6/db9gOO86E6ppmS?=
 =?us-ascii?Q?CLwfxDIqgEMTyyCtsDZvA6VXLto60fQmm1Y48WoeFnJqOw3NdWlYIhC74b3U?=
 =?us-ascii?Q?kRECT5kqdGxkkpi2Qj20yz+gABZqm39ByBSgDBMbZGLzS8uQuxdy9Tr1mJ/x?=
 =?us-ascii?Q?mvdbN4oBdYSOoyopYbtWR0Vcku3zmCd6zd2e+lrk3K/Np8cEwS70x8tbt6EB?=
 =?us-ascii?Q?C/ItjdTb9w+fTZPWBmsMqN4u8AbWiEe51zPysOF+Kg5YS2KADUhcU6KJ1G4u?=
 =?us-ascii?Q?r6uT3EKtBlLkbYWEAQjmpHYvniHWe2qT6wHkpepH7gFiaHw5AvRShLyCLtY4?=
 =?us-ascii?Q?+N0mgwHOuToVjXRtFhY1o5AcuKMxCULrgcS9GtgMYyBiLtJcuTM5c7MHlgOm?=
 =?us-ascii?Q?wxElCQ123agqlz8K9da3MevAMtI1/vo=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f57c6c3-7209-4b17-4533-08da246fab9a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:06.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Erb/SXN/pvdNGtprYSc3aRlfMY7ElV6LSMBNKZdTcxst0SXKGSRho1dMjdyWRUPxUc4RypVEr57bKP3J1YBGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks property is now mandatory. Add it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 088271d49139..59b289b52a28 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -224,9 +224,12 @@ rst: syscon@1e60000 {
 			little-endian;
 		};
 
-		efuse@1e80000 {
+		sfp: efuse@1e80000 {
 			compatible = "fsl,ls1028a-sfp";
 			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.35.1.1320.gc452695387.dirty


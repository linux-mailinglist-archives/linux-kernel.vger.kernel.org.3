Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21FE4B40C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiBNE0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbiBNE0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:12 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E224F47E;
        Sun, 13 Feb 2022 20:26:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIZjl6cL0eLRIdyojIx6pqomb23exySMdWvWzhMBgpE3A9m0BmjPvlnFwCoOpX7rCFkot5SN2JwnffIQc/dhmITtSWMtpqJLtJ9b4oYqsFsJqnGNu4RFYue2exOaIzXno6hdHVatYahkO+1d994HvVSx0JMgpQP0kN3IWJzofB5zQ0mGGYwY+b+zRuIDfi1nJDgo71uC6Zky6v5rvp5V2mmwBR0Rtu+g/PqCdJe4kGG5RvUPSnJmItKJC1iUj3jxdG0Ryk3SvHBGJ/PbMv4UeCrS/o70KMxvp/TJiMWucYITVcO8apC4duUIScNYTIaaBMdXDULpO6MmdHOZ1peTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpAZh1T7C+POkdbs/YT2d/ls+QvRhT3Kw33SEe6rvw4=;
 b=kHn748Z1HAi5Fv/rlbmCnPeyJn9e+70cA8HnNs/48kpM+wV66+xxepXB39qcW9dY1S3cFr9jGuDzRInNQdmsSPk+871SSytHV2cG83cD26pH7JRui8VqVLbw4Elhpr1vXCzVPzLb9zPWJBr5sH1rJLEgELu+dhlY06zE0saE1hJPDrrdjbu6eTAequcEpXrhIbDRuj2UVhRU7kgh3TQr/crG2bcitxl6YlVMyCmoYlBpTuU9hxs72Jx5J0c/QAZ6QpQXJvD7QOua3aN37E+H1iEBuW4DvQHhekTXwrV9WllNpnnK3Y55A+AwC2jgowh8XKlSI2OpJLD/yCy3XqjwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpAZh1T7C+POkdbs/YT2d/ls+QvRhT3Kw33SEe6rvw4=;
 b=kFr9zQBmlNcRW2miBy/sOMc4mQhMoh3R1vVe3O7doJFh0tzDUPZJuf/ih84o53istZCIjZvh2099vrzWXknGOfviWqWMia/nvyLtlbwXOYDWof92HNLDZohj+f+gxK8BYnmmbTo2VDLBHBYuqNxILK2wdkJQZP1HGb7IJFv+p7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2451.apcprd04.prod.outlook.com (2603:1096:203:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 04:26:02 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:26:01 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 07/10] arch: arm: dts: bletchley: add shunt-resistor for ADM1278
Date:   Mon, 14 Feb 2022 12:25:35 +0800
Message-Id: <20220214042538.12132-8-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa14381-e623-40d2-9ccb-08d9ef721b1c
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2451C591FA4DD96717D090CD8E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osvF55KLNhAMLrEYdKHQE+7M2WIM0MKh0uRiXe/lmwh4Zw1AccuSXsb9q0JHwkHcowdzsQb4nlhve6kZSGlJVpSr5t85sureOMAi9GdtZ7DH/zpFENepAoLMLIvu+Utw0PfO1SFYK2BYi69R6P5VpfHxaWXxgI3RcwD8xe4jEDV9AdvQ+AbMCzS6BGWLKGBzEYfMnkWOyo0Fd9fdjmD/IkaYB73f3fFMSFdSCqzlPVWZJnt4bNUsTcDlhVe6SwfRjwKAs8g+dTq47HX03qQ/iNXYYrjEpyXxZjre0klwGy0IbitmCLv05wl6wpccGnGq+feNBvKGTG8jpg7O1+8YKF9C/uApSMCHBAYDDnGXaz+u5T1nRqRhDLYFuQzS+cxJ/AFmoBqiJjBuUkowV1FM0dZmaxb8CUMQStXQCzPn/dC3r9qPArn1U/lTKRR/5hqA4wyADxCEekYrjh0CZ8OTp0d7rKBKtssnYFNwb+BLez04MyrxCp8lXm7+9dG7fKlg9plkRkpkS7MNN3dNQwRxagHw3gtJ8AP3uW9T2UpqdmlGTTWmC15rO86j0yqdIIMwamJXv48y/AMhCV81RZNngpE35O3+TIsNZha5mYSDq1jizpVwxvDEsrH1WR2ts1Hir9zQHHOOtjw9hLBYf1AZq5diwXbNq9g3STjpil2n7ZNABW1aaaX4g1zaHE5yD2AOnYorKq4niJcuPJ2WEAJxfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(4744005)(38100700002)(38350700002)(6486002)(4326008)(8676002)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?255ZqgB4kE/uk0SJ4sPJhcoJfqqwrA0F7dGLx+U7N3cED5YGZtyDUzlAsSVM?=
 =?us-ascii?Q?boyDp0xwPVYJCAvcm+jGC8sfMUOlyRTowTOeZasy1MVtvL9UreaAfoMpfFvO?=
 =?us-ascii?Q?g0eaZ8Vj0+4cGy/2Qr0W4AW0ZibrEMGDd2HFk6sDyKdZTwEA27aaeWvn1vDW?=
 =?us-ascii?Q?sKGQd1kkVwzru8UE35erCeA0fYflISsRPO8fPztYwhs7+eDoHB4QbrEw31E2?=
 =?us-ascii?Q?CvKw/ruU04RBwmhTJ0UHBHYMTOEbaASSxQaDmwIs6ASl6BN1Q1ngyO+ZC7Sk?=
 =?us-ascii?Q?zYFf25oXsXpazos81fUSr0IFPxvqtCnXt5N6UVB4RMo7c6LsQn2TxudoOxXc?=
 =?us-ascii?Q?IyyuNjd5FMaDebFuVKnmejuNERkVJ0vQJDPsFGknGcfRj8iSVwnCZA2L+LGG?=
 =?us-ascii?Q?ZUutqLHGz5g3RIjgqmqIAG7A92OYruNszgbWyrqkmQrlHgJ3l/RLF1W/iCmo?=
 =?us-ascii?Q?HjX0PkAKzDRmumLvyXDJgJ7qZn3a4mhUQyfpoPZFh7P7mFfrqplgXikO9TmX?=
 =?us-ascii?Q?VCNvZZitVoqdOlTwSwT340ScK9OGnr5Jf1ZRG7umNMLg8Qqglk/2kREkH8Ke?=
 =?us-ascii?Q?sidGmY6h+8pPd06A8yECXeaKZsNr2idnvQDyqpH4tgTMmMZEtqtqye3Uun2P?=
 =?us-ascii?Q?7gdPjOpfkhKzaRTQ/XoWhDFKXCQaNdYei1CEZkvS0YINcDsORR1g4AI6jQnD?=
 =?us-ascii?Q?Z6MBokGfOQMQBOFoBObch/B4DFQ1qi6rTFnlO3AdqTlhoYOCCMLTVLh3Ja9H?=
 =?us-ascii?Q?4qCx9SDpBLWZvSDLQdEdwbvTZ+Zt9RmvuhgmDwWNaI8CJvyDIxU8zEjZ6fEa?=
 =?us-ascii?Q?S9/mFSTHWOZBAgxs7G/1IbGaMlWsDqH72FGiM6d8RxolVKLF0rULikS1mLeR?=
 =?us-ascii?Q?YEUsHBwlpjvUYiBLCV4Et/WZYT0Hd5ojDmbZ43ziJm5tpkUxezSP+Ux0VucE?=
 =?us-ascii?Q?jpDfkAa81XypMvBBrRmJn42rFPEJNjnVm3v0cpSMhwvsn3DETSLfh35jQOjZ?=
 =?us-ascii?Q?XF52m9lg7Kdgy02YDJIRjOh+8Lm7Ke+qiJppN6a4Slf3BlII6y9c4izhjehs?=
 =?us-ascii?Q?1li/sE9Aa09SC8H4C+xLQqEj08ih/kAefLaoq2GUBMu1PCYu7I3HJrK4gJUi?=
 =?us-ascii?Q?wPApDo24sPsF+YQsl57gQAgp3D3/p7zDHgSIdoUsTaA+nODj153s7KG6oEs+?=
 =?us-ascii?Q?3paia8oyCNXLSDHs0JH1wjZWQxFaKYItxsukL56TiAP7ueJ03629vlt0HyC+?=
 =?us-ascii?Q?7GsFIfXnFUK5tPLLvnNcg9epCZBdeZ+QVXgYPNQIj6qsEDoKs9nAHNPA+9/6?=
 =?us-ascii?Q?My0cjTrh7t699v+eWOb2Ou9GQxpV8kqfhplbAGBqWAAKEInJ4uHhyssu4UlW?=
 =?us-ascii?Q?rmzZowf00wqha08gCsR+UhuefhLArKJSbI9wOAqcxkRE3AowS9/JjtUd4d96?=
 =?us-ascii?Q?DfSmIeukuGPETwTUKB2pmw0BacZMIY/4ljth3HlJw4AbeYJkQ8MYV2aejgbJ?=
 =?us-ascii?Q?YC9c7fgz5+hG6FGzSIostbKOj03FDeW3PqaqflNl7KuJsoRGkycMPD1/Zctz?=
 =?us-ascii?Q?1+RtxCvnfXZCYUEydqgSWXcxhR3JYWubmulQ5CKU22ELUYP0RaS2VF8R5Ocf?=
 =?us-ascii?Q?azfS69f4DB4p8NWrYPaCGn8=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa14381-e623-40d2-9ccb-08d9ef721b1c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:26:01.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/X96SRbQdlbzvpmY9V4ySzUQaZou56j/rWxcKhKyFWJTQ3/3Txh/3kSq+0d4y8CSHPZND9rrArRF9fmn7jyzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix with correct shunt-resistor value base on EVT HW

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 8afaa8f52c38..76c086ea7b71 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -715,6 +715,7 @@
 	adm1278@11 {
 		compatible = "adi,adm1278";
 		reg = <0x11>;
+		shunt-resistor-micro-ohms = <300>;
 	};
 
 	tmp421@4c {
-- 
2.17.1


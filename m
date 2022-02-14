Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C32B4B40CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbiBNE0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbiBNE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:15 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C624F9C3;
        Sun, 13 Feb 2022 20:26:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqeWHHGWHYkoLVLm2HdAqip2DqGl76667D4IzBBThT2PKSipZZjcjmpUPOxmKcNMe3AXGXNALWExm8IYmaQUoGGV+PBFc9XkU1rnkJ6AsIVsRhLtM8nB67qXxa822+za0VhRsSAXVkPnGAH1DsS/8Fs2ET7z2f8Sq34RQxZFKXXpksPlEDzsMBN5E6CECMqHjYCcS5a1tWisAj0T5ynwnzo/xETQM+zxpLkJZcW9A5NzJRr5trtgoUsdREgKIPU7ndBQawDxOv7AJIOOXWwweTRwajk4h6sqrFEhYqImq5naMO6W0IXHt20mzg6tri8hfMMy6I8RyKBU8GispLJrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+PhkdPbF9OOYJcM+200PXMui6uN8XsO2KXH8pDU/qU=;
 b=eQ2PlFHOBXFCoUJ7dCmGTooxIBikRGEbk3hUYg5V16NzIZ5IuzSW066gKpifmLpPeRGM3hF3hMplui+MRC5J3nQ6Rvhq5TPmRG/4x/Rdj2oEaO9BfTRfC43r57grtUDENwpFoISHgMH3zglNXc1wG5/1bb5UpMYCJRcCEIxO136/Od15MfgvPmv35Ve+zitDpMVpDSIU++mI0sjU9WeIdeTzS0h4367C0OxRHWBTSC9TytGwthw65JBJL2RNvkEaBF3j0Jwu9bJNn/560et1UwDHx0Bt3HfdBrjCAsODdUSzS9rGSw3nJJ2Lyr+zvv2hOnHcYGMUsGMB1JzD8i3dWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+PhkdPbF9OOYJcM+200PXMui6uN8XsO2KXH8pDU/qU=;
 b=wPDxF5YbheCKtWc2o65nP1dT2o8TjPGySjYpn0m+cDowg3bnM3SYGfp1cL+4NerWJkzRfSzk55vs3ga4jufgFGUbPrMorXI0xh4KklLzWYVJ6yY/2ioCZSMtUC5H+ol30v1tyk8XP8oK3zUQpL6jmTJZIDMxGSexnJUFAYJiYjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2451.apcprd04.prod.outlook.com (2603:1096:203:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 04:26:03 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:26:02 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 09/10] arch: arm: dts: bletchley: enable mdio3 bus
Date:   Mon, 14 Feb 2022 12:25:37 +0800
Message-Id: <20220214042538.12132-10-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af83a549-ca79-4b96-08d6-08d9ef721bcd
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB24512DEE62DB105DABDCA32D8E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StDHXGAC3DK8czWUrqnM5ZJmn60rSWifMFHT8A9G/oID/5N48t+7oFl0y/3fDrZ2iI5h0/kjqBZUesYNreXCWq6loFhD14Et9tCD1tZob48FJ91SIlBcZCjSy3aFiuWQDDLClWQjri4oUl9cznZH95tcjORVtUnu25Css1ZzK5tsSgTw/l4rsn/dpv8mk2uCemxxReKYl81oIt+tTZlwy87MYRHNMBwghuVPaDW5CLue/2noyUzfB4rxcj+XxjVBPKMpHzhwJ1XXdyK/Vj1kIV/WHnmCnm+urr70yyFzDoR5lIf8kBKkzcygniw9I2bfqn3wg+ze1Nwzkrugx4i29DfOSFLpzE/+1DErb/jvAiOT3XwIbzRizEbgWZppOQWMi7mjXVHlVH+tS11+GyYtZrfrn0qIGoPdh514cbDWloy6PqT56ZiiyNKW2pdxzFNgd3VP7g62PRDGngY3ouMm4ng5Jco2ITtWfrf6ufBdjVlEDKnMDJ985nCp4MQ68ZG/tKnJn0uKdawFAEs13afy061zFuO2GMtc2ejSLYt0I98KUvOuypEEnCBcNlQIOcs52GydQcXVjzgwp+Y8IZDCqRvRWX7L+auyzWYHPtKLyzFg6EbNntI8quXILtmON+L28lro9r863o8taMVC62aCiyr1gzJg456XaTwaqpqttBkd2pqZMShh6DsB5WRFcDUy8rKb/S8llc854VlbUns7xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(4744005)(38100700002)(38350700002)(6486002)(4326008)(8676002)(83380400001)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ftaVhvKvezJXtunoB6TzC5cJj1s4pQUSbdYjaaWnDhcTUoD9sEr58i/5A2VV?=
 =?us-ascii?Q?kRXLp2D3gklEWniZyjgPe1lSsf1CBpO9syVu5YiPKb9ByNDiRgHVyeTzcgam?=
 =?us-ascii?Q?k+yaJbnYIe0pr7Mk6AW7MgzaIBg/TV3o4/gklcrnJOO2wuLuKabJCMb5Em2i?=
 =?us-ascii?Q?/huUhRjx7Gs2sQo3tMsUMATkBYMmDVncLd2mHgpdwLW23eENkaGGh8AFSVxc?=
 =?us-ascii?Q?hzuHWOF7h6jx6THgTFAwI54JJpVpnaa/2qxc+oWcMHhWnY9hn8xd0uc0MMAA?=
 =?us-ascii?Q?3ixUeyt365hOPEGcQUKQdV7tVnVDQ6+aiYxuJ+1IsAdNlh3MHRCNWSAaWlVc?=
 =?us-ascii?Q?5uGUS+hfWkrxNCraDIwgY3+TiDOrZx9hjzDisKIl7uned7/FXRhbCgBR2v7o?=
 =?us-ascii?Q?ayGJ9zO0SAMcl+YuehZX/gUQLccpuK26tgUvnzZuNIfGaxXueqwOkuuVQuIy?=
 =?us-ascii?Q?JJxPyDgXDcQVptC3+9dlarPMwapd/mWfdPl4ubzQd31Xkyvck+dqozpVzOO1?=
 =?us-ascii?Q?EuOhEAFqifKI3RzU0AOClKXK4yiNF98Dx2Us41L/uk0wursMmOn9Cuet44Vy?=
 =?us-ascii?Q?YQSP7Pv/I3CHqxQstY8eJEBmsaHomrhgDcaAl8RG0YOaCJdaIYOuB+iDlD74?=
 =?us-ascii?Q?yOGSZJT6inAELnPqHzSFrelXlVsnK8N7iqsoCMImO6SJhjBH5FSAxVChdA+I?=
 =?us-ascii?Q?1lfXf4/lHQXyMh1J3a4Mucst93yMYQEeiPZLhhYklaSLmdxtWF5V2bGDCLe0?=
 =?us-ascii?Q?Etof6wHoq3oPSCc7Ytl1oTKVcc+vJuYPnD2Vxa2dc+wAPTiAHThYqvFyeKOv?=
 =?us-ascii?Q?blwrp56RwKSE4EbyVpDqW6J0ognqcaZNpLYBofOPerrbL63aqDhnQS+B2Xt0?=
 =?us-ascii?Q?wcmLeK2La3yCm98nPPZFtSKXyNGeR+xTijRqOnfTbR7ylZXeIlE1HMNaFMMk?=
 =?us-ascii?Q?8uA8uC3wGHJ81Pua7R/6uD4MbYi155dVCRCnZqGfN9SkDPw4UAvsajj2tNDE?=
 =?us-ascii?Q?/2HpLNSD5e10XtDWxGxyDnhjeIPmioEizNNK8sW8BODWbhCleF+Mtp8Vm5DK?=
 =?us-ascii?Q?2vJBedEczyWGIqn1Lju3F1C2NtcJv+3rG4N11YLPdHh3CNtiTXovSVHCU3WD?=
 =?us-ascii?Q?31QRXxpo12//+aEv44VxZu/ehrxv/4/M+99LA4x8wMrbSclToNLtXwur7TkQ?=
 =?us-ascii?Q?pX5jW39HQ5tobwdiNUzR/6gtZvI4kzcOzu+K8sCwGLNLNYxXYuzW7WeWw5ww?=
 =?us-ascii?Q?eYHFctd+QOYcMILQ/TAJ33VjeA5R/ysZSYvPKB848ypIWPSMYHOsjqgH/Ria?=
 =?us-ascii?Q?1XkVXen/j7d/9WCeo48oiugk8vavS0TRgYx54c+kDrTwtIdiNeo0Y1NBZgIZ?=
 =?us-ascii?Q?VsPVvn0XSrrZ3WIZ8fkr8hcDQ2jvIKhT66UIZFXH3/D/u4O6ATxyTJTxnZxa?=
 =?us-ascii?Q?tABI6NMTd+ZzTFJoIueukiroTyy90qVdyp0tvptPvFNTdFWbskHlB4Fnz5wC?=
 =?us-ascii?Q?/krCjgKKp3QqhFaLu7Urf9uzFo4kkRyWb9rdcvUxQJ9B2owd7NjHqxonhKWQ?=
 =?us-ascii?Q?gBQcVS+MUfstWdJoEzk+yjAzjV+Pk5mrc+CEysZBxN6RRYoLYvkD0qsYMy3O?=
 =?us-ascii?Q?Ed/lCH1fTozq6+lnmmlHkq4=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af83a549-ca79-4b96-08d6-08d9ef721bcd
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:26:02.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qhw/fMCsfKlBl23mKWfmqTM2sxzXRK6DiSdt7SSygFfIn43WXh/4RpqGriIsp/Eea/i1ZJ4iI9JHPVU14hJdvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
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


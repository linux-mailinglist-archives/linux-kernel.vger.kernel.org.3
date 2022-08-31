Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD025A7808
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiHaHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiHaHsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EC3C1212;
        Wed, 31 Aug 2022 00:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJy3aClx6pat21iPD1ygbHkEWuhPTl8bg1oP3bHiym1lnzL4Hg8BhKH9tRY/bwu5Fs8XmP0Eg67v27z8C07QJIwuN6uig92Pf1XQQkSgO/wbi++PF9mXw5OurT5BHcncInLzF5ijSiLiqiS2k4B/0lKP42DS2flE8IeunTy+DFe1rijS7br+M14fDo4wFudGgrG7p3uNRrbutDh9dYXbAGdIQPkLas7rD1/PW2cyKWPxBXqM5uHXFWbxo+3K8CmZsv/t3n8GD3xF1yokIeF7sQtAXGoEjGfxqfctSrOwAFtaVpdDjoDQx0VT6J8xGbUuefB+9iuitv7LQZF5D70kyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJgHxlx+oINKviLPDODGZJLIoFlVYSAARQA1N4UuQaw=;
 b=UFDmFcNn50IRehObUEdcKuktwQ+AynonleKHGzEgIGY6392bszdpf7EE3TqDfIBKUE9zst2AhJBnwDwUyNpAMlLLpl2Bnhj06bZrk9lH0XA4E9vKCKF8q7ANvK0CsJnG50qwKMTCKYT4FDfgTi5EIS2Abgd7GXvY+MWkabPRWNf/LMxOkgOu0HFSILN8GBK4DuHXLxyHLi/3TTWbyNLY4aTSjUmOrQfqFH4/h1lU56Ih8x+8+4+oZ6pAmjB4VzbNl+fHTYxf7ysQ26P3HBEllImyLVjZNNHeMeF7p/LwEqaWvCZr5TMtn3RJyn7tglashdGQ6/L8MP7+EGmDZ2nIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJgHxlx+oINKviLPDODGZJLIoFlVYSAARQA1N4UuQaw=;
 b=kDKl5jfMQ+1jpsIXdgD56OCKjOp7XzkKySJW4rOjvsLm3nME50+SLwcg9yMXLt2hWCNTl84rWZvZfytdghhIjN5SbtOdv6SNRqaw97h/HO+l38J8wHBnsQGXa/k1uRYMWT5uZCZii9PF2JWSxicMW+fo524H3TNCZOrQwNSQyW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8001.eurprd04.prod.outlook.com (2603:10a6:20b:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:48:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:48:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 4/8] arm64: dts: imx93: add s4 mu node
Date:   Wed, 31 Aug 2022 15:49:19 +0800
Message-Id: <20220831074923.3085937-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e411ef-c13a-4e91-98c4-08da8b252799
X-MS-TrafficTypeDiagnostic: AM8PR04MB8001:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiq9zJ95AavL2EIjDgP0mA/dNgFklwbV2mAt0NXZGxfOYgQbWH8IV3aJiLEJ6IOIQ5+EgtHysue9cXY3IRG5sT4CQ9gB1K3XoVh4puMHq+S03fwtmap2FbIJ9vDleJYTubI/WeLseJuO/s28opU6oCwO3p8pk9bT3hZqzdX+oO8mibJUr40VdJd0QiDK5iUKeFbm+dSuej8VzUtfgBqsu+UsHjI4MGGtaIE5EewWyhFEn0M1hmFAWXw9EiluGvjHXrLKgFmniccsZzIeg7R0tlKFVlqw4zDoIGAV05uSzjtgiQF4rAn9kAv5IpxsR7JOncFiBkbzzGpoURZYGILo52QLgWTXsf/Rx2pIYbCymc70Rw+PMcP7zo3hRQVLYXKSFj8w2qdPIGDZnnyKcT8DM+26PLbQq0+BHvT7z9R3GvgcZbCTGGxoKw1mxkFNjm33dz3KjgZx0NNfQX3a9Q7vsaT9xxh5LVJ1CsW0wx4GiopiTwqx1HSa5Fzkcjvm+EP/OS33jnRx2v75rA3J5fmGSrIIGa5Zu28ktcxenlVf2ptYxtWZJwpS37OID09F6onNlckHlCTXXWIVb6Rvwz5Vco2UMNOUs3GyZkxX/rp6TBH9JEVqGHmaxWGKvxmJDrfIFsnBPVxSDrtJVZUXrSZ9WeD1mYEgm9mi+DwB+4bz+WbKzpBktd2nzImSviY4x7EtCq8yq81AOanoZ6PYXfiL7oygSmrbYbiLK4PuBnYP9RkEGeE/JCZFejgmZikl4AX4rtwMhhUf5jk6+0AyPDfiGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(83380400001)(2616005)(186003)(1076003)(6512007)(26005)(38100700002)(38350700002)(2906002)(52116002)(6506007)(54906003)(4744005)(316002)(8936002)(5660300002)(66556008)(6486002)(4326008)(66476007)(8676002)(86362001)(41300700001)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YIdWqnd2IXGvGVMBAv573cIk0l5LNe5DYrzBoM7xtRf+ODyA5YGwuAzgCP9f?=
 =?us-ascii?Q?IinMisBbq2i0KtaVqVHrUvtPIXoOO4SQTlhjfVODNWHL0qAzTtaFozwE5sIR?=
 =?us-ascii?Q?kpq9NjNTFDFrGyPflybvrrDiudX1xgn3PFVPsSjut4nUl+ie+jOVLI2DrDWB?=
 =?us-ascii?Q?7A+E56qLxZg9bbVyJTyxkI3pkfCK3foP3+bGVLbYlU+czxU73mpSEZSWA68y?=
 =?us-ascii?Q?Ya4OPLIfHP0X1Yk4EybHNhYOF4BnqFprP5Ba5XUgVoXnM8eJ78KkWvQrZVw2?=
 =?us-ascii?Q?o7UIHRgbRXW2oYdIbzSl2vcXo9Ic2Fj8jvHThYuXXyazuW7P926/I1Sa9WUG?=
 =?us-ascii?Q?bhD31/RvGvuuBw31rf7+O7lkOM+YbZmMg4NpEJgyqcyc/0RG1fBetStLJYHv?=
 =?us-ascii?Q?rqdwdFXN/2tXJqGSPo3saOlnL+vfKjJA2P+SRT6Jgd55/ozbqmo3j/N56FjR?=
 =?us-ascii?Q?KbD9oKT3Z7UD9sqsvav6U4gdBCN3cEZxFXeaSbpDgnefU6hzQvPC1AZDBXca?=
 =?us-ascii?Q?QCRgtDlrpmKDwSod/6JJfJvfX8N1DJx8lX3W9uY/T8SdK7uhgIjxr4gXW+hF?=
 =?us-ascii?Q?Urf/iHmXIVqD+v09+5OL3JdG4FqxG5cKYq2tYrKGOWVNSSIH++KJGQ5fyIb7?=
 =?us-ascii?Q?9s+nNLSnV0+rD1NVHcvNNASzMtqQjEkujC/gZ3fLq1FF8YYSsFtBOhQ9Wxeh?=
 =?us-ascii?Q?eQqD/l5oViy8UEqdlxIOcRwiAqVgETEMqjcuzJkKPbr/Qoiii0NvPGyNj4xX?=
 =?us-ascii?Q?n3cE5U9MIIG+c743PNiwCBhPopCMaTRpy5ujEisFooKggJTYqfatXZv0bS1v?=
 =?us-ascii?Q?tvip3Gl9FSm+9bpbLAf3SjaJSS5B2UuvxC2w/vsl293NPV2BcNZzTcrw/lxZ?=
 =?us-ascii?Q?esPjWL1039jJ9K9TtL9tHyedPCWKfO3hdTYhrsHIMiReoMEppM6tuJbh4mI+?=
 =?us-ascii?Q?gOm1L4xSU3YZWZrSg7n88h9duFLNMmCGL3ZPebGiHUtwfIJzB4624CUHQCsd?=
 =?us-ascii?Q?63eOc53TtZ7H8o2YV0/SbFfsRXaRSY4F0Xcreu0E8XdClXQ3Hh1dSfO5zErc?=
 =?us-ascii?Q?d54bQ57lOMmAbfL7vJx0PlqSNv6Dayz/BL6rRqYdETzDwOeo4JnmgBOKEmkF?=
 =?us-ascii?Q?/f453oWmrQ2/kHEvHy4VasBmVX51CvmAazp9jPJvvizb9r5qIMar0efuL3nV?=
 =?us-ascii?Q?ca/UXWw9saFwOW7i9FKz9j1At/z0dM73CUm7WJdIpy37ohRgIK/A5clR5p8C?=
 =?us-ascii?Q?5+od4CiqIEisreLVh9x85ODLuTaUUA/xd0WLIiogxtCKzpIqlneQOvTZI2TG?=
 =?us-ascii?Q?7b7I5JIWxM+wvWOSPwXSszGkJhaUSdYrKGXxbrJ7Ey7jgeWr8kCBqCXXKkYP?=
 =?us-ascii?Q?r5qigVhGWCyeunU+OBRtEbwXygkKFAmkxgLhUf7Mf3aOyiKXJB6nZRKJJGu3?=
 =?us-ascii?Q?Ip9gXIvqq/nlrLCOBYdhjJFQYjm44OlICMGxBB33dPW5YM99i3+dRaOSBSWj?=
 =?us-ascii?Q?ck4hOwT/afU59SpQMdcZVSYrTf526JqUDUlBPJ3Uu9wiTuMvFQnn4pQbCOiz?=
 =?us-ascii?Q?f3uhpt9HdS5rhXMNalIPZYEdQXzDj9mgI+ofRkyf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e411ef-c13a-4e91-98c4-08da8b252799
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:12.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x56smQMvN+L2Yf4BOz2LHkkRajIxsEAPRjn8Rjta8DOyCJcu+VJsTHqCsAuoCMaKdWUkrAXdwtLtOLOy8HtE7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8001
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add s4 mu node for sentinel communication

Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 26d5ce4a5f2c..dd76472ced46 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -342,5 +342,15 @@ gpio1: gpio@47400080 {
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		s4muap: mailbox@47520000 {
+			compatible = "fsl,imx93-mu-s4";
+			reg = <0x47520000 0x10000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "txirq", "rxirq";
+			#mbox-cells = <2>;
+			status = "okay";
+		};
 	};
 };
-- 
2.37.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9F538719
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbiE3SKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242378AbiE3SKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:10:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE8A2077;
        Mon, 30 May 2022 11:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVAqU1WgR0iaRUgFuI5LPTJWHfaG/yeXUlWzKg1sYzGckeI3S8LUGI8sAFX0s6FLILPt+8391+TMcTbGFTM1U9BjsLqjRqYoT+7gH5QToWNWv3QMoRmm5C8EbuF+YNOTWzgO7oYCIRpmj9bCtMeCgkiKBS3/PTdfIpLynwfUQuYKgROj9eJw5xrS4VkfjlQJkIloaIYctlC1+uLR5gMGK+GGE73jQfuz2LEeTQVx/00GFfUyew/jqvxL4vzn83214mEmPUmkmadOCaia3dOvxS2kT4VTK950aC67sISHHSNNcjrzjU6qQxVP+pA4KH5qaw270IHOrEZ2rmvllLMlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xr+sOpLspTWoW1hqbrnxjODG7nLw40H1+o7jtgPHss=;
 b=nYHoYYh+OMzrfivG5vih14MxleU79L7WBEqm6M1PAJRDs0X0LsU7QgMHMIx9QRWRvtwdP+21OVP3BXxtxTNXy4n+E7qrRMJgmS8IlV5Z2AVQ7XhMENdrmJ+VsNzTBaQE/pb00Xa+AHb0vGlHjNSP6VXiFSmgshcVJgp9IF3AeLBHSv5xhjhrWt412Tu0ZbDxjK5iBkgYP/xZx7w4MpOU2JWqJCpSY0JDnwKCsHJfbka1EhryQvt1U6w4NCbP2k7GtzNm4Hmx2qAkoSPjpcifZcxyrRhmOUtB1gf4xe4y9wWXxEQBeijB4kLZ0sY2p9z8vgPCB0wgDjkLXR4S78gW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xr+sOpLspTWoW1hqbrnxjODG7nLw40H1+o7jtgPHss=;
 b=sasQZQUJ0PjkjtDZrRjVOHMlhBz7dB9esOdaMw1syTH3mMwdiojPSwbKHEemS5PD+8yDmCkQtzVqp678UMsKrA41yN9NCHcoIaQhmhK9MpqDWKOCNKIdmwj9NfXPLZUiwAN1kZ6SJIwpW/m1w83wrMJ9XD+/V9UDVIttPn+j+eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by VI1PR04MB4462.eurprd04.prod.outlook.com (2603:10a6:803:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 18:09:57 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d%9]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 18:09:57 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     horia.geanta@nxp.com, gaurav.jain@nxp.com, pankaj.gupta@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        silvano.dininno@nxp.com, V.Sethi@nxp.com
Subject: [PATCH 2/3] arm: dts: imx6sx: Add entropy delay property
Date:   Mon, 30 May 2022 23:39:23 +0530
Message-Id: <20220530180924.1792399-3-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
References: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 708be761-7d7f-48c3-eb60-08da42679a75
X-MS-TrafficTypeDiagnostic: VI1PR04MB4462:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB44628DF605ACF2C3A1D68477F3DD9@VI1PR04MB4462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: da40yT6iDy54u7lyXS2QOvqICygB9r78vvj2QI+9mInYRgwBAawkxALPJPcrAYGpFjEoCYdwiEr/6LGGuPTf1SzZwgeOGbDqP4n57Dxn3hYKei/nWp9WP8L6PklQ2V3TfqkGSeBO79Jhk1daJbIZo+P86G1THOOQ7upeIYFbbVYK6B7THnkYCwL430Hh8O5zUXDL/eneDQM3eL98yIEyWRw3rhBYVF7YWjr/deBCv6xRDEAoEsCzLh7dXBffT1ZxHqy26RxVeL/bK3JDkzuBsDirkcJfuHhavJJgUNdUrovQN2WKEJqHOsKEEcO72lLxYFV2gCD6Uc+LLUpTzjZsMJOjYNCT7fLM4r9gXB0IOboe0KGyXzoQifZUyS++VsY8vQ2gXWvlCXmHJf30jMLTqWbFGCs5/ny8H13pp2Ri0ZG8yWvk6nQn2K5kds7AhoAMDN0JP68q591LA7dadYocv7WRgksUtc3ILUCS7/RpCiISwIhWuV3O6/YzRaUAp2TrMWaIixK+z09+ugHfyw8KKt7Wd1AY9jSrF1cGE+kCyZC11mE7BlRZWhlwNsjDryBIz85RAXgTml5bTXs130xXZ0Osx9GlDN1ULRDM7oPljqgHOc8+07uvXba4bNzG3hmTFlxwJ0bFzk8zKx9gYaOJgzNXlDmsTrSK+EotZSju2RVeiN4X9kD0ra6dD2hgdbCJDfJsPFP7Ida127dcNZhrUXL/hiHXbVcXD/94tLX9Jwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38350700002)(8936002)(36756003)(6486002)(508600001)(44832011)(86362001)(4744005)(5660300002)(38100700002)(4326008)(66946007)(66556008)(66476007)(8676002)(6512007)(26005)(6506007)(6666004)(52116002)(2906002)(55236004)(186003)(2616005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQuVTbUkYeQ57wauIgxUJcTnjTfG9RzfsWV2FdFJGQ45cPdOB/y00MtNkNcs?=
 =?us-ascii?Q?zaMC0EYd+JfI+PGauuQQHPuuaY5i1e6jUw09dRibHJUwkZB8kxCuNLbM1Ljf?=
 =?us-ascii?Q?7j/GMcxBNSSzJ5zXeKqyrxTXJyW7Chg0fGZY76MK0NFGDGyd5VK+LX53etXC?=
 =?us-ascii?Q?Vt8SC11gOpMUBs6EV2sUm/q7d0N37xsFTfGCy1Ym7WCRVY3w0wi/mGeUc3V1?=
 =?us-ascii?Q?6mvFjPbSlZBKypIBm5oLgBhAl9985cV+NwG8gIvuE9Ox1WyvPSA14RateHW2?=
 =?us-ascii?Q?HkeBbsNBupJ/xvVvqf9aQA8f/2plMHsTxNR1hhSXDuIgdn6oI7Q3x6rGu7wB?=
 =?us-ascii?Q?+rBXXVNuS0zOWqzx/VvWUFR9Brg4iYc15MgviIEcpBFH3cpWg33aKJDxonS4?=
 =?us-ascii?Q?4N//kmfUCgRlVgPvw/9oLL4hjeWqetgtGLDOPL+u7QowBuMh6xaKRKwyxdUB?=
 =?us-ascii?Q?XwBR1BaXr/kwnCnSC0PPHX2i8Ds4n2CjgeB/0TwiecSTbtNp8pNvWCkC0q9S?=
 =?us-ascii?Q?oTCZaHKLSr4bU6nVEcuH3+KRsSX2M48/qIPM2lMLdhW0TTn3tlujKOULGE9C?=
 =?us-ascii?Q?/uSBuQiLMd4jbnEMMmufhNm04ae6Es0AL7p3XtylEOEmr9RY833ljGWZVIup?=
 =?us-ascii?Q?UDewrVRYN8BklOldexRWtk0bynLxoxsHApijkqrVfJxZyXpSkLTkiKsFdM62?=
 =?us-ascii?Q?uLbThnNreXgzSE5oV3hhjCFkruyVQOOJ2usu7tjGhkvQ+7+WOho7HNunk/mT?=
 =?us-ascii?Q?ZoXdaFzUFTl9si5NXsmfHtLSz+RjRaM3RL3VrQsx+P3RF+cllJiKHSTq96Xu?=
 =?us-ascii?Q?EJ/oiOQGakkGhzNQLzAmgR2o20UUQjyDh57b/fZVu45kyHccBcUx0ROliYb2?=
 =?us-ascii?Q?NqKXX8/ykEDB39iNBOPlZqaK/dx9uPU1gHvLgkj6RMQXcvhQsUY1R1UHYe4Z?=
 =?us-ascii?Q?oILLQNEYfcH5k8AZfk59ZkqL1kaCQ8zzQUpcUsr0VAuey3+0xIwjbHbeiAUY?=
 =?us-ascii?Q?K7jO5CYJflBUizocpeaobEnDzBHYzqQq5tooHovVeTkzmrVCIhpfua8Y1z2o?=
 =?us-ascii?Q?YZBLDpfuRBaMVxiCd5MAUieHW9cFu/KJx28EUZkuuDCqxtlL60pBAvUVnUo0?=
 =?us-ascii?Q?HIns/OWwI7+24Zha3TOmmUnsAi7JiIT74/UBYvZve/v1Ll10tuB7OXwC1p3O?=
 =?us-ascii?Q?S/0hFWth2A5fFxd4j9Exa7Hjqi46QjRg29TNDkrnrTms7XEETP06H/ZsgtOn?=
 =?us-ascii?Q?2e4SDaA0TVMjOHrM3WwQwDNPj62achdOOb5QzR80XifzFh4OO5AEUEl25v+5?=
 =?us-ascii?Q?1VEHe0YXFq5CXyPxsjppOLFwQ433t/hwRFbH+b1BMAk0RqfWNFMZZWT5qM85?=
 =?us-ascii?Q?2+k5eljPY8WfzJJNb4QiE2pmODatXoY/xMY4CGyN3y0ircHabVBEwhbMI8oy?=
 =?us-ascii?Q?3FH60/wIdyRGnsCfMNPr0SqeXoUjQ197xvGUqRkOFKUb4EIKf1OON5aUXf0R?=
 =?us-ascii?Q?xc/DkgKrouLTsL3PcdA27nQ5WMl/dClbp0u7EySRm6IWom3sajM7eQUGFmfb?=
 =?us-ascii?Q?sfE/r+v1EwTvdgZN+pQRXzu/vpcix4lhbAWpjeFYvvA3+yb8B8PeZh96L8W6?=
 =?us-ascii?Q?mXyRh/AxNiTSh+ky+k8+nMktwGEre9EXhtiJvbvA7g6OOjoCBJcZQBRzHlkv?=
 =?us-ascii?Q?GDtk1qRNMcG30/4+5G2sAAgEStIBEf++RHvRaB8wwnWaho8U1o6iaaAQzNfG?=
 =?us-ascii?Q?qNMCk/BR0TPRsTWLzCT7/MmLf569BKs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708be761-7d7f-48c3-eb60-08da42679a75
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 18:09:56.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1wbGY7lHB/naNrtwpzcyiHswNAJKHLGmZWLaxLhiIuFOodN5wfVl5fYSfsNp4HhbftvcvtDxjgQX1CaMD9jXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx6sx entropy-delay property.

TRNG self test are run to determine the correct entropy delay.
firmware test is executed with different voltage and temperature to
identify the worst case value for entropy delay. after adding a margin
value(1000),entropy delay should be at least 12000.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index fc6334336b3d..305fad35f5c4 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -864,6 +864,7 @@ aips2: bus@2100000 {
 
 			crypto: crypto@2100000 {
 				compatible = "fsl,sec-v4.0";
+				entropy-delay = <12000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0x2100000 0x10000>;
-- 
2.25.1


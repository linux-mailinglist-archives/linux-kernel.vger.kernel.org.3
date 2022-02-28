Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC54C65A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiB1J1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiB1J1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:27:50 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E169486;
        Mon, 28 Feb 2022 01:27:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWT2VEmsIwVPn3kGDhsp0IiRlXa/RP2FczB/6AO87DJexlZBNqEUSUFYvooQjPNKvs+he66NlNEPglVRmfDBnm4fdlWwm7l1VsM3GBHJCtKBfLs83drvkGm0dC4sbXQ9b2JMEhQnIMRCyXet7ycJ7NeZogMVot/HKFASPU7g/Aakua9CcXb0eNMmgZPC3Ufzv5ceJd9dW5TBaL68yARVxSy7NPLIeJCG1kOWvKIaF66JueXZkM9zya80AK5CPmRMvaww6q2qgvD6lblR3KkzZohCm4TAbLhWRiiJ18zz/xrXaiFbOKYMlvj1p6r2va8NTYKPryYZFrZ8wIwVuzEflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMV6WFrgZqQDyN+F++IThdZQKY2EFp+h/DtLAyPC89g=;
 b=QX3Kv6znkFtpZD3TtLwKts6xANZQbJYxxRH5Bbn8m5omGLZtfQsJ0Ho2+8ImLL99diYa5jvhBDr2mtf8DyMWmM6bGQE/JEdYGHZcgFFQAVI0ZwmrjRcmso6OIf2AU0o87wKzXbvMu/TvTuVaGwUonrf8z+/LaNGZoBuV3v8lLLOqkZOrOzpVpxK5xfz5n7SqiimJuK6eLoLvj2014p+xJjaFpwvDvv0lGntAmt6OujfkTUNYO2oB4VW8wQvcfofdoj2Ji8VsViSMCXgnmDzXRlRCv2/OQQDeTX4sF2M74wYxhmQbFSFRRA/P0NFcjDYGkJVfLA1Y8ofiTg2RGdSBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMV6WFrgZqQDyN+F++IThdZQKY2EFp+h/DtLAyPC89g=;
 b=JZH5xU1FfbC/gnCOdiiKV+LqkACApbUS3kQqPzjEHHHaEWMHpfctahSXAjVJhNPFqlHHklGO1CzbtVVVXp1aohN3BtLMIE83IYfIg97xe4Iej6tPVtr+Y8fGf6IQm5n+JOMxo+iSSzLvisZ9tiTxNW0RcHXE7/vql5xdTyEf1hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB4182.eurprd04.prod.outlook.com (2603:10a6:209:44::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 09:27:09 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 09:27:09 +0000
Date:   Mon, 28 Feb 2022 11:27:06 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fsl: scu: add imx8dxl scu clock support
Message-ID: <YhyVanldAlwkqjsQ@abelvesa>
References: <20220222082140.2073629-1-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222082140.2073629-1-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR0901CA0087.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::13) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0069aa6-763c-4226-35a1-08d9fa9c7e3b
X-MS-TrafficTypeDiagnostic: AM6PR04MB4182:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB41823806193BF2973900B050F6019@AM6PR04MB4182.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uoq+tCK0QBtdS+IqRvMp38Z73u5XXNiOM9f+/2iq+DsyYuUUzXarr5azbJeLm3Jj7eOUwmMB9379hIcQkPVSLSkzubYs/cPoAPAv8v8BEN5xC6pWU0nHhh1AlS+oOYissSqA/nSSKGgmFNt/6i2PJiZOUR4XiygUTMTax6tJ5xVclTmv2Lm6j/6qHhvzJksam23S+CkINF2VTxducrsx3P0TD9fL+HiBCdplbwsR4NhcaqeS/99vXj102fJPPo3WR6JP9KH+ymCYe56Ci+RH8nqdsMhgaA3S8r0Gk6P9cK3EY07h6DEHnKW3Uj0v3NNOUcOhviUS4ak8biqe8m+IaUMh56a16sRbpO2x1Trp9gYGFqRYQYNFlajbrpSsp23dkCW8g8e7WJ0pljw5sCy++Y6lBvKtbEI143C9q79aHuaFgi4hhMb3IrHIq9I4kQKsox/0xMcV6AO/1tZpxFo84OCvpRVlPIueWl8O1PD4cGg76cEvItn8I4FPYIdbjWdglbzBRQMLkce8K/Bllp9fwxNBgVOUG71jTYzq4xJH5plJzrq/ZqCn18tacUGB0gbzM1CuxrngYT/biFZJkMVnadoxzxIUNMs8G4vJs8mVkb/OkWb8EIIl0SyLQCTD5pRZF3/BHftkVl4YA6aujfc6YAO/7ez85f95yZDtVYk2PhBpZhm2jsO0yMu9rBHiYleUFTG5BnrpdJSVavpjRPuXGXTEJID9jU7/WOeqjHUjQ1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(4326008)(8676002)(66476007)(66556008)(66946007)(316002)(6636002)(4744005)(508600001)(6486002)(110136005)(54906003)(86362001)(38350700002)(38100700002)(9686003)(6506007)(6512007)(6666004)(26005)(186003)(52116002)(53546011)(44832011)(5660300002)(8936002)(33716001)(2906002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TybFPuY8YEhwXxmha8U50phRadiLvSeWuUchBD37t4Nt4FrLrOOva8LRiTe0?=
 =?us-ascii?Q?MKFzXq1mvYMHltInEBOw9jqr9nspmo9o46YIs02M3FYK1h4KB+dIKU2jjU1h?=
 =?us-ascii?Q?wPiZhrVAgro/M0IvYJg/xQ/znB0xlItEap6Ygp2IMonf4SL4h9+GTzkIpWJc?=
 =?us-ascii?Q?Es48YUg4bReTQS1Nop06R5nwhXMuwUSjXC7aMz+WAjQQB6/TAtWjPnTCEk6X?=
 =?us-ascii?Q?01YGy1+98ZdVrzvzycsMeo3bKhreu7a+VePILkPGVb4Hvl3++NouCbRmmYL1?=
 =?us-ascii?Q?LoKHUpvpbPJscvdQetuu2QaiJ6g8n4LBbrd1Q2A8V6PSetXW8V0uAYZhsf6P?=
 =?us-ascii?Q?qmn9FgF+mRpJRpqkzbIxU/ZWNiIosCsaO7MKKnqJmoutfZK25SzP4aIfFc0W?=
 =?us-ascii?Q?nDIN4v88KtFiE6CJqqbTrT2l66KhqUykcNChT0+rkV1KoQucfFEvVTUUMcd8?=
 =?us-ascii?Q?XI9Zkof+DA+rfJqkZj4q9FiNFx89aKpdO1wHfDKuJeOxJF7T1d9M09AnEcDl?=
 =?us-ascii?Q?q863pbPk0eB+YNOT9CNMK4+hn/K6+Xr7E8a02D8N/FjOrYfr2Q3SKL37nSil?=
 =?us-ascii?Q?GybG+WCz2AFE4RDa5F1O4Mi+Yr+mn3YjMqmjF8pKPRqKOKJ9K4+tZ5gNWadg?=
 =?us-ascii?Q?m3soVPHyGpSGNxXA1/YOPCN0eVFumtMgrbm9Ggmy2j3BcJsWTvfRG1DQLQFR?=
 =?us-ascii?Q?hpxr3yLm7zZecfG3WItL1aKhaXqyJLBMJDKCFDauk8MphPCzrgMDoBi3of+/?=
 =?us-ascii?Q?RzWzsCj2Rw6VsjjHIcOR+smKH/uJomOwUzqApscfL69lPTOECj/nogWjIZSv?=
 =?us-ascii?Q?XqGogNUmICiNIbrOFD5a9uEC4eT1J6j9TQmiRn5mylux/f4G1ubQ7GwIkye8?=
 =?us-ascii?Q?0HTxj5swvHC+5EL2X+692rtcx1/AbwffQbcKPwnSvdqb5eprY4buJR12HTRM?=
 =?us-ascii?Q?J16X6WnQ7fMeChc6UD7UO4ibHhp2azX5RS4y6Yu3tlFiHRW23TpIk/syvjXh?=
 =?us-ascii?Q?3vEmxgVJRBda/NgQYLpa8dYmoD3QONrCPr3oaAo2DYqp38NuyCp3sF6IB/cz?=
 =?us-ascii?Q?Z5tUuCq3WZ7HLxkL5ycJgCYpiLKJH+G6S6FGsH9kWJ0Oo1Fc5DDtbLGgKVHq?=
 =?us-ascii?Q?dmw71BSJbz9+ZXw6PNCK4qTKSiOesrS/A9EQyXsck4hoN1BMb3kox1vQI3s5?=
 =?us-ascii?Q?XlgjE1cg6oIH3hgUH8HjKBYcZC5FHHAipL/ZHQIiTKniaoz7H/W2ohAhQRLb?=
 =?us-ascii?Q?xSZ31KCGdIf/Dd+koNRn34ZWFF/yL1KtkGMKwD8pAkTNlzs+17OAMJCkodK1?=
 =?us-ascii?Q?I32YgHtRAXJmuhSP58Wjgz5ZwnfQZPyS9SoZf7ajQ0pjzRosemo4SirTsQji?=
 =?us-ascii?Q?1BGzg3iu2PSdC1DWMGX4bGW4MHTybI+Gz/mdqZkmRv5GYag004h6wgTgcMj/?=
 =?us-ascii?Q?EErZJSqGKGBeYm0Gsoh5h3RX4bNlCDIXXdyPH8d/1AqHHTWx0JczAiWYif+Q?=
 =?us-ascii?Q?0E+9CDfuOPBK7WjtSRkH3aUdoPH8alo0nqXckTu9nSMZVkPADBuyJ6dd8HVT?=
 =?us-ascii?Q?mLspuM17q4eIr4j/eAaEufEIxMUaBPhgzIRrER8hnc47e52c+T/ChBmJYEsb?=
 =?us-ascii?Q?YVqzoCARtNW2/aEcdkAk78w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0069aa6-763c-4226-35a1-08d9fa9c7e3b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 09:27:09.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kg5Ag84QIZdzbW/tOR8/EJfi5eFcGFeuRy2qr2CU4gVmQ84JpSPQ98ETftyzBqTvxzcUu+Ko4KGqpy+DnI9K4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-22 10:21:40, Abel Vesa wrote:
> Add imx8dxl scu clock support.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied.

> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index fd0061712443..a87ec15e28d2 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -86,6 +86,7 @@ This binding uses the common clock binding[1].
>  
>  Required properties:
>  - compatible:		Should be one of:
> +			  "fsl,imx8dxl-clk"
>  			  "fsl,imx8qm-clk"
>  			  "fsl,imx8qxp-clk"
>  			followed by "fsl,scu-clk"
> -- 
> 2.34.1
>

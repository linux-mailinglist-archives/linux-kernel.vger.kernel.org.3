Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E57C4B16DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbiBJUSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:18:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbiBJUSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:18:14 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154FC1025;
        Thu, 10 Feb 2022 12:18:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4HN3eYODOyKNaJOpKBUeFfxj7Azd0tUinvrdRl08S6Rvxng09qN75SqtouC/WBK1qoHoKcl+E6ryyico+N3CKP5S40beeYUtedvSl4Y7EOggnUzTl80qk6KmFbNhFqV5Sy5rcDhL6M36i01+/tg+Mp20F3npK/YfyMWYHGG0udf1s6bqtoKexJh5ZBjiZdY8jIUvcx6xh3AcnAG5IdEH9xs8nURPWSoQznZHwRquow1DLZmxFSnrSMe4Q3knb0DwJB8RecRxBmGH4roByc52daE6zPsqIr51Nq5M5c8Oy70GtIjoZvYKhQ0eHv0z4HHUMREEajh/UJFVgiRvpUUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8QQjrUvOSqDFnqRHfdJvnWqNRUSZDPvl3Q4ThGYIgQ=;
 b=H7h9VDNSSUrGBLmX4LGwom8Q3+X4spMPoPF3+LNDy39BuffmN6k0zaIPHvjbr1/xtkWnKO/rBKdyVsIgE7PI+NhX1SsWGTBFDSUXYT6UVIBz/lxNS+FfPNeD9gvL6e76nRjFC4X0YCxoB5VT4HTdknh8VYt8i7Dm3cTRTliTi1rpYbhZVxLnUpQDRNduiR1OxejSK3E8ejqsMqXzwnBc0c4WysXdVvxePuew+iW0Q6W1ts9SJwvRSzd8f1P3agMXU2Z8ZuEQnjZaqjfOsTP/gAEJEhfXvEYCNbsR6etG6tU6YxGk+6b0Tc8ap8SLtdBS9IIQI9QotmgxTt/MoV+Itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8QQjrUvOSqDFnqRHfdJvnWqNRUSZDPvl3Q4ThGYIgQ=;
 b=Hjh37CwhRJlaNtXYOPZDA0+o23TkBMA4NbpYzREOTn4L+/coJKFFay1K13TdlV9jOo5VF0xTN2D9wbx9gAaT8cIZN7nTAyyYuxBlGeI1Vud1gmMjOW/j6HrY4nWNlXhJ0mACBlQZ1Rt20w5iwNgj8SS7kaO3AJ92nFbg1PK1hlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS4PR04MB9387.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 10 Feb
 2022 20:18:12 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 20:18:12 +0000
Date:   Thu, 10 Feb 2022 22:18:10 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP
 backwards compatibility
Message-ID: <YgVzAuu2Vgf1fqFi@abelvesa>
References: <20220118135918.2126010-1-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118135918.2126010-1-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR0102CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::37) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91331d7d-432a-4cb8-6c0b-08d9ecd2764c
X-MS-TrafficTypeDiagnostic: AS4PR04MB9387:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB93876A00F642A1E76DD8BEB5F62F9@AS4PR04MB9387.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2hnrjJtUEytFddlr+YdoCxro2vI/2wR80uwGUrVEwQq2XH/cYpEwOJFX6GcqKNaHK/qEmZYkxf1yWkXS7ZLaJzl+eFMDk2AOZnpaiB4krElaNOFtjMtkOcX231174g0gxo0TtLhhcbj7vO9OAsH3+efT3BFRNbSbnnOUJd/sWDhzRIb/M0hkOBhSsek8yal8kG0/6EZw42qlUYI86X3MowhoxFPtuZ19s4HZwPx8O2liSzdgnCYfp3lqooC/759sJ23kSGNIGmAVlwSjVjYl6gm79ubKogCy0IHhgTHEKcmnP+0+ram4KJsP99FWRdVJUrlUbruR6JE3UlG1MiRphFHPSWzbk8FJHv7wvVkMTSws+gmxDskLOln4GOpcPNERFANynjGKBNq7IpKx0fe2asgl6dIUyPWYpcSbPw1pnRkilp8rkC/H/Di2m3xKJgX2L1RK49iauWr5n881HHjBhEiDR0/ENZ/hKqE3ZRpP2yA1jqesckut2rRhagfDhGGvVmCWhmhB3wZgsGpdoV9JZH0im+9ripenUF5At9jcgM064isuRJ2k3cfOEH1Kr9wTx6Dp/tvQxpUtYRk7EDPd/7RPKUYz6QxBZaiadobfd/LOu26EGSkdDlogKaqzbWVrlNFar+OeQLe8/pAK9vjytwk6RXm2kd3UKTMf8EORAMXxKyZjkQKDTUhl1o5Z51ULkZn6H2PondvllT9wNlpsqpl4qQb+2PGmPmaEQQOD2W65XP5OXSijlclAMeJmWI/uT+pCQiPTeXs9Z0jrjjmsEjR2CKs4ZWKe9s8YFMM848=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8936002)(6636002)(53546011)(38350700002)(33716001)(44832011)(86362001)(186003)(8676002)(38100700002)(66946007)(66476007)(966005)(66556008)(4326008)(26005)(9686003)(2906002)(54906003)(83380400001)(52116002)(508600001)(7416002)(6486002)(6512007)(110136005)(316002)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAOAABe3Y+Mf4q1zFm5jYLyGAMt2NIwdwyxrguHSItJ/5rTaNEUgDaofvmqD?=
 =?us-ascii?Q?r7HNb5SbDN8Q7yG0YDed7XT/bf5wqfdlcx4frJFyHXr6VsHbFdV9wFp75nok?=
 =?us-ascii?Q?CFN95nvPumXuc+2ICunKZBSgw4H07FAh9stLQTsk3O0+XusMUEcR0ICZcfpo?=
 =?us-ascii?Q?76KLDuiuNpcDf+dCarsW2G0dvLkjAsW++XRE0HJskdM9uxTkTPiXYTwhXTUt?=
 =?us-ascii?Q?B+EmM9K3AbopWh8vYxDzJBzFH4QYf4SWSBnFGmurX/l2QD0YYt/rDnw+OQVu?=
 =?us-ascii?Q?JKZ+i1Ni3UAkp/8XMP99PVjK+nvnUT3sAWZ7GHomN1enpIPqrkxDvJfFuVKk?=
 =?us-ascii?Q?YuLg/5Syuyq0T0uE9OSXSKeIMc1OVnP22lmtKrC4NDqzvqXmRbe2Nz+W1zar?=
 =?us-ascii?Q?pTH/ZLqwsX2XGaRnDDj3yqTjkst9iT6p046B9GCvZCxJ64wCgkE5WKChkxex?=
 =?us-ascii?Q?oYX8XAG3t7h42qZJl3Q8MGniBWe0oiQVu60waICHFYqaXKGsCFlBHojcQTFU?=
 =?us-ascii?Q?DTmB7mMBdJHUjGNZpjRp/pCerFlbBl2irJE+36EHbxGoNWA5HaasrMw8r2y9?=
 =?us-ascii?Q?BUuoDaw79XLPxAYWty8FQ3bDUVXrPhBcDN+p25xFRGRiqA6RsVknlRjvoSqe?=
 =?us-ascii?Q?PL7NfKr+16D74RsSVkTalTWieiKPGFQOxSxr1kiTtadGQ7nwe+sbtWDM3Jhg?=
 =?us-ascii?Q?VKUs9USA1GughukUt2dKd6hy2wrWJFDElS7TvF55lfhS1jNjudz6e2PgyoWB?=
 =?us-ascii?Q?v3o6YFL13EdhgG7ngIxG8cnGdz7cCJMjudgt6ronOlmQITsORdWKCxZqBpe5?=
 =?us-ascii?Q?EZjRWW2P5GX+YWPazCiX7PEecu7xkEup8EyAlBcvqFS2kETmPQ9grnxtEYHl?=
 =?us-ascii?Q?gvQmBci7CAqNWlYtFN/7K2MWo2+EBu6bFFchkkZE/OrfgnhQKcjkssPFLwRi?=
 =?us-ascii?Q?AqfZ9h7ePKdACMSlkvCrmnjsfwujy7iA9Gf3Ar0rSlT6ijmo5VsefnvaN4xb?=
 =?us-ascii?Q?3f3kSAbWsDTI8oOecOtIO18HF+X10eEFDj24JXvyfP0UH2yyb00YRynPPwxi?=
 =?us-ascii?Q?55pgprDvwRM1wdW80LzPrvxQt2hGUv8WluYuvFJX3if3O2Z/weJabm3vB29S?=
 =?us-ascii?Q?0QalrA1HvXx5XJRew8xnygDPhlEPvUxvw15LJ1DlOKk+K2Oaimh/Co4RZs7M?=
 =?us-ascii?Q?dDUekfhXmRkD2/bUCKZh56aZRScL66n9+DMU9QEBiNaDn7kK5TgtM7kiRPYn?=
 =?us-ascii?Q?QTHFo1gprEAnbkZdLYi+bj7dMIoSJZ3SsVHIDEy+276fZJ1/Mry4UzcOXpTC?=
 =?us-ascii?Q?hyLymLkF/rnYZizSxb297Z0FR7+wXCao0HYjirbFTKoG+X+pWS+KVpSEjKTC?=
 =?us-ascii?Q?5oo/n0SeM5l6DjybhxSpvXHhrMVMmrXBAXeDTQiG82sQ7lDx/ls9QXcmfTGw?=
 =?us-ascii?Q?OTBg36Fwyh+DBfaaPLyVjPGevu1NjpvqK7RbiNHTUOkl/8WMZZtnPtRvSjaC?=
 =?us-ascii?Q?hIVaith1LKgwDoTDU2PmRm1t+bLkZxFXQRshEax5tYE8vhf0qYq0Qalj9lEx?=
 =?us-ascii?Q?nO8NmHnk0BxFFw7hN4NHicvkZsZt9bgsoRrUPTJNSOgcerSH04ZwW+D2DTAW?=
 =?us-ascii?Q?GRN80zbMp247TjBoRyrURjA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91331d7d-432a-4cb8-6c0b-08d9ecd2764c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:18:12.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTsBwBUefb2AppsL57iXulunA6UfDxi8jbi5dIuJmC+yzoarrS8oGkMiharUjdeNH7QLIHxw1gCDALJHM7i7tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-18 15:59:17, Abel Vesa wrote:
> Drop the i.MX8QXP backwards compatibility with i.MX7ULP since they
> differ from clocks handling point of view.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Please ignore this one and have a look at the V2 here:

https://lore.kernel.org/lkml/20220210201407.567860-1-abel.vesa@nxp.com/raw

> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index aa83cbf56d59..ff364bd0fbac 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -20,11 +20,10 @@ properties:
>            - fsl,ls1021a-lpuart
>            - fsl,ls1028a-lpuart
>            - fsl,imx7ulp-lpuart
> +          - fsl,imx8qxp-lpuart
>            - fsl,imxrt1050-lpuart
>        - items:
> -          - enum:
> -              - fsl,imx8qxp-lpuart
> -              - fsl,imx8ulp-lpuart
> +          - const: fsl,imx8ulp-lpuart
>            - const: fsl,imx7ulp-lpuart
>        - items:
>            - enum:
> -- 
> 2.31.1
>

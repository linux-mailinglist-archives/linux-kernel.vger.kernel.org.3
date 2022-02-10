Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B854B16E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbiBJUVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:21:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiBJUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:21:07 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C3B273F;
        Thu, 10 Feb 2022 12:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htlqPJy8HmXRcpPJDMpvSku7WC+i4rV9H0Pr9qIhl+EWOctNA1ObwWWXqquLuYvKBxHAYZOX9S4xMyfrSk2bfW5+Vrk/w7byfQCx8zo0Ev2IMcRLSz8tx724Rjax8ydji4AOeSLSm8HNN5g4ztamKd98jBuWb7COgzFKnMlF/z3U7idG9o5tUgoL5xMvv4/nsN4wjb+Fnw/n69uCGkAgLygeQTYmyWlnO/L5wfATDgVfMUoJ6Wud3p+6NP18zesqvt8InPQJvBl4lslGqShqk+3OtuRKJAuWi0tpZ5QQSaI2xvzqAYGfawZQJBRMCg2y85f327UGeKBK7EX0/Dj/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb6DFhpl6E2rEOI9OVle0MwxsSeAGTZlOYC0YbcT42Q=;
 b=eQwwYMAKQF3lLmyAF0fikTfG/s8wKYciAYBvkAAcZL/BqsFtJTxnI+yDgxEiomEW1QaHFb/WdDdw4RY0MBzJjNE+Geww5pGnxuzoZy0NIQNiJdpalQNL43rY/XG5ixgMJvM4mNxLo3r2jqmkbGt8Ks/6+u9bQTcpqN+7L571sO1vW47ChGI1hbpMLwZyrv2TXONOyLtC9XQZ7r6jyAfvhWHVoO4PvNTl7foy6sUYh+xd0wsR2q1lqKGBNhuFpeUPVA1dZjrghlPUyZdZKeb2Dd+J6oxd40aZYmn3xWabWopi2Zjms6Ls/yPzdD8c+7VO41B64Cd0dgwp8XwwyasZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb6DFhpl6E2rEOI9OVle0MwxsSeAGTZlOYC0YbcT42Q=;
 b=Cnjl4wycshzMFBd5CqjZixXvYh5OH+o1tkomBIzNLv4rQpcB6e/y1NBSiKZQYyzG4ALC2FqHyCKW+6/+6k6ZRulzGiUW40M/1Mk0F7PBeZp/vj0Dhd7x63pNlwYGBJJvXr6g5OSEqFyklENYKPz8vSGIOG2HnaPsPxB1SBIZHqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS4PR04MB9387.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 10 Feb
 2022 20:21:06 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 20:21:05 +0000
Date:   Thu, 10 Feb 2022 22:21:04 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from enum
Message-ID: <YgVzsNBge7R5T6xF@abelvesa>
References: <20220118135535.2118720-1-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118135535.2118720-1-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR0801CA0071.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::15) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d65c61d-310b-4579-9e7d-08d9ecd2ddce
X-MS-TrafficTypeDiagnostic: AS4PR04MB9387:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB9387C56BCA4F79AA62645CC9F62F9@AS4PR04MB9387.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhVX4qPMKEqkFwAIEjdnOApwLko4QQrG7yz/+g1NxW1VVEyRKFSKxAyiR69aMZCRqfSqwM/2noHJPRGUtm7SCRrmuLOrbkixSAOZl70N+eHMdG6ksamgK6kSLpzGdm4IFK9B9SHFLcgwpgjDQhLveuTfGsfmELce9R2vSLvrrqCr+t+LLofsFLPmB+rleFyzz6hQE8Wj0Da2pnVk2g3ADDa7eSaY7P7Kfp6vFXcTfUY9YYVzhojCcmBZdYSRDP82MmTWnVqBScUJ3dDvo3RXINYscPc6IWkP+nzteUc9JfC1dckTZ+e77Vy4+GpVgc+t4JhyngMICao3b4cVTOtX+ry+tA61TI2JO9UV7eMXQNXKt9r+WgGsLTVV/UIJt7qBfYEpLFIOPrihUDxWJq3+ewGuQxczQoj5zRYtzHEnNWziTvllw1nD5yL8iaM71Hdh/rfaGf1lbz0SfXmUuWZYZFMU4HtV8hg1QLygRjMv8L6n2W3f+O/gXTzN6VD8vS1QASG0l+ndSHnrDueqvNbB3KYuAKXa0oKK5jAgaImvaSa5b0k+/Nl3vAXAUnoHUrSXuLAscvivrf7yrxe4R1BIQojeaGSmZslCTbadyWzVg4Jbjvv6W/eL30vaxm6kKUkpx70rhDg7HyONq9YS8kcYuB/VOzEfVsrWrCJRTaAinpHaDHw0GirMYaU4XsqyxNZeBr9g3RfmLiHQNkxvgIh9TXF83/XI8TdnHm7IQ6Lg4RWU6MfHk5/kliJ6HbEqPwmCp74wwEwFFBhvBgY0G520e//JcdQAIEsr9kgPEpRH118=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8936002)(53546011)(38350700002)(33716001)(44832011)(86362001)(186003)(8676002)(38100700002)(66946007)(66476007)(966005)(66556008)(4326008)(26005)(9686003)(2906002)(54906003)(83380400001)(4744005)(52116002)(508600001)(6486002)(6512007)(110136005)(316002)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7z1926otmvF27z0p6CoNqDWvyx98bG2IoX2dkG7IBql89IK0t3rURliU9QYD?=
 =?us-ascii?Q?cCFbEfT0N47PrJ9H2mbh9fanCPEYApLt0/MgLgpiWU7/YRbaIMK3WCpMlkbt?=
 =?us-ascii?Q?6DTiXUl2tTQB4KHWbiR7nB9A4ga4aqroncirfO+MVYWrq/a1ijvITmKW6c/k?=
 =?us-ascii?Q?/mrgANGsdmKlLxJKINR2A29sOekn2wSg0Z2GIVimMXT3J2EpOkj/SahJBHf6?=
 =?us-ascii?Q?0nAT73kb5AvReFRmvkvR+YZFL4lhxXh59zV7aovHhGsPmO0Bw5hwDF+k2e7A?=
 =?us-ascii?Q?JrRLFFnVRQB0P3Virz53nsvW4bRz6TYbsIJquA7BkycoHhL8GTfnoGTr74at?=
 =?us-ascii?Q?ruS227RpCeFnicmQ0OejYZM3LNC/EN5QxJGt6Tbtt4vrk01TExzNmedPl0DV?=
 =?us-ascii?Q?iR009k4LtPw9qJwDMtCvxs5wtUvfXMtZHUAh84hRorXMGefhYCvsZ8VeyCYn?=
 =?us-ascii?Q?SpZ3AdIsK13eKpeUSjy8EKksuPQTswbcepWGI4hVHYqZZoyTJ4DGeEo2IhVk?=
 =?us-ascii?Q?o1wFSWeAl6Q0iLDzBwEdSZRxioYXzc+KsWTSBs0qY8j5DFY9WVoKv4tmUN72?=
 =?us-ascii?Q?CF0VarOalijNmWg8J087t7wxF10TuIIupogGB0rGkA8WilvkwFhpmQOby3jD?=
 =?us-ascii?Q?1gniEbxnnikrQidSul/dGU8eimaC/4f5klAyYo5Xfw6nnbb2FvrmVm6p8AJk?=
 =?us-ascii?Q?kCraCaO0ijl22r7EIsVX6ob4XvgirhS+RrNUit1C4X12euibQsWP973MNrTU?=
 =?us-ascii?Q?KUp3Vb9v8lZg6w24xpJSEAaTRxhXhi9QdyRB60dzjHxJe6I4M5BE5IiI0V4g?=
 =?us-ascii?Q?ggninowYk+pjh2bhsDIe7F1DK+52LZYkYl9ziiaq5xDRxWy21kWAkRthSEHl?=
 =?us-ascii?Q?Rr2gCVAryLUZvwjGT5zJ1ahtsS2/4OOgsaOoIKVbtcC9xyBEg5nCtgbTv5W9?=
 =?us-ascii?Q?9fR8KGDqrFnCp0mkPh5fMqzENVbrP7eMY9qyRnmwVlmKLRfA+Gt4yMsY/Q+r?=
 =?us-ascii?Q?+9/nepDo9FOAuOfKj962iZOcxzucd4DgmDPCwr9MeuFg4YqqobDr6sA2HA2s?=
 =?us-ascii?Q?j5gX+Al8LBQRZjciF2WaVodffXxDaHoB7cD3CYyDkrdEOhFY+NefX4pVhQ2M?=
 =?us-ascii?Q?LOcrOKPBSBSk/ZC/RswjW0D+x81dtAOuiqUOCeu5WpqUtCUdpoNQNw8/xcZ+?=
 =?us-ascii?Q?T6tOfYqtv1JDq399AzVe1zqQeRkAwO+QnuBCTIpTjVeloEv9qP+ZWsl4RZoK?=
 =?us-ascii?Q?zyxSC571i804AXRzdN9vEsn8v/b6wqKTw7KB3Av/kBf697y3TqE7OYwHlf4r?=
 =?us-ascii?Q?scYe4QYLYmnQxznv5o9fTnLouYxg0gvo39P1+qOWk2EQErgcgICE8D1GsCbs?=
 =?us-ascii?Q?ChZz6Csb4/hH0DNXKZOlKtVgYTM+TcXD4Px9rkO0JwZtjujeUvw28A1hrfS9?=
 =?us-ascii?Q?5ssWIzx80/eUzfV9FkvWPJ1cRHhIBLEL5Y6rofc6925Q/NYzRhl5LjNwSQI3?=
 =?us-ascii?Q?7aAm5hj0Egs0JgfYCgvbOs8GtzDnVJPF86sCdwQJfl2N8kyUNlTRqk6CWral?=
 =?us-ascii?Q?4pO+ZeMIQqvl5XZEJyaj0tqyn057rs3GVZ/fZT9Dtxefxut8hHBCH4mIgGSo?=
 =?us-ascii?Q?4pfSzO+phenWnJbbOoNytFs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d65c61d-310b-4579-9e7d-08d9ecd2ddce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:21:05.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPrlLQ5gU/QLrMXFQZY6ntFXdBkM6LSKOXB5rDBh947+ZjdAhns2GYHPLkE0Y98kekdShtTaie47Xv4pJgpOWA==
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

On 22-01-18 15:55:35, Abel Vesa wrote:
> i.MX8QM lpuart is backwards compatible with i.MX8QXP, so lets remove
> the single match from enum. This will force nodes to have both compatible
> strings, since there is alreaady an 'items' entry for that.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Please have a look at V2 here:
https://lore.kernel.org/lkml/20220210201407.567860-2-abel.vesa@nxp.com/raw

> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index c33e3af1b5ea..aa83cbf56d59 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -20,7 +20,6 @@ properties:
>            - fsl,ls1021a-lpuart
>            - fsl,ls1028a-lpuart
>            - fsl,imx7ulp-lpuart
> -          - fsl,imx8qm-lpuart
>            - fsl,imxrt1050-lpuart
>        - items:
>            - enum:
> -- 
> 2.31.1
>

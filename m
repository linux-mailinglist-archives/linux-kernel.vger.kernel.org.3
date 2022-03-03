Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324A84CC802
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiCCV2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiCCV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:28:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2119.outbound.protection.outlook.com [40.107.93.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381A9AE56;
        Thu,  3 Mar 2022 13:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6S8OBjKjUhRqfEZc0PPrQxS75WHR5tLsgOpBlWqBF+vvX4OAjukct8iZEIB5R5Cr76MWVn9MAIeU4tRDAGr03gKb4h7q7RCqgjl+44uU6EaVmx6s7UaML3Mar9RhRiOTR/zuUC4qwcnYU76ZgmM+6Tw/KkrGblcIZUap/jEvPvmRWX8F4HyOBu0PliU8GbDlcmG/OKiu1GnVTsvXn5TZug9xAw1mAt5lKf1snG1J07V8YnBQQMpE6KeD5KOWc42cxs9VEHGbIqu8ynqZ4Dio0DesHMT7FBPhhGFQ3D5vIMj0XNneY+Z9fFEGovthFJhTd4KBCVMZEAcTRO8ymH7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2Lbjwe8eooiG6ReOL6oj50VArq9TAhZDY9cTDA/kc8=;
 b=P9WgOKBEoOwkXndvpBxMfXdcKYfSOthRKxXLFOCtab5zme4DPy3hpHwr9MXUc6o3CwgmeV+Td2ELLdK9gw1tli6JDBBal9czozLLLvUr0kjStbjXIgmwGWC+5HGdywRhRicLB06KqFDjy4ahLAsXOm/Yk4nEY7Q/CPzHXFds06jTNebbOZliVBO0O/BP71RMt+i5rHdwzOqnDzIchfXeY4B59FFimVuRCSaq7XLBLYmvNWznOAwNRPDAer8MB5c9lJl2mVy8Z+BWA7rXOPreOTNS8pQ9DHfCsrQ3jy9JnNIEFLWnTGsM0u2ln3W+rlVnaWoqqWQvPSq5Gmnu100Rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2Lbjwe8eooiG6ReOL6oj50VArq9TAhZDY9cTDA/kc8=;
 b=ftsD77JXtdzr8nxMByCXCf7G0K5D8r6TlsfiD+quUY2ypTIowS730l0oD7GAOE0hP0Mmz07/A3yf2V5nJu0ZLo/xjFOgs+SypGvQFu6UfJiy72OOvBqBcE3V/euxeEPm1CmObPEvS78kTNG9ROfc0Z98gFbY2Ma7LBYxWV2MmyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BN0PR10MB4965.namprd10.prod.outlook.com
 (2603:10b6:408:126::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 21:28:00 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 21:27:59 +0000
Date:   Thu, 3 Mar 2022 13:28:05 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 1/2] pinctrl: ocelot: Fix the pincfg resource.
Message-ID: <20220303212805.GA19085@COLIN-DESKTOP1.localdomain>
References: <20220303203716.3012703-1-horatiu.vultur@microchip.com>
 <20220303203716.3012703-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303203716.3012703-2-horatiu.vultur@microchip.com>
X-ClientProxiedBy: CO2PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:104:6::18) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e965bf1b-986b-4969-4df4-08d9fd5cb07d
X-MS-TrafficTypeDiagnostic: BN0PR10MB4965:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB49659FB00C6FBA3158D26FC5A4049@BN0PR10MB4965.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBVMoCnYDMMoU17uRV3TbEtMzF12yGyzy9G6SBvaTh8SMnPskxRV/w4OCWJXv86CMgMzI7Oaq8FWejXDj5MrUfrp44hgB6gSKCL3AKAIde1xR7oEcionT6bStQCU99j+V/67RIODPIgh6nBHJwc08Re0imd2p9m79qUIdSx31t9gKKNxa3F/bjFyS+qh007FRKkmUhPc3yfmuRoc0YcXJPeSKfc8hKis6bI20oZc8+8c5GpHUQnS2uYJH13UqJSR3kXHuP/FB194D2zKqp9akkY86yeiS/MObkxIRdq01RRaUzTLFTviaxNyr+ysYzdzGL+CTgvGKJAN12mvXhoAYYaYX+eZK8GgfrdKbImwuGEWnLef3YKszCpKv0OJ/qb4/FxIrJpcofz/zucukANh+dECC1y1TmNzO7LR9bVv1tgsUE64NsqxuIbAR83MrUj9FUZrrH6rS5BJhGgx/57YD8HdrbF/Q58ETfza9tNO645qIiLuoyGBsQosvjZX5T2gulgyZyazqiNlwAiR+1s93HuOX5kuaiOysKhK+yLbBy+IcMVy/dgvgaQ2GcgDIDUUHyoo/jJu5ReCAxxZNsK7n9Zq1bOMUn726gS1lfO1L7oQGf8hmzpMa2sqtqFthgBaeszo1wM2uDK69Xlw2bY+ExY8KfPkNtPPtkfgJwJnJy9g6pD8Aq0sG3TWSA4R+/9EuWl0DCmpk8h0p6X7EO1k/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(136003)(376002)(42606007)(346002)(366004)(396003)(66556008)(8676002)(4326008)(38350700002)(33656002)(38100700002)(6666004)(66476007)(66946007)(2906002)(52116002)(9686003)(6506007)(6512007)(8936002)(508600001)(83380400001)(6486002)(6916009)(86362001)(44832011)(186003)(26005)(5660300002)(1076003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfhIi6+J9TEcdd8eoUva7grSbmBn04IQH2raXhiLwckFuLvkPSDCZsr4Ws/O?=
 =?us-ascii?Q?c4GdGR4+Y4Fx3IFKnhG6yQMSejFR5TFJD8AndKpvIqduK9olr5T8UJqLcYkW?=
 =?us-ascii?Q?CJn5+IIQb/02zJ9cP8acGU4no31kJd/7c9GipTxw2ajLBW0a6Ibf105aPYW1?=
 =?us-ascii?Q?yfywQrvHmTPqkytelWndlQG71ynrB29pFefupyOO2HYwmOYoN/VYN+h8wBpR?=
 =?us-ascii?Q?bFw3EXq2qqOIzx1zQbsPL624bzKmEa+JCw/adopo3sK7Jj1N1EqjkDNnMSJu?=
 =?us-ascii?Q?JqhovoXbXJh9ZPYbLMEb/CDEHzkvRwJOIJkhzU3byyJeN2GFpfvI8jrj5kRE?=
 =?us-ascii?Q?Im9hdWsrE2zB4QTDIxPG1yCrWligtkRuK/F9XYdt0HEYmsnKSc4SFl7HLtQK?=
 =?us-ascii?Q?rW1DhW1qRwrBK3d+xwGy3igipV/08/q938d5UUk9ku63plvFjagjj5ex/6FH?=
 =?us-ascii?Q?Wuz5XLDCTCg8Y4qWFQi3r8RhSoU2vJAVp0vqIvlkVCFxdpHsfj7YppNzsZfd?=
 =?us-ascii?Q?/dlbUEPj+5d/rQFspz69uQjSfDfhiZ7jiyt+315eVKooxVkVA9TVs0/E2s0e?=
 =?us-ascii?Q?4NoDXs1j0fCfPFY+g+MQy1MdbajvXTnbb6c3YiaWZJRj7abH4g/pVPGjtJXu?=
 =?us-ascii?Q?FVxWMyP1mh7TrAm0oH/yOIidcH+G63Hhx0DJa9k9a7y+i9oSIJfFX/YBswKo?=
 =?us-ascii?Q?+hgoZ0aEAmTHnCPWrWwGwMVc51e5a18xznLx/zHy8L4HjV6uvZGyIj0lm/7m?=
 =?us-ascii?Q?MU09O+NlUeaEuZyTi4syQAs2lEJ5/KJZSG/W4Yzuz/OXLasWoq4GJmMARMRi?=
 =?us-ascii?Q?AP5Z52W2ZM5aNLE3tpxvO72lTIpn2japVMUKl+bNKGcwXJKZZzpu3bh0QkNJ?=
 =?us-ascii?Q?WDV58mTBKLWAJXfierahQaW+WYeNu5gjqZW0Rj3gJgd9qRsLYeuFR/nhTuKW?=
 =?us-ascii?Q?V4mUTHXdHFKmRjXOQmaZUbC+3SlBIK+Y3JgBz0XupHZ/N2MQfBTLUYBaHH4a?=
 =?us-ascii?Q?lM0rI7qkJeZNY8LU1zaTRLwN53lPpqavOL6ZBGDbUyjwm71nRJFGRXf7LaNR?=
 =?us-ascii?Q?KzzQBn5UPotx0DpjGDFT1eDPS6sTgVTmgCGvnmO/ZfLhjzEvSsWLN8X0FE6g?=
 =?us-ascii?Q?S/OPJBL9jW25zPKGF5C3B4uOQuT2ykid1PwVp/tDtB/lzBVNDjuTBaN+M6ea?=
 =?us-ascii?Q?kqmObCzCmHOPFaGGLQlb5JYz4RVWE6F8PmJwO0MBaxdVZqqvFYCumCWyKtbA?=
 =?us-ascii?Q?hP2xf15836ZMXqA+D5mcnyw2QDsfdpPRmC6/ZDFbvcb49wI8BZM51jW54J8s?=
 =?us-ascii?Q?1xdxvh6jx74zeMaG1Q7WQV40xT3hOdsaaCQk2gviS14wDPWbVuphkJoqV03m?=
 =?us-ascii?Q?Ab+Ln63gQhGVmY9mfXe1NQ9TncrsMDfdy+5ERceIXiqjz05+tZ5Q0pT34zrd?=
 =?us-ascii?Q?xyBJTLykY+74XEajpoyaCjuoBc7cWFNGic3LchtKncWO2/VngPit+dS8Z2AD?=
 =?us-ascii?Q?mY7BAY27L6OGAvDdA5bi29Jye07GVKm2DyG1ImkQmV9mKzlR3DV+rHaJw5Ay?=
 =?us-ascii?Q?fRyqDUxVmbpggllFgZwN4XFIQDwxRA3Ba9iaM/h6V+7DuewCbpntPuiICWpk?=
 =?us-ascii?Q?UJaNKQpj2J4kniby22UWob2Uje224B0sEttjQW8QmnZuX9SceuyWAcdb6SEf?=
 =?us-ascii?Q?q5FCjg=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e965bf1b-986b-4969-4df4-08d9fd5cb07d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 21:27:59.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EydzuwfXweNm/Kd2xrv3A2DODQ8YaPxweT42X2ml+OQ/4hX5I1ved0YJSoturVUym18vLrRFM4DOA56at27TSiAlJnXyYCtgLczlh6k0KvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On Thu, Mar 03, 2022 at 09:37:15PM +0100, Horatiu Vultur wrote:
> The pincfg resources are in the second memory resource. But the driver
> still tries to access the first memory resource to get the pincfg. This
> is wrong therefore fix to access the second memory resource.
> 
> Fixes: ad96111e658a95 ("pinctrl: ocelot: combine get resource and ioremap into single call")

Sorry for this bug, but thanks for finding / fixing it. Digging through
my commit log to make sure I didn't make the same mistake a _third_ time
:(

For what it's worth:

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>

> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 685c79e08d40..a859fbcb09af 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -1892,7 +1892,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
>  		.max_register = 32,
>  	};
>  
> -	base = devm_platform_ioremap_resource(pdev, 0);
> +	base = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(base)) {
>  		dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
>  		return NULL;
> -- 
> 2.33.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822164F947A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiDHLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiDHLvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:51:42 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF5C2438C1;
        Fri,  8 Apr 2022 04:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0XHYned61xHyfASTl8Y8xvxr1A9J0OmRqrjQzGJ+2vao7fvJg6hi0Ebj9W4OKoEIr9c+Vvd2OoVW7G24t3/R5CQj8sVnRppsuQIcHESCqA7wprcmImFuljbidT0YEY9XY2iwJuEFD/tcT9lcQoAmrfgTjOz5zrQR15oH5siGEP8+EHu3vDmD7hIsygfIshEOhPE+j7ZbWWRP3swYFAlEqF9OJzXjovM32OvjHvGH0C8p2aeyfgBnGXuddCKLTPw1ofwV/iRCWQ6UeJ76PWLShltc/6auhrXc5AsM4RGci6fpq8hOI3AiOIpS0rVXlXn+DGha01r08ifcCISPElBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bxJ92bqEZkFufioOLyo6VIxa3tXmutwT91sm6aAfNY=;
 b=cITL5r38ZcfiqH7NWMHolaE7Zsn1cCksWXJY80hD/4J5/y51hl5Dw7gtYYGIfFEsb2ivsmQo88pC+tpr1yj5rXjTQaDmdKHb5iDge57AYUc2YQtZ/6TqnEOicJ8Dn2CIfvj/u/N6kDeQ8F3DhSOo+waBu1u9H8mypk93fYMT1XgCP88ux8Svt6Me0FWiDFjdFsPy9KM8Vom8lCbMsl48cWQ1Gx54Y3MAtCbcU8zcXIbDgVejoCQx3Qt2L0kcarpI3Aqxj9JMe8bjz78aQL4qX7h1zvoXRTaS+ZpiSVEF+iC3elalso1u2eNLcVZ+3imI/68gDdiL/DlVG05NA2snUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bxJ92bqEZkFufioOLyo6VIxa3tXmutwT91sm6aAfNY=;
 b=bK88A0kEGWMGBtWj/wdwAjM5dFfxNu2kdKEHVrzukwpdvXPrm1iTnBW7Y4h1wVun+TyzdFCDwg+cBvKBb47qqhGc/5F6jvyL8nbZAdYoDwpbkjv1j+TB+m8iVdKBMrDqTG2JgO3Cym0tkmVo0w+Nx9yAIu3kjHowemBFprBQ1aE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB6111.eurprd04.prod.outlook.com (2603:10a6:803:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25; Fri, 8 Apr
 2022 11:49:35 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 11:49:35 +0000
Date:   Fri, 8 Apr 2022 14:49:33 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: Add check for kcalloc
Message-ID: <YlAhTXH2+WJtrKP9@abelvesa>
References: <20220310080257.1988412-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310080257.1988412-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: VI1PR0102CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::34) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3aae6f-85be-45a2-3e97-08da1955da1e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6111:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6111BC9BAE0257009C369C7BF6E99@VI1PR04MB6111.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3i1GjVruKCG9vsABEWiMMKHqcWE1SRvxad7x3iDWw+hSkyhrkVW7lT3R6iIgALEaUJH4IzFoF5ynyRILGL92LZQ6ey9AvlMYtkw0eMqpfYtS94jRNrrxGPsEpsHkuBYTKqAahCNtEjvvrWoYwXtuvotMfffWIvuUVxEyEZDMliafpSeKYyNxdkX/17cB1J63Fs/FpBGrLqXnjSnanOiWAlhkRe4JfIP1x6W8bqnq/APD+TPKtQuPwDXsr70vgWBycCOFJsIbStIEtWhgFzkndki2FJxpkP2z7/WaefaE2maiiewzlQro4jpmSdAYjrzxsHakeP31iY/MTnbHFz8kvixXZwECqtt4UPA89aO1YeYThQee+EIYyJvbJuwA4n4fQvubK4y86mERAPaIHrDpmc+V4+G2puUkP12F1CYhtuOi22zDAD9CrdrSY/KTIZAcnI/OoXobpfHhPqpBE9hJkbANdqAFPgm9wBoAwFHx62VI9FioqjY0+bpbl3eD19YtNCvtwYo3wnvh5nej1s0r9KYdeggxw/qxvXscqmnIONpBl2DpLFcXDhCtCOGs1Q1Fi2cdjWUCJZ+ZU5yNGgN2U6gScseRfWKav4qhD0fsNoigZUQrYUzMoXhAdUv91Lc+i7WLR7hLjkZB9+K/MtLlUzBWBSrxuK3JmM/IDWkWbfYzV3TkFNBtRISTNCmisny3dRsfwYElzEWs4qTZ2Djm0TjNdq28qlmoJS4VrpWP1PU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(53546011)(52116002)(33716001)(186003)(6506007)(7416002)(8936002)(5660300002)(9686003)(6512007)(4744005)(44832011)(38350700002)(38100700002)(86362001)(508600001)(2906002)(83380400001)(316002)(6916009)(4326008)(66946007)(66556008)(8676002)(66476007)(26005)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjynPXJGpjOpOQoRqEL4JXnzvRj+yj77dPxKssZr/RW7fElKW+P/kVy829pz?=
 =?us-ascii?Q?ekdhhIlhVsKHYdToFDdfgpztnE8uFlNJEm0fHbMzlFlSi/OP4JvOANrU/Kgd?=
 =?us-ascii?Q?bZTASvs/Kzj1xVPbV/CtZSC0vKJCZdHyT3H+DcXWtSySzocWeLqSCOxADvOL?=
 =?us-ascii?Q?dsDs4KTaaDoUsC1mgaCry6OeYU4ESktdMA87aFoFc4sRm+y3xpXEsbrIRW0w?=
 =?us-ascii?Q?TVnASr00VFObi5YCuv5wrTytStQwcsAT/0dWabVkkaXOXnzrXo/5Zk95hTWc?=
 =?us-ascii?Q?Y+lcGxw0fGT/F8yGduZI+h2emHRBFC3dRmPwSvrK19vDIAI5yBWwE7PfWC46?=
 =?us-ascii?Q?GHoDfxcodJKnA1WWTXvs/cJ2HF3mS/qaV08D/hwabNsdsS+B4TpcdaPflVPS?=
 =?us-ascii?Q?+otdzqcO5SW2CmiCaQphXVrj9K89l1qJfavtU2PEqlywqsNSmL2nheEFEGfA?=
 =?us-ascii?Q?pXj+gqtAbdjS1CDB67zVQCFb+QR6wqlD4NXNCNv8Ouy0a85Xht/7wh0R+s5d?=
 =?us-ascii?Q?LUkJxq4XFGsMhiZz5cVqwOl2coop/Q/QzE0yddnmphzteen7kWIlVWy6lJzI?=
 =?us-ascii?Q?VoRbXqSKEcDYDU2OCqGjvmHGJvmNEDfUqOsFc4+k4nc0NC6NRj78fjTD1/eZ?=
 =?us-ascii?Q?sohtY51PGhfn7GefH1gWEkAOE3l0zGIEJT3yIpAvO4fJ2CIbCCd+hiR3u+MQ?=
 =?us-ascii?Q?IzlDSn8iA6We2/djbzhJaZuhWRy90kten8VHzdC3h6nV+hhvnLRVRk4y4tWr?=
 =?us-ascii?Q?jZBwcv4l8Bgz7+C8IWtbpiFHhpgxhc84eecCODgUMaZdxtsDNTbzNA/FJ+If?=
 =?us-ascii?Q?Y6RXnK/tO8CFrnVGVxncfe6U56ftpNeA2h59MTOxOWYvNTGPtZsI1UQM1gkd?=
 =?us-ascii?Q?nrh5pB5jU5r3kiQ3w8lvN9wPA+GXi0UUjFWHiYLkTpZ08yg+i4B/XRrt9m2l?=
 =?us-ascii?Q?ANy5JlcmgZToWHTf5ttcjm2xTrUoeDAAulX7dnYcD3XpBDrZP3SdLQNcK/S1?=
 =?us-ascii?Q?R1DOXIr4WZhJpdVa4vku4fsMQ/Bw9FMRQRnMFbccp8r+5lu2mXPlm/5QAzqB?=
 =?us-ascii?Q?6iHiPuQtHZh0qQWYnSmrUJqUhN1dzmmJDviZBtjVt2mkpirg9WpviAkmH2ki?=
 =?us-ascii?Q?MFiSDzs19bdhdugIn8SWBNaqlGeWdomszIz+Ki9dEAuql3imgXepLbl98Cot?=
 =?us-ascii?Q?3v7DF4vXLK/HHgb4s77S+Tb1g+oimQC9L/L5c7GAhV3oeLQitaSGenc65eHV?=
 =?us-ascii?Q?9vf8u0XZ/Jc+XD4FwMa/AT+VQWIUCA0ku0sk+ppQnHYB9OXf4440txsyRRiv?=
 =?us-ascii?Q?8l9vlVrsOFPKaCcsMRDwcnHaDFI/dEklAnjhmlclnq7HUsZsvC/5X30mmxLP?=
 =?us-ascii?Q?D1/Bh4mr/Vi93jm72XKKdhB1XXAhMM1soKeoQpAY9FPqmv8YVdssLB9ACjVB?=
 =?us-ascii?Q?4x9bZkgTTeTTYVnNuyKqMFe+6CBOO3VLtm3VUh8HJFWY/OMalpXCTiVNzCpl?=
 =?us-ascii?Q?ctdEViqXz7DVT2c6pyTqqfF1VZYNU4ekOFbnBshvtsvy7jS9/oYT73SASsmI?=
 =?us-ascii?Q?YanT1wOTLuI2ay3kVZdisfifviS1aEPUxDs1P/eYVwPfzfQ5hW0ohfUM/1XV?=
 =?us-ascii?Q?yvK24knvpiv407SQk2RSbHxK5l2+fGE/oGE/N/TOWEhO97/NNWljVveqbvzA?=
 =?us-ascii?Q?vW2TNL32BFOUApvL054qZHr4BIZVXoKxYf693AO6RwKAkygnrIh/ylgyEDw1?=
 =?us-ascii?Q?GQQUSgICtQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3aae6f-85be-45a2-3e97-08da1955da1e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 11:49:35.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ghwbxv83A/JiN8HBXCULZMJn3PBfx5lAyvBwStdE+gkwCdHY3hMCR8FLYQbdaptdwi34echSUdLNmLWWa3RSsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-10 16:02:57, Jiasheng Jiang wrote:
> As the potential failure of the kcalloc(),
> it should be better to check it in order to
> avoid the dereference of the NULL pointer.
>
> Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 7cc669934253..99249ab361d2 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -173,6 +173,8 @@ void imx_register_uart_clocks(unsigned int clk_count)
>  		int i;
>
>  		imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> +		if (!imx_uart_clocks)
> +			return;
>
>  		if (!of_stdout)
>  			return;
> --
> 2.25.1
>

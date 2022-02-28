Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336234C6C45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiB1MY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiB1MYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:24:25 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00083.outbound.protection.outlook.com [40.107.0.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F4575222;
        Mon, 28 Feb 2022 04:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afAe9m6jie84oLOykl3Lis2jgfnGIvs6C9lDl+9sEP3520ktiGJk8nXTn9ESSEvhjBimKbLgy9FD6qmS3G0hwtHw+qkJVABArDNnpxA4FyDyK/8OxllR/U7pjM/mr0YyL3nvfm7gQ2HQyxee8/u2PyJ7jQSICuLvWvdBhk+MZga+aMmOcCleljGSRdshy0bG3i55XpVLXO0z9k32EaQL6jDXKMV7lJDqzkMbnYqT0HZ2cUGuRZNb+noxr3OnBw3sXOyRxXeCg64ls2C3kSK0I9VNWtvN88M7nG09V3uRjd1qcd9lSdCF8UJITaRSPueYtaJfGV9WeqfFOnMtTWwxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A6P06fcV7XyekmDKjByC7LAtwOuWLgh+ckCA8rqZYs=;
 b=VK12hA5sI3pobMPFTZqBsGMsPRLL3XqW0zuc6IHuf+L+bO+cKdqrf1G9qXMT8igOBbe2w/TiWKqLnft6Fl80pKTVqYyLxuO/93boi1ssjnAPSoC9WsrmkWYyIqvuvjcxQ8r2TIpFkaGAiLfaRjjykc9+raEr4wYpsNUBMuecgRnfBOAHKzqXMXQ848QxHAUgnnoZ8GsVA+MFfp9nFRsNboWRlEnI8ZRrWjft8UO9mbEHWcaS6/xOQKKa85wS1+csMHOtNRhvbS/T3XAW2oh3v/LrFO0LGZYQhHag0rp281RD14JqewTkn4tZi0u8LHRFXjWRBbJewirwIHqaEazwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A6P06fcV7XyekmDKjByC7LAtwOuWLgh+ckCA8rqZYs=;
 b=EarLvCS2scgGbV17PMw+DtfuRPIfR/0C9sPR6wt2Y2B/aAntD0XlA84r3azaOgWxsIQAlvFYr26glLYuM8sn9KC0Yvbjygc2JfRMwKhr5wOV+W8CeKfvUShqmXupEBhxVATJtD6ex5OXvg61sBk8B1cZNWTHzcGMBtLq/E/cNns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 12:23:37 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 12:23:37 +0000
Date:   Mon, 28 Feb 2022 14:23:34 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] clk: imx8m: remote sys pll1/2 clk gates
Message-ID: <Yhy+xjPXoCeZ8AhI@abelvesa>
References: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR07CA0208.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::32) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 305b7b61-0c31-4019-f0e5-08d9fab52537
X-MS-TrafficTypeDiagnostic: VI1PR04MB7152:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB7152D57A9B5BA08B007F9E7AF6019@VI1PR04MB7152.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ntu7r5uRIUZO1lllx4lgv2e4kTUopSLi9QQyXHZEtgwA2ucKUOOg4pw/YJh13GCDwd9oDuv6kd2gmshwNzWCLP7p1QnhQz0EQZB0RWh3fg6F2PBoqWOpI+2CILT2ZexRDfFFDPZ9AseWz2w2ce2hD3usTJAqTB6LzEwNov8fpYYlBoq/lShz6fG+WKFQrAUa7fc29eZ4JV5ncKq/oVsFRLahCmUW2ENp0jhMlr8JZaq3IR5rlTSp/P9+nxKCfiScg+0nxNdUDN7JSlHcvaPNLZBb1D+G9UhP9LTInLYeZ2qXjUhp5wtrvxf1fIPT0oaXRljb/5aDRjtOLNpG4XX0pIYGiEtrTUoO4ZD/HgflvhGg/gxWUs+s/zTj0LDrJvIIDCn05Yge0gp0T9HLRJlPQfe/eNqYyCP4jjPyhj7vVBxnIefITGJ5G6Vr5822gfMcJfT7Xs1ew4UXNztMstqUmQqXvQwLuCsESmILl61uYfqxOEjM4+uAc1cR6vOLBt776kD3weVCtysRNaS+vjN/B8n1dEGCgRv5hYiXGASqP3OS70DHaS+7+DDmsOu4HE+0tqA2S4GqcB4fM5vfTJcHS3iEnOM1irfAxEA/fI3snOdbhCkQi3QET0mmmR4z7ZzV9qcz9jYiSIMGvZTKpOFGun5bhQr7pQN045rXruEqtBjP+spVUbI9c4srKo0EKlT7aBK05S+Ie0TUEeQXfx2OA5xJFmKKEDCoe1mtIk5g4/rDrDMIHhj3Y5bUd4QZE983
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(508600001)(316002)(6666004)(38100700002)(8936002)(53546011)(6506007)(6512007)(9686003)(38350700002)(83380400001)(52116002)(86362001)(186003)(26005)(2906002)(5660300002)(6486002)(44832011)(7416002)(4744005)(66476007)(66946007)(33716001)(66556008)(6862004)(4326008)(8676002)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJfteVYSnqEy/Dx6Wy32LvcgcqSQJWXEVSz+XB6RohCvZ/fEznaWih6+YvM3?=
 =?us-ascii?Q?0ZlrGlCxIjgUjpZW/Mnp3WVjV7KABf7EGH+LwjH3u8Fvs/DEKENk+YtlPEoC?=
 =?us-ascii?Q?JOLoFvHoepGjsl/zCEAUQEG0Cv9js0mZzEPMYE9DqPZhVPbIbpgI3BhvA+PF?=
 =?us-ascii?Q?7pDASRN3jl29Id78lJJt89U5eYE9mrHwsw8kGqoxM8z/N05HDJu1y3b/ZMaT?=
 =?us-ascii?Q?LW1q2KArq6+8k9Jxror8F1HahQpdbUYzj20r1GZLgLUJ4YtkscMXrH4LG1fS?=
 =?us-ascii?Q?LpHJ97KZpgV7JHwiQe+bR+TEVkgEAsgNeeWIhuUB89O1aRpv+RkxzuYvBypU?=
 =?us-ascii?Q?quKt8vfDGHnJoOcxzY4M15VTFfEiwD7DvdfxrtdpM+8OwjGJ6QxucwWEzz1K?=
 =?us-ascii?Q?n5rgOc4AV0yaqDWmzcB2DQMNttp8W8eI2abUVmsM+dV525mpsWUrhjLyR2u4?=
 =?us-ascii?Q?aIZ6WSpQx/90mNHFHqPwCnWSTLw043v/Sj2idxDUwVkEd3zA/RcAAKVg+flT?=
 =?us-ascii?Q?78904cx0VE6ilOCjciVjRPUJWSJUidjLGkPjrM/rkYZMmGfvq5l+tPAYO0AS?=
 =?us-ascii?Q?WmaiHLx/Yap0bzegXFXS3PPappXHW2Hcf3Tz9luKn73xRBt8xvUv0V3xXgET?=
 =?us-ascii?Q?pWS9K12PsDzElrqrdGeD4eqZUvj43Vi2Q3fcbJVZBQYE6gZ9fWbGB7PPggFd?=
 =?us-ascii?Q?7rBJ2TCiG/LmhupUZS4IkvOEqapDZifaVewDp50bqfKwbdHtTnxFYjlzGJS8?=
 =?us-ascii?Q?wb9IZNO36JMespe6Ax11qms+C7Fdiu6ltstGzQ/Mm/5fHk7nteUJ0WKK4RJA?=
 =?us-ascii?Q?EM2ZWmuePEuJ/7KG0wpZ1FiY3ayP7pjp1UruRjuHGe2ixE33FQHRPP9UxNVS?=
 =?us-ascii?Q?v0whSPH77yiqq8DyBqCZHoWZOivRcfxdcG6bBn7yEDFckUAiS0fStxFMxdGd?=
 =?us-ascii?Q?kLMaUxbi65NWf/GIIWfHMpqZY3zWYpNzVe81GAkgmJvW0gB9NfhdLO1Mib6Z?=
 =?us-ascii?Q?NlD46hXI44qxnalz9xp98qV6kWkVYVsE0eyxC/X5yP6nY3gE2++YnSGkjoB1?=
 =?us-ascii?Q?XOP4ggMf3rZWHwvYCh/PQkqcs6uiqi6uLW7IjSrmQLmOwg/NhZg/RN4tqT7I?=
 =?us-ascii?Q?YCMPhYAgxvzI1vWXFpmyPDstyBSrnYs4gphrcNBjUmkjdxBVmklTBu3ALfGB?=
 =?us-ascii?Q?dLCcFiHtds4JnuluajFpmK3q5KCZxq5Z/CxGQah96j08e+y/ZSRlKhayOIt6?=
 =?us-ascii?Q?CmkTDCpC5rFADUc13Q3jl8ew9EWBPoUEbpAwzdp7y8nk42EHM5u9rIi1b+WM?=
 =?us-ascii?Q?QmXnM+yHIAZuSUsn4pKkvIacb8quWizxvENeT0AdcU/wSiex1F4F3XZXeNOI?=
 =?us-ascii?Q?kz5hxtj+Sv2ki0gvGwRE5jIL0ukEtkMUm52gyYj3dj6BtJnGm0Tbiody4UTt?=
 =?us-ascii?Q?niq8OovXuB8/O/7ilqFjhYz8kahUM4lnBcgn2hA3TRoITXNH7v5LoeZxoeR9?=
 =?us-ascii?Q?rFWyuXscILj2wrjoutFetzetvqNHtshs0TfMiKnTAQADsYoyp21XlFEbOlLD?=
 =?us-ascii?Q?4rXJfOvRS3jxLiFhoADMYrhJ7g4c2/m4h8sMapXC9IKcle4tPF1A6CZJxToM?=
 =?us-ascii?Q?XlrQTI1JU33Z/ZkpHHDwkHI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305b7b61-0c31-4019-f0e5-08d9fab52537
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 12:23:37.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvbBjRRtLJ4mIv0z/wvkY7EaMeOitYb1iJPSpev6DSgAzEZAxH1CmcFBkEztFi4eQHCf/PzRYfvg/TLs2sQt5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-25 16:17:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Same to commit c586f53ae159c6c("clk: imx8mq: remove SYS PLL 1/2 clock gates"),
> This patchset is to remove the pll gate, but still keep the pll out gate
> following NXP vendor tree.
> 

For the entire patchset:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> Peng Fan (3):
>   clk: imx8mm: remove SYS PLL 1/2 clock gates
>   clk: imx8mn: remove SYS PLL 1/2 clock gates
>   clk: imx8mp: remove SYS PLL 1/2 clock gates
> 
>  drivers/clk/imx/clk-imx8mm.c | 49 ++++++++++++-----------------------
>  drivers/clk/imx/clk-imx8mn.c | 50 ++++++++++++------------------------
>  drivers/clk/imx/clk-imx8mp.c | 48 ++++++++++++----------------------
>  3 files changed, 48 insertions(+), 99 deletions(-)
> 
> -- 
> 2.25.1
>

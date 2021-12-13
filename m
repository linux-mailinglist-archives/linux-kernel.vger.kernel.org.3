Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74F7472B54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhLML1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:27:30 -0500
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com ([40.107.21.61]:23904
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230209AbhLML12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:27:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8WEfbfpKSR4++eHyGvQEiBMgXUVFai2rDRE3g4ef9RVTgUuHvE1az66SVTtpDteam4q64b3DSNTV3tVeXHpLG9CDB5+J7meB8mxm2v4UEr4oiP1gpd+lYk+3E33PirVKMt7ydFGI8j2pq56yu72XZ/vS3vvUqZwAuGN6+VOaSnmo5rva+0JX9713pksEg1EBNMjpVXFkohIQsvPFIyqOP9SQqjQwKc43XVOyMWb1dPTdvNDLwpb/RctL1LBB6Z/wgWjs+xvqsxsyOUEwCb8N18osxDkdzHaH2JIuJGSQ471CJ4A+AONXFBtS15rGB7athgJQ/tRw/97+TN5meV6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qh5RypPH92RzlAQBiXHxNBel/5tlHuxbE7piBZqe1g=;
 b=CSgqGS4SXf8xoiBV+Jsh+kTKCecdHjvZ/d3EFCFruLVZzY+yc2MFefWz1HANdNtCnd/4CBAu17QnSX/lZb/fQx7LR/GxGk9+hxi33Y4Fx5cEjQZFj4L8jcRcmZ8kITW51AslbAt1l9wXSiv2pmQBJEjoO+W47akHGp3SOprcXqzAVb1iplrLj0xwT1qs6mkwSnwjyxAtJPxURsEEX5Xta8URXIg4bE3der1XBBl67Nk0RH3fIlZODkeabgGmi0ZpdEbjId+BSfbr1K9ZJSVAMgfne58OJfgGgVp7BJqsGRQLiFsPEZ7RINOfijjRXngCu+MsnvRVCtpWoLuvP6QImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qh5RypPH92RzlAQBiXHxNBel/5tlHuxbE7piBZqe1g=;
 b=aMJLPleUyGOoGqW7+H5yil3Vl0je0XarFvKx/CECtOwM5JJ/RY70pSayNakXR5MLa3o41q2ZqxrP4ujWnxUEU364WiATSm6B3qsVsOrgbrJyg24xjL+xxl4h6NUssEzxR3EgxdIWQ/CXipkuzhOSfpO4/mUou7u5SY/pQl5lgs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB2864.eurprd04.prod.outlook.com (2603:10a6:800:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 11:27:26 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4755.028; Mon, 13 Dec 2021
 11:27:26 +0000
Date:   Mon, 13 Dec 2021 13:27:23 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     miles.chen@mediatek.com, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] clk: imx: use module_platform_driver
Message-ID: <YbcuG4nn4Dicdl9n@ryzen>
References: <163087455086.405991.14496690646389782129@swboyd.mtv.corp.google.com>
 <20211105055932.3432-1-miles.chen@mediatek.com>
 <YZlchKnEqWN8nKQk@ryzen>
 <20211203015714.4BCBCC00446@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203015714.4BCBCC00446@smtp.kernel.org>
X-ClientProxiedBy: VI1PR07CA0304.eurprd07.prod.outlook.com
 (2603:10a6:800:130::32) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (188.25.169.131) by VI1PR07CA0304.eurprd07.prod.outlook.com (2603:10a6:800:130::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 11:27:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be093786-acc5-4dd0-1ef6-08d9be2b89cd
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2864:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB28640D2EAC4A08FC66DA14D2F6749@VI1PR0402MB2864.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye/KNcL0UHF+XQp2jmrLULkVyezdj+1aLoe0Q24S0pNyV+Mu0R7JH3vzQ2pgwaS2LKa0Qw7NdKsewIZ7uB7i43c5hZV/2rrLBZlzmAIrHK1JKswxLt2hYc01mEVvvhqvFYhijBTfmu3sbjAEs5gjulnnnID2nRdJppJ0FMLZxn2v10a7nN9pV5z6Vp7j4e0Yidb6QPSxnMWRAsdrOnbnVAQJLrE7vCyYFEk03SdGI7QeV3pLO48fhXt47mqPhT8ZdYf4HWO+qs4X6T0kUmnpzFzkejEfRuz9kW5GMNArzMwu68H38HjqjWKCeLPJ891JrIOZtORfVYNVCyWvpK7G+5nKdCef15sNDAnUj/z+4vwCXuweYuo8Y9yuowXf6uaLaKxsBo2MKIE4vkpLJbiz/U2omST3lIe/mE+HCyyRpTuxVN+2uY9LHdxpJ9OLRyrB3IF+bEpm06BtS/5kmRtzPKWR2sCYPHYNzR4Ry7eQSWIvkJfX+IPKfuS1/WJndlYrb/YIVhWOuZvsUEV+E/RKdTVOXpHZvYesT7m5gkbtOeymqnto8Tg6h+SIO/rVDPAGt3N90qCpNdgz2vipofKUTFmFyNm3ixSWw2NwvurYeBgt6FfTD7WOkoU9bYmfhVP2wX7li2yedItSBnDWnf1iI989UaB+auGOwtloCEqkIwpBT5WZ8M4NV8zM/Uow3fI+rG8OjOVX68is0g6O8+m/hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(86362001)(186003)(38100700002)(66476007)(956004)(66556008)(53546011)(8936002)(38350700002)(8676002)(66946007)(2906002)(316002)(83380400001)(4001150100001)(33716001)(4744005)(9576002)(508600001)(6916009)(44832011)(52116002)(9686003)(4326008)(6496006)(55016003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzngEfI8YAKgOazAiK5BfTSxpnB/DQf3Sz6MvfFc+KHhaf9tBp7pUpq40/N2?=
 =?us-ascii?Q?pySl6/BqSeGQgXI2bY5TVJfdFLfM1fp7HMRlypMu/835fCLwPHiU/vVteNTJ?=
 =?us-ascii?Q?+TYeiHH1KOFvXhqQztLPkRi3ViNXWPuDVnn7Hb48PQOCOVPcQjjCk+dGNvVy?=
 =?us-ascii?Q?R1GisJbjo9W1A0RaYtRiMVzCza64fSrzSJpSw0uEM2HCkionOFJ6of7ssYIK?=
 =?us-ascii?Q?urKnMmSEERANvAFgxtsHk9+qFCh5hFdo58lscgYKoWPkx3ALFo1GP7s94FS0?=
 =?us-ascii?Q?wjUrYos8x8gRBfDiOc0EEMdbm7Apn7kc5xODtLM9dqQQi8vzBg0ZufTyI8qJ?=
 =?us-ascii?Q?2ZE1SqgwPg9jFv82dls6sipRLveTvPpp+5uuVqJwNBIa4oxxPnxfUjy9Ni84?=
 =?us-ascii?Q?MUI47DE3UlPe7aaXU8GRMzXYaVT/BCuVKcx/8UsM/6tIK2LM+dWim7/ziRmy?=
 =?us-ascii?Q?zdEAjEjyUTq9TA40yVEPlJgj6oIeWNM679gplmSLsPdoeLnoV1xhSPAYifVl?=
 =?us-ascii?Q?XzDqxzQf0X9B7iNX8MDbT07/MIUda1G8jW0dMv+SqS3ACQOb+KvX9bFtAQek?=
 =?us-ascii?Q?g1m2FAJw4j8et9iU4zvkGNHDAxjogvDWe+9o5HBowKreZnq4qKC2YyUov4rC?=
 =?us-ascii?Q?DB0h8jGocsTnnJXuABj/DbK/cVMs/Av35u1DfqzrZkDf7YtzfKvydvFdt4ke?=
 =?us-ascii?Q?l8qGIHTsQoHNjX47YcNNYA8uDYlBUb8lyP9sRsHymrvXMzXXoF5zlWbTQSGQ?=
 =?us-ascii?Q?2bXVvyg/eWldAm+ZBOd69quNH2oCeMT/ngUXMDMOSgkDVXJbX8JAzs1V7B/Y?=
 =?us-ascii?Q?sN9EJpzBVBM9rO+SeO6desi8LhWHhZZcecOxk4hrV0U1lztnUSPVDTJnUX9g?=
 =?us-ascii?Q?+z0l2FB/dUoZCQgpour1E6d3HD4l4cF+oUMSmtA45cMtMu7qd3Tg40sQXwch?=
 =?us-ascii?Q?HtGUu73SKLD/vxYbEANh4ceKALsUhtdl6rGUuI3VCOkZCiBv0Jtmh1SBt5F7?=
 =?us-ascii?Q?FcUXz3mEKis3uwk24D3+HbaSMYh72+zWe0LNG9DxlGRQTmzbz8i6HdzsDXo/?=
 =?us-ascii?Q?0qcj5OHZIIJOPprUcoD40uzGPfoqZpFLiFi6RjEwwbCUpaHc/cV76i/G1wxX?=
 =?us-ascii?Q?WjxWsrhleTQsvk+G2TfayeRIiCW5lHDKfiOaMcUTf7aOz6bejZKiymBxbe7c?=
 =?us-ascii?Q?GpP/x+F0Sx8YKkDOefwkQ0Jw0GhWesPKJm2/zVu7pbvSEApC96vqMHap1/2q?=
 =?us-ascii?Q?4qosSAkIqx3rzcVtT8PKxJbdnZxT0pRdjDHj8mr7/n+pAQVQsm/oXZ2dFzY4?=
 =?us-ascii?Q?/7kdM87Qhk41GCc8Kpnnup2IBHvKqeW8KlY26HOyV5ySGgUCFDHNuyXLry99?=
 =?us-ascii?Q?Tj9k3k3PJOSEZKvHfQy5hjRpmvdW9wBR7+o4TtDlFsS8FK3MQt8Dlfk3lRTm?=
 =?us-ascii?Q?KayGnHTUTDsrKZpFDk8kLPejyGWjrEvCImD3ClOPQ0M+2dauNoSCd9CSiDsy?=
 =?us-ascii?Q?B6uvIHrGPiAuRrUPl1pCAWMzqBaRnR/tsI2nbAkpfuZnRN0ujS2AV6R5Np7N?=
 =?us-ascii?Q?JHeNCV0/K2K92OwG3uTOdy/ZV34lXWUX5tHAn0xyeAONtOSdzRV7/5DO4YY+?=
 =?us-ascii?Q?ByLtzCV98y4BvDFaFnJH8OM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be093786-acc5-4dd0-1ef6-08d9be2b89cd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 11:27:25.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpEEsx+27vBqTXsHGNntjCgP+EM2ey9/fcB40cG6HvrdNI+zsFqVYtB6bsxfGMtZTazUyqQE87tr+NC5HZLVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2864
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-02 17:57:13, Stephen Boyd wrote:
> Quoting Abel Vesa (2021-11-20 12:37:24)
> > On 21-11-05 13:59:32, miles.chen@mediatek.com wrote:
> > > From: Miles Chen <miles.chen@mediatek.com>
> > > 
> > > Hi Stephen,
> > > 
> > > >> Fixes: e0d0d4d86c766 ("clk: imx8qxp: Support building i.MX8QXP clock driver as module")
> > > >> Cc: Fabio Estevam <festevam@gmail.com>
> > > >> Cc: Stephen Boyd <sboyd@kernel.org>
> > > >> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > > 
> > > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > 
> > > Thanks for doing the review, I cannot find this patch in clk-imx tree,
> > > Would you pick this patch, please?
> > 
> > Sorry for the delay. 
> > 
> > Fixes are usually picked up directly by Stephen, 
> > therefore they're not going through clk-imx tree.
> > 
> > Stephen, can you pick this one up please?
> > 
> 
> It doesn't look like a very critical fix but ok. I suppose someone could
> try to use =m for these files?

Yes. I think this is for GKI.

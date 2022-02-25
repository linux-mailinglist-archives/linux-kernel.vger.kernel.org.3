Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A54C444F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiBYMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:09:10 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140088.outbound.protection.outlook.com [40.107.14.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7171A12AB;
        Fri, 25 Feb 2022 04:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HefMdErJZkpFJb1+8Nons6cgWeYaqsmpMyO7I3tPTtGR11gsalXDImsCsgNQn1lebqxNS1Ju76eQ9nWLgG3R5GUaaoZ9w515JFK5KIuf/twEt8G5z9YOHz6dSqW/kk0zw01g5zfn46U8b3FKn5fb+woUjKgLGXKs5X2MXmU7LNMZRD0FhJHUPwNUjEFjzbwr6YjeBKDP2ExZpnhRWVqyt62jwP/eBzfelXvr+6SxDHIz92nTDRirjegnkauc7wy7IeTXiuSLoSSwdw2HLFDmJhZpP76usOIgvyGX7WHiiT3fRia+poCwaMIYUv4MrIoGjkfMXw8hXQaJ88r4PeGYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6FVKHaEcmtFCGmOX2D8PuxE22kMANmq3WyC0j0u3Co=;
 b=JrTB9SAuhyRoMUei5oTdR91L26hu/F9l5VbL+jsPvf1o4WW4nIbmyaJL3DtTobk6KdZXquYfd7vPy0JRXqC/Hy9FwMOIba0u08edgzThcc/PF7OruaVuau7KqME7Lgo09kuwkt3o2/agN91AS5ePs2BxrOybhrYeNOm4ccwg08eswxE1d6z8MyWQagO81EramDGGYQVWlaffEazy/zAGVOXbGVpZCvyFXAShqJ3x3dQg77VVhD0JFMRzpdT31T0ZNqJ82wfHc/7l4CIkCV/GSQYSpVFGK2BZ4BveroP6AJGWUoeD3DMf51CA/2/tL76lXBiJpdfhn8AJ5RJ8f/AnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6FVKHaEcmtFCGmOX2D8PuxE22kMANmq3WyC0j0u3Co=;
 b=N0AdWV/eIMN7l9ktMqGa95R67YnZHBrMyEgoYrEGRyrl03N7VGmM79MSm7/WJ8wCDtvKgaeFmHY2iQbezAtVVMnTcI2K+qnGfxUTbwYLrk3X1k7ufuklSVQjY4McwMJiVD+LXb03SAYZBrHDBQlRIusd3Okyt7gbomu3C1JsoEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB5827.eurprd04.prod.outlook.com (2603:10a6:208:123::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 12:08:34 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::144c:129e:befa:2602]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::144c:129e:befa:2602%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 12:08:33 +0000
Date:   Fri, 25 Feb 2022 14:08:32 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx8mq: add 27m phy pll ref clock
Message-ID: <YhjGwHpseO9SVuCr@abelvesa>
References: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
 <20220225090002.2497057-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225090002.2497057-3-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR06CA0098.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::27) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c5e8378-2f07-4a35-1ae9-08d9f8578b81
X-MS-TrafficTypeDiagnostic: AM0PR04MB5827:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB58275FAD115FBFEC9C8FC5A2F63E9@AM0PR04MB5827.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbtQLkn5ocSGl5S+ieJ7phc2EVzg2Z9U+64fyBRKU4o4Ryzx0dXjE8oAXBkgfhHWyrAGsIaQXEQZ7OSK5jcn3vCHeP591cYD/cJfIUmigIkrHgnxCv1s3/5tl2vjqPdmGmovgir7KmNZEuhlNNfxKTtDImvpEqVi8PfIYLIllgTIlDkpH9W4LAF5w/UVbCpkijcvNWOzqAZAxQm6fJeLce+X6nQNDV+toKOListhZHK7heqjYttkb6smmnwxZK6TTlV73S3UnTcruKPoe9gwYyjlzx7A3PRbjfsVW4fMIcbry0hVaMg493C7J4L+IZf4TnHvCW73luWYlVmvw7MTVCy3Q7n+xk3sYiESlly8RT2Kz728uTBifZoh5t8MCVNJIMW2TpvyvE4TU4xVvOza4lEtlJEB6St0tH6LFxudiBlKzYH1HLRdj0BzYjm4RYkidT9oWvrRgM5rCrFl+rwccg2zZ4AeZGbuACifz+ZfQKvviWRa4IPtbrVg2Z6gzIHWIZo0n6UXfbYmYegTomZ/2mKU2l4swHmMPsDFvdNRqGbWldNyL4L7pMLee6Uwc0/wpqFILf/z0IZw8oBs6ew7x3Ay3JxsCYZ9odKrqSxCC8N2yNI0wNfISue3fsnS0ByJT5Cb1MiBpImrQapeJTU8O/5MsCV4zz92jmpUCWn8WKdZBLL/8JbTboohn7dEb2wT2FKolcTKZhCdj+5mtzTcl2UAaTdmj0x/8zCGbnCg1hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38350700002)(38100700002)(83380400001)(186003)(26005)(86362001)(44832011)(316002)(66946007)(2906002)(6862004)(66476007)(66556008)(5660300002)(7416002)(8936002)(4326008)(33716001)(6506007)(53546011)(508600001)(9686003)(52116002)(6486002)(6512007)(8676002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTBht/sIh2F7risLK/fYjYesfavqL0utkczS6SbET3JicxM86nq278LJvzlG?=
 =?us-ascii?Q?SqsOxXrzPsrPPvRk8eyP3YR7yNABG2TNb/bROfvPKFhHi4VPC67TO/Vf3FDO?=
 =?us-ascii?Q?J24LedU7u8y/V0ZmsJjpZsVwnSG1WLlE3zsq0BsR9aDq9F+VwncCCsD0VmAF?=
 =?us-ascii?Q?qT9MSNE3F5T/FnC3OmQ+yNAHk5VXqmYqN7wI1cez25jf8kFZp9Mc3aMtZ09f?=
 =?us-ascii?Q?8DfIgN3wTbkElSH8Cf0PrWrMnOA8W56jcA2d0T+UH3onMiVmiBj2g7/TFSib?=
 =?us-ascii?Q?+gcoA8HYIcUL8iN36qYl7PwcPci0CrEs/0+bJDwJO2UIew67M9uvimnBLu/m?=
 =?us-ascii?Q?/OGvQCBJCardvSPqOQ3FXCs9Wo9AZpfdNUZiyrIkk8qxv3QMH+D0zScGDNEd?=
 =?us-ascii?Q?oDKVXiyOqFJcVVRrDkYj1VHT3Rl6IWk1eJXJ7ROSE+iCvp0J+2w6nukAphLr?=
 =?us-ascii?Q?2L2vXipEcoUhuBMg/u/VRG8D5y+3ApcAYxvDn7EtoKSvJ99jaBhByMdfSD55?=
 =?us-ascii?Q?xFgV+sXy+tvHxo6P/dVAcldM149mvZobq18+1CIncjPinXl/MCx7l+WYrAEv?=
 =?us-ascii?Q?cV7raJGmpk+M3zd11yyVlij3bfILG4Vxrlsc5fuyur8Si/gAdZwakUWQpNE7?=
 =?us-ascii?Q?opb/3n9zDHF9H8Rk5TAh9wcWU9VapsEFDRZOXxtMeurp2hnrmdl1PgRZX7kT?=
 =?us-ascii?Q?DDebF+HBdIIfIuh+3Uuv47lar7oS8AKFDOZY935sAuheFkxNCRoBfedAcPj+?=
 =?us-ascii?Q?qdQj0OjT+galhj2pKTFGhiKNkNb0hV6nGwjbdQ1DItTLIDD28fswSiyVTjJv?=
 =?us-ascii?Q?2nJwv7MAkueoTNK49eUq8KEgTTM33bUa5yCymEjAsg2MdThWWrF2s7NEYVL8?=
 =?us-ascii?Q?81wLawsLrKLrqzFVwia6SSzBHgaHm5H9zbMx49sAixoC70+yAc85GkT0TLN7?=
 =?us-ascii?Q?wdoNCsE/uPmMSCd+aX9gt5OypdD7JxHwNm+ijOXri0QbaeQKdNuMwYnfApqi?=
 =?us-ascii?Q?jrlbVjkRwNPZyEfTGL80jAaaJ8gfTZNoxCq/Cxv15L8ZCbYdEe3PyDe0hjJ8?=
 =?us-ascii?Q?UAwdGlkyAqppUF6xvO51CJsZDPX0Al7r9SK1PmpqTEf8wCy3AchIRP5p87k3?=
 =?us-ascii?Q?dBqFr+CaDueGgIkfMFMUGdG8MClESkg10xXD6fz1HNsLlAriURtww1oU8z0G?=
 =?us-ascii?Q?mSUNfF7h8dx1IWNKIsVqGXEmhQBYrpIuAtUN5QLR1L1B4riKBv4CzNixZVGf?=
 =?us-ascii?Q?opTghW/P4mxmc8QIBuRtQCQC9VPwViUSSXkb4tvm+0lAp2FZ/TSBkDmgSsve?=
 =?us-ascii?Q?c+s7daGj4FvE+GUfGy1mDU2+PqHH2TDBgQXQgzmGLj1gJGr7wBaPJmHrnF/m?=
 =?us-ascii?Q?7NKXMEhZ2Dow6Z8SN3pRUGePtK3exvlYgUrtBk/8sFe7j/U4MXehQLwsADJh?=
 =?us-ascii?Q?F4Wq8uql1aOoH0fd8k1lFtvLO43pQ/1s0tOP7lYxEkLMweYg/pqvxI02SHjM?=
 =?us-ascii?Q?Z7dHQfq1SO7sTdL9KIMMKlIkWLS5t+4PRCNFxNF+6BBLl8co4PUqCowBIRIB?=
 =?us-ascii?Q?KE5PXa8GCNky5ydPmWXY/jTZGWKuTuiKtrqqhWr5cPTmU23SqXx+kwDX+s/G?=
 =?us-ascii?Q?s9Ynaz6lfEabfuQ/x6xysNU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5e8378-2f07-4a35-1ae9-08d9f8578b81
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 12:08:33.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfJ75FtnXAeqFLsSh6c7sS5mas2G0XX2UN8rNYTYgg/utJst+HGSFiKnI1YKDSBdgncSqLSkDtEXMeK5qTBcKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-25 17:00:02, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> According to pll documentation, the 3rd pll ref clock should be
> hdmi phy 27m clock, not dummy clock.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 83cc2b1c3294..a9e69b6355ed 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -25,7 +25,7 @@ static u32 share_count_sai6;
>  static u32 share_count_dcss;
>  static u32 share_count_nand;
>  
> -static const char * const pll_ref_sels[] = { "osc_25m", "osc_27m", "dummy", "dummy", };
> +static const char * const pll_ref_sels[] = { "osc_25m", "osc_27m", "hdmi_phy_27m", "dummy", };
>  static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
>  static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
>  static const char * const vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
> -- 
> 2.25.1
>

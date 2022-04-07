Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4024F7B69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbiDGJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiDGJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:18:58 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10085.outbound.protection.outlook.com [40.107.1.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1E7DFE9;
        Thu,  7 Apr 2022 02:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAZQA5Fgp0N1wI/iYRZ0JJErEFHh6rLeces+vhstU+nZzJltIjv0jFed8Y+BtCvIO47DrQzVlklc2O6wS7miXQlDT5TlM6uzgqKZEkgdOgGsgK9RGNw/uU9Wne02gm/hc7uT9QEd0W50pBy/RxqSZUtO+bemuGDMVZUL88E2scTC1zFc4MqgkFQyzeyZ+XDjLTuH7Pj0BMiC/CtwlLbyYte7fOkV+PNQ/0wb6WC3JWerX6NmoQMeTHugBJ6y9g8m0ZcnBpFzHwP99U7ZI67+DKOZQiAfcmgP9e7/UJqP6nyfQ+GAHW3HiIijsWvATWlm9UyBiTcyTEPDsXIbIimkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E96RVyaYvCFJVRCmAgbAZqzIKO23qb2fIFoieUi+HPQ=;
 b=eLGdbarLAkn7yo89LJm9u3vdXaENAc3Q1VTXkZhfrzY8rt3QLbTFHREsMNfPg4E0ZJH/FfjWgw/S6JK1Cqhe9RFoU1+Hf0NJCQ5FhJwksn6CUjSd4SAuofp0qky2vJeG7Or8Picob9cXABa7jWKjswlYj2qarYtRr1itZgMLmGhCem+S3dAe8rMhA3R1z+6m7412V1nYBAUg/AXtaHvKvjmHFQ2nk100Gi6PkOYP14wYDMdR5d+cixu3evj5OSqWcM/7Wr2b+4HvagnNapmBaKG2LPjihUpIDyJ84W26CeO+PnFic5ckVWF8nxTBpL3Z6GGaDZu+Xh6cq/BHyraZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E96RVyaYvCFJVRCmAgbAZqzIKO23qb2fIFoieUi+HPQ=;
 b=YHQVf+fJOaKR6LRymk86gHNlimQftwBNY9aZf5dI9xhS/0VVqeMBZ249PUOQdiKf6wdJcyGSC3zpjpeueRYU3beNTewUmXk7NvgEJCTLGHq475HmTpH2Z/FXmkD7Af56VuwWcHtLviP/sl8OM1EVM+wz0oagQ2Y4h4+3QbyFFLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM5PR0401MB2579.eurprd04.prod.outlook.com (2603:10a6:203:37::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 09:16:55 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 09:16:55 +0000
Date:   Thu, 7 Apr 2022 12:16:53 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx8mq: add 27m phy pll ref clock
Message-ID: <Yk6sBUhus7XWdYy5@abelvesa>
References: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
 <20220225090002.2497057-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225090002.2497057-3-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:803:64::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce55d3b5-8897-4b27-00ed-08da18775c23
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2579:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2579F7DC8921404329EA78A6F6E69@AM5PR0401MB2579.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eriA5U/kEDGIkZuIt7vdQ7C2UjwHAFp2pFtIZo6OQM2VX84ScGxK2XFLFs8IsbJag0mLrFQN+wPm3IpgEHZW9TA9PZNKNM7OqUEO2MrjT+bjDLem4RNkhl2EH/Nzv4hbuHk21bwpuDxAvO4YUqQbsw3oNZMeru6C5nZh4NF0jpUTTIO6sWqoM9uC7B9hbM38N9OYtCVpw9docqXMpoJLc3+ImattGLiJJQhmJ6UUY5U7twIKNRkRhDwr7kAeTDkSGAU2Nv5twQ3Ev/W8tQwN8PasTmzggitdGiEh+p9VvIo8RRv/ULyuphP0mKw09r6agE1a44opXIg843SxzyCISLl3h+/1xdu5NpF0C32RfD8FEODP96EpladknhcA4T4Xvb8jnTb7yN2neyPWVdpqC2lSbTBmJFr3N90p0h9RhqmsGU8Ipq3QI4cHOCURpCvzkdn9+Mv7KB0jayVGNW4jKzeBLsHjlrFPwcPbiBHX8Kco0/nXbkItdPj+iTixz/zS4cFwMuV0wJLkugJ8I7+vuifZ360gTIckOyz9WLI1EJIgDYELo9pDYSnvI8bwYtOF/pnRgRzBkKfgbHOOIFWH0HV9+Fm6Lm1j+rRA++hTy0e+HF9CMeqLV81hvXnC+jruXs16dEbAEdme3BTfwcyloBnWI0jc4n2VxUloQoKGnHk40bT5zT4r4uWsxJkavZULHVtV4+R65fNDgeyL8ny2EzwdbRozluZHnifP0E7IG0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6512007)(9686003)(7416002)(86362001)(26005)(316002)(186003)(5660300002)(44832011)(53546011)(52116002)(2906002)(83380400001)(33716001)(8936002)(508600001)(8676002)(6862004)(4326008)(38350700002)(66476007)(66556008)(38100700002)(66946007)(6506007)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rRdagD4fbjIn3W4om9ZgVKXx7niuFzzH/8OsN13FA/Fi0JbZcoLSMBHv6V1D?=
 =?us-ascii?Q?SYrMLsfbBEFqbweRUH/visCAdqs2fFv03sULEky1Vg23N6+hkhSgK1tYo34m?=
 =?us-ascii?Q?ZVuIWl+Vb2G0mGMzz2bVwgOj52jzow2BVHQssW2p/TSQqz56Zu4xLpbQpC8M?=
 =?us-ascii?Q?B+g+GJLlQwRZZiAFH0eBbnZfHLA/grZ8MgGRRYpW9CMv73bF1FjP6Rwi9uwl?=
 =?us-ascii?Q?QB0ABcDq4SHL5kSiliQ7a6MdqEJwh3w4xMKsftEMJVhq9bImw+3+QSncZsS6?=
 =?us-ascii?Q?f3hWk0B4K43YGupeWQuNBPZREL9VSN9iaO9jjXoq+vrcl+v2J6REX+Mk/JeA?=
 =?us-ascii?Q?6gl5+7Mx20swN+7eXgTDIU6BVa5jrxfjznWtGh/M1OwWb1vFswDwwN3uKl0K?=
 =?us-ascii?Q?utbcktM1/wlxxLaEZyAV8MVjjZdu9bBvFHlUw9yfQr7D6o9Fr479q0o2vlwV?=
 =?us-ascii?Q?ckLP5PBTo+3MZHrcZ/KXgwKbDWS3SV8dYLRjEZThjpVPmZ9oFJK5pvs5jCck?=
 =?us-ascii?Q?Nn+ebWvg6oz7tICwB8UrWUseZgNh0JQL6EYDzrUMwUEg8c5sodRDlaNeq3f/?=
 =?us-ascii?Q?mA6by23ulkRMuo0BMQvme0TCg1oiildWsJYlGYZowmeotmmyiUBAMUP/++O/?=
 =?us-ascii?Q?TU7Fw0CcbUpouDj5O5gQ+Hc2RXiuDAcqiZrptKA4Xi97p9hE63kCy9u3sz3y?=
 =?us-ascii?Q?sp1Q6vEQRxRxXADwuDucH2K+OACOKEaEI2+HsEPArKkwMnhhjf6F1uSdpEEx?=
 =?us-ascii?Q?ppZufJ5fMUwKYeTQL6L8loT6uwV3Hz/Wc99DlbBytUIAiC06oW0V/onmpdHp?=
 =?us-ascii?Q?1Rpix+A6jOZ9f/7iCIga/VM1nGQylcLSNSGfGVj4HlGgA1/v3xD2l3VMgPp3?=
 =?us-ascii?Q?aBXJLFUavCzhs3VLGcamfsNKLslb8QuywS/Aui3M2aEv/MrTZJ9uf/9/pNUG?=
 =?us-ascii?Q?MgdtlzaZeEahRsrxJ/UQT4cgzwy7xhyviSliFx2Ba88JNpHgrCgiu5r2Yp/M?=
 =?us-ascii?Q?fvDoy5rBr/p9FpqwHDYJk7Bn5U2puRpeMOh7Ft9A5QzNJNM6aqqrIZlroDUA?=
 =?us-ascii?Q?9oUDpcf5voXWPs3MdICXTyKIbJ2eprepVEFxImKoS5QNyAnDd58fNBZ4R+nD?=
 =?us-ascii?Q?Dd1ksDfyubtc7iAtuycrGNmiYjXVSo17TIe0S2UK3JCxeRx3VWWak8Xjuuia?=
 =?us-ascii?Q?kOe4GeYvvSlzq+JNbbUgoOGK7c60yHIpPPFsUtkcsS5p7ENVcOnBRDo0jDOs?=
 =?us-ascii?Q?MqkdFBQ3qzcxFoHgAv5/zPLBMZkNh52E7klRc+FGxbpF0cnOBqt7ChdpqKBm?=
 =?us-ascii?Q?24TFI8+QKNtR2Z9Lm/ehYliMeWMf1CM2bq96gGncG7v7JWeKuD7RdfGgTI2m?=
 =?us-ascii?Q?sgt0kZK0kd1hdzQAu1DfSGZI9VzxO0KGcXgKuN7YtJttfBcMXeYYgH334Dx3?=
 =?us-ascii?Q?CwblNz/PGE3smH/V4wC3Rnta8ESAl/LSLEa79if8pmbphotBP3F0HWlOb6Os?=
 =?us-ascii?Q?NiOjuLF835ykWfZHmAkhUyuLGA45ntWv3yLZy2+WEqrn0dFLVYJM0+8tNQCa?=
 =?us-ascii?Q?cPzR1PTvRCRcqlOAOLTOqoMPWYoyGb1dnr1kntGPmRCJJJO3TDduCXU8rIdA?=
 =?us-ascii?Q?iFt+EiomFWSq0YDd7guig4GpJVBeHNYGrJbNIQX7m++t9Z/5gxn6EjSs8Y72?=
 =?us-ascii?Q?3iO4KqZQUqctLxQAUN2Ttn87jfV/KogVRLj4U3WtnxisW+XgzMEnPJdt6A6p?=
 =?us-ascii?Q?/XrpIISM/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce55d3b5-8897-4b27-00ed-08da18775c23
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 09:16:55.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI6qCsQ8n2Zmu0uyb+xdWuEerM0wikumgQXqLf6oBhi0ASR91ojYj64bvDZ6WMsmFlG5VtcgT+N6Ulaojkykpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2579
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Applied, thanks!

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

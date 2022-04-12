Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09404FDFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352366AbiDLMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352911AbiDLMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B779B6;
        Tue, 12 Apr 2022 04:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmDPkc0ro6Ey/nAhl7mrDEZSxUT1iYVGIhLh8+s4qBB3igDz0fs10sHRElYMyJX3bIge32N7puXF2v17rOZ456Y1ude1iPvtSlP3tTYJy1BNd2R+sCejCTlZZ0QsDCCS1wSk8usNXk4qWYiH5B9mqcmS4LLzNF8ADoC+Gd2CwiSrMMvA5d1q3aqdaf0VcsLt23uwTLdMIBQZlooX9sNWgU++dH3cS97R2v5be+q5mH/FdpjZNNxyUD+H3nimugXeQKWlYLCMPt3A1VXQngsWcjmWbrzHriTJi1Noa3hxUTfQo6ifYOg3YjHUXMPRKwDPyMPHV70ZJs6Q8Jq5lwgTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApBmchM206ziv6PHdYyademKDkFTVG9QuECmRAu0GVs=;
 b=JgJ4nHs69j0ZJtJ+b5C7OBW6v1Ct4SP22FEpqWpMh9MwX3vIaTnN25Futw0nqQEJp218B4LW7Z50Ku3taVxSpI7PuXwe9BPLF+t6iWJVj/1RpAipQhmUBCYd2k7dBMsf4ycyUCsHqkuztg/DcB1mWsER45Hop+2HXpsgrBmRHf+3vIcXDVac3tQgp5CjAzXf/PYj0GZoMgV2unpxubSswNa9lRvMWqjKcqYC1m1r0UfgnsbOUYTIXhaQAKFoTZ+Q+E+ztFxWLsgL2F7uJo45PNK9mBOMq4NxXbKoVnYiD3UsyiqcLSnCpCQ7AIJdXsMWX1pQ2Y7BgS1jVjkMibEREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApBmchM206ziv6PHdYyademKDkFTVG9QuECmRAu0GVs=;
 b=VpbEV2/3AkSNzFMcfwpxbrZVIKqJaYP5GwhgqTNXAxN00gDOf3dw+XvKWcj8KKd4R8nS2wPUJHy+DjAHRIFfZGeXv4MKjfkOlXVM7Yz4WO/kKsQ4gH9q4pl0p5Vc7cTzJ/Fi1lzmaA95JuJU/j1FPaLTlj+MoM/J6zL+itGGpvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB6PR0401MB2567.eurprd04.prod.outlook.com (2603:10a6:4:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 11:01:28 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 11:01:28 +0000
Date:   Tue, 12 Apr 2022 14:01:26 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: Add check for kcalloc
Message-ID: <YlVcBviIvBBId9WV@abelvesa>
References: <20220310080257.1988412-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310080257.1988412-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e50d1fb0-b6fe-40d8-ef03-08da1c73cb64
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2567:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2567213DF0D6B5FD360B591AF6ED9@DB6PR0401MB2567.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dm1PddQsj2UZnyc3Ra+4j2UVqRDhDXMKMPaw2WW2k6MREn2REoEPmx6gIYGuFqxlCR/0lEh2QB8YxJOO46q5xVoHjFf+QDudW81wgpZTdKLdhnUI/ELR0Q2FoWqLtZ5PLdru1ZYbxa8fL347p+vdzaYNYJflza+cupeTv75YylVrJIX98MKoCbj50DBp7AO4hhfshUpxvR8/tsIskYlU1L5/T/NKaTs9dKVnun+Hes7nA12eblxs1Ihd3MT3NeuTi3uSe17n0f5xvhZMKzDb4v766ovgz0MqWrk/Q4t1zR7caSpJSl9h71fRA0izKsuYvu+x8mC9K5wTlXs9fwlbORj6v/oBR/geVIAWzG3zpJ2G8ZQvWhTMQZ0rx3qiZ71pqIQA/A7jJxUpq7slEhm3VJR1Lbr7yrg08piHhQImtO8pLokZz2Dz2dBnGKWSKb/IMEygQqH5mrTaxRKagrTnn5ULSPmBbxICdx2bIn50ISObDVMM1fJS/KhkF17iVNV20wVFOuh2oVrwK/rL/ab6CEFb1xz9YWGJSicy/sZLl7g8+pUr79Hc2jWT3xceQoevjWTEVEVGQbQjxoiwqjSxN6Ma11e3OEg5+az0ZlqSXOydBd7d+ed2os8sApZTk7mZ8jMuENG6t62tFFwLw8h746870LFXvS3vsOCn7dKeaef5oVn4TJr2h0V4k5TWmG6EsXt2NGYOpo029ulcwQpIHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(4326008)(508600001)(8676002)(6916009)(5660300002)(7416002)(186003)(2906002)(83380400001)(6486002)(316002)(8936002)(86362001)(26005)(6506007)(52116002)(53546011)(66476007)(9686003)(66556008)(33716001)(44832011)(38350700002)(38100700002)(6512007)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8gsynWZwlOraSkBX3N6MtCwmtosgLo0nwJGtNP/HtzIKdTeyjaMuNy/MBtt?=
 =?us-ascii?Q?ZQgWtIdEC9GIiNfxNOVr8ZE128QhC4GcO7vwKtaMUljuSvc3ijBsQB+v1zUz?=
 =?us-ascii?Q?XgXzoMdpyn0Yj/Nj2ZGDHYsunWwU/qF12sQh0z31SweRPWSLW9DSSkrgZRI8?=
 =?us-ascii?Q?SepdpFKaXqL4ZuJ5ag32VT27ZMIt75HMLQ4t21uHrHEaxR0BIjnj/fevcT0G?=
 =?us-ascii?Q?92Nh9aolCypeg4dRZxRD8Ul4p9aoLNxrJKeDIaPNJ9cHur863m069urj0Xwo?=
 =?us-ascii?Q?apGRmCLRzIawfDYU/7tOfMs+KC9xoCOO5EPtxNCfJ9Bf/EXmm7VJGQFZVBK1?=
 =?us-ascii?Q?rTef4Hpg1t7AxKQbWWFJQmSh0sJT1emKq/0N+88dzl8jQRN/9Uvyfj5ZAJVO?=
 =?us-ascii?Q?aHCG0B8/x5zucuyLfEqRJ4orl+Ua+vBGuh+OxDJmVkh1McG9553Aep8B1dQ9?=
 =?us-ascii?Q?r34PC6fYFrT4hKRAP3f2FUeM/PA2RJjVwxRVBxhx3Giq7OSxOb1Aa+UTYo7C?=
 =?us-ascii?Q?tw5QGnskEEcyykHAfBtkWQw4pJ38ly/7zLVMK3eMIfKShq+DC4VjeFkOFlcU?=
 =?us-ascii?Q?VwuaTZY5Ku3+9JkUABk+SdRWRb2WevcB+ymmq3+eFxEanmSysfqzpKqec0QL?=
 =?us-ascii?Q?YnpLVBGKcGlI57l80p5X5C1MGE75z/x5buioXj53l7+kB2PvXLXGErT4T0on?=
 =?us-ascii?Q?lFQ1qIb9qe8cYIK4I5pACXJqT2HxHKuOV2f0Z14/oQie+Q4EyAaiofGQ/zol?=
 =?us-ascii?Q?uGtQ1ySTu6YMTsrnWZKE/ErhVdCRmDN7DNwmhDQPidnComMcxHNHyaiU5Grj?=
 =?us-ascii?Q?rE1rpiifmjonHMM2qqUJGT1b79a5ObrQhkiep9ItRYGqTjumc+vKQhgYaSEV?=
 =?us-ascii?Q?XyBLWpIx0xWa9dRrlA950tneet+MvAG60zVj36Nf5JgCqd+Qwy8NV+vZtgTA?=
 =?us-ascii?Q?IAjN96p2MsYwPor9oNt4u3HDJuIMlfe+TsMWLZQ+hoJil6vO/rSV+kSDdXIs?=
 =?us-ascii?Q?qRMBjZveHHfUkw+NBjdvm8O+iXwShHBte7nvdbJssLNQHF8QB/7sFNCFbvQR?=
 =?us-ascii?Q?JPgEToGYkCcrLejwjMLNjXEhK1R9PYuWMAxDBf46dgecQMAq4TEBY0ymviYg?=
 =?us-ascii?Q?bKRPO1OAbKifa9Ysxb8vZmrIZEK6RG3ihByYKClGlR3/WwFVItIAj9Uv3YJm?=
 =?us-ascii?Q?YbN23aPAdUMNI5yFRdkf3vj6MmpWHyyiB9JvLnWPL2QqhAgqg0JAR6CCk/P+?=
 =?us-ascii?Q?JqX/3XO3/Qw7L/RbC5g332jYPa/EYwIoJ7kAyP4Z3+ge9Im+Uf9b0Rzam0Yy?=
 =?us-ascii?Q?E4Hvyp76laUzMBdzY/SaNtJrH7mT6Ret/w1o/5QRtw2MvjHHcVM4aIVcOyIH?=
 =?us-ascii?Q?b9Ou7iVZ6PeVD3sUVsfnwfEqEOClwGYKXkCPtCTi/VVoapf0ewpwP9q1WCqe?=
 =?us-ascii?Q?BWiK+ZqtMylnSyiiaLrRKqnhBIJOx+Ay14CME/RhbZ+BBACc/nbB/eQ3CNfl?=
 =?us-ascii?Q?vZ61Ra3ieLwRuc7qfm2xQA5DjXg6Fz8f/moll8+9Z/9Fe9Spdwq/kfRM2p6D?=
 =?us-ascii?Q?FVQBPWffMsCgpyeJvaJkBNawUoA3OCdNRM6AnUWyvEBZGECm7EL9r0/M4//E?=
 =?us-ascii?Q?MNsnBDteV2Sl0ph3Fp+Z3g7a5GwC7jvgqfg9DSGr3UYnHUyOJ+wR39cx1kkw?=
 =?us-ascii?Q?nJVP2CbugmrMryj2dV6WP9MhaihoQTNKWhn5TKJpAHH5A35vRrpE+09Y7pfU?=
 =?us-ascii?Q?T1AM7EHFxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d1fb0-b6fe-40d8-ef03-08da1c73cb64
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 11:01:28.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuNJ8kvEQv9KKRj94tKGGVNf72yUmA+WSGnM/75F7tH+bOt0A53RFUOlY6Emen3bGQkNGvDh87M+wtpWEYlauQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Applied, thanks!

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

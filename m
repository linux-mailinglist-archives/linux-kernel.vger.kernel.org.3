Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9025389B3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbiEaBql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiEaBqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:46:36 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30061.outbound.protection.outlook.com [40.107.3.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EEB532C2;
        Mon, 30 May 2022 18:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhpzPwk/63ImGWRUQ9NAjOvJwZUucsgXVi8QTmoE5XAxgNe6OaP7p5Y/dLeN5pgYiCGcghmvhKZcwoRNu5mfob3aZ5av9L9TXqpU3q0dKeWNJOLVrlNoPUUDkEnNRwHGb8B/3ba3fhVLdFJjN/mSCiK5cvLo4YsUiSeEP/oqYNu9auyNFa+kgeUmrn2bGN3kspzbqpQQniy0Y6SxnpQXcN7eEFVbM7VlTzXe5QoXBKwUHh6IjvqM87BtmiYaHwRQpSOThG8yqUsokmIls+Jdqd5ntD0qmmp7X1Jehvimg27CmfacoTNdMoI/PzXj5doe3TYTJhJb+BldE0t0SoqkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VipeVFFpzim3sm6hxmJM93jLziGZd9izTe8k1WOhRyo=;
 b=iZ1vpARn+8xt8QDvGTQk8YI6/K4hMKa/mnzqkY9xQSWxEtD0Q/ndBVkzuwWZPjutX7JUHhECu3D6Nm7y1dHxR+HwM4oWu6TmIdMEBK5kX6DOFHthTitYFgtLqv7khwNNz5plCBD4dZLFDD1JULYNIRCJqlw2QhFlN55E/BtjwTj/ee7UFeCKHyMYigdQEqOAoI2uFnAz0ohdaIMB/kJaYVt8ih7eizJ6hB+9bQ4XpngOpX4T22pYzLCxlAKeAr2frWJy9ADpYZRaIigGsTFHSw1Lns8JXPkhoPfHpwg7yjvQDtHoO+stgdJufVaf8Sm0DooFW85CmbjqhvOiYXAeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VipeVFFpzim3sm6hxmJM93jLziGZd9izTe8k1WOhRyo=;
 b=nc/JM+6OdZYa2p8iHH1rOLwNPRIencPtfY1XOyr1vXGCSIpAYmpSAGp5v9ZHUiwSmn986pE298oZK2sJKMUArFnn0KMASrIlTdgOUhLu/5/IlqiI25r5NPFUh5ucbgkdS8iKuMv7IaXJZmEcBN0QADzCoQoKbYT6vNZC+Be+EDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB6PR04MB2949.eurprd04.prod.outlook.com (2603:10a6:6:5::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.19; Tue, 31 May 2022 01:46:32 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5293.018; Tue, 31 May 2022
 01:46:32 +0000
Message-ID: <4d7f39188b76d509909b0c6274ad2bd89723b8d4.camel@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate table
 properly in ->recalc_rate()
From:   Liu Ying <victor.liu@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Tue, 31 May 2022 09:45:52 +0800
In-Reply-To: <DU0PR04MB94172EA72CC1D6DEFE03CEAD88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220529071156.2511568-1-victor.liu@nxp.com>
         <DU0PR04MB94172CDB8AE355ACB0AFF0CF88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
         <DU0PR04MB94172EA72CC1D6DEFE03CEAD88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fe57e83-a1fa-4f03-aecb-08da42a763a6
X-MS-TrafficTypeDiagnostic: DB6PR04MB2949:EE_
X-Microsoft-Antispam-PRVS: <DB6PR04MB29499D8A4C93253C9FBC7F3998DC9@DB6PR04MB2949.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPI9bBFWrjz53HdeOKLia7vo2z6iYFqemtxUz1Ppt8Qqtr8F9aHJe2VcBd11x3kT4ZmbaZ4Y6IZPGRmaqreP9lHVCl9UZSHEJf0/407CHfV7CtQSaZutsdEhocfjpCLdFrpAnoUF2VXZmQ0a494FcJX5eooyboCN81xlR0j6ya/CjBVxfcEAgIaaxZIZYfIR1xq5hcB1AM3Aoln14Nd6pAWKfCY+aXXsH707MPxc4W7oVQOvjwgqP3XxS8nyoj0k9f5nF7veRs/BNhkEaZc0v4lR0LbRLxzvltslxUEQVkk5isEnyrZxqiOsx55pg6i3LaiwoBTptn4s7m0f0VKaZK15L8/lz2Gjv4+uuqsyxktnbjfvuMR8d4i19XHHcUP1xP3nLMVnV7Zu9ED/cYeBU5VQF6oKQm7HrLGbCTFZs/tt9Yltw19HxlaggJ1myD2re355rNyt+MU5kLGQFZr/xNTSqeiR0AfBjdIkWxsw8XUcvZWRit+60u22hRsp1dGnUvqCbSftfYeOFuah9yZjV3fUIdLb2iAfzB3atQHTJRuK1bJsmcNG3qJ2E6EDJmBcheBUWmdT3VzLu9lIv8WWOo3GaPZ9ZcWQa1xISN63diZuPAQgLZp3LGyzRLvH58erEfrV5xpwP7kZE4f4OkXOBE9d7Li/KMi5yHUB7WRB2P5F8I/sO7bj5cygQQuiISdih00TJDgKlrTsoxE3GUFl+xtFpB6XvAHh0H8G+vOvvdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(66556008)(2616005)(8676002)(6486002)(2906002)(38350700002)(186003)(6666004)(26005)(5660300002)(83380400001)(86362001)(36756003)(6512007)(6506007)(8936002)(38100700002)(52116002)(316002)(54906003)(110136005)(508600001)(4326008)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlURmJvNjBwMzB4bHhSRitCQm5LSEl1bnpzMk1jOUF6MjBIa1M3K3dBTkFr?=
 =?utf-8?B?ZldrTVNQSVNtUDE0S0ZIem16SVpHbVRubVowQ2FUb2ViN1lxQjV6bG1ZYzZo?=
 =?utf-8?B?dWpNQWQ5S1h5T05FNExnQWsxTy9Gbzcxd2dBV0xKSUk1cFZtdkFOaWt2aGdP?=
 =?utf-8?B?MzdaTVEvd3Z1NVRqZFhFckdKRFpEdWtlUFM0b0pWUnFVdUcwTVVnYk4xaHZZ?=
 =?utf-8?B?WDdBcjA0MU9zQUVwTUNNYXZvbVgyazZRQmppbGpYcVYwbWszVmdFcTMzWkdK?=
 =?utf-8?B?K2hpWjJRb2Nndmh2b0RlVVk2RWlBb0ZPOS8wOHlxNjRVbXB3Yko4by9nY0Nr?=
 =?utf-8?B?ODkyYldLQW1BYVV6cERtOHN0ZmxoQ3lTc3FERFFValQ5T2QwSXhyMk5pdHFF?=
 =?utf-8?B?ODF2NWpHemdSTERtUXUzTDQ5eWxsTndGWjNUZFUwNGJMckJyRk0zZStQYUg2?=
 =?utf-8?B?THRZZXdLRWwzTTUrOWlDZ0g5SWJXUDh6cmtzWk5CaXRTR3NBd0hJem0yOTR2?=
 =?utf-8?B?a0djZEZseHdOZDVWaHR3bVJqN1RnQzVPTDQ1d1hVaTRicW14MktlUllxMEFa?=
 =?utf-8?B?YmZaSUZxQ2ZiUnlUVDhnL2lGcFNLOFJzdnVpSkhpYmg1WkR6K0tWdWFpYnNz?=
 =?utf-8?B?bjc4M1NqNUNSdHVvVmx1akYxNWNEZExMR2UrcmhzYkJ4QVBNNUNrVzJaUHIr?=
 =?utf-8?B?eGpId3pmT3ZEWno0cXNlZnBxRStlWjlFUWUzL0xOUmMrZTQxRWxFOWZUWVZB?=
 =?utf-8?B?bVYyQThseHI1MFpjTllGemNRa1NuUjk0Tm1NRk5RWU1KNzRZdXNzZ3hOcXNx?=
 =?utf-8?B?QStOaHU2NzZYRVo3d0JaWTdZUzFwVGd1bXhFMk9FUENTNTZaL0xid2hubWNS?=
 =?utf-8?B?ZTlFOVI0NXhvak54QWRKa0V2aTRCUjlaK3dsWWVQMzZWb1llT2EwSGZ3SldZ?=
 =?utf-8?B?NUlPbjFYeWhmazgvQXJKWnlyRXJMWHUvY25xTzRZdXFpNFNJVDFLc29JSmhW?=
 =?utf-8?B?VzAzUnVQY1ZpaUZnS2NibXo3TDhiL2xRS2RmOTlvUGp6aVdpd2h0TUg3a1Np?=
 =?utf-8?B?Rnd3VzAzQmxIdmEwVE9Jc3ZHZTVBOGNQc3FGVlo5NEJ2Rlk1ZXk5N3ZONVdP?=
 =?utf-8?B?R2RiZkNmcU04SEp0U0xXektwYWthQTZMbUdEQndFd042cFRqM0pTMlp5eHJR?=
 =?utf-8?B?clZrbGhPbi9jYVNtbWZTV005Mnorcit6SjZWb05jbWNmR1pqeUkzeFhQQkZP?=
 =?utf-8?B?dXBSTCtWWXlkVTZhU0xkd1lyMENuZFpSS1NEYUR5V3lSRklGUC96ZldxTVds?=
 =?utf-8?B?S1U4RFYzSHdBY3h4ZS9RTFJTWVFTdCtZM0UvdzU2ZTg4dWtqaVQ3V1dUTHZw?=
 =?utf-8?B?NFdCWkFQTDdZK1oyWk4ybWQ4azJjRmpUSkl2Y0wxUytnZElKRUJGWWhBMmZh?=
 =?utf-8?B?VGxLbGlaQmM1ZXNLWGFYLy8yNHhVSG9RT0NqNlczRzQ4enQ1QVJlOURXcW9F?=
 =?utf-8?B?TWN0UGVoRVN2c1VHeDNxQmhNUk51L1lPYmd6djY4bkUycW8zdFE0YjllekJS?=
 =?utf-8?B?b1FXRXdpQW9Mc29wOXVqSERwQlFSOXhBUGlaR1FOaEpOSDhRSWtobTExYVJ2?=
 =?utf-8?B?eVUyOTN6N2VxV0pONzM5OUlOeVJaOEVtTS8vaEJwT0RTeFRUczdMR2VnVGdX?=
 =?utf-8?B?aG9lTHZ6ZWFmNkswc1RId0lJUFNVb0xkWGVVZW9XOWZya2RWNVp3K3pVYjdo?=
 =?utf-8?B?UWJyN1JkMlVaaWhBK20zVVEzWHYwTlh0K211QVFrcFdSS2VnNGFKRUMrYVph?=
 =?utf-8?B?WTdyNkpsVlVQdm05azdwb21HUUEyT3M2aGZqZHNvSDU0aldrVis2UVFqaUNF?=
 =?utf-8?B?bUhFei9FWlkrMjErWFpPZW5kcEhNNFdDS0VjanhoSXBzZmZ5T2l6eE1uU3ZF?=
 =?utf-8?B?TGNHbEdBZU9yOG5GQ2lXZnhYT3JWcURSSGQzM0FYVWlXeWpYU2RWV1FzcFRn?=
 =?utf-8?B?WFJ2ZHJNZ2RCbWFyV0JMdEZQYmN6bFFFMENEZktNUDBER3N5RHFnYjQ5cHFI?=
 =?utf-8?B?dU12bnN6Mk9OOGZwYTh6UGg4UHhQeGFjN0RDb1I3SmpCMS9STmZrZ3RnNk1V?=
 =?utf-8?B?SHM1aHk0c084TmpJVHhET2ozdnBRSFB1eVZPYUgvQ0xrV1RUNWthNVZBWXda?=
 =?utf-8?B?UEhqdllRVWRiUlNqRDRpY2swWEExZHZxbVNTOC90Uk1Zb2w2dGxCVXVFRWJQ?=
 =?utf-8?B?UWhKZy93dGFyQ3NSNlIwRmV2bHY0Wnp5MGlIdFBzZzJ2VVF2aFFocVpOR2Mx?=
 =?utf-8?B?bWFpbUdqMWdvZW44RmFpNmFBdC80L0NjeElveTBMV1VOYW8yRW9CQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe57e83-a1fa-4f03-aecb-08da42a763a6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 01:46:32.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVnFcbQMjQQCvIDpDKACUTx7DPY4oM2thnFNcGCov3JHATiqqXfKeqDj2ez0YePvqoyvUHAXKhXXd1Cf8SRIrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Mon, 2022-05-30 at 17:08 +0800, Peng Fan wrote:
> > Subject: RE: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate
> > table properly
> > in ->recalc_rate()
> > 
> > > Subject: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate
> > > table
> > > properly in
> > > ->recalc_rate()
> > > 
> > > The PLL parameters in rate table should be directly compared with
> > > those read from PLL registers instead of the cooked ones.
> > > 
> > > Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
> > > Cc: Abel Vesa <abel.vesa@nxp.com>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: NXP Linux Team <linux-imx@nxp.com>
> > > Cc: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > 
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > 
> > > ---
> > >  drivers/clk/imx/clk-fracn-gppll.c | 24 +++++++++++++-----------
> > >  1 file changed, 13 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/clk/imx/clk-fracn-gppll.c
> > > b/drivers/clk/imx/clk-fracn-gppll.c
> > > index 71c102d950ab..762b07dd5a6d 100644
> > > --- a/drivers/clk/imx/clk-fracn-gppll.c
> > > +++ b/drivers/clk/imx/clk-fracn-gppll.c
> > > @@ -131,18 +131,7 @@ static unsigned long
> > > clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned lon
> > >  	mfi = FIELD_GET(PLL_MFI_MASK, pll_div);
> > > 
> > >  	rdiv = FIELD_GET(PLL_RDIV_MASK, pll_div);
> > > -	rdiv = rdiv + 1;
> > >  	odiv = FIELD_GET(PLL_ODIV_MASK, pll_div);
> > > -	switch (odiv) {
> > > -	case 0:
> > > -		odiv = 2;
> > > -		break;
> > > -	case 1:
> > > -		odiv = 3;
> > > -		break;
> > > -	default:
> > > -		break;
> > > -	}
> > > 
> > >  	/*
> > >  	 * Sometimes, the recalculated rate has deviation due to @@
> > > -160,6
> > > +149,19 @@ static unsigned long
> > > clk_fracn_gppll_recalc_rate(struct
> > > +clk_hw
> > > *hw, unsigned lon
> > >  	if (rate)
> > >  		return (unsigned long)rate;
> > > 
> > > +	rdiv = rdiv + 1;
> 
> After check more:
> According to doc, needs add a check here:
> if (!rdiv)
>  rdiv = rdiv + 1;

This new check is not something this patch tries to deal with.
Maybe, you may send a separate patch to add the check.

Regards,
Liu Ying

> 
> Regards,
> Peng.
> > > +
> > > +	switch (odiv) {
> > > +	case 0:
> > > +		odiv = 2;
> > > +		break;
> > > +	case 1:
> > > +		odiv = 3;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > >  	/* Fvco = Fref * (MFI + MFN / MFD) */
> > >  	fvco = fvco * mfi * mfd + fvco * mfn;
> > >  	do_div(fvco, mfd * rdiv * odiv);
> > > --
> > > 2.25.1
> 
> 


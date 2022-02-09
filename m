Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156C04B000C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiBIWVp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 17:21:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiBIWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:21:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BCF1C0F8699
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:21:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-66-G1dgHlBaNBupzuHAnSEDBA-1; Wed, 09 Feb 2022 22:21:37 +0000
X-MC-Unique: G1dgHlBaNBupzuHAnSEDBA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 9 Feb 2022 22:21:36 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 9 Feb 2022 22:21:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qing Wang' <wangqing@vivo.com>, Abel Vesa <abel.vesa@nxp.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: use div64_u64() instead of do_div()
Thread-Topic: [PATCH] clk: imx: use div64_u64() instead of do_div()
Thread-Index: AQHYHZBjXPxrJKPUzEuGCK2WjoSvgayLy2mg
Date:   Wed, 9 Feb 2022 22:21:35 +0000
Message-ID: <4f0336b0217f4e7fa9a1a7aa044ee4fe@AcuMS.aculab.com>
References: <1644395819-3791-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644395819-3791-1-git-send-email-wangqing@vivo.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Wang <wangqing@vivo.com>
> Sent: 09 February 2022 08:37
> 
> From: Wang Qing <wangqing@vivo.com>
> 
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.

What is the domain of parent_rate?

Unless it can exceed 2^32 do_div() is correct.
Ignore checkpatch.

> 
> fix do_div.cocci warning:
> WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/clk/imx/clk-frac-pll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
> index c703056..90b25e3
> --- a/drivers/clk/imx/clk-frac-pll.c
> +++ b/drivers/clk/imx/clk-frac-pll.c
> @@ -129,11 +129,11 @@ static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  	parent_rate *= 8;
>  	rate *= 2;
>  	temp64 = rate;
> -	do_div(temp64, parent_rate);
> +	div64_u64(temp64, parent_rate);
>  	divfi = temp64;
>  	temp64 = rate - divfi * parent_rate;
>  	temp64 *= PLL_FRAC_DENOM;
> -	do_div(temp64, parent_rate);
> +	div64_u64(temp64, parent_rate);
>  	divff = temp64;
> 
>  	temp64 = parent_rate;
> --
> 2.7.4

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


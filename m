Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA5544766
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiFIJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFIJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:27:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC5132766;
        Thu,  9 Jun 2022 02:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 876F0B82C8B;
        Thu,  9 Jun 2022 09:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AA1C34114;
        Thu,  9 Jun 2022 09:27:10 +0000 (UTC)
Message-ID: <a9dd6b8a-f5a0-fc7e-fc59-b71a4048d178@xs4all.nl>
Date:   Thu, 9 Jun 2022 11:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: atmel: atmel-isc: remove unneeded IS_ERR()
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "open list:MICROCHIP ISC DRIVER" <linux-media@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <20220519065234.127978-1-guozhengkui@vivo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220519065234.127978-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo Zhengkui,

On 5/19/22 08:52, Guo Zhengkui wrote:
> There has already been error check in clk_unregister(), so remove error
> check before calling clk_unregister().
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/media/platform/atmel/atmel-isc-clk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/atmel/atmel-isc-clk.c b/drivers/media/platform/atmel/atmel-isc-clk.c
> index 2059fe376b00..9decd8fb03d5 100644
> --- a/drivers/media/platform/atmel/atmel-isc-clk.c
> +++ b/drivers/media/platform/atmel/atmel-isc-clk.c
> @@ -304,8 +304,7 @@ void isc_clk_cleanup(struct isc_device *isc)
>  	for (i = 0; i < ARRAY_SIZE(isc->isc_clks); i++) {
>  		struct isc_clk *isc_clk = &isc->isc_clks[i];
>  
> -		if (!IS_ERR(isc_clk->clk))
> -			clk_unregister(isc_clk->clk);
> +		clk_unregister(isc_clk->clk);

Actually, clk_unregister does this:

        if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
                return;

So if IS_ERR(clk) is true, then a warning will be issued, and that's not what you want.

I'm rejecting this patch.

Regards,

	Hans


>  	}
>  }
>  EXPORT_SYMBOL_GPL(isc_clk_cleanup);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B84D4EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbiCJQYy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 11:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbiCJQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:24:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09883195300;
        Thu, 10 Mar 2022 08:22:23 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nSLYO-00055v-2B; Thu, 10 Mar 2022 17:22:16 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     cgel.zte@gmail.com, mturquette@baylibre.com,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] clk/rockchip: Use of_device_get_match_data()
Date:   Thu, 10 Mar 2022 17:22:15 +0100
Message-ID: <2697395.DCgNgQjydf@diego>
In-Reply-To: <20220309185738.2192EC340EC@smtp.kernel.org>
References: <20220304011703.2061466-1-chi.minghao@zte.com.cn> <20220309185738.2192EC340EC@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. März 2022, 19:57:36 CET schrieb Stephen Boyd:
> Quoting cgel.zte@gmail.com (2022-03-03 17:17:03)
> > From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> > 
> > Use of_device_get_match_data() to simplify the code.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> > ---
> >  drivers/clk/rockchip/clk-rk3399.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> > index 306910a3a0d3..b1b67bfb63b8 100644
> > --- a/drivers/clk/rockchip/clk-rk3399.c
> > +++ b/drivers/clk/rockchip/clk-rk3399.c
> > @@ -1634,14 +1634,8 @@ static const struct of_device_id clk_rk3399_match_table[] = {
> >  static int __init clk_rk3399_probe(struct platform_device *pdev)
> >  {
> >         struct device_node *np = pdev->dev.of_node;
> > -       const struct of_device_id *match;
> >         const struct clk_rk3399_inits *init_data;
> > -
> > -       match = of_match_device(clk_rk3399_match_table, &pdev->dev);
> > -       if (!match || !match->data)
> > -               return -EINVAL;
> > -
> > -       init_data = match->data;
> > +       init_data = of_device_get_match_data(&pdev->dev);
> 
> The translation doesn't look equivalent. Before we would bail out of
> probe if match data isn't there with an error. That isn't possible of
> course with further investigation but please make a note of this in the
> commit text to aid review.

We _do have_ Rockchip clock drivers serving multiple socs already
(rk3188+rk3066 for example) and as patterns are duplicated often from
one existing driver to a new one, I think it makes sense to have the
error handling done correctly.

So doing
	init_data = of_device_get_match_data(&pdev->dev);
	if (init_data)
		return -EINVAL;
as before.

If due to some strange coincidence the condition is triggered
this would cause a null-ptr-dereference with the direct call to
	init_data->scripts
below, which might or might not be hidden due to the (early-)console
being up yet, where with correct error handling a system might at
least come up to a point to complain about a missing clock driver.



> Also, please don't send new versions of
> patches in reply to previous versions of patches. It breaks my patch
> workflow. Thanks in advance.
> 
> >         if (init_data->inits)
> >                 init_data->inits(np);
> >
> 





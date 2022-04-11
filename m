Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC24FC1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348347AbiDKQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbiDKQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353B115A1E;
        Mon, 11 Apr 2022 09:07:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so23776198wrg.3;
        Mon, 11 Apr 2022 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EhYDrblculfpaFgkZPez4Ue+cOiQQ05MeuW7S3DyiIQ=;
        b=peziRnRsQBMeUf9bsErHa822sErI+XGFJPlvGIfWSlLK+E5KNdBBUE1ysbInn+jVLn
         +71u2Nvi7f2G3r1tzUf1dWKGMZrxhqpEhnmx67X9CnsIAZjTsy6Jrv1fvZCDdJ3lNUJT
         s3oAqGANXwMwhTAHpNSgJzNsIpsoNIk3zM+GHa78DiF9JEER71rD2KSJ9VxQGJqnNDCe
         +GBrhD6kVWilJmwsOOhkQyg6ay3N9cdPK59+yRhk56qRrL7g3cB8HE1D1EMcJrBHLns3
         u6frVHRgKaFsvgcFicBxIa5Uk72pbNTrLqPydmJMM6n+tADuC2TgVLA5JCWJuloH5Qp5
         gG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EhYDrblculfpaFgkZPez4Ue+cOiQQ05MeuW7S3DyiIQ=;
        b=35Mh+F9Hiio3hMustUiZMsG7ewE1JH9QYgaYtD/28D6+s+kDdQcIQQGoqBmWnROHg+
         8pycs49WchBcnsXolr6y4/T/X3S8VYwHWiVTkfGYy++dL7o+p0ULu/eB+mzrBgy2NZKF
         o7llUhOUoLdlkLO/Kafj/I1wf7kfQNRjxZ2wgTMF7c/gU654IM5W7uPpf3c2EKxWzFZM
         EdINmUbqepmLyKPwyq9R4RsWyHCp9xYA2DksToNugwfGe4x1hMvWD4Ovc8yBYv/xzyse
         yj7DCUtCR1O+w6EZ//AZV5u0w+OzjBEUa9ONrM1mwhmt6QVQl1DWfHN6XBzyzHH1T4lB
         Kg+A==
X-Gm-Message-State: AOAM533CjJUyVuPSXzA05h44E2OUM/oCL6WYo9G6tpeTBfo5BQngkgPz
        7yQkOd1dyErUup4lHZgoNQc=
X-Google-Smtp-Source: ABdhPJxSqY98uimlygBQ4qN91Jukoq9MDcm+rrkCh8J2a6AoOBiLVcHq05gidksHoh8WqPBJLEvDug==
X-Received: by 2002:a5d:6350:0:b0:207:98d5:9bcf with SMTP id b16-20020a5d6350000000b0020798d59bcfmr12885558wrw.40.1649693274790;
        Mon, 11 Apr 2022 09:07:54 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b0038ec43c48bfsm549775wmg.33.2022.04.11.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 09:07:54 -0700 (PDT)
Date:   Mon, 11 Apr 2022 17:08:41 +0100
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000
 SoCs
Message-ID: <YlRSiUkdFkNoPMaH@localhost>
References: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
 <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
 <FKM6AR.T3U5W4W42W2R3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FKM6AR.T3U5W4W42W2R3@crapouillou.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:48:15PM +0100, Paul Cercueil wrote:
> Hi Aidan,
> 
> Le lun., avril 11 2022 at 16:42:41 +0100, Aidan MacDonald 
> <aidanmacdonald.0x0@gmail.com> a écrit :
> > The TCU clock gate on X1000 wasn't requested by the driver and could
> > be gated automatically later on in boot, which prevents timers from
> > running and breaks PWM.
> > 
> > Add a workaround to support old device trees that don't specify the
> > "tcu" clock gate. In this case the kernel will print a warning and
> > attempt to continue without the clock, which is wrong, but it could
> > work if "clk_ignore_unused" is in the kernel arguments.
> > 
> > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > ---
> >  drivers/clk/ingenic/tcu.c | 38 ++++++++++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> > index 77acfbeb4830..ce8c768db997 100644
> > --- a/drivers/clk/ingenic/tcu.c
> > +++ b/drivers/clk/ingenic/tcu.c
> > @@ -31,6 +31,7 @@ struct ingenic_soc_info {
> >  	unsigned int num_channels;
> >  	bool has_ost;
> >  	bool has_tcu_clk;
> > +	bool allow_missing_tcu_clk;
> >  };
> > 
> >  struct ingenic_tcu_clk_info {
> > @@ -320,7 +321,8 @@ static const struct ingenic_soc_info 
> > jz4770_soc_info = {
> >  static const struct ingenic_soc_info x1000_soc_info = {
> >  	.num_channels = 8,
> >  	.has_ost = false, /* X1000 has OST, but it not belong TCU */
> > -	.has_tcu_clk = false,
> > +	.has_tcu_clk = true,
> > +	.allow_missing_tcu_clk = true,
> >  };
> > 
> >  static const struct of_device_id __maybe_unused 
> > ingenic_tcu_of_match[] __initconst = {
> > @@ -354,15 +356,27 @@ static int __init ingenic_tcu_probe(struct 
> > device_node *np)
> >  	if (tcu->soc_info->has_tcu_clk) {
> >  		tcu->clk = of_clk_get_by_name(np, "tcu");
> >  		if (IS_ERR(tcu->clk)) {
> > -			ret = PTR_ERR(tcu->clk);
> > -			pr_crit("Cannot get TCU clock\n");
> > -			goto err_free_tcu;
> > -		}
> > -
> > -		ret = clk_prepare_enable(tcu->clk);
> > -		if (ret) {
> > -			pr_crit("Unable to enable TCU clock\n");
> > -			goto err_put_clk;
> > +			/*
> > +			 * Old device trees for some SoCs did not include the
> > +			 * TCU clock because this driver (incorrectly) didn't
> > +			 * use it. In this case we complain loudly and attempt
> > +			 * to continue without the clock, which might work if
> > +			 * booting with workarounds like "clk_ignore_unused".
> > +			 */
> 
> Why not unconditionally enable it instead? Then it would boot without 
> clk_ignore_unused.
> 
> Cheers,
> -Paul

I could, but why add essentially dead code to the kernel? Maintaining the
old behavior has the "advantage" that it remains broken in the same way as
before, so any workarounds anyone was using will continue to work the same.
And if they were not using workarounds and got a broken kernel, this patch
will not make anything *more* broken, in fact it will not cause any change
in behavior in that case (aside from the warning message).

But if you think it's best to just enable the clock anyway, let me know
and I'll send a new patch.

Regards,
Aidan

> 
> > +			if (tcu->soc_info->allow_missing_tcu_clk &&
> > +			    PTR_ERR(tcu->clk) == -EINVAL) {
> > +				pr_warn("TCU clock missing from device tree, please update your 
> > device tree\n");
> > +				tcu->clk = NULL;
> > +			} else {
> > +				pr_crit("Cannot get TCU clock from device tree\n");
> > +				goto err_free_tcu;
> > +			}
> > +		} else {
> > +			ret = clk_prepare_enable(tcu->clk);
> > +			if (ret) {
> > +				pr_crit("Unable to enable TCU clock\n");
> > +				goto err_put_clk;
> > +			}
> >  		}
> >  	}
> > 
> > @@ -432,10 +446,10 @@ static int __init ingenic_tcu_probe(struct 
> > device_node *np)
> >  			clk_hw_unregister(tcu->clocks->hws[i]);
> >  	kfree(tcu->clocks);
> >  err_clk_disable:
> > -	if (tcu->soc_info->has_tcu_clk)
> > +	if (tcu->clk)
> >  		clk_disable_unprepare(tcu->clk);
> >  err_put_clk:
> > -	if (tcu->soc_info->has_tcu_clk)
> > +	if (tcu->clk)
> >  		clk_put(tcu->clk);
> >  err_free_tcu:
> >  	kfree(tcu);
> > --
> > 2.35.1
> > 
> 
> 

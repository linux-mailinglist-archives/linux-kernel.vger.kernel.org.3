Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3593A4BEBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiBUUku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:40:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiBUUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:40:48 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE92237EB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:40:24 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id k2so8426962oia.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4MPeEss/eyhujmZHQpuKuJo+y/GBuhmITtjH3kw5oTo=;
        b=qgQx96VIAfwy5gqV9T15CfmdVz/V1iKi8abJIMxo7iAA6RDlvo448KNRKokm0iaUpX
         c55+5OBvtWmId6TT6BV/pSg2WCNswNG2kZwIy5UJM08PGCqub9c8ehMLkBuTl9tVWzUx
         SoflnUz35O2LmWGvKiFLnZL+jCe+RH38O+2NT4uzuHpbGBzVh3Bh3dOOkqPNhptUDIqg
         SwGW3BTckAfW5kLHtnRIklY2qp4vBYXyfOm3HsyFpjnAKvR59EhdNAyIe98o0LVqQvl5
         8MCIbNn6yXRwYq9Wzvkn/Sv7YB0/3GTK6GAA4VwubEzJ87Ek6m4079ylj6sW4pKI2BHE
         UtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MPeEss/eyhujmZHQpuKuJo+y/GBuhmITtjH3kw5oTo=;
        b=H0iZW5JTWSFow2aH/k0Ahk2ULmJPWJMKQ9IKbxWKjYf4I8CsXKtxCyb0sepH93ZXwv
         fQ/b8aPbHvXpdlVKV9yzJAKtr0EZEH++Q3pCAmZKk6Mt4xFzc2V78B4HIDGjPfTiWH6e
         0J82X2toGi/5ZuqMeOGFSXAhZlm/QlMJVUL2s7HDCsWxOTgiXGbeJEe1r1YXTiNJgKz/
         +nAEVi9chwes9wmjzurm0jnUXCiW/YN6v4Tk7CyuzvUrDXr7fczBuaMTDUuPAO3PR1U1
         cNiUlQQPsq7vcmQuoJI7TNQiu5cpEon6h4TYxj83H+x4PwS0PPX5RDFX613/oDMlNoMG
         Tndw==
X-Gm-Message-State: AOAM532zynrexgbnsdMsbwT53fNgM4+OB9JuovMQyLGZsNYHbOtL4EBt
        uLCEmCBpdY9pwGIWW2TtsxSDqw==
X-Google-Smtp-Source: ABdhPJzj03s5eDaxuXX9ylEOu3voMTeqNd5F3Ulcr3RvfVPBKrBwXvw95jjeqihlpKTVd6iXxZgwTw==
X-Received: by 2002:a05:6808:3006:b0:2d1:b44c:5549 with SMTP id ay6-20020a056808300600b002d1b44c5549mr389253oib.318.1645476024112;
        Mon, 21 Feb 2022 12:40:24 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j2sm5479493ooj.2.2022.02.21.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 12:40:23 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:42:24 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for
 GDSCs
Message-ID: <YhP5MD+d8btWBUl8@ripper>
References: <20220209172513.17873-1-tdas@codeaurora.org>
 <YgRBnExwlzI+lPlR@builder.lan>
 <20220210072842.3E796C004E1@smtp.kernel.org>
 <9f343332-9a0e-cbf9-9fb1-17127036b0b6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f343332-9a0e-cbf9-9fb1-17127036b0b6@codeaurora.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Feb 08:55 PST 2022, Taniya Das wrote:

> Hi Stephen, Bjorn,
> 
> Thanks for your comments.
> 
> On 2/10/2022 12:58 PM, Stephen Boyd wrote:
> > Quoting Bjorn Andersson (2022-02-09 14:35:08)
> > > On Wed 09 Feb 11:25 CST 2022, Taniya Das wrote:
> > > 
> > > > Do not update the transition delay and use the default reset values.
> > > > 
> > > > Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
> > > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > > ---
> > > >   drivers/clk/qcom/gdsc.c | 6 +++++-
> > > >   drivers/clk/qcom/gdsc.h | 1 +
> > > >   2 files changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > > index 7e1dd8ccfa38..e7b213450640 100644
> > > > --- a/drivers/clk/qcom/gdsc.c
> > > > +++ b/drivers/clk/qcom/gdsc.c
> > > > @@ -380,7 +380,11 @@ static int gdsc_init(struct gdsc *sc)
> > > >         */
> > > >        mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
> > > >               EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
> > > > -     val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
> > > > +
> > > > +     regmap_read(sc->regmap, sc->gdscr, &val);
> > > > +
> > > > +     if (!(sc->flags & DEFAULT_TRANSITION_DELAY))
> > > 
> > > I dug a little bit more into this and noticed that on various platforms
> > > CLK_DIS_WAIT_VAL for the GPU_CX GDSC is supposed to be 8 (whereas both
> > > hw default and CLK_DIS_WAIT_VAL is 2).
> > > 
> 
> Yes, only for certain GPU_CC these would be updated and that too in case the
> design team suggests. Downstream we would set the value from probe itself,
> or we can pick these from device tree as required and suggested.
> 

I don't expect that value to be "configurable", so pushing it to DT
doesn't seem like the proper solution.

> > > I'm not able to find anything helpful in the git log describing what the
> > > value does, but it seems that a "just use hw default" flag won't cut it
> > > for this scenario.
> > > 
> 
> This value is used for the number of clock cycles it would wait before the
> GDSCR ACK signals/halting the clock.
> 

That makes sense.

> > 
> > I'd prefer we invert the logic so that we don't need to litter this flag
> > all over the place. I recall that the wait values were incorrect a long
> > time ago on early gdsc using designs but hopefully they've been fixed
> > now and we can simply use the default power on reset (POR) values.
> 
> I am okay to invert the logic, but I am not sure if they could cause any
> issues to the older targets. They were broken in HW design long back, but
> got fixed in most families of target and most GDSCs.
> 

I don't fancy us having a flag with the purpose of "don't set the
timings to 2, 8 and 2" and then rely on open coded writes in probe to
set it to something else where needed.

So I definitely would prefer to flip this around, to make the cases
where we want to write different values explicit.

But as you say, unless we make sure that all existing platforms do write
2, 8 and 2 we risk introducing regressions from the current behavior.

> As mentioned if explicitly they need to be updated, it is best to do from
> the probe.
> This was done in SC7180 GPUCC driver.
>         /* Configure clk_dis_wait for gpu_cx_gdsc */
>         regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
>                                         8 << CLK_DIS_WAIT_SHIFT);

But we call regmap_update_bits() from probe, which sets the CLK_DIS_WAIT
to 8, then we call qcom_cc_really_probe() which will end up in
gdsc_init() which replaces that with a 2.

Perhaps I'm missing something?

> 
> 
> Please let me know if we are okay to add the invert logic.
> 

I'm still favoring a scheme where we add 3 integers to struct gdsc and
in gdsc_init() we check if they are non-zero we write the value to the
register.

Although being a big patch, we could maintain the existing behaviour by
giving all existing struct gdsc definitions the values 2, 8 and 2 to
avoid regressions and we (everyone) can then go through the platforms
one by one and remove the unnecessary assignments - but more
importantly, double check with downstream if they need a different
value.

This will also have the side effect going forward that it will be more
explicit and people writing gdsc definitions should double check these
values.

Regards,
Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97574B1657
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiBJTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:32:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiBJTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:32:06 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C6E49
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:32:05 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id v6-20020a05683024a600b005ac1754342fso841596ots.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83jBZGnAeOun9Qa4YScgifTnrV3+O1ps8rW5TfaBw7s=;
        b=yAf89xZUS4cPnGjORwlkSomvKd2gpHBkxvVwfYg+srNzovcPFQ8NUbVOa6DwNaifMc
         JpBhPchLKy7G1Kkv+vj9mSKz26vWBG8sAoLWFoB/HBWWToEGsm2WApanWtdxT6R2a5UM
         wXRURB3Rpb8Sg5mXeq2Xl5pOn2XyTznTsLDtulTSJamR91yCzJ9u5U9jbXAZpZYmnzEg
         97kFfwSQPZaJpl2BabDyTsIyF23FLwTeiYy/JZbRG9tPWN90SHzuqh3kfNEfwgUYhrof
         CrMLYrcqm3Lnlihgwj0piDSNlaAZWrDFUOkaD1cd65LD7SNKPvB40gneZ87l6Pj2f1U+
         v71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83jBZGnAeOun9Qa4YScgifTnrV3+O1ps8rW5TfaBw7s=;
        b=SVcpTDcsL4+dhmZZFYkpM1HCWDCb3ugw3XGgljwJyGn2Uoin4Der34WkXVfEo7BzKc
         F1Kr50eUfhRjUAU/ABpWbnq2ZJFfEkwnGBAvN1QAnJbrXRtS2zFM74RNIYoKhHF/VkMe
         2KeQlnU7HbFnJJ0qefWBslM1kzuXw97OdIkUOKMAwiAli4FK54lV0ErWvsM9Z5UB1IgO
         fxwXsvkhQiPxlgUTHQmOfbK9qI+eTjVRG5OV6Q3wOuVlEwnmjZbtcDkP//YMwXZ0tkNq
         x98Rm98KMcfcFFpgJ8kPdlJNni2i2RQFIl2OGXgkBRGAojgX4Fgx5HwpjXGGEWDEdb6C
         Ud4A==
X-Gm-Message-State: AOAM532jH6FYsPiM2TpSh7KXZEcavAlDRLnW1Cb8jUe00/xkEE6+taey
        m32kEv/vEqtASvK8eYgssMDY7A==
X-Google-Smtp-Source: ABdhPJyTtx10MMXoAruAHk6VMccZVX8E3+3Teal8Wvh7ZZ+EG3kTiqozmH3kp/yXeMkLzrSMHFYlwA==
X-Received: by 2002:a05:6830:120b:: with SMTP id r11mr3424291otp.182.1644521525326;
        Thu, 10 Feb 2022 11:32:05 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id b32sm2860318oaq.43.2022.02.10.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:32:04 -0800 (PST)
Date:   Thu, 10 Feb 2022 13:32:03 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for
 GDSCs
Message-ID: <YgVoM2QZTJAbu6WR@builder.lan>
References: <20220209172513.17873-1-tdas@codeaurora.org>
 <YgRBnExwlzI+lPlR@builder.lan>
 <20220210072842.3E796C004E1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210072842.3E796C004E1@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Feb 01:28 CST 2022, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2022-02-09 14:35:08)
> > On Wed 09 Feb 11:25 CST 2022, Taniya Das wrote:
> > 
> > > Do not update the transition delay and use the default reset values.
> > > 
> > > Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
> > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > ---
> > >  drivers/clk/qcom/gdsc.c | 6 +++++-
> > >  drivers/clk/qcom/gdsc.h | 1 +
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > index 7e1dd8ccfa38..e7b213450640 100644
> > > --- a/drivers/clk/qcom/gdsc.c
> > > +++ b/drivers/clk/qcom/gdsc.c
> > > @@ -380,7 +380,11 @@ static int gdsc_init(struct gdsc *sc)
> > >        */
> > >       mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
> > >              EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
> > > -     val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
> > > +
> > > +     regmap_read(sc->regmap, sc->gdscr, &val);
> > > +
> > > +     if (!(sc->flags & DEFAULT_TRANSITION_DELAY))
> > 
> > I dug a little bit more into this and noticed that on various platforms
> > CLK_DIS_WAIT_VAL for the GPU_CX GDSC is supposed to be 8 (whereas both
> > hw default and CLK_DIS_WAIT_VAL is 2).
> > 
> > I'm not able to find anything helpful in the git log describing what the
> > value does, but it seems that a "just use hw default" flag won't cut it
> > for this scenario.
> > 
> 
> I'd prefer we invert the logic so that we don't need to litter this flag
> all over the place. I recall that the wait values were incorrect a long
> time ago on early gdsc using designs but hopefully they've been fixed
> now and we can simply use the default power on reset (POR) values.

Are you suggesting that we make it the default to not update the values
and then provide means to specify it where needed?

I like that suggestion.

But as mentioned in my reply yesterday, GPU_CX on several platforms
needs a different CLK_DIS_WAIT_VAL - and not the same value.

Are these values ever 0? Or could we simply add the three numbers to
struct gdsc and have 0 denote "use hw default"?

Regards,
Bjorn

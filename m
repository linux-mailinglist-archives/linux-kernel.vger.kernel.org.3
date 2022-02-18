Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA54BBDE0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiBRQ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiBRQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:56:14 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03BB25AE6E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:55:57 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso4181268oon.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pInuhqCUKlyUoEXuWgKg1Wujz7TDTU39Sy2l1F/hTtA=;
        b=tGMO/mIvCDGbcTb9cGMz11xTh7itxXS7A61+zRdHHfGkwSvgMKZFG21gFAWetvbnZ1
         H4bw6eg7/5ZzhaBpDRHoc3nlq1CRQJKgagvK74uAoeHWDDB4PzmwUAfXXEYfMp3lCZdr
         wbqQtOUtgx3GFlT10yrWbUD3w+oVZWsmqMNZvmJPevYtneBMhxNEFdtDyCDD5L4k6Qrd
         1oR6nCDA/xl+K/3EhSi3fDIkSABdaGL9AHY8uJJVRDVE2X1TMyDXNguJ7VmEUWzyReZw
         pbIl/RGCSJupHY11jktZoCTTDx1y2zABB+9f3bMGIAPErILsRUiqgvXFSZ4otQ+Weboh
         iGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pInuhqCUKlyUoEXuWgKg1Wujz7TDTU39Sy2l1F/hTtA=;
        b=PYy1zBRspEJrWbxhljZ/8jcRAvJj9PhOzNM0sB6ZSYW1DMvXSr+mUE6MFysRMcJVaK
         dnyfCT9JxPHG+C+EBr0C9MgEGBVPzVzM6I2kcMDceUvIaoaJSSkJoqzupIkkyoBCpySl
         Zq/gtD7NEwRTYfze7E0yuqWfZ6M7hvLLCwP9nYCtw18D6COBschd6Z5fS9Gegfrpu1z4
         wpSaAATTzdtj500qN9DM7bc+kUbbjqRUKKQutDn0TFJ5TixqZiFCMZGj+IY+yt1lNnHl
         n4STr4S6vLdBljcblOT3vzAOvEMnYAebTWSJ6PHCdqT0NwVHmwOkR+RyDyvCdiXKcEdX
         PbWw==
X-Gm-Message-State: AOAM533KUnW82d6HjHpMCPCjgf8pMdEdqeA/L9NHxxyOiPh+MjUjtDhH
        XwTkEol85TUQExDh+PPn0bFRFg==
X-Google-Smtp-Source: ABdhPJwMdNlDq+QHL5mKNt87mqwiHbkMztRqQza/VJNIKkYfdAwMNP8R1T6Q3XW6mpT4o1PdTGlfdg==
X-Received: by 2002:a05:6870:b003:b0:d1:3804:aee2 with SMTP id y3-20020a056870b00300b000d13804aee2mr2889956oae.155.1645203357235;
        Fri, 18 Feb 2022 08:55:57 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id el40sm22088082oab.22.2022.02.18.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:55:56 -0800 (PST)
Date:   Fri, 18 Feb 2022 08:58:02 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v12 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <Yg/QGqQhYZY6KaqJ@ripper>
References: <20220216045620.1716537-1-bjorn.andersson@linaro.org>
 <20220216045620.1716537-2-bjorn.andersson@linaro.org>
 <CAD=FV=Xj5k7JROP1PFY9tmXxLY7FRJNdr-+UmkCW_YGqpDkFew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xj5k7JROP1PFY9tmXxLY7FRJNdr-+UmkCW_YGqpDkFew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Feb 08:10 PST 2022, Doug Anderson wrote:

> Hi,
> 
> On Tue, Feb 15, 2022 at 8:54 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > +static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                        const struct pwm_state *state)
> > +{
> > +       struct lpg *lpg = container_of(chip, struct lpg, pwm);
> > +       struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> > +       int ret;
> > +
> > +       if (state->polarity != PWM_POLARITY_NORMAL)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&lpg->lock);
> > +
> > +       if (state->enabled) {
> > +               ret = lpg_calc_freq(chan, state->period);
> > +               if (ret < 0)
> > +                       goto out_unlock;
> > +
> > +               lpg_calc_duty(chan, state->duty_cycle);
> > +       }
> > +       chan->enabled = state->enabled;
> > +
> > +       lpg_apply(chan);
> > +
> > +       triled_set(lpg, chan->triled_mask, chan->enabled ? chan->triled_mask : 0);
> > +
> > +out_unlock:
> > +       mutex_unlock(&lpg->lock);
> > +
> > +       return ret;
> > +}
> 
> My compiler (correctly) yelled that `ret` is returned uninitialized if
> `state->enabled` is false.

You're absolutely correct. I am however not able to figure out how to
get my compiler (aarc64 gcc 11.2.0) to give me a warning about this.

If anyone have any suggestions I'd be very happy.

> I initialized `ret` to 0 and the problem
> went away. I assume that the patch will need to spin to fix that
> unless everything else looks great and a maintainer wants to fix that
> when applying.
> 
> With that fix, I was able to use Bjorn's patch along with Satya's
> patches adding pm8350c support (removing the now defunct
> "pwm_9bit_mask" property) to make the PWM on my board work. Thus, once
> the error my compiler complained about is fixed I'm happy with my
> `Tested-by` being added.
> 

Thanks! I will initialize ret and send out v13 including your T-b.

Regards,
Bjorn

> For now I haven't actually reviewed the code here, but if folks feel
> like it needs an extra pair of eyes then please yell and I'll find
> some time to do it.
> 
> -Doug

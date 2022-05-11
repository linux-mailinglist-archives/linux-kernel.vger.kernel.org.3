Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23057523852
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbiEKQPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbiEKQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:14:57 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF86D189
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:14:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q8so3240399oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cf09Je3CtRN58q8NVoc2nPVu33QjMHj88UB5fSrOla4=;
        b=CTG8yoxyViVJG9wmGrm6SLhEgFT0WuEvMoQXyZI5Kx6YkRB5j28pASLSwuZICqn0Cn
         WUe9JQtUluE5n2n2m1EPa+FISLLmw74zubXRkCQO7+cPFnDb7SH7eHHvsAv5UmyVzyUV
         Yg4qwAYNHpV19CvN9+QaSJdKAjMOYPnzZCA3hYz+C9nugper2Z4G1e1AGj+1SszRkaQo
         moGjWWVVce7nK2CR/KrFugqD3XC1mwkzPeFT8lqC0rXm5ECEPIDRHLahArrblpkSEeOi
         oarjMZfY1Bm/srauvkhyBWogv1HqzCKX1WkOEQx8b1IIsfASQoQDyYqMHU0Z+3n8xztv
         Iymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cf09Je3CtRN58q8NVoc2nPVu33QjMHj88UB5fSrOla4=;
        b=X4CnYsKaB16zRCsY+IYEtZ4byzkEk0dYfPgj0cXZxg+N8WGwDO0uhaghTwE0RMrqnI
         xyAt2949nbr0D6VCQyt5JDV8O2QtQos2+qKw7HCyF15KTEOYcXfmOMo2Z4wVw29Xsawu
         uN5mICqYeEgXJx+4uM2JcrYvznsPaLIZ6XJ+noyB2ZTzVgEN/Y5JtpHAVpAXOmOQnsR2
         4vzvY1F8e/8QsyjG89IT69c5VsdQ6WEGjxdekOZncZgJOMBuSjipeHDU15s+jKXYafJv
         ovrkwn04ZDan1wZQo2nfv4Lq8XkGCP1QuyFgm7u5ycAE7ZPqY0W5qNntsomL387KCA7C
         vwQw==
X-Gm-Message-State: AOAM5309zT85WqfhLneRotZ75tsic9eBJxO7IRzNuIlvS3K1eeiRXQ78
        79wvA/vkZ54IIE322+O1pGuUeg==
X-Google-Smtp-Source: ABdhPJz8wvQ3CXsSwZJgwMBRizoEDzOcZERxCvR6YfvQLmBZIZFLmiRHdvM6kGdBrvW6hOVawnGctg==
X-Received: by 2002:a05:6808:2199:b0:326:90e2:754b with SMTP id be25-20020a056808219900b0032690e2754bmr2876267oib.227.1652285695478;
        Wed, 11 May 2022 09:14:55 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z18-20020a056808065200b00325cda1ffacsm861218oih.43.2022.05.11.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:14:54 -0700 (PDT)
Date:   Wed, 11 May 2022 09:17:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <YnvhleAI5RW0ZvkV@ripper>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220303214300.59468-2-bjorn.andersson@linaro.org>
 <20220504073009.GC8204@duo.ucw.cz>
 <YnKTAvQc6eDxTl14@ripper>
 <20220506160901.GA1199@bug>
 <YnVMcaRV86jZslhd@ripper>
 <20220507063659.GA6968@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507063659.GA6968@amd>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06 May 23:36 PDT 2022, Pavel Machek wrote:

> Hi!
> 
> > > > As such the pattern sequence provided to hw_pattern looks to be the
> > > > smae, but I don't see that it can be made compatible.
> > > > 
> > > > > Can I get either patch to disable pattern infrastructure for now or to
> > > > > get it compatible?
> > > > > 
> > > > 
> > > > I'd be happy to get this updated to your liking, but this was one of the
> > > > drivers we discussed when we introduced the pattern trigger and led to
> > > > the conclusion that we need the ability to do hw-specific patterns.
> > > > 
> > > > As such this document provides the hardware specific documentation, as
> > > > we describe under "hw_pattern" in
> > > > Documentation/ABI/testing/sysfs-class-led-trigger-pattern.
> > > > 
> > > > Please advice on what you would like me to do.
> > > 
> > > I'd like you to use same format leds-trigger-pattern describes.
> > > 
> > > If someone passes "255 500 0 500", that's requesting gradual transitions and
> > > your hw can not do that. You return -EINVAL.
> > > 
> > > If someone wants that kind of blinking, they need to pass "255 0 255 500 0 0 0 500".
> > > 
> > 
> > So the section under hw_pattern in sysfs-class-led-trigger-pattern that
> > says:
> > 
> > "Since different LED hardware can have different semantics of
> > hardware patterns, each driver is expected to provide its own
> > description for the hardware patterns in their documentation
> > file at Documentation/leds/."
> > 
> > That doesn't apply to this piece of hardware & driver?
> 
> It applies: since your hardware can not do arbitrary patterns, you
> need description of what kinds of patterns it can do.
> 
> But you should still use compatible format, so that pattern that is
> valid for hw_pattern file is valid for pattern file, too, and produces
> same result.
> 

Okay, I didn't understand that the hw_pattern needs to be a subset of
the pattern. I will prepare a patch to require the pattern to include
the zero-time entries as well.

> If you believe documentation implies something else, it may need to be
> clarified.
> 

I'll read it again and if needed I'll try to clarify the expectations.

Thanks,
Bjorn

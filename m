Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58374A7AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiBBVz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbiBBVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:55:54 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921A6C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:55:54 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso767373otl.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2HuhD4BMwOpT0StEKJZI/a0PbP6Mi96M+kUVshgnr/o=;
        b=aNCJxs4oY7GADhu6PAbbAp8A3qFy94oEH52OJrJAf6y5xuX9bcFTi3Q/ZTVLF3kSd3
         SFFRG/WRM+gt8VKGmjxGvJEZgZf61SvDFC7Qm8QdaQCALQvpVYr8om6Qxxn87U7+Uk7G
         XAuUzLEAZ57FPAjhfAPjkvFQhkxRfnK4jcltQ/LkbVw9+02CITJ1hcyAQd3Lfm+U4VdL
         PavKxgRCOB4YHWSBZYO09eWdXIaS/F8FBpjEz8fWJOCcyUR37QchAHXvSLMuw57FG4zu
         dpubgHPp9tT0zJPh0SoAJs5V5NwIDsyTG0xdsmJbIQ5BpLkDqH/XpbQ6gNS0sQpRPQGG
         f2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2HuhD4BMwOpT0StEKJZI/a0PbP6Mi96M+kUVshgnr/o=;
        b=AvbQzAw9JgN4Aa7c5bJ39ptKZrjQUcMF4NR6nNkxtbGL9u/qO7fLVgVMwtxO2M4CPU
         S7TJEYMJdMYx5fVvg4pC0yI05p1maZlrKJjlRFgnnEcjcErI5tnWy1AaRZ46ut4EcvZW
         Q7YcwHhrzsVjHCp0y0hnomdNfFShPqVtxGARUx5/tueUM6leU4EhlrwDN3z/ZJzBYyOm
         N12k8f/hTVjHcLlDfGKLhwCm0kpRNTDasU3nMhD2KA9cO9C+qSjzImUnJFx5cf3r8U3M
         /VI6qii/UfiyU1DQQ3XCSs3KAKacPqXS5BtMsV0zN+GaaPYO+Ccq+k9T8zeKg/+pKxoa
         ibsQ==
X-Gm-Message-State: AOAM531zQF0hsEIks3JcA9CzlSdT6S/Cvf1sZu9XaP2hV4KapwB4u3b7
        U1O3mqJ6k2nZ7AyrGY885yNi/g==
X-Google-Smtp-Source: ABdhPJw0rMjfqQN4DfYNpGSTiQviBwFuellzRA/PGvVSnJLYJLZ2E5dqc5U7wnfsrlGuC9Wv3cU+wg==
X-Received: by 2002:a05:6830:3145:: with SMTP id c5mr5977160ots.380.1643838953582;
        Wed, 02 Feb 2022 13:55:53 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id a19sm15587772otf.27.2022.02.02.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:55:52 -0800 (PST)
Date:   Wed, 2 Feb 2022 13:56:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v10 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <Yfr9+jvGIyB2ynMS@ripper>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
 <20211010043912.136640-2-bjorn.andersson@linaro.org>
 <YXL0DyyPkS4/wfB7@ripper>
 <20211027211928.tjybwy2lokj6eoun@SoMainline.org>
 <YfSPYkbTXMOUGKkG@yoga>
 <20220202110305.gbow3e3stolb67v5@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202110305.gbow3e3stolb67v5@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 Feb 03:03 PST 2022, Marijn Suijten wrote:

> On 2022-01-28 18:50:42, Bjorn Andersson wrote:
> > On Wed 27 Oct 16:19 CDT 2021, Marijn Suijten wrote:
> > 
> > > Hi Bjorn,
> > > 
> > > On 2021-10-22 10:25:35, Bjorn Andersson wrote:
> > > > On Sat 09 Oct 21:39 PDT 2021, Bjorn Andersson wrote:
> > > > 
> > > > > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > > > > PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> > > > > with their output being routed to various other components, such as
> > > > > current sinks or GPIOs.
> > > > > 
> > > > > Each LPG instance can operate on fixed parameters or based on a shared
> > > > > lookup-table, altering the duty cycle over time. This provides the means
> > > > > for hardware assisted transitions of LED brightness.
> > > > > 
> > > > > A typical use case for the fixed parameter mode is to drive a PWM
> > > > > backlight control signal, the driver therefor allows each LPG instance
> > > > > to be exposed to the kernel either through the LED framework or the PWM
> > > > > framework.
> > > > > 
> > > > > A typical use case for the LED configuration is to drive RGB LEDs in
> > > > > smartphones etc, for which the driver support multiple channels to be
> > > > > ganged up to a MULTICOLOR LED. In this configuration the pattern
> > > > > generators will be synchronized, to allow for multi-color patterns.
> > > > > 
> > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > ---
> > > > 
> > > > Any feedback on this?
> > > 
> > > I asked in #linux-msm whether anything is wrong with the patterns,
> > > since my Sony Discovery (sdm630 with a pm660l) blinks way quicker on a
> > > pattern that's supposed to stay on for 1s and off for 1s:
> > > 
> > >     echo "0 1000 255 1000" > /sys/class/leds/rgb\:status/hw_pattern
> > > 
> > > It however seems to be broken in the same way on an older version now
> > > (this might be v9 or v8) which I don't remember to be the case.  Can you
> > > double-check if this is all working fine on your side?  If so, I'll have
> > > to find some time to debug it on my end.
> > > 
> > 
> > I had missed the fact that LPG_RAMP_DURATION_REG is two registers for
> > msg and lsb, for a total of 9 bits of duration. So what you saw was
> > probably ticking at 232ms.
> > 
> > Note though that the pattern uses the last time as "high pause", so I
> > expect that you should have seen 232 ms of off, followed by 464ms of
> > light.
> 
> Visual inspection seems to confirm those numbers indeed!
> 
> > I've fixed this for v11, both rejecting invalid input and writing out
> > all 9 bits.
> 
> Doesn't that 512ms limit, together with using only the last value for
> hi_pause (and not the first value for lo_pause) force users to write
> patterns in a certain way which is not easily conveyed to the caller
> except by reading the comment in the driver?  I'd guess lo_pause can be
> used even if not in ping-pong mode, it should just hold at the first
> value for the given duration?
> 
> (That said hw_pattern is anyway already riddled with device-specific
> information, such as only having one `delta_t` which functions as the
> step size for every entry, and with the change above would need to be
> sourced from another step that's not the first.)
> 

Perhaps we should clarify the single delta_t by requiring all those
delta_t to be the same, rather than ignoring their value.

I.e. we make the ping-pong pattern:

<value> <lopause+t> ... <value[N/2-1]> <t> <value[N/2]> <hipause+t> <value[N/2-1]> <t> ... <value> <t>

And for non-ping-pong:

<value> <lopause+t> <value> <t> ... <value> <t> <value> <hipause + t>


What do you think?

> Bit of a stretch, but perhaps worth noting anyway: should this be
> written in documentation somewhere, together with pattern examples and
> their desired outcome to function as testcases too?
> 

There's a comment in lpg_pattern_set() where I tried to capture this.

I don't think it's worth documenting the behavior/structure away from
the driver. But let's make sure it's captured properly there.

Regards,
Bjorn

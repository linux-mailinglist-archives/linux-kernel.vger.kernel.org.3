Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282851DD95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443782AbiEFQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443769AbiEFQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:28:40 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5836EB19
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:24:56 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-d39f741ba0so7676226fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MJNi1mbSdob7+bt9cuYWkkcjxTPYJe7q5XVeyN3mbE0=;
        b=hxbKsuJmP/J8sgmfTX8++VCbHxMkma3TtffIjfk/un+FrHSMF/iF8j5Ass5FMe/NBi
         nPb4sbJeG7pvEDbr5U2Z1uLMlkQ4CXen/ReSeNCjpjj46WW1MKMZyU1unDGH6JZDUzPt
         5HH1O5CXOIjZqPst9/Vvf6ZSQt7KHZSbZHWPUL53o3tQ8Ra+qG0bUQ3o+64XOEpQ/Vti
         CHj8Xc5vLsVd6+225+OrnS6K6CPUPIqzTc+tVXwKj6mKDEg+AAh3kkrKe/ez9Xy6gGND
         6+NdBlwjQXW5yNdLIwICdIUw7JXpLg2YvwXdDfNI1Z6ZhiA8p5tMJCEBw/G6xHYEZ057
         aT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJNi1mbSdob7+bt9cuYWkkcjxTPYJe7q5XVeyN3mbE0=;
        b=zEysXkmzTCklSxxKBLMpkMKvi5AUHgxS1byI28CGcHwldYdXZveSt0AWX/DmAer4fZ
         gY7bmt7dfkXFh1tuUC+sZwEa8Pr4AMGp6rVRh/qlgivwu7MgaFUF7IeMaGLCF615I3Pc
         kHz7XA3FHiZj8HO/KudEd4eHUVHIPndAPQSJajFBhw9U9otn8XMF8etJx8J9SugGEGTk
         VjZnmJsO+SXaUabZEE1nV+5cnBspyjk6WOlz8xKit/uMxr3301SXW7XiGvysPyDOtwzx
         jJQcCpcoMYOskejp/bE5RFsXg4JXKX7WIFo5TGTyzwhm80XHg3K86XJXkD00EPzRN9Uu
         k+eQ==
X-Gm-Message-State: AOAM533ICodxoUGbjjRjmPQlcy7R2jmgoZLktG92B6Hp9Lf47GlA+Nsj
        XqzcHrTqdjrYNZfaupJmE0l6TQ==
X-Google-Smtp-Source: ABdhPJzRPABBMXOCHct7MUr2JDfjknHPxMsUWZxuLfH7VhK2lkNZtaisjFtIeEQ941TOXMLluM+umQ==
X-Received: by 2002:a05:6870:414d:b0:ed:5585:7436 with SMTP id r13-20020a056870414d00b000ed55857436mr1682804oad.29.1651854295970;
        Fri, 06 May 2022 09:24:55 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a204-20020acab1d5000000b00325643bce40sm1832260oif.0.2022.05.06.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:24:55 -0700 (PDT)
Date:   Fri, 6 May 2022 09:27:29 -0700
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
Message-ID: <YnVMcaRV86jZslhd@ripper>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220303214300.59468-2-bjorn.andersson@linaro.org>
 <20220504073009.GC8204@duo.ucw.cz>
 <YnKTAvQc6eDxTl14@ripper>
 <20220506160901.GA1199@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506160901.GA1199@bug>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06 May 09:09 PDT 2022, Pavel Machek wrote:

> Hi!
> 
> > > > +    "255 500 0 500"
> > > > +
> > > > +        ^
> > > > +        |
> > > > +    255 +----+    +----+
> > > > +        |    |    |    |      ...
> > > > +      0 |    +----+    +----
> > > > +        +---------------------->
> > > > +        0    5   10   15     time (100ms)
> > > > +
> > > > +The LPG supports specifying a longer hold-time for the first and last element
> > > > +in the pattern, the so called "low pause" and "high pause".
> > > 
> > > Please see
> > > Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt . This
> > > should really be compatible.
> > 
> > Unfortunately the LPG hardware only supports fixed duration (except for
> > the ability to hold/extend the first and last duration in the pattern)
> > and it also does not support gradual transition between the brightness
> > levels.
> 
> Ok.
> 
> > As such the pattern sequence provided to hw_pattern looks to be the
> > smae, but I don't see that it can be made compatible.
> > 
> > > Can I get either patch to disable pattern infrastructure for now or to
> > > get it compatible?
> > > 
> > 
> > I'd be happy to get this updated to your liking, but this was one of the
> > drivers we discussed when we introduced the pattern trigger and led to
> > the conclusion that we need the ability to do hw-specific patterns.
> > 
> > As such this document provides the hardware specific documentation, as
> > we describe under "hw_pattern" in
> > Documentation/ABI/testing/sysfs-class-led-trigger-pattern.
> > 
> > Please advice on what you would like me to do.
> 
> I'd like you to use same format leds-trigger-pattern describes.
> 
> If someone passes "255 500 0 500", that's requesting gradual transitions and
> your hw can not do that. You return -EINVAL.
> 
> If someone wants that kind of blinking, they need to pass "255 0 255 500 0 0 0 500".
> 

So the section under hw_pattern in sysfs-class-led-trigger-pattern that
says:

"Since different LED hardware can have different semantics of
hardware patterns, each driver is expected to provide its own
description for the hardware patterns in their documentation
file at Documentation/leds/."

That doesn't apply to this piece of hardware & driver?


Or is the sysfs documentation simply not reflecting what has been
decided of how this interface should look like?

Regards,
Bjorn

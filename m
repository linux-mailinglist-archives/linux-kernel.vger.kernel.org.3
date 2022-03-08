Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D074D0C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbiCHAAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiCHAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:00:36 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908E33E10
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:59:39 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so19977007oos.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 15:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KEKG+0hooW1zM7qhTU6cSghfN5cLCif35DDe+3mMJLQ=;
        b=qFLO6hAIpl06N4GNLGqecP/zlZwavKJvd+C2rXjxnNQPO4w64M+806hqjlD7t5TC6g
         BNcZsQmoORx6UJxpnwD9nzyJsEPGkmb0zpT0utUZNkmvIvTQPsNqjE/ItkaeHXwNtLfY
         efsTbuorX+m2WMmD3Euhws5BSxUNtK+/decBRrARGms/jFqz8lQbCru/seLE4bzH+M9f
         D9u3UAjiDwhUSEja4sQILVR7zt0gV81PgQ7xKfOLlmw9jXZIVArFCZHhQ1up67wWc9fZ
         2Jf8M3tT8faHc4vRoIoMP8KxFQi8dtC4xe0MCaKN1gJY+MWmOar9FEoBxNxjw6Fq0f3r
         8CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KEKG+0hooW1zM7qhTU6cSghfN5cLCif35DDe+3mMJLQ=;
        b=jOxhCKwCOnPuxr3IuE6gXpHedlTzmpDNWohASDdjNJVjm5IV7nwMz64S/0eKQ7yRA3
         E6ZqjvG/YDOvu/YhR+JXDclMcg40OyoEU7XHbsOYwtnBHLYw6IxTRccFIUtuI8QVtuUS
         kAAV7srg8m2GqmGdssXyQhAbjScZlqBeDzL4rpW+Be0yJoAi5kcoF5xYDVF9FyaSgSUd
         NcjQdcpCeGkJ/YCTyjzd1CpAcByrUuXzKJqKoIh3hhZ14qlMdff/UowbN1MAKfsTI9hX
         bQLuJNswnhNhzQjFbF0AEGU4KfUujrlO8TKto+WDRHwGLdKnIqKLGG+FhgzeKsTbOoFd
         kAxA==
X-Gm-Message-State: AOAM530R5uHQ4YchGpWHUpudh4uLQWrSp0YAnUqI7wZ0gjm5xEAMX01N
        NJtBO3i49P08FcQVuUsRF7oq5g==
X-Google-Smtp-Source: ABdhPJytmm6mXDFw5YmoLtk0zA0zRvReKCgSL+J2N0/BnKQabYOOJvsgpbE9CnKc9Mj8U2BLGCcYMA==
X-Received: by 2002:a05:6870:a189:b0:da:b3f:2b83 with SMTP id a9-20020a056870a18900b000da0b3f2b83mr870514oaf.290.1646697578856;
        Mon, 07 Mar 2022 15:59:38 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l4-20020a4a94c4000000b002ea822fbac8sm6381033ooi.21.2022.03.07.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:59:38 -0800 (PST)
Date:   Mon, 7 Mar 2022 16:01:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 7/7] usb: typec: mux: Add On Semi fsa4480 driver
Message-ID: <Yiac0h4RX8VxDtZ7@ripper>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-7-bjorn.andersson@linaro.org>
 <YiXbg4QwgIgLh3LW@smile.fi.intel.com>
 <YiYbOQpX4+fP8S1W@ripper>
 <YiYvMf5X+S0WZ9lO@smile.fi.intel.com>
 <YiZzco76Nrxbxz95@ripper>
 <YiaDd+quwXgbuz5D@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiaDd+quwXgbuz5D@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Mar 14:13 PST 2022, Andy Shevchenko wrote:

> On Mon, Mar 07, 2022 at 01:04:50PM -0800, Bjorn Andersson wrote:
> > On Mon 07 Mar 08:13 PST 2022, Andy Shevchenko wrote:
> > > On Mon, Mar 07, 2022 at 06:48:25AM -0800, Bjorn Andersson wrote:
> > > > On Mon 07 Mar 02:16 PST 2022, Andy Shevchenko wrote:
> > > > > On Sun, Mar 06, 2022 at 07:40:40PM -0800, Bjorn Andersson wrote:
> 
> ...
> 
> > > > > > +		/* 15us to allow the SBU switch to turn off */
> > > > > > +		usleep_range(15, 1000);
> > > > > 
> > > > > This is quite unusual range.
> > > > > 
> > > > > If you are fine with the long delay, why to stress the system on it?
> > > > > Otherwise the use of 1000 is unclear.
> > > > > 
> > > > > That said, I would expect one of the below:
> > > > > 
> > > > > 		usleep_range(15, 30);
> > > > > 		usleep_range(500, 1000);
> > > > 
> > > > Glad you asked about that, as you say the typical form is to keep the
> > > > range within 2x of the lower value, or perhaps lower + 5.
> > > > 
> > > > But if the purpose is to specify a minimum time and then give a max to
> > > > give the system some flexibility in it's decision of when to wake up.
> > > > And in situations such as this, we're talking about someone connecting a
> > > > cable, so we're in "no rush" and I picked the completely arbitrary 1ms
> > > > as the max.
> > > > 
> > > > Do you see any drawback of this much higher number? (Other than it
> > > > looking "wrong")
> > > 
> > > I see the drawback of low number.
> > 
> > 15us is based on the data sheet and if the kernel is ready to serve us
> > after 15us then let's do that.
> > 
> > > The 1000 makes not much sense to me with the minimum 66x times less.
> > > If there is no rush, use some reasonable values,
> > > what about
> > > 
> > > 		usleep_range(100, 1000);
> > > 
> > > ? 10x is way better than 66x.
> > 
> > I don't agree, and in particular putting 100 here because it's 1/10 of
> > the number I just made up doesn't sounds like a good reason. The
> > datasheet says 15us, so that is at least based on something real.
> > 
> > In https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> > I find the following:
> > 
> >     With the introduction of a range, the scheduler is
> >     free to coalesce your wakeup with any other wakeup
> >     that may have happened for other reasons, or at the
> >     worst case, fire an interrupt for your upper bound.
> > 
> >     The larger a range you supply, the greater a chance
> >     that you will not trigger an interrupt; this should
> >     be balanced with what is an acceptable upper bound on
> >     delay / performance for your specific code path. Exact
> >     tolerances here are very situation specific, thus it
> >     is left to the caller to determine a reasonable range.
> > 
> > Which to me says that the wider range is perfectly reasonable. In
> > particular 15, 30 (which seems to be quite common) makes the available
> > range to the scheduler unnecessarily narrow.
> > 
> > And it's clear that whatever the upper bound it's going to be some
> > arbitrary number, but 1ms should ensure that there are other hrtimer
> > interrupts to piggy back on.
> 
> Okay, I have grepped for usleep_range(x[x], yyyy) and there are 9 modules
> use it. A few commit messages call 1000 as "reasonable upper limit".
> 

Right, we usually see a much more narrow range, as you say 2x or perhaps
10x, and this why I said I was glad you asked. I have been wondering
about this in a few different cases...

Thanks,
Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7A4D092A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbiCGVEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiCGVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:04:04 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359C522F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:03:07 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so19482867ooi.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TZE4y2o5AxnkMZnRpncg3DqjupwmSSHQnjBBKyyAtNE=;
        b=vJKoBSejYsc3f9Klw0q/k6zLApJALiY1z7DV1dR6c+uES9Tn0j9yg8PHZjneHAzja3
         CFdcEApqBeuTwu71vmCNyVKq6RfL7lNOuObDzkC722PGJP/lxY4YmLCCEIjPdxWGVp9K
         8qD6H30X3FQkgWQdqYV+dlVH+wEyDA1hlvWAUTUYazwYES09RYO+dXaM0uXw+vdLq4YZ
         x6gh/dRhx4vH8LdYMwYr77WgVKVZDf09aWc/8Q4FjJ/KIrLPK/8vCqsqlHGIlLcpKbyE
         ZnwP5xDWPyiqu43n+NCWn42TFQg6+0+DOOGOSnpj5pELR0vT8MuD7iQE7kF8blmBeYD2
         06Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TZE4y2o5AxnkMZnRpncg3DqjupwmSSHQnjBBKyyAtNE=;
        b=qKBAUTozlZD4KKhF0Bht1F/emTQDDyRYSQxsE6peKlhw4bJpYnT5VoCBswb924DQE9
         MmzOTS6DBKSOC/in/9XPTzAI6kOoR8enhjmcnBtgd4ozUmGFgDryUqg3JdmwwRA7+K1t
         m1jxOAu4BBSqEw6ZAxg/K+/26p6r742RY5rHJ3CJXANuhLtyAIJPTYTYVadF2U5yb7Eb
         i+EeFc4MM0rjA5tN1WT6ENALJx58x2NgedzXz4Scg3yMIy65s8ciHVPfK8OXKeZ73DGW
         CHoFntDSd73LSHCQsQ4Ka36ACo0h7xjRZMwSmAq06kmqe5tekpd81EL0fzaqKEdRG3oR
         3U4w==
X-Gm-Message-State: AOAM533w1atOKvb+HIflP9w2idIKAD+hIFy0bfSv3qnwrrhmSD5WmwO2
        xkO1r8E3zk1OsPaullupDiAaog==
X-Google-Smtp-Source: ABdhPJz8dtqAUl9Wa+QMR22Za4hY/xZ2fVhIBORMjTKKuZxeVipzASzjf0KTjPPgr33ClAzWHw47aQ==
X-Received: by 2002:a05:6870:911f:b0:d9:ad78:203c with SMTP id o31-20020a056870911f00b000d9ad78203cmr528955oae.91.1646686986315;
        Mon, 07 Mar 2022 13:03:06 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id q9-20020a4ae649000000b00320d35fc91dsm2814437oot.24.2022.03.07.13.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:03:05 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:04:50 -0800
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
Message-ID: <YiZzco76Nrxbxz95@ripper>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-7-bjorn.andersson@linaro.org>
 <YiXbg4QwgIgLh3LW@smile.fi.intel.com>
 <YiYbOQpX4+fP8S1W@ripper>
 <YiYvMf5X+S0WZ9lO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYvMf5X+S0WZ9lO@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Mar 08:13 PST 2022, Andy Shevchenko wrote:

> On Mon, Mar 07, 2022 at 06:48:25AM -0800, Bjorn Andersson wrote:
> > On Mon 07 Mar 02:16 PST 2022, Andy Shevchenko wrote:
> > > On Sun, Mar 06, 2022 at 07:40:40PM -0800, Bjorn Andersson wrote:
> 
> ...
> 
> > > > +		/* 15us to allow the SBU switch to turn off */
> > > > +		usleep_range(15, 1000);
> > > 
> > > This is quite unusual range.
> > > 
> > > If you are fine with the long delay, why to stress the system on it?
> > > Otherwise the use of 1000 is unclear.
> > > 
> > > That said, I would expect one of the below:
> > > 
> > > 		usleep_range(15, 30);
> > > 		usleep_range(500, 1000);
> > 
> > Glad you asked about that, as you say the typical form is to keep the
> > range within 2x of the lower value, or perhaps lower + 5.
> > 
> > But if the purpose is to specify a minimum time and then give a max to
> > give the system some flexibility in it's decision of when to wake up.
> > And in situations such as this, we're talking about someone connecting a
> > cable, so we're in "no rush" and I picked the completely arbitrary 1ms
> > as the max.
> > 
> > Do you see any drawback of this much higher number? (Other than it
> > looking "wrong")
> 
> I see the drawback of low number.

15us is based on the data sheet and if the kernel is ready to serve us
after 15us then let's do that.

> The 1000 makes not much sense to me with the minimum 66x times less.
> If there is no rush, use some reasonable values,
> what about
> 
> 		usleep_range(100, 1000);
> 
> ? 10x is way better than 66x.

I don't agree, and in particular putting 100 here because it's 1/10 of
the number I just made up doesn't sounds like a good reason. The
datasheet says 15us, so that is at least based on something real.


In https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
I find the following:

    With the introduction of a range, the scheduler is
    free to coalesce your wakeup with any other wakeup
    that may have happened for other reasons, or at the
    worst case, fire an interrupt for your upper bound.

    The larger a range you supply, the greater a chance
    that you will not trigger an interrupt; this should
    be balanced with what is an acceptable upper bound on
    delay / performance for your specific code path. Exact
    tolerances here are very situation specific, thus it
    is left to the caller to determine a reasonable range.

Which to me says that the wider range is perfectly reasonable. In
particular 15, 30 (which seems to be quite common) makes the available
range to the scheduler unnecessarily narrow.

And it's clear that whatever the upper bound it's going to be some
arbitrary number, but 1ms should ensure that there are other hrtimer
interrupts to piggy back on.

Regards,
Bjorn

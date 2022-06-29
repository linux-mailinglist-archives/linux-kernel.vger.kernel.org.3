Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA17B560319
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiF2Oef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiF2Oec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:34:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB762FE75
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:34:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so22815097wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YwMx0K+gB3HnfOSE/DE2vrY/Xv/2KVNuV7bbWiBmaZ0=;
        b=t9d7mxbayU9fIxs7aB/naMkZBP7l+LB6KH3Q7/svGPGRxMZ7Dfi+ksGvt+svcEOlNT
         kxG6N2ARP+ITeZ6J1JBJ9/jhyZktQLeQ/e+AHtAQWcwLm46OY7hwoCme3NGIsfwP2Tb+
         UVDVvExHIadq/M8Ml4it499RACT/BvAMnRgsH35czmZ/nzFsyF20f//qRm40DeYXNtvN
         Z+FMjR7wkLHSyS5w9xicqOiW19If5WT5qx8sLDn8HDncWudbKR7RpU7+WhpN4smdMbs0
         V23Fya+2wFTStvRB0Sr3SSmjOhn/c+0IAUc+WhABtlBC0f39l6FZZqb+VHWpts3z3afv
         OoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YwMx0K+gB3HnfOSE/DE2vrY/Xv/2KVNuV7bbWiBmaZ0=;
        b=RsEZRIiVcEh7nOsgReRWErsChK4/f4uSQY3DTYn/rzIq32G2iu5rZ+0CP8m3rEhljM
         ZqBIfBZIJ0E8zK/E9OD7Ak8Fq1aCUw/AwolH/SoJoVZn44gTzI+GqK5wljKBl8kMHoWM
         dOSr+1IBE4ltz+lcXDKn9TV0o5eplENJKI5nyz3/fxRESAb8v9VPNcG0gW8EtnHuMEXP
         4s9ai+WnVVF9EARYjA53txJDjgQACmDaudEcyVbLJIC5dhpGDPXn0Rtfk29L5vPic761
         torYghfPWu8YevB4Ol9OoW6lBAT8x0xQUGKBGghtGHlybn+szjqBVNl4w22eiLEKo80Q
         V0MQ==
X-Gm-Message-State: AJIora+W/hXWLNIR0JINEIbIAOxTsL/XxS6/PnjFsDY0e3peHQ0lVQcI
        Z1N4WxwreVSy6S6PIVK2kKFnCC6mD7bedw==
X-Google-Smtp-Source: AGRyM1umikRDYY2EzECrH+k3F0zE2vjjXOiJXU4UF3+4icuztKJspdIa5ONAJkbyUybgCAUsSFH+Ng==
X-Received: by 2002:adf:d1ca:0:b0:21b:a858:3698 with SMTP id b10-20020adfd1ca000000b0021ba8583698mr3532556wrd.172.1656513270704;
        Wed, 29 Jun 2022 07:34:30 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b0039c5328ad92sm3599133wmq.41.2022.06.29.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:34:29 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:34:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error
 codes in show()/store()
Message-ID: <Yrxi8xKjVXsckrWX@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <Yrlyw1eMFy4kd0JB@google.com>
 <YrrNxEIMuYLpzCd1@smile.fi.intel.com>
 <YrrOHtDjI+P6Iq0r@google.com>
 <YrraKMemrHImty7s@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrraKMemrHImty7s@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022, Andy Shevchenko wrote:

> On Tue, Jun 28, 2022 at 10:47:10AM +0100, Lee Jones wrote:
> > On Tue, 28 Jun 2022, Andy Shevchenko wrote:
> > > On Mon, Jun 27, 2022 at 10:05:07AM +0100, Lee Jones wrote:
> > > > On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > +	ret = kstrtoul(buf, 0, &bxtwc_reg_addr);
> > > > > +	if (ret) {
> > > > >  		dev_err(dev, "Invalid register address\n");
> > > > 
> > > > Is that really what failure means, on every failure?
> > > > 
> > > >   "Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing
> > > >    error."
> > > 
> > > As far as I can see in either case the address is invalid.
> > > Basically we may drop this confusing error message here, if
> > > this what you prefer.
> > 
> > Your call.  I just wanted you to consider it for a moment.
> 
> Userspace will print an error based on the error code, so
> I would rather remove _this_ message since it doesn't add
> value, esp. when we could have -ERANGE.

Works for me.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

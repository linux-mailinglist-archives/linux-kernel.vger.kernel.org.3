Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDB568B78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiGFOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiGFOjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:39:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5F21E2A;
        Wed,  6 Jul 2022 07:39:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h17so9226401wrx.0;
        Wed, 06 Jul 2022 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nbQzGLyZt6vzMT4BrPBKi6wsfX0WBie55S1iaaXmviw=;
        b=KCmuH45Vy/rpX/YO/8zkdGIjPwhBYbYTx4AAuan5fdQsofigAJqvELTwsriH+fNszk
         8ibZuqSZb0KkiBhVZaHKQu2ofbuuSc2j2Er6SS0P/OcGNiw3Qk4x2WSdUJqWQwnp0tOH
         AoCdkpjvY2D46ih6+FHsGjqI4+oUTBq5PMgRafwnLQNdjGF51y5dpzLJEcGv5U0D5y0m
         zmmHDfIouMDdPYEIRtWJwVoZrIwKiqQwFx7ysqEIv9qu8YOPnzhBEiZtMQt7o9xSUj9B
         vGW7pMrIyHBP8WIAocwjP2crsF9F9NVABukfZtlL4JleU+HPb/zdaCCWC3sbjH495cOX
         DSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nbQzGLyZt6vzMT4BrPBKi6wsfX0WBie55S1iaaXmviw=;
        b=LtWHKRgTG7ZvZv7NlWx9LOVCoFnS9K8bUa4Q9cWvVgyX/URMfldoF0USDlngypX7/d
         veva2vUJtX2Z4jeeJdV7jyoTz/wVj9I/vqaPXE6NLxgwYwRcOj7WSz2WBXYM97uOSSGx
         BgnWPcQUwYEo9v0u6GBWQ65IF5AfTH7XNdOk/7YdauotSE7ZGxNzKozDXyzyEoiRUb8/
         objJ204lJTw9c9MtZqF0zKJ/Nm7jl45cBzEre2l/uA5omEf4mF/O7MIjviGnXPSlCsuV
         Iol6NNngPtb/VXwfkHUdlC+BEdu7xwG8wRxEjSvabr2UY+WwYojCIzP6g6/sJCWWfq3x
         Z+CA==
X-Gm-Message-State: AJIora9gNrWcnay1zrkvi7WNkFpsd7vfvNEDsR4tbEZ/pNP9tVuDek3F
        ChU2ZnPsF7xqFW1l2FpX98k=
X-Google-Smtp-Source: AGRyM1sCnYfNWrP9a6CSVlU5BzXSjjrZmNGdu/l9Zkwg02x4RMZljumMZCkx5SDH7ztA2RR8lp07bw==
X-Received: by 2002:a5d:4982:0:b0:21d:6e04:1fb3 with SMTP id r2-20020a5d4982000000b0021d6e041fb3mr12404193wrq.69.1657118356381;
        Wed, 06 Jul 2022 07:39:16 -0700 (PDT)
Received: from [192.168.1.126] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm43580911wrm.27.2022.07.06.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:39:15 -0700 (PDT)
Message-ID: <dd655cf6e49cac219a5ae29bff1a19fd026c6ea5.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Adds more tunable config
 parameters for BMP380
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Jul 2022 16:39:13 +0200
In-Reply-To: <CAHp75VcEAtpVsfp2CCtJR_e_eSSFaMkODFwd-ZuHKGsNPcVWfA@mail.gmail.com>
References: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
         <CAHp75VdBv8BJVzBCMzWKpm0RrqX=K_QPQ4cgdshqXP3Uy+hVHQ@mail.gmail.com>
         <b9280ecbf78424882878ef2ff6c3da6671064ed5.camel@gmail.com>
         <CAHp75VcEAtpVsfp2CCtJR_e_eSSFaMkODFwd-ZuHKGsNPcVWfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mié, 2022-07-06 at 14:42 +0200, Andy Shevchenko wrote:
> On Wed, Jul 6, 2022 at 12:51 AM Angel Iglesias <ang.iglesiasg@gmail.com>
> wrote:
> > On Mon, 2022-07-04 at 22:08 +0200, Andy Shevchenko wrote:
> > > On Mon, Jul 4, 2022 at 2:41 AM Angel Iglesias <ang.iglesiasg@gmail.com>
> > > wrote:
> 
> ...
> 
> > > > +               if (unlikely(!data->chip_info->sampling_freq_avail)) {
> > > 
> > > Why unlikely() ? How does this improve code generation / performance?
> > 
> > As Jonathan Cameron sugested on a previous version of the patch, even
> > thought
> > this code should be safe (as if we are checking sampling frequency is
> > because
> > the sensor is a BMP380 and has that property), it would be better to have a
> > sanity check just to be sure the property is really available. I used
> > unlikely
> > macro to take into account that the property would be almost always
> > initialized.
> > 
> > Now that you mention, probably this code won't be called too often to make
> > the
> > "unlikely" branching hint make a meaningful performance difference
> > 
> > > > +               if (unlikely(!data->chip_info->iir_filter_coeffs_avail))
> > > > {
> > > 
> > > Ditto.
> 
> Is this really a performance-critical path? How did you check that
> unlikely() makes sense?
> More evidence, please!

You're right. This code will be invoked by userspace using the sysfs ABI,
probably just once, to check sensor settings. The unlikely() is out place, I'll
drop it in next patch iteration.

> ...
> 
> > > Why do you need to copy'n'paste dozens of the very same comment?
> > > Wouldn't it be enough to explain it somewhere at the top of the file
> > > or in the respective documentation (if it exists)?
> 
> No answer?

Apologies, I'll fix the duplicated comments. Would be a good place for the
comment before the function "bmp280_write_raw" or at the start of the switch
block?



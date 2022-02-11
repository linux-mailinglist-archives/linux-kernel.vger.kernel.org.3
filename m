Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB4A4B23A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349082AbiBKKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:45:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiBKKpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:45:36 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A326D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:45:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d10so21958452eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEW2+OnrIkGv90ItjjI8TR+nuEuIp7MUjbB4JMbaggo=;
        b=ep3FY7eQZnxLi4wlb1RXoC5DFZ8SVDjOMraC6VvPF+V08SrAPm2KOsc3w0HKC5HstJ
         nTF5ZNtIYG4Ty8VEy3ISS/61/2h9mAzGMXQt/+oCYPe0Ryr6YMUXlmEVOv/eAhE/o7pk
         j/HMcHUXOVFPy4oS3bqLg9ztgr/vq3ihcMC175EL265Q1rnL2ACdemzaWBbC5UlPY3jn
         BJfi28Xxnxi77Dp7VDrv5rAbOm2GcJ/IP4yu5NOmf4z2FAV07Oa69157k5kwb6ASaShY
         9miKSEx+qk35EgIBMNKBb7wKEZzlcWrkp/fNNtoo7oZsy6Yl5bvRlj/tdmJcCRFFNL4Y
         gFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEW2+OnrIkGv90ItjjI8TR+nuEuIp7MUjbB4JMbaggo=;
        b=clsCNJ+JXzYFflRBVqCqJi9LNU6mABmjnP6NM+kw5fimM3OFgCI2/yEBiVZiGjtSjC
         XAcMq8lo30Ju6NttN2ZhUokR2DiW+naxuEKma0xc+i2sarlRCRAqRa8tGF3nq9fUwvD7
         gI0wvkSnoDN2Fc2ItlJpOincG1aYLZwELh8d5CwchDAmSW6TjaJWYASnyQQeFjfM9ACQ
         ugBYYvqv/X/+COsNj0/b1OyA579dUo6+iQ1kiXSGytILznEkb84ZuDH3zhWZbLu4Ovdv
         jMkbzTNR5ctnACUfO5i6XAUJb/lc082lXlp/DaMkWiK8aBV8dGfnvt0+uausxWp5Mp96
         UYZA==
X-Gm-Message-State: AOAM530Q6CNKtjJZ667kr7PRHHkr1ZLgASxoIQvQeNMWKnCe8G90QNK7
        ixckM3Zvnv76+O0i1HagfK6nMg==
X-Google-Smtp-Source: ABdhPJwmsfIEHznt5tWec/CynJt6DvRsSkSwbKJmKjr9ay7z87boYJEanc75X3b9sEO4bPyHlKj4og==
X-Received: by 2002:a17:906:f855:: with SMTP id ks21mr821099ejb.181.1644576332863;
        Fri, 11 Feb 2022 02:45:32 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id s16sm4701470edt.91.2022.02.11.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:45:32 -0800 (PST)
Date:   Fri, 11 Feb 2022 18:45:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
Message-ID: <20220211104528.GA475776@leoy-ThinkPad-X240s>
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
 <20220205153940.GB391033@leoy-ThinkPad-X240s>
 <4d5951ee-d7d2-1e76-eb24-5f3c46d1662c@arm.com>
 <20220208130047.GA273989@leoy-ThinkPad-X240s>
 <e68839bc-b4f0-1fe8-1748-484254ded37a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68839bc-b4f0-1fe8-1748-484254ded37a@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Thu, Feb 10, 2022 at 05:23:50PM +0000, German Gomez wrote:

[...]

> >>>> One way to fix this is by caching the value of the CX bit during the
> >>>> initialization of the PMU event, so that it remains consistent for the
> >>>> duration of the session.
> >>>>
> >>>> [...]
> > So the patch makes sense to me.  Just a minor comment:
> >
> > Here we can define a u64 for recording pmscr value rather than a
> > bool value.
> >
> > struct arm_spe_pmu {
> >     ...
> >     u64 pmscr;
> > };
> 
> I agree with the comment from Will that it makes more sense to store the
> value of the register in the perf_event somehow (due to misunderstanding
> from my side, I thought arm_spe_pmu struct was local to the session).

It's shame that I miss this point :) As you said, struct arm_spe_pmu is
a data structure for Arm SPE device driver instance and it's not
allocated for perf session.

> What about perf_event's void *pmu_private?

Before we use perf_event::pmu_private, could you check the data
structure arm_spe_pmu_buf firstly?  This data structure is allocated
when setup AUX ring buffer (so it's allocated for perf session).
IIUC, the function arm_spe_pmu_setup_aux() will be invoked in the perf
process, so it's good for us to initialize pmscr in this function.

Thanks,
Leo

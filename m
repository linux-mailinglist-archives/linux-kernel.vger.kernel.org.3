Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85F4AEA2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiBIGRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:17:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiBIGPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:15:25 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1014E00ED57
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:15:29 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n23so2599533pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 22:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4l/aFNwd63uVLKNzeMm/2/pR6vs/tYGDEs6LgxVDxlI=;
        b=r1fiqywmY+ZXjFns4iy4OyiewaVgMm0NsTnoz629RyyIhdlq8v/wSp0eNSiEThtCR+
         tbze/g+/ol7lhlw5SoWxsXGKGJm/BGjeK2OgefivPq8rC/kd69by2eh/XAqS08Sz/yOp
         oRdKYg4ECKxNmOp8ch3Adi0KmBe6qZnsrDnjvAtP0A0IKsdlBEfJKAgoSI9agqb90W/b
         NysePOlOF4FtXKvvLKwcGXHSMGRgspJpDIYkrZ247uRQLIvuqe9vSvTGqQNBvKuSTBvb
         FEn9RBMF7W0H69VY3UD26kT52kWkGmcpqOVYYvyY8A448QS24UGkCk/tQsaqo6X3Pt14
         4MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4l/aFNwd63uVLKNzeMm/2/pR6vs/tYGDEs6LgxVDxlI=;
        b=QokFqKm44alTcLaxNbStMCEJCcjlVHD6RkLeVdN3WBe7NP4+1Ccldvdd0o3l9Gi2gA
         8jXSIVfm7uqet89xOLYLCoyrlRkK6053walWNuk1X4SZ42pV60Bem1LK6oaZahwRREW/
         6ji9xJ1WDdVXy6FP/8KZo+Dd/HIiQtnZn5Ewjkq0D5UkOTeqsI/8w7FagoWskhaM0Fkb
         4yHZ50JIljLjswBs4BB9xK1IwiksfkWAV8P7+Nbk7VaVMNYNLr9EwxxHWqSn4JDKPcgw
         kU3+zU6QYGxt3ZxJaCb17UN1Bzf/gZbLVNjOorcDLYTByciD22ezuJcl+Gnt02Ev37Al
         TnKQ==
X-Gm-Message-State: AOAM530/g4gTPaLAX7htuPhQYqh5FVzz5pwd44xh1q9AYQ8rAFithr4o
        UkrQZeG3G2j8/7kCvYOr5qCydA==
X-Google-Smtp-Source: ABdhPJw6hRR+tHVYkKn3k15p+UCUOzqAo6H+niApeRvxhdpTbpiTd9O3cmPCS3R7fY6sD2XFQhj5iQ==
X-Received: by 2002:a63:f50f:: with SMTP id w15mr716344pgh.113.1644387321236;
        Tue, 08 Feb 2022 22:15:21 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id o2sm6879778pga.57.2022.02.08.22.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:15:20 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:45:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 16/54] cpufreq: replace cpumask_weight with cpumask_empty
 where appropriate
Message-ID: <20220209061518.4xxc3hsswrfgg5u4@vireshk-i7>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-17-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-17-yury.norov@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-22, 10:38, Yury Norov wrote:
> drivers/cpufreq calls cpumask_weight() to check if any bit of a given
> cpumask is set. We can do it more efficiently with cpumask_empty() because
> cpumask_empty() stops traversing the cpumask as soon as it finds first set
> bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  drivers/cpufreq/scmi-cpufreq.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

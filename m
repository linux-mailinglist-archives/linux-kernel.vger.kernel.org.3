Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE384493C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348843AbiASPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355617AbiASPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:05:19 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46ECC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:05:18 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso3437056otj.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rT9FJ0j7/GR3QV3pYKP9vdE5VbXyREPL1/JFSj49N9s=;
        b=TkP0onxPtD5jB1gt+D1/yPotxgObqZuoJ/oopIGNyr03TMDZ7ffUflSnGXNAV0hBNY
         BNwV6mQbgB6X6N1lGoQnuS3jSZr3RFboo+vWCYPZ7/Auy9axTIv6HvhunxexwcEsulex
         TXvAqRxLAMXqpjBfp/a3bOjQ4fvrv1DATGjwX5CjV/byPb+y5ESE3Y5Mb78UYIy+VXSZ
         1je7N4dc4VJZ3qCyrJ/0MO2YrAYFMOQ4E/lSrau8JkqGfzbBbrrsMMxazFTSCI4UQqGN
         cNfBwEAtOLJxHzE6fYt9uGIk7onUWOkr8hJG57D8d0ukqepWeoTI8A+a1kkktS9KWcBM
         JSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rT9FJ0j7/GR3QV3pYKP9vdE5VbXyREPL1/JFSj49N9s=;
        b=Pr2ssvanCX9Cdb47wwqkJ7M5mJ5j7+9EtitzoZkLNUG7PT7CmqBkEy/Ns+9XXZtubY
         +fMwu48KrhXJxotuhHi4E4UvCaEdC//oihxQghYMPi2iEvY0Q2Fiq8yS3zM/7aBXnuEN
         gwykjDQOgUfB3uHzw+hmbbC82tmYCxJFGraozmks1qk5ETp07WdQCbnd0vjSct8I4Yx9
         /0tkW0RUilHEpmMrHiV6dc7+Q3KWGKWas+qynpG+6/EmYi4GTBvdSkgvQ/GdkHyUnu5A
         jxPfHlFG8d1Z9lP55q95JaUAn9Y2SbCD/blI2TyM1pNs7mK/mPcSzeEfqtp4dH8pGvs9
         koEg==
X-Gm-Message-State: AOAM531Jmbh7DdWL04mDvCic5ZucpK3h3wQ8i0VnqfzXwfe73Z7P9L1B
        qXl+lh0sZy4J96kyuv9wC6UeaQ==
X-Google-Smtp-Source: ABdhPJzUIi3KXQuwlo8bH34JPGPPIl8ckdmaGpfQ9ZMEiW7t0Q0G9kj77P/h92SFPMEX42ha38Va0Q==
X-Received: by 2002:a05:6830:2684:: with SMTP id l4mr14282953otu.79.1642604717967;
        Wed, 19 Jan 2022 07:05:17 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w22sm9105oov.24.2022.01.19.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:05:17 -0800 (PST)
Date:   Wed, 19 Jan 2022 07:05:52 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: qcom-hw: Use initialized cpumask for
 thermal pressure update
Message-ID: <Yego0BwrVXkqqJOm@ripper>
References: <20220118185612.2067031-1-bjorn.andersson@linaro.org>
 <20220119063547.hktwzbycf7trqjju@vireshk-i7>
 <20220119064029.b2yhqcazhpdbhasc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119064029.b2yhqcazhpdbhasc@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18 Jan 22:40 PST 2022, Viresh Kumar wrote:

> On 19-01-22, 12:05, Viresh Kumar wrote:
> > policy->cpus keeps on changing with CPU hotplug and this can leave
> > your platform in an inconsistent state. For example, in case where you
> > offline a CPU from policy, other CPUs get their thermal pressure
> > updated, online the CPU back and all CPUs of a policy don't have the
> > same settings anymore.
> > 

Oh, I didn't know that. Then my proposal doesn't seem that awesome.

> > There are few things we can do here now:
> > 
> > - Check for empty related_cpus and return early. Since related_cpus is
> >   updated only once, this shall work just fine and must not be racy.
> > 
> >   While at it, I think we can also do something like this in
> >   topology_update_thermal_pressure() instead:
> > 
> >   	cpu = cpumask_first(cpus);
> >         if (unlikely(cpu >= NR_CPUS))
> >                 return;
> > 
> > - And while writing this email, I dropped all other ideas in favor of
> >   change to topology_update_thermal_pressure() :)
> 
> And then I saw your second patch, which looks good as otherwise we
> will not be able to catch the bug in our system where we are sending
> the empty cpumask :)
> 
> So the other idea is:
> 
> - Revert, or bring back a new version of this and register the
>   interrupt from there. But that is also not a very clean solution.
> 
>   commit 4bf8e582119e ("cpufreq: Remove ready() callback")
> 

We could do this and keep the interrupt disabled until we hit ready().

But I found the resulting issue non-trivial to debug, so I would prefer
if arch_update_thermal_pressure() dealt with the empty cpumask. So as
you suggest in your first reply, I'll respin the second patch alone,
without the WARN_ON().

Thanks,
Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7557493CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355676AbiASPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344565AbiASPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:21:00 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD5C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:21:00 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id k15-20020a4a850f000000b002dc3cdb0256so833415ooh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u+VlURNkFbcvnlcKAhj9AzbW+2y4iy8uqcT2Hg3D05w=;
        b=PqjhB4OWRy0R4raPT4KWqqKggpggvSj3ieBshqWNHsD7eJ2VhpM0J+6sma/iN9cnrr
         P6q5ecnenTFRFEe7xPoOjA7I1JJI1LR4oawI6wX5gbUKMSFx+nULv+CaqPels7MY7/3j
         BWNJI0aeFuNyNFTjOgHg1WkTN/5lANvt9aD0OSB6sikWDRxr2FMJEG6QqxFlIk+RS9Rs
         pbsV8UyArjhyPAPwq+JYLNjCKEI+ByurR5j86Py7nEUw0cqIh4ttim+FsEUEqT648Aex
         fFVcIyM2Az5ny/EhEF5PKOWAkrR25/yOaN5gMu/tDcfh7oMAS6zhvdz6ECDSpI+0YH5m
         HxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+VlURNkFbcvnlcKAhj9AzbW+2y4iy8uqcT2Hg3D05w=;
        b=sfO33mJ09ssWpwjz0stzLhppgD4bn8sJyvJF8Zhu6j858ge/FImtjCtLXBBslUV+SG
         7pP153sKFGuEH6fVYVC0tglVRPjvlkhcHQ1xStbtR1PfsmAeS7AeOewdJaluuUsNI85p
         Kg/c9X1cewf5MYVyOoVzuiqAnp539cp66gH++BHZBeZzn2xnhS9vzvlp3LBswGx0eAVm
         iG6OOYFf0wfzKsNpFYYTHDzNkc9bK2u4s6TXsmYOlSfMuEkKbVz2T43wIQgoKpLMzjRg
         sT7aCaoZ6n67S0gNb32gFkVLhPsyLZRreBVE0CGkGrIWjfOfvm6x4hHjh9guizENRaEJ
         nL/g==
X-Gm-Message-State: AOAM533SERDieI2jbo5swJf7gtB0lIHPg+rg7JzfRwahzxwUgiKtdVNn
        tfpMRdol6uDLqhWKIBYfCqtT6g==
X-Google-Smtp-Source: ABdhPJzciEV+DLP4ljYzj4If36zEm4Yn76ryBLFy7hYXn+XWNeljTJgFZOKilcrC59nl8wBqkg4Qaw==
X-Received: by 2002:a4a:3e53:: with SMTP id t80mr22119292oot.74.1642605659248;
        Wed, 19 Jan 2022 07:20:59 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d15sm40204oiw.4.2022.01.19.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:20:58 -0800 (PST)
Date:   Wed, 19 Jan 2022 07:21:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] arch_topology: Sanity check cpumask in thermal
 pressure update
Message-ID: <YegsfuLPJDqYPr0n@ripper>
References: <20220118185612.2067031-1-bjorn.andersson@linaro.org>
 <20220118185612.2067031-2-bjorn.andersson@linaro.org>
 <20220119144328.cvt76mhsufxg7qbr@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119144328.cvt76mhsufxg7qbr@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Jan 06:43 PST 2022, Sudeep Holla wrote:

> On Tue, Jan 18, 2022 at 10:56:12AM -0800, Bjorn Andersson wrote:
> > Occasionally during boot the Qualcomm cpufreq driver was able to cause
> > an invalid memory access in topology_update_thermal_pressure() on the
> > line:
> > 
> > 	if (max_freq <= capped_freq)
> > 
> > It turns out that this was caused by a race, which resulted in the
> > cpumask passed to the function being empty, in which case
> > cpumask_first() will return a cpu beyond the number of valid cpus, which
> > when used to access the per_cpu max_freq would return invalid pointer.
> > 
> > The bug in the Qualcomm cpufreq driver is being fixed, but having a
> > sanity check of the arguments would have saved quite a bit of time and
> > it's not unlikely that others will run into the same issue.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/base/arch_topology.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 976154140f0b..6560a0c3b969 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -177,6 +177,9 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
> >  	u32 max_freq;
> >  	int cpu;
> >  
> > +	if (WARN_ON(cpumask_empty(cpus)))
> > +		return;
> > +
> 
> Why can't the caller check and call this only when cpus is not empty ?
> IIUC there are many such APIs that use cpumask and could result in similar
> issues if called with empty cpus. Probably we could add a note that cpus
> must not be empty if that helps the callers ?
> 

As indicated in the commit message, it took me a while to conclude that
the cause for a memory fault on what seemed to be a comparison between
two variables on the stack was actually caused by this race - which
isn't trivially reproducible, unless you know what the bug is.

Now _I_ know better and will hopefully recognize the oops signature
right away, but my hope was to put the sanity check on this side to save
the next caller of this API some time. Updating the comment probably
would have saved me a minute or two at the end, probably as confirmation
of my findings after the fact...

If you prefer to keep topology_update_thermal_pressure() clean(er) and
exciting I can hack around the issue in the Qualcomm driver.

PS. I'm onboard with Greg's objection to the WARN_ON()...

Regards,
Bjorn

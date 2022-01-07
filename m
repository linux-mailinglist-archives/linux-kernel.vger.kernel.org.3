Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD63487F98
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiAGXud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiAGXud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:50:33 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E4AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:50:32 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso8248940otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MtaD0jiMFwAF1y23324QcO/uLTF1MdIlBdqofV7+EOc=;
        b=Q+B2lEj0bz8JV+KmSIt6rAYLeSA47VFwgPmyyJHDdfeozhwIqTwykMCHq17LlfcTz5
         vjIELSVRqAZ9zs+G75wAyWpm2i3Y2u6Kspaumwln3M6SI0krQV9GEThAeOl0bwKRWDR3
         FyyNK1+JCt8qOb21gIHhKUPXvhyfXrBuFMixtbLWh+1Wo012DrUJYwLe6vorrykjAadS
         cwY/1OU7P9hfa0G2ilSPtl674kNTccKEkBFqkjDgS2D/1C3ZZQ+KrnBXHOshCcxfwo2K
         DHlGIuD8f+8qnIa2Yr4XVbkXPXIcXxgn9MPN0UpFdJPzee1LvApu5jGUdX5aNhab1uiy
         6hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MtaD0jiMFwAF1y23324QcO/uLTF1MdIlBdqofV7+EOc=;
        b=WQqMaQswzKcf9JjQcEXjJCw8rXieLLJA4AGUtujSHKSm2yYNmANcmEsRsD4kMExaVj
         Q3R00W0FD8Mdug6ZIhZ7ysGCb8lpJw/xr817ui/ul/gfaCCyhcHb3kGl2kbN8yF4PRPX
         W23CP356+fv4Dsjit9A6Qj2+EJmpM6QH7PqjYf4tk2jgqGNBi2ByF3GTGnXws3UVMge7
         zsnsaMC5V2tu7Z/0dqFfmeEc7vmVHRfj3CQ1BlzNmiyp/gBpjXqXHPP3JO/9ai1sNc18
         PTrddj8scm38p+ROfy2/IB1WcXq2s9ZQmd1xHkpwGe392t1TIC1uEcRobJHqCNViOhyF
         /sXQ==
X-Gm-Message-State: AOAM531reE1kK6oySLkVr448mIx+hGad/03fLBJx/MjaMCrZme75hkNk
        +bn/b0znRXM8m6PrqtgrhkC1hQ==
X-Google-Smtp-Source: ABdhPJxklGIFuq/RlZCNvCdPn3v/sMlRnAHaJ5h26MfOvxULajImCkiEjEqmrndPQwpf1X/OszmkAg==
X-Received: by 2002:a05:6830:2b20:: with SMTP id l32mr47965797otv.333.1641599432328;
        Fri, 07 Jan 2022 15:50:32 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i25sm33714otl.8.2022.01.07.15.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:50:31 -0800 (PST)
Date:   Fri, 7 Jan 2022 15:51:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Andy Gross <agross@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] qcom/soc/drivers: Add DTPM description for sdm845
Message-ID: <YdjR9kQSFEydZybr@ripper>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-7-daniel.lezcano@linaro.org>
 <YdiUOh8FtPRktlUM@ripper>
 <8e2fa6b6-4f95-9381-4d7e-810afe98fcea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2fa6b6-4f95-9381-4d7e-810afe98fcea@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jan 14:07 PST 2022, Daniel Lezcano wrote:

> 
> Hi Bjorn,
> 
> On 07/01/2022 20:27, Bjorn Andersson wrote:
> 
> [ ... ]
> 
> >> +#include <linux/dtpm.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +static struct dtpm_node __initdata sdm845_hierarchy[] = {
> >> +	[0]{ .name = "sdm845" },
> > 
> > Why is the index signifiant here?
> > Doesn't this imply risk that we forget one element, which will be
> > thereby implicitly be left initialized as {} and hence denote
> > termination of the list?
> 
> Yes, that is possible. The other annotation is also possible. The index
> helps to refer from the .parent field.
> 
> That said nothing forces to use the index, so it is a matter of taste.
> 
> >> +	[1]{ .name = "package",
> >> +	     .parent = &sdm845_hierarchy[0] },
> >> +	[2]{ .name = "/cpus/cpu@0",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[3]{ .name = "/cpus/cpu@100",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[4]{ .name = "/cpus/cpu@200",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[5]{ .name = "/cpus/cpu@300",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[6]{ .name = "/cpus/cpu@400",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[7]{ .name = "/cpus/cpu@500",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[8]{ .name = "/cpus/cpu@600",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[9]{ .name = "/cpus/cpu@700",
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[10]{ .name = "/soc@0/gpu@5000000",
> > 
> > It worries me that we encode the textual structure of the dts in the
> > kernel. E.g. for quite a while this was "/soc/gpu@5000000", so if this
> > landed a year ago this driver would have prevented us from correcting
> > the dts.
> 
> Why ? The change should be reflected in the driver also, no ?
> 

There was no update needed to change /soc to /soc@0, but with this
driver in place we would need to do that.

The problem is that the life cycle of the DTB is different from Linux
and we promise our users that the kernel will be backwards compatible
with existing DTBs (at least for a reasonable amount of time).

So if we made a change in the kernel to turn the incorrect
"/soc/gpu@5000000" into "/soc@0/gpu@5000000" we would no longer find a
match if you try to boot with yesterday's DTB.

> > Another concern is that not all busses in the system are capable of
> > 36-bit wide addresses, so it's plausible that we might one day have to
> > create a more accurate representation of the address space. Maybe not on
> > SDM845, but this would force us to be inconsistent.
> 
> Sorry, I'm missing the point :/
> 
> If a change is done in the DT, the code using the description must be
> changed accordingly, no?
> 

No, the kernel should continue to function with the old DTB.

Consider when your Linux distro gives you a new kernel version on your
computer, that shouldn't require an upgrade of "BIOS" in order to boot
the new kernel.

Regards,
Bjorn

> 
> > Regards,
> > Bjorn
> > 
> >> +	     .type = DTPM_NODE_DT,
> >> +	     .parent = &sdm845_hierarchy[1] },
> >> +	[11]{ },
> >> +};
> >> +
> >> +static struct of_device_id __initdata sdm845_dtpm_match_table[] = {
> >> +        { .compatible = "qcom,sdm845", .data = sdm845_hierarchy },
> >> +        {},
> >> +};
> >> +
> >> +static int __init sdm845_dtpm_init(void)
> >> +{
> >> +	return dtpm_create_hierarchy(sdm845_dtpm_match_table);
> >> +}
> >> +late_initcall(sdm845_dtpm_init);
> >> +
> >> +MODULE_DESCRIPTION("Qualcomm DTPM driver");
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_ALIAS("platform:dtpm");
> >> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
> >> +
> >> -- 
> >> 2.25.1
> >>
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org ??? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

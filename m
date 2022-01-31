Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A5D4A4C58
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380568AbiAaQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380562AbiAaQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:41:50 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81527C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:41:50 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso3350313oop.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lccbg+paMSrfNOlYw3jpPC9OWvbn/WwrDOZkcaZPvcE=;
        b=vijErlFOE7h9CFvOpGy5DofZSxon73a/2uogpCN2gsvHTCGhtwRERz8/825La3DaiX
         5ipwWnhjPWnbhZzKKegWu7eX3EbQinJ6B/KX1zZASrd+0GO6Ew3P1BEDxz+RPnYEWFuk
         J2O7AvzQ+xnSrIyZZfLfwDfzNhixKOVivSZldDFMSK4UqLIGLlO9QcQb5vXlXHPgVVpn
         ehjYw9jUhbkfBs24LjgEgEh4mHfVE4n4M4cZGQVt+If2HdEn6tjGcw8Q1kAKLCMdryY0
         pfrmCRnKIoZk+NjASoWjPPW7T8dasrC+7+OvpoObpj460j6TpxdwEJr7uLjzJ7hNQS90
         DdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lccbg+paMSrfNOlYw3jpPC9OWvbn/WwrDOZkcaZPvcE=;
        b=AAN9UiPxTmL/K8d67BRBB9SB1yhYInHkQECA3vIJc0dWzLXmbFGBYJZuC2wwr+fggp
         29UoM5lJp8kSCokowG4uQpbgdW2B6ofZx5yo9UHyVIJeREEwlaTGf3fkypuqdvgOsr1S
         RoszKnaB4q13fKkyA/MgNAJe3QVG1OQ2fn12CKZGo++edMRlZLebBjIIwEcu+7m+O+ij
         48DkQX7fwzCq7nb1OgXVo/RqWf5nVBY7KFfIXAuY6Q0GpzrOzpmj+qROVKnVdf31AWcn
         dyWi5mUFDZ+776TYYuhkjQ/tXSomoa/6Ooc12e5eaczbAvpOPV5PU9W6qaELuDTBHq9P
         9PLA==
X-Gm-Message-State: AOAM532BeK2hwoi91twEdYaooeShTbZ22M8u8h4eIWZTt1lpkKjfCLFv
        dAkEq+KMJ9iDg3oQXK+angC1Lw==
X-Google-Smtp-Source: ABdhPJzjCFjNfjHPLsn3ZSMjJW96ABmq1kMkNtPhY1mK4eAvoRmBUiK54b1fVpZejSzB186165LJvw==
X-Received: by 2002:a4a:a5c5:: with SMTP id k5mr10562610oom.66.1643647309810;
        Mon, 31 Jan 2022 08:41:49 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 71sm9562848otn.43.2022.01.31.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:41:49 -0800 (PST)
Date:   Mon, 31 Jan 2022 10:41:47 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kgodara@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        quic_rjendra@quicinc.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sc7280: Add herobrine-r1
Message-ID: <YfgRS/UtRn6Ewwhj@builder.lan>
References: <20220125224422.544381-1-dianders@chromium.org>
 <20220125144316.v2.5.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
 <CAE-0n528Bxdj+DKhi2Lan4qR_=4KHD7A1Zkr15tmu+MchryJ1A@mail.gmail.com>
 <CAD=FV=UcpKaLQ31CGKUnaNnZcYnM4N_t8VC43FPGktoYDiMfsw@mail.gmail.com>
 <YfC5i2jR5N+pmHoZ@ripper>
 <CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27 Jan 15:16 CST 2022, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2022-01-25 19:01:31)
> > On Tue 25 Jan 15:46 PST 2022, Doug Anderson wrote:
> >
> > > Hi,
> > >
> > > On Tue, Jan 25, 2022 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Douglas Anderson (2022-01-25 14:44:22)
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > > new file mode 100644
> > > > > index 000000000000..f95273052da0
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > > @@ -0,0 +1,313 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > +/*
> > > > > + * Google Herobrine board device tree source
> > > > > + *
> > > > > + * Copyright 2022 Google LLC.
> > > > > + */
> > > > > +
> > > > > +/dts-v1/;
> > > > > +
> > > > > +#include "sc7280-herobrine.dtsi"
> > > > > +
> > > > > +/ {
> > > > > +       model = "Google Herobrine (rev1+)";
> > > > > +       compatible = "google,herobrine", "qcom,sc7280";
> > > >
> > > > Can we stop adding "qcom,sc7280" to the board compatible string? It
> > > > looks out of place. It's the compatible for the SoC and should really be
> > > > the compatible for the /soc node.
> > >
> > > I don't have any objections, but I feel like this is the type of thing
> > > I'd like Bjorn to have the final say on. What say you, Bjorn?
> > >
> >
> > One practical case I can think of right away, where this matters is in
> > cpufreq-dt-plat.c where we blocklist qcom,sc7280.
> >
> > I don't know if we rely on this in any other places, but I'm not keen on
> > seeing a bunch of board-specific compatibles sprinkled throughout the
> > implementation - it's annoying enough having to add each platform to
> > these drivers.
> 
> Looking at sc7180, grep only shows cpufreq-dt-plat.c
> 

Good, then we handle all other platform specifics in drivers using
platform-specific compatibles.

>  $ git grep qcom,sc7180\" -- drivers
>  drivers/cpufreq/cpufreq-dt-platdev.c:   { .compatible = "qcom,sc7180", },
> 
> Simplest solution would be to look at / and /soc for a compatible
> string.
> 

You mean that / would contain the device's compatible and /soc the soc's
compatible? I'm afraid I don't see how this would help you - you still
need the compatible in the dts, just now in two places.


Either we leave it as is - which follows my interpretation of what the DT
spec says - or we (and the DT maitainers) agree that it shouldn't be
there (because this dtb won't run on any random qcom,sc7180 anyways) at
all.

Regards,
Bjorn

>  $ git grep -W 'soc[^:]*{' -- arch/arm*/boot/dts/ | grep compatible |
> grep -v "simple-bus"
> 
> doesn't show many hits. The first hit is "ti,omap-infra" which is
> actually inside an soc node, but even then I don't see anything that
> matches the cpufreq-dt-plat.c lists.
> 
> ----8<-----
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> b/drivers/cpufreq/cpufreq-dt-platdev.c
> index ca1d103ec449..32bfe453f8b4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -179,25 +179,29 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
>  static int __init cpufreq_dt_platdev_init(void)
>  {
>  	struct device_node *np = of_find_node_by_path("/");
> +	struct device_node *soc_np = of_find_node_by_path("/soc");
>  	const struct of_device_id *match;
>  	const void *data = NULL;
> 
> -	if (!np)
> +	if (!np && !soc_np)
>  		return -ENODEV;
> 
>  	match = of_match_node(allowlist, np);
> -	if (match) {
> +	if (match || (match = of_match_node(allowlist, soc_np))) {
>  		data = match->data;
>  		goto create_pdev;
>  	}
> 
> -	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np))
> +	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np) &&
> +	    !of_match_node(blocklist, soc_np))
>  		goto create_pdev;
> 
> +	of_node_put(soc_np);
>  	of_node_put(np);
>  	return -ENODEV;
> 
>  create_pdev:
> +	of_node_put(soc_np);
>  	of_node_put(np);
>  	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq-dt",
>  			       -1, data,

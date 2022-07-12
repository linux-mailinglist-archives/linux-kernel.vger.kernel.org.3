Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831DE5719F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiGLM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiGLMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:25:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C2B0249
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:25:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso1180204pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7Kkdpw0CXoEWIErTCFA3Qrrlf9LnDXlc1tDM9FQEkM=;
        b=KuK+XxEAiZqgqYpARe+Ajp5+Xdwyu7FklH95kCtVjkvgG+1uPVQMUhmdejypzwsmBf
         Mo2dlK8V3ZWr/GxLdSczjCIlGFxuf+SqP2UzOA52DGrUp6dLD+xeFAsYTL7PgJ9kPAcC
         mtW+6fqF7M412Pj8YOHBXLLFEqiOasGTHcx72eZTsMfr0dyK5VfHFh4gXRbcW1fCUoIE
         ttT5O3cTky3v+47P0Y/IlYrTawdf8t75/PedOHBBnreEgIdlJw5oqHKarJN4588BL/XE
         cXPVJCIqGBTASqn3khqMiRBtsFwDl2IZaS8yUbgvRmdVE4+r+UWADTpcbBUaaXatoyu0
         Ih+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7Kkdpw0CXoEWIErTCFA3Qrrlf9LnDXlc1tDM9FQEkM=;
        b=Ky+xK7qWWjmXxi/fHqV6jAfnCSlCz/JCQClJUNzuwF1mFdyW/eOFxA+d9bse8NpFNu
         1JZbh2bX8cikUw44kgO8JHDqU4jK5QYmIUR+7pMZu937F2lOWyGdeHone4Xsserzt0eJ
         Ajsiq456N9AjjCx2aCrsaujnGbKwd0bNJ6OEAGErHLXRHVZ85sMzZ+lAejnm4rXbRSbZ
         RD1XHHkDwDd0YgpofIQgCQ/FwVFZBxt4xZ+FiAFJvbIvxlRQrr/qOQWP4xSIiYD+KR7p
         L0ROW3REBcsxcUxd0QZ877vH15zvT5XnOAL0ZRTZsTTRc321iXmQIpHHQ4iIMBTXGylz
         T11w==
X-Gm-Message-State: AJIora/y7p8r9z8VDWnbmiCeFgbPHhFcD52SlH9W87dRgTVscgTE8iiv
        DT609esvCXyMwYPC3XHQP8dX
X-Google-Smtp-Source: AGRyM1uKDhZojzscbBh0F9qg+DTu0azBDT/jsX0vJ6G1yxcsnu7T8U/Es7XsMpSg8z41cXpj/4V+GQ==
X-Received: by 2002:a17:902:be16:b0:16c:151d:3e21 with SMTP id r22-20020a170902be1600b0016c151d3e21mr24149386pls.49.1657628751649;
        Tue, 12 Jul 2022 05:25:51 -0700 (PDT)
Received: from workstation ([117.207.31.14])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902860c00b0016191b843e2sm6698327plo.235.2022.07.12.05.25.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jul 2022 05:25:51 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:55:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Message-ID: <20220712122541.GA21746@workstation>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <YsxSkswzsqgMOc0l@hovoldconsulting.com>
 <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:22:40PM +0530, Viresh Kumar wrote:
> On 11-07-22, 18:40, Johan Hovold wrote:
> > This break OPP parsing on SC8280XP and hence cpufreq and other things:
> > 
> > [  +0.010890] cpu cpu0: _opp_add_static_v2: opp key field not found
> > [  +0.000019] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -19
> > [  +0.000060] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 403200000, volt: 576000, enabled: 1
> > [  +0.000030] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 499200000, volt: 576000, enabled: 1
> > ...
> > 
> > I just did a rebase on next-20220708 and hit this.
> > 
> > I've narrowed it down to _read_rate() now returning -ENODEV since
> > opp_table->clk_count is zero.
> > 
> > Similar to what was reported for tegra for v1:
> > 
> > 	https://lore.kernel.org/all/58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com/
> > 
> > I don't have time to look at this any more today, but it would we nice
> > if you could unbreak linux-next.
> > 
> > Perhaps Bjorn or Mani can help with further details, but this doesn't
> > look like something that is specific to SC8280XP.
> 
> It is actually. This is yet another corner case, Tegra had one as
> well.
> 
> I have tried to understand the Qcom code / setup to best of my
> abilities, and the problem as per me is that qcom-cpufreq-hw doesn't
> provide a clk to the OPP core, which breaks it after the new updates
> to the OPP core. I believe following will solve it. Can someone please
> try this ? I will then merge it with the right commit.
> 

I gave it a shot on Lenovo X13s based on SC8280 SoC and it fixes the OPP
issue. So you can add,

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 666e1ebf91d1..4f4a285886fa 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1384,6 +1384,20 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>         }
> 
>         if (ret == -ENOENT) {
> +               /*
> +                * There are few platforms which don't want the OPP core to
> +                * manage device's clock settings. In such cases neither the
> +                * platform provides the clks explicitly to us, nor the DT
> +                * contains a valid clk entry. The OPP nodes in DT may still
> +                * contain "opp-hz" property though, which we need to parse and
> +                * allow the platform to find an OPP based on freq later on.
> +                *
> +                * This is a simple solution to take care of such corner cases,
> +                * i.e. make the clk_count 1, which lets us allocate space for
> +                * frequency in opp->rates and also parse the entries in DT.
> +                */
> +               opp_table->clk_count = 1;
> +
>                 dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
>                 return opp_table;
>         }
> 
> -- 
> viresh

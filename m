Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F108571EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiGLPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiGLPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:16:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C696658E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:10:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b9so7705124pfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=24GiY7xs/AOkZ2wDT+jq5qIaUGqPEUFDT83Dcdn41lc=;
        b=AVewZ9GTLN8QUPIMpsumydhLhsrz+NGv835wkw3mm+S/6lHY4UmkHBvsMDSe0JlYj3
         V1qjJgp280HVU6oPgPg0f0PUXQMNu4txo1kInSWDAtObw+rBlpfVRNPeiPN79aKkZrax
         Fx8UIRGYezZYo8zxZOijVmX0NErwSDre/B7SlXbg76P31Yc+hxqrBnBdDhFY7jxzMyCE
         qQ1P71xu2qxxhJyXlP7PXAmpPIqnLLl2vdk9IgL0D11dpPudP8+CnO5EE20062ZSrseK
         Tb2gpymS1ha8RIG7wIkxZ/0/eRXiBPnHKISuAtL5KqxH1MfyOYOyUGsqqfof3Tv0Sy21
         +uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=24GiY7xs/AOkZ2wDT+jq5qIaUGqPEUFDT83Dcdn41lc=;
        b=yRLh/BvYODQoWzwJAM9WoiX0WoS3cZ5/J855SbB5np63VZG/XdE6qxSUCGh6LE3Hkk
         lg78t5/8h/Fa1l+EoUEyZCCozFO8bsWb5w2tXcwo1thO4Hn9EFE8349Z1ca89JxL670J
         I6+2atNF0WiE5+OK+DhMv0l7ePTgf48ywwQQ4uutsbNiSwfczQBwBBTQhiV206/oGMhA
         9gg7qrASLjp9sO8EvgpYkCHABsxmm5sxLVtjiQm0QDYtLmf9jv82Ux1K8z33Ev1y7M3n
         NXceT0jO7qrwBnJYdMw5JZt1VjCxO23QfJqOohxGCOACyinn1WBr9JWK9bCcjLxnYn21
         NcfA==
X-Gm-Message-State: AJIora83OUUFKYsqfRiMf7ZaASrhK4Zor8jWJsBNpb+QLKFQLJW2as9O
        nB1gu60WWw/eogJuixIoCJHXPQ==
X-Google-Smtp-Source: AGRyM1sTKabYGY8Tal+borECoY05ZOEAoZzgGr3flmGIjIegLuXUBFSTZFgOV0nRcYVZ5Ko1W5RjIw==
X-Received: by 2002:a63:b50b:0:b0:412:b42c:6940 with SMTP id y11-20020a63b50b000000b00412b42c6940mr20638775pge.460.1657638648500;
        Tue, 12 Jul 2022 08:10:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id o65-20020a625a44000000b0052ac99c2c1csm4888270pfb.83.2022.07.12.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:10:47 -0700 (PDT)
Date:   Tue, 12 Jul 2022 20:40:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <20220712151045.vn4tpat4c4cplndo@vireshk-i7>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <YsxSkswzsqgMOc0l@hovoldconsulting.com>
 <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
 <Ys2FZa6YDwt7d/Zc@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2FZa6YDwt7d/Zc@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 16:29, Johan Hovold wrote:
> On Tue, Jul 12, 2022 at 01:22:40PM +0530, Viresh Kumar wrote:
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 666e1ebf91d1..4f4a285886fa 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1384,6 +1384,20 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
> >         }
> > 
> >         if (ret == -ENOENT) {
> > +               /*
> > +                * There are few platforms which don't want the OPP core to
> > +                * manage device's clock settings. In such cases neither the
> > +                * platform provides the clks explicitly to us, nor the DT
> > +                * contains a valid clk entry. The OPP nodes in DT may still
> > +                * contain "opp-hz" property though, which we need to parse and
> > +                * allow the platform to find an OPP based on freq later on.
> > +                *
> > +                * This is a simple solution to take care of such corner cases,
> > +                * i.e. make the clk_count 1, which lets us allocate space for
> > +                * frequency in opp->rates and also parse the entries in DT.
> > +                */
> > +               opp_table->clk_count = 1;
> > +
> >                 dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
> >                 return opp_table;
> >         }
> 
> This looks like a hack.

Yeah, a bit. Initially I wanted to solve it in a cleaner way, like it
is done for Tegra, where you will pass the right clock name to the OPP
core, so it can verify that the clk is there and parse the table. And
then tell the OPP core not to configure the clk from
dev_pm_opp_set_opp(), which is possible now. This would have done the
things in the right way.

The problem with Qcom's DT is that the CPU node have the OPP table but
doesn't contain the clocks, which are available with the
qcom,cpufreq-hw node instead. Because of this, I couldn't pass the
real clocks name to the OPP core, "xo", for the CPU device.

I really tried to avoid adding the above code for Tegra and found a
better and cleaner way out. But I couldn't do the same here and
figured it may be more generic of a problem, which is fine as well.

The OPP core does two things currently:

1) Parse the DT and provide helpers to find the right OPP, etc.

2) Provide generic helper to configure all resources related to the
   OPP.

It is fine if some platforms only want to have the first and not the
second. To have the second though, you need to have the first as well.

The clk is required only for the second case, and the OPP core should
parse the DT anyways, irrespective of the availability of the clock.
Because of this reason, making the above change looked reasonable
(this is what was happening before my new patches came in anyway). The
clock isn't there, but there is "opp-hz" present in the DT, which
needs to be parsed.

> And it also triggers a bunch of new warning when
> opp is trying to create debugfs entries for an entirely different table
> which now gets clk_count set to 1:
> 
> [  +0.000979]  cx: _update_opp_table_clk: Couldn't find clock: -2
> [  +0.000022] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000004] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000004] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
> [  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
> 
> This is for the rpmhpd whose opp table does not have either opp-hz or
> clocks (just opp-level).

Ahh, I missed switching back to the earlier code here. i.e. not use
the frequency for OPP directory's name, when it is 0.

This will fix it.

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 402c507edac7..96a30a032c5f 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -138,7 +138,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
         * - For some devices rate isn't available or there are multiple, use
         *   index instead for them.
         */
-       if (likely(opp_table->clk_count == 1))
+       if (likely(opp_table->clk_count == 1 && opp->rates[0]))
                id = opp->rates[0];
        else
                id = _get_opp_count(opp_table);

I have merged this into:

commit 341df9889277 ("OPP: Allow multiple clocks for a device")

and pushed out for linux-next.


Bjorn, Mani,

It would be really good if we can find a way to make following work on
Qcom:

        clk_get(cpu_dev, NULL or "xo")

If that happens, we can handle the special case just at the consumer
driver (qcom-cpufreq-hw) and not in the core.

-- 
viresh

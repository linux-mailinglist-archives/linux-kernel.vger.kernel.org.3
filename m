Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37677538AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiEaEiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243863AbiEaEiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:38:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885A633B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:38:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so1306942pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VkpYRAJ/gqW49paTS4w2txVNaxPjLbcfc90XJicK11w=;
        b=EsSXqSMWaavhIrx8cnuacQZNzt0hSQNULiVPQaZaP5IPJt9Er+LBshF8bi6yO1bXIx
         v3CwPgxDT1WS3hlwPIqabxQ20jR/Usp7IQpM0c7KTUS7TxmU6pJeZRn06ygEOzeexAI5
         J/1plNiX4RFkyoPVbVMHScDP0DNyf91L4x65fgBOlODLG96W9alHBtZwDsDz2WzbMUH8
         fxTT6o435FmDvd9L3OvcDl/sibkXkEl91jEOllXI++BCBDcHUIqhipXjybj7jKKlDAzL
         P7/snh60BgOqoEhO29/xLmNmotHq29gwqkUZPPk2e2rEKqZqWeSOSDkF+dZZjD4+qj6s
         Wwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VkpYRAJ/gqW49paTS4w2txVNaxPjLbcfc90XJicK11w=;
        b=SE1RkynBXJMkJM5KVz06YhdCleuur6Kp1sjbiIyeFdqDYFVNAakauLpEnqpyFemXJ5
         l7QRLjLgq//oOSSGquzDwziX7O8wHT8ZKn1lmd3OKyts+ulSZRxyIYn72CF50Vf1Oxl0
         iFz90/msZCfbjWCkLW1g3I2O76pW1+aWYLl+pMn/6pqB2r22XhyACJRo7fIqBng6yppo
         U6ajb+PKe75WCe1ubVcyP4GAwPAp5UJVkEVzrlCbJRbwRlcGRr7RNUWsFmAvbdxtr6J1
         oRsRwp/N54G3W3owvk9hRHYuMling5U6cYieewoZhgP9DVjsp5vOE/su/jYEzTVo0Zl1
         y0lQ==
X-Gm-Message-State: AOAM532wRKEaKEAkFDWrtwBw4c5PeE6y3QYeikwjS9knatGBhN6pINmI
        gCe4nGbacxJFLUV0aUo8i16m6w==
X-Google-Smtp-Source: ABdhPJxw5iqeIxTuGzPM8M4vMYs13mh+v3AxbVH104yM/SKez7nK+g3nhbj8GPjiGXZArl1uPpa3uA==
X-Received: by 2002:a17:90a:ae14:b0:1e0:51fa:5182 with SMTP id t20-20020a17090aae1400b001e051fa5182mr26502725pjq.60.1653971891294;
        Mon, 30 May 2022 21:38:11 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e20-20020a635014000000b003f70a4445bfsm9321014pgb.28.2022.05.30.21.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 21:38:10 -0700 (PDT)
Date:   Tue, 31 May 2022 10:08:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/31] devfreq: exynos: Migrate to dev_pm_opp_set_config()
Message-ID: <20220531043809.xfpzz6c7x6utyjb3@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <CGME20220526114410epcas1p27ad1ed594737423fb967f92529a1abd5@epcas1p2.samsung.com>
 <052c4937ce408a01de5cd7d7e359d333f9b11e57.1653564321.git.viresh.kumar@linaro.org>
 <9d492494-4a0a-f690-6a80-2bba5d8633b9@samsung.com>
 <d9a96812-fd4e-cf46-cbe5-63f0e1d373a1@samsung.com>
 <20220531041505.egfe2kpi3bgb6l55@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531041505.egfe2kpi3bgb6l55@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-22, 09:45, Viresh Kumar wrote:
> On 31-05-22, 13:12, Chanwoo Choi wrote:
> > I try to find the cause of this warning.
> > I think that dev_pm_opp_clear_config needs to check
> > whether 'opp_table' is NULL or not as following:
> > 
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index fba6e2b20b8f..cbf8f10b9ff0 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -2598,6 +2598,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
> >   */
> >  void dev_pm_opp_clear_config(struct opp_table *opp_table)
> >  {
> > +       if (unlikely(!opp_table))
> > +               return;
> > +
> >         if (opp_table->genpd_virt_devs)
> >                 dev_pm_opp_detach_genpd(opp_table);
> 
> Does this fixes it for you ?
> 
> It isn't allowed to call this routine with opp_table as NULL, I should
> rather have a WARN() for the same instead.
> 
> Can you check why exynos is passing NULL here as I don't see an
> obvious reason currently.

Looking at the exynos devfreq driver again, it feels like the design
of the driver itself is causing all these issues.

Ideally, whatever resources are acquired by probe() must be freed only
and only by remove()/shutdown(). But you are trying to do it from
exynos_bus_exit() as well. Calling dev_pm_opp_of_remove_table() as
well from this function is wrong as you may very well end up
corrupting the OPP refcount and OPP may never get freed or something
else may come up.

For now I am adding following to the patch, please see if it fixes it
or not (I have pushed the changes to my branch as well).

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 780e525eb92a..8fca24565e7d 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -161,8 +161,11 @@ static void exynos_bus_exit(struct device *dev)

        dev_pm_opp_of_remove_table(dev);
        clk_disable_unprepare(bus->clk);
-       dev_pm_opp_clear_config(bus->opp_table);
-       bus->opp_table = NULL;
+
+       if (bus->opp_table) {
+               dev_pm_opp_clear_config(bus->opp_table);
+               bus->opp_table = NULL;
+       }
 }

 static void exynos_bus_passive_exit(struct device *dev)
@@ -463,8 +466,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
        dev_pm_opp_of_remove_table(dev);
        clk_disable_unprepare(bus->clk);
 err_reg:
-       dev_pm_opp_clear_config(bus->opp_table);
-       bus->opp_table = NULL;
+       if (bus->opp_table) {
+               dev_pm_opp_clear_config(bus->opp_table);
+               bus->opp_table = NULL;
+       }

        return ret;
 }

-- 
viresh

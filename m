Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB514B95E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiBQC3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:29:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiBQC3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:29:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D661829E966
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:29:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 10so3503939plj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUsrl8epLlmjlG8q6yYYqardM1YS21a8liGhoAKKr30=;
        b=Aeot2pk2uSzp6e8cOf9yD6zX/HkQ77vHr1AqJ8mm2uQ7XCesxIGnZmg7F43qZ5gcL/
         gCzvwKABHXksPQqZZHLwOopW4Qxmgk28F4zSfxXoOBTyU9n8obbX1LOXwJHucquU9kTf
         CGaPP/svmLVbMFuxGlt58cS3CxQ8T9jdNk0ZjcOud8VFZVgdnP1ZAf8/QcsakSNAafcF
         9OFkovsgDYqRhCcqM3C/c9UlywC0/zzI6g+xvjhYP+WV/s6JhTX677YZUGtjUBwLR1pi
         vrcmFmsZq1LFOLuHjgn1PnjdcT1xUFCfQaYztq98/2R1kI0orpkhu9/8/lRfeI+j+jqT
         CeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUsrl8epLlmjlG8q6yYYqardM1YS21a8liGhoAKKr30=;
        b=cUKvEJfnm1q/zp5nO+RLkQmmpa3GUON4CWcM/yCpGyhDTdRFaihKOAPhdUSABgqhmh
         eOClNyXpvD/M4biashSF821E2BFtTF48+/mNrYehVMosdBT6TaaL9RVZMxGwqvM7/P5d
         jNS0SmBhPkqxDIF1X20QDr8cm/o88QZ5nxFwupy/hvSoJsTZwqxGhb+/xxtq+iE9Jrx1
         wqwn9yI3m+a/J7bizxa6C7EVo2c+JYr9yI/Wdf+KTmjBOdZuIc4RlZXDF6QEwvhpI+BG
         QutieXQCWpqPmGCowyPFTcrBsBQFJRP+ietAGCn7yC0MQwicGmBSdWdITR8oyeAl0sQQ
         Qg0A==
X-Gm-Message-State: AOAM530ZFcEmVhqN0NOZRASWwNKgf4/huBVN4spVy6IvfqNrfymD4Egx
        E9D8cqpeIDMQfO63s+eOGf373Q==
X-Google-Smtp-Source: ABdhPJx8l/LrL92FGypZrTLkXD1CE66Bv9TCVg8SGHG3SKuA42gK/ttd/Y/tzphB/eZCELksQmICmg==
X-Received: by 2002:a17:902:b78b:b0:14f:69f:d6e1 with SMTP id e11-20020a170902b78b00b0014f069fd6e1mr851133pls.85.1645064941356;
        Wed, 16 Feb 2022 18:29:01 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id v187sm16289066pfv.101.2022.02.16.18.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Feb 2022 18:29:00 -0800 (PST)
Date:   Thu, 17 Feb 2022 10:28:53 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cpuidle: psci: Call cpu_cluster_pm_enter() on the
 last CPU
Message-ID: <20220217022851.GB31965@dragon>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-2-shawn.guo@linaro.org>
 <b690d382d989bd99eaf870e79f63cfb9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b690d382d989bd99eaf870e79f63cfb9@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:39:26PM +0000, Marc Zyngier wrote:
> On 2022-02-16 13:28, Shawn Guo wrote:
> > Make a call to cpu_cluster_pm_enter() on the last CPU going to low power
> > state (and cpu_cluster_pm_exit() on the firt CPU coming back), so that
> > platforms can be notified to set up hardware for getting into the
> > cluster
> > low power state.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-psci.c
> > b/drivers/cpuidle/cpuidle-psci.c
> > index b51b5df08450..c748c1a7d7b1 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -37,6 +37,7 @@ struct psci_cpuidle_data {
> >  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data,
> > psci_cpuidle_data);
> >  static DEFINE_PER_CPU(u32, domain_state);
> >  static bool psci_cpuidle_use_cpuhp;
> > +static atomic_t cpus_in_idle;
> > 
> >  void psci_set_domain_state(u32 state)
> >  {
> > @@ -67,6 +68,14 @@ static int __psci_enter_domain_idle_state(struct
> > cpuidle_device *dev,
> >  	if (ret)
> >  		return -1;
> > 
> > +	if (atomic_inc_return(&cpus_in_idle) == num_online_cpus()) {
> > +		ret = cpu_cluster_pm_enter();
> > +		if (ret) {
> > +			ret = -1;
> > +			goto dec_atomic;
> > +		}
> > +	}
> > +
> >  	/* Do runtime PM to manage a hierarchical CPU toplogy. */
> >  	rcu_irq_enter_irqson();
> >  	if (s2idle)
> > @@ -88,6 +97,10 @@ static int __psci_enter_domain_idle_state(struct
> > cpuidle_device *dev,
> >  		pm_runtime_get_sync(pd_dev);
> >  	rcu_irq_exit_irqson();
> > 
> > +	if (atomic_read(&cpus_in_idle) == num_online_cpus())
> > +		cpu_cluster_pm_exit();
> > +dec_atomic:
> > +	atomic_dec(&cpus_in_idle);
> >  	cpu_pm_exit();
> > 
> >  	/* Clear the domain state to start fresh when back from idle. */
> 
> Is it just me, or does anyone else find it a bit odd that a cpuidle driver
> calls back into the core cpuidle code to generate new events?

It's not uncommon that a platform driver calls some helper functions
provided by core.

> Also, why is this PSCI specific? I would assume that the core cpuidle code
> should be responsible for these transitions, not a random cpuidle driver.

The CPU PM helpers cpu_pm_enter() and cpu_cluster_pm_enter() are provided
by kernel/cpu_pm.c rather than cpuidle core.  This PSCI cpuidle driver
already uses cpu_pm_enter(), and my patch is making a call to
cpu_cluster_pm_enter().

Shawn

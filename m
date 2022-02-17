Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4584BA0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiBQNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:14:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiBQNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:14:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B92AE709
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:14:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso7070548pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdlLlJhbQL/yqDobMDic8Dhn/I5hCPeUob53KHF16Xk=;
        b=iNfqKq5Vxb8wbnaxWGaMqh0FL8SDsPrenCAQIRZFrNIhQgqO7fJd4oIED5SBuhNT4Z
         9dH1d/yANOaEj2VFyMvW7yc67AvmK1KaGey4bQaBOfdABU2J7i3s9CCNmQ60p/Hw6EAQ
         40LySQYRZhvMBvWfdbeIz0DPmbMgH1flwovP7lOvs7a3CW/YGx0FuzdIqxvbhDTue6DJ
         05+BzE0dWFyRgrRlAflUbq1EUiqzz04owQoNT3rKcOeJN7A8yga7IdbJNxNkyNleAt5d
         AbExYnvudxCvxL6NKR12/3lT8OkgW8RUwDDra0zVqb96jm5iUOJrAHRKLXzC+CIu2dTw
         b2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdlLlJhbQL/yqDobMDic8Dhn/I5hCPeUob53KHF16Xk=;
        b=djyShzkAp/fXRpMxWPT3W5ZB8p/BzEFEa3cj6GfSwdJ+QE4dgqRg3HKFE3TxgpYoYV
         mXgGf6dHQ1p8yxLjHNspASw8WVlevlMiBZyTaovCEBmnMW9sH7TqTVuXgD5iY35vPrZ9
         UYLpKnZLzlc0CYvaOYbLAGc5W9HiQhJu0Za9sASqkIMStYeLikGktxLnakcP+iqeiSfx
         VSudZnofCZIXh9f33JJNqdHFVCq4MnYV8iPdX7OlRFqIBoE2IEYUo6g7Pc9xDICwSqDZ
         OfHpfyWcv6152zZjQPcfszgSUMk/qThs1s59KKLUSnMOTQjpVecwtspMuByUXIH6beAk
         lHPA==
X-Gm-Message-State: AOAM532hKmskklFnRJ/Xb9jyv3xYyRtj526WD1UykVQU7JRQD/XyY9PG
        qpAClO15IDyvB4kHQOm1HUTfBw==
X-Google-Smtp-Source: ABdhPJw8TYbPnz7C3y/3QVqKwy7odJLtmW3d4Cz6rXdRkbxoSKc0+apSrVv411QxkKXEWWcCTBUuwg==
X-Received: by 2002:a17:90a:7845:b0:1b9:159c:148e with SMTP id y5-20020a17090a784500b001b9159c148emr2978883pjl.136.1645103655886;
        Thu, 17 Feb 2022 05:14:15 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id l21sm48249804pfu.120.2022.02.17.05.14.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Feb 2022 05:14:15 -0800 (PST)
Date:   Thu, 17 Feb 2022 21:14:08 +0800
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
Subject: Re: [PATCH v5 3/3] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20220217131407.GE31965@dragon>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-4-shawn.guo@linaro.org>
 <0847c34b8c482e6f080ce6f44b02220d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0847c34b8c482e6f080ce6f44b02220d@kernel.org>
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

On Wed, Feb 16, 2022 at 03:48:42PM +0000, Marc Zyngier wrote:
...
> > +static irq_hw_number_t get_parent_hwirq(struct qcom_mpm_priv *priv, int
> > pin)
> > +{
> > +	const struct mpm_gic_map *maps = priv->maps;
> > +	int i;
> > +
> > +	for (i = 0; i < priv->map_cnt; i++) {
> > +		if (maps[i].pin == pin)
> > +			return maps[i].hwirq;
> > +	}
> > +
> > +	return MPM_NO_PARENT_IRQ;
> 
> I'd rather you change this helper to return a pointer to the mapping data,
> and NULL on failure. This will avoid inventing magic values which may
> or may not clash with an interrupt number in the future.
> 
> > +}
> > +
> > +static int qcom_mpm_alloc(struct irq_domain *domain, unsigned int virq,
> > +			  unsigned int nr_irqs, void *data)
> > +{
> > +	struct qcom_mpm_priv *priv = domain->host_data;
> > +	struct irq_fwspec *fwspec = data;
> > +	struct irq_fwspec parent_fwspec;
> > +	irq_hw_number_t parent_hwirq;
> 
> Isn't this the pin number? If so, I'd rather you call it that.

We use term 'pin' in the driver as hwirq of MPM, while the parent_hwirq
here means hwirq of GIC.  But it will be dropped anyway as I'm following
your suggestion to check mapping data instead of parent_hwirq.

I will address all other review comments.  Thanks, Marc!

Shawn

> 
> > +	irq_hw_number_t hwirq;
> > +	unsigned int type;
> > +	int  ret;
> > +
> > +	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> > +					    &qcom_mpm_chip, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	parent_hwirq = get_parent_hwirq(priv, hwirq);
> > +	if (parent_hwirq == MPM_NO_PARENT_IRQ)
> > +		return irq_domain_disconnect_hierarchy(domain->parent, virq);
> > +
> > +	if (type & IRQ_TYPE_EDGE_BOTH)
> > +		type = IRQ_TYPE_EDGE_RISING;
> > +
> > +	if (type & IRQ_TYPE_LEVEL_MASK)
> > +		type = IRQ_TYPE_LEVEL_HIGH;
> > +
> > +	parent_fwspec.fwnode = domain->parent->fwnode;
> > +	parent_fwspec.param_count = 3;
> > +	parent_fwspec.param[0] = 0;
> > +	parent_fwspec.param[1] = parent_hwirq;
> > +	parent_fwspec.param[2] = type;
> > +
> > +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> > +					    &parent_fwspec);
> > +}

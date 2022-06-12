Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5820154794F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiFLIxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiFLIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:53:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780649903;
        Sun, 12 Jun 2022 01:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94C3DB80B79;
        Sun, 12 Jun 2022 08:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7721EC34115;
        Sun, 12 Jun 2022 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655023986;
        bh=VtgoVnezwgppbWJB6LoaSNYOo+Jq58Oon9TcheWQ7UU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GfrvgGhhJ4I4SExFdEpr0GPZnqp09E+I4nJM+TE2DUAmr87VzCi/71BXze0kVPzNU
         p4gXfopggT0QOUrD+iFFVPL4tcbIXVwX0lyuo3ZyaKWEsvKVZkjGzD92sD4nYzvBqc
         vNL+izsM0BNglkqLFCl6SaXVliJ8b9pu7njyrhjcxiUeNfGt/93JcFRRB/IozXyMHa
         p/hENEb7g9MEbOKUqSm+SIIMMH/oQXodVx6I/lUBk3s/p57ThJe//JqJk9SeLFO2En
         Y0nlcJ+gwfaLKU9rfeH/4iZt0ZyMQkGFY0CanZdRtOIfgBIW47R+yyCBMGmfHrWLmk
         cTbehz+aE3F0Q==
Date:   Sun, 12 Jun 2022 10:02:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220612100205.2cab2965@jic23-huawei>
In-Reply-To: <20220609180923.e2q7hkeq5jldtdo2@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
        <20220525181532.6805-3-ddrokosov@sberdevices.ru>
        <20220528193335.646dd092@jic23-huawei>
        <20220609180923.e2q7hkeq5jldtdo2@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 18:09:05 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Jonathan,
> 
> Thank you for comments. Please find my replies below.
> 
...

> > > +					i2c->name,
> > > +					indio_dev);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err,
> > > +				     "failed to request irq (%d)\n", err);
> > > +
> > > +	trig = devm_iio_trigger_alloc(dev, "%s-new-data", i2c->name);
> > > +	if (!trig)
> > > +		return dev_err_probe(dev, -ENOMEM,
> > > +				     "cannot allocate newdata trig\n");
> > > +
> > > +	msa311->new_data_trig = trig;
> > > +	msa311->new_data_trig->dev.parent = dev;
> > > +	msa311->new_data_trig->ops = &msa311_new_data_trig_ops;
> > > +	iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> > > +
> > > +	err = devm_iio_trigger_register(dev, msa311->new_data_trig);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err,
> > > +				     "can't register newdata trig (%d)\n", err);
> > > +
> > > +	indio_dev->trig = iio_trigger_get(msa311->new_data_trig);  
> > 
> > Drop this.  Your driver now supports other triggers so leave
> > this decision to userspace (thus avoiding the issue with remove discussed in
> > v1).
> >   
> 
> Okay, but many other drivers have such the same problem. May be it's
> better to stay in the consistent state with them? What do you think?

There are special cases:
- only one trigger supported.
- originally only one trigger was supported, but that got relaxed later
  and we need to maintain the default to avoid ABI changes.
- maybe one or two that slipped through.

We didn't start setting default triggers until fairly recently so lots
of drivers don't set one.  That doesn't mean we shoudn't fix the
issue you identified but in this case it's a policy decision so probably
belongs in userspace anyway.


...
> > > +
> > > +	/* Resume msa311 logic before any interactions with registers */
> > > +	err = pm_runtime_resume_and_get(dev);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err,
> > > +				     "failed to resume runtime pm (%d)\n", err);  
> > 
> > Given you already report an error message on the failure path in resume,
> > having one here as well is probably excessive as any other failure case
> > is very unlikely.
> >   
> 
> This dev_err() message is located here, because
> pm_runtime_resume_and_get() can contain internal errors which are not
> dependent on driver logic. So I try to catch such errors in this place.

It's a trade off, but generally we don't spend too much effort printing
errors for things that aren't reasonably likely to happen. Obviously
we do return the error though so that we know some debugging is needed
if it happens!

> 
> > > +
> > > +	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +
> > > +	err = msa311_chip_init(msa311);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	indio_dev->modes = INDIO_DIRECT_MODE; /* setup buffered mode later */
> > > +	indio_dev->channels = msa311_channels;
> > > +	indio_dev->num_channels = ARRAY_SIZE(msa311_channels);
> > > +	indio_dev->name = i2c->name;
> > > +	indio_dev->info = &msa311_info;
> > > +
> > > +	err = devm_iio_triggered_buffer_setup(dev,
> > > +					      indio_dev,
> > > +					      iio_pollfunc_store_time,
> > > +					      msa311_buffer_thread,
> > > +					      &msa311_buffer_setup_ops);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err,
> > > +				     "cannot setup iio trig buf (%d)\n", err);
> > > +
> > > +	if (i2c->irq > 0) {
> > > +		err = msa311_setup_interrupts(msa311);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	pm_runtime_mark_last_busy(dev);
> > > +	pm_runtime_put_autosuspend(dev);
> > > +
> > > +	err = devm_add_action_or_reset(dev, msa311_powerdown, msa311);  
> > 
> > It's not immediately clear what this devm action corresponds to and hence
> > why it is at this point in the probe.  Needs a comment.  I think it's
> > a way of forcing suspend to have definitely occurred?
> >   
> 
> Above devm action is needed to force driver to go to SUSPEND mode during
> unloading. In other words, the device should be in SUSPEND mode in the two
> cases:
> 1) When driver is loaded, but we do not have any data or configuration
> requests to it (we are solving it using autosuspend feature)
> 2) When driver is unloaded and device is not used (devm action is used
> in this case)
> 
That's fine, but add a comment to explain 2.
As a general rule, devm_ actions clearly match against setup path actions
so when they don't it's useful to provide a little more info.

Jonathan



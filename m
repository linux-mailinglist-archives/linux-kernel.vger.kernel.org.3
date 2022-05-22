Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66553026A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiEVK2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEVK2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:28:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D039838;
        Sun, 22 May 2022 03:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82CCFB80B00;
        Sun, 22 May 2022 10:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A85AC385AA;
        Sun, 22 May 2022 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653215291;
        bh=78L9xq8+jayZIp2ngKH0d9f+WN+dtJ0EX80ikGjIYVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IDtRu+QK7A9Ryg6Ai2i06P8ZcyfR2npgP2nPRrw1Cq3y27U85Q3KnNf9SJPPPRPGm
         QvDb/Vc7KPqjvJi5Bxc+7CccDClcHq+lnS21WsyoH8I3IRfNaxR2vwHibteAFfuXwJ
         EflVofSoRmKoE2d77snCCHsIk+mgTXXfTte8NjgqlC9k2PtbAKX1yy5k0AB8fOAJvv
         ecIXxLLabXgZOWuAca0BRbGuOEK+ktHmrWOiaNtlwXqrrw0sMAu+9KI8Uq4wpCIBT2
         p5sjEqwBxzOh0nJftNtD7NMlX37Dx5DAqZXWoSOYb2+32SSVR/yxxrfpMTkXd8vfjS
         kJheQoEl9e15w==
Date:   Sun, 22 May 2022 11:36:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220522113654.0e3c0023@jic23-huawei>
In-Reply-To: <20220518122515.aby5lbb4xusr6pdt@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
        <20220419154555.24191-3-ddrokosov@sberdevices.ru>
        <20220420115023.00006a25@Huawei.com>
        <20220426172406.s4h6g7nrpytaq263@CAB-WSD-L081021.sigma.sbrf.ru>
        <20220518122515.aby5lbb4xusr6pdt@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 12:25:59 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hi Jonathan,
> 
> I have two items to be discussed about iio_trigger_get().
> Please see my questions below and correct me if I'm wrong.
> 
> On Tue, Apr 26, 2022 at 08:24:10PM +0300, Dmitry Rokosov wrote:
> > > > +							       "%s-new-data",
> > > > +							       indio_dev->name);
> > > > +		if (!msa311->new_data_trig) {
> > > > +			dev_err(&i2c->dev, "cannot allocate new data trig\n");
> > > > +			err = -ENOMEM;
> > > > +			goto err_lock_destroy;
> > > > +		}
> > > > +
> > > > +		msa311->new_data_trig->dev.parent = &i2c->dev;
> > > > +		msa311->new_data_trig->ops = &msa311_new_data_trig_ops;
> > > > +		iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> > > > +		indio_dev->trig = msa311->new_data_trig;  
> > > 
> > > This will create a double free if you were to change the trigger.
> > > 		indio_dev->trig = iio_trigger_get(trig);
> > >   
> > 
> > I didn't take into account other trigger usage.
> > I'll rework this place for the v2.
> >   
> 
> The first one problem is module_get() calling for trigger get()
> semantic.
> I've applied iio_trigger_get() function to acquire module refcnt,
> but I've faced with rmmod busy problem. IIO driver module doesn't want to
> stop and unload due to not having zero module refcnt.

One option is to remove the trigger from sysfs - write an empty string
current_trigger, but you are right this is a bit of a mess.

Probably the best option is just don't assign the trigger automatically at all.

This was what we almost always went with in the past.  If a driver
supports multiple triggers (and if it doesn't why expose the trigger at allm
there is no obligation to do so?)
then it's a policy decision to associate a trigger in the first place
so shouldn't really happen in kernel.

There is a corner case for drivers which can only use a particular trigger,
but that trigger can be more generally used (validate_trigger provided, but
not validate_device).  Another corner case is drivers that didn't expose
a trigger, but later gain support for other triggers then we need to set
the default value.


> Syscall delete_module() tries to stop module first and after calls
> driver exit() function (which executes devm_* handlers inside, including IIO
> trigger unregister). It means we have the chicken or the egg dilemma here.
> Module can't be unloaded until module refcnt is not zero and we can't
> execute IIO trigger unregister (decrease module refcnt) only when module
> refcnt is zero.
> I suppose the possible solution to such a problem is a different semantic
> for internal triggers (inside driver itself) and external drivers (like
> hwtimer trigger). What do you think?

Potentially though it's going to be tricky as a driver doesn't generally
have any way to know they are internal and we need to be careful not to
underflow the reference counts.  We could hid a flag somewhere and
add an iio_trigger_get_same_owner() or something that sets that flag allowing
us to decide not to drop the reference count it if is automatically unassociated.
In the path where you get:
1) iio_trigger_get_same_owner() on probe
2) sysfs write changes to another trigger.
3) sysfs write back to original trigger
it is reasonable to assume the need to clear the trigger
before driver removal is possible, whereas clearing the trigger association
if only step 1 happened is no intuitive.

> 
> The second one issue is located in the different IIO drivers. Some modules
> call iio_trigger_get() before iio_trigger_register(), trig->owner is not
> initialized to the right value (THIS_MODULE) and we don't acquire refcnt
> for proper driver object.

Ah. Good point. I guess we missed that when we were moving over to
automated setting of the module.

> I'm going to send patchset to problem driver set, but I can test only
> buildable status for such modules, are you okay with that?
That should be fine.  I can't immediately think of a case where it would
be a problem as the iio_device_register() should be later and until that happens
nothing can turn on the trigger - so there shouldn't be any other races.

Jonathan

> 


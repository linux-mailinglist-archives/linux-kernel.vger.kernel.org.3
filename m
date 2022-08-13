Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E87B591B5B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiHMPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiHMPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:24:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E115700;
        Sat, 13 Aug 2022 08:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48DAAB80689;
        Sat, 13 Aug 2022 15:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B258C433C1;
        Sat, 13 Aug 2022 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660404241;
        bh=b6AqnPbsc+T59VwdyA+H2w9UZXXLMHRrYjnllS8rbtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LXjzyKktxW6qtiUqZhuABTD6e+W9SgXhFOm7CTkonETMs0ilXL+Sx+lrlfcyK5WBj
         3YZ4d1wNFk2ef5monqna1n32jsoMms/LYSG0krOgxbsuq4IHlPypLJlv+tLgqccw20
         Z/Pjn0GZoLhIU3NlxWjKW4K97Yr+LlaHVgVXiBDDaI8LoNs+ZylGAVgiBXb24CEZXB
         H1VHhcgUei99peiXwDh17qqFprlOrSPtbcisEHWjmx42UfzNa+F50DRjHy/GEcup/7
         AA84TCHZMJ+bBE5ub2s8/+I/4TbGp2xeO56IslnVhoROfS/2zKfOuPu/CFRZa7M/r0
         Cs43rkIwptZHg==
Date:   Sat, 13 Aug 2022 16:34:28 +0100
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
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220813163428.0a181cc3@jic23-huawei>
In-Reply-To: <20220809094754.akfed7hxcdvxoacj@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
        <20220803131132.19630-3-ddrokosov@sberdevices.ru>
        <20220806163204.3262c0e7@jic23-huawei>
        <20220809094754.akfed7hxcdvxoacj@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 9 Aug 2022 09:47:54 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Jonathan,
> 
> On Sat, Aug 06, 2022 at 04:32:04PM +0100, Jonathan Cameron wrote:
> 
> [...]
> 
> > > +/**
> > > + * struct msa311_priv - MSA311 internal private state
> > > + * @regs: Underlying I2C bus adapter used to abstract slave
> > > + *        register accesses
> > > + * @fields: Abstract objects for each registers fields access
> > > + * @dev: Device handler associated with appropriate bus client
> > > + * @lock: Protects msa311 device state between setup and data access routines
> > > + *        (power transitions, samp_freq/scale tune, retrieving axes data, etc)
> > > + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> > > + *                 to notify external consumers a new sample is ready
> > > + * @vdd: Optional external voltage regulator for the device power supply
> > > + */
> > > +struct msa311_priv {
> > > +	struct regmap *regs;
> > > +	struct regmap_field *fields[F_MAX_FIELDS];
> > > +
> > > +	struct device *dev;
> > > +	struct mutex lock; /* state guard */  
> > 
> > Shouldn't need this comment given documentation above that provides
> > more information.  
> 
> Without this comment checkpatch.pl raises a warning about uncommented
> lock definition.
> I agree with you, above comment is redundant, but is it okay to ignore
> such warnings before sending the patch?
> 
> I'm talking about below checkpatch condition:
> =====
> # check for spinlock_t definitions without a comment.
> 		if ($line =~ /^.\s*(struct\s+mutex|spinlock_t)\s+\S+;/ ||
> 		    $line =~ /^.\s*(DEFINE_MUTEX)\s*\(/) {
> 			my $which = $1;
> 			if (!ctx_has_comment($first_line, $linenr)) {
> 				CHK("UNCOMMENTED_DEFINITION",
> 				    "$1 definition without comment\n" . $herecurr);
> 			}
> 		}
> =====

Hmm. I guess checkpatch is more stupid than I thought on this. Definitely
fine to ignore that shortcoming of checkpatch.

> 
> >   
> > > +
> > > +	struct iio_trigger *new_data_trig;
> > > +	struct regulator *vdd;
> > > +};
> > >  
> > 
> >   
> > > +static irqreturn_t msa311_irq_thread(int irq, void *p)
> > > +{
> > > +	struct msa311_priv *msa311 = iio_priv(p);
> > > +	unsigned int new_data_int_enabled;
> > > +	struct device *dev = msa311->dev;
> > > +	int err;
> > > +
> > > +	mutex_lock(&msa311->lock);  
> >   
> > > +
> > > +	/*
> > > +	 * We do not check NEW_DATA int status, because of based on
> > > +	 * specification it's cleared automatically after a fixed time.
> > > +	 * So just check that is enabled by driver logic.  
> > 
> > That is going to be very problematic if we can have this and events coming
> > through the same interrupt pin.  Not harmful for now though given you are
> > only supporting NEW_DATA for now.  Just something to watch out for.
> >   
> 
> Actually, I have run some experiments with NEW_DATA status bits. And
> looks like we can't determince actual status of NEW_DATA virtual
> interrupt when physical IRQ is raised. I will back to this problem when
> begin Motion Events feature implementation.
> 
> [...]
> 
> > > +	err = devm_pm_runtime_enable(dev);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	pm_runtime_get_noresume(dev);
> > > +	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +
> > > +	err = msa311_chip_init(msa311);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	indio_dev->modes = 0; /* setup buffered mode later */  
> > 
> > As per other branch, I led you astray here it seems.
> >   
> 
> Sorry, I've made a mistake. Comment about INDIO_DIRECT_MODE was left
> by Andy here:
> 
> https://lore.kernel.org/linux-iio/CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com/
> 
> [...]

No problem. That's an odd historical corner case.   I liked having
clear values for 'currentmode' (now in iio_opaque) and those matching
the bits set in available modes.  So even if we didn't set it we'd end up
with a reserved bit which would add extra confusion.

The direct mode is currently just used as a placeholder for 'not a buffered mode',
rather than the state variable has never been set.

Jonathan

> 


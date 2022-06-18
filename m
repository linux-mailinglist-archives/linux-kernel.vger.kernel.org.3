Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E703E55050C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiFRNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFRNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:17:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF4DDEAD;
        Sat, 18 Jun 2022 06:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84AD2B808C4;
        Sat, 18 Jun 2022 13:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8485C3411A;
        Sat, 18 Jun 2022 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655558266;
        bh=nmSfIhwdXVYqsSz7pkv5v/OV6Q1kNMZACzI7k2REBNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X9WZ5W+ZW7pwMHbImv9vGPOaNO35V2FJwW4oKyGykyl8Bl5XhD9EmSb1Qb3w24IGD
         2s066vZSBfUpdj9V1Pal35iYmJ2a5w2E6CxxwhtXOfuj7B6inP2AFGwpwrqZwqZmV1
         ddhFfP/ws8ryZA3Y2AHqCfoIK4KBhBDulkWCiM65y/B9BGJ2VW77j4ot/06wjGOt4G
         JndllYTvwkukXxp39k235DibSxYOUYwSOaDRNkTN+oradidKhmGd07CJjli/6kGGT5
         0avyy31vvmneyE3bchsEemIT4bu9pj3M7R+jaBKHT0yYRFKz1yVhZUOs2ezV9vTW14
         TzTQJGkw2V0mQ==
Date:   Sat, 18 Jun 2022 14:27:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rockosov@gmail.com" <rockosov@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: warn about non-registered iio trigger
 getting attempt
Message-ID: <20220618142703.75025659@jic23-huawei>
In-Reply-To: <20220616091308.miwqkdfc77mm72hz@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220607183907.20017-1-ddrokosov@sberdevices.ru>
        <20220616091308.miwqkdfc77mm72hz@CAB-WSD-L081021.sigma.sbrf.ru>
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

On Thu, 16 Jun 2022 09:13:00 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Jonathan,
> 
> I notice the patchset from 
> https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices.ru/
> is not merged to stable yet.
> I think if this WARN() patch is okay for you, maybe it's better to merge
> it together with the previous one. It will notify developers about this
> problem as you suggested before, and the previous patchset resolves the issue
> in the all IIO drivers.
> 
> What do you think about it?

It would be a stretch to take a defensive measure like this into stable,
so I'll just queue this up for the next merge window.  We might have
some exciting intermediate times where anyone actually using the togreg
branch directly will get drivers that will spit out the warning.
That should only be people active on the list though who will find
this quickly enough and understand what is gong on.

I'm fine with this and it's been on list long enough for anyone else to comment.
It'll be in a branch I'm happy to rebase for at few days anyway if there
are any last minute comments or tags.

Applied to the togreg branch of iio.git and pushed out as testing.

Hopefully I'll get a pull request out for the fixes-togreg branch
sometime this weekend.

Thanks for adding this protection btw.

Jonathan


> 
> On Tue, Jun 07, 2022 at 06:39:18PM +0000, Dmitry Rokosov wrote:
> > As a part of patch series about wrong trigger register() and get()
> > calls order in the some IIO drivers trigger initialization path:
> > 
> > https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices.ru/
> > 
> > runtime WARN_ONCE() is added to alarm IIO driver authors who make such
> > a mistake.
> > 
> > When an IIO driver allocates a new IIO trigger, it should register it
> > before calling the get() operation. In other words, each IIO driver
> > must abide by IIO trigger alloc()/register()/get() calls order.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> > Changes:
> > v1 -> v2: totally reworked the patch, used trig->list entry instead of
> >           trig->owner as driver registration indicator.
> >           It works perfectly for both builtin and built as a module
> >           drivers.
> > 
> > v2 -> v3: changed WARN() call to WARN_ONCE() to avoid warn spamming
> >           during deferred probe() as Andy suggested.
> > ---
> >  drivers/iio/industrialio-trigger.c | 2 ++
> >  include/linux/iio/trigger.h        | 5 +++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index f504ed351b3e..d6277e72d515 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -581,6 +581,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
> >  	if (trig->name == NULL)
> >  		goto free_descs;
> >  
> > +	INIT_LIST_HEAD(&trig->list);
> > +
> >  	trig->subirq_chip.name = trig->name;
> >  	trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
> >  	trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
> > diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> > index 4c69b144677b..03b1d6863436 100644
> > --- a/include/linux/iio/trigger.h
> > +++ b/include/linux/iio/trigger.h
> > @@ -93,6 +93,11 @@ static inline void iio_trigger_put(struct iio_trigger *trig)
> >  static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *trig)
> >  {
> >  	get_device(&trig->dev);
> > +
> > +	WARN_ONCE(list_empty(&trig->list),
> > +		  "Getting non-registered iio trigger %s is prohibited\n",
> > +		  trig->name);
> > +
> >  	__module_get(trig->owner);
> >  
> >  	return trig;
> > -- 
> > 2.36.0  
> 


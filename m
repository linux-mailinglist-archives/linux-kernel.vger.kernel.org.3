Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF6481142
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbhL2J0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbhL2J0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:26:15 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8A7C061574;
        Wed, 29 Dec 2021 01:26:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so19393122pjb.5;
        Wed, 29 Dec 2021 01:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+uyGXw2zMR+CQvA02b6eWYiIEZYNRtMbr7nnxVAIWwk=;
        b=bekzznyzgM3MYdfVqXgQtC/qBZNrAflRmpK0KtRurBIiQjioQCJLDoaGUM7GFDI7SV
         6GHX/af/BPwJfOMlzpHigrFajqsHVrBDzR7vq6YbPJFAMFtnAwNVe/vUX8T7k7TOx0K1
         nnlknXi1x2Uw7cqmJC4CHCbR2vaH1gVed9Mp+dH3l5a1Le7jT+vsfqOaAQDKYJS2sUrO
         iDmBNscC1YS2EgCo/AWV1q5waRmyX1FbV5Tt9x7keOArm609AuYI1PwkhEOrD8lEUSoW
         Ilq2tSEmxU3s66MXrpB5R8c3TftdcNRsM9sqKhpfrdPDn5snH1AUBwsWpO5uLzvl2WNL
         SJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+uyGXw2zMR+CQvA02b6eWYiIEZYNRtMbr7nnxVAIWwk=;
        b=fs4DIyre5ogHwDBOYJPtpLRAfQbUANN5IjDw8cD1hbp4/NwziaqQJfMcWer2rK4ZdY
         4+bmB+Dxrg4S6+r8iNmsKr24efcWgGEL3usrjLFFTXMP3DDwSoNaq2rmFx7JPFZNnIMf
         rCiFw1WiElDty0U0PUi14R1Pmk0CeCtf/ij4RY8EUmCUl3/grQHlDuxe1nUgUKxm4P5p
         NUQn5CScguJBD4sQwibMXwxcL7w7b/Td9i+FWf5xy2BzyAxTZV2kXl6nDoNLabetAiFI
         mXrsUhe+JSPJwuRHrWMNhjkaX7JlhG72MHeAVYwr3L6cCUy7CLxWOHb+8ML2d/TWxDyN
         oObw==
X-Gm-Message-State: AOAM5328KEIcjy+L64jDd492eRnJLupCqCJxLGyfnNPz23mWGKBsoXs1
        MUHZ4Zz7yFmkMH0h/ipv3LY=
X-Google-Smtp-Source: ABdhPJzTZN0pOJRIUuycspkwpR7VSKxFJBl10iNPMXUuhapX9rhuVI7AahMk2UhwpwgrBq1s4LXo3A==
X-Received: by 2002:a17:902:9303:b0:149:a17a:5333 with SMTP id bc3-20020a170902930300b00149a17a5333mr210935plb.12.1640769974000;
        Wed, 29 Dec 2021 01:26:14 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id i11sm23263050pfq.206.2021.12.29.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 01:26:12 -0800 (PST)
Date:   Wed, 29 Dec 2021 18:26:06 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     David Jander <david@protonic.nl>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <Ycwprv+uiGXD1Yzs@shinobu>
References: <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992>
 <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992>
 <YcaZEKbzRbX982YW@shinobu>
 <7a717808-2a06-975b-cd91-5362b784d0bf@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2jTihH0GNWct0ev"
Content-Disposition: inline
In-Reply-To: <7a717808-2a06-975b-cd91-5362b784d0bf@lechnology.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2jTihH0GNWct0ev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 09:16:31AM -0600, David Lechner wrote:
> On 12/24/21 10:07 PM, William Breathitt Gray wrote:
> > On Wed, Dec 15, 2021 at 10:08:53AM +0100, David Jander wrote:
> >>
> >> Dear William,
> >>
> >> On Wed, 15 Dec 2021 17:48:26 +0900
> >> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >>
> >>> On Wed, Dec 08, 2021 at 05:10:35PM +0100, David Jander wrote:
> >>>>
> >>>> Dear Uwe,
> >>>>
> >>>> On Wed, 8 Dec 2021 14:59:02 +0100
> >>>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >>>>   =20
> >>>>> Hello David,
> >>>>>
> >>>>> On Tue, Dec 07, 2021 at 08:16:02AM +0100, David Jander wrote:
> >>>>>> On Mon, 6 Dec 2021 13:24:18 -0600
> >>>>>> David Lechner <david@lechnology.com> wrote:
> >>>>>>     =20
> >>>>>>> On 11/24/21 7:58 PM, William Breathitt Gray wrote:
> >>>>>>>> On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote:
> >>>>>>>>> Hi William,
> >>>>>>>>>
> >>>>>>>>> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gra=
y wrote:
> >>>>>>>>>> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:
> >>>>>>>>>>> Add counter_push_event() to notify user space about new pulses
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >>>>>>>>>>> ---
> >>>>>>>>>>>    drivers/counter/interrupt-cnt.c | 2 ++
> >>>>>>>>>>>    1 file changed, 2 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counte=
r/interrupt-cnt.c
> >>>>>>>>>>> index 8514a87fcbee..b237137b552b 100644
> >>>>>>>>>>> --- a/drivers/counter/interrupt-cnt.c
> >>>>>>>>>>> +++ b/drivers/counter/interrupt-cnt.c
> >>>>>>>>>>> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int ir=
q, void *dev_id)
> >>>>>>>>>>>   =20
> >>>>>>>>>>>    	atomic_inc(&priv->count);
> >>>>>>>>>>>   =20
> >>>>>>>>>>> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, =
0);
> >>>>>>>>>>> +
> >>>>>>>>>>>    	return IRQ_HANDLED;
> >>>>>>>>>>>    }
> >>>>>>>>>>>   =20
> >>>>>>>>>>> --=20
> >>>>>>>>>>> 2.30.2
> >>>>>>>>>>
> >>>>>>>>>> Hi Oleksij,
> >>>>>>>>>>
> >>>>>>>>>> It looks like this is pushing a COUNTER_EVENT_OVERFLOW event e=
very time
> >>>>>>>>>> an interrupt is handled, which I suspect is not what you want =
to happen.
> >>>>>>>>>> The COUNTER_EVENT_OVERFLOW event indicates a count value overf=
low event,
> >>>>>>>>>> so you'll need to check for a count value overflow before push=
ing the
> >>>>>>>>>> event.
> >>>>>>>>>>
> >>>>>>>>>> It would be good idea to implement a ceiling extension as well=
 (you can
> >>>>>>>>>> use the COUNTER_COMP_CEILING() macro) so that users can config=
ure the
> >>>>>>>>>> particular point where the value overflows.
> >>>>>>>>>
> >>>>>>>>> Thank you!
> >>>>>>>>>
> >>>>>>>>> What would be the best and resource effective strategy for peri=
odically
> >>>>>>>>> getting frequency of interrupts/pulses? This is actual informat=
ion which is
> >>>>>>>>> needed for my use case.
> >>>>>>>>>
> >>>>>>>>> So far, I was pushing every event to the user space, which is w=
orking
> >>>>>>>>> but probably not the most resource effective method of doing it.
> >>>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>> Oleskij
> >>>>>>>>> --=20
> >>>>>>>>> Pengutronix e.K.                           |                   =
          |
> >>>>>>>>> Steuerwalder Str. 21                       | http://www.pengutr=
onix.de/  |
> >>>>>>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-20=
6917-0    |
> >>>>>>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-20=
6917-5555 |
> >>>>>>>>
> >>>>>>>> We could introduce a new Counter change-of-state event type whic=
h would
> >>>>>>>> trigger whenever the count value changes, but I agree with you t=
hat this
> >>>>>>>> is likely not the best way for us to derive the frequency of the
> >>>>>>>> interrupts due to the indirection of handling and parsing the ev=
ent
> >>>>>>>> data.
> >>>>>>>>
> >>>>>>>> Instead, perhaps introducing a "frequency" or "period" Count ext=
ension
> >>>>>>>> would make more sense here. This extension could report the valu=
e delta
> >>>>>>>> between counts, or alternatively the time delta from which you c=
an
> >>>>>>>> derive frequency. Regarding implementation, you can store the pr=
evious
> >>>>>>>> value in a variable, updating it whenever an interrupt occurs, a=
nd
> >>>>>>>> compute the particular delta every time a read is requested by t=
he user.
> >>>>>>>>
> >>>>>>>> David Lechner is implementing something similar for the TI eQEP =
driver
> >>>>>>>> to expose speed, so I'm CCing them here in case this is of inter=
est to
> >>>>>>>> them.
> >>>>>>>>       =20
> >>>>>>>
> >>>>>>> Based on my experience, I would recommend that counter drivers be=
 as
> >>>>>>> "thin" as possible. They shouldn't try to provide any information=
 that
> >>>>>>> the hardware itself doesn't provide. In other words, the kernel s=
hould
> >>>>>>> provide userspace the information needed to calculate the speed/r=
ate
> >>>>>>> but not try to do the actual calculation in the kernel. Inevitably
> >>>>>>> there are nuances for specific use cases that can't all possibly =
be
> >>>>>>> handled by such an implementation.
> >>>>>>
> >>>>>> I completely agree with this. While interrupts aren't really meant=
 for
> >>>>>> measuring frequency, and this being somewhat of a mis-use of somet=
hing, it is
> >>>>>> still possible to do and very useful in many cases. That said, whi=
le the
> >>>>>> counter framework is AFAIK the best fit for this, the main use-cas=
e for this
> >>>>>> driver is measuring wheel speed (and similar "speeds"). For this, =
the minimum
> >>>>>> amount of information the driver needs to provide user-space with =
to do
> >>>>>> reliable calculations, is high-resolution time-stamps of GPIO even=
ts. A simple
> >>>>>> counter is not suited, because there can be glitches that need to =
be detected.
> >>>>>> If user-space gets a buffer full of consecutive time-stamps (don't=
 need to be
> >>>>>> all of them, just a sample of n consecutive timestamps), as well a=
s total
> >>>>>> count, all needed calculations, glitch filtering, low-pass filteri=
ng, etc...
> >>>>>> can be done in user-space just fine.
> >>>>>>     =20
> >>>>>>> I've tried using gpio interrupts to try to calculate speed/rate in
> >>>>>>> the kernel before and it simply doesn't work reliably. Interrupts
> >>>>>>> get missed and the calculation will be off.
> >>>>>>
> >>>>>> Exactly. Been there, done that.
> >>>>>> For reliable speed calculations of a mechanical system, the proper=
ties of the
> >>>>>> mechanical system need to be known, like physical limits of accele=
rations,
> >>>>>> maximum (or minimum) speed, etc. The minimum set of input data nee=
ded by a
> >>>>>> user-space application to do these calculations is total pulse cou=
nt in
> >>>>>> addition to a buffer of timestamps of n consecutive input events (=
raising or
> >>>>>> falling edges on GPIO). So IMHO this is what the driver should pro=
vide, and
> >>>>>> in the most resource-efficient way possible. This particular drive=
r will be
> >>>>>> used 3 times on the same SoC, with each up to 10-15k pulses per se=
cond. That
> >>>>>> is a lot of interrupts for an embedded system, so they better cons=
ume as
> >>>>>> little resources as possible. Filling a ring buffer with timestamp=
s should be
> >>>>>> possible, as long as no locking is involved. Locks in IRQ context =
must be
> >>>>>> avoided at all costs, specially in this case.
> >>>>>>     =20
> >>>>>>> For really slow counts (i.e. 1 count/second), I can see a use for
> >>>>>>> generating an event on each count though. For high rates, I would
> >>>>>>> just read the count every 100ms in usespace and divide the change=
 in
> >>>>>>> the number of counts by the time period to get the rate.
> >>>>>>
> >>>>>> For slow counts, I agree, but for high rates, I don't (see above).=
 There can
> >>>>>> be glitches and false events that can (and must) be effectively fi=
ltered out.
> >>>>>> For that user-space needs to know the time of each event during the
> >>>>>> measurement period.
> >>>>>
> >>>>> No sure I understood the problem here. If you keep the driver as is=
 and
> >>>>> in userspace just read out the counter value twice and measure the =
time
> >>>>> between the reads[1], you can calculate the average frequency of the
> >>>>> event in userspace.
> >>>>>
> >>>>> Isn't that good enough?
> >>>>
> >>>> No, I'm afraid it isn't, for two reasons:
> >>>>
> >>>> 1. These counters are often used in environments, where glitches can=
 and do
> >>>> happen. So sometimes there are fake events. The only way to tell fak=
e from
> >>>> real pulses, is to filter them. Unfortunately you need the timestamp=
s of each
> >>>> event for that.
> >>>>
> >>>> 2. Another reason for having time-stamps is the case when the freque=
ncy is low
> >>>> and one still requires fast accurate measurements. In that case time=
stamps
> >>>> provide a way of accurately measuring period time.
> >>>>
> >>>> Best regards,
> >>>>
> >>>> --=20
> >>>> David Jander
> >>>> Protonic Holland.
> >>>
> >>> Keeping drivers focused on just exposing the hardware data and
> >>> functionality is likely the best path to choose, so my earlier
> >>> suggestion of a "frequency" extension would better be left for usersp=
ace
> >>> to handle.
> >>
> >> I agree.
> >>
> >>> So in order to enable userspace to derive frequency, you need reliable
> >>> timestamps for enough consecutive events to provide an adequate size
> >>> sample of data on which to perform filtering and other such operation=
s.
> >>
> >> Ack.
> >>
> >>> If we add a COUNTER_EVENT_CHANGE_OF_STATE or similar, every count cha=
nge
> >>> will generate an event with a logged timestamp. Is the problem with t=
his
> >>> solution primarily that the Counter event queue is currently utilizing
> >>> spinlocks for synchronization?
> >>
> >> Yes. Basically, since one can expect a very high amount of IRQs, it se=
ems
> >> paramount to eliminate any source of latency (spinlocks, etc...) from
> >> interrupt context as well as to keep CPU load as low as technically po=
ssible.
> >>
> >> If a spinlock is used, and at 10kHz pulses, on a moderately fast embed=
ded SoC,
> >> it is IMHO quite possible to have user-space cause the spinlock to be =
held for
> >> more than 100 microseconds, thus causing a pulse to be missed. Not to =
mention
> >> slight jitter introduced to the timestamps that can cause user-space t=
o falsely
> >> filter out events (a software PLL that doesn't correctly lock).
> >>
> >> The ideal ISR in this case would only take a timestamp from a hardware=
 TSC (or
> >> similarly latency-free direct source) and put it into a circular buffer
> >> without using locks, and maybe increase an unsigned long counter value=
 (atomic
> >> operation if MB's are correctly used) and nothing else.
> >> If, for example, such a solution would require user-space access CPU
> >> load (complexity) to increase by a factor of 10 or even more (in order=
 to
> >> avoid locks), this is likely still preferable, since the ISR is execut=
ed maybe
> >> 1000+ times more often than user-space accessing the driver.
> >>
> >> Best regards,
> >>
> >> --=20
> >> David Jander
> >> Protonic Holland.
> >=20
> > So the counter_push_event() function interacts with two spinlocks:
> > events_list_lock and events_in_lock. The events_list_lock spinlock is
> > necessary because userspace can modify the events_list list via the
> > counter_enable_events() and counter_disable_events() functions. The
> > events_in_lock spinlock is necessary because userspace can modify the
> > events kfifo via the counter_events_queue_size_write() function.
> >=20
> > A lockless solution for this might be possible if the driver maintains
> > its own circular buffer as you suggest. The driver's IRQ handler can
> > write to this circular buffer without calling the counter_push_event()
> > function, and then flush the buffer to the Counter character device via
> > a userspace write to a "flush_events" sysfs attribute or similar; this
> > eliminates the need for the events_in_lock spinlock. The state of the
> > events_list list can be captured in the driver's events_configure()
> > callback and stored locally in the driver for reference, thus
> > eliminating the need for the events_list_lock; interrupts can be
> > disabled before the driver's local copy of events_list is modified.
> >=20
> > With only one reader and one writer operating on the driver's buffer,
> > you can use the normal kfifo_in and kfifo_out calls for lockless
> > operations. Perhaps that is a way forward for this problem.
> >=20
>=20
> Would it be possible to make it so that userspace can't modify the
> events_list when IRQs are enabled? Then we wouldn't have to add asecond e=
vent buffer.
>=20
> IIRC, the only operations that modify events_list are when another
> list replaces events_list when events are enabled and when
> events_list is cleared when events are disabled. So as long as the
> ordering is right with respect to enabling and disabling IRQs, it
> seems like the spin lock should not be needed.

I think that could work. If IRQs are always disabled before events_list
is modified, then there is never a risk of interacting with an invalid
events_list and thus counter_push_events() won't need spinlocks. When
IRQs are disabled we miss any possible events, but we are missing those
already anyway when the events_list is modified.

William Breathitt Gray

--p2jTihH0GNWct0ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMKaIACgkQhvpINdm7
VJICRhAAmQxOO314MYpRGtRJcms5b8pfnavCYMcGhhXx+oqJFG6dSpOm1tjC5GzE
Nrng5yB/IgDHxFN76teaStOZqjHnQwhNzHXAV+BSfevpNY4XFkSWgHScJmkW2gSj
oY38ts2bVrq0FN3L900Xg2HA6vzeL19wYBoyUqeb/EK2UENdTNtne+gH3plRJB0z
J7Q0Pi2o+y6uctVCo69MOEVgbGVG/lYC3rc9FxFL9uJPM1dlmSCa1bd4j/t6nmtt
EmPptQnLHW8xYzG3PGcyg/F7xAI61dmYraA+rrLIGZRED/hxG6CHOioA3m5Gtjhu
9bV16UfsQ/N0WicrI9SPzyw5FZkAhcRRG3EwbO4GzMK1sHa4FSjoWUQbsxok8PGQ
u5IUrqoBm6AVh2+mTa44OIY8pJg8hwakOZprDUZ18n8LorBz5fXGQpojU32HU0as
zIp1xjYaIqSM76TIiQ4LTsJwGqVQD17HaE3HIN311PPXXTWFqmOMDHhiMUV/Dv24
oIHIJgJ3ZutpWriFCJ740elosz7uu/wcfgBwN90gEeW+dI4QMVoxR8nmJGT3Xq6d
aS4Eo2od6YatMt8kEHpVT+GwjRXeQllSqRRmtZED+i5EijSsIsJNL5GK5JEpVRWH
qbGQJYqntyjeirKzvCp9adJ8dzdg+GQYW4hd/q9y64xnupDV6qc=
=SKsK
-----END PGP SIGNATURE-----

--p2jTihH0GNWct0ev--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B002147F1CE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 05:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhLYEHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 23:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhLYEHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 23:07:52 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F1C061401;
        Fri, 24 Dec 2021 20:07:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v13so9024075pfi.3;
        Fri, 24 Dec 2021 20:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Av9VKIlk5OEdWm6mp9ws0rtRyKrc+WoEMr8EVfI4Tg=;
        b=CjZWSW6GL9utsBrTuSaNeBGhwNIHREPGN0tgQZw8itbni02oOnkcGWfEKx5Z5wVuAv
         ZD/Rr/EhQFnXygOm1KphGjcGQPN+v7DXPBbs5BYOEKtEbvBtQYY+AoaGTFd+lbZymZ5t
         sZwsEuN6Fmci29673DqnVlpbkgao78xyQ8+IKHR+7txcC+5HEv8xMsV9U2yihSOFg02Z
         PwyXsimLgDMrR45pxpp0Qy+I1wiFo70S26aBi8pcMoKAeDUhtzGIsmdlIcxqUrKDBolS
         8jmt8s0PgiJb3JKxMSD1MwHCEqo0TBWAKLpENfnoJxiGv5p6r7Tg9bUPja0vQj4hN3ro
         cn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Av9VKIlk5OEdWm6mp9ws0rtRyKrc+WoEMr8EVfI4Tg=;
        b=C36seABMvF9q3vHYTDTriJKmfN6+qTSpJoS1D8Ga5TA71Af2DZonF/fndGtme5/snj
         LC1OWqZaHC2bvxHxxdnme0T/mlN7nmpgrnODDBcSa+DS3HqvxpUE2NtpoCKe5t6amdgO
         bCs5yOG5UnhK3ongElA+ZAK+55VRuHkzjyfzKGdNRqBzczEic5x6jQwyDclbI2Pa8QsU
         7tsjqXySCf6uPURQLMarZo+fMXEjdHPAgo3xzyEtI0TUtIACZ6eHZCiC8Iej0Q/5AUPz
         AQgm9HeDY8rBANeL7O5mwCaAyqnHogdOLNgNgG81AG2bhSZDAoxY0Ll01ekuiZfW/KQK
         /wKQ==
X-Gm-Message-State: AOAM533MbsPs3+iDsRQzkwA86K/cIS3gMj21MWyiUkgd/JtDtAeED7rx
        DcNHWLJvbT3Z2PQ/cZro1XoC7ZfyluREhx+1
X-Google-Smtp-Source: ABdhPJzo81RbR6u9NATzhOe/wQZ9bo2+HQcEkD6G0TtUWX08dpW25gW+8T3WUWapfKloypNGMVur6g==
X-Received: by 2002:a63:aa0e:: with SMTP id e14mr8292909pgf.68.1640405270932;
        Fri, 24 Dec 2021 20:07:50 -0800 (PST)
Received: from shinobu ([37.120.154.44])
        by smtp.gmail.com with ESMTPSA id v12sm8789849pgc.13.2021.12.24.20.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 20:07:50 -0800 (PST)
Date:   Sat, 25 Dec 2021 13:07:44 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Jander <david@protonic.nl>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <YcaZEKbzRbX982YW@shinobu>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
 <YZ3XAeYyfGblfaOi@shinobu>
 <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992>
 <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4yW8YEuGs8SU/bDK"
Content-Disposition: inline
In-Reply-To: <20211215100853.11f9262d@erd992>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4yW8YEuGs8SU/bDK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 10:08:53AM +0100, David Jander wrote:
>=20
> Dear William,
>=20
> On Wed, 15 Dec 2021 17:48:26 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Wed, Dec 08, 2021 at 05:10:35PM +0100, David Jander wrote:
> > >=20
> > > Dear Uwe,
> > >=20
> > > On Wed, 8 Dec 2021 14:59:02 +0100
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > >  =20
> > > > Hello David,
> > > >=20
> > > > On Tue, Dec 07, 2021 at 08:16:02AM +0100, David Jander wrote: =20
> > > > > On Mon, 6 Dec 2021 13:24:18 -0600
> > > > > David Lechner <david@lechnology.com> wrote:
> > > > >    =20
> > > > > > On 11/24/21 7:58 PM, William Breathitt Gray wrote:   =20
> > > > > > > On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrot=
e:     =20
> > > > > > >> Hi William,
> > > > > > >>
> > > > > > >> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt =
Gray wrote:     =20
> > > > > > >>> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wr=
ote:     =20
> > > > > > >>>> Add counter_push_event() to notify user space about new pu=
lses
> > > > > > >>>>
> > > > > > >>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > > > >>>> ---
> > > > > > >>>>   drivers/counter/interrupt-cnt.c | 2 ++
> > > > > > >>>>   1 file changed, 2 insertions(+)
> > > > > > >>>>
> > > > > > >>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/cou=
nter/interrupt-cnt.c
> > > > > > >>>> index 8514a87fcbee..b237137b552b 100644
> > > > > > >>>> --- a/drivers/counter/interrupt-cnt.c
> > > > > > >>>> +++ b/drivers/counter/interrupt-cnt.c
> > > > > > >>>> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int=
 irq, void *dev_id)
> > > > > > >>>>  =20
> > > > > > >>>>   	atomic_inc(&priv->count);
> > > > > > >>>>  =20
> > > > > > >>>> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLO=
W, 0);
> > > > > > >>>> +
> > > > > > >>>>   	return IRQ_HANDLED;
> > > > > > >>>>   }
> > > > > > >>>>  =20
> > > > > > >>>> --=20
> > > > > > >>>> 2.30.2     =20
> > > > > > >>>
> > > > > > >>> Hi Oleksij,
> > > > > > >>>
> > > > > > >>> It looks like this is pushing a COUNTER_EVENT_OVERFLOW even=
t every time
> > > > > > >>> an interrupt is handled, which I suspect is not what you wa=
nt to happen.
> > > > > > >>> The COUNTER_EVENT_OVERFLOW event indicates a count value ov=
erflow event,
> > > > > > >>> so you'll need to check for a count value overflow before p=
ushing the
> > > > > > >>> event.
> > > > > > >>>
> > > > > > >>> It would be good idea to implement a ceiling extension as w=
ell (you can
> > > > > > >>> use the COUNTER_COMP_CEILING() macro) so that users can con=
figure the
> > > > > > >>> particular point where the value overflows.     =20
> > > > > > >>
> > > > > > >> Thank you!
> > > > > > >>
> > > > > > >> What would be the best and resource effective strategy for p=
eriodically
> > > > > > >> getting frequency of interrupts/pulses? This is actual infor=
mation which is
> > > > > > >> needed for my use case.
> > > > > > >>
> > > > > > >> So far, I was pushing every event to the user space, which i=
s working
> > > > > > >> but probably not the most resource effective method of doing=
 it.
> > > > > > >>
> > > > > > >> Regards,
> > > > > > >> Oleskij
> > > > > > >> --=20
> > > > > > >> Pengutronix e.K.                           |                =
             |
> > > > > > >> Steuerwalder Str. 21                       | http://www.peng=
utronix.de/  |
> > > > > > >> 31137 Hildesheim, Germany                  | Phone: +49-5121=
-206917-0    |
> > > > > > >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121=
-206917-5555 |     =20
> > > > > > >=20
> > > > > > > We could introduce a new Counter change-of-state event type w=
hich would
> > > > > > > trigger whenever the count value changes, but I agree with yo=
u that this
> > > > > > > is likely not the best way for us to derive the frequency of =
the
> > > > > > > interrupts due to the indirection of handling and parsing the=
 event
> > > > > > > data.
> > > > > > >=20
> > > > > > > Instead, perhaps introducing a "frequency" or "period" Count =
extension
> > > > > > > would make more sense here. This extension could report the v=
alue delta
> > > > > > > between counts, or alternatively the time delta from which yo=
u can
> > > > > > > derive frequency. Regarding implementation, you can store the=
 previous
> > > > > > > value in a variable, updating it whenever an interrupt occurs=
, and
> > > > > > > compute the particular delta every time a read is requested b=
y the user.
> > > > > > >=20
> > > > > > > David Lechner is implementing something similar for the TI eQ=
EP driver
> > > > > > > to expose speed, so I'm CCing them here in case this is of in=
terest to
> > > > > > > them.
> > > > > > >      =20
> > > > > >=20
> > > > > > Based on my experience, I would recommend that counter drivers =
be as
> > > > > > "thin" as possible. They shouldn't try to provide any informati=
on that
> > > > > > the hardware itself doesn't provide. In other words, the kernel=
 should
> > > > > > provide userspace the information needed to calculate the speed=
/rate
> > > > > > but not try to do the actual calculation in the kernel. Inevita=
bly
> > > > > > there are nuances for specific use cases that can't all possibl=
y be
> > > > > > handled by such an implementation.   =20
> > > > >=20
> > > > > I completely agree with this. While interrupts aren't really mean=
t for
> > > > > measuring frequency, and this being somewhat of a mis-use of some=
thing, it is
> > > > > still possible to do and very useful in many cases. That said, wh=
ile the
> > > > > counter framework is AFAIK the best fit for this, the main use-ca=
se for this
> > > > > driver is measuring wheel speed (and similar "speeds"). For this,=
 the minimum
> > > > > amount of information the driver needs to provide user-space with=
 to do
> > > > > reliable calculations, is high-resolution time-stamps of GPIO eve=
nts. A simple
> > > > > counter is not suited, because there can be glitches that need to=
 be detected.
> > > > > If user-space gets a buffer full of consecutive time-stamps (don'=
t need to be
> > > > > all of them, just a sample of n consecutive timestamps), as well =
as total
> > > > > count, all needed calculations, glitch filtering, low-pass filter=
ing, etc...
> > > > > can be done in user-space just fine.
> > > > >    =20
> > > > > > I've tried using gpio interrupts to try to calculate speed/rate=
 in
> > > > > > the kernel before and it simply doesn't work reliably. Interrup=
ts
> > > > > > get missed and the calculation will be off.   =20
> > > > >=20
> > > > > Exactly. Been there, done that.
> > > > > For reliable speed calculations of a mechanical system, the prope=
rties of the
> > > > > mechanical system need to be known, like physical limits of accel=
erations,
> > > > > maximum (or minimum) speed, etc. The minimum set of input data ne=
eded by a
> > > > > user-space application to do these calculations is total pulse co=
unt in
> > > > > addition to a buffer of timestamps of n consecutive input events =
(raising or
> > > > > falling edges on GPIO). So IMHO this is what the driver should pr=
ovide, and
> > > > > in the most resource-efficient way possible. This particular driv=
er will be
> > > > > used 3 times on the same SoC, with each up to 10-15k pulses per s=
econd. That
> > > > > is a lot of interrupts for an embedded system, so they better con=
sume as
> > > > > little resources as possible. Filling a ring buffer with timestam=
ps should be
> > > > > possible, as long as no locking is involved. Locks in IRQ context=
 must be
> > > > > avoided at all costs, specially in this case.
> > > > >    =20
> > > > > > For really slow counts (i.e. 1 count/second), I can see a use f=
or
> > > > > > generating an event on each count though. For high rates, I wou=
ld
> > > > > > just read the count every 100ms in usespace and divide the chan=
ge in
> > > > > > the number of counts by the time period to get the rate.   =20
> > > > >=20
> > > > > For slow counts, I agree, but for high rates, I don't (see above)=
=2E There can
> > > > > be glitches and false events that can (and must) be effectively f=
iltered out.
> > > > > For that user-space needs to know the time of each event during t=
he
> > > > > measurement period.   =20
> > > >=20
> > > > No sure I understood the problem here. If you keep the driver as is=
 and
> > > > in userspace just read out the counter value twice and measure the =
time
> > > > between the reads[1], you can calculate the average frequency of the
> > > > event in userspace.
> > > >=20
> > > > Isn't that good enough? =20
> > >=20
> > > No, I'm afraid it isn't, for two reasons:
> > >=20
> > > 1. These counters are often used in environments, where glitches can =
and do
> > > happen. So sometimes there are fake events. The only way to tell fake=
 from
> > > real pulses, is to filter them. Unfortunately you need the timestamps=
 of each
> > > event for that.
> > >=20
> > > 2. Another reason for having time-stamps is the case when the frequen=
cy is low
> > > and one still requires fast accurate measurements. In that case times=
tamps
> > > provide a way of accurately measuring period time.
> > >=20
> > > Best regards,
> > >=20
> > > --=20
> > > David Jander
> > > Protonic Holland. =20
> >=20
> > Keeping drivers focused on just exposing the hardware data and
> > functionality is likely the best path to choose, so my earlier
> > suggestion of a "frequency" extension would better be left for userspace
> > to handle.
>=20
> I agree.
>=20
> > So in order to enable userspace to derive frequency, you need reliable
> > timestamps for enough consecutive events to provide an adequate size
> > sample of data on which to perform filtering and other such operations.
>=20
> Ack.
>=20
> > If we add a COUNTER_EVENT_CHANGE_OF_STATE or similar, every count change
> > will generate an event with a logged timestamp. Is the problem with this
> > solution primarily that the Counter event queue is currently utilizing
> > spinlocks for synchronization?
>=20
> Yes. Basically, since one can expect a very high amount of IRQs, it seems
> paramount to eliminate any source of latency (spinlocks, etc...) from
> interrupt context as well as to keep CPU load as low as technically possi=
ble.
>=20
> If a spinlock is used, and at 10kHz pulses, on a moderately fast embedded=
 SoC,
> it is IMHO quite possible to have user-space cause the spinlock to be hel=
d for
> more than 100 microseconds, thus causing a pulse to be missed. Not to men=
tion
> slight jitter introduced to the timestamps that can cause user-space to f=
alsely
> filter out events (a software PLL that doesn't correctly lock).
>=20
> The ideal ISR in this case would only take a timestamp from a hardware TS=
C (or
> similarly latency-free direct source) and put it into a circular buffer
> without using locks, and maybe increase an unsigned long counter value (a=
tomic
> operation if MB's are correctly used) and nothing else.
> If, for example, such a solution would require user-space access CPU
> load (complexity) to increase by a factor of 10 or even more (in order to
> avoid locks), this is likely still preferable, since the ISR is executed =
maybe
> 1000+ times more often than user-space accessing the driver.
>=20
> Best regards,
>=20
> --=20
> David Jander
> Protonic Holland.

So the counter_push_event() function interacts with two spinlocks:
events_list_lock and events_in_lock. The events_list_lock spinlock is
necessary because userspace can modify the events_list list via the
counter_enable_events() and counter_disable_events() functions. The
events_in_lock spinlock is necessary because userspace can modify the
events kfifo via the counter_events_queue_size_write() function.

A lockless solution for this might be possible if the driver maintains
its own circular buffer as you suggest. The driver's IRQ handler can
write to this circular buffer without calling the counter_push_event()
function, and then flush the buffer to the Counter character device via
a userspace write to a "flush_events" sysfs attribute or similar; this
eliminates the need for the events_in_lock spinlock. The state of the
events_list list can be captured in the driver's events_configure()
callback and stored locally in the driver for reference, thus
eliminating the need for the events_list_lock; interrupts can be
disabled before the driver's local copy of events_list is modified.

With only one reader and one writer operating on the driver's buffer,
you can use the normal kfifo_in and kfifo_out calls for lockless
operations. Perhaps that is a way forward for this problem.

William Breathitt Gray

--4yW8YEuGs8SU/bDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHGmQYACgkQhvpINdm7
VJKIVBAA2dUKFvQQdKMjLIna9eLKxZnPgrrZkCxpqBShImVm5Dto2rBBXtDOGLGo
B3RJfXh0+eAMUmUbNUuIcB+ZwWi69CUZkmq8/yCXvx58oN3wVyw1cYOABqximZhl
lfVUcCrTJCN1sFVjpVAWkrt0s1PnsSH75iJum5wpEmaRMJYnac50+4Tp+7424ZxW
92VLxqGN0qfgSUF6M5IlZrDe7k9vEimv2MGVZi6okph5f7nslcWEZo4UafHXP7Uq
6X9fVcWPdxjhZQmF9WFwfRkZ5hTtITYkKZ7Spq7YiFqo/UvvU2MWEatRZHSBl2Nm
ichCqOHMDHcFbgA/c7lPwjfHTPhXRDyppD+kQBAzKTCDj+zwtBdix2X280yBVttz
TuFKvSSp3t9FlK3GY/MvC08KHDBT6vz0iCn0cNsV6RpmLQROOMLtgzZzL4yd5dEU
Gsq7tl/WjB1kzyha/QC/oCcgN67rr4WqoDLj8uOYN/8Od7Vx7+tLbvqbOK34/2q1
ozRpTw6+QrWcYosicnicfAXJClwtNDzICVxidXuzVa+pmphuR250NwGCt5zJBUcx
7/O8Cc7hX4IY+Rq5LMt/X3m356ni9WoCYO85oq9FAmXW8lGqZNfwMnN0So1scbri
aHu1HBJJ1doBGCoK+geh2c2Kg51lj2K3lC4/ca+qo/pSxM3izzg=
=zH+/
-----END PGP SIGNATURE-----

--4yW8YEuGs8SU/bDK--

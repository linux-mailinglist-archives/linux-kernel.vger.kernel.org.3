Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DB4A8005
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiBCHvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiBCHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:51:01 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A919C061714;
        Wed,  2 Feb 2022 23:51:01 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id s6so1874566qvv.11;
        Wed, 02 Feb 2022 23:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qHA4FJIzc2avJ0UHq+M29RbUoQGiDIOwaftl21kPHfM=;
        b=KQReyke8X3IJIGe5kD0mfQE1NHkCOeICXqhC7Y7SEUF7RkQFZoFXLL51yt6YH3iFXy
         n+NpgQS2YqYV51SjjDw9I3sfOX09hQlBD6N/Dtsnh8fEbmaq+tengA0MsWpOUtppNdDe
         +UrFbyj0wp6hFY/enpgaidrtv9EmYfsCz+nNKxhcRKb1NFIdkwc0fpMRxRRFe7N8SKd5
         jBt6U+x0PMWeZzHvp1UCvGpDAzlsIpzn1sFSQU6hE1IgR9dcw1KlNGGn6pPW8oPw7JAI
         ff7DcF6iCdiWDIW+5oY4WvXl7LiC2S4tM5DSsCuEn5MeygY4YhP2T1UO1kl4S10QnCM4
         /Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qHA4FJIzc2avJ0UHq+M29RbUoQGiDIOwaftl21kPHfM=;
        b=Mi6BRi75d+oetXbZjqBNxc7ycTyvsgHXWkdRTmdLoNsRBPRWzoobVhcCr+LQbwbfmh
         wewpcS6Y34UIbKXyOPuiVANZQUecKtHzpn58u5A+Ak2iDxUHxWEthBHZjvxbsDUC7swq
         I3kru4F1sv7lqxzuSUpFafSfnylWA5SbiINA882QZlyM9qvnen3vcGIO5NA74cRfGA1f
         R+8ltiFsbwTignfC0VsEYUaZ2aprpV4LPnphzAwTkCO7LCqiO16VGGHRmeAdDCmfEj8V
         zjMQj3g0eKI22zAz4sfjYyRaITcN8OiZ/38y+gxSjEJzIVqsnKWpFahfttKsZj/bkZ72
         Qo8w==
X-Gm-Message-State: AOAM532/Z+BiNnkAf+gwjknsQp9zFD7Q8ZAkFLK8fRMetSmvuBgrQMgc
        wSc38CSrXv5BPRjzlbO5xVo=
X-Google-Smtp-Source: ABdhPJzi87FL6BZvS4fUgKZm1HlKZ0YPTCJkjEIs7PdLg897b1DHnDk/2sh8Py7uGBO602KUEiEH7A==
X-Received: by 2002:a05:6214:2462:: with SMTP id im2mr30564083qvb.21.1643874660578;
        Wed, 02 Feb 2022 23:51:00 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id n7sm9754555qta.78.2022.02.02.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 23:51:00 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:50:54 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     David Lechner <david@lechnology.com>,
        David Jander <david@protonic.nl>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <YfuJXrxpas1ufzp2@shinobu>
References: <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992>
 <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992>
 <YcaZEKbzRbX982YW@shinobu>
 <Yfp56WznEMh7rp2O@pengutronix.de>
 <7a22b7c7-e5ac-7574-9d65-179ab605e4ca@lechnology.com>
 <20220203072411.GA12695@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byTadX5abZMJ1qKL"
Content-Disposition: inline
In-Reply-To: <20220203072411.GA12695@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byTadX5abZMJ1qKL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 08:24:11AM +0100, Oleksij Rempel wrote:
> On Wed, Feb 02, 2022 at 09:17:57AM -0600, David Lechner wrote:
> > On 2/2/22 6:32 AM, Oleksij Rempel wrote:
> > > Hi William,
> > >=20
> > > On Sat, Dec 25, 2021 at 01:07:44PM +0900, William Breathitt Gray wrot=
e:
> > > ...
> > > > So the counter_push_event() function interacts with two spinlocks:
> > > > events_list_lock and events_in_lock. The events_list_lock spinlock =
is
> > > > necessary because userspace can modify the events_list list via the
> > > > counter_enable_events() and counter_disable_events() functions. The
> > > > events_in_lock spinlock is necessary because userspace can modify t=
he
> > > > events kfifo via the counter_events_queue_size_write() function.
> > > >=20
> > > > A lockless solution for this might be possible if the driver mainta=
ins
> > > > its own circular buffer as you suggest. The driver's IRQ handler can
> > > > write to this circular buffer without calling the counter_push_even=
t()
> > > > function, and then flush the buffer to the Counter character device=
 via
> > > > a userspace write to a "flush_events" sysfs attribute or similar; t=
his
> > > > eliminates the need for the events_in_lock spinlock. The state of t=
he
> > > > events_list list can be captured in the driver's events_configure()
> > > > callback and stored locally in the driver for reference, thus
> > > > eliminating the need for the events_list_lock; interrupts can be
> > > > disabled before the driver's local copy of events_list is modified.
> > > >=20
> > > > With only one reader and one writer operating on the driver's buffe=
r,
> > > > you can use the normal kfifo_in and kfifo_out calls for lockless
> > > > operations. Perhaps that is a way forward for this problem.
> > >=20
> > > As proof of concept, I implemented the double buffered version with t=
he
> > > sysfs flush_events interface. Currently it feels kind of wired, I use
> > > poll and wait until it timeouts to run the sysfs_flush_counter() to
> > > trigger new data.
> > >=20
> > > Here is example:
> > > int main(void)
> > > {
> > > 	ret =3D sysfs_enable_counter();
> > > 	...
> > >=20
> > > 	fd =3D open("/dev/counter0", O_RDWR);
> > > 	...
> > >=20
> > > 	ret =3D ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> > > 	...
> > >=20
> > > 	ret =3D ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
> > > 	...
> > >=20
> > > 	for (;;) {
> > > 		struct pollfd fds[] =3D {
> > > 			{
> > > 				.fd =3D fd,
> > > 				.events =3D POLLIN,
> > > 			},
> > > 		};
> > > 		ssize_t i;
> > >=20
> > > 		/* wait for 10 sec */
> > > 		ret =3D poll(fds, ARRAY_SIZE(fds), DEFAULT_TIMEOUT_MS);
> > > 		if (ret =3D=3D -EINTR)
> > > 			continue;
> > > 		else if (ret < 0)
> > > 			return -errno;
> > > 		else if (ret =3D=3D 0) {
> > > 			sysfs_flush_counter(); <---- request to flush queued events from t=
he driver
> > > 			continue;
> > > 		}
> > >=20
> > > 		ret =3D read(fd, event_data, sizeof(event_data));
> > > 		...
> > >=20
> > > 		for (i =3D 0; i < ret / (ssize_t)sizeof(event_data[0]); i++)
> > > 			/* process event */
> > > 			....
> > > 		}
> > > 	}
> > >=20
> > > 	return ret;
> > > }
> > >=20
> > > If it is still the only way to go, I'll send kernel patches.
> > >=20
> > > Regards,
> > > Oleksij
> > >=20
> >=20
> > Couldn't the flush be implicit in the `read()` implementation
> > instead of requiring a separate sysfs attribute to trigger it?
>=20
> Hm...
>=20
> To detect pulse frequency, I need a burst of sequential time-stamps
> without drops. In case the pulse frequency is higher then the use space
> is able to get it out of FIFO, we will get high number of drops.=20
> So, we do not need all time stamps. Only bunch of them without drops in
> the middle.
>=20
> I know, at some frequency we wont be able to collect all pulses any way.
> Internal FIFO is just increasing the max detectable frequency. So, it is
> sort of optimization.
>=20
> My current driver version has own FIFO which is filled directly by the
> IRQ handler and user space trigger flush_cb to push all collected
> time stamps. The main question is: how the flush procedure should be
> controlled. We have following options:
>=20
> - Attach it to the read(). The disadvantage: at high frequencies, we
>   wont be able to get a burst with time stamps without drops in the
>   middle
> - Trigger flush from user space. In this case, we make user space a bit
>   more complicated and cant really get all advantages of poll().
> - kernel driver is using own timer to trigger flush. The timer can be
>   configured from user space. The advantage of it, the user space is
>   simple and has full advantage of using poll()
>=20
> Regards,
> Oleksij

Hi Oleksij,

Earlier in this thread, Jonathan Cameron suggested using the RCU macros
to protect access to the events. Taking an RCU approach would eliminate
the need for spinlocks because the memory barriers are built-in to the
macros, so I assume flushing would no longer be necessary. Would RCU be
a viable solution for your needs?

William Breathitt Gray

--byTadX5abZMJ1qKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmH7iUYACgkQhvpINdm7
VJJt2xAA7ScnCN7IiVPfPEooe/JGG8Kpvmo7xn2gbXc5hBjyqE2IfNun360A3Bp1
ctvX2TVxZHcG1vu91ohl+DBIFMHFpx4yJBSnObwAu6xmPUqPQYlZsXRt0RpqYxnW
+4T9ieYjL1Ac//ZHcyhVAwb12YV49y11asM7B8YB4OlgjNRILtdUhtct2nJOU58v
37U/M3hcUJJa9NVrObAGJLv1oMM1EQk8P2CiRT7UGbipF5RVZPDbVyZhfYTpmbj3
TxGNUZQ1vIneW1VAjb7elh/+jjo2oQkgIQ22lCRmxswQDyQ4tLtxY60ZuYV/rUnh
4Fo3X5KuoeLE1DfW89btkCx18bz64d3hKWCdx2XwSeuwz3WtBOKpdNjx/SigKNmp
CPBeFXpXpTgAzlowd1YlNCm8YidEmmNJHSsQ0+NMTjfpH9TVMnCGHNQbthzOb+EW
Uwvk8WAe9ef2j1ZHg3OWyC5a9VSk53yLGnBAgLrcLJYYmVmTTI9ollQsyjeROWsX
Z1O5516/J4UH2umGXKLv4PxXejMi66pBXGKEjkkY8q3huxABiqEejFPMlcQuePoY
OPEZxRQ5zc0NTDs1fSROwBEtAvPBcx/cqqQiQI1FFGyW5z6T7CtOFowO8r8sT2jB
81R6IG3fQiP81FqmFgucZcRY3XEV1ry7bhphYYcwBZ1fcg1hWlg=
=wnFm
-----END PGP SIGNATURE-----

--byTadX5abZMJ1qKL--

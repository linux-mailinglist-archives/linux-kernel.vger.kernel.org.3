Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260164658E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353364AbhLAWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:11:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40898 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhLAWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:11:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0B3BFCE20EC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 22:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E526C53FAD;
        Wed,  1 Dec 2021 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638396510;
        bh=Nzk4xuBnLua+Ch7FNlliRtr6zY/RQhBET5UD098bDuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgLeqX22nSJ5as6n4hru6rcn5e/oaMcbN0AoDLM3lAi0iV4ao2zy5CU8OkntE3/7k
         FKSgkTMmZJhs/md8BOuojPkdkq3GV8oflHmAcseebwPI3qTdKJSMWI7MtyeN40C+5m
         Ff42FyiLxvrWJzS9sB9kQpmVPuXiUagRmxrwgXdPKuMIgFb8NuepqRtEDu5O0/sP2I
         qtDo7QE+YVcMbpnFk9Y+PzdBbkg26Rjz3Ke8ppSGzFMXPyn2jTGPB8avsX+PgWTtRi
         pvP5Ey0W+84MkHXQjO8IgLqf28/qeS6lkiHGvaUEQP9m4pw/9XnR17a/ScUJqHKK9p
         zyJmowDyMMlzQ==
Date:   Wed, 1 Dec 2021 22:08:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l42: Implement system suspend
Message-ID: <YafyWnVA1J1rgCf1@sirena.org.uk>
References: <20211201153648.17259-1-rf@opensource.cirrus.com>
 <YaejghraYE6lD7FD@sirena.org.uk>
 <87930df9-6220-807e-a655-1c7d7ec020ab@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MZbxPQY3xGbOgcXr"
Content-Disposition: inline
In-Reply-To: <87930df9-6220-807e-a655-1c7d7ec020ab@opensource.cirrus.com>
X-Cookie: This is now.  Later is later.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MZbxPQY3xGbOgcXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 06:04:00PM +0000, Richard Fitzgerald wrote:
> On 01/12/2021 16:32, Mark Brown wrote:
> > On Wed, Dec 01, 2021 at 03:36:48PM +0000, Richard Fitzgerald wrote:

> > > +	/*
> > > +	 * PWR_CTL2 must be volatile so it can be used as a canary bit to
> > > +	 * detect a reset during system suspend.
> > > +	 */
> > > +	case CS42L42_PWR_CTL2:

> > This feels a bit hackish

> I can't think of a better way of detecting whether the chip reset. If
> we don't have control of the reset GPIO we can't force a reset. So it
> depends whether power turned off (also whether it dropped below the
> Vmin voltage at which a reset is triggered). The regulator framework
> can't tell us if it really turned off power and on ACPI systems the
> power is all controlled magically.

Right, hence the second part of the question - the general thing for
drivers has just been to assume that the power might've gone out over
suspend and behave as though it did unless we were using the device as a
wake source.  We could if required extend the existing regulator API
notification stuff to generate notifications, though they'd not work
when it's compiled out.

> >     - is the cost of doing the cache sync really so> expensive that it's
> worth the effort of trying to skip it?

> It's not cost, it's about getting the correct values in the registers.
> If we call regcache_mark_dirty() it tells regmap that all the hardware
> registers have reset to default. Then regcache_sync() will skip writing
> cache values that are the register default value, assuming that the
> register already has this value. If the chip didn't reset, the registers
> could retain non-default values while the cache contains a dirty
> default value, in that case the register needs updating to match the
> cache.

(note BTW that at the point I queried the performance thing I'd not got
as far as the magic bypassed write sequences)

So this is clearly a being done at the wrong level - it is needlessly
complex, non-idiomatic and making fragile and non-obvious assumptions
about how the cache code operates.  The issue you've got is that the
cache code is presenting interfaces for the common case where you'd only
want to resync the cache in cases where the device has been reset but
you've added code which bypasses the cache and pulls the device out of
sync with the cache.  You need to teach regmap about that, not try to
hack around things in the driver code.  But...

> I tried to persuade myself that a cache value couldn't possibly change
> at any time from suspend() being called to resume disabling cache-only
> so I could safely accept default values being skipped. But that
> assumption made me very uncomfortable - I don't like leaving potential
> bugs in when its simple enough to prevent them.

=2E..that's based on the assumption that this is all about the magic write
sequences you're using for shutdown potentially conflicting with default
values you've got in the cache?  If it's not those then the assumption
is that either the device was reset in which case it has reset values or
the device was not reset and held it's previous value, in which case the
cache sync is redundant.  If we don't trust the device to reset cleanly
for some reason then it's probably a bad idea to tell regmap about
default values in the first place since even on initial boot we might
actually be doing a soft reboot and the device could be holding values
=66rom whatever was running beforehand.

This clearly isn't simple, and other than those shutdown sequences or
potential issues with the device not resetting cleanly this should be
done by extending regmap so it explicitly knows what's going on.  If it
is those shutdown sequences then you're probably looking for something
like doing a _sync_region() on the registers the sequences touch.
Possibly a _sync_region() variant that writes everything requested, or
just make sync_region() not skip defaults.  Or just remove all the
defaults from the driver, the sync will be a bit more expensive but
that's hopefully fine.  If it's not those shutdown sequences it should
still be handled genericly but I'd really like to understand the
scenario you're concerned about here, especially the fact that any issue
will show up in this single register that the code is checking.

> > > +	if (cs42l42->suspended) {
> > > +		mutex_unlock(&cs42l42->irq_lock);
> > > +		return IRQ_NONE;
> > > +	}

> > Given that you're using disable_irq() to force the interrupt off (which
> > is a bit rude but often the best one can do) how might we be getting an
> > interrupt while suspended?  This seems to indicate an error condition.

> I may have misunderstood here, but the documentation says that
> enables/disables are nested. The interrupt starts out enabled right
> after calling request_threaded_irq(), so I expected that all users of
> the shared interrupt would have to call disable_irq() for it to actually
> get disabled (I put the call in on that basis that it does no harm). If
> disable_irq() forces the irq off even if it's shared then I'll remove it
> because as you say that would be rude.

Hrm, that may have changed since I last looked - if that's the case then
I guess it's best not to warn which was what I was thinking here.

> > > +		/*
> > > +		 * Only call regcache_mark_dirty() if cs42l42 reset, so
> > > +		 * regcache_sync() writes all non-default cached values.
> > > +		 * If it didn't reset we don't want to filter out syncing
> > > +		 * dirty cache entries that have default value.
> > > +		 * DISCHARGE_FILT=3D=3D1 after suspend. If the cs42l42 reset
> > > +		 * it will now be 0.
> > > +		 */

> > Something needs to tell regmap that the cache is dirty otherwise it

> Regmap knows if it has dirty values that it hasn't written out to the
> hardware.

Well, apparently it doesn't since otherwise we could just do a resync.

> > won't sync anything, including the non-default register values?  There's

> That's fine. If the registers have not been reset they still have the
> value of every clean cache entry. Every dirty cache entry will be
> written out by regcache_sync().

What about the shutdown sequence - does that not touch cached registers?

> > currently an assumption coded in there that the cache is dirty because
> > the device was reset and everything has default values.

> Regmap only assumes that if regcache_mark_dirty() is called.

Right, but the point here is that coming out of suspend the driver is
expected to be unconditionally marking the cache as dirty and doing a
resync since we probably lost power.  The code is trying to avoid that
for reasons that are not at all apparent but I *think* are due to the
bypassed writes in shutdown(), especially if you say it's not a
performance thing.  We shouldn't need to worry about there being non
default states in the hardware.

The whole thing is just really confusing as it stands.  Like I say I
think this needs to express what it's trying to do clearly in both the
regmap operations it's doing and the code in general, at the minute it's
not clear looking at things what the goal is.

--MZbxPQY3xGbOgcXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGn8lkACgkQJNaLcl1U
h9AY6wf+NO6Z2euXBl8DqEPROLW3ucXDLxPW1AQkm0HivSrPNUz4M+UP0QogAWIM
DRQAAV7PBOc9HfjDGzOwsnY2qX7KmIE8NYW5H2Z67AD07neE/m8u5zVTQekQ2g/U
2Wug+2Z42ssi+v5L02CzBs6v/XxeMPKHhzdFqkeoZB3XIAT08v4d0LkEZfxXYUG4
ZOx5KDUmrsrdlVeZ7CsLBTeRU2HpBl2aLnuE+6a2ohAvdZzb8AWVAwLsqcfzWol7
lq/8V1aERLytQkZssL5olF4wJUgSUhf/deFPp5xYEtWGWE0R2XGFuEdQav7kY6xt
TWv+LT1HvO7vX+uKd1lszBv4V6GivQ==
=vARI
-----END PGP SIGNATURE-----

--MZbxPQY3xGbOgcXr--

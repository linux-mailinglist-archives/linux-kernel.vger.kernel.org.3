Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC45A6CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiH3TJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiH3TJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:09:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA972696;
        Tue, 30 Aug 2022 12:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95EC9B81D8D;
        Tue, 30 Aug 2022 19:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5E9C433D7;
        Tue, 30 Aug 2022 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661886554;
        bh=3RzQ8lzdJbVGxY7Fac63eSU33uBmGlFQpKF4dZbtmYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxM8lKrSS4cHRGJfhY3zm2DFkvGjesnkECPeKDRSoi7V/N8qDwKwfuGk9nlyZNVHW
         qlvp1LWn3xuE6vE14IfgXS27bJ5HUv5OHc4vz4U7OvTLdWSGmRT6ehYBxuQv4gcwah
         osNFJeiEW8JVresvADuFt8dGst3SsQQwD5PHu3fY0FgUkDE63wfS3H9natCO5bYoDV
         9Au/4UHIgRRqYFjZe/sEpXcOSMsvmVRLSoEGaDMbJZ8k9AvzxCdXaDgWBCRQXvzsFI
         X2qIrST+G4gDQDiE96BNWTzcrHo1eofi5BKA8UNx/lKLHD9FL17GdirMgDMaNkhm2E
         xXExo6H05m2tQ==
Date:   Tue, 30 Aug 2022 20:08:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 0/4] spi: Introduce BPF based SPI mockup controller
Message-ID: <Yw5gSElhbYwoXrfw@sirena.org.uk>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VEE/E6KN77c45Ytn"
Content-Disposition: inline
In-Reply-To: <20220826144341.532265-1-weiyongjun1@huawei.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VEE/E6KN77c45Ytn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2022 at 02:43:37PM +0000, Wei Yongjun wrote:
> This series Introduce a BPF based SPI mockup controller, which can be
> used for testing SPI drivers without real device.
>=20
> The testsuite for SPI drivers will be post in other series, with also
> support for I2C and PCI bus device drivers.

I replied to some of the individual patches here with some more
detailed issues but I do have some big picture reservations with
this approach as well.  One big one is that this seems like it's
only going to be able to handle emulation of devices that are
purely synchronous - I don't see any sensible direction here for
extending to devices that need an interrupt line as well.  That
seems like a major limitation.  It's fine not to immediately
implement everything but it should be fairly clear how that would
be done when someone needs it and some of the BPF design goals I
understood seem to conflict with that.

I'm also not clear what the BPF environment is like when it comes
to extensible frameworks, as soon as you start thinking about the
problem space there are some obvious extensions with things like
more detailed register map descriptions and validating that the
operations that the driver is doing to the device are actually in
spec for the device or trying to stimulate race conditions or
error paths in the driver.

There's also the issue with getting the BPF userspace tooling
that I mentioned in reply to one of the individual patches.

Basically while this does look very simple from a kernel point of
view I worry that BPF might not be the right tool for the job and
could be a bit of a blind alley, with people rapidly running into
issues trying to do anything non-trivial.

There was a series in the past year or so from someone
implementing a similarish idea but rather than using BPF they
provided a framework for writing device emulations in qemu with
a simplified Python framework.  That seemed like a more obvious
direction here.  They were initially focusing on I2C but it's a
similar space.  Unfortunately I'm drawing a blank on who was
working on it or the name of the framework so I can't give a
useful reference here.  Their direction was towards having
something that could also be used to validate what the driver was
doing to the device from the device's perspective.  I do know it
was written up on LWN.  Hopefully someone else will remember what
I'm talking about from this vauge description.

--VEE/E6KN77c45Ytn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMOYEcACgkQJNaLcl1U
h9BFXwf/SI9sfIsMapZOZHgClNyczWRLtC8JMAIgJIsFm+pTR7CU0VO+POH9cTdd
Jlx14x01XFV17MjZnQyWyT2IgzKLXoJ2AA5SSoZy8fy/iA+zQGwsM0OXp6HkjRv5
KrtMtbb7/2mKsRfENacOGyirdkKFnyDQ2VVi6pmpAYruFHfmveTOXfIewgUjD86e
8Z/9MPo9hShmdH1t3EvZGKkucP0BLTi4pyQYmoGIlrvlhikWKKy5Apk0pNu5SvH4
mx3cpcDyxRbLqQGxmGt0fFGQniM5UlC4oXOa8j4DxkB4LcXrUPuv1WjJQyB8Q/2c
rJZm2XXVMveuEGEXTnXXAacJ/4+l7g==
=oMk3
-----END PGP SIGNATURE-----

--VEE/E6KN77c45Ytn--

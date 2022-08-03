Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7374C588B72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiHCLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiHCLoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:44:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2741BE8A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB3B9B82188
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA56CC433C1;
        Wed,  3 Aug 2022 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659527051;
        bh=5/9YQO52Bee/EaBc9lr7oejsA5JxeJQbFXb22/02YnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsJmMmlF6oaE4300tR9I6TP3bpCtgtJUCvfsJxqBCcm5ECKRkN3oEQT7TV4Bc6Y5d
         8i5VJPKdOD5QerZF5RuwmI7bbhFmosud8w2v96sVyELNN7s5KIGRF3dH4uwL3CybUM
         JkTWYvusnwPq/Btj2ZKH8nucr3ohrwJS0mZXANwKH1zyIMnLDNtba4JUYirPvlLP4j
         bqTfDvAFi+pqnSU6rr7B8WOZBxR2SWBcNBlXj3HtHb0xhoujvQVZArfpSyoTuiJJK8
         oC0wVpTyTYRBYHCt97W6uBBGj4A9z14L/YYojpHfvurk9n8xqT4QYyNfwn0eyhzwv4
         nt80N/JTN74Iw==
Date:   Wed, 3 Aug 2022 12:44:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Tom Rix <trix@redhat.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, ardb@kernel.org
Subject: Re: [PATCH] soc: sof: fix clang -Wformat warnings
Message-ID: <YupfhNXObIt6yNqI@sirena.org.uk>
References: <20220721211218.4039288-1-justinstitt@google.com>
 <YumINAZ4WaM4rG7Q@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dMPAc8CxvXVPL9lp"
Content-Disposition: inline
In-Reply-To: <YumINAZ4WaM4rG7Q@dev-arch.thelio-3990X>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dMPAc8CxvXVPL9lp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 02, 2022 at 01:25:24PM -0700, Nathan Chancellor wrote:

> Is it too late for this patch to make 6.0? We are trying to enable
> -Wformat for clang in 6.0 and this instance of that warning was
> introduced this development cycle by commit 323aa1f093e6 ("ASoC: SOF:
> Add a new IPC op for parsing topology manifest"). If I am tracking all
> my patches correctly, this is the only instance of -Wformat that does
> not have a patch applied to a maintainer's tree so it would be really
> unfortunate if we could not sure it on for -rc1.

> We could probably route this via the Kbuild tree with an Ack along with
> the patch that enables -Wformat if it cannot go via Mark's or Takashi's
> ree.

We have a couple of months to get fixes into the next release so it's
not an emergency at this point.  If you want people to see things
promptly you really need to do things like send them with subject lines
that look like something that might be relevant for them to review
(generally, at least visually resemble how other commits in the area
look).  I don't know if I even opened this mail first time around
because based on the subject it looks like something for drivers/soc not
a subsystem I maintain.  Given that none of the SOF people responded
it's likely something similar applied there.

In any case, if you think something's been lost the content free pings
either here or on IRC aren't that helpful - they're not directly
actionable.  It is generally more helpful to resend, that way people
have the patch to hand and don't need to go looking for it.

--dMPAc8CxvXVPL9lp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLqX4MACgkQJNaLcl1U
h9CFOwf+JSow+bMD3gDkBQomWzJw8cGlWyTUcsXLdlE/CzXwQs5srMa5Or+NqyRW
/iU7VN7jq7imtSN6PHsdwgu9V5v6B3bK7aIO8aTICXnQhLrgjuRSeA0OMcIjCf7n
mpjg920Om3+BWhYMU9JK4sNilrA6cEeEK8FaZKPQu+bEpAzrtKGKRugbBc/C8Jbm
GULKrkZ01e5UUovr2h6va6ownqScAVgj58T25DyWcJMT3hiLouiHd/vdIFzSsLBS
uoxFUkJXQH3Gk+GnwtvmXmagvSlzvcIfQn4XzKWQP0wS12AV1VuZ8kF9YfOcBqF/
Xjm48O6XfeasYtW3gZV9hz8wX3rFNA==
=BSuP
-----END PGP SIGNATURE-----

--dMPAc8CxvXVPL9lp--

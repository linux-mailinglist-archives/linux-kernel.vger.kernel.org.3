Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEAE5091D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382509AbiDTVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382518AbiDTVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30A3483BB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FA1161509
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864D5C385A1;
        Wed, 20 Apr 2022 21:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650489122;
        bh=xKYphzgcXDUuNB1g1olIfF2kYeWa4F6zxmc89At4WEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJvRICXCnqsZTOicqSq8XKHqpzaEqYrYXZYXyKglmBjBqIFVo0jx6kG5ktlFUeeFH
         ortGVo4GqvbbVJKVhSid1vygH3kfRBodCwzQhJ/I6u34n4PiLxjXMA0WrX+tx7I/oJ
         ViqVpUontQilWMG6MSazSsjGy0SLTA8NJXf/kBKYcJIYYjG2DOD9jZYanEDdYdM73Z
         bRK9i1vgkTlBq02HwayxBa8AVDc5+Kdj7IvExSopovIQjj1fjc19zC1ZBB/RgCrUYn
         mKJHLlGjFQDc0ucBBbIyKwr/3srD9IBT8sAHkSYFZOiLkC6H5e/Vx87BKTPFThULku
         XmyLZhqmjVkXQ==
Date:   Wed, 20 Apr 2022 22:11:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: core: Replace _regulator_enable_delay()
 with fsleep()
Message-ID: <YmB3HWEIv8m+BP1w@sirena.org.uk>
References: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
 <20220418141158.2.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
 <YmA0vq3qkAEYGk03@sirena.org.uk>
 <YmBPyJfN7we4k78/@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MBlKhS3PxJRqZiM8"
Content-Disposition: inline
In-Reply-To: <YmBPyJfN7we4k78/@google.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MBlKhS3PxJRqZiM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2022 at 11:24:08AM -0700, Brian Norris wrote:
> On Wed, Apr 20, 2022 at 05:28:46PM +0100, Mark Brown wrote:

> > Did the issue with the delay functions preferring delays on the higher
> > end of the allowed range get fixed?  That might be an issue for larger
> > usleep() values.

> Hmm, good question. I had a faint memory of this problem, and searching
> around, I couldn't find that anybody *thought* they fixed it, and I
> found evidence to the contrary (some reports complaining about, e.g.,
> boot-time performance issues in drivers/usb due to the same, with no
> indication that anybody truly fixed the problem).

That's what I feared :/

> So maybe it's better to retain the regulator core helper
> (_regulator_enable_delay()) and rename/repurpose it for my patch 1?

Sounds like a plan.

> I feel like there's some room for improvement in either fsleep() or
> usleep_range() or both, but I'm not sure exactly how to go about that
> right now.

It's really difficult to design an API that's both tasteful and clear
about intent - it's relatively easy for something like a driver that
just has a single hard coded value so you can just use usleep_range()
directly but it gets awkward once you start being generic and the code
really has no idea what the actual delay it's dealing with is.

--MBlKhS3PxJRqZiM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgdx0ACgkQJNaLcl1U
h9BNngf+LUIMyIBXhnQk7dsM8g3YL+uGLxUSOp7J+4ytI/gqL5rDnAYjhiZHyMIF
bGXVQLoxRfI97mNc1bkMTdfn4E+GdisohnZTeWBC2EWJsgp+hqNp4OJjvNmnG7fA
G3HWRFVuNJRFZXuNR/xV40gMbF90YzMxd5O5jEAy4ClG15+lOKYX7ufazU+TOXjt
7UA05qUreEvo/If3W8ku3s/s4Z0IBArkjNv1Ympm6BzXZvUxzL/OIxpDlK7Wu9CJ
1Uld08J7g1jVMX3lFhq2RqCJuCwwQqdhikh+npjZ+Nljtc2h8zXveuRcmbeN0TQl
iBXESTgNXEIu0yuktqT1k9pTkhnGqQ==
=5nW2
-----END PGP SIGNATURE-----

--MBlKhS3PxJRqZiM8--

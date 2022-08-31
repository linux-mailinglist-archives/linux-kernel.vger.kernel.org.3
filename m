Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58B5A834E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiHaQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiHaQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:36:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2ACD4BE9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45348B821AD
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293EEC433C1;
        Wed, 31 Aug 2022 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661963791;
        bh=KgZnsso7kF6aHFGnSIJef18Uvd0pNC/m6XSGxGYBwGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sz1XKawN2B5HHP/sZItd+rAzx2tmHhNRckLdU7Z0JxA6uEHvfmFFvLKnsQ68F3W/i
         SRaqC9SoHRlpYUBcOFkREKq3ZrFt/AevhKdNyluFpx4Tm0sJlXIsBePzkb6yoPvuuH
         MAbJkzFu/3e0WZitiB9kDH7Xk8M+oEbw+Yp3LAaxCV9+14SmHgt853Fhg7+vo7oeYK
         IEZTCDAu++Jk4o5/obZW6houyO9FPyQ3gXIkH6LL0UtByLXf/Bhgv+691IBgxjbExG
         ic7F2diU4ZSYka8M+XnlpjkJjvlFerCQf2W6MNDVudmQ8+WZz850jyCzzRSr5m44Rc
         UjAbG7g9a3vXw==
Date:   Wed, 31 Aug 2022 17:36:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steve.lee.analog@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        krzk@kernel.org, ryans.lee@analog.com
Subject: Re: [PATCH] ASoC: max98390: Remove unnecessary amp on/off conrtol
Message-ID: <Yw+OCnOgYUOWdIEx@sirena.org.uk>
References: <20220826023504.6183-1-steve.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="52dw3Ph+pKqVOnNd"
Content-Disposition: inline
In-Reply-To: <20220826023504.6183-1-steve.lee.analog@gmail.com>
X-Cookie: It's later than you think.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52dw3Ph+pKqVOnNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2022 at 11:35:04AM +0900, Steve Lee wrote:

>  The Amp is already control in userspace before trigger calibrate function.
> Remove unnecessary control in calibrate function.

I can't see anything which ensures that this is the case?  Should there
be a check which returns an error if the output is not enabled, or
should the function check the current state and preserve it at the end?
I can see that this would fix problems with it being disabled when
callibrating.

--52dw3Ph+pKqVOnNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMPjgoACgkQJNaLcl1U
h9C4ZAgAhg2+SIaK5IfZY+hTm2eRhD88hpYBfBw5lrXth3VHn8iRgUorzGgiqSle
VbE+t7hq4C4q11alwzR+ZdtZgfuHBb7Y3w8Xx+Dk0SxJQ9bptDT4/nb6+Y9Uogwn
Fd07GAC8YzMUZnIjOK4VzL70N/iTLSXroGUb3MoMYWwFWnN5VeaR5eZSHa8ntyt/
S62LthzfBXoNaqrrpx+jeXqzEYzOPfQKfNDAXVW2Imj+D00hp5W4zSvDYGofI4qR
zfLUl6afqUqTCp/MHUncBPafhQJ1QBJVRYRTDRyvxdgFSIcBQvsZSJ4wRZhk86ot
90friYxGNtUu2Q/VBaInZN//VEIeLQ==
=yjS4
-----END PGP SIGNATURE-----

--52dw3Ph+pKqVOnNd--

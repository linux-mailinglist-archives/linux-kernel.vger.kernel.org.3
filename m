Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431154FCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382982AbiFQSM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383595AbiFQSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACBFE038;
        Fri, 17 Jun 2022 11:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9364661F41;
        Fri, 17 Jun 2022 18:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA29FC341C5;
        Fri, 17 Jun 2022 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655489563;
        bh=bUPFzcA2bwrfrcLXD7x3oRlhBEAEkGwIHCdUjnjME3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzEkn0jgFwCR+zHucfSU4ACpiT+fNkS2SkFZmgsY4v8y5M3CnzX+KS6IUY8wdxqZv
         bPLoZOVE6WGVIg4R5nrb0saH0gbx+9qBInXQ7heDbJSX8lK99o/MiR2N3JljAbl+Oc
         CHZfNqt4+z7CCQ60+9dGyhQG57CnXBJ5hiaQBq7wd0Zn+i7HklQdvGyT+nOeCs0T0K
         nPdmfyat8StE/e95a3xGNcHoNzE8dcYkRMwuLn5EGmwVPd/8upE+ubrIKgU2QFOCOB
         JUuoF3x8Z8kSPF89Xm2v3RZQF8VoEdbTFhp7XhKPcsZWVbiPv7cJ60RiD+VZK88Ppb
         9JEPbYeNFIQTg==
Date:   Fri, 17 Jun 2022 19:12:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Owens <daowens01@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: ti: omap-mcbsp: duplicate sysfs error
Message-ID: <YqzEFX1rIRIwJCnl@sirena.org.uk>
References: <20220616202645.1645972-1-dowens@precisionplanting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u2XbzTKFvyqRa/q5"
Content-Disposition: inline
In-Reply-To: <20220616202645.1645972-1-dowens@precisionplanting.com>
X-Cookie: My life is a patio of fun!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u2XbzTKFvyqRa/q5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2022 at 03:26:45PM -0500, David Owens wrote:
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requested
> probe deferral:

This breaks an x86 allmodconfig build:

In file included from /build/stage/linux/include/linux/kobject.h:20,
                 from /build/stage/linux/include/linux/module.h:21,
                 from /build/stage/linux/sound/soc/ti/omap-mcbsp.c:12:
/build/stage/linux/sound/soc/ti/omap-mcbsp.c:604:18: error: =E2=80=98additi=
onal_groups=E2=80=99 defined but not used [-Werror=3Dunused-variable]
  604 | ATTRIBUTE_GROUPS(additional);
      |                  ^~~~~~~~~~
/build/stage/linux/include/linux/sysfs.h:154:38: note: in definition of mac=
ro =E2=80=98__ATTRIBUTE_GROUPS=E2=80=99
  154 | static const struct attribute_group *_name##_groups[] =3D {       \
      |                                      ^~~~~
/build/stage/linux/sound/soc/ti/omap-mcbsp.c:604:1: note: in expansion of m=
acro =E2=80=98ATTRIBUTE_GROUPS=E2=80=99
  604 | ATTRIBUTE_GROUPS(additional);
      | ^~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/linux/kobject.h:20,
                 from /build/stage/linux/include/linux/module.h:21,
                 from /build/stage/linux/sound/soc/ti/omap-mcbsp-st.c:12:
/build/stage/linux/sound/soc/ti/omap-mcbsp-st.c:299:18: error: =E2=80=98sid=
etone_groups=E2=80=99 defined but not used [-Werror=3Dunused-variable]
  299 | ATTRIBUTE_GROUPS(sidetone);
      |                  ^~~~~~~~
/build/stage/linux/include/linux/sysfs.h:154:38: note: in definition of mac=
ro =E2=80=98__ATTRIBUTE_GROUPS=E2=80=99
  154 | static const struct attribute_group *_name##_groups[] =3D {       \
      |                                      ^~~~~
/build/stage/linux/sound/soc/ti/omap-mcbsp-st.c:299:1: note: in expansion o=
f macro =E2=80=98ATTRIBUTE_GROUPS=E2=80=99
  299 | ATTRIBUTE_GROUPS(sidetone);
      | ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

--u2XbzTKFvyqRa/q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKsxBQACgkQJNaLcl1U
h9CbVAf/bLEYqN9UltUUtE4QfUjkIThFiIGPqM6T7Lr0oitKtqpZGp9i2uqREP8Y
67Eks5a6Zs3SZr7ERZ4nYj/rurE+Jd5YgjxQ5SnGtj8tEFEe6/bzOmCzql0eyRX/
VuFTxyaDKi7QwfejecS3lQIxtWKLbUKw3rRBTF8LMH55Hnw2/oCNYL9djV80lena
GoaJVJYcxFU5Glv4J0ISgs1Oih1rHpI8SegCxqpdiHH2mPELxGB7BcyIyLS3x9yb
BL0dxS8LNRDmakViC8B2csXBjMIq310UogmzfMGyTtV2o/bijJ2eM0LiORCPOAGh
EdOyjsMBlX00w5lh3tyDdOYltpf8IQ==
=VZEL
-----END PGP SIGNATURE-----

--u2XbzTKFvyqRa/q5--

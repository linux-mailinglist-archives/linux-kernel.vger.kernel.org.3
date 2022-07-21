Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86257D6D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiGUWX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiGUWXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:23:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0C95C02
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CFAEB82585
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3EAC3411E;
        Thu, 21 Jul 2022 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658442202;
        bh=TrB5avJPHQv7ufvHADTIZZvo91GC5AxaOs1zsVkqqRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3rXYzNRTUxaXTideEL6S9A4SKopKTHLjPGekT3xIymzjxElMt/XAVJMSouh8Y5x+
         7DVRHw3lahyjN/iOQ1SLqT6SEniI0zzBzL7aQEBPMOErH4oO0cp9F/J51iSdU+TGSa
         U4jHBcNtWXch1y6P6AQ4Tll8gxqngYksCbcVWi6Cn0OfseUb/roQOYijH2rxtUDM7J
         yXyAGfx7gQkGnZu7RSbE4vUtUofjviM9fXY6nfMcSRsRTFfLTAx4+5KIvdinRubrZI
         +j9Q/o5x9B5F2yTASLcnXvjIxT1jGR3YCf0gQMfxl309MXe0279D7hZg28JJx/4mx4
         yI6JtSD5jiOlA==
Date:   Thu, 21 Jul 2022 23:23:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] ASoC: amd: acp: Initialize list to store acp_stream
 during pcm_open
Message-ID: <YtnR05hxiWNKOGoC@sirena.org.uk>
References: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
 <20220721062043.3016985-3-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w/c1cvUq36ZEZHgE"
Content-Disposition: inline
In-Reply-To: <20220721062043.3016985-3-venkataprasad.potturu@amd.com>
X-Cookie: Linux is obsolete
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w/c1cvUq36ZEZHgE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 11:50:35AM +0530, Venkata Prasad Potturu wrote:
> From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>=20
> We are currently allocating acp_stream during pcm_open and saving
> it in static array corresponds to array index calculated based on
> cpu dai->driver id. This approach will fail if we have single dai
> linked to multiple pcm device as we will have same dai->driver id
> or array index for multiple pcm open. Initialize new linked list
> stream_list to store opened pcm stream info dynamically.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/amd/acp/acp-platform.c: In function =E2=80=98i=
2s_irq_handler=E2=80=99:
/build/stage/linux/sound/soc/amd/acp/acp-platform.c:108:31: error: =E2=80=
=98struct acp_dev_data=E2=80=99 has no member named =E2=80=98stream=E2=80=99
  108 |                 stream =3D adata->stream[i];
      |                               ^~
make[5]: *** [/build/stage/linux/scripts/Makefile.build:249: sound/soc/amd/=
acp/acp-platform.o] Error 1

--w/c1cvUq36ZEZHgE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZ0dMACgkQJNaLcl1U
h9A8gwf/fL6DbtvOtKpgGASfHBvRvfVnyGcb4t2YHbwtZTMnfB3M5vvhcARidz6E
z7OCU5ds6THN+zdyGcm5+z54vHpfdw1xW4MzRiz2zuUdviLPk+op/8FdiTFsuty3
hEqhv67RHBuvBOHQx1dB4CErspqEaL9+9jX+r5JtLQFyj2isoNGiont3x6I3M1FP
E/zkne2SyW/Hz466bTPewSdoiYMe5BTDIN6y4qqYiFLWd3wWPWFMMe+Hdv/WkYaX
CcbsgGy95KfyD6QYjr8AzyCDeu7WDEbs5HuXeCpIaa4JjHZ48ES8Eg1jDy3AlJcy
+HnorlsJYlXPqpDtIPhqiwhd+iM+4A==
=BIrc
-----END PGP SIGNATURE-----

--w/c1cvUq36ZEZHgE--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A95383E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiE3POM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiE3PNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:13:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F31A0067
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E4BACE106B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC87C385B8;
        Mon, 30 May 2022 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653920011;
        bh=M+00GOuXuD3qATD1qzKNz1hVq15YrxTq0pMnKrwvVeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jox3gxFnMJU1mWKLehrO+A1MOhqnkIk7Oipg39sFbcHHnmKaAZRVYrdTuaBEpmjv4
         lcL8dWWain6ty0I9wQNm9Vw7QzIFXnBizSCFStfVcFmRDZkwgun69wdrtci3b7hUPW
         +zReSXJAeShCyXWK42qBF4IHy/m4cBrc2bl9vAPQyk225seicmLauLtIWEHCVJcp44
         sXOJm2iEuiqEDWBEEInwuh95ouU0kF/xff/7NA8jlRTspt7AYYXFhOb4nhtxFesJu/
         7dBN1CAf7eaBv5oigmIAH4rgI79QGcl5OF+ZlwAmbY7P9RpDu2UPPFB5vrvNt+6eb9
         pOyi3WIrvBhDA==
Date:   Mon, 30 May 2022 16:13:27 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 1/1] asoc: msm: use hashtable to check kcontrol
Message-ID: <YpTRB6rwGGUnUmvK@sirena.org.uk>
References: <cover.1653813866.git.quic_rbankapu@quicinc.com>
 <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w30vGsfjdTtApDVJ"
Content-Disposition: inline
In-Reply-To: <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w30vGsfjdTtApDVJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 29, 2022 at 02:20:09PM +0530, Raghu Bankapur wrote:

> index 5dcf77af07af..0eb18f8ee6fd 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -58,6 +58,15 @@ config SND_SOC_TOPOLOGY_KUNIT_TEST
>  config SND_SOC_ACPI
>  	tristate
> =20
> +config SND_CTL_HASHTABLE
> +	bool "Add SND CTL hashtable"
> +	help
> +	  This enables hash table in sound card for kcontrols. The traditional =
way is

Since the rest of the change is to the ALSA core this should be
in the core ALSA Kconfig, though I'm also wondering if there's
any reason to make it configurable at all - is there any big
downside to just using the hastable all the time?  This sort of
tuning control tends to be a bit unclear for users.

--w30vGsfjdTtApDVJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKU0QcACgkQJNaLcl1U
h9CgDgf8CA1ZjPNPDW9eTebFImHbdjUFqR86l8zehQwy0N0Cwxx9Sfpe7WQPbR9a
ZeJ9L4cgNQ0e7l4+txIc+i+G/BzIOc5ojK3/OiUqTlCaiie5bP9aNVVd1SaHVCRW
2buYD+83wCTYdpjRDHd6stmHc2XDZCkRRmeYeaKFNINNNe2ovg8W+LteV7dZdX9S
/K8cHu+bIJzdUetALHkKS/jyHyD1xX0QVb7b6vQOfKmlelGVyVq7i5VVOso/tvqV
A/Rmy8HUwbCbQieD2zGxsvRK4k50/tQH/1GmHp5O8vVzPfuqZRbHNR7dodJnz9gA
fM18/fn88qbrP4HiYNiVKDnJ2heShA==
=98Bq
-----END PGP SIGNATURE-----

--w30vGsfjdTtApDVJ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEFC4E58E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbiCWTIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiCWTIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:08:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06339FE5;
        Wed, 23 Mar 2022 12:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7197BB81FDB;
        Wed, 23 Mar 2022 19:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E752C340E8;
        Wed, 23 Mar 2022 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648062390;
        bh=rnGUy1NYDMq+7asXvjQLF0WtVU2uMWXPW+J0p8Njwwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBxxdAyelIlHLZsZY6i6A0dlqCPZlkuJuBwhS0Ir1MliarGAiEtO1qi1sBfHa5pht
         0EmNHpCjn0JUleJaGDzyhSaS+E+1uWxWKlpab6RpnJLtpTlTEGNLTPqHDMrYZBZHyM
         7F6+4lBA0O+OUtswzh/JXx7w2wifWt8U0irfq3SLSkS08+Xj6ca/0O8B9oBuJdUgUm
         eb+iq+DqLFS11BtrbGme8hQ+bmea3Sa+7nhEuhqUCn3bP1S/6VqeGibPaMVDuTcW2t
         DiOQ/VFrH2vxTWTJbXeWwK3h3yvIyq23keVJIKVx2qGoNy5K0yNtuv4eeCouX2qBcM
         QqjE6OkYxRzOQ==
Date:   Wed, 23 Mar 2022 19:06:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <YjtvsYs+x3LRaLVP@sirena.org.uk>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <YjtNJe4Pgp3WIwOa@sirena.org.uk>
 <YjtXbDyCWZxKnf4Y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rnXVjJVxKarMt6/o"
Content-Disposition: inline
In-Reply-To: <YjtXbDyCWZxKnf4Y@smile.fi.intel.com>
X-Cookie: Nice guys get sick.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rnXVjJVxKarMt6/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2022 at 07:22:52PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 23, 2022 at 04:39:01PM +0000, Mark Brown wrote:

> > There's no *need* but the __ looks suspicious...  what's the upside
> > here?

> It's exactly what is written in the commit message

> __*_bit() are non-atomic
> *_bit() are atomic

> Since they are wrapped by mutex, the atomic ones are not needed.

Yes, it's not needed but what meaningful harm does it do?

--rnXVjJVxKarMt6/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI7b7AACgkQJNaLcl1U
h9ASSAf8DMDeomgtofuXgc4yoT8avnHb1qkmLcsZIhCT6MJIKZwPwNvyzAdzuquz
rDDTfNfq0ZFb0j6SAYRSgPPPRk69i3vdy1hT+T7ykaIaJ1laQDlJsKq3XxkIOSbB
hSGvZlp7dp/WITrwX4QPefJD2ENNoDSOnElrqjRLCivmjhd3wwAjD8YyGCTgtUhg
hxvJ2jI7J1LtFdmcqtuu/hTvs3TluKo7DcLCuzuNWs6Yllm7F7i7tWdLvJ0I3mCc
WaZKh5l6sdZNfBWQsy5C6Nrj7qkrok5mgqaN8i+kqEbW1OTnevvQuAtlq/QJfAGt
zWkYYvdMEevnFgC/jNRrBVdMWWZNYw==
=mCxY
-----END PGP SIGNATURE-----

--rnXVjJVxKarMt6/o--

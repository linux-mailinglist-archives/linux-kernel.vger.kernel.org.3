Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3E4D3240
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiCIP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiCIP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:57:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F213C255
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85B7961650
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFFBC340E8;
        Wed,  9 Mar 2022 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646841377;
        bh=KVzxjGUGk6NYXxcaOKH+zrJvN87Ms5WfMwZNi9pdTgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTwJVvmhuOCIPhLdib/xFfeu5wi7sqMuanevPJ4/ayYDsCQYPfIEAKx7/IaHxxxfS
         RVcXrBlrawgTrF6GhJCuMOJfWG3Bdc/sdC977qjsJZs5LrMbQc/DLeVN2cJsizkkXo
         08HTuDgMF1aG5h28lI021rZ+U8Ozsr1zCkKl0qDDZM3yY6mEwIs48pRvHaD5kd8TUY
         QUxa/xaQWqt6KsBKyLblz233oPOocOEOZVAc80rUEM4Rllz77FKy/tnKJqpqUhNpTA
         JOBsoCjOxi470qagokchg0EOmDKUAc7QEpQ5ZOjok/eXfAS4lof8CNYA18tNkGycHG
         5mtllOqTdiiqQ==
Date:   Wed, 9 Mar 2022 15:56:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas5805m: fix pdn polarity
Message-ID: <YijOHNT0eqDyoviP@sirena.org.uk>
References: <20220309135649.195277-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saKSD0Ud0ux1qrCM"
Content-Disposition: inline
In-Reply-To: <20220309135649.195277-1-john@metanate.com>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--saKSD0Ud0ux1qrCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 09, 2022 at 01:56:49PM +0000, John Keeping wrote:

> The binding defines the GPIO as "pdn-gpios" so when the GPIO is active
> the expectation is that the power down signal is asserted and this is
> how all other drivers using this GPIO name interpret the value.

> But the tas5805m driver inverts the sense from the normal expectation so
> when the powerdown GPIO is logically asserted the chip is running.

> This is a new driver that is not yet in a released kernel and has no
> in-tree users of the binding so fix the sense of the GPIO so that
> logically asserted means that the device is powered down.

> - Rewrite commit message to make it more obvious that this is a change
>   to the interpretation of the GPIO in the binding

I'm still not seeing the functional change here.  The actual state of
the GPIO is identical in both cases, all that's changing is the logical
view internally to the kernel.

--saKSD0Ud0ux1qrCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIozhwACgkQJNaLcl1U
h9ADgwf7BXCNab9gHFTGN3ia4g62mvxnNpcUe9ztentajumfMLfdgzTZ8r2PyHSs
WQIrsZYfpnLxqerHODGQJX8WkdujBIPI2RJCt2tsaY334Ufc5nw3kc1r1a2rHODA
+0ZRJo5C9ddTXWW4hvV0FUzAc0pv6pG/vgh8uqpFakTH6xjmDI05o8Wv3kP0yQOv
LalAGP5T59IH6yOsVaJt/2RaVAl6DngbjwIsdNTZl2kpOMaoBkYhmYcElAAefvUP
iIBo1kq4bshF3B5s7rKKKDsVAonifhAqlAqsCWJMxK81wbIooEXA4xw/y/kmEzRM
/71nhJZt/xkQWeIGyJs1X4dM2J0tFQ==
=hDq2
-----END PGP SIGNATURE-----

--saKSD0Ud0ux1qrCM--

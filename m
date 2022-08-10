Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D008758EF19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiHJPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiHJPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91C60523
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B8F60C21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5594C433D6;
        Wed, 10 Aug 2022 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660144587;
        bh=GM01A3vPn4SxbCncDoqhIanwmfKrvFK0yJfID6wv9/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZJAGKppH3GVnFiDRHrWIpYX8tBuSzAHVkVPohIPo4Z+L1VvCtGHTJbd33cnC44ID
         kPhl3ddcOsVc1HKGaG934XejXHzhQnhPCaSTkLJgN3mtZxqh0Xk+OFVb08TNOUwyNt
         VtcTJg6pVRXXAjwEWVuDTu3AgpMAJ3VrZAqfNzBfFaOGkunfVe7kXWN4cSD7xN6HRy
         gFLoaETFr0mtytXIWQq3V0sm5z6A5HOVGfWPA+GKIaLJs2RTQ9siBAWJ9En+i5GYc9
         R6Zqw/5cOPYBQd7nm/64Yl/qWl9lf30JVFuJ3bQFXrw2RsmrOEw+/AGqkm2mhDmb8n
         Nck270E/EoJHg==
Date:   Wed, 10 Aug 2022 16:16:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] regulator: Add devm helpers for get and enable
Message-ID: <YvPLx5hizWMEBjVK@sirena.org.uk>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
 <b6058e052b842a19c8bb639798d8692cd0e7589f.1660127865.git.mazziesaccount@gmail.com>
 <YvOdBv0edrE3wKsO@sirena.org.uk>
 <e8900490-1eec-83d8-b190-6d6983d81c4a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+tMecClWfAgfuSlW"
Content-Disposition: inline
In-Reply-To: <e8900490-1eec-83d8-b190-6d6983d81c4a@gmail.com>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+tMecClWfAgfuSlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 03:19:05PM +0300, Matti Vaittinen wrote:

> In order to tackle the issue the suggested API does not return handle to =
the
> regulators - it really just provides the "get'n enable, then forget"
> solution. The consumers who use the suggested API to "devm get'n enable"
> will have had time manually controlling the regulator afterwards as they
> will not get the handle. I would almost claim that the pattern we nowadays
> see (devm_get, enable, add_action_or_reset(disable())) is more error prone
> as users seem to in many case be storing the regulator handle w/o any
> comment about the automated disable at detach.

Hrm, right - that does help with that case.  However we do need a bulk=20
version since that's an obvious problem case.

--+tMecClWfAgfuSlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzy8YACgkQJNaLcl1U
h9DSPgf/aMwuVB03tEyJWgsMUoa/+AzXF+i+5ryTdmp8FB5hhK81JwSjAsSbtknL
eYh7L7XcgXOm3pwbnCLKC8nF7hJ+gqwfZHfnVnFF2EL+h8QZwBdXcAPN1HgCvJP+
J20/iIgxfKl+Qxb/Mk7jJBbv+u1hDzsEnCNHS8Xw5Y3hs/o+BuitSBASCnO+e4sm
HjmE8o5N/0HpSxLA9EGsX8w+iTwLNbyvjouAX/TqKPe3h5vYa9TOnS2s0z4tOleS
wuzwsEIEM/I1UjFtVDGNMit3yBBW1JOkJXo0E/ZrOR35/oNiS4YvCvDJ6BPQYisZ
UfeW5Y6Rzpib21/7etsbrxkD1pqGlg==
=aNEN
-----END PGP SIGNATURE-----

--+tMecClWfAgfuSlW--

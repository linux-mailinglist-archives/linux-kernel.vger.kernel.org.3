Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90257042F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiGKNYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKNYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA896326F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F5B6148E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459DFC34115;
        Mon, 11 Jul 2022 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657545845;
        bh=G70xBG379C6f8fJ4Hi2cSSohFChcI3TzIWyJTrOHcRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jP1Zn0WWw4060K6LRNqkqIVb0fNrKWYIEtemq9b7lxU2Ed4QbszNV7H9tImg57LBp
         lknP1pVJza3KXF4mLs6Zqd9J8gJ3KXmXg0RBqnwEttJVGSSzptaIp70UbREzJPAykq
         3vo1gyzOkb6msiZdQfLwQa9ENLvwiduGQF/XSY7FhWkvPU84dFjygQNP61SZf29BPp
         n/exw/dSDqizck/dAA/hmQrqfP/a8e3OvxIf8i2yutOWJnzW+zZLjZ+vBYl9H6+HER
         BhcxlUFEW7TUqPRnI0r6fLKjAFEXTexuIROV8fIZD06D4Cat84xiR1A7NToT8sWBeb
         Dn7953VK+tAVw==
Date:   Mon, 11 Jul 2022 14:23:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, judyhsiao@chromium.org
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix NULL pointer dereference when
 pinctrl is not found
Message-ID: <Yswkb6mvwUywOTLg@sirena.org.uk>
References: <20220711130522.401551-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8nxuGyPlmzXFliIn"
Content-Disposition: inline
In-Reply-To: <20220711130522.401551-1-alexandru.elisei@arm.com>
X-Cookie: I am NOMAD!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8nxuGyPlmzXFliIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2022 at 02:05:22PM +0100, Alexandru Elisei wrote:
> Commit a5450aba737d ("ASoC: rockchip: i2s: switch BCLK to GPIO") switched
> BCLK to GPIO functions when probing the i2s bus interface, but missed
> adding a check for when devm_pinctrl_get() returns an error.  This can le=
ad
> to the following NULL pointer dereference on a rockpro64-v2 if there are =
no
> "pinctrl" properties in the i2s device tree node:
>=20
> [    0.658381] rockchip-i2s ff880000.i2s: failed to find i2s default state
> [    0.658993] rockchip-i2s ff880000.i2s: failed to find i2s gpio state
> [    0.660072] rockchip-i2s ff890000.i2s: failed to find i2s default state
> [    0.660670] rockchip-i2s ff890000.i2s: failed to find i2s gpio state

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--8nxuGyPlmzXFliIn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLMJG4ACgkQJNaLcl1U
h9B/nAf+Kvf5A4KB+uPO75jiVyCWYLkssKsw3HPjAgF8EBe+8IPSH4bMdRcdnkQH
/pZO3j8srxvMN1ABFQcuRSwjkxGjKYw6JGKo7W0BjV20qZ8PwLWPIOb9VVEROFiP
ky6OFpD3u5KGXVx95J8syIOrgskyM+CQ+eczZQCezEVti0W/WeysP2nm96HChhQB
9CogIqhh3ta5E7G7aq74o2o9reistKq1WNh94UfjDGGmj62d8RWdCVkLTrHjqY5n
sMAZHBBjIFybtao7r1NtcwUwTsvGcUWqX1u5xFhBx8i3T8aWbC5M9a1wdNGGzAtM
dGv7Ol9LRhreIVWgVe63OzthpynCSg==
=AqBY
-----END PGP SIGNATURE-----

--8nxuGyPlmzXFliIn--

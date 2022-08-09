Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A658DB1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbiHIP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244852AbiHIP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4A564DE;
        Tue,  9 Aug 2022 08:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52CEC6126A;
        Tue,  9 Aug 2022 15:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F63AC433D7;
        Tue,  9 Aug 2022 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660058855;
        bh=fQ1vxx5hvw6lsWVefkUSI+jjDL0i6RgRtYeopmp59/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEnCGY9pciB+LdPdZXSY7FDJxCstebFVLJ4fGtjOLqcMK1FqJZFbkocRuXjrstDTC
         NtsI27Wrp/hcva7bVxlFQ0tsVd19dN4bIdo0O7BOo4nLmj2PeDDD62jgtVF5AhLFlt
         OP8ze/pzfmUui6nnuSM07hjug7DdXkM6MBxxPasRfgaBOo3YLBNCQP6OxAJamiKU67
         dIvyIV5Ug9MBWPLdqoUVr9YASK3N8nEwLuLNgqAayiPYtyXVinMXS2vKz0DhDfGu4X
         GweuxDWrw09R9PoZ7U9fKl5wBGw4CY/Ryw2A5cyRmLfurwLQuWsp45cU8EWmlBbw7P
         6M2eFOnGYudfw==
Date:   Tue, 9 Aug 2022 16:27:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Message-ID: <YvJ84qkuXdvVgXRm@sirena.org.uk>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lBVgeDOGXQW0ujkF"
Content-Disposition: inline
In-Reply-To: <20220809152019.461741-1-narmstrong@baylibre.com>
X-Cookie: A nuclear war can ruin your whole day.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lBVgeDOGXQW0ujkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 09, 2022 at 05:20:19PM +0200, Neil Armstrong wrote:
> At the end of a message, the HW gets a reset in meson_spicc_unprepare_transfer(),
> this resets the SPICC_CONREG register and notably the value set by the
> Common Clock Framework.

> This saves the datarate dividor value between message to keep the last
> set value by the Common Clock Framework.

When you say the value set by the clock framework does that mean that
the clock driver is adjusting hardware inside the SPI controller IP
block which is then getting reset by the SPI driver without the SPI
driver knowing about it?  That seems like a bad idea as you're finding
here.

> This didn't appear before commit 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
> because we recalculated and wrote the rate for each xfer.

Note that the rate might change per transfer.

--lBVgeDOGXQW0ujkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLyfOIACgkQJNaLcl1U
h9Awagf+OUcsezR87epB5sRf0iUOehYNcaHJv9CU74vZ9hdz23rciUwHLGp+gGaO
6VTnFgYp20wC+Zxy/W0fT6WgbqQ9D+RujmabrST1jgVFd/ml24q/qCE7YL/GZ1pj
Z7GGoe9GmrfRFUW7zRmKMrQsOFQtxXsZSR0rM8iMHlPm9lI8pVEBDY1AI1TFPL+0
U0ncLcbJ0pibxGz2cboKDEfRoU5OJu8a0F9EBJ4OVJeI+XgjEiRounhW+g9E1rc2
8XOrwsOdwFkRckIzeZqAuAECA4px79Fj24pJObWousC7M3x+1VkctwWe8SZHAUjq
+FI09JvFwqg6AThV8fUxh5x8xxS/MA==
=yNF+
-----END PGP SIGNATURE-----

--lBVgeDOGXQW0ujkF--

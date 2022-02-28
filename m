Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471344C709E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiB1Pah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiB1Pag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:30:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE0261A31;
        Mon, 28 Feb 2022 07:29:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B141B811D2;
        Mon, 28 Feb 2022 15:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13573C340E7;
        Mon, 28 Feb 2022 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646062194;
        bh=lIBSNp+pViFi4sTHttxnbsoqe0xdjN5DZcklDqZj7Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy0rV89WR/SvOWDHaUHJ97DAgacxQQfVhpMHYQ4MVrjArRr/ymrj1T2h8ueI4rIoE
         L/tFqM4S1Z+Kn8T/EypwMKAZhmilQWMgDcVdjCl7qKFWGDl9o60aCyDQeho8J7ElUN
         5BhXHsZ5Yw2E5uLiyAuR+SLf76CEWvS6PI6JebmqIxiYpN4Prxr8jbfGnn/537bi27
         LRwO9d4B5sXjzZGZT41RLmD5FaFYhFDoB7EbMF6pusgSBQOxBhSyZRS0zm7yZgJVp/
         pDhd+XwSmrznxLjFcWg2UqaMPpLRceCqAK+d1JfN2heAxSbewAgYjpcn597HcMFJgA
         +uv3vxiGLT4Bw==
Date:   Mon, 28 Feb 2022 15:29:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Message-ID: <YhzqbYW1q5bPNWXn@sirena.org.uk>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6sX4MQTStecWuNG6"
Content-Disposition: inline
In-Reply-To: <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX4MQTStecWuNG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 28, 2022 at 04:15:46PM +0100, Christophe Leroy wrote:

> +	if (!status && spi->trailing_bits) {
> +		struct spi_transfer t = {
> +			.len = 1,
> +			.tx_buf = empty_zero_page,
> +		};
> +
> +		if (spi->trailing_bits < 4)
> +			t.bits_per_word = 4;
> +		else if (spi->trailing_bits > 8)
> +			t.bits_per_word = 16;
> +		else
> +			t.bits_per_word = spi->trailing_bits;
> +
> +		status = fsl_spi_setup_transfer(spi, &t);
> +		if (!status)
> +			status = fsl_spi_bufs(spi, &t, 0);
> +	}
> +	m->status = status;

The binding looks good now but this is still driver specific code when
it looks like it could easily be implemented in the core - like I said
on the previous version you'd need to update drivers to advertise less
than 8 bits but there's basically nothing driver specific I can see here
so any driver using transfer_one() would get support that way.

--6sX4MQTStecWuNG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIc6mwACgkQJNaLcl1U
h9ByJgf+Ph2K77NJETd4CxxTZeaCykQtUOUWUNtf67pOCCXa0j2bI0/ER4oBstq6
A4QjDZW1vXmlkY/Q2zfLOi0Zw3nGGo6Ygj6n0K/3SiQGaiX+9DsDL2rWKdxxsU5p
kNfnReKJ9eeF5rDNS6Pap4FlwXmknCCFelC43BcFHzlJcZZxYHPCb1OUAxB0t8xm
Djs56AByqApS2i1RXPDqwLE4q9024Xvmn8ULYHbjFANawe4cRiIRwwFHOMkNsDSG
TwLfO1ndF2eImBieKEoZe6cUCMy/PXFU5q3EISaqpDuxmq3Hj0Os2j9HLi9tLAwC
Iuwnf+cjK54tJ5vEeCSQOTpdQuZabQ==
=EYyd
-----END PGP SIGNATURE-----

--6sX4MQTStecWuNG6--

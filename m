Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE94B8EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiBPQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:59:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiBPQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:59:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90CF2A5209
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:59:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739B161B94
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B984C004E1;
        Wed, 16 Feb 2022 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645030742;
        bh=BqZVn79CauvUvjQtr/GuUmW/IpmEA2mCkZGUGwBaZ/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeRSQuNmXU3Mbr6+kaYd6Mls6s/IJkezLzA/TCPpNv3zXiDPeSCx6j7qpjrJSk5WP
         dWJfvbv85GRJBel8xIWwG6Iz6ymLgqnS6zJlYELzqAkx/QadAc8u8z/xaee7xHwj+k
         RqkJkzrNd6wjYJyGqgP+ZQv45lcLinvOyzOi5x5EBIeN8f2dti+A1a2zLYt3D22HYW
         MroWYqREwoNE6PSWwyFPBWX6xx/xHsIiovYorCe7jPkwADh81W3/Fdl10ppDOw+8Iz
         sNQOPsEBbzLVXEp1tk1dpzrTMPldH2dk3/Sj4PWUBKAtZ7JfpNY/nNusPbtYFIdjw0
         wVkPN32ZqbVhQ==
Date:   Wed, 16 Feb 2022 16:58:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        "Srinivas Kandagatla =?ISO-8859-1?Q?=20=1B?= [ 
        =?ISO-8859-1?Q?=20B=1B?= [ =?ISO-8859-1?Q?=20B?= =?ISO-8859-1?Q?=1B?= [
        B" <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] regmap-irq: Update interrupt clear register for proper
 reset
Message-ID: <Yg0tUlQ/Qs8AHa4O@sirena.org.uk>
References: <20220216100026.25543-1-quic_pkumpatl@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fzypM6lEStJ0CbMn"
Content-Disposition: inline
In-Reply-To: <20220216100026.25543-1-quic_pkumpatl@quicinc.com>
X-Cookie: Fremen add life to spice!
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fzypM6lEStJ0CbMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 16, 2022 at 03:30:26PM +0530, Prasad Kumpatla wrote:
> With the existing logic where clear_ack is true, interrupt clear register
> reset is not handled properly. Due to this only the first interrupts get
> processed properly and further interrupts are blocked due to interrupt
> clear register is not reset. So writing 0x00 and 0xff(when ack_invert is
> true) should have no effect, other than clearing the ACKs just set.

This commit log still has the problem that it's not clearly describing
the problem and I've forgotten again - in what way is the interrupt
clear reset not handled properly?  What should happen and what does
happen?

>  				if (d->chip->ack_invert && !ret)
> -					ret = regmap_write(map, reg,
> -							   d->mask_buf[i]);
> +					ret = regmap_write(map, reg, 0xff);

Why only 0xff and not UINT_MAX?

>  				else if (!ret)
> -					ret = regmap_write(map, reg,
> -							   ~d->mask_buf[i]);
> +					ret = regmap_write(map, reg, 0x00);

Please write 0 normally, no need for 00.

--fzypM6lEStJ0CbMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmINLVEACgkQJNaLcl1U
h9D09gf+JwEZ6LxLtPsYZXopIjju84kxjtJWT/2+YUa7DqB63ObSech/ypG7TLS7
dj1SjI1wQMNn6G0gMk9q7RiViuofuaOA/N+BHzKzxkeOvilqrYSFdlU8awS7w5RN
bhpXnTHpFbOK+ZwKefWjmXrTfevs73AktezrcLVhOhhsb+Yl45MEQr8U+slkJHVw
nPCMX+s5bfuGHJR/tky4wjbGmkdcKJx6VeceCnocaUKJ+EnD/QvMvvRD8akVVAh7
+zhBTbCbmEdKU0qfbJJQeiYZgIsqcxO4fXpe5sKdIOkw3N1IFW+ddwbAd2ZzeP/J
outZ+EETI+BnwvdyrHK7D9Rr+d83fA==
=tJhS
-----END PGP SIGNATURE-----

--fzypM6lEStJ0CbMn--

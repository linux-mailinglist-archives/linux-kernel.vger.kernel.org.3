Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183EF4A48C9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377620AbiAaNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243076AbiAaNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:55:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47AC061714;
        Mon, 31 Jan 2022 05:55:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E15C7612C8;
        Mon, 31 Jan 2022 13:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA89BC340EE;
        Mon, 31 Jan 2022 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643637307;
        bh=Mux+ePrY92AdNvLzvqVcgpb98PfbvNDN5o5jwmjyfww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCGy+cUsKVh1qxUrE4zCpjye+OJAvX7e3cTfdxgTndfpBEZz+UwzMFXmJvXr5aiQy
         SuIxQWsSjykVcYiw59O41KScLb862vSFn98HsWXbJXsJ/ANaVb5/xO5xHN70SQkTBO
         DKPJmvLCJYfzgJOi58r2C58pLlptCOs8LolavgwUS+Lvkoclal/EzQKfPzIy+1ZYMz
         UzypcFTal4H9gH0YHh+Ha4n01PS8Gf3RLbj4GXhKIk8WyzROpPaxwWvdXeUA22zaQX
         0km23LsI4JZX/OwphBxMAORiU4Y4RIHo2AUr0X1xiguTWQdycyIlkm/tlbHck8F6TY
         0JRZ0yiXxWyDg==
Date:   Mon, 31 Jan 2022 13:55:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-mem: check if data buffers are on stack
Message-ID: <YffqNEzjIkApR1HS@sirena.org.uk>
References: <20220131114508.1028306-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgw4aAEj6xocjt/W"
Content-Disposition: inline
In-Reply-To: <20220131114508.1028306-1-p.yadav@ti.com>
X-Cookie: I will never lie to you.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgw4aAEj6xocjt/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 31, 2022 at 05:15:08PM +0530, Pratyush Yadav wrote:
> The buffers passed in the data phase must be DMA-able. Programmers often
> don't realise this requirement and pass in buffers that reside on the
> stack. This can be hard to spot when reviewing code. Reject ops if their
> data buffer is on the stack to avoid this.

Acked-by: Mark Brown <broonie@kernel.org>

> +	/* Buffers must be DMA-able. */
> +	if (op->data.dir == SPI_MEM_DATA_IN &&
> +	    object_is_on_stack(op->data.buf.in))

Might be worth a WARN_ON_ONCE() for debuggability?

--dgw4aAEj6xocjt/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH36jMACgkQJNaLcl1U
h9Do6Af+PYxmL6o8QTkbuSMNCf4zLsOLWsjug+Pzqn02yk4lNTbwV29h3+FEqewh
trvMCVQgaMabgUOf/9hZhlYOJHod52b77dQI7iBolONua4wUPqHsNtO+p9FP7V46
gjUkTp54ArBKRRI8rlP/IpJy9ZAlzEEZEeXzGn/FZtw+Sdh8RDsFPSiB2X265XQG
dYLDlWfbrKc/2rSAoi46iZY9J9lcm86V44LAdJ1GoLXUf/esHiOtLftGUA+9xGb+
MoOIrMhQ1+AtnAx6fdg0DwD6aKNBFT7gCVqUOvteLnFGGCYKTMSF1OAuywY+4CSj
n1ri3jkVecHB15q9WpPtuVniim+7fA==
=ywN3
-----END PGP SIGNATURE-----

--dgw4aAEj6xocjt/W--

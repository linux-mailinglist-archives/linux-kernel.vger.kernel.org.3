Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472095A6CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiH3TL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiH3TLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374174DC6;
        Tue, 30 Aug 2022 12:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD8B6170C;
        Tue, 30 Aug 2022 19:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D52C433D6;
        Tue, 30 Aug 2022 19:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661886710;
        bh=Gy1+/VL+e+70uS7vuaYRJDgykD4gag04o0GXtUVp0Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGd3aN68jGAWLZCn0bIQJGsVfCHhsD9Uh4kiEfQfbal05Dgdjt7lB3zOnNy+ncGUq
         EpFTpXzEKSR1Svp0w1GkaBR1ckw+Pg6+Kt+P+1P7EX5T6pOh/t05f/cbE2V7VaohQx
         i2T/kAx/sAGPpHTC30KUeNbAodZg1EwND26m2H2AIqD8vW2QXnIWE6YU5lH6rx7hfG
         9k2dn6Fe4/5TVo78LAsCNg/t1WNEeRJ1LGGn3kmBI0qW+N6oGqE/yTxAZfEo6NnZtq
         PY9FvG6a0ZuxHT+W5UnbBwSYbnpepuqBc3Glh+eXEVj2Ga1g9fsjpxRCVPogwoL0Ih
         r4DjUwQGw6uug==
Date:   Tue, 30 Aug 2022 20:11:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 1/4] spi: mockup: Add SPI controller testing driver
Message-ID: <Yw5g8zalllhRxd9Z@sirena.org.uk>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-2-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rAsQXulb1Pv6CUsu"
Content-Disposition: inline
In-Reply-To: <20220826144341.532265-2-weiyongjun1@huawei.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rAsQXulb1Pv6CUsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2022 at 02:43:38PM +0000, Wei Yongjun wrote:

> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SPI controller Testing Driver
> + *
> + * Copyright(c) 2022 Huawei Technologies Co., Ltd.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +	master = spi_alloc_master(&pdev->dev, sizeof(struct mockup_spi));
> +	if (!master) {
> +		pr_err("failed to alloc spi master\n");
> +		return -ENOMEM;
> +	}

Please use the new _controller() API, we're trying to remove the
use of outdated terminology.

--rAsQXulb1Pv6CUsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMOYPIACgkQJNaLcl1U
h9B3Dgf9GwTmEIp7x3InIXeoHPy2V3m9g+OvVUr6fte0ryePE4q1K4Y8FkvlCuhz
rPpAUESzkpdAWhqBeG90GN64cq4vE7Sd9GFzNhiH6B6HJ6dbD7qzisyWZ1jZyaC1
PyqzSWIzH6TIbWUvO5KeKFk3b/MB69UK+ySAkx1cNy8cLDISD66tKC+ik70NFwxj
fP0Rxq17y9l4eIabW5VC54TwwtxMX5IlkqY0qZd4Vq1Qpm/LMojrL4Np3CN8/gYu
V3N1mAvQDIQzegCkdxgwpiZIxngbD/oOh965Xebpu/BRkzXMS5Q+m3SLvUdKSnHr
Up9Frzo2lSXuOU6MgacfB/DjpbhtgQ==
=EOT4
-----END PGP SIGNATURE-----

--rAsQXulb1Pv6CUsu--

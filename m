Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220335A6BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiH3SOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH3SOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:14:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E97298D12;
        Tue, 30 Aug 2022 11:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6559B81D0C;
        Tue, 30 Aug 2022 18:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DCEC433C1;
        Tue, 30 Aug 2022 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661883245;
        bh=VKzLFiP5mB24ZQikYwTCSQzw6IlGtjNBLJRJ3/f8DN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoQzTTQT6IaJUZCXQsb10J+JwgNfoHg0nCI4uVecJ+sh6iaQo7idU22k+xf0mHwYS
         TFZKdr5oKf0jcULLavtJGByELsx0GZkjE9faQNyttS2enX7z82jrvOXNuAWuXgrIsr
         FSTZ79v5BU1XcqhAu/4Z3n7fxoY4Z11RrpeND7WGSnLvGmmFs+8NFnIZ31u3mcuUsV
         gV54BfP4OHnFpyW3BHvjKHpN7AkVx3obiekUh0Li925PI7GgIXwGbyEfDtB8Dmkgba
         zVOe12BdnPNYGrusd8noWIFxQPqsx5pi++zxAj5Scux/M6AyzTH2FXwNJKMdi/D/SR
         j9XYn+qb8aw1A==
Date:   Tue, 30 Aug 2022 19:14:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 2/4] spi: mockup: Add writeable tracepoint for spi
 transfer
Message-ID: <Yw5Ta8sO3fMsPLDY@sirena.org.uk>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-3-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NrO7SSyXeKA+hN76"
Content-Disposition: inline
In-Reply-To: <20220826144341.532265-3-weiyongjun1@huawei.com>
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


--NrO7SSyXeKA+hN76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2022 at 02:43:39PM +0000, Wei Yongjun wrote:

> +#define SPI_BUFSIZ_MAX		0x1000
> +
> +struct spi_msg_ctx {
> +	int ret;
> +	__u8 data[SPI_BUFSIZ_MAX];
> +};

This has a hard limit on the size of messages of only 4k on the
size of messages, that seems a bit on the low side especially
considering that the example is for a flash device.  There's also
things like firmware downloads which can easily exceed 4k.  The
driver should at the very least report this limit via the SPI
API, and probably also complain loudly if the limit is exceeded
since it's unlikely that most drivers will actually be checking
for such a low limit given how rare they are.=20

--NrO7SSyXeKA+hN76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMOU2oACgkQJNaLcl1U
h9Dh1Af9GdUHS58zJBE+b0BdW2/c+ovfh36z1nrwxcJmGcLx+PFKfGGpTnk+7BX0
oBKAI50N9F0ah3pROKYTAwz7jKW92dHXakjR14zsPG2TnOX3mb3ZBcellJ+LveNQ
HTGjT+XX7Ggc1ZvjzTyTQ/FlSGRCOviRpem61IzIxvbdB2XDPFETQS0sbfNkvWxC
YRKyVg/yFMLQAQ49pEeoJnUOU4Cxe0PxagFAvjbeav8tiOrGxsBchmzb8opSVTGD
p8wF1d0tZnMyzrCGyklWblniXO7oiUsf/3Dc5+QwHCTqEu+KOgTTLM3AbLWYcEXt
zVUPTPuxfCQv4cPJk//ZJolyfz9Y7w==
=RqoT
-----END PGP SIGNATURE-----

--NrO7SSyXeKA+hN76--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849515403A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbiFGQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbiFGQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556610191B;
        Tue,  7 Jun 2022 09:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B847B617BF;
        Tue,  7 Jun 2022 16:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B83C385A5;
        Tue,  7 Jun 2022 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654618844;
        bh=l9olBdY8XoPM0wf1tBtpXR5ucJg+To7Pu36qgJqjaqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQP8+i8X1y17vNEFOscgQI0w77IuDZF+Fb0YMAmNub+87rZKCbc2s99eyXz5dGYu1
         MquzbeVwpnRq5KWaarHllVfoQm8s1AlgXzJqvUk0XOp67mQUfq/PIsNjPWiax2/moO
         6DTcoJuGX6paPBFBEA8dGQsb+kZtnaqsL/GuGy230fi7CBoMZUN4bPcMqRXksb449K
         6r8kuPAm5yNYp+1HAzVUJMzdNzUHRiW8/hkqPal4utd29p11Fm82TaTn+QxBYioZ/k
         TDvuhv/igCZjMlx67qcqv5HIgW6qVLSBqRtGGI2KPjBPb1G4UaZUGiNow2kjPif8QM
         Rd3SlDZ6Y2APA==
Date:   Tue, 7 Jun 2022 17:20:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: fix use after free in of_spi_notify
Message-ID: <Yp961zPy064+ouF0@sirena.org.uk>
References: <20220607155233.27235-1-xiaohuizhang@ruc.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TVcPyVtbuby/o9WR"
Content-Disposition: inline
In-Reply-To: <20220607155233.27235-1-xiaohuizhang@ruc.edu.cn>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TVcPyVtbuby/o9WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2022 at 11:52:33PM +0800, Xiaohui Zhang wrote:
> We can't use "ctlr->dev" after it has been freed.

>  		spi =3D of_register_spi_device(ctlr, rd->dn);
> -		put_device(&ctlr->dev);
> =20
>  		if (IS_ERR(spi)) {
>  			pr_err("%s: failed to create for '%pOF'\n",
>  					__func__, rd->dn);
> +			put_device(&ctlr->dev);
>  			of_node_clear_flag(rd->dn, OF_POPULATED);
>  			return notifier_from_errno(PTR_ERR(spi));
>  		}
> +		put_device(&ctlr->dev);
>  		break;

Could you be more explicit about where the problematic use of ctlr->dev
is please?

--TVcPyVtbuby/o9WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfetcACgkQJNaLcl1U
h9DqjQf/Sqhd8EwOOC3Tz3LWmIt8e8a9/0Tz3BKJ+BnMEu0OvgpypqYFAKkwmKo5
eus+x+63OYod/Gv6nZplOOdo7hCwTvG2Cfw8RSpp+2NQiSl3repfVb/OXdFlizm6
xCS39kszeGsWNTE4lZ6c4ivseeJD1niCQ8WjYbB94ozvqVZbm5/YvQWzxG7PT2c+
SvkAaeNkh1OV3GbRCSLu8ANLTHePt4iBnq1L3bcQnxXC+V7N+NRWMb3L67wSzvNj
lAoyl+jUKniAg8d0kcV+j5H3cS95usOnNGDAqeXQtjcGDX846lPsGVhJQ5g0RU4E
kftauAlFT43fOlYnU3VOX9HvhXtRbQ==
=Sbkt
-----END PGP SIGNATURE-----

--TVcPyVtbuby/o9WR--

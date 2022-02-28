Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE71F4C710D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiB1P4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiB1P4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:56:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BE2FFD9;
        Mon, 28 Feb 2022 07:55:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5F2EB81222;
        Mon, 28 Feb 2022 15:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64659C340F3;
        Mon, 28 Feb 2022 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646063736;
        bh=52psn0P7i6kx+2Vgh9EygPaBcWwRnWOszaqCVfH2Qr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHhqzKTtHfeG7CErBHCQTvk4kKry4af4Y3e5Wbedo/SFd59l+zqTvm+KtuZzZKj4l
         RmV6pBPDGqXE5gqz2VdIsNdWWik9iE6hfIguEoTmdMpaFUwOvkJQmVc5afew1kgsUt
         zPClzaK1z6YU94cXcU8UY/TBv9dhVQnYxNcaEdcjPBLO6rhYHqaiV08XdhZrJqusGh
         vYXVg/0Gm6TKbyttrr02rHOrz503NmU5ddy40ef8fGeZ+lkzk34p+2skSP9v3xnfPc
         OOI3Ji+keNX4k/LvkGx7o4Isj4a7RHvBlUs3z38Z6yJyXS1l6u4iwFKr/NwmJlbqOp
         0AvHI3bddE4XQ==
Date:   Mon, 28 Feb 2022 15:55:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, kernel@axis.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: virtual: add devicetree support
Message-ID: <YhzwdBP4OJe+bdyw@sirena.org.uk>
References: <20220218110604.1329024-1-vincent.whitchurch@axis.com>
 <YhZDVGC7dPiisnI+@sirena.org.uk>
 <20220228155027.GA16152@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g4ahjnXkuhAl/CwA"
Content-Disposition: inline
In-Reply-To: <20220228155027.GA16152@axis.com>
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


--g4ahjnXkuhAl/CwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 28, 2022 at 04:50:27PM +0100, Vincent Whitchurch wrote:
> On Wed, Feb 23, 2022 at 02:23:16PM +0000, Mark Brown wrote:

> > That's not going to stop anyone.  We should at the very least be
> > printing very loud warnings if anyone tries to intantiate this.

> I can add a warning.  Maybe something like this, following the style of
> kernel/trace/trace.c?

>   pr_warn("**********************************************************\n");
>   pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
>   pr_warn("**                                                      **\n");
>   pr_warn("** regulator-virtual-consumer is only for testing and   **\n");
>   pr_warn("** debugging.  Do not use it in a production kernel.    **\n");
>   pr_warn("**                                                      **\n");
>   pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
>   pr_warn("**********************************************************\n");

Something along those lines would do it, yes.

> > > +	if (!reg_id)
> > > +		reg_id = "default";
> > > +

> > Oh?

> As you know, this results in looking for the regulator phandle in a
> property named "default-supply".  I wasn't sure what supply name to use
> for this virtual client.  Getting the name from another property seemed
> unnecessary.  Would you prefer that, or would you suggest some other
> name than "default"?

I'd suggest adding a comment.

--g4ahjnXkuhAl/CwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIc8HMACgkQJNaLcl1U
h9C51wf+KFfI8JqUVnvlder6Z+YCme3skyOiRmP5clNr1nTM3XLIayEiJSwFoKog
r27Ts02yQx1FP7MQ3SV6wlhVPubyNtLL2hbLcebAHSBzfttGMImN0cnqxiAuOJPR
i2jzelbza9HLGZ8zwrqjFpC4ElsxUQJw/EpgWHLQbXAihO3/8fZLGJNxzBUTpw48
PLenoN6To5qGoRBk6l+BeUXL8A/XdrJX7tbgvBvMQ63c5l6Uwyzie52LQDC104LT
KH954p9Iyuy+P2nwGxQLqfI1kUfkVpENF8RzIrScIZlIDxvKWUGzxPrnd9MC3bvf
+y0lUn9aKPKM7l0afesp9vVLFE2O+Q==
=8wK8
-----END PGP SIGNATURE-----

--g4ahjnXkuhAl/CwA--

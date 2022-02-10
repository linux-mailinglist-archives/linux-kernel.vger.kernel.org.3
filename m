Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA04B0C32
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiBJLTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:19:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiBJLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:19:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A68FC7;
        Thu, 10 Feb 2022 03:19:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 011D2B82536;
        Thu, 10 Feb 2022 11:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97200C340EE;
        Thu, 10 Feb 2022 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644491941;
        bh=5J/dIHGwHKQr+CSn8R7NlZJrW4Hn1Viu4Q0/ctmXtRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZ33xLuhBaQhOVEK5GWlIGr1jdGVU8e5oJMHflDNpFmnjmxjymIOLmbJhW6LgP8hv
         0hggYrSrs9SPmxFc6Z+tMYMW9TjPCvZn445zW7exb3Y36AvWmb8GTxbTXm4D0wUHl5
         sj8/qxphNJ1+ftY8QDdAQSTfgjOGQHKtXPg8onN+9LzzuJyzbSbpeKTczx9Ry85vu9
         fxUCvdsaMWcZjfiuGQ6vRrHxMZR9xMT58pqgfxfJyPhu7mdBUe4zeHAfbyEtvM5U24
         lL9qI3YV2vhCeAf7/rr4A3pMyOYC9fzyFwsCtQJOXc4ZtuZ/goXbFs4NkplKfJEWZS
         FMCG7NKSY+tUQ==
Date:   Thu, 10 Feb 2022 11:18:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ying.xue@windriver.com
Subject: Re: [PATCH] spi: disable chipselect after complete transfer
Message-ID: <YgT0oU/5SMViNRu7@sirena.org.uk>
References: <20220209100042.22941-1-yun.zhou@windriver.com>
 <YgPEWyEj7lbQJgAn@sirena.org.uk>
 <07aca74d-c74e-c2a3-b8eb-bdcf9ed21a55@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zG9DLS7XB1MYP9NF"
Content-Disposition: inline
In-Reply-To: <07aca74d-c74e-c2a3-b8eb-bdcf9ed21a55@windriver.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zG9DLS7XB1MYP9NF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 10, 2022 at 10:03:16AM +0800, Yun Zhou wrote:

> if the last xfer->cs_change is true, keep_cs will be true, and it will not
> call spi_set_cs() to set CS to false. Do you mean to keep CS enabled in this
> case?

Yes, that's exactly what is supposed to happen in that case.

> I do not think it will break cs_change support. In my understanding,
> cs_change indicates whether or not change CS after an xfer completed. But at
> present if the last xfer->cs_change is true, we will not change CS to
> disabled state. Is this the result we want? I'm confused.

Yes, it behaves differently on the last transfer.

--zG9DLS7XB1MYP9NF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIE9KAACgkQJNaLcl1U
h9BMgwf/SLT/XaZtvAo8Uaw6oVOqfDXhs9k/DoP0JnwPdK5c2EQTEuExn70MLCGQ
bAk0rWlHAgqpFMxc3XBsHDXXl4gP1KW91i8lIZNoEXbhDZ3sq4zOultAis7wV2c7
Jc8bqyiLFvmFPv99uNXSLxXdfkR/At8Rb3xg0UlQFfT8cAp+u/6wFsJswGGNusmn
ZJd2S6YXENaeAqhRB3M0hyw9EQ/ALcvN3gPsPDiQ33YlXhRE6Ovbb22Y/k3l/LWA
nFGFBiHw9ZBSHYrYXdHx4zykqpVnwh5EcdwXz9MuwccakXTjCdxJpeN0g67df/2a
B2+cIdJFMkkP0rQROoQQaVJ5PK1huw==
=MnC8
-----END PGP SIGNATURE-----

--zG9DLS7XB1MYP9NF--

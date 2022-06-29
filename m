Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BAA560759
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiF2R1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2R1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D83BFBB;
        Wed, 29 Jun 2022 10:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35DCD61E69;
        Wed, 29 Jun 2022 17:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED50C34114;
        Wed, 29 Jun 2022 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656523669;
        bh=x0EesMyFaiSD8rylLmQqTGs3zzcIl/WKMbvu1LL/AV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBPcDs7ZbJTPSInPM7tyCB+0SAxPf6O8wnPrY5bQ5hRcG4wj0bJhBAyLc+KNDe6H8
         BfgwTzTPSlzVSvZLpfo4x+chPeMxywDFj6xQe3nbAYrZWGgEqRy3woZ0OkgcdvLe4H
         Ad+Ni3xu4hsPYt9WeMy7doyJbTIccWokzoOXS8HQPttWMDEyueU6zlzIqy7p9SN4my
         I+3ACBSudHDC2Br/wXSfR9TFqWe6iTHpECDA9v1F+scmxqE4aDOMixSxWvsuOkEMgM
         UVvzq3MhzMlLPoJTpWGWNkJzL8hI34sIW/A2CdP1/4IHGw7HB2yIV0YJo4GDv152Qu
         nTlqF0xa2Y9Ow==
Date:   Wed, 29 Jun 2022 18:27:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ian Woloschin <ian.woloschin@akamai.com>,
        Ian Woloschin <iwolosch@akamai.com>
Subject: Re: [PATCH v3 2/2] spi: aspeed: Fix division by zero
Message-ID: <YryLj6iWVkqWowDg@sirena.org.uk>
References: <20220622161617.3719096-1-clg@kaod.org>
 <20220622161617.3719096-3-clg@kaod.org>
 <YryHVsrqNlhdwKzq@sirena.org.uk>
 <59b82730-f09f-f7e5-0e2f-4ad1765f0f6e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VkJUd9CeU3kUqltG"
Content-Disposition: inline
In-Reply-To: <59b82730-f09f-f7e5-0e2f-4ad1765f0f6e@kaod.org>
X-Cookie: Booths for two or more.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VkJUd9CeU3kUqltG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 07:21:08PM +0200, C=E9dric Le Goater wrote:
> On 6/29/22 19:09, Mark Brown wrote:
> > On Wed, Jun 22, 2022 at 06:16:17PM +0200, C=E9dric Le Goater wrote:
> >=20
> > > Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")
> >=20
> > This commit isn't in mainline.

> drat. It's the OpenBMC kernel. I will resend. Sorry about that.

It's OK, I fixed it up locally.

--VkJUd9CeU3kUqltG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8i48ACgkQJNaLcl1U
h9D0+gf4tcfx+ldgEy2Wvrii45VbLbXw8yUXIxKQWcg1Ekf6E/5WrCYwVz5ZzRyj
DwH03bKdCTk598u1GbdxhugIaqvp76wQNbHJZ1kxVZd7a2i0cocCFjwaLlLQmdcv
BM0VmWsVJgA77QfAcdZJGdBtkqeObaAp7Uf/TZyg7Lq73fBK83hv9YyDp0JLSNla
TLwlT9Z7ot5cLFfBMOGiYRAsoPI/+6uf2u0zptUsnM105ArmVcC6WiOgbDB8eeDf
p9fFawvvtYgH5/pvK3WJjRehd+/KW/O2AAjJQmy2yhCMTsty3/4NCyUl/XFH7ymV
j8kcUIm7NlXWxsi45lGgDn2KlMNq
=K6NB
-----END PGP SIGNATURE-----

--VkJUd9CeU3kUqltG--

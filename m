Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC35599FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiFXM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFXM43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:56:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FAD4FC72
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19786B827FC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB73C34114;
        Fri, 24 Jun 2022 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656075386;
        bh=oZgB5FkUoIrYN0GL94UFDfxuPMTD6+aI5GADFEjgS6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oG2ZzXI7n/1R/rvuGgy+nU4KYxTjAuSE2ICfmp8EfPCvBHCKkTdZl4yb68zdGao5J
         bIcXglaownmzcAJUo5wQz1QoPq2OsmFfpWbg/CaeVD5pBXycqcGplfc2FyCuM2EJq8
         QUl/6VClaal5aeBDtYDM22s1I1FkdHTTNYZnzAnVP4D2UJ+B1zvlYaeLhdzbmqA0ya
         mTuST7dsAV9cXiyXjguwCQBVvvJc3cArCCBipuJX+s/Ruhv2QnD6QhKFIIDJMvSiwc
         RrJSSC+Ai4wsKDseSAgaI+XP67OGoXnbzChtq9HhPJs0Iv+r6StFHCD5eTdvj28AsZ
         wKqKW3NqlYFiA==
Date:   Fri, 24 Jun 2022 13:56:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
Message-ID: <YrW0dlXWhOo+a0sf@sirena.org.uk>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
 <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
 <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
 <YrWqAqGUuy8Z0F3x@sirena.org.uk>
 <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9R9sZfMsAeA9ZxE"
Content-Disposition: inline
In-Reply-To: <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
X-Cookie: Help!  I'm trapped in a PDP 11/70!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9R9sZfMsAeA9ZxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2022 at 05:46:10AM -0700, Joe Perches wrote:
> On Fri, 2022-06-24 at 13:11 +0100, Mark Brown wrote:
> > On Thu, Jun 23, 2022 at 11:26:10PM +0200, Andy Shevchenko wrote:

> > > There is no point to convert the fields you are about to remove.
> >=20
> > > So, either don't touch them or make this patch closer to the end of t=
he series.

> > It costs us nothing to convert them, this isn't a difficult or hard to
> > understand refactoring - the patch is fine the way it is.

> Modulo the defects that might be introduced if an overflow occurs.

This won't be an issue if the fields are removed which was what Andy was
complaining about.

--s9R9sZfMsAeA9ZxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK1tHUACgkQJNaLcl1U
h9AeNQf/Wi7SpXxxRgHHg80reef4GhdJlgfwJefIGf4Soq0Sj4UloPvW9AmGxCOQ
HQXa4OW03BmAX+7q9nSb9re+lpGmlWSwoZJx2JaJUrvKCWsOT/BZDx0958B3L4UR
+gCm6ktBfNk50D171mV4PRUckD65qwO+QLh15gcxFSqYq1ZmMElXdFdKhXjL29Xh
Jv6CcPrvYBqAZRc90PRD/nO5ikYobUrx9QMnRIO6KFeKMspugXk7O4ofAtOGmvv/
jaDViIxSvxV5DF0q0MK1H5R5DxtQWCzYBfG636bXvHfu6vfrf80aInRT5cmMR6Z1
3ujqMKEMiodj6RH9YELf1Ku1zVrGDA==
=Cha1
-----END PGP SIGNATURE-----

--s9R9sZfMsAeA9ZxE--

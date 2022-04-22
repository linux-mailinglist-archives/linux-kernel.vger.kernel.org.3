Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904FC50AC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442785AbiDVADy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381767AbiDVADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:03:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3673EF17;
        Thu, 21 Apr 2022 17:00:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kkvgq6myvz4x7V;
        Fri, 22 Apr 2022 10:00:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650585656;
        bh=jyMua1JM5/19m6/LHbydkO3JFid9AKYADiYEgJ3fXMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QGftkvzG4k0wI+vlqiiV8GmECKnBzelEU3jdZuLwPAGeMmN+9JKb3kLGZpmOfhHam
         r0k5NVYYcDOajlhzPDZOW8L8kAPqdQujQRz7LK3oTPELw+RWaLgsVkrYbK8g0s0mxn
         +JBw8mKASnf5ENpw/2dVrLAEhVMnUVSHiJzbaPiNEIi4oVy7cFuwAHoWz+JbeW16Hq
         tDLBTXkYYNydMB7Q/3djkmsTaGilAqf344XtIrponhpMXr05ORYpf0rP0ElxzSsl1P
         LPp4BZA3cyyEss8iVzq7i7Kb5/2hW1Rwm5ufC8V4aJOEM3x8QiG5DcIwg50DwANbCq
         xL6q6+OdmXO/g==
Date:   Fri, 22 Apr 2022 10:00:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2] topology/sysfs: Fix allnoconfig build breakage.
Message-ID: <20220422100054.74cadded@canb.auug.org.au>
In-Reply-To: <90d0e2c9b4a74c92bcdd5fc4313a7629@intel.com>
References: <20220421152645.3a849198@canb.auug.org.au>
        <YmD+geU9CmjoVnN9@kroah.com>
        <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
        <YmF+FTxgu2U4/oPA@kroah.com>
        <YmGEL2klp4S97UiH@agluck-desk3.sc.intel.com>
        <20220422092247.5c638079@canb.auug.org.au>
        <90d0e2c9b4a74c92bcdd5fc4313a7629@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QDaG+i/BcEViymA_OO6Rbib";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QDaG+i/BcEViymA_OO6Rbib
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, 21 Apr 2022 23:38:28 +0000 "Luck, Tony" <tony.luck@intel.com> wrote:
>
> >> Fixes: c3702a746ff5 ("topology/sysfs: Hide PPIN on systems that do not=
 support it.") =20
> >
> > This is actually commit aa63a74d4535. =20
>=20
> Doh! I looked in my tree, not in Greg's.
>=20
> Doesn't matter much, Greg is going to revert as I haven't come up with a =
good[1]
> way to fix this.
>=20
> -Tony
>=20
> [1] I found two bad ways. First one made Greg barf. This one breaks the b=
uild for over
> 50% of supported architectures :-(

I assume that there is some good reason that topology_ppin() is not
implemented as a static inline function?

--=20
Cheers,
Stephen Rothwell

--Sig_/QDaG+i/BcEViymA_OO6Rbib
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJh8DYACgkQAVBC80lX
0GwzbAf+LuLlFTK6JAMSbPf8A8gnPo4xr+iVf9lG8eHDQnrVFhKVSyo+B9fEUB0h
oPv3yRZG1KktlrfmbfFjBQSEq+AX/p/pJhtlk4Oc97hO0JUr0mgwW8okdeYL7tEM
SMw3/UkVaBMphYklW2Y6kb7Vx1VSS+GVDaV9f7t05vS7Fmcr79/776MPaj2lyCKu
lT570KoHabGrGUQs23lJwo316w+USWsGMs3WQa6VobFfiscyr7+ytG1KugXAMkSw
A+xf/Ymip2f+vfxz26KtoUzUAbAvFd6J72eEaHZ+LTwY/3I3UAn4XQiBbWlD9pRg
RNAsdlIk8+m6+Pmne6iCTSbMx1ocaA==
=tSPX
-----END PGP SIGNATURE-----

--Sig_/QDaG+i/BcEViymA_OO6Rbib--

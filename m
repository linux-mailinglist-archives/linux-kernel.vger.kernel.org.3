Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226104E6A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353113AbiCXV5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXV5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:57:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF90AB8201;
        Thu, 24 Mar 2022 14:55:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPfCv5VG8z4xYc;
        Fri, 25 Mar 2022 08:55:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648158924;
        bh=Hz0ssr3VzNWiziECwLC1/AbVCt1DqznmWTHpjMood+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DzKCKm7m/iXeFiQ8UJ0SS6/37bQRUjt9FuU7a++Tm3wDDXMl8gEiGcbhQqh8AVF4L
         1nqV36+dLMd1DsgzC+v3KnX+0psX6a5xhwM6GwwRzwemNOYJd2fIUBrM773sfC23TT
         0TE8OCZM8ysWt4LguQcnkz52YOrhRbegNbWFJzqmcIjbYr1x96ZG8NL2XhBMSFQupa
         y9PCKJsmqPe91mCAXoSI2ncRKiYhw2huZLTwLlqDI8YSURSNKnQACd/NMceHtLhhxg
         zeFA1mUTt4L11w+Qc31BZjuMOj1YRhatWTC1YLkzYrOKM0cL9a8L8jyh3Q9UGBy5nf
         4KWMR4pcnvTZw==
Date:   Fri, 25 Mar 2022 08:55:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20220325085522.731aee73@canb.auug.org.au>
In-Reply-To: <d1399c72-d729-58f8-ac63-1966f18c028d@redhat.com>
References: <20220301201659.45ac94cd@canb.auug.org.au>
        <20220324183329.22c97ea1@canb.auug.org.au>
        <2f33bdce-a002-708a-dd65-7bfb6ebc4cd9@redhat.com>
        <20220324222241.42896e9e@canb.auug.org.au>
        <d1399c72-d729-58f8-ac63-1966f18c028d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d2pIn8VVmMvajc.FXtfGtFb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d2pIn8VVmMvajc.FXtfGtFb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Thu, 24 Mar 2022 14:04:28 +0100 Hans de Goede <hdegoede@redhat.com> wrot=
e:
>
> So I did some digging and the trick for reproducing any ABI
> related warnings is to touch the .rst file which has the
> "kernel-abi" reST directive (1) for the ABI subdir you want
> to regenerate the ABI docs for.
>=20
> So in this case I did:
>=20
> touch Documentation/admin-guide/abi-testing.rst
> make htmldocs &> log

Looks like missing dependencies :-(

Thanks for persisting ad discovering this.

> And now I can see the warnings. I'll prepare a fix for this.

Excellent, thanks.

> Looking at Documentation/Makefile I also learned that you
> can also do this:
>=20
> scripts/get_abi.pl validate --dir Documentation/ABI
>=20
> Which results in a different set of warnings...

Wonderful :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/d2pIn8VVmMvajc.FXtfGtFb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI86MoACgkQAVBC80lX
0GyKiAgAjUEJU8gRaUeo8a8SuNzcZwJSxG/nuNCaeTSioc4cNZzUZv3lyd6ATwUL
8F8LsAJLfbsZVSLPLSpS73juJIBQFUbC4Jzubk+fKZwh9Fdq05Th9IERzOBMR5ML
fWjLQ+gWnbStalrlSMoiScg9pqjLMC37vQoMGL9pnzhdfJGs+kwN+Ew3jpJNWSQP
Jw9uMHDYBgsibGcnpBa1aK/i+j9DcDolcnZu1ZURu7Zs9WvEqUScg24UVUr5Nnsi
11zcs5qcIsqHoUeW8eV9RmmHJqKXKwQURNxLF8zaJovaR8FxSWeLM7RoMQ1+SFFI
El+DcGllweHdSGRb1+tt4xoYCxy29g==
=y9xf
-----END PGP SIGNATURE-----

--Sig_/d2pIn8VVmMvajc.FXtfGtFb--

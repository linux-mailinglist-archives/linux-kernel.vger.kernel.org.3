Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC54955A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377651AbiATUuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:50:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58670 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347268AbiATUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:50:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8277921976;
        Thu, 20 Jan 2022 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642711807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBe7F7L80y1kE1bJ6ANTakO8VFNQRdOQcpHkxfp8KNg=;
        b=uCs/RV08IDy/9GK/BVf4WncGKIDfO/AEtE798xyNUoimDSnUeg4KGRck5uO+JE3PDHk89w
        QRmSLbvR0k3XGAgm0P3Yy0MQb23ld75SjvYmyrYzlAi+dBCyuOCXB0TNXl9YNRyAq3tbTS
        3OGTQIyTPSQinpzrUfEdnIQft1ZTNX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642711807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBe7F7L80y1kE1bJ6ANTakO8VFNQRdOQcpHkxfp8KNg=;
        b=dE5oCXlatkoKsreWi1DJzMt4U21L2GtG3ykP1Qnv7DPpzUcZvcZViaD7LUesb2BuLws+sw
        Uz+/0lSqXbJ+K7Dg==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7704EA3B83;
        Thu, 20 Jan 2022 20:50:07 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 5EBDC603EF; Thu, 20 Jan 2022 21:50:07 +0100 (CET)
Date:   Thu, 20 Jan 2022 21:50:07 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] certs: Fix build error when CONFIG_MODULE_SIG_KEY is
 empty
Message-ID: <20220120205007.knmctn55c6o27rrk@lion.mk-sys.cz>
References: <20220120192205.525103-1-masahiroy@kernel.org>
 <20220120192205.525103-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pm366d4hbdqvhg2e"
Content-Disposition: inline
In-Reply-To: <20220120192205.525103-2-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pm366d4hbdqvhg2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2022 at 04:22:05AM +0900, Masahiro Yamada wrote:
> Since b8c96a6b466c ("certs: simplify $(srctree)/ handling and remove
> config_filename macro"), when CONFIG_MODULE_SIG_KEY is empty,
> signing_key.x509 fails to build:
>=20
>     CERT    certs/signing_key.x509
>   Usage: extract-cert <source> <dest>
>   make[1]: *** [certs/Makefile:78: certs/signing_key.x509] Error 2
>   make: *** [Makefile:1831: certs] Error 2
>=20
> Pass "" to the first argument of extract-cert to fix the build error.
>=20
> Link: https://lore.kernel.org/linux-kbuild/20220120094606.2skuyb26yjlnu66=
q@lion.mk-sys.cz/T/#u
> Fixes: b8c96a6b466c ("certs: simplify $(srctree)/ handling and remove con=
fig_filename macro")
> Reported-by: Michal Kubecek <mkubecek@suse.cz>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Michal Kubecek <mkubecek@suse.cz>

Thank you for the quick fix.

Michal

> ---
>=20
>  certs/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/certs/Makefile b/certs/Makefile
> index 0c459cfd09df..3ea7fe60823f 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -75,7 +75,7 @@ endif
>  $(obj)/system_certificates.o: $(obj)/signing_key.x509
> =20
>  $(obj)/signing_key.x509: $(X509_DEP) $(obj)/extract-cert FORCE
> -	$(call if_changed,extract_certs,$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG=
_KEY)))
> +	$(call if_changed,extract_certs,$(if $(CONFIG_MODULE_SIG_KEY),$(if $(X5=
09_DEP),$<,$(CONFIG_MODULE_SIG_KEY)),""))
>  endif # CONFIG_MODULE_SIG
> =20
>  targets +=3D signing_key.x509
> --=20
> 2.32.0
>=20

--pm366d4hbdqvhg2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmHpyvkACgkQ538sG/LR
dpUBUwf9HmPCa7g6UQtEC0lsbElABfDeg+iyFlfh3/2sXNVYUu17XRQho4lf9k6w
2DZP1/c1z3FNNptTXDLvEKxuyDaGWN0PKLbKtRSBK95MO4qXCh22iGpLrCj6sgj+
pVh2A3N2VN9tRC2TUVebMZTuY4xInRIDM6SR2vKCQhp4s9PSAxFSNQhrTFYs1S1k
t1O70jNya5Nc80ZhuZsb1C8s7osSnxny6TLG2CG4sQuxeBnA/NwANbY4c0F9A7c2
aVsw5Xpcwb4Z/Lt4ii7dk2A74oVGzUG46SfSs696wbMxkeXVv2TjpaxoSCK2rRLs
BPBj114e5qXeui20klIFKfFPFmdgkg==
=C1gV
-----END PGP SIGNATURE-----

--pm366d4hbdqvhg2e--

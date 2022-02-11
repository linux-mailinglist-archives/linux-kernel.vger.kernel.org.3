Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4B4B1B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbiBKBdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:33:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiBKBdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:33:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C685582;
        Thu, 10 Feb 2022 17:33:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jvx353l77z4xcl;
        Fri, 11 Feb 2022 12:33:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644543218;
        bh=KxLwMynRJ0UsoOel3fOo4xenJdot+JkG2dWXB0EDpxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=inpSJ5qE80eJDCLj0eze36lR4GEmHaV13FzR2trUww1s8BR+/g5p3YqKiberout75
         6E8b3N1cDHZdoBaJTt+dEtT2meG1qqFubvKvAKWzPn4zRmFw3bly5jWocKhkzZ5nVE
         MRQLhKSs9cq1PnVBJd407u1hOqAkKtISWXyl8uWLbeJ0UNkRU21QrYavk10LL0fbA6
         gL+x9tyNuQaXY0n/O9PKFpRBZwHViSdsJf9L1DLCEvyROYDyxGnwS/tpafUXb3mTO9
         +SLGpdFMj/Pp0RNKJwO1tH1WaW5OyDGq4twEbii1Ajp9uh9Fw0lN7b6gViC6I0Vpao
         153alyaWyGS2w==
Date:   Fri, 11 Feb 2022 12:33:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <20220211123336.54eff9de@canb.auug.org.au>
In-Reply-To: <YgWdbYfWgHP2jBmI@bombadil.infradead.org>
References: <20220210184340.7eba108a@canb.auug.org.au>
        <20220210193302.686fa61a@canb.auug.org.au>
        <20220210214125.2b248790@canb.auug.org.au>
        <20220210222953.6e078d20@canb.auug.org.au>
        <YgWdbYfWgHP2jBmI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g2ImcQNIuZLdtj/=NtqDINk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g2ImcQNIuZLdtj/=NtqDINk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Thu, 10 Feb 2022 15:19:09 -0800 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>=20
> FWIW Linus merged a more newer version of the regression fix, and only
> until today did we get that version on linux-next.
>=20
> > So it seems that the parent of "fs/binfmt_misc" is a permanently empty
> > directory - the is_empty_dir() check in insert_header() succeeds. =20
>=20
> I am not seeing this issue on x86_64 KVM guest with:
>=20
> CONFIG_BINFMT_MISC=3Dm
> or
> CONFIG_BINFMT_MISC=3Dy
>=20
> I think the issue might be that linux-next has Andrew's earlier
> version of the fix merged, and Linus now has the new version. So
> linux-next has these extra things below. But I can't understand
> why this is seen on ppc and not on x86_64.
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 241cfc6bc36f..788b9a34d5ab 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2735,17 +2735,6 @@ static struct ctl_table vm_table[] =3D {
>  	{ }
>  };
> =20
> -static struct ctl_table fs_table[] =3D {
> -#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
> -	{
> -		.procname	=3D "binfmt_misc",
> -		.mode		=3D 0555,
> -		.child		=3D sysctl_mount_point,
> -	},
> -#endif
> -	{ }
> -};
> -
>  static struct ctl_table debug_table[] =3D {
>  #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
>  	{
> @@ -2765,7 +2754,6 @@ static struct ctl_table dev_table[] =3D {
> =20
>  DECLARE_SYSCTL_BASE(kernel, kern_table);
>  DECLARE_SYSCTL_BASE(vm, vm_table);
> -DECLARE_SYSCTL_BASE(fs, fs_table);
>  DECLARE_SYSCTL_BASE(debug, debug_table);
>  DECLARE_SYSCTL_BASE(dev, dev_table);
> =20
> @@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
>  {
>  	register_sysctl_base(kernel);
>  	register_sysctl_base(vm);
> -	register_sysctl_base(fs);
>  	register_sysctl_base(debug);
>  	register_sysctl_base(dev);
> =20

Thanks for noticing that.  I have removed the old version from my copy
of mmotm today.

--=20
Cheers,
Stephen Rothwell

--Sig_/g2ImcQNIuZLdtj/=NtqDINk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIFvPAACgkQAVBC80lX
0Gwijgf/TBdDbcMhAB0z9NguKoO3pYzk1BqQws7Iu79AMgDt00akkM2gceMKpFuh
k8woqS8ESIDtrz4FjiU6sUh8pe4RVQg9Z0qLw0Ez6tRTNDmyLYqafrKLzuPytuM7
a0XtSXO/Vid1EX5jR4oAN0CJMVXS5S7lUOSNVI0arWkjIyblpL1fcWd8klzb6D8m
1dDI+NRnoFd78aNfEZt0rxJbUEs8zivqiLkxlfUpcWoPn2924UUIvWcNvvMZW8T3
hOU6RYI7g3zm3pleVBzvFETS5qktFdCq3jwlFkJDLWWXrAY8DQWaHqF4oKVfwfkM
zL0ZQYnAW/HZ3XzZQDqYX0e7ri7RZA==
=Fgbg
-----END PGP SIGNATURE-----

--Sig_/g2ImcQNIuZLdtj/=NtqDINk--

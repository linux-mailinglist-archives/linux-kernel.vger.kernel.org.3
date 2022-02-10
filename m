Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBE4B19B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbiBJXm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:42:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiBJXmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:42:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED3F54;
        Thu, 10 Feb 2022 15:42:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jvtb50Vstz4xNn;
        Fri, 11 Feb 2022 10:42:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644536561;
        bh=azW/yt8sUWT6gTQwL81zKupeCNHDKK7YvnJWUs8xLUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QHecK3bsh+C9Dnmv0ALFHnWVbMnIesZvzSBva1SJH0XdSNPXBJRtOdGWUtEDGcbvM
         lRfd0zvubx6Qjdu+ur+yXKVmxDClNrKzxzXBmJjeLESV0Eu9FORPsUffcgpMKXelQS
         lZ3obxI9qKEn7lWkG9jEpaEpbNwOwbtRIC6N7YhNrM/yDVHEK4LN/nyt2hB5I0eail
         zbAKVz8zgNGhH9Wz7Hi/cGd413lux+SWAfQaHdru75VoLmpxONGXsOQoa3Yz/WV8DE
         WltanRcAST4A/EmW0175ufowiV4jylAurD9t0lRrO9G5Pg06eyPNNUu2FH2tbBxvW8
         KmbRYKLuwoIzw==
Date:   Fri, 11 Feb 2022 10:42:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the btrfs tree (Was: Re:
 linux-next: build failure after merge of the kspp tree)
Message-ID: <20220211104238.5da77acd@canb.auug.org.au>
In-Reply-To: <20220125140730.GO14046@suse.cz>
References: <20220125115757.20bc45e8@canb.auug.org.au>
        <20220125140730.GO14046@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K1_v6gNgO/eBd5hOunmiQNW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K1_v6gNgO/eBd5hOunmiQNW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 25 Jan 2022 15:07:30 +0100 David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jan 25, 2022 at 11:57:57AM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the kspp tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > In file included from include/linux/string.h:253,
> >                  from include/linux/bitmap.h:11,
> >                  from include/linux/cpumask.h:12,
> >                  from arch/x86/include/asm/cpumask.h:5,
> >                  from arch/x86/include/asm/msr.h:11,
> >                  from arch/x86/include/asm/processor.h:22,
> >                  from arch/x86/include/asm/cpufeature.h:5,
> >                  from arch/x86/include/asm/thread_info.h:53,
> >                  from include/linux/thread_info.h:60,
> >                  from arch/x86/include/asm/preempt.h:7,
> >                  from include/linux/preempt.h:78,
> >                  from include/linux/spinlock.h:55,
> >                  from include/linux/wait.h:9,
> >                  from include/linux/mempool.h:8,
> >                  from include/linux/bio.h:8,
> >                  from fs/btrfs/ioctl.c:7:
> > In function 'fortify_memcpy_chk',
> >     inlined from 'btrfs_ioctl_encoded_write' at fs/btrfs/ioctl.c:5082:3:
> > include/linux/fortify-string.h:316:25: error: call to '__write_overflow=
_field' declared with attribute warning: detected write beyond size of fiel=
d (1st parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
> >   316 |                         __write_overflow_field(p_size_field, si=
ze);
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> > include/linux/fortify-string.h:324:25: error: call to '__read_overflow2=
_field' declared with attribute warning: detected read beyond size of field=
 (2nd parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
> >   324 |                         __read_overflow2_field(q_size_field, si=
ze);
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> > cc1: all warnings being treated as errors
> >=20
> > Caused by commit
> >=20
> >   602670289b69 ("fortify: Detect struct member overflows in memcpy() at=
 compile-time")
> >=20
> > interacting with commit
> >=20
> >   504e1ebb6316 ("btrfs: add BTRFS_IOC_ENCODED_WRITE")
> >=20
> > from the btrfs tree.
> >=20
> > I applied the following hack:
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 25 Jan 2022 11:47:17 +1100
> > Subject: [PATCH] fix up for "btrfs: add BTRFS_IOC_ENCODED_WRITE"
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  fs/btrfs/ioctl.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 73ad918a05a9..d34620034f8e 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -5079,9 +5079,14 @@ static int btrfs_ioctl_encoded_write(struct file=
 *file, void __user *argp,
> >  		}
> >  		args.iov =3D compat_ptr(args32.iov);
> >  		args.iovcnt =3D args32.iovcnt;
> > -		memcpy(&args.offset, &args32.offset,
> > -		       sizeof(args) -
> > -		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
> > +		args.offset =3D args32.offset;
> > +		args.flags =3D args32.flags;
> > +		args.len =3D args32.len;
> > +		args.unencoded_len =3D args32.unencoded_len;
> > +		args.unencoded_offset =3D args32.unencoded_offset;
> > +		args.compression =3D args32.compression;
> > +		args.encryption =3D args32.encryption;
> > +		memcpy(args.reserved, args32.reserved, sizeof(args.reserved));
> >  #else
> >  		return -ENOTTY;
> >  #endif =20
>=20
> Thanks, the patchset is still in progress so I'll apply this a fixup
> until the patch gets updated.

This has come back today ... presumably the hack was removed but the
original patch was not fixed.

I have used the btrfs tree from next-20220210 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/K1_v6gNgO/eBd5hOunmiQNW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIFou4ACgkQAVBC80lX
0Gxk6gf7BxTQqHx/UOgLQFzLaro274POyAZ/ZXhfAUhR8kYEBBkZlHaWK/h6g4Gf
S8MEsXqmtquR9/o8UfEA+0zIumFEIYEAGzETJ9sVz7YAMuwucL66PfmowMd0/cdy
d2jCmix6bPRR9zUb2GmG9n/mcNk+IMzhq5wjxgT4DvqcZLnvxVcFgvQv83EUthyg
JvZxZ60WnE5Dx7q/sSePA3BcvuQxAAPIoZyTHzOpcM61CdlI0jZCf7hfT3hpYQVa
INUrJh0CT7tWEgOj4vIRR6UsQLTd72KDFfMmy7BVpm+5pbzI51otyazggqmTpiVt
2PrZsYylwTuJmCjgpJZFEBubr6MswA==
=t7LW
-----END PGP SIGNATURE-----

--Sig_/K1_v6gNgO/eBd5hOunmiQNW--

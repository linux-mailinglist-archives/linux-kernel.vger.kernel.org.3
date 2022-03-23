Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4F4E5AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbiCWV6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiCWV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:58:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7BC8C7F6;
        Wed, 23 Mar 2022 14:57:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KP2J61wChz4xLS;
        Thu, 24 Mar 2022 08:56:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648072616;
        bh=aHjNgAelKfhb/Va6saAW8LUPIPUtnQVfHHfUW96Rbcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g50l42DT9yMIVNvdYTJu50LRH6z0Llc5/yEA7d1qmaOLGq3LSbXmBrCGnGsTDt6O9
         /4LBcY+fgAObFk4huYHlwH0NdzJlKjCLofjtORBmBPDTMLbSN2EPVG+Bkve51CPsBV
         DNr9RC3rSjDEhgM+kZK6BRRLzxiGh2urREQ7C3jpHdHmMdi91Wh3f3k8ksvQKDIAfG
         68uVkN2paIyVMCiNY4kJ1X54zNqTW7Gue6qMxyeU+Z+CX0jBHcE0TJdf71+B3rrxgP
         38haQqTz7vP6puFRMmAFRKgpNtXe5m9c2OvMns+XozMRBdUrX1Y3xN7dlmGLCw0g/B
         VvXXzR+NouNBg==
Date:   Thu, 24 Mar 2022 08:56:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard@nod.at>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: Re: linux-next: manual merge of the folio tree with the ubifs-fixes
 tree
Message-ID: <20220324085653.4c4c5315@canb.auug.org.au>
In-Reply-To: <20220315205259.71b4238a@canb.auug.org.au>
References: <20220315205259.71b4238a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q_PUoTablLrBmKKVQNFxoNY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q_PUoTablLrBmKKVQNFxoNY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 20:52:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the folio tree got a conflict in:
>=20
>   fs/ubifs/file.c
>=20
> between commit:
>=20
>   3b67db8a6ca8 ("ubifs: Fix to add refcount once page is set private")
>=20
> from the ubifs-fixes tree and commit:
>=20
>   c337f2f4f746 ("ubifs: Convert from invalidatepage to invalidate_folio")
>=20
> from the folio tree.
>=20
> I fixed it up (I hope - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
>=20
> diff --cc fs/ubifs/file.c
> index 6b45a037a047,8a9ffc2d4167..000000000000
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@@ -1304,8 -1304,8 +1304,8 @@@ static void ubifs_invalidate_folio(stru
>   		release_existing_page_budget(c);
>  =20
>   	atomic_long_dec(&c->dirty_pg_cnt);
> - 	detach_page_private(page);
> - 	ClearPageChecked(page);
>  -	folio_clear_private(folio);
> ++	folio_detach_private(folio);
> + 	folio_clear_checked(folio);
>   }
>  =20
>   int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasy=
nc)

This is now a conflict between the ubifs-fixes tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/q_PUoTablLrBmKKVQNFxoNY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI7l6UACgkQAVBC80lX
0GxFvAf+LdauYC4A5knBnbOVsqd46s2qnLxZbWMWwc+F8fgvwDk9H9qf1Jtqi58T
gADReIjUwZ0ZsURSItlRNJqVwFwwOJQu0bpG0A6T9mkCUoQcqPAVjZQ+ZiD6wb9y
HIWMwKApt3FSfHv8CZUuEJgVnJJx+76lVFrnm5v2FLVVQcny9zwAjvmzTaNhSWmg
I7pMGCv/x8LAwOA01RJPom7DZ+gxiF9UrPZmBYoXlP/5kk5VLx/dHBqD+nQ0xUU0
XOFm7TZNGKUCpdxHmGiiHBPlq+a58qdojpbQpMesaWrqjdYnIUSV5BxBfwsY1m84
qRL+FhP/LIkpe67uGj2lsKhUl/t3Lg==
=E4Zl
-----END PGP SIGNATURE-----

--Sig_/q_PUoTablLrBmKKVQNFxoNY--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD747EB13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 05:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351233AbhLXELF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 23:11:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:59527 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbhLXELE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 23:11:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKtsL1VPMz4xgr;
        Fri, 24 Dec 2021 15:11:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640319062;
        bh=wSyVyz5FBNDlPu0quD9cfNONAVyr9hVDfj3L9iuRy1A=;
        h=Date:From:To:Cc:Subject:From;
        b=fHm6m5G9PwaBd7ZZwJ51fdwoVH42Z/qDAhk68iESlV/tdwZb7/IZuTUvb/7lOAh0L
         rZ1azt53ZthUDc1fBv3BGI/BAZPUiF6Q+/pMbCccCuBWVb0HGr3osQ1xf2U6NOi1mo
         Cz9XT07tEwc8wH0GZU6SyXEuZOZEFWmknns/F2QJSztCaqjcixX+GW88pn4gXq5Sc0
         bFpW6IKtOwNhEjk106hhAfmy9EpCfamShmsn2MkEj1GSlgu7O2HyWx//3pqT9a1RDc
         Ug74fkfW3zGiObBPFfigu+SYJr79jPwTZ3Bfpg515aVlWIDZowWjoAlhfDFdWtyN0X
         Y2RnJKaIhebMw==
Date:   Fri, 24 Dec 2021 15:11:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mike Christie <michael.christie@oracle.com>
Subject: linux-next: manual merge of the userns tree with the vhost tree
Message-ID: <20211224151101.5e56b7b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2rxGSefMHPvDSO0UYw0i8b.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2rxGSefMHPvDSO0UYw0i8b.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  kernel/fork.c

between commit:

  d109de6eb40d ("fork/vm: Move common PF_IO_WORKER behavior to new flag")

from the vhost tree and commit:

  329b30af470a ("kthread: Generalize pf_io_worker so it can point to struct=
 kthread")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/fork.c
index e3e7150bcb1a,6f0293cb29c9..000000000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -2012,15 -2032,6 +2012,9 @@@ static __latent_entropy struct task_str
  		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
  	}
 =20
 +	if (args->worker_flags & USER_WORKER)
 +		p->flags |=3D PF_USER_WORKER;
 +
- 	/*
- 	 * This _must_ happen before we call free_task(), i.e. before we jump
- 	 * to any of the bad_fork_* labels. This is to avoid freeing
- 	 * p->set_child_tid which is (ab)used as a kthread's data pointer for
- 	 * kernel threads (PF_KTHREAD).
- 	 */
  	p->set_child_tid =3D (clone_flags & CLONE_CHILD_SETTID) ? args->child_ti=
d : NULL;
  	/*
  	 * Clear TID on mm_release()?

--Sig_/2rxGSefMHPvDSO0UYw0i8b.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFSFUACgkQAVBC80lX
0GwgwQf/amtUYFE/0Danh7EY5KFcR9RQghIT9qpICydVBy93p8QL1hULNCYLfVLy
ImB4wo6qlZvqIsIhkpuPlZAAV5NgAGYxsL6VQBKpLl+2hhXVvG/svVTLwpIfFRfb
uiKaxCXo5uDplUuFa81M4f22hgvY8gj8mtmc0M0e9RJRMTMOj6SZi+5wi0giZ1RN
dJ3hnigp4myZ8pg/1UMfBXjV8hlEypFGj939qfqEJVO+49LEt9wt9tJHZRAteG5r
SE7KyuWGEWSBxcfyyaxGjqUHH5HnbNgEtKmF3AvZ4D5oeUylevTXuGMGouRfDqR+
cJOcIVnjOUS83NxLjPHgrS0uVzUddg==
=6xhG
-----END PGP SIGNATURE-----

--Sig_/2rxGSefMHPvDSO0UYw0i8b.--

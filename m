Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8476B47ECD0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbhLXHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhLXHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:45:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D840FC061401;
        Thu, 23 Dec 2021 23:45:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKzcd1rT3z4xZ1;
        Fri, 24 Dec 2021 18:45:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640331921;
        bh=vRzgZOEbPeMdEI5ydoYq3Dx46rAUSpzZcddztszbPjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ajUTf6KkegOTrpfoBJGnK+3pA+myFUOE+fLgnUmRMZP6e9yaN4IRdJADjEPg7HAx8
         XniUBjclhA1Y2YdQ4Utx7BGEgBGrg+VEY472yVdpbK7cd+qNg7tPE/4WZju+ix0BI0
         RrXemUzqJLc5mjE1pxY8DpXEcJ2TYo//dE9VtIgPF53kLbFGU7GCZDnEVDiFi/0gjY
         s6eDwJ5Rp00ZY7WEdzK2WfM1JAH154PHsP9/vt3oiefyf/DTdunmSDlKQm+Xi1ybQn
         k26TILSbqwInAGH9t0gBre08J9COSKVRFJ//zYlupo4ninETCNNV15SU09wmdbOlcg
         CPyQmB0Ye35SA==
Date:   Fri, 24 Dec 2021 18:45:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 userns tree
Message-ID: <20211224184520.157a0660@canb.auug.org.au>
In-Reply-To: <20211221220734.16e36bdf@canb.auug.org.au>
References: <20211221220734.16e36bdf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w.KJ5Xme_=_jTrEZ_lpN5h_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w.KJ5Xme_=_jTrEZ_lpN5h_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 21 Dec 2021 22:07:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got conflicts in:
>=20
>   include/linux/kthread.h
>   kernel/kthread.c
>=20
> between commit:
>=20
>   40966e316f86 ("kthread: Ensure struct kthread is present for all kthrea=
ds")
>=20
> from the userns tree and commit:
>=20
>   1ac41b3d9ad8 ("kthread: dynamically allocate memory to store kthread's =
full name")
>=20
> from the akpm-current tree.

With the addition of commit

  329b30af470a ("kthread: Generalize pf_io_worker so it can point to struct=
 kthread")

to the userns tree, the resolution is now as below.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/kthread.c
index 261a3c3b9c6c,8be710f2d83d..000000000000
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@@ -94,7 -95,19 +96,19 @@@ static inline struct kthread *__to_kthr
  	return kthread;
  }
 =20
+ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
+ {
+ 	struct kthread *kthread =3D to_kthread(tsk);
+=20
+ 	if (!kthread || !kthread->full_name) {
+ 		__get_task_comm(buf, buf_size, tsk);
+ 		return;
+ 	}
+=20
+ 	strscpy_pad(buf, kthread->full_name, buf_size);
+ }
+=20
 -void set_kthread_struct(struct task_struct *p)
 +bool set_kthread_struct(struct task_struct *p)
  {
  	struct kthread *kthread;
 =20
@@@ -118,13 -128,17 +132,17 @@@ void free_kthread_struct(struct task_st
  	struct kthread *kthread;
 =20
  	/*
 -	 * Can be NULL if this kthread was created by kernel_thread()
 -	 * or if kmalloc() in kthread() failed.
 +	 * Can be NULL if kmalloc() in set_kthread_struct() failed.
  	 */
  	kthread =3D to_kthread(k);
+ 	if (!kthread)
+ 		return;
+=20
  #ifdef CONFIG_BLK_CGROUP
- 	WARN_ON_ONCE(kthread && kthread->blkcg_css);
+ 	WARN_ON_ONCE(kthread->blkcg_css);
  #endif
 +	k->worker_private =3D NULL;
+ 	kfree(kthread->full_name);
  	kfree(kthread);
  }
 =20

--Sig_/w.KJ5Xme_=_jTrEZ_lpN5h_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFepAACgkQAVBC80lX
0Gyntwf/Sv6+N4PaXfLtGqYguX9GDW5tNZOMF5txNYKk+UzZVkRAIW/TttFN7P+l
FPm/CIyTf6Uya2uXBSSjebU1X7FsqXof9z1qjVhI76LSMg77Cd2feoQzzmucJm4l
e9J1NrTvjUk53Dpi3nqY21IdzZP+0IXk9wZkogORDmpSMXydbhX/Xu4LS5U9rHgS
JYRxkAAQsDJtluS/psS+rHZaUxxQUcFxxpo/CoLN/X+YSG6OHtQM4f374Gu29Kt2
gEeQ9RVWIlsWG3noPkFVFl70kSNLkMuATzUdutnRSQiSi5eSv7qEansCFZMLeMDt
0dlv/Za6LU+YqnY5il+VQLfcKEG8Rg==
=A3tV
-----END PGP SIGNATURE-----

--Sig_/w.KJ5Xme_=_jTrEZ_lpN5h_--

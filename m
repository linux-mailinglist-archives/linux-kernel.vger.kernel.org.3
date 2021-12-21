Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A1947BE93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhLULHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhLULHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:07:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D1C06173F;
        Tue, 21 Dec 2021 03:07:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJDFP69FHz4xgt;
        Tue, 21 Dec 2021 22:07:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640084858;
        bh=sGwUVGMYmfSOoq7kl7vDs2DU8f7u457UNrYrWsnc7cI=;
        h=Date:From:To:Cc:Subject:From;
        b=GBeMZgtBF1Ft8aaYUK9ZHz1PCA/BuMMlMIXe1CB+qAraH9eWDGytnzFDHvZrEifYE
         3xx+NaZPvwmClY3RfkRs6xtrPLlhYgdJgdqZQq3ju0e4iPQUcApm/y2g8tFJS7YyaO
         39dCcedc5yaOPL9R/smS8At/hzLOGuX53CGrHgOlOxFyGp3NYcmv5PnZ0CeUJlaNM+
         htXChcCt193YQrJhkMD+l3mVMWvsLDFubLh0ANohPfe4YGOI23QzBtPxo70PZEEbZ9
         1jQx1kenazBsZt9bts8EAaBuk9PEw8o0yvfA6bJmqzAySqYt9FiGp8ReYbZVW5zcYZ
         FrKXvdL8brhHw==
Date:   Tue, 21 Dec 2021 22:07:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the userns
 tree
Message-ID: <20211221220734.16e36bdf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zy9E67.wwSzBvkVnKa=+TMT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zy9E67.wwSzBvkVnKa=+TMT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got conflicts in:

  include/linux/kthread.h
  kernel/kthread.c

between commit:

  40966e316f86 ("kthread: Ensure struct kthread is present for all kthreads=
")

from the userns tree and commit:

  1ac41b3d9ad8 ("kthread: dynamically allocate memory to store kthread's fu=
ll name")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/kthread.h
index 4f3433afb54b,a1810374eaa9..000000000000
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@@ -33,7 -33,8 +33,8 @@@ struct task_struct *kthread_create_on_c
  					  unsigned int cpu,
  					  const char *namefmt);
 =20
+ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk=
);
 -void set_kthread_struct(struct task_struct *p);
 +bool set_kthread_struct(struct task_struct *p);
 =20
  void kthread_set_per_cpu(struct task_struct *k, int cpu);
  bool kthread_is_per_cpu(struct task_struct *k);
diff --cc kernel/kthread.c
index c14707d15341,8be710f2d83d..000000000000
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
@@@ -122,13 -128,17 +136,17 @@@ void free_kthread_struct(struct task_st
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
 +	k->set_child_tid =3D (__force void __user *)NULL;
+ 	kfree(kthread->full_name);
  	kfree(kthread);
  }
 =20

--Sig_/zy9E67.wwSzBvkVnKa=+TMT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHBtXYACgkQAVBC80lX
0Gybugf/QCb63It2JBJC7x3/0T9JyLC8vuGTK+1+oDDMZ6O+jSRqqTd8XOjcP7FN
aCqGpu0eKvnS7XfyJzebP+OrzWXvOqKsfOHR4dfBqitrqBUE2Dc1zNS3i8+UfqYJ
dphfXJHDrPR+K2Ty3L7UcHb0M9kf7yC5RWouHEyBeLuZj0ds/P15losPo204CdUg
37pfwcpxgj3Z7fMLecbxp52yF8ZeqHJcGMb4B6TbZwMIyEN71pPQlSV4QMQwKhV8
ArjwL7v7nK1qbu7CU5Evt4nH9UlcCGqhIbSPrW2oELoixbcApJcVaXaDPUyQo6I6
ZcNY1uEgVC3oPg9jnz6Rx3uQxk+o4A==
=jh07
-----END PGP SIGNATURE-----

--Sig_/zy9E67.wwSzBvkVnKa=+TMT--

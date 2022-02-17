Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3992A4B99A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiBQHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:11:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbiBQHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:11:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB941082;
        Wed, 16 Feb 2022 23:11:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzmG64LdZz4xNq;
        Thu, 17 Feb 2022 18:11:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645081886;
        bh=knr5RP7jO6NuuhlrZBzG1Zyk0G91nMtqAcJPvFJy+TQ=;
        h=Date:From:To:Cc:Subject:From;
        b=X+ZfwMIK5sQGVJsTJza3TwEB03lVe66wSrGVsX9KfXLRCfc7hCvX9zIQ0oNr1ev9i
         A+jJmeva5LVNGR6ZFli9Ae9fBgE1DW95CaoDVuzTCGe3Ofd0Xswbsx7BkO1KWiftFA
         HT+lf9gXWuAGOgIR2WWOvjrq3uYr7zJ8OzIsqBAVZnWmIs+Ya/rd8qO9y6ayNy1SSS
         rL5/OVgwfMIB8FRSFtzYrRu616ZqzWl3Y9dMfqe6N9VSC5Sj6qDGRzWgHa6NIXRfze
         ke/E119QOsK07hTRua05jwapUcCMB2k7bh6mIhYykGtZXfSuwlrwgYqdaHfn7A4FQ+
         opEXmOUJJWFmQ==
Date:   Thu, 17 Feb 2022 18:11:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the maple tree
Message-ID: <20220217181125.138b7340@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/91KVv/kXvKiRuucoKcLnV7H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/91KVv/kXvKiRuucoKcLnV7H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  mm/mmap.c

between commit:

  b09e8361a4c3 ("mm: Remove the vma linked list")

from the maple tree and commit:

  ad56e23dec9a ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")

from the folio tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/mmap.c
index 1b3600152f6f,64b5985b5295..000000000000
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@@ -3116,30 -3132,13 +3112,19 @@@ void exit_mmap(struct mm_struct *mm
  		set_bit(MMF_OOM_SKIP, &mm->flags);
  	}
 =20
 -	mmap_write_lock(mm);
 +	/*
 +	 * Actually taking the mmap semaphore here costs 3% performance on
 +	 * a large machine:
 +	 * https://lore.kernel.org/lkml/20170725151754.3txp44a2kbffsxdg@node.shu=
temov.name/
 +	 * Lockdep will complain about not holding the mmap_lock, so we lie.
 +	 */
 +	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
- 	if (mm->locked_vm) {
- 		mas_for_each(&mas, vma, ULONG_MAX) {
- 			if (vma->vm_flags & VM_LOCKED) {
- 				mm->locked_vm -=3D vma_pages(vma);
- 				munlock_vma_pages_all(vma);
- 			}
- 		}
- 		mas_set(&mas, 0);
- 	}
-=20
  	arch_exit_mmap(mm);
 =20
 -	vma =3D mm->mmap;
 +	vma =3D mas_find(&mas, ULONG_MAX);
  	if (!vma) {
  		/* Can happen if dup_mmap() received an OOM */
 -		mmap_write_unlock(mm);
 +		rwsem_release(&mm->mmap_lock.dep_map, _THIS_IP_);
  		return;
  	}
 =20

--Sig_/91KVv/kXvKiRuucoKcLnV7H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN9R0ACgkQAVBC80lX
0GxtSAf9H1TiK5hLB+eFD34NPoDnEmWlLokriU/nYoUnyNhvfDJi1UuTb4Ti21Ai
kmundy9JSU1dGXuI6wfc7EMauSaNfBKv/j9iz3th+5Gr9sBFdEJR/UVVzfg7OYZ7
/fDhqH5x2we7h29NJTCD1NMMmYpT7Mprvk1cqEgl048vlc+VG6N15NzKVOTVJ/mq
EvJDuVDSrKP/tSqZSVUDET7NkZb/tbZQBhxo5gdO/ge7WNRGqFSBpwrWl8JGcI42
DGlyDoVgzeXWqv6zDgCj+lDVY4lLFITMcwkdwgDR762cHCtsaGvMTUH5CrquQYiI
03zyCt5uEHRfrYTZmtUWjpaAJNEBxg==
=Fy4s
-----END PGP SIGNATURE-----

--Sig_/91KVv/kXvKiRuucoKcLnV7H--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90395581021
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiGZJl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiGZJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:41:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645DC2B1BA;
        Tue, 26 Jul 2022 02:41:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsX4J0bfgz4x1Y;
        Tue, 26 Jul 2022 19:41:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658828512;
        bh=ygRCt1IcR9dgCBW8HqFsp65TP2lPDKejFwY2ek3UuD8=;
        h=Date:From:To:Cc:Subject:From;
        b=gB2ugTuBA+zAYZ/5PIX98Y8JipGaubNUPvB1U7cXQzjHTdKgpGhoOQse7k900Io7A
         kOY087Xw4pE/0hBm5RAqYLXM/71tIjubZbHXPwVT70uuJWchG7FeWmrB3viyKY+lBm
         ruaa+vNyFd33FzZpAvw0GMd2QL/S1/8qm7SnYhlxzrQGr66xS4RLUgLKVHK3G3+tzJ
         pfOYB4iXWShQBPVDhif0StgJ7s2Wa/moVDKZACkVSc6qwu6TVrPKeceBkQlCDhntnH
         FsXCSQDIPGik+h8ICkNBqiCM+sYjIy6RdWc26OxryLksgSiVw+UQPJ0eGPnHL1lkEQ
         BxtIvWz4BeqXw==
Date:   Tue, 26 Jul 2022 19:41:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: linux-next: manual merge of the mm-nonmm-stable tree with the
 bitmap tree
Message-ID: <20220726194151.71e511e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PiSrXluymVVHYF30g8.HKEm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PiSrXluymVVHYF30g8.HKEm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-nonmm-stable tree got a conflict in:

  lib/Makefile

between commit:

  e0281efe11c9 ("lib/nodemask: inline next_node_in() and node_random()")

from the bitmap tree and commit:

  b81dce77cedc ("cpumask: Fix invalid uniprocessor mask assumption")

from the mm-nonmm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/Makefile
index 90d02a0986e9,de3e47453fe8..000000000000
--- a/lib/Makefile
+++ b/lib/Makefile
@@@ -33,11 -33,10 +33,10 @@@ lib-y :=3D ctype.o string.o vsprintf.o cm
  	 flex_proportions.o ratelimit.o show_mem.o \
  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 -	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
 +	 nmi_backtrace.o win_minmax.o memcat_p.o \
- 	 buildid.o
+ 	 buildid.o cpumask.o
 =20
  lib-$(CONFIG_PRINTK) +=3D dump_stack.o
- lib-$(CONFIG_SMP) +=3D cpumask.o
 =20
  lib-y	+=3D kobject.o klist.o
  obj-y	+=3D lockref.o

--Sig_/PiSrXluymVVHYF30g8.HKEm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLftt8ACgkQAVBC80lX
0GyiLgf/UTGQVDjVG5pL3te+G7bkYx0qM3da+lxhFURfY4N9Fdsmu5adCLfwsM/K
7Jj1TqDJx8KFkW/BUBaHyar7jBrHvhtG/lKVNNUx/ANkhzYhVCxLg5Z7dr3U6UUP
+xrbkIeVFRrzp9Ufn/oQBjUXwG1CJ2YKfZKqcchtQkH7sjQBtd8Dcq08g+/VTGCI
QLJJ1ebMseEJV7eJPZkB2hKGk/DfvQH0spRfI0doVK9uDp0ADtOeegHn4FkoiLJD
NkI0MBMAqBu3DlPaqRPpf7nE8aJLcYUaomBViKVxVHyItLidjQOqHG+nUCZuZLmH
1jpNgNgRs2JhbHZUN6Mvtb5lhL1rHw==
=BnVo
-----END PGP SIGNATURE-----

--Sig_/PiSrXluymVVHYF30g8.HKEm--

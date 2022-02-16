Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A44B8053
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbiBPFjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:39:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBPFjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:39:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC5BB0AD;
        Tue, 15 Feb 2022 21:38:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jz6Fc4W95z4xcl;
        Wed, 16 Feb 2022 16:38:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644989926;
        bh=dYPjtCeRuoZsilIwQN5iPJw6Z/a+raiWjMK5T5Ra708=;
        h=Date:From:To:Cc:Subject:From;
        b=qttjlqgPbNvvyqf9w/l3y0XzTetYrJfMTuShi/emEjpMLo+31WvBpKki9waqEXYDC
         Qx/CMmuXFdTi2Wfdzo5fZZNdsj6Q23AjyU7ANB6wTsHUKk9PyPNKR27eK0v/sfZNeb
         R530qmJ2aqMFLxslMgrYHHQi/ZDW7wNFp+sQCzgsgnn3p+omVm5jlBLm7vaFY9bGpX
         oBxlHyGMDqyARZuYcPWroMAmUE39Os/zLOgPbhPHJBVTF1EtCBIpI7KKCbCHfSt7KU
         hnZbB/iTlvP5TnDiL7HQ695uiw3F4UgymHIwGK3B9laqnEN2SM5R7YMdb1AeskfvLl
         1n4whylYoACEQ==
Date:   Wed, 16 Feb 2022 16:38:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the akpm-current tree with the tip tree
Message-ID: <20220216163843.5293ff58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+D4MrK85CR90.IYz61zptjj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+D4MrK85CR90.IYz61zptjj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  Documentation/admin-guide/sysctl/kernel.rst

between commit:

  3624ba7b5e2a ("sched/numa-balancing: Move some document to make it consis=
tent with the code")

from the tip tree and commit:

  2dc52f4f86f9 ("NUMA balancing: optimize page placement for memory tiering=
 system")

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

diff --cc Documentation/admin-guide/sysctl/kernel.rst
index 8551aeca1574,59c3b4ce37cd..000000000000
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@@ -609,8 -616,56 +616,14 @@@ being accessed should be migrated to a=20
  The unmapping of pages and trapping faults incur additional overhead that
  ideally is offset by improved memory locality but there is no universal
  guarantee. If the target workload is already bound to NUMA nodes then this
 -feature should be disabled. Otherwise, if the system overhead from the
 -feature is too high then the rate the kernel samples for NUMA hinting
 -faults may be controlled by the `numa_balancing_scan_period_min_ms,
 -numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
 -numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
 +feature should be disabled.
 =20
+ Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
+ different types of memory (represented as different NUMA nodes) to
+ place the hot pages in the fast memory.  This is implemented based on
+ unmapping and page fault too.
 -
 -numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_bal=
ancing_scan_period_max_ms, numa_balancing_scan_size_mb
 -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 -
 -
 -Automatic NUMA balancing scans tasks address space and unmaps pages to
 -detect if pages are properly placed or if the data should be migrated to a
 -memory node local to where the task is running.  Every "scan delay" the t=
ask
 -scans the next "scan size" number of pages in its address space. When the
 -end of the address space is reached the scanner restarts from the beginni=
ng.
 -
 -In combination, the "scan delay" and "scan size" determine the scan rate.
 -When "scan delay" decreases, the scan rate increases.  The scan delay and
 -hence the scan rate of every task is adaptive and depends on historical
 -behaviour. If pages are properly placed then the scan delay increases,
 -otherwise the scan delay decreases.  The "scan size" is not adaptive but
 -the higher the "scan size", the higher the scan rate.
 -
 -Higher scan rates incur higher system overhead as page faults must be
 -trapped and potentially data must be migrated. However, the higher the sc=
an
 -rate, the more quickly a tasks memory is migrated to a local node if the
 -workload pattern changes and minimises performance impact due to remote
 -memory accesses. These sysctls control the thresholds for scan delays and
 -the number of pages scanned.
 -
 -``numa_balancing_scan_period_min_ms`` is the minimum time in milliseconds=
 to
 -scan a tasks virtual memory. It effectively controls the maximum scanning
 -rate for each task.
 -
 -``numa_balancing_scan_delay_ms`` is the starting "scan delay" used for a =
task
 -when it initially forks.
 -
 -``numa_balancing_scan_period_max_ms`` is the maximum time in milliseconds=
 to
 -scan a tasks virtual memory. It effectively controls the minimum scanning
 -rate for each task.
 -
 -``numa_balancing_scan_size_mb`` is how many megabytes worth of pages are
 -scanned for a given scan.
+=20
+=20
  oops_all_cpu_backtrace
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =20

--Sig_/+D4MrK85CR90.IYz61zptjj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMjeMACgkQAVBC80lX
0GwKqwf/fR+BJILM/wGXW4ZPsFE8d5XuiuDvYoAMxyW7wsNfFe7mTxB5iAGDGqr2
2NMk+bP0gxF28oS0qJxWRjHA7BaRwb879uNapPHyitg9Sql3K6s12lUND/D/gX5P
SzxaX0pBxWiQp2XGDoBY85kFN3xmOUxE5FZVkpW0naXP5Tq2qMW39Akx9BguLiA4
Lm9iFfyEdHNiui3eT848/rn9/mTs8cBUzrzqJNlT1z79DH2ezfSbKwby91hplZpR
O63o5QjW7mABhKOauZ3m0WCNTmJPF0yIYYOJFEYCh5cpWtvVhmS/ZTaTTWXpW+I0
8eS1FGqSaX1qA/NOcQFT2L4uHOyduA==
=fvfZ
-----END PGP SIGNATURE-----

--Sig_/+D4MrK85CR90.IYz61zptjj--

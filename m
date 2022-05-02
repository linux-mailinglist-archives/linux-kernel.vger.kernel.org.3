Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D84516E62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384642AbiEBKwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384582AbiEBKwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:52:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58CB1B6;
        Mon,  2 May 2022 03:49:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsKb603ntz4xdK;
        Mon,  2 May 2022 20:49:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651488546;
        bh=Qin3clB8EKdwJwy5QZOYM8XR5Qx9CNnFDTHRGLBe1+A=;
        h=Date:From:To:Cc:Subject:From;
        b=U7Xt4Vgb9yA6inQ7E+PH+Bp5NLIQrJ1elwiypHGePkoWWxW52UXoGkAtMY59vN34j
         Famoc9VbX0Th76ygMlPoHJy1ckn8BPhPCpBBaDK4jlti9hKsEHYTBXnj0ACrXDuHH3
         Gi49doHUzp3v9iMpZOQoV+RWWcgjfIno/X52L3yE66ZnRxDk2gnG/bl963bgsMitYl
         xyVr/m/7W3kowW0VxJOQdJjQUAT2EVZ798/P4RSjhBmbaulEBFgKjKp4kIrnTvqsta
         EuAm8HAN+aVA6oEBqzxXRuheR1JnqZUgqgAnstWAgZk4zf69VRTKK/t0xARvKUs2go
         FmuivK38f2ctw==
Date:   Mon, 2 May 2022 20:49:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220502204903.64e94442@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ad1p+TVqUiLDL1ymLLms_.1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ad1p+TVqUiLDL1ymLLms_.1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from <command-line>:
mm/shmem.c: In function 'shmem_add_to_page_cache.constprop':
include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert=
_267' declared with attribute error: BUILD_BUG failed
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:333:25: note: in definition of macro '__comp=
iletime_assert'
  333 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_=
MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
include/linux/vm_event_item.h:147:27: note: in expansion of macro 'BUILD_BU=
G'
  147 | #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
      |                           ^~~~~~~~~
mm/shmem.c:743:40: note: in expansion of macro 'THP_FILE_ALLOC'
  743 |                         count_vm_event(THP_FILE_ALLOC);
      |                                        ^~~~~~~~~~~~~~
In file included from include/linux/math64.h:6,
                 from include/linux/time64.h:5,
                 from include/linux/restart_block.h:10,
                 from include/linux/thread_info.h:14,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/arm/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from mm/shmem.c:24:
mm/shmem.c: In function 'shmem_getpage_gfp.constprop':
include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert=
_275' declared with attribute error: BUILD_BUG failed
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/math.h:15:46: note: in definition of macro '__round_mask'
   15 | #define __round_mask(x, y) ((__typeof__(x))((y)-1))
      |                                              ^
mm/shmem.c:1892:26: note: in expansion of macro 'round_down'
 1892 |                 hindex =3D round_down(index, HPAGE_PMD_NR);
      |                          ^~~~~~~~~~
include/linux/compiler_types.h:340:9: note: in expansion of macro '__compil=
etime_assert'
  340 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^~~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_=
MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
include/linux/huge_mm.h:307:28: note: in expansion of macro 'BUILD_BUG'
  307 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
include/linux/huge_mm.h:105:26: note: in expansion of macro 'HPAGE_PMD_SHIF=
T'
  105 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
include/linux/huge_mm.h:106:26: note: in expansion of macro 'HPAGE_PMD_ORDE=
R'
  106 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
      |                          ^~~~~~~~~~~~~~~
mm/shmem.c:1892:44: note: in expansion of macro 'HPAGE_PMD_NR'
 1892 |                 hindex =3D round_down(index, HPAGE_PMD_NR);
      |                                            ^~~~~~~~~~~~
In file included from <command-line>:
include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert=
_276' declared with attribute error: BUILD_BUG failed
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:333:25: note: in definition of macro '__comp=
iletime_assert'
  333 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_=
MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
include/linux/huge_mm.h:307:28: note: in expansion of macro 'BUILD_BUG'
  307 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
include/linux/huge_mm.h:105:26: note: in expansion of macro 'HPAGE_PMD_SHIF=
T'
  105 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
include/linux/huge_mm.h:106:26: note: in expansion of macro 'HPAGE_PMD_ORDE=
R'
  106 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
      |                          ^~~~~~~~~~~~~~~
mm/shmem.c:1915:34: note: in expansion of macro 'HPAGE_PMD_NR'
 1915 |                         hindex + HPAGE_PMD_NR - 1) {
      |                                  ^~~~~~~~~~~~
In file included from <command-line>:
In function 'can_split_folio',
    inlined from 'shrink_page_list' at mm/vmscan.c:1719:11:
include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert=
_195' declared with attribute error: BUILD_BUG failed
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:333:25: note: in definition of macro '__comp=
iletime_assert'
  333 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_=
MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
include/linux/huge_mm.h:351:9: note: in expansion of macro 'BUILD_BUG'
  351 |         BUILD_BUG();
      |         ^~~~~~~~~

Reverting the following commits makes the problem go away:

  2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_foli=
o()")
  94cdf3e8c0bf ("mm/shmem: convert shmem_getpage_gfp to use a folio")
  3674fd6cadf5 ("mm/shmem: convert shmem_alloc_and_acct_page to use a folio=
")
  b0bb08b2d5f3 ("mm/shmem: turn shmem_alloc_page() into shmem_alloc_folio()=
")
  8d657a77c6fe ("mm/shmem: turn shmem_should_replace_page into shmem_should=
_replace_folio")
  9a44f3462edc ("mm/shmem: convert shmem_add_to_page_cache to take a folio")
  561fd8bee1dc ("mm/swap: add folio_throttle_swaprate")
  cb4e56ee240d ("mm/shmem: use a folio in shmem_unused_huge_shrink")
  22bf1b68e572 ("vmscan: remove remaining uses of page in shrink_page_list")
  7d15d41b7c4a ("vmscan: convert the activate_locked portion of shrink_page=
_list to folios")
  8a6aff9c51c7 ("vmscan: move initialisation of mapping down")
  b79338b3d217 ("vmscan: convert lazy freeing to folios")
  719426e40146 ("vmscan: convert page buffer handling to use folios")
  339ba7502e13 ("vmscan: convert dirty page handling to folios")

--=20
Cheers,
Stephen Rothwell

--Sig_/ad1p+TVqUiLDL1ymLLms_.1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvtx8ACgkQAVBC80lX
0Gzhewf/bSibuH23I0UsCOQb6rP2cPCDTuTvmdGlY2VYC6CFW4nDpcNtEetIe24U
MUK9t5cLY9xYsAop/SCfwFSqz0yJ79OiIKwhbTqERQjBQ95/PEg4UfL81+KdN4NP
VU+vzC/FDkaf2hwLjbbk3R1LdiLaGV5zyBEnmLCkRjthUJksM8LJMqr0yluLgRtf
+LTK9YogL9kQBrX4fYC5FUSwjlxOXzJAlOWHrS9u8MREcTtUpz7/w784VyhzRxL8
owIQkNCEoCP0bZG0yP+DotVECJFW7DQQfOUMVDJlwIc6RFS6oeSKvD85DYDuSeD2
qGE1EPx3ckzsccsXXY4he86ydScw6A==
=Ao7f
-----END PGP SIGNATURE-----

--Sig_/ad1p+TVqUiLDL1ymLLms_.1--

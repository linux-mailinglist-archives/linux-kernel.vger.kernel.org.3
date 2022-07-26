Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B315811DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiGZLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiGZLXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:23:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391623191E;
        Tue, 26 Jul 2022 04:23:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsZKn4BDJz4xD9;
        Tue, 26 Jul 2022 21:23:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658834621;
        bh=9mO5/KjxQfzR1tvgHLPVBpv7rqJ1xhxYd9fnJcY95lM=;
        h=Date:From:To:Cc:Subject:From;
        b=Z4lhHfv+ODqesMBz94cec2dAVR9kpTJpdmX/cHux3vpZFI/QK53xVusJT5zcGFFzq
         j+aHvxqgaFJFiaRSaObQy25SVunU0qzgXeo48/ZPAVDVEa04zj5KClqLG40uhDzWqM
         EFKGRQXSCu650/FbpLaLlyNJKK6vk+M/bbLXy4TRc+DcLJD56N1BybAJmXfmRKpI1g
         rpixzU6JMPxNNLWGMTZpeah/G+qzb+mdb5ik/7O78Mwj294sWa8J5QB7CH3l2PxJF9
         Hg1M0jIk+xVEgSFsyUaM2YV/8xKiqnPA+ro71znWgIDkjW246N7tUK4WoDJ5Kz1rEv
         a2O9Kj13uBtOg==
Date:   Tue, 26 Jul 2022 21:23:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: run time warning after merge of the mm tree
Message-ID: <20220726212340.72499268@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mlKk4LBY8l9gTL7q0CLKFLt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mlKk4LBY8l9gTL7q0CLKFLt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next qemu run (powerpc
pseries_le_defconfig) produced this warning:

[    2.579447][    T1] Freeing unused kernel image (initmem) memory: 5120K
[    2.597718][    T1] Run /init as init process
[    2.725683][    T1] ------------[ cut here ]------------
[    2.725993][    T1] WARNING: CPU: 0 PID: 1 at lib/maple_tree.c:1227 mas_=
alloc_nodes+0x228/0x350
[    2.727071][    T1] Modules linked in:
[    2.727515][    T1] CPU: 0 PID: 1 Comm: init Not tainted 5.19.0-rc8 #2
[    2.727924][    T1] NIP:  c0000000007e6d18 LR: c0000000007f5434 CTR: c00=
00000003bb950
[    2.728030][    T1] REGS: c0000000034c3770 TRAP: 0700   Not tainted  (5.=
19.0-rc8)
[    2.728190][    T1] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 4=
4428480  XER: 00000000
[    2.728584][    T1] CFAR: c0000000007e6b70 IRQMASK: 0=20
[    2.728584][    T1] GPR00: c000000000403ee8 c0000000034c3a10 c0000000027=
9f400 c0000000034c3b28=20
[    2.728584][    T1] GPR04: 0000000000000cc0 0000000000000cc0 00000000000=
00018 0000000062dfc850=20
[    2.728584][    T1] GPR08: 0000000000000001 0000000000000004 00000000000=
00000 0000000000008000=20
[    2.728584][    T1] GPR12: 0000000000000000 c000000002970000 00000000000=
00003 00007ffffc35fb60=20
[    2.728584][    T1] GPR16: 0000000000000002 0000000100000000 00007fffa43=
c0130 c0000000074d03f0=20
[    2.728584][    T1] GPR20: 0000000000000002 c0000000074d02d0 00007fffa43=
50000 0000000000000018=20
[    2.728584][    T1] GPR24: 00007fffa434ffff 0000000000000002 00007fffa43=
30000 c0000000034c3b28=20
[    2.728584][    T1] GPR28: 0000000000000004 c0000000074d0480 00000000000=
00000 c0000000034c3b28=20
[    2.729676][    T1] NIP [c0000000007e6d18] mas_alloc_nodes+0x228/0x350
[    2.729769][    T1] LR [c0000000007f5434] mas_preallocate+0xb4/0x190
[    2.730100][    T1] Call Trace:
[    2.730277][    T1] [c0000000034c3a10] [c0000000033f01a0] 0xc0000000033f=
01a0 (unreliable)
[    2.730876][    T1] [c0000000034c3a70] [c0000000034c3ab0] 0xc0000000034c=
3ab0
[    2.730990][    T1] [c0000000034c3ab0] [c000000000403ee8] mmap_region+0x=
2c8/0x880
[    2.731102][    T1] [c0000000034c3bf0] [c00000000040494c] do_mmap+0x4ac/=
0x610
[    2.731206][    T1] [c0000000034c3c90] [c0000000003c5bc8] vm_mmap_pgoff+=
0xc8/0x1c0
[    2.731307][    T1] [c0000000034c3d20] [c0000000004006dc] ksys_mmap_pgof=
f+0x23c/0x2d0
[    2.731408][    T1] [c0000000034c3d90] [c0000000000134f8] sys_mmap+0x48/=
0x90
[    2.731539][    T1] [c0000000034c3db0] [c00000000002efc4] system_call_ex=
ception+0x184/0x370
[    2.731639][    T1] [c0000000034c3e10] [c00000000000c53c] system_call_co=
mmon+0xec/0x250

Introduced by commit

  872b9f073f0a ("maple_tree: add a mas_destroy() call to mas_expected_entri=
es() failure path")

At least reverting that commit makes the warning go away.  I have done
that for today.

I am wondering if maybe the -unstable parts of the mm tree should be
dropped in the last week before the merge window opens on the
understanding that those changes may be too late for this release?
--=20
Cheers,
Stephen Rothwell

--Sig_/mlKk4LBY8l9gTL7q0CLKFLt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLfzrwACgkQAVBC80lX
0GxrgwgAo/ixNZN07s411nmnGFhN/viLAW8rwTXVlE5UopbTaMOGU+owJFbyaxtL
xP0qeVMbeJOGS4M095ErL8igUwrr9dq5szZIQMEHXRjOU86CaWuNIHI5EZnuJ3Qh
KYCXYAyFUEKGR/nraaDmqGxPN13gZim/FPWOkA+PN1m871bt1CKYch9JcpbJ92qK
7YUh/s6Ti1N7pkhDOnOBdDPU+sbmR+8mDIfRIH4tIeUwx4bBzlQklIZwZtIymU3O
DBo/AbQEmZbH259UyyQfuH4601scsZK44fWquQSKg0DlpDMTm/ZIbUs43sQfAU2X
4lbt1aA8wSrxFQpWK96gH/ZXUtCCUQ==
=Rjia
-----END PGP SIGNATURE-----

--Sig_/mlKk4LBY8l9gTL7q0CLKFLt--

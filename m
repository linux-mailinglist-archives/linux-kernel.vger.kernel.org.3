Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404059F124
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiHXBvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiHXBvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:51:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2880EA0;
        Tue, 23 Aug 2022 18:51:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MC8Fb0B03z4x1N;
        Wed, 24 Aug 2022 11:50:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661305859;
        bh=BigbBY09npaKn1HWURPO2ZRFxFHgIDlTYLr1TZ98XKE=;
        h=Date:From:To:Cc:Subject:From;
        b=nkYtcvRKuz/5kg0dnnubqQ84XE227WwTaBNaP5EmJSTZRtNYyqeKwlNxTrVgnKRpC
         BIqsH5WFDsNWzUdmPCXN+tLuPRX97LO4RQ5M+kHqNNfS3Dt/lL233GRRdnZ/wk18kP
         hz0aTEA+s6Tolf5XJZsSAqK3r8W+nL7YfjZaV2AJcxRw95CiP/tnC1DNpQzHzXf75d
         +lKhvdzWrdXMZ4tpL/Wvis//xjnITkAOwjnSMXM+htCCwTi+BhpLstReDxKOxXdk70
         2VfqUNUfXO+xHe7HJiIDo2iwKgDOKE9J0yl2T3qG0U3NUpvb7T2W5xtsCZ4Vzvuyu5
         +mAY0HzdwXvRw==
Date:   Wed, 24 Aug 2022 11:50:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20220824115057.107e3d42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SMhn12Xh8N1XEgO/XrCrjkt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SMhn12Xh8N1XEgO/XrCrjkt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/bitmap.h:9,
                 from include/linux/cpumask.h:12,
                 from arch/x86/include/asm/cpumask.h:5,
                 from arch/x86/include/asm/msr.h:11,
                 from arch/x86/include/asm/processor.h:22,
                 from arch/x86/include/asm/cpufeature.h:5,
                 from arch/x86/include/asm/thread_info.h:53,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from drivers/scsi/mpi3mr/mpi3mr.h:13,
                 from drivers/scsi/mpi3mr/mpi3mr_transport.c:10:
drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_update_mr_sas_p=
ort':
include/linux/find.h:40:23: error: array subscript 'long unsigned int[0]' i=
s partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werror=
=3Darray-bounds]
   40 |                 val =3D *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/scsi/mpi3mr/mpi3mr_transport.c:1610:27: note: while referencing 'ph=
ys_to_be_added'
 1610 |         u32 phy_mask_xor, phys_to_be_added, phys_to_be_removed;
      |                           ^~~~~~~~~~~~~~~~
In file included from include/linux/bitmap.h:9,
                 from include/linux/cpumask.h:12,
                 from arch/x86/include/asm/cpumask.h:5,
                 from arch/x86/include/asm/msr.h:11,
                 from arch/x86/include/asm/processor.h:22,
                 from arch/x86/include/asm/cpufeature.h:5,
                 from arch/x86/include/asm/thread_info.h:53,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from drivers/scsi/mpi3mr/mpi3mr.h:13,
                 from drivers/scsi/mpi3mr/mpi3mr_transport.c:10:
include/linux/find.h:40:23: error: array subscript 'long unsigned int[0]' i=
s partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werror=
=3Darray-bounds]
   40 |                 val =3D *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/scsi/mpi3mr/mpi3mr_transport.c:1610:45: note: while referencing 'ph=
ys_to_be_removed'
 1610 |         u32 phy_mask_xor, phys_to_be_added, phys_to_be_removed;
      |                                             ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  434726c4b89c ("scsi: mpi3mr: Refresh SAS ports during soft reset")

I have used the scsi-mkp tree from next-20220823 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/SMhn12Xh8N1XEgO/XrCrjkt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMFhAEACgkQAVBC80lX
0GxN4wf/Z7YQufAfzLw3BvvaF1arzFAC6vtf5p1p77fmxYGzTF0pDLxhNtOT5Ivw
pp9iDe1aF72YlZTuJt0kcjepQMaq39c0ZGve6/vbm55OdmPj/av4C/2hJ0AzYM0t
O9/zXgFSHLVKabG/vCKbpIe7ae3ES5jYeoHBXOmILGj7MaNHD0nd1yZs8lUW6ksq
x/x1HKZeBQkaeS2m2eRl+Ubr2q6tqRT6TpzfFYvvMgxlbe7FXntP6Ssx9rcgdjgW
yE2vqWQs2ypz9IE6aiW5XTwv9dqPpE7P7icLqfUITZk/Lkgp2K/TGOa5fsvT8RoN
9UZKvTdU7D/uCURZV89OLukapdv8XA==
=Vk5t
-----END PGP SIGNATURE-----

--Sig_/SMhn12Xh8N1XEgO/XrCrjkt--

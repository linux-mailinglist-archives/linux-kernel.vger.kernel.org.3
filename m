Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E851ED73
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiEHMRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiEHMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:17:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0227110FDD
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:13:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kx39V5trYz4ySy;
        Sun,  8 May 2022 22:13:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652011998;
        bh=dxwY2t1/3j8Cm+1YL8a1tBfaNXSJojWCH9nMJ9l7iU4=;
        h=From:To:Cc:Subject:Date:From;
        b=kqbZLfR/pRB84uMw6FKl/RKDgyqbQ87vJJnknd7Ft2R3HInTeEzfCqLJ5JHpPDea+
         Z3Hs3msY39d+Me/06WcnEjie0iHwnCxq/uBBZM3URAS9b7wIZlocqE4Xp18Y9vPiLb
         EtZfhLgsnfk2YVlzlgRDWdghq/CBOUuKuQ0jVlsTyDmdkHYpppmSoPDw83/nk1e4XD
         ltYdxBjK2NsXaFD3u/mrPW6HTuH2D/VcYPDxws8RzaPE8nGJzW0z1i25I7iMl7AXSU
         ZqysRrw/zLvY879EuLdMZYU2ee631jFjlXaBLdzOXBpnvf1FBivh+XCMkNNxC9LJuX
         d3nnhj/IgEBsQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     haren@linux.ibm.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-4 tag
Date:   Sun, 08 May 2022 22:13:14 +1000
Message-ID: <87fslkte79.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.18:

The following changes since commit bb82c574691daf8f7fa9a160264d15c5804cb769:

  powerpc/perf: Fix 32bit compile (2022-04-21 23:26:47 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-4

for you to fetch changes up to 348c71344111d7a48892e3e52264ff11956fc196:

  powerpc/papr_scm: Fix buffer overflow issue with CONFIG_FORTIFY_SOURCE (2022-05-06 12:44:03 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.18 #4

 - Fix the DWARF CFI in our VDSO time functions, allowing gdb to backtrace through them
   correctly.

 - Fix a buffer overflow in the papr_scm driver, only triggerable by hypervisor input.

 - A fix in the recently added QoS handling for VAS (used for communicating with
   coprocessors).

Thanks to: Alan Modra, Haren Myneni, Kajol Jain, Segher Boessenkool.

- ------------------------------------------------------------------
Haren Myneni (1):
      powerpc/pseries/vas: Use QoS credits from the userspace

Kajol Jain (1):
      powerpc/papr_scm: Fix buffer overflow issue with CONFIG_FORTIFY_SOURCE

Michael Ellerman (1):
      powerpc/vdso: Fix incorrect CFI in gettimeofday.S


 arch/powerpc/kernel/vdso/gettimeofday.S    |  9 ++++++--
 arch/powerpc/platforms/pseries/papr_scm.c  |  7 ++----
 arch/powerpc/platforms/pseries/vas-sysfs.c | 19 +++++++++++-----
 arch/powerpc/platforms/pseries/vas.c       | 23 ++++++++++----------
 arch/powerpc/platforms/pseries/vas.h       |  2 +-
 5 files changed, 36 insertions(+), 24 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmJ3s60ACgkQUevqPMjh
pYCE+xAAk+ButiF8vXxyO0/sWvW8F2qkGDvUlGn8Dwo8q8AaA70nCvzztcnBMScE
KrUjJFOEAiQUKXCVsczWAcxQwPAkD6myTaoseUBNTc+fdeLiWzpAGRY9FTMR54M6
UtPtiSCUnz2UJnU4gIfAEYGGsnF2PMKnBnEV4ROFNqqIAihmQjW7oU7iLq4kNSX6
YOE5UPUpPSuyJgI1/KlseUuEsH/Hz0Fc3AvSEel+/pfTdPaIxed7Oxr116HsOHqJ
Lda88F+4Tdk0OSC9Q9gzbyqQsvpIe2OTt9FQEuBbSAEV+eUbWuwBI44UVkpDDg/C
HlcmxAGAoulLXTKrnt3RkjonLZuVwGCTgCJe9zTzWG00n1XzO6mvEuphyixlPsow
7Ej5QLSWkGMZhZO+wTcJpgcCcZ4TEYtpf3T5iBR2DlcftIgmlJtmSS99mwgMZ7ct
LaHYJDOlSRCtxQipAeHBtybe/ngsxYIdCjNlumbEbYY6tUg5+6jY8DMkJ6KFHAfk
82h241dByF0YDW1HpG5D+RGpEvxTpQrFYhE9XPdOqQ07mwOzIg9DMmCLXrIofETV
Ywb5+jY3DlpCZz0nxOHA+5SO1fealq8ZC4ZDKO3FErgqsUUCjuZJUbSLtFHGGRsF
HIg+xDoXRpiGWwpIqrgozu2xxYE4AbDhe+sOVvF4APHTXIuP0+U=
=Lyfd
-----END PGP SIGNATURE-----

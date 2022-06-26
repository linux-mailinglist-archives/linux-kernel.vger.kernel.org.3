Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B691D55ADDF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiFZAuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiFZAuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:50:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320413EAE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:50:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LVsjR1qpZz4xXD;
        Sun, 26 Jun 2022 10:50:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1656204651;
        bh=OB5tn+I2GIG329HuwGDVgM1HpRDegLtdTaJsILlADQk=;
        h=From:To:Cc:Subject:Date:From;
        b=NaTLgayttFGRvh7kXgESiyIXYFRWRVtB6FOcTLGo1kG7PJ1V14o195WBXoHCj53Qb
         F1rLvIPaYpYtt26XF2G1rr0cyuWFPhAdoTuYk1QQo0DaFG4dg2Us48f6pnAEgJc35j
         YKGX/f1gVHQw+ZQnQmFMiLxeOZ0hLPWgeiUDnQsAQmqx6on2EOWYQTxm+S6pphKGZx
         bir61Y61I5wA5eVFekEDvzOoCoDUAovkv5RxrBhruPagJWZ7xBwrLvPqYMz8oKQ7HC
         fch6d9jhKyCd0WGseR4e2qQ9y6Y3oVr1U8qE8c2ety43Ah/YuANWcYUZfuksgaUglk
         2O3OvgxB1QCgA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason@zx2c4.com, ajd@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen.n.rao@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-3 tag
Date:   Sun, 26 Jun 2022 10:50:49 +1000
Message-ID: <87pmiw4592.fsf@mpe.ellerman.id.au>
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

Please pull some more powerpc fixes for 5.19:

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-3

for you to fetch changes up to f3eac426657d985b97c92fa5f7ae1d43f04721f3:

  powerpc/powernv: wire up rng during setup_arch (2022-06-22 19:47:22 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.19 #3

 - A fix for a CMA change that broke booting guests with > 2G RAM on Power8 hosts.

 - Fix the RTAS call filter to allow a special case that applications rely on.

 - A change to our execve path, to make the execve syscall exit tracepoint work.

 - Three fixes to wire up our various RNGs earlier in boot so they're available for use in
   the initial seeding in random_init().

 - A build fix for when KASAN is enabled along with STRUCTLEAK_BYREF_ALL.

Thanks to: Andrew Donnellan, Aneesh Kumar K.V, Christophe Leroy, Jason A. Donenfeld,
Nathan Lynch, Naveen N. Rao, Sathvika Vasireddy, Sumit Dubey2, Tyrel Datwyler, Zi Yan.

- ------------------------------------------------------------------
Andrew Donnellan (1):
      powerpc/rtas: Allow ibm,platform-dump RTAS call with null buffer address

Christophe Leroy (1):
      powerpc/prom_init: Fix build failure with GCC_PLUGIN_STRUCTLEAK_BYREF_ALL and KASAN

Jason A. Donenfeld (3):
      powerpc/microwatt: wire up rng during setup_arch()
      powerpc/pseries: wire up rng during setup_arch()
      powerpc/powernv: wire up rng during setup_arch

Michael Ellerman (1):
      powerpc/mm: Move CMA reservations after initmem_init()

Naveen N. Rao (1):
      powerpc: Enable execve syscall exit tracepoint


 arch/powerpc/kernel/process.c                |  2 +-
 arch/powerpc/kernel/prom_init.c              |  2 +-
 arch/powerpc/kernel/rtas.c                   | 11 ++++-
 arch/powerpc/kernel/setup-common.c           | 13 ++---
 arch/powerpc/platforms/microwatt/microwatt.h |  7 +++
 arch/powerpc/platforms/microwatt/rng.c       | 10 ++--
 arch/powerpc/platforms/microwatt/setup.c     |  8 +++
 arch/powerpc/platforms/powernv/powernv.h     |  2 +
 arch/powerpc/platforms/powernv/rng.c         | 52 ++++++++++++++------
 arch/powerpc/platforms/powernv/setup.c       |  2 +
 arch/powerpc/platforms/pseries/pseries.h     |  2 +
 arch/powerpc/platforms/pseries/rng.c         | 11 ++---
 arch/powerpc/platforms/pseries/setup.c       |  1 +
 13 files changed, 83 insertions(+), 40 deletions(-)
 create mode 100644 arch/powerpc/platforms/microwatt/microwatt.h
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmK3rQsACgkQUevqPMjh
pYBy9hAAqTgh+EzA0L2c8u8jps+xDrkzlx1yc3uRGGPJr+q/HoV6daZnN1gTDolF
ryK98wDeBIy/2+3TZj18+ok86/jXHSXpQd8w2sT9o1fMfmMUGrxe2qWrvxTUOUCr
eRgZNzOE0u7kANppuEpwEtT1oQu1Tmcta2Fen7EBxJ5FZaOkrQrF6oOee5vRSRlA
O0cIzYBu6Wd/KYpJCVmixcywIrz1U3mdPFzzPbG/G+/jvUxvp5jJudJf40QSpEbl
7zg7Ilxga+LHL8yJSnKHV9GTx8MlDqBM/e4+BDC0eNL4GGNkFjQmVXpD13ovVsMe
tXF/oM+6/7emHDpP21Dzx6+TFXYTOeIu07k2z1R/WkOzZZkYE1/7RCvltX/h8/9W
XwAwGRTi1xvMDmWGlNEV116v9si+WXzDWRBCe4P5TNcb8d1Y+I3cLVvrJa6QtqIj
S/QroyB+Z6dLWxZbBQBm35muOqdHm91HQWV8EdHmePAwhntji/Hkghjfr2+4mi9J
ZVnWyVeYhhhSMzVva3MuEcZNu0kXLdslW4mNkwkIJTcqg9K8KxFCfZK/6VdK6ask
6hLP/fitGCpZ9YVpB40CTPvwLxO93ShrtRmGu8qoQSX1YmlbvIReA7jDuBnU2u6T
f1UHagFzWKePmPXUHFXJWzHjb9IBUGWRat9jFlerL+5sRLoLkes=
=+YP6
-----END PGP SIGNATURE-----

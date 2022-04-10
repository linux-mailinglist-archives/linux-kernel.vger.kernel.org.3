Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBB4FAE0E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiDJNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiDJNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:25:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9583B55A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 06:23:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kbt3Z4Jlvz4xLS;
        Sun, 10 Apr 2022 23:23:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1649597020;
        bh=hmIbrPItE/fhgZiQOZ10+3w1d55EyNhgfrJfoY0cso0=;
        h=From:To:Cc:Subject:Date:From;
        b=BumI25dOGPHD2vUxscA4roeAgqSX1tnWSNhbLsbKE2CCQ8aycC74hXOOQFUqspRpb
         obQFuM5KvSmYX2MwGmh9vRA6dX8sRJHOaO3JvuU0W2FtcsLOZpuZelKbzm6LggjS9H
         ZnWL7c9sjVpqooJ6yUmo7PEXUSlp08xkS4ECH7mSizUkplc2SiUKwwcfA/t9802AXG
         axNoJ4FFP9NT/IHSjj3HP2KylWDlfqojn3P7ngA4/JK10ZxwAD1hUQTwwyjqjRXwz7
         rIkB9oFzU3Sdf+GbMt352wz1cnUMvaRNsjdoGI/Y+F9uDsB/WzMNaLXznV27TLi4cl
         ZEX59x1pbmmgA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mhocko@suse.com, npiggin@gmail.com,
        osalvador@suse.de, srikar@linux.vnet.ibm.com,
        wangkefeng.wang@huawei.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-2 tag
Date:   Sun, 10 Apr 2022 23:23:35 +1000
Message-ID: <87y20d5ay0.fsf@mpe.ellerman.id.au>
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

Please pull powerpc fixes for 5.18:

The following changes since commit f82da161ea75dc4db21b2499e4b1facd36dab275:

  powerpc: restore removed #endif (2022-03-27 15:31:16 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-2

for you to fetch changes up to 1ff5c8e8c835e8a81c0868e3050c76563dd56a2c:

  Revert "powerpc: Set max_mapnr correctly" (2022-04-07 08:54:35 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.18 #2

 - Fix KVM "lost kick" race, where an attempt to pull a vcpu out of the guest could be
   lost (or delayed until the next guest exit).

 - Disable SCV (system call vectored) when PR KVM guests could be run.

 - Fix KVM PR guests using SCV, by disallowing AIL != 0 for KVM PR guests.

 - Add a new KVM CAP to indicate if AIL == 3 is supported.

 - Fix a regression when hotplugging a CPU to a memoryless/cpuless node.

 - Make virt_addr_valid() stricter for 64-bit Book3E & 32-bit, which fixes crashes seen
   due to hardened usercopy.

 - Revert a change to max_mapnr which broke HIGHMEM.

Thanks to: Christophe Leroy, Fabiano Rosas, Kefeng Wang, Nicholas Piggin, Srikar Dronamraju.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/64: Fix build failure with allyesconfig in book3s_64_entry.S

Kefeng Wang (2):
      powerpc: Fix virt_addr_valid() for 64-bit Book3E & 32-bit
      Revert "powerpc: Set max_mapnr correctly"

Michael Ellerman (3):
      Merge branch 'kvm-ppc-cap-210' of https://git.kernel.org/pub/scm/virt/kvm/kvm into topic/ppc-kvm
      Merge branch 'topic/ppc-kvm' into next
      KVM: PPC: Move kvmhv_on_pseries() into kvm_ppc.h

Nicholas Piggin (4):
      KVM: PPC: Book3S HV P9: Fix "lost kick" race
      KVM: PPC: Book3S PR: Disable SCV when AIL could be disabled
      KVM: PPC: Book3S PR: Disallow AIL != 0
      KVM: PPC: Use KVM_CAP_PPC_AIL_MODE_3

Srikar Dronamraju (1):
      powerpc/numa: Handle partially initialized numa nodes


 arch/powerpc/include/asm/kvm_book3s_64.h | 12 ------
 arch/powerpc/include/asm/kvm_ppc.h       | 12 ++++++
 arch/powerpc/include/asm/page.h          |  6 ++-
 arch/powerpc/include/asm/setup.h         |  2 +
 arch/powerpc/kernel/exceptions-64s.S     |  4 ++
 arch/powerpc/kernel/setup_64.c           | 28 +++++++++++++
 arch/powerpc/kvm/Kconfig                 |  9 +++++
 arch/powerpc/kvm/book3s_64_entry.S       | 10 ++++-
 arch/powerpc/kvm/book3s_hv.c             | 41 ++++++++++++++++----
 arch/powerpc/kvm/book3s_pr.c             | 26 ++++++++-----
 arch/powerpc/kvm/book3s_pr_papr.c        | 20 ++++++++++
 arch/powerpc/kvm/powerpc.c               | 17 ++++++++
 arch/powerpc/mm/mem.c                    |  2 +-
 arch/powerpc/mm/numa.c                   |  2 +-
 arch/powerpc/platforms/pseries/setup.c   | 13 ++++++-
 15 files changed, 169 insertions(+), 35 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmJS2fgACgkQUevqPMjh
pYBt1BAAgsfryhBqA9GD/hEgNpk08Pb214OAAGkKF4uStVs3kAlVhuVeDUThGt5B
z3OpvAL8lnOOkQ6S/fl0FXMAU5URJhdXTNwmS3g557VIWAVblWEc+oGMOeq2aJIi
hmlFoLUd7Ge31I03+OZ5IIlOuOc0DM8Qe6zpF25feg3Xw0oQzMHCKgPfnsWbQz+Q
116NhWE8r35eCmrZEsamaTaUBb8ox9aklVaNNyYm/fJgUUuZg9ROb+pmf4s4y5uP
x+DQW5RawMV6S7+co7Je8wJB4wGDG0aO/edqUPmdkVW8jksUv5aTD3jr3aQeSA8l
YwICU8wIZBd9Ps3W8/1LWVfNCyfdcbafOCztirrIAHpD7BdKUizvo8zyQCMTATqB
m2mHI+EPOGcE/P8HRhLENnjBz6CTU0ZFuSaxpmyDTCOewDP9zzIGkEL5qwZ9EOcY
7XlqEEK0PiS/rBmigN8R5bv+H9WsJ6Lb2mOVkoSo18ujM5oclhyWw6OlAVmpLybU
ZauoiM31SINO5LHX+M9P0o8FHtauRLPCHYxmB6akhnTPqYhwfqi+fWxrqbmBtEba
dr+MTnAVMEFIt4ZdzFOPtZcM+nSGUX/CNfUO4DiCW9MgB9F24kx/lmy+MljQ0gvS
2jxt0ylnTUVxb1XeGZMVHD1CCz0vZhntmAxewbkoltuZuMufJdo=
=WTqS
-----END PGP SIGNATURE-----

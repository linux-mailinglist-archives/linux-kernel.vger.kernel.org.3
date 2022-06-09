Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70F545006
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiFIO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFIO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:59:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC441F8993
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:59:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LJnLn5Dd2z4xD2;
        Fri, 10 Jun 2022 00:59:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1654786786;
        bh=N9NnYp3GcVuyR2yBzP9kXGZYH5tjTQycICPNf8wRK0E=;
        h=From:To:Cc:Subject:Date:From;
        b=ayUCVdulsnb8alDqSNWslgtCmQ3NuK4Q5IAhoRnjtLXhugwvcfOj81qJr1CpEzcs6
         A+H0TiA7W1JFaNXgG9ph6Ymz1T8qJ3zcdoJnZ03qT73+CibG28F3H1oSphJjGBxbZM
         JzsnBUDSvYkQs93RZLzCXLSN08efakPyaZXdGAUa3nBftWl/O4Oo/bBj/JwBtxdOaG
         pxtaWj4NRnZ8ZpLOQtagatOJqC3pTL2JkQeoNDiJUoub0INWBTzlc+Hk2f8pT72qeb
         BD+xaG3wUzTpa/LTDSEWPnfV/LIMamYppy9m2nA/+gBcvBqTR3hZIB5iXFDL1Xh3RA
         ugoMqD84b0Z8Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     heying24@huawei.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, masahiroy@kernel.org,
        oss@buserror.net, paulus@ozlabs.org, vaibhav@linux.ibm.com,
        ariel.miculas@belden.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-2 tag
Date:   Fri, 10 Jun 2022 00:59:45 +1000
Message-ID: <87k09pdgri.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fixes for 5.19:

The following changes since commit 6112bd00e84e5dbffebc3c1e908cbe914ca772ee:

  Merge tag 'powerpc-5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2022-05-28 11:27:17 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-2

for you to fetch changes up to 8e1278444446fc97778a5e5c99bca1ce0bbc5ec9:

  powerpc/32: Fix overread/overwrite of thread_struct via ptrace (2022-06-09 23:32:56 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.19 #2

 - On 32-bit fix overread/overwrite of thread_struct via ptrace PEEK/POKE.

 - Fix softirqs not switching to the softirq stack since we moved irq_exit().

 - Force thread size increase when KASAN is enabled to avoid stack overflows.

 - On Book3s 64 mark more code as not to be instrumented by KASAN to avoid crashes.

 - Exempt __get_wchan() from KASAN checking, as it's inherently racy.

 - Fix a recently introduced crash in the papr_scm driver in some configurations.

 - Remove include of <generated/compile.h> which is forbidden.

Thanks to: Ariel Miculas, Chen Jingwen, Christophe Leroy, Erhard Furtner, He Ying, Kees
Cook, Masahiro Yamada, Nageswara R Sastry, Paul Mackerras, Sachin Sant, Vaibhav Jain,
Wanming Hu.

- ------------------------------------------------------------------
He Ying (1):
      powerpc/kasan: Silence KASAN warnings in __get_wchan()

Masahiro Yamada (1):
      powerpc/book3e: get rid of #include <generated/compile.h>

Michael Ellerman (3):
      powerpc: Don't select HAVE_IRQ_EXIT_ON_IRQ_STACK
      powerpc/kasan: Force thread size increase with KASAN
      powerpc/32: Fix overread/overwrite of thread_struct via ptrace

Paul Mackerras (1):
      powerpc/kasan: Mark more real-mode code as not to be instrumented

Vaibhav Jain (1):
      powerpc/papr_scm: don't requests stats with '0' sized stats buffer


 arch/powerpc/Kconfig                      |  2 --
 arch/powerpc/include/asm/thread_info.h    | 10 ++++++++--
 arch/powerpc/kernel/Makefile              |  2 ++
 arch/powerpc/kernel/process.c             |  4 ++--
 arch/powerpc/kernel/ptrace/ptrace-fpu.c   | 20 ++++++++++++++------
 arch/powerpc/kernel/ptrace/ptrace.c       |  3 +++
 arch/powerpc/kernel/rtas.c                |  4 ++--
 arch/powerpc/kexec/crash.c                |  2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c      |  8 ++------
 arch/powerpc/platforms/powernv/Makefile   |  1 +
 arch/powerpc/platforms/pseries/papr_scm.c |  3 +++
 11 files changed, 38 insertions(+), 21 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmKiClMACgkQUevqPMjh
pYBl2w//cMfBNA1wR3b+r9+Ro9SlFMzfCtk0ue+A44QLo0Va71H9eZLmZ7qM6LK4
B37Am/bNZPnI0DM1pjTXKq0aEt7KRC9VyEiS9Gl4w0mf5bRjZy8Q8A+YA/CDoKrr
Ctd1iAZzk1mAbegdSeS66DlmGVGvDwzLK8jkJDPjOhaaXZMLZLRx+j4USeLuTCMS
Ub7LXpLcewa7E7xOXshoFIFd6wCSEpsiayCEAlCd4yICKeDfNdWc/9GBd3e6z+1e
7cSr7E59TY1cJ5WZ00p1UPigImNroYBEPmZj+F3vSt/MQwb/VXZYQuFojytk126z
sl69pzyghp4oCdvNvVVxHTHjDYZhnoPEKSoPpgD+CegrrdgKBeXweGE8T8JHKr4i
1FSFrX+zwXoTRRpwyDVEtDu1ld/AMHMQO8NiFFDSuYDdgrgYCyqk1Rg3Yb6aYpLQ
+b8uwX9b1lUZyrJz/Whf4PpTW0TmU9eyNPyFScpyojX1HMcu+VDBtowuaS1FkzIb
2ft6XsQUV0f4EIrJTsgWWyIw32kE9TiCPKwOX3wMQfdx5j6YuQJ7N2ALZVoQnQbu
aUvpGu6Fv/tasSaboThHWpAsRZLMGjFD94WwvX1Kn0NtvWpoeocA6barup0Nosey
3avApSIyPG5Q9RA3m1SjM0dLJdpyUmt2hDuvuFitRmeqePOoVxc=
=s319
-----END PGP SIGNATURE-----

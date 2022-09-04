Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0475AC44B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiIDMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiIDMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 08:36:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B91E3D4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 05:36:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MLB3Z0VRMz4x7X;
        Sun,  4 Sep 2022 22:36:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662295002;
        bh=H+KEsahWTtHRKpMd36IjmCM/6vqd9S1NJOfa2HWcW8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Bl2umHW2VCQdQeA5FBP2RLoYNkk303KJGrDPOSbqLHc7FBPvMbWrW1lswFAoyYGj/
         xt5QNpoN3ziTxFRxRtbgn8om0SbWb4L/WN2/Vl6OCWPUAHEvyL1iI5XLQtur9B8K2C
         rdFrXdA1kWGS4OJXI8uGFRsuvEuETc2IXkDGhnx5ivGOltU3N0jCX69QETafkPpny4
         Ur4tOQpUEmwSKki5G7Z27TuYFSufSyhFo9ta1O8ORQwveT/EnQkkSz14URn/uX9tnK
         ILW4xcdxZzmIfKCPqJUqTnhZQ8o9xJ2+LHL+ABB5btun7ZGnSBWp1i6cPhPXiUu7f7
         qrIbXe277b2tg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        masahiroy@kernel.org, nathan@kernel.org, pali@kernel.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-4 tag
Date:   Sun, 04 Sep 2022 22:36:31 +1000
Message-ID: <87fsh7tiy8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.0:

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.0-4

for you to fetch changes up to 6cf07810e9ef8535d60160d13bf0fd05f2af38e7:

  powerpc/papr_scm: Ensure rc is always initialized in papr_scm_pmu_registe=
r() (2022-09-02 18:55:11 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.0 #4

 - Fix handling of PCI domains in /proc on 32-bit systems using the recentl=
y added support
   for numbering buses from zero for each domain.

 - A fix and a revert for some changes to use READ/WRITE_ONCE() which cause=
d problems with
   KASAN enabled due to sanitisation calls being introduced in low-level pa=
ths that can't
   cope with it.

 - Fix build errors on 32-bit caused by the syscall table being misaligned =
sometimes.

 - Two fixes to get IBM Cell native machines booting again, which had bit-r=
otted while my
   QS22 was temporarily out of action.

 - Fix the papr_scm driver to not assume the order of events returned by th=
e hypervisor is
   stable, and a related compile fix.

Thanks to: Aneesh Kumar K.V, Christophe Leroy, Jordan Niethe, Kajol Jain, M=
asahiro Yamada,
Nathan Chancellor, Pali Roh=C3=A1r, Vaibhav Jain, Zhouyi Zhou.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc: Fix hard_irq_disable() with sanitizer

Kajol Jain (1):
      powerpc/papr_scm: Fix nvdimm event mappings

Masahiro Yamada (1):
      powerpc: align syscall table for ppc32

Michael Ellerman (3):
      Revert "powerpc: Remove unused FW_FEATURE_NATIVE references"
      powerpc/rtas: Fix RTAS MSR[HV] handling for Cell
      Revert "powerpc/irq: Don't open code irq_soft_mask helpers"

Nathan Chancellor (1):
      powerpc/papr_scm: Ensure rc is always initialized in papr_scm_pmu_reg=
ister()

Pali Roh=C3=A1r (1):
      powerpc/pci: Enable PCI domains in /proc when PCI bus numbers are not=
 unique


 arch/powerpc/include/asm/firmware.h       |  8 ++
 arch/powerpc/include/asm/hw_irq.h         | 46 ++++++++--
 arch/powerpc/kernel/pci_32.c              |  9 ++
 arch/powerpc/kernel/rtas_entry.S          |  4 +
 arch/powerpc/kernel/systbl.S              |  1 +
 arch/powerpc/platforms/pseries/papr_scm.c | 90 +++++++-------------
 6 files changed, 89 insertions(+), 69 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmMUm5QACgkQUevqPMjh
pYAfxA//ZxJ628HdOELmRQJ1d5jGza0ijHDT5gEH2w7KlJ0AfxiHQ+QEs90V0X4c
Kv8SPmjwp+j/u1374qsLhwpn4v92mri8hA7mZyFtF5rECr2glYWd1G8bhEoqznMS
A0o51vaREzwuuZ/8Yy2zERm5oBUMNyg3Xt7JJBlDAs927D039UezWKbUHsIrD8SS
8NWX9bUWNCuzzr66OD8fF8AT7zv3u1mDYeOqph14Lf6RVoJi0q/RLa7+PIsVxOpJ
sq0CsbdZ7cc/FAYKY92y5eDcYK6FLEr1LLeb4ZmXwEIAoe9jzI5X6vykFJXoL8JD
YmwZNXA9FFTWRN+X9RhBp+DJSnHY57kHn6es4Xgv5juroeP9YnnA/LmgPDrt6W15
jB7xkupxDhexZSMF/X+6Q67IY07mTw5Hrb6c/Kfkqk+KF75ryJKjQf35LY1fnRJP
yMIzVubN/fngIlup//C8YzP7OdwJRqEJNfphR+zMF8+5xBJbP9X1AiBVQm1N7eeM
NzrtvgZy/zAueErRyGR4OoaM8OP3eIayAQCFACiI8a9IjT5OGMDluxpfX9Uf08SX
7w6k31Q8namY8HrUT04mo2tXTcUHkjibCCY73q2YFV/2jygJp8UdbpYxmVTAe1PB
oWNanRelqN7cBnw46NrTDRDYEZcqj2iBCWeDlOZVH1/wcDT07g0=3D
=3DSjDB
-----END PGP SIGNATURE-----

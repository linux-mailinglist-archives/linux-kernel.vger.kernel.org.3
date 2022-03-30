Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE78E4ECEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351313AbiC3Vp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351301AbiC3Vp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:45:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A75F76
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648676650; x=1680212650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lASKdYMSMbpY3YMCgBI+0wvBvlgBA48ZwyFm07zjWLU=;
  b=diCl5m2s8gvhgm8lThUxlyq1GenS0Y1pnOvVYFopGyVpc+XpLU0fzO9x
   8evvmwgrnullhnCdF6/vZAf3ZaI8EMDJ+1rNagcNzF51PaI+YsdT8L+IR
   J/dU7sIT7bhjGK7hk7wvqnkhIM806hpU/K+GriBfowNrqjdWtSN6hNw0I
   8LJoHsYdCV/W1v8k8ZfptIv74aMJNKl1MzEJC1LW1iy1/rukUV8hltNwe
   j0LyCdvkXEkmLnS8AcLHxC22J9Luxp0enFVOJpa3Yyrru7amcmqinkJH4
   zQsQpuIFISehdWvvig7ylgBSSrmP4rcxdiyaS4xApov0VK7zGHcL8L82k
   g==;
X-IronPort-AV: E=Sophos;i="5.90,223,1643644800"; 
   d="scan'208";a="197584225"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2022 05:44:09 +0800
IronPort-SDR: 4GRIFdH9TMjeym8ZqTWhSxNqztqvcshb3t/93pNusSS/yeqXGZvjU3RRfJk8PlpxCl853gzCiS
 +y3aE+FuXflVesNUh24cwIMop0NdC9dwUFqV/3ICokl+1jCPnt5WKZ3qyL1IZ7m4YPRlAiJS9Y
 VW6vVjiFNcooxQMn5pvXjNR5agqO/mBll8SIn8VcKW4V4M1zWsH8uhzVLSXHZhkDy/fJdvSPM1
 5Vs1odYJztkkE3UNGpcAtfTT7AQJR8EonU76TbTwViaVlpPlyXT0zxy88DvAFRWXo5zkqljXNL
 3UNChpbmcl3PWXxSZPvmKVQj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 14:14:59 -0700
IronPort-SDR: nz9LRtCr74A5e9F8YpM0nyrSwbyZe0Y7xnAlxzV2ue48m5mOJRs4m4r2gjbmk8e6Ngv4rtHFKh
 SDNtWNfeOa2DiHSsgJQWRHq22nI3i0B3nW9jOILHKtBE75TlTUySnoGVk5ymPcZhOx9QOkHahs
 TBmcAKzXeYNcKXTeQSmqxZYd8s46AcFA5/HAroxC4mvQJSusIBenWPWKwToqvjDhP14BAWGlG1
 ei4nQysu98Wh5h0+4I3e8eX6O0okOhAtGZp+UC0aaOWiV54ZWDdLBre0XQHDSVS89ccrIlIGAw
 TFU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 14:44:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KTKh84W68z1SVp1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:44:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1648676647;
         x=1651268648; bh=lASKdYMSMbpY3YMCgBI+0wvBvlgBA48ZwyFm07zjWLU=; b=
        Gl5NzUDnqI0kjNfdRZ04swsSk5BP+Qbor+W1CKvXHkuYtfMz5Sr2Uc+zXsD8/K5X
        wkNbfhFMHxENsUtDUDTpeXpCaOa3QBVQbiqaRHSgPUAvP6JAdqavNTyVXscDSvT5
        5zo6oyUJqiwR9zE9IykUfEA2JqIWpgyYn3HK/v69kjTJ16CbOL5/ec8/3HnTHkOI
        zlZnN6az9FT48zsbBiwWvInIWgf/e9ZwfAEwP9QkDwhUed9eQAcvIu8PQ/DsEHYk
        4MWwaTTZU9E+R0Zg0O/BpnEBAcGfZZi1g/TYvYk/D9ZzKggBy7OFRv9cA882dlhn
        2gBitXSNdzHk0rW1pmLV0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aSWGep7J0jfO for <linux-kernel@vger.kernel.org>;
        Wed, 30 Mar 2022 14:44:07 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KTKh31mLtz1Rvlx;
        Wed, 30 Mar 2022 14:44:02 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu
Cc:     linux-kernel@vger.kernel.org, anup@brainfault.org,
        atishp@rivosinc.com, guoren@kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] riscv: Ensure only ASIDLEN is used for sfence.vma
Date:   Thu, 31 Mar 2022 07:43:58 +1000
Message-Id: <20220330214358.3409766-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

When we set the value of context.id using __new_context() we set both
the asid and the current_version with this return statement in
__new_context():

    return asid | ver;

This means that when local_flush_tlb_all_asid() is called with the asid
specified from context.id we can write the incorrect value.

We get away with this as hardware ignores the extra bits, as the RISC-V
specification states:

"bits SXLEN-1:ASIDMAX of the value held in rs2 are reserved for future
standard use. Until their use is defined by a standard extension, they
should be zeroed by software and ignored by current implementations."

but it is still a bug and worth addressing as we are incorrectly setting
extra bits.

This patch uses asid_mask when calling sfence.vma to ensure the asid is
always the correct len (ASIDLEN). This is similar to what we do in
arch/riscv/mm/context.c.

Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/mm/context.c  | 2 +-
 arch/riscv/mm/tlbflush.c | 2 +-
 include/linux/mm_types.h | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..4329fe54176b 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
=20
 static unsigned long asid_bits;
 static unsigned long num_asids;
-static unsigned long asid_mask;
+unsigned long asid_mask;
=20
 static atomic_long_t current_version;
=20
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 37ed760d007c..ef701fa83f36 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -42,7 +42,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm,=
 unsigned long start,
 	/* check if the tlbflush needs to be sent to other CPUs */
 	broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 	if (static_branch_unlikely(&use_asid_allocator)) {
-		unsigned long asid =3D atomic_long_read(&mm->context.id);
+		unsigned long asid =3D atomic_long_read(&mm->context.id) & asid_mask;
=20
 		if (broadcast) {
 			sbi_remote_sfence_vma_asid(cmask, start, size, asid);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..5fa7cc0af853 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -666,6 +666,8 @@ struct mm_struct {
=20
 extern struct mm_struct init_mm;
=20
+extern unsigned long asid_mask;
+
 /* Pointer magic because the dynamic array size confuses some compilers.=
 */
 static inline void mm_init_cpumask(struct mm_struct *mm)
 {
--=20
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A04ED3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiCaGBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiCaGBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:01:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CFD81
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648706359; x=1680242359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ed6hy39Lfvz6DiRAwjZW7mlN2JlqATkwXCFG3WQaKZ4=;
  b=OxOj6n5W1UcYjTHLOiwC+5uIUSm0RnXbz4QHOCMVmkXlCJ1ILEjJ+URH
   5/+5rT2yCOs7QN3VOVXTZnHvZiFAWzyGhh+6RqDkJwlHPIIK6fO6A+UPE
   5DhKcOMpcBWGqRuM3JZqwyyJEYwC8U7XHNdGMDzNRSPpavrpcf9ckUkJ+
   FjElTGB9g2m8wHPhop2rl4DgS605m25p3uAPuM1Ze7WhdCjakjkmUovzX
   CQ9KUk0nVF1BiJj2rV4C40/C0a5mgdXFQJwgUCA3zqt4q6SZFVLaxShJB
   ewzERVBaaseALKrKvYU90bpt1IGGcXLCDy3eKJ9wvW8Arh5y5O0U1NiE5
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,224,1643644800"; 
   d="scan'208";a="197614523"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2022 13:59:18 +0800
IronPort-SDR: VVpf4f1nqWVcoPKglrMFkNVquzGbzoyjMur/r12pVFrtieigeFmn8anyMA8YuZ1AudBF01lndX
 2bVohr0+dSi4aFjr6THTlj3SHYuiChnDmJhM30nCA/J+2jhRhyxNtNgEo/UR5UXe5xHYkJoEDJ
 t/Mu1LLng1cNNLwK/aizkuz2/exxp2eVWosEJ72e0+DFYruPhQNOqq4fTvsm5N6faBQOBd1Gar
 fBeGICTMzVGTa/6/stfunfjlBnVtMFLi9ADVCcxAdC2L2CNynlE2pJQcQe7mRQz2im9WjT2vrQ
 KBEtNPZlFoeYYMDHP7SmM4j/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 22:30:59 -0700
IronPort-SDR: Yh6GaEUe0YgAXNc1Ip3/11F3+nG80CU6XgQ2Nmr6ek5pXT8EXVtel7fAc4+ZJPBbOov+ATf2wB
 qqwnh9n7Mxu1CYMWpxNYGbarEkRKYUpjCvCPtLnfA8qzxAZnB5wdiTj1fRZcLltyXBDSZKDd3H
 17XXdW2SdmYCFkQq1gEZLMK5Dacz76dl3iRb9id4e2oCXSGyUwzyx3KBo32CfMoNXvlmonkyfK
 hMpQJvsCp37p+x+PZIxd+JGyvved0YgzJj9LsyDaSru8RkJM2uXYisfKuSbsh03d8uwSgX3LL8
 ufo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 22:59:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KTXgT5m1Mz1SHwl
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:59:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1648706357;
         x=1651298358; bh=Ed6hy39Lfvz6DiRAwjZW7mlN2JlqATkwXCFG3WQaKZ4=; b=
        Yc6W+ITI968wp+sBRBtH1tA9Qv3MkNzmw3y0uyMUjG51xjpSaHjjaHd5UgBCo3rT
        JlB3xy2rRPFpNi+/PAI8FSZyqbama6PdcppoF3COdfl6xA5Jq8+VL8JqSBhBKrjL
        1f5Q+C4F0PY9ZMSUhsPAgkJp1vUmj/tnaEDUI/yHoeEjvApqaxQWvY9VoAENYdMA
        zbhhfW4CGvsTJ5Y648+9fN2y2fs4eIrY6nRA2kColsABLLy7g5JwLrd7MmQp2kso
        q5OO5XH5TYcaGRxt8PirIApFvwGPHQe6ykwn69k4TGyNKba96ftktwtJzIF0c6sF
        kNnKTwlb1uzWMC/giDktkQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8qkqEPmHcNFa for <linux-kernel@vger.kernel.org>;
        Wed, 30 Mar 2022 22:59:17 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KTXgM6MWnz1Rvlx;
        Wed, 30 Mar 2022 22:59:11 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     atishp@rivosinc.com, anup@brainfault.org, guoren@kernel.org,
        alistair23@gmail.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3] riscv: Ensure only ASIDLEN is used for sfence.vma
Date:   Thu, 31 Mar 2022 15:59:06 +1000
Message-Id: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
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
v3:
 - Use helper function
v2:
 - Pass in pre-masked value

 arch/riscv/include/asm/mmu_context.h | 2 ++
 arch/riscv/mm/context.c              | 5 +++++
 arch/riscv/mm/tlbflush.c             | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/as=
m/mmu_context.h
index 7030837adc1a..94e82c9e17eb 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -16,6 +16,8 @@
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
=20
+unsigned long get_mm_asid(struct mm_struct *mm);
+
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..14aec5bacbc1 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -302,6 +302,11 @@ static inline void flush_icache_deferred(struct mm_s=
truct *mm, unsigned int cpu)
 #endif
 }
=20
+unsigned long get_mm_asid(struct mm_struct *mm)
+{
+	return atomic_long_read(&mm->context.id) & asid_mask;
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task)
 {
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 37ed760d007c..9c89c4951bee 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -42,7 +42,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm,=
 unsigned long start,
 	/* check if the tlbflush needs to be sent to other CPUs */
 	broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 	if (static_branch_unlikely(&use_asid_allocator)) {
-		unsigned long asid =3D atomic_long_read(&mm->context.id);
+		unsigned long asid =3D get_mm_asid(mm);
=20
 		if (broadcast) {
 			sbi_remote_sfence_vma_asid(cmask, start, size, asid);
--=20
2.35.1


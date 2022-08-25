Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A15A0734
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiHYCP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHYCPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:15:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E843318
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:15:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33daeaa6b8eso30006977b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc;
        bh=hlkbdSh3RrDmPIg3ch7MrZraM/QcXY+MEJi9qJyXRE8=;
        b=FCCvVahDxyEe8oFcjbRaWbbqarZyrgGFoEre52IVhq5uKLHfuiHMqA33QONlyEC2Eg
         3o27wqz72oC88bbjmE5I8H3dC7BJ+jILWkjsHkhhMzQ1IyuHSLLB2HNL1CNzJBIxl+O4
         +ndxTbU4CFOix0jZhN0xFNliZYhih6De/JAlTGeYTnuMi02htuFlBt9wcgjtBzXx4YLU
         QIcDF4zIZE3Tb20alkdIyJeJHR1PjMJ4D94gvKOnGh+XVBIcbmQ7D4lT9UJ2OoyFjuCc
         gic9ZwOVU9PQt0dkSv6i7P/7tFbpltQH8zP50PoCZ+vy4w0QisX7BFnd8+ujDmSaa30Y
         Q5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc;
        bh=hlkbdSh3RrDmPIg3ch7MrZraM/QcXY+MEJi9qJyXRE8=;
        b=vw8O2tFPU74bwUp+FczKCPb7ijR0etu2Oa0+bPVyt1EUb4LI36LGNS807w6lx8CBTZ
         I1M7gD7J5oZPi3A0Bsype+x17MTXCl2FKO3AS1lG/uXyrQB63+hXo9ZS0X588nJZhOJ1
         fijH/yItIKYoR0F20KC1KTsyOE4OkSCKZV8qwFJOFknUo3P/xsz8PQyovml9/EWSHRHy
         Crpe9FOr8GCL48e8mkNYP+vGTVvVgMhaIkncXEqTlwOWu13dGQ63hILXE795PH2eUbks
         AgFjnHd8BuyEHNuASF2QlBS/n0UijYd7MagICcHLS97hl2/Ww+Bxv0RAk3UYG11TIQ0g
         5iSg==
X-Gm-Message-State: ACgBeo184/aK9zNf2L58VvGIP1T5kwrFlqAz7Mb9smocWFNFRdzEXGOn
        vJG7SkrOVhmBeSqaE8FqYK2rIGRHY8Ev
X-Google-Smtp-Source: AA6agR6uZKuzUbVoRoyMSYTVwhzWKNZiSeTbS/Woz+IcgAmSSPRTj767sPQUTEPmWHRI/WonpuvfvupHu5A6
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:ee67:952c:dac7:b56])
 (user=eugenis job=sendgmr) by 2002:a25:dd0:0:b0:695:87f3:f2e6 with SMTP id
 199-20020a250dd0000000b0069587f3f2e6mr1593766ybn.263.1661393752119; Wed, 24
 Aug 2022 19:15:52 -0700 (PDT)
Date:   Wed, 24 Aug 2022 19:15:32 -0700
Message-Id: <20220825021532.1175943-1-eugenis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] arm64: mte: move register initialization to C
From:   Evgenii Stepanov <eugenis@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Kenny Root <kroot@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If FEAT_MTE2 is disabled via the arm64.nomte command line argument on a
CPU that claims to support FEAT_MTE2, the kernel will use Tagged Normal
in the MAIR. If we interpret arm64.nomte to mean that the CPU does not
in fact implement FEAT_MTE2, setting the system register like this may
lead to UNSPECIFIED behavior. Fix it by arranging for MAIR to be set
in the C function cpu_enable_mte which is called based on the sanitized
version of the system register.

There is no need for the rest of the MTE-related system register
initialization to happen from assembly, with the exception of TCR_EL1,
which must be set to include at least TBI1 because the secondary CPUs
access KASan-allocated data structures early. Therefore, make the TCR_EL1
initialization unconditional and move the rest of the initialization to
cpu_enable_mte so that we no longer have a dependency on the unsanitized
ID register value.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Evgenii Stepanov <eugenis@google.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/linux-arm-kernel/YwCsIm2nCXCEEgAd@arm.com/T/
Link: https://linux-review.googlesource.com/id/I2c7df6bd4ea2dfc59376a8b9b5d=
3562b015c7198
X-PCC-To: Catalin Marinas <catalin.marinas@arm.com>
X-PCC-Cc: Evgenii Stepanov <eugenis@google.com>, Marc Zyngier <maz@kernel.o=
rg>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@ar=
m.com>, Andrey Konovalov <andreyknvl@gmail.com>, Mark Brown <broonie@kernel=
.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel=
@vger.kernel.org>
---
Changelog since v1:
- Keep TBI1 off unless CONFIG_ARM64_MTE
- Fixed mask application in the RGSR_EL1 computation (bug found by Kenny
  Root).
- Changed code formatting

 arch/arm64/kernel/cpufeature.c | 40 +++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S           | 46 ++++------------------------------
 2 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.=
c
index 907401e4fffb1..9692e75e2ee44 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2030,8 +2030,48 @@ static void bti_enable(const struct arm64_cpu_capabi=
lities *__unused)
 #ifdef CONFIG_ARM64_MTE
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	u64 rgsr;
+
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
+
+	/*
+	 * CnP must be enabled only after the MAIR_EL1 register has been set
+	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
+	 * lead to the wrong memory type being used for a brief window during
+	 * CPU power-up.
+	 *
+	 * CnP is not a boot feature so MTE gets enabled before CnP, but let's
+	 * make sure that is the case.
+	 */
+	BUG_ON(read_sysreg(ttbr0_el1) & TTBR_CNP_BIT);
+	BUG_ON(read_sysreg(ttbr1_el1) & TTBR_CNP_BIT);
+
+	/* Normal Tagged memory type at the corresponding MAIR index */
+	sysreg_clear_set(mair_el1,
+			 MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED),
+			 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED,
+				      MT_NORMAL_TAGGED));
+
+	write_sysreg_s(KERNEL_GCR_EL1, SYS_GCR_EL1);
+
+	/*
+	 * If GCR_EL1.RRND=3D1 is implemented the same way as RRND=3D0, then
+	 * RGSR_EL1.SEED must be non-zero for IRG to produce
+	 * pseudorandom numbers. As RGSR_EL1 is UNKNOWN out of reset, we
+	 * must initialize it.
+	 */
+	rgsr =3D (read_sysreg(CNTVCT_EL0) & SYS_RGSR_EL1_SEED_MASK) <<
+	       SYS_RGSR_EL1_SEED_SHIFT;
+	if (rgsr =3D=3D 0)
+		rgsr =3D 1 << SYS_RGSR_EL1_SEED_SHIFT;
+	write_sysreg_s(rgsr, SYS_RGSR_EL1);
+
+	/* clear any pending tag check faults in TFSR*_EL1 */
+	write_sysreg_s(0, SYS_TFSR_EL1);
+	write_sysreg_s(0, SYS_TFSRE0_EL1);
+
 	isb();
+	local_flush_tlb_all();
=20
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 7837a69524c53..870e1b259ef7b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -48,17 +48,19 @@
=20
 #ifdef CONFIG_KASAN_HW_TAGS
 #define TCR_MTE_FLAGS TCR_TCMA1 | TCR_TBI1 | TCR_TBID1
-#else
+#elif defined(CONFIG_ARM64_MTE)
 /*
  * The mte_zero_clear_page_tags() implementation uses DC GZVA, which relie=
s on
  * TBI being enabled at EL1.
  */
 #define TCR_MTE_FLAGS TCR_TBI1 | TCR_TBID1
+#else
+#define TCR_MTE_FLAGS 0
 #endif
=20
 /*
  * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory=
 and
- * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ * changed during cpu_enable_mte to Normal Tagged if the system supports M=
TE.
  */
 #define MAIR_EL1_SET							\
 	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
@@ -426,46 +428,8 @@ SYM_FUNC_START(__cpu_setup)
 	mov_q	mair, MAIR_EL1_SET
 	mov_q	tcr, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
-
-#ifdef CONFIG_ARM64_MTE
-	/*
-	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
-	 * (ID_AA64PFR1_EL1[11:8] > 1).
-	 */
-	mrs	x10, ID_AA64PFR1_EL1
-	ubfx	x10, x10, #ID_AA64PFR1_MTE_SHIFT, #4
-	cmp	x10, #ID_AA64PFR1_MTE
-	b.lt	1f
-
-	/* Normal Tagged memory type at the corresponding MAIR index */
-	mov	x10, #MAIR_ATTR_NORMAL_TAGGED
-	bfi	mair, x10, #(8 *  MT_NORMAL_TAGGED), #8
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
=20
-	mov	x10, #KERNEL_GCR_EL1
-	msr_s	SYS_GCR_EL1, x10
-
-	/*
-	 * If GCR_EL1.RRND=3D1 is implemented the same way as RRND=3D0, then
-	 * RGSR_EL1.SEED must be non-zero for IRG to produce
-	 * pseudorandom numbers. As RGSR_EL1 is UNKNOWN out of reset, we
-	 * must initialize it.
-	 */
-	mrs	x10, CNTVCT_EL0
-	ands	x10, x10, #SYS_RGSR_EL1_SEED_MASK
-	csinc	x10, x10, xzr, ne
-	lsl	x10, x10, #SYS_RGSR_EL1_SEED_SHIFT
-	msr_s	SYS_RGSR_EL1, x10
-
-	/* clear any pending tag check faults in TFSR*_EL1 */
-	msr_s	SYS_TFSR_EL1, xzr
-	msr_s	SYS_TFSRE0_EL1, xzr
-
-	/* set the TCR_EL1 bits */
-	mov_q	x10, TCR_MTE_FLAGS
-	orr	tcr, tcr, x10
-1:
-#endif
 	tcr_clear_errata_bits tcr, x9, x5
=20
 #ifdef CONFIG_ARM64_VA_BITS_52
--=20
2.37.1.595.g718a3a8f04-goog


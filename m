Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B134EBBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbiC3HgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiC3HgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:36:06 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE694217C63
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648625656; x=1680161656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K672uUqxDrF7zy+d+ns9cy66tx5nctnpny9P8BPsp1w=;
  b=n55WPeU4Ov4RBaKlW+ObpBt4Gxa006IxUpPDLV7Og1oqb0bs43udtL4E
   PL3+Wn2xCVPNQ2nGeaO80jPHRoL9w3E2p7P5jj6A/Kxnnmy6sPWKiaHet
   ptlTr4qbxFMGB30HZwActIQLoBJXL92fGlskMmOaKNznWBK14SM1h+p3w
   M3h2oVCt8bUBWtlcvzSdGq5V34Q3HkBlyEIi+O/rAOSMqeZ0lcbhns6/Q
   BXWB8A0edWOWQRtAoN3ArCj9xsSnOhKXnz9nDAZZl/P/OVDE1tVFedAVA
   qawZOcfhMLF92Ig07Cw/6UkDB8C3QmXiOTishoP4GH9PGYjspmADkcC42
   w==;
X-IronPort-AV: E=Sophos;i="5.90,222,1643644800"; 
   d="scan'208";a="195504235"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 15:34:00 +0800
IronPort-SDR: x+Cqs+hkbgI9vuYjm5snrQn193WNpZGGT20l7DKmlWzlYk0QleaQb0KVdYPtDjWy19WsFwEb73
 UVjgCBDXW8CR0j41EQ3aeNrhLGa8VC6yROFiG/X/F8I6u0JzQDVB5Jo5p/2etnPujBU6kd6z7C
 lvLynZQENfFzF6+SAQ9+S5m/wPuS2DlZWyIKvqlqQvB8GOYnNqv3cBbEGzXrLrLP7hGb7zzCfB
 XR6PpyD3djR70Ellc0vmINDLkcxuDX1GnHxI13xV1/dun7fFAkZiXYV8uWsylxolqHdoIhdlxE
 LDTDhyCtd5OXmRG5mq6GRCib
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 00:04:51 -0700
IronPort-SDR: vucboqE6RKTKOV4ayKu7cGEJD8dnqhFaAOPTvogC1jyKg+q53X788/KKIeLQoSpiPKxh4IhT2z
 CsSnDVrBCt5Afw8Lq0wZIw4VrPwVYGllDWahJy5i7fHC9NtR2N1bn4b0vMl5rDwCxDyZrwXL5w
 KfkxiWuUSL62IDLMYgz3fzKHwTv1LQjvQI2rbq8BkJZUd755AVQ6bCLtrY5nEjqbKEIW9uI9tg
 YecbxXO2djZY8NsR4tiTZLHo76eywYB2zOZTOFOFE+0mkLaD8XNlV4FnPV8kRoZGtr9UQ5jznr
 Xr0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 00:34:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KSyqD0PqKz1SVp3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:34:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1648625639;
         x=1651217640; bh=K672uUqxDrF7zy+d+ns9cy66tx5nctnpny9P8BPsp1w=; b=
        Z6SGtjn0tLBh5p1+VQlUazr7x1EUmEPQPc9QtjkVF5pqPwRKgtuuAzX2sA1RhYGN
        Db+QdscNUdkM1UllHLT+EBdZ8NArST/950LzyjGdlwocfpksG1uycISIFmvTEukA
        7/QIih1SPddp4ZwzgtbiKEdZyupBTtHCST3TmcTc6uLnn5oRqqlfCRxICkWCIbHo
        uwdKI0DlkTk3O6VHd/PoFg/r0yVBnWObH/a814MBsDjmzCjH4RHp7IM+oPaS9WyI
        8Z0L7PrAY6LZHrErfqoF2sjjoT/eMxG3iFcGbNTkmzTolaPQIZDC1+9Dh2wnv5QZ
        4EhH81YvTiXqSbqmXo0mkw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XfwPolyCKbZS for <linux-kernel@vger.kernel.org>;
        Wed, 30 Mar 2022 00:33:59 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.112])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KSyq54rsgz1Rvlx;
        Wed, 30 Mar 2022 00:33:53 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-kernel@vger.kernel.org, atishp@rivosinc.com,
        guoren@kernel.org, anup@brainfault.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] riscv: Ensure only ASIDLEN is used for sfence.vma
Date:   Wed, 30 Mar 2022 17:33:47 +1000
Message-Id: <20220330073347.3898802-1-alistair.francis@opensource.wdc.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/mm/context.c  | 2 +-
 arch/riscv/mm/tlbflush.c | 4 ++--
 include/linux/mm_types.h | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

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
index 37ed760d007c..4469615aa07f 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -10,7 +10,7 @@ static inline void local_flush_tlb_all_asid(unsigned lo=
ng asid)
 {
 	__asm__ __volatile__ ("sfence.vma x0, %0"
 			:
-			: "r" (asid)
+			: "r" (asid & asid_mask)
 			: "memory");
 }
=20
@@ -19,7 +19,7 @@ static inline void local_flush_tlb_page_asid(unsigned l=
ong addr,
 {
 	__asm__ __volatile__ ("sfence.vma %0, %1"
 			:
-			: "r" (addr), "r" (asid)
+			: "r" (addr), "r" (asid & asid_mask)
 			: "memory");
 }
=20
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


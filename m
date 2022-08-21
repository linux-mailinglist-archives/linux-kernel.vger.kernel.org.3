Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8959B120
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 03:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiHUBAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 21:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiHUBAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 21:00:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A101E3EA;
        Sat, 20 Aug 2022 18:00:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b5so4901910wrr.5;
        Sat, 20 Aug 2022 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=a4jNHFHiClDdq/v49nsMbA8I7HwKAy8R6hrK4YLcETg=;
        b=AXPnI89Txz85BoWVYAFCMtMPbQcGFSRW9UnKTu6iScu4HS0WqlGWSD9JtoSlTj70EP
         mZiagAyiMBkanQ7JZ7mBCJueCAvdX0+/UkZ5D5VPGYEnOaqT1tXH7H/xw0T3hQwXlC4b
         vl3orITND69HNkgeXNp56lMh5QVGVWA5jAYDKERihJAGkVIx2trU73w2i7dh/BNDJG82
         Ep9cwajpDz7iBIOmLCm7ODT7JtrbCTr+rduE9jiQ8cfpX/PEGHjP6Aai1P6VFTImcO66
         kcYtnqjcC7Pzq/JWMdynbGRSoowQgEZszBEltfRK6NHhRu5PdcmWfqmcUQpXi9TGhooV
         Wu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=a4jNHFHiClDdq/v49nsMbA8I7HwKAy8R6hrK4YLcETg=;
        b=ahZsxp3B0FV/o0aUGOymNfH7V5PhlR7ak6f75t8mZAfbO012oLJnzkeV664RoxE2XI
         idku2LYObldQH2RFAzhI+WE19VHFwWR00OG5ZLpB9XRp2UZS4zAj4rKdEWeYbyOMxb9p
         SKFCXQlMQj7cwyWodCkin1WkjXxEwF6qr/7hSP6LXZ7s8vriZS29Vn0rg7b5nsS2F/I7
         zpYY2mJ2fHjo2eod7Ne19qTWT0Fktv381/maGB3CtotIV0ni1HVINyk8vTkx8FHkzL1d
         mOL/Bi1sknhsiQkczioFFeB3aSL0If36EUK9wjTsvVR99f4ohBI6HKQ/u979BSIEzPhK
         cNOg==
X-Gm-Message-State: ACgBeo1hWGogJeLIqGxF1VzYBPIDxzeJJu7ZmzFimkdMO9ztuTpOSNaq
        1LqCtM5LQu2NKMkgwGA6DbJ8AeASKFc=
X-Google-Smtp-Source: AA6agR5zLE9kQ65fXHG6rjjR2ZpdPg7mUbxbgX8Wf/KmxTkJHk+7GWOjEPvnFelVMh/hMofl4rxKbg==
X-Received: by 2002:adf:f208:0:b0:225:25e6:c964 with SMTP id p8-20020adff208000000b0022525e6c964mr7555213wro.531.1661043647749;
        Sat, 20 Aug 2022 18:00:47 -0700 (PDT)
Received: from localhost.localdomain ([185.192.68.223])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003a2e92edeccsm12148515wmp.46.2022.08.20.18.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 18:00:44 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] powerpc: disable sanitizer in irq_soft_mask_set
Date:   Sun, 21 Aug 2022 09:00:30 +0800
Message-Id: <20220821010030.97539-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ppc, compiler based sanitizer will generate instrument instructions
around statement WRITE_ONCE(local_paca->irq_soft_mask, mask):

   0xc000000000295cb0 <+0>:	addis   r2,r12,774
   0xc000000000295cb4 <+4>:	addi    r2,r2,16464
   0xc000000000295cb8 <+8>:	mflr    r0
   0xc000000000295cbc <+12>:	bl      0xc00000000008bb4c <mcount>
   0xc000000000295cc0 <+16>:	mflr    r0
   0xc000000000295cc4 <+20>:	std     r31,-8(r1)
   0xc000000000295cc8 <+24>:	addi    r3,r13,2354
   0xc000000000295ccc <+28>:	mr      r31,r13
   0xc000000000295cd0 <+32>:	std     r0,16(r1)
   0xc000000000295cd4 <+36>:	stdu    r1,-48(r1)
   0xc000000000295cd8 <+40>:	bl      0xc000000000609b98 <__asan_store1+8>
   0xc000000000295cdc <+44>:	nop
   0xc000000000295ce0 <+48>:	li      r9,1
   0xc000000000295ce4 <+52>:	stb     r9,2354(r31)
   0xc000000000295ce8 <+56>:	addi    r1,r1,48
   0xc000000000295cec <+60>:	ld      r0,16(r1)
   0xc000000000295cf0 <+64>:	ld      r31,-8(r1)
   0xc000000000295cf4 <+68>:	mtlr    r0

If there is a context switch before "stb     r9,2354(r31)", r31 may
not equal to r13, in such case, irq soft mask will not work.

This patch disable sanitizer in irq_soft_mask_set.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear PPC developers

I found this bug when trying to do rcutorture tests in ppc VM of
Open Source Lab of Oregon State University following Paul E. McKenny's guidance.

console.log report following bug:

[  346.527467][  T100] BUG: using smp_processor_id() in preemptible [00000000] code: rcu_torture_rea/100^M
[  346.529416][  T100] caller is rcu_preempt_deferred_qs_irqrestore+0x74/0xed0^M
[  346.531157][  T100] CPU: 4 PID: 100 Comm: rcu_torture_rea Tainted: G        W          5.19.0-rc5-next-20220708-dirty #253^M
[  346.533620][  T100] Call Trace:^M
[  346.534449][  T100] [c0000000094876c0] [c000000000ce2b68] dump_stack_lvl+0xbc/0x108 (unreliable)^M
[  346.536632][  T100] [c000000009487710] [c000000001712954] check_preemption_disabled+0x154/0x160^M
[  346.538665][  T100] [c0000000094877a0] [c0000000002ce2d4] rcu_preempt_deferred_qs_irqrestore+0x74/0xed0^M
[  346.540830][  T100] [c0000000094878b0] [c0000000002cf3c0] __rcu_read_unlock+0x290/0x3b0^M
[  346.542746][  T100] [c000000009487910] [c0000000002bb330] rcu_torture_read_unlock+0x30/0xb0^M
[  346.544779][  T100] [c000000009487930] [c0000000002b7ff8] rcutorture_one_extend+0x198/0x810^M
[  346.546851][  T100] [c000000009487a10] [c0000000002b8bfc] rcu_torture_one_read+0x58c/0xc90^M
[  346.548844][  T100] [c000000009487ca0] [c0000000002b942c] rcu_torture_reader+0x12c/0x360^M
[  346.550784][  T100] [c000000009487db0] [c0000000001de978] kthread+0x1e8/0x220^M
[  346.552555][  T100] [c000000009487e10] [c00000000000cd54] ret_from_kernel_thread+0x5c/0x64^M

After 12 days debugging, I finally narrow the problem to irq_soft_mask_set.

I am a beginner, hope I can be of some beneficial to the community ;-)

Thanks
Zhouyi
--
 arch/powerpc/include/asm/hw_irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 26ede09c521d..a5ae8d82cc9d 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -121,7 +121,7 @@ static inline notrace unsigned long irq_soft_mask_return(void)
  * for the critical section and as a clobber because
  * we changed paca->irq_soft_mask
  */
-static inline notrace void irq_soft_mask_set(unsigned long mask)
+static inline notrace __no_kcsan __no_sanitize_address void irq_soft_mask_set(unsigned long mask)
 {
 	/*
 	 * The irq mask must always include the STD bit if any are set.
-- 
2.34.1


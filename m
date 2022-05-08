Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4817051EAE8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 04:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352236AbiEHCc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 22:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEHCc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 22:32:56 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF865FA4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 19:29:02 -0700 (PDT)
X-QQ-mid: bizesmtp64t1651976826tvmg9h3r
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:27:05 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: FXvDfBZI5O5f6PogLChBEkRd/taD9BhPoeCfIHm9UnB0cKmQa1Hq07nXuuryo
        SjwX4LZeftZ5jc7K0kkN8HluCt1m6fVm6w+PTFw6ucKoPU6iq5JTuBeHASkJc2vdQH/f5Ef
        6xKT8O06nP4NwFAbadrfFlgh7qbY7XX0rF20MC4CFVCX2hrPPoMpw0BbuG1TUuvgaeMbtvQ
        uBNf8LxzIlydiFCd1rn9XMNPVitLkGylIz0IpMEx3wZzWiSJbjPk1AMHQ1sTMFZCZCFwukc
        9SxhRKKS9qSTLCK96wctodMkKCWbECIrTwt9NA3AQoqVaw6s/twAK2pdr5u9dQsZ1n0xsWM
        kBGUVQr//8Ta3tok8C4KCHbEbE7gQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     yury.norov@gmail.com
Cc:     wangborong@cdjrlc.com, akpm@linux-foundation.org,
        Julia.Lawall@inria.fr, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/ia64: no need to initialise statics to 0
Date:   Sun,  8 May 2022 10:26:28 +0800
Message-Id: <20220508022628.96501-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/ia64/mm/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 7a2d608fba74..854e90c4e7eb 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -84,7 +84,7 @@ wrap_mmu_context (struct mm_struct *mm)
 		flush_bit = xchg(&ia64_ctx.flushmap[i], 0);
 		ia64_ctx.bitmap[i] ^= flush_bit;
 	}
- 
+
 	/* use offset at 300 to skip daemons */
 	ia64_ctx.next = find_next_zero_bit(ia64_ctx.bitmap,
 				ia64_ctx.max_ctx, 300);
@@ -144,7 +144,7 @@ static inline void up_spin(struct spinaphore *ss)
 static struct spinaphore ptcg_sem;
 static u16 nptcg = 1;
 static int need_ptcg_sem = 1;
-static int toolatetochangeptcgsem = 0;
+static int toolatetochangeptcgsem;
 
 /*
  * Kernel parameter "nptcg=" overrides max number of concurrent global TLB
-- 
2.35.1


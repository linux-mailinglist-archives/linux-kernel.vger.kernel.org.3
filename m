Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69C56B409
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiGHIFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiGHIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:05:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA380488
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:05:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so1180048pjr.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpsViEXZYHaSKdo2Y5tfQa2GHPWQpzwRjvyBNJo59WU=;
        b=QD+aXyufjYV5Rhg7g9mfLcGxaoTj7cmPQTrt3D9uRtWwYIH8z6Valy/m/ZlLU7GeiT
         1EnfnMAEEekJP2mj88bW+jDYHsM+CJ5HSgYc03i+rLDa/K26IcLX7dDBB8n8qZWjD6Pk
         1/WG8KcKtyXf2eHl6M0nDWp3YEfU+dkn1DAACfrWjXSt6kPCHsuhmG4pk6jtiRZRJFLV
         Or/krkaK+/Hc2bddE6KxyoiuQ5W5z3Sk/MRH1seFkab8gN0j6IHeiC4CKI2ZNb5JjwIN
         GiMozYnu5loweh0SxxE/VnRPyHhT+dKJRkCKtm3rSmU962lysfmEkrp88Ejw531Rluop
         WCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpsViEXZYHaSKdo2Y5tfQa2GHPWQpzwRjvyBNJo59WU=;
        b=vCQ+UYIVZ/MWiE94FRr2wh03KFXPnNinDmbkrsbMenwgR+1sFP/2XZVvpuyCTLQY+7
         AJVVJfxyVLDx5XNjcDQNz6xBAtyrHacyZwQXn52elH6nCD+ZmqJPNpOkvk95cjbKIEpY
         eTegR8yGSJVCZR4BlWJXWvO8MTv6AgTn5kTFPZc/lZIJ8kBmZR4jQcqpgTvVnI9bJ1Uo
         ktQl/KWTqjHWc8GZJoqzPsigZ5ZUtuHRYh4n0/xVLHyjTWXF4H6uTeSoUDEJVP9s+T3Z
         jzS6d0n8u6MTKMk1eGfWXKZQwks26y4sY4bOkC0ww4IOcMbUsvKGoF3e2BgCtyg23HmT
         WJIw==
X-Gm-Message-State: AJIora/CTLX/O+SQfeTRaM32Y2C8Uzbp9oTyROFarRBQZPXDbTX7eAcc
        5K0zrJfSFfabIa1Fap0vbMMwB8MAdjo=
X-Google-Smtp-Source: AGRyM1uaRRfDeP9jrOYeJppPRbXd05sAchFcz1uJ3YbkZdmE4BJ78z/Mok35DRObt1hqvwYOPFO2Pw==
X-Received: by 2002:a17:902:bd43:b0:16b:953d:9e0e with SMTP id b3-20020a170902bd4300b0016b953d9e0emr2269539plx.63.1657267530175;
        Fri, 08 Jul 2022 01:05:30 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e11-20020a6558cb000000b00408b89e4282sm27207738pgu.47.2022.07.08.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:05:29 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Date:   Thu,  7 Jul 2022 17:30:53 -0700
Message-Id: <20220708003053.158480-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
possible") introduced an optimization of skipping the flush if the TLB
generation that is flushed (as provided in flush_tlb_info) was already
flushed.

However, arch_tlbbatch_flush() does not provide any generation in
flush_tlb_info. As a result, try_to_unmap_one() would not perform any
TLB flushes.

Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
anyhow is an invalid generation value.

In addition, add the missing unlikely() and jump to get tracing right.

Fixes: aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when possible")
Reported-by: Hugh Dickins <hughd@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d9314cc8b81f..d81b4084bb8a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -771,14 +771,14 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
-	if (f->new_tlb_gen <= local_tlb_gen) {
+	if (unlikely(f->new_tlb_gen != 0 && f->new_tlb_gen <= local_tlb_gen)) {
 		/*
 		 * The TLB is already up to date in respect to f->new_tlb_gen.
 		 * While the core might be still behind mm_tlb_gen, checking
 		 * mm_tlb_gen unnecessarily would have negative caching effects
 		 * so avoid it.
 		 */
-		return;
+		goto done;
 	}
 
 	/*
-- 
2.25.1


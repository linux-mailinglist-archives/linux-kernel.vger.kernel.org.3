Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C04BFF72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiBVQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiBVQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:57:38 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00716BFAD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:57:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11460so145910127b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=knnzmuohJ2ih2y2NTiUEzUxj92qYLV4FmoYUekHSvUw=;
        b=tazhhxtdUk3rQttzgDm+V0n+dY4v2ZnB4i8xG8ax2HZdSoHAffJo42UTzU3IHvzAqj
         CzDDQtHudJDmOpjvt+NTOxsHiMMcd5AR1KeV4KZ04Anj9Hvg2wo5WdkKx0uhJOAuX1UG
         DMG5h+1UR544FLvyjxNA1/VvkZavi0pxiwKfoHP3qdoBAJ8849pS8kTNoGD5QX5f9/Px
         48yknJpXBRw8xvBSwtZigYe1MGyv8eQBBWwjuMT8BSujAmFufVqRsnYE2LCmZqywZs8i
         wJddWj0UZSrpFMMQpEijc1j/Xch9CqJ1J2YUynBS8lvvuY7OGu4etP9u4qE8wqmUHhIw
         yLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=knnzmuohJ2ih2y2NTiUEzUxj92qYLV4FmoYUekHSvUw=;
        b=Xe91ktN0nz4w2p6o9pV1v0wApCbo6UaLaeuPYe45EQbzSk64vQZvT72LAB9FO9RrmX
         xN5Wg8mZ4aBISVHiinRGGt5aYR5PpjCCM40Zl/0+mwECR581bifkJyipKWhc2dZ4RNL6
         kvpoz2aXJbfrXoguQ4ynICHKbbZ3xNv5kdigDG5vE82x1Qj7MawXuufXgpHG2X+jk+17
         j+Wpnt9zwM9+0lpFs5dhtiT3W2h9ZjwbVSXUZHTnncr0RCGmQjLoeoY8ljVa6lgbciA8
         tdSSdwDokx577mWJZ+sFc4ipEXCP56AVkN3QJZGPtE5l0QRMZP1sMIYa0TqfFfPpjHQ6
         c9Tw==
X-Gm-Message-State: AOAM533n76ItwTRSOBBPIpeh+7FaW4OiC4J7NMks7qREoj/z04nSlB16
        OZMv4ni8o3w57ntUAI41J0IBjqRWNd3WoztbZg==
X-Google-Smtp-Source: ABdhPJxsM9h50TZI3B0JLyBOhiXv0umcrv6dsBugtZNBeZtlKN8O9HTo3L2ie+qpRSFxA92HD2CPBV8kKYkIX9PJAQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a25:4cc1:0:b0:623:ca02:c1e5 with SMTP
 id z184-20020a254cc1000000b00623ca02c1e5mr22952503yba.95.1645549030879; Tue,
 22 Feb 2022 08:57:10 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:05 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 4/9] KVM: arm64: Add guard pages for pKVM (protected nVHE)
 hypervisor stack
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maps the stack pages in the flexible private VA range and allocates
guard pages below the stack as unbacked VA space. The stack is aligned
to twice its size to aid overflow detection (implemented in a subsequent
patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 27af337f9fea..69df21320b09 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -105,11 +105,28 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 		if (ret)
 			return ret;
 
-		end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va;
+		/*
+		 * Private mappings are allocated upwards from __io_map_base
+		 * so allocate the guard page first then the stack.
+		 */
+		start = (void *)pkvm_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
+		if (IS_ERR_OR_NULL(start))
+			return PTR_ERR(start);
+
+		/*
+		 * The stack is aligned to twice its size to facilitate overflow
+		 * detection.
+		 */
+		end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_pa;
 		start = end - PAGE_SIZE;
-		ret = pkvm_create_mappings(start, end, PAGE_HYP);
-		if (ret)
-			return ret;
+		start = (void *)__pkvm_create_private_mapping((phys_addr_t)start,
+					PAGE_SIZE, PAGE_SIZE * 2, PAGE_HYP);
+		if (IS_ERR_OR_NULL(start))
+			return PTR_ERR(start);
+		end = start + PAGE_SIZE;
+
+		/* Update stack_hyp_va to end of the stack's private VA range */
+		per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va = (unsigned long) end;
 	}
 
 	/*
-- 
2.35.1.473.g83b2b277ed-goog


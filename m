Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8CC4C234B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiBXFTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiBXFTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:19:47 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A917E363
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:19:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11462so11767017b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=Sc96glvxYslSfkQXo+KXiEGMpwz7KGQFqK1SBX4eD7A=;
        b=B8lXlAgDd0kVzKodKmL9JcM1dcJSITQumRTkFniujZawZDAhk4wZn+DpIQLhUYO/ch
         /iD4fAJgbvRXUaHirgctgj7pLUQblkrrsAEJMibl5VJvqZTLUgl49dAk/yK8WdVz6O83
         u40dS8aCwVHlq3RLEMzMPcZbJLQzQK8GbGi9dh9cBMwbfhbfitEzE3/zjkDAaPEfZ/kf
         tG4sTtq9tpZQfTqmU+TA7/OqoQH7nrxa151lCTPVRM1WDtWmB9kRigE239E2/Tc9/Jqz
         41uBcTKbyjiUJdTcleBYvwYHxaKNIGvnY6iTRF8DBO069ux3kEvruXCti9dxa2D7yM4V
         im7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Sc96glvxYslSfkQXo+KXiEGMpwz7KGQFqK1SBX4eD7A=;
        b=OuVVNQg3Vqu6TVkJDuL8rl4L8vIMX3/4a2z3rbMK/DsKh+oie15T/hjfD2MNmypEmj
         OUFnzT9tx2JJuPfa6A+0ABf+ZOBVgDCTaNP72XDAXVPl2R+ue7GHH+Qrx9WmbBtIKkyw
         SiwCvOlqKkrIFtn82eNGi4Fme+ONF4FzA4ej2TXode83nMcGcTHC4BH4jYPrg2DcK15A
         0rkY1lanwhFZvIvZN2puTzF7vGPFQ7NpYhONIPFjwBwEVcfPnwT7ouJ25o8UHLS/efYH
         /45OEliQsmLWu+Y2umk+aPrcSRxAZsvLBxPIfhsC46SJuWIq2SfRjhX+iL0eVjkvbjKN
         C++A==
X-Gm-Message-State: AOAM5318Huxo5cYhHcuuNdALpnJEWrL9NELPuOyD1nW+OkD8Vuvdx3Kw
        q2KMT6LQNs6ELhRqxKnSUuB+f/HsMrFBCPffOQ==
X-Google-Smtp-Source: ABdhPJzBUzrWz/IzDAYDQ8eab8JhoYZDYi700gxVQBn86Vj1XDP4YQZMrJTSKaYcX0VoNCNeGZXoRp+1Cxz/wmOKKw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:415c:9be0:c461:440a])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d449:0:b0:619:c1f1:928b with SMTP
 id m70-20020a25d449000000b00619c1f1928bmr968656ybf.19.1645679957716; Wed, 23
 Feb 2022 21:19:17 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:13:39 -0800
In-Reply-To: <20220224051439.640768-1-kaleshsingh@google.com>
Message-Id: <20220224051439.640768-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 4/8] KVM: arm64: Add guard pages for pKVM (protected nVHE)
 hypervisor stack
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Scull <ascull@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
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

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark

 arch/arm64/kvm/hyp/nvhe/setup.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 27af337f9fea..5f3a4002f9c5 100644
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
+			return start ? PTR_ERR(start) : -ENOMEM;
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
+			return start ? PTR_ERR(start) : -ENOMEM;
+		end = start + PAGE_SIZE;
+
+		/* Update stack_hyp_va to end of the stack's private VA range */
+		per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va = (unsigned long) end;
 	}
 
 	/*
-- 
2.35.1.473.g83b2b277ed-goog


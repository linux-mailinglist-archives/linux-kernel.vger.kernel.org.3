Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892844C3C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiBYDn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiBYDnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:43:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8131986FB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:42:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11462so19890757b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=TYfrDDnCDZLgsaXn4hYzYqjwtRqrff+8WzYcoEgftOI=;
        b=q7666YkutUkL6RKXDHN6uW1bfeRRma2VbYbkjuziO8kN3Ez+AvP99CPA+crFQIMyGM
         u8V98l/kcyJmZrAMYC8lp0VZdsx7hfOnk0og8Iyu8/EPTcDyOrtXaylNfruGAYrBELML
         0t4kJOa3EW5NNbIbFy4ls3stZzs7gzcL6saNGB+qXhJn3B64HD/5jMrLH5g2Qj/oJRUN
         C3NdGCf8ofRIATki5ntXpIdGQYYOMg+4xfPq2uDJ2UMg5PbTBm+zuybq7cU5vTAp9A5R
         OadOj9nn2g7Sk/FRIHG0Q30twQG0Zl6SxdUGzB8zR5q1zrX1sy32E1VtmvDod4V091/Q
         RyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=TYfrDDnCDZLgsaXn4hYzYqjwtRqrff+8WzYcoEgftOI=;
        b=tAk+GRB/lLiY03J1G7Jean5wqztwfRgrUovOomyEYI/uKtfjH+WGhKdMGBKsQ9McLv
         66GZ/wk7qZFBUNJFg26za0X9N3z8UAOEskQWIjzocRjd52kpRlHd0Ka/D7Mx+SNR8KX9
         JPMRUFWRHQlIPDQzah4twzSevnTVe/Mr3SbJhPAMCC2sCwca3CFgyqAFLCRDD+OqMquV
         lUXngLUI6CxgTJGbR309W9sbSfQjSpPTXS7uB2WHKRsIT+V8CRzoc5ozG3NuCJFCQZNH
         ocFqK9Bfl8BD3dS4aJZefgkdPEb/AuEQZYvBBxk4fdI+uApIZFqLostJSspZ3PhhFGh3
         WRqA==
X-Gm-Message-State: AOAM533cY2aUkmcTqZVEQifkqG4OR89SgshxTzcjdro/zkfYkX8KHLM2
        eNx3zR4m9v+bz8X/sHUTIOlt0AidEwuL7IQHEA==
X-Google-Smtp-Source: ABdhPJyuZ08nciNdihLr0dH67Rir4ZvyzFgkAlltso3KgjJwiOs2qrT2Nw+pxsQEIBxp93gHWjAaX4W2t6yMU0pQ5Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:3a50:90b2:e6a2:9060])
 (user=kaleshsingh job=sendgmr) by 2002:a25:808f:0:b0:624:a5e8:9762 with SMTP
 id n15-20020a25808f000000b00624a5e89762mr5469937ybk.279.1645760573552; Thu,
 24 Feb 2022 19:42:53 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:34:49 -0800
In-Reply-To: <20220225033548.1912117-1-kaleshsingh@google.com>
Message-Id: <20220225033548.1912117-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 4/8] KVM: arm64: Add guard pages for pKVM (protected nVHE)
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

Changes in v4:
  - Replace IS_ERR_OR_NULL check with IS_ERR check now that
    pkvm_alloc_private_va_range() returns an error for null
    pointer, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark

 arch/arm64/kvm/hyp/nvhe/setup.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 27af337f9fea..1b69a25c1861 100644
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
+		if (IS_ERR(start))
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
+		if (IS_ERR(start))
+			return PTR_ERR(start);
+		end = start + PAGE_SIZE;
+
+		/* Update stack_hyp_va to end of the stack's private VA range */
+		per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va = (unsigned long) end;
 	}
 
 	/*
-- 
2.35.1.574.g5d30c73bfb-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC144B1883
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbiBJWna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:43:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345122AbiBJWnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:43:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA302704
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:43:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q11-20020a252a0b000000b0061e240c8fb3so11422482ybq.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=2CtdKKtWqmoQwaNtCKVnEnSlCVes5hG5Of9ZJoRSPvY=;
        b=nf4mRr3ZycGHhBqUZ+8DH8ok/Qz5Vau89sI8kQL6TBzahsS+36PcxWkEHapQEi57zC
         CGZbN1pSxbTcmxo4AB+1siE6sFbVo2nb0UNYy50fVpf34U/KaE2hkYTprUDL4Nb7cEx7
         eOnLgbr0qMZnT6YgUCkRnP6o+xccxEE8H2B8bDpfPqwt3rT5owKtKDyzxlxoreRzy07y
         MzXYO5kYEYUKhF9/9jypyALGVa3urJxqTXcX0FAUfDebx61o/y7NyiNP7UOwQhkI7CzS
         luqBAqd7jIqdj7/5zwZd4zwMLB9kJDCIHLmkKLXY+xR7ATa7MbmSjWRxP0IbgVTg4WA9
         yOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=2CtdKKtWqmoQwaNtCKVnEnSlCVes5hG5Of9ZJoRSPvY=;
        b=6kDzonm23UMbArHlah93p4q1/R2EGmS7BjvxBZs+N34mxRP9sJQUkU2wY3t3tWfGKG
         rDXbFOZ98jgSyj85YCKd7s1lLOmxFeBhSmfgAgLNrihY7Vl3U6t7jOPMIRJRaQ4Y0v0q
         IUpXruC5fXGUN5nzqUAVn5kRmEyVkaiM1biTescNvTTaFi6oUwi60Qot+SywXbW0Mx3C
         caEx5uQf6iJ65Iq+i3wu+dChCUOYrsN68PtLuUJJIlobfMopJXKIxAFRbxwiuwywj/Mf
         s9e3csv4YlrwrGPw1JzkQyhu13hdkvW4MCoA9VOCdeEYTTYiMTOXWR3dBQVEFAsSgBXO
         +o8g==
X-Gm-Message-State: AOAM5327UqxJAVz38uabWk7CuHOdeBOVEq8VJm04apuSPcP6Dj2r9/AE
        dgjohAI+mARnH+c93OrJY4RyeEXk6cvQgzNyIg==
X-Google-Smtp-Source: ABdhPJwyMEA3/vPtnC5hrjc0C911vwYkTGYEzvGOgFv+0i9iJplYrKuXB9UfmBJoHZPA2fyRMmEXZHP0MgIOdqb77g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a81:60c3:: with SMTP id
 u186mr9342666ywb.26.1644533004795; Thu, 10 Feb 2022 14:43:24 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:42 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 1/7] KVM: arm64: Map the stack pages in the 'private' range
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

From: Quentin Perret <qperret@google.com>

In preparation for introducing guard pages for the stacks, map them
in the 'private' range of the EL2 VA space in which the VA to PA
relation is flexible when running in protected mode.

Signed-off-by: Quentin Perret <qperret@google.com>
[Kalesh - Refactor, add comments, resolve conflicts,
          use  __pkvm_create_private_mapping()]
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 27af337f9fea..99e178cf4249 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -105,11 +105,19 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 		if (ret)
 			return ret;
 
-		end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va;
+		/* Map stack pages in the 'private' VA range */
+		end = (void *)__hyp_pa(per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va);
 		start = end - PAGE_SIZE;
-		ret = pkvm_create_mappings(start, end, PAGE_HYP);
-		if (ret)
-			return ret;
+		start = (void *)__pkvm_create_private_mapping((phys_addr_t)start,
+					PAGE_SIZE, PAGE_HYP);
+		if (IS_ERR_OR_NULL(start))
+			return PTR_ERR(start);
+		end = start + PAGE_SIZE;
+		/*
+		 * Update stack_hyp_va to the end of the stack page's
+		 * allocated 'private' VA range.
+		 */
+		per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va = (unsigned long) end;
 	}
 
 	/*
-- 
2.35.1.265.g69c8d7142f-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475AC576AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiGOX6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGOX6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:58:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0298E95B29
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:58:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cbe6ad44fso50759517b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4Gh4HGzCqCiR1aMRIxtcGB+xW1TuymtOUOGGi3XUe+w=;
        b=laaDvU+ra+tX4Ugt/hApPQt2F+7sMcLjlMfErCxQ6ZAH13Fl9Hv7omF2Saquz513mu
         J+bzAYxUx7CJ7btjmdncYrC4Y1veu4NHmQSeNXnOpqCAxzIaB5YMd/l72BqrmAcB25Re
         aNK+JcXfLhxCXei0o7ELRQeRTW82+RLqR5IixgRFrLcuYYER2aDhKQ486g/VCwUqVWtH
         tasGaqajdMOPcNItlrkBHc6TN6iHktOIIjVTgbV/GxxseQ1L4UA2gFqmJgw62Ugr1v/5
         6gP6onX2YcRMENGDJD/h2b8G3wSA1GpfizjMN4ihAYbf/2VUfRAwE7VGIPqLL9iTf/e3
         aq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4Gh4HGzCqCiR1aMRIxtcGB+xW1TuymtOUOGGi3XUe+w=;
        b=xJAsgOatK1sjExKQQPaJppfqVoOp8sH4ZrtcH/fpavQJF3PeRODqwu+YJrWzd6+Us1
         cAz5+T67YBvV13+eu6762XmZ3AJZ15PoQGIuOlpBRXXDW0tfk8UEYh1bwgY5WI9k+tkK
         kOeq5ABB8WIdmYw4vHJrxFMjq2AFPF5wW6yV8lTp8aeWIKO30RQVb/446qxpuzNF3XUH
         hF33t1ZvgHTqoeCn+VWI/atwnjgtHe5XEqRRTo5KReTw/AWwN8jbfMs3yZ8g4MrYiYtZ
         pzYqeViyMHzvI/IZ44Qa49lICr+IocoM0RRDBeAixL6dqcLjAWqm40r3MIxTJvRZK6YS
         aZzA==
X-Gm-Message-State: AJIora9b18255ZUm/kg4UQY+l+X/81idLri+ECFrYHkkWiLRcMMShxaF
        4NwZ6DZuoGze80MnsCIAtDmAxY9d9gqVUzqGXg==
X-Google-Smtp-Source: AGRyM1vkyU/rsorWG73TjyeqssO4W2twt9Xtdrwt2iDSADe0KqgrXHN+i9CgnK6UL1nt08B+26vBLjDJeLP2QInhhQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:dbad:2778:c9ea:c5e9])
 (user=kaleshsingh job=sendgmr) by 2002:a25:cb85:0:b0:66f:fffd:a726 with SMTP
 id b127-20020a25cb85000000b0066ffffda726mr3177720ybg.287.1657929512302; Fri,
 15 Jul 2022 16:58:32 -0700 (PDT)
Date:   Fri, 15 Jul 2022 16:58:24 -0700
Message-Id: <20220715235824.2549012-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] KVM: arm64: Fix hypervisor address symbolization
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com
Cc:     will@kernel.org, qperret@google.com, android-mm@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_RANDOMIZE_BASE=y vmlinux addresses will resolve correctly
from kallsyms. Fix this by adding the KASLR offset before printing the
symbols.

Based on arm64 for-next/stacktrace.

Fixes: 6ccf9cb557bd ("KVM: arm64: Symbolize the nVHE HYP addresses")
Reported-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/handle_exit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index f66c0142b335..e43926ef2bc2 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -347,10 +347,10 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 			kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
 		else
 			kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", panic_addr,
-					(void *)panic_addr);
+					(void *)(panic_addr + kaslr_offset()));
 	} else {
 		kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_addr,
-				(void *)panic_addr);
+				(void *)(panic_addr + kaslr_offset()));
 	}
 
 	/*

base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
-- 
2.37.0.170.g444d1eabd0-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81834D4FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiCJQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiCJQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:47:12 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0F1688C6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:03 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id q7-20020a63e207000000b003801b9bb18dso3211515pgh.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZtMt2wyNKjtAiC88Q9bMZ9sXYSFZv/d9rVnBJi58YjE=;
        b=kF1znJ85tnfKN1AqdnzwfECAQ2Bujq/sYB5jsXv9223OEp8oLI7a4GjXMMqiXdJKwt
         XHQV3yyoMv/foJR1ICm6OepAwP6nQRV8LErs/I5gGumDWU9qzwjTbRTW9HCR0PWgqlB6
         x8vNVZLqVGy4eHLzBawQNrARD/WxTyRhjgI0bjLQqJrLR6X/F3L+HVwfArLVEC7cniWG
         7SH/D9MddLJkIEnASvtVy9Mo6CLqaZoFYjpXIH5hBRa/UrxhjeqnwXd0mw+5K2HBtRrx
         7giUtfK0uwxO9EitJUz30MABR9jtP1s0OzhBmWmD+N8hOkBUrnF9WOvqqhVh0Gts5EHk
         VFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZtMt2wyNKjtAiC88Q9bMZ9sXYSFZv/d9rVnBJi58YjE=;
        b=2/T+HOm5eSwbBYUH+PnS/Dn1tskh+K+F4ZDbRKihI/pCo7keS67i54m/Mk6D+1YBDe
         pk1y00MvApiEbMZKjcTgmfG1e2FGhoyUkKyvU1FUJZtowPML0/LEFqiyhkREqnhFzRnC
         lEzuQbOGtdD0rG8MbIKQzeARzR239F7AvPMD4HDWU0N+ueriI64dPaGF7QHL17zmlSA8
         VhpI1xEMrcGoeIWdQzs4vt+9VpNyWipeqDPMZj6XuKh18AIfaqTPsfF9z+rCJ48amDwL
         4mRIbA6+bMHyv9oXLVWbH+jFtMnuVFLL23urHxCtHqVN7eocoVYhJtXpD3t6ZPdBDUdG
         gPiw==
X-Gm-Message-State: AOAM533xhHlXEJjZV52g3xTMxi4qKmD/kR9fo6RA63NCzL2fr54ToPxg
        Y7uVp00XE+ZI31aerdYAvtpGCbpM71+Zq8sV5I9jDXbA8X2T+0hO8MJI+9epAHaWyzXsyIC+NMl
        OadomHv9BZcnMjvx5S/vTqa2Jx3NtJ5XZHkZWlacgiisF/HJ98bM4KTVKz2/CzOXxNWkfplJD
X-Google-Smtp-Source: ABdhPJyoHfbF8RQ9sOUvgKO7WeX+jxEC0rLnHPaqY5crXjjYxoTQBF0iZZpOSN7klvCidjTmaT7hiCOEyKeL
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2d58:733f:1853:8e86])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:2296:b0:4e1:905f:46b6 with SMTP
 id f22-20020a056a00229600b004e1905f46b6mr5914762pfe.16.1646930762732; Thu, 10
 Mar 2022 08:46:02 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:45:25 -0800
In-Reply-To: <20220310164532.1821490-1-bgardon@google.com>
Message-Id: <20220310164532.1821490-7-bgardon@google.com>
Mime-Version: 1.0
References: <20220310164532.1821490-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH 06/13] selftests: KVM: Improve error message in vm_phy_pages_alloc
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make an error message in vm_phy_pages_alloc more specific, and log the
number of pages requested in the allocation.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a10bee651191..f9591dad1010 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2408,9 +2408,10 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	} while (pg && pg != base + num);
 
 	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
+		fprintf(stderr,
+			"Unable to find %ld contiguous guest physical pages. "
 			"paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
-			paddr_min, vm->page_size, memslot.id);
+			num, paddr_min, vm->page_size, memslot.id);
 		fputs("---- vm dump ----\n", stderr);
 		vm_dump(stderr, vm, 2);
 		abort();
-- 
2.35.1.616.g0bdcbb4464-goog


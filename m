Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C051B359
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384970AbiEDXIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380040AbiEDXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:02:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B845A087
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r9-20020a655089000000b003c612b48014so158779pgp.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hThR3eXvdbL6PIPwsArk6NS/Y6ItR8JxmYPs055HfNQ=;
        b=HZvGef4wMTUUww0ii1QoiwMBQSBC/Pvw3CoC72aul1ExRfDQ2K5By8y4/GGBcgJaeN
         owaaHAG/e7rStRrir9ExqsMKk4ynjLGKLmJaW5Z/6z+xjstjP5ZbhJ3Kb6wDVrH9QauE
         DkJedMIVsKGVgA4gID4rx3C4DyKI6MUL7S3Bffz5GU/1jUw6uYENZeYMnZJcSD1FBHxo
         uqhvPCUHKfzKn25stT7tccHRDWctknK2xDWQEGGvAoVl9rL2byoPoQ07LbFg5Ho4zHpN
         PGa+qnQwevzHvvolT3qf93eqYFEuuCX9mYdLStjxrXePI+/05RKJk2pFbAaGb7yOggAB
         V58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hThR3eXvdbL6PIPwsArk6NS/Y6ItR8JxmYPs055HfNQ=;
        b=kGsfdXV2RyJ7n2bVcD/F88iQ+PUa4IYbxSOCoOCHMr6KPpW3uRb45D6JnIJ/BE0xK9
         NROYxUHLtEBe68CJ9tYfyCB4OZSCuFBUZQlr8B3Kv5AWGw00ppw7J7fUQZptuVagJxPB
         5N7yDBeFDtcpzeLeD3rNlTjjr1XTF77AcBKoX+lrW9Te0scGkSXcZPwdZbLMR7PmsQPw
         wKe1rxDLvNtcBVxKH/uum6quGhaEVNcCk1t/1v1XXtVA2uAVLTlu03raOmAtNTvADGXG
         jwGHRImmID9/d0f+LGMpZwVyqplkqmNcYzrFKBAwHyytMDKoX1/C6n0fI6wpWs6YjQ6t
         6/Tw==
X-Gm-Message-State: AOAM530TwTY7GP4BsM+kbmx+kH1I4Ig9NkX/dqErYvFNnREE6qJ70GA6
        ZBfzIIfgeyoTSXOyi2JMsMdOnvQefLQ=
X-Google-Smtp-Source: ABdhPJwgHLHvRfb8WYuIp2kW1pjw/YQRzjjh1gfBOLY12cy5NstVGLntHtlD+eVhWnvP5CGghG3yOhajnck=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:d487:b0:15e:a0a4:69e3 with SMTP id
 c7-20020a170902d48700b0015ea0a469e3mr18832343plg.155.1651704791544; Wed, 04
 May 2022 15:53:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:49:14 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-129-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 128/128] KVM: selftests: Drop DEFAULT_GUEST_PHY_PAGES, open
 code the magic number
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Remove DEFAULT_GUEST_PHY_PAGES and open code the magic number (with a
comment) in vm_nr_pages_required().  Exposing DEFAULT_GUEST_PHY_PAGES to
tests was a symptom of the VM creation APIs not cleanly supporting tests
that create runnable vCPUs, but can't do so immediately.  Now that tests
don't have to manually compute the amount of memory needed for basic
operation, make it harder for tests to do things that should be handled
by the framework, i.e. force developers to improve the framework instead
of hacking around flaws in individual tests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 -
 tools/testing/selftests/kvm/lib/kvm_util.c          | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 527f63a30668..d30f8e0612af 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -100,7 +100,6 @@ memslot2region(struct kvm_vm *vm, uint32_t memslot);
 #define KVM_UTIL_MIN_VADDR		0x2000
 #define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x180000
 
-#define DEFAULT_GUEST_PHY_PAGES		512
 #define DEFAULT_GUEST_STACK_VADDR_MIN	0xab6000
 #define DEFAULT_STACK_PGS		5
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f4bd4d7559b9..a0c8333d1bf6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -274,7 +274,13 @@ static uint64_t vm_nr_pages_required(uint32_t nr_runnable_vcpus,
 		    "nr_vcpus = %d too large for host, max-vcpus = %d",
 		    nr_runnable_vcpus, kvm_check_cap(KVM_CAP_MAX_VCPUS));
 
-	nr_pages = DEFAULT_GUEST_PHY_PAGES;
+	/*
+	 * Arbitrarily allocate 512 pages (2mb when page size is 4kb) for the
+	 * test code and other per-VM assets that will be loaded into memslot0.
+	 */
+	nr_pages = 512;
+
+	/* Account for the per-vCPU stacks on behalf of the test. */
 	nr_pages += nr_runnable_vcpus * DEFAULT_STACK_PGS;
 
 	/*
-- 
2.36.0.464.gb9c8b46e94-goog


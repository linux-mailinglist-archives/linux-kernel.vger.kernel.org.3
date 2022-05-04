Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1551B2DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbiEDW4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379460AbiEDWyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7C1CFF8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:27 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id v9-20020a17090a7c0900b001cb45f88cdcso1100232pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=NtspSlUg4ML5uMJ7vjR/+OVkX26xwVVuotNivGjDjEw=;
        b=i8p9S2Q1YB++zvCiyZcgldBtm/WJw9SzZVcpnlekEf4KNcXr57t+cI2f9o5y/+bouz
         hD3fCxoTJpO5y9V2EzM/7R69ywUoevXk1abQq/HM9nkCdKIe4TVijfS0UNDXifnnpzzq
         uSm2bEf1r2cKU34QG5U9TK6Kp2LkoTvd1PyHpZFJM0qshIwz/IfxjMUIgFSa2hdETFW3
         oZdOHglDbZJckyotMHLZJW9AD6sTY1QZ+4kFZe9iuaYB8345EP8ET8P8dJvxYYt+yu+7
         w6Yn10lgUwLSQwS+7zSLiigBIbryXfcgT+F5dt/hTPRABsc8OigVmItPBCOYYOWe2KMp
         LlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=NtspSlUg4ML5uMJ7vjR/+OVkX26xwVVuotNivGjDjEw=;
        b=lNfg7G05hF8sSGyy1C/7pXua2q/C0E9JAdkabz6QffdEgejpNW7fz2xyqtlH9Jycrk
         mp89Fdf31EzPRwOzoSW/P065z9Nm3HLcwl9p3gTmnvbcJ3j+nEsYDJMKaYeND70HDP0N
         YEw0Qcjv3E0zoXBWdq+3UYzyQR/+ixZjHULYU0eCr5oSjjhMH3yZclrr5EpGUwzVlb4X
         LcafHsJt4JThYxiHnE+DAfFy++FEPgOAFwdYmcgQ57pf84LNJhin89038gx4KxUmVUzp
         rx46/wPkzSynVIke1TJq3HVqomC3xtzs/abd0/81aTs0WFs5x5fN/caDGs96Mv1ja5Az
         jGIA==
X-Gm-Message-State: AOAM532Dx41Q5R48rkwze4xP8Hy56xFsVf78pyZaUdPIqD4J7FyTD5WP
        p1W6IPRbQh+xKxwBccT9x0GHmEahKfo=
X-Google-Smtp-Source: ABdhPJxP1o0Y315OZJ5ArQVikvoycdcvFzlcnlwt1FfAgnv3BEg3jUo17c3+V0ncJnPB8bB7WS9S+77NCuY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:7d81:b0:14f:e18b:2b9e with SMTP id
 a1-20020a1709027d8100b0014fe18b2b9emr23642359plm.160.1651704626657; Wed, 04
 May 2022 15:50:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:38 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-33-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 032/128] KVM: selftests: Use vm_create_without_vcpus() in dirty_log_test
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

Use vm_create_without_vcpus() instead of open coding a rough equivalent.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5752486764c9..74dcac0c22c5 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -677,11 +677,8 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
-	vm = __vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
-	kvm_vm_elf_load(vm, program_invocation_name);
-#ifdef __x86_64__
-	vm_create_irqchip(vm);
-#endif
+	vm = vm_create_without_vcpus(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
+
 	log_mode_create_vm_done(vm);
 	vm_vcpu_add_default(vm, vcpuid, guest_code);
 	return vm;
-- 
2.36.0.464.gb9c8b46e94-goog


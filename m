Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6B51B2D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384085AbiEDXHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380281AbiEDW7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:59:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6106356FA0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 9-20020a250909000000b006484b89c979so2257477ybj.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=G/NbvGhtiyLQi7kYqoocOZcin0VQ7Ev2zOKIrEGbvEg=;
        b=PEtzywlanOhN5HCJA3Lt0CeIncOVVBKRoV0Hf2g1tEJh5BLkkMlbTy4701Ccc7S0UY
         koKKUWTdKaN61LeyvKAWsy0NnbVTrS1shF+8jndT/qCkDFahRcrUViryo9fDf5fb22F9
         1pafsRqHBmgwLFYPWTofxlLLi0Kzqg5jytBCK18RYJXkurPp5R8ZD5Wk6JKpSi5InZwZ
         fOcmpRSWdL3OqAnyUMf2GOwX6HyBtLD/ZGtvPVw+Bt4MoOZEIIiL/Kz6TlVrdfcbGY1L
         sSdMuPWn2iakz3XVTYecII7Pb+Da44akgh4pLgeZLoKQfBF6r07l6kKv27AJ/k73c4Ii
         u+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=G/NbvGhtiyLQi7kYqoocOZcin0VQ7Ev2zOKIrEGbvEg=;
        b=Vc6pQexzxS7pMoMD2QzPE0+YgnL7c3+vK87U+Ziu67jpsGX194wNwniNplfNjWfbLq
         58m5nxOzwLKh7BA/tL7MLcJUZ2W+j9cMbM0MoQP2TrgbRYtFveEN18HbLMAlmtGDnICQ
         5RA2pv67e1GMIds8AmaEDJgExdSo3qWiqKyoMMAC05kUxnd/nmFN81l6ueGg/6ag4X1d
         kY/0/GgqdmZeJXUHAmHWRRRh7TvQcr+pFf53dhvtexsMXp/DcGdqhXLWj2dKSE4T6kcd
         e2Fs8WMbdFaF47ipMaesvdwzcbw90WoJfTyJzEI6k0PF7OCa1oJaAuM+tmI0ZUS1upTR
         FlJw==
X-Gm-Message-State: AOAM531l1A36hcrN9s4VpfGjpyC75lAF1P3r/XMphw4UtKyA9DxMhk1t
        5XvA+3ZZzVzzyP2Q9AYFRANxX/tGAV4=
X-Google-Smtp-Source: ABdhPJw4vqEx1r/FPBUGl6CXjGB99bRmtBvbIU1DcpitmJiYdK1Z1DGCAz61RZcnkMRlB+o/5X+6z514Cko=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:2a52:0:b0:648:f7b4:7cb8 with SMTP id
 q79-20020a252a52000000b00648f7b47cb8mr18287580ybq.431.1651704759092; Wed, 04
 May 2022 15:52:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:55 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-110-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 109/128] KVM: selftests: Use vm_create() in tsc_scaling_sync
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vm_create() instead of vm_create_default_with_vcpus() in
tsc_scaling_sync.  The existing call doesn't create any vCPUs, and the
guest_code() entry point is set when vm_vcpu_add_default() is invoked.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
index 2411215e7ae8..728b252597cc 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
@@ -98,7 +98,7 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default_with_vcpus(0, DEFAULT_STACK_PGS * NR_TEST_VCPUS, 0, guest_code, NULL);
+	vm = vm_create(DEFAULT_GUEST_PHY_PAGES + DEFAULT_STACK_PGS * NR_TEST_VCPUS);
 	vm_ioctl(vm, KVM_SET_TSC_KHZ, (void *) TEST_TSC_KHZ);
 
 	pthread_spin_init(&create_lock, PTHREAD_PROCESS_PRIVATE);
-- 
2.36.0.464.gb9c8b46e94-goog


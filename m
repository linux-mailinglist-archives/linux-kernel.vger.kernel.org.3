Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4405835A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiG0Xei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiG0Xee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:34:34 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838C56B9D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:34:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s6-20020a170902a50600b0016d2e77252eso174820plq.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=tcg4fyWcMhApmssB1rrZxLEKjBF7sSie1JOHuz2QyKw=;
        b=Y22uyc7My63H8qiFF1kgEwUBLMnNiTDQAspI9xMCMaI8CL4pMsFZwEy5qqqu/OAbjk
         dCkhYEVY81t7juGyB3KIxXTQ16K2PW8Lbb0TiJluF1RHfns+Gpb4V79FfA53W3Jo94he
         OhcXVYyDhnTAEAhhX4NcAbrMDp1GYhjOIRVOBGVk99IfkIzYylefYMyoW1sFSV14LpXR
         /loGYZXkjgZj34YAUF1U+FsjpNVxIp22oA9ihhclEeuBB1IqhuA/NrFqXW3aYoCx0I57
         74hrMCbtPcUJHybQ8N6HeVjtcLXTs1aNHY455CaZL+xFrrAx8aGJU+hv7v53sWhV6ZIR
         zeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=tcg4fyWcMhApmssB1rrZxLEKjBF7sSie1JOHuz2QyKw=;
        b=ZVVVEIXEwIT0wPEEVLh2sYNwiK7p/V7ABD54cy2Hthfr7Cfq7iATSJjT8WaErAnRTJ
         cQlqQ9o3KjeyJrmVwouH3LbPMfP/rMSbIKf72GfuRS+34w69zIw732i9opXMvB56afCg
         amVeMRoJDWO4VA1FtBEJS3FBoKi/x/6k1XHEHd72Ms4rBdb0G23sfn0Mrv6iIaxsRifj
         rP/jGNQ7drlKBfliMb6J0KXv5fWdGJlcmxWiDg5JCGLkRKfYoE6/tXtsYUKSCnYPc4lg
         F89pbAV+Tp+WV+hsX4BzQ1ezTsFGhntoCjZ7QqKcgR9VvVFeEwnui/okqr0IneetJXkb
         ToYQ==
X-Gm-Message-State: AJIora+piEwL+PekxXlkqkMavd0yhM+uOAMdyTguuCcoqRPV8n9VDCQn
        AghoO6pSzojFZxKypd6gJ5yJzd+0ZLs=
X-Google-Smtp-Source: AGRyM1v9kW5QkJ7txPbJ2wbBnmnKx7n0zh8SlRr9e8pUg1+T0qGL/PY7sqMWVgiX+DZcxx9VtWqNPiGmxJI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9e9b:0:b0:528:2948:e974 with SMTP id
 p27-20020aa79e9b000000b005282948e974mr24092040pfq.79.1658964873498; Wed, 27
 Jul 2022 16:34:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Jul 2022 23:34:22 +0000
In-Reply-To: <20220727233424.2968356-1-seanjc@google.com>
Message-Id: <20220727233424.2968356-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220727233424.2968356-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 1/3] KVM: x86: Refresh PMU after writes to MSR_IA32_PERF_CAPABILITIES
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
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

Refresh the PMU if userspace modifies MSR_IA32_PERF_CAPABILITIES.  KVM
consumes the vCPU's PERF_CAPABILITIES when enumerating PEBS support, but
relies on CPUID updates to refresh the PMU.  I.e. KVM will do the wrong
thing if userspace stuffs PERF_CAPABILITIES _after_ setting guest CPUID.

Opportunistically fix a curly-brace indentation.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5366f884e9a7..362c538285db 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3543,9 +3543,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 
 		vcpu->arch.perf_capabilities = data;
-
+		kvm_pmu_refresh(vcpu);
 		return 0;
-		}
+	}
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
-- 
2.37.1.359.gd136c6c3e2-goog


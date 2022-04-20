Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38823508E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381201AbiDTRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381168AbiDTRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:38:17 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6F205CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:35:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t3-20020a656083000000b0039cf337edd6so1362175pgu.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Oj7z6gF3UmFPqpARpPyMhAnqQVwNhos0ksWVaS2glIE=;
        b=BHW4MoPP2qr6KkJ/bv2IsG+E7kEQXfxOROPLzA/Q0FGDcoBzR8RG3LaCyDgc+N/VZD
         ebM5y3USor/huYodLjYAIrwk+3trvOyQqnp/3EC2drn0LDVzJNrGW8kjD8kAueuW1sCv
         9SqEOSQTgoVR5UMh2Ggs4IzpLD3upFTu8YsObU3SkgGfjoSNkRzyw7tiqIWKO/1y60PD
         dkJDpj3NgVL9l9i36GP4khKUbxDXLDKKaTmeZaADvtYr1NiPrMNl/FVAKN7Kki3AQ3VM
         SjFcdRFoq2Mzy+dyYsA+ZUCkiTDeAMTcmYg9Sub9vwJqwC6vKt9J4BIu5yhgMpo9WgPi
         Xn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Oj7z6gF3UmFPqpARpPyMhAnqQVwNhos0ksWVaS2glIE=;
        b=7LOX5bK40eThlKPDXmtOfrz6UmVMyQK1SpaLkShdWzaVX7xETm8PZCc3XNOMIcVSvG
         2vFBueSw1we9ale/YhGyagbo6dta7ducadaOKQfysaTvGyVZ/0H26+1iNoT0cxTvYbVv
         7aeqGdr6P0tfEwBX+ku7MpK3vgfn7VDoRBWUscPC7F0UnEfT9TMvp9xwXer0iyqkYWJE
         YyJ6/i6SyEf6Z4/6ke5UMZ7QJPwYoUIqzg/7cxSS2USwQ049sFucTC7Imcg8Dv+4/9e8
         ejxp9f0QfHwAlh1EQPDda1nzet6DC8EDk+yvKYbjObOniO7S1srp0cM7waRiXwCHTihQ
         rKCw==
X-Gm-Message-State: AOAM530eFBcy6UE9Ugl76G13m+tJTs82ZXeQyov52TzLERfWnXOq8RQc
        5J33Vhb5doabM7R3tM4J1dpcSNLXOCDLMfB4HbHJEcqAsURQTZNvDttR3FEvC2NGdvMd233zq1D
        PCFRsEng87crC5tLXy7sHAeC7ukgrPDBytztwuJSYnf9aOXbyzwxyK2WHmR0Zuv9Axxv/5zEv
X-Google-Smtp-Source: ABdhPJzDSmuusSkVSzZvaX/pcqMXPsz/BlZMEv7jAS+fuTBtjfO8rwJ48kCEMy1Q77d2R6RIlL4rmKwZsKAJ
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:6ea6:489a:aad6:761c])
 (user=bgardon job=sendgmr) by 2002:a17:90b:33ca:b0:1d4:d5ab:40b0 with SMTP id
 lk10-20020a17090b33ca00b001d4d5ab40b0mr3119586pjb.96.1650476129737; Wed, 20
 Apr 2022 10:35:29 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:35:10 -0700
In-Reply-To: <20220420173513.1217360-1-bgardon@google.com>
Message-Id: <20220420173513.1217360-8-bgardon@google.com>
Mime-Version: 1.0
References: <20220420173513.1217360-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v6 07/10] KVM: x86: Fix errant brace in KVM capability handling
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The braces around the KVM_CAP_XSAVE2 block also surround the
KVM_CAP_PMU_CAPABILITY block, likely the result of a merge issue. Simply
move the curly brace back to where it belongs.

Fixes: ba7bb663f5547 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ab336f7c82e4..665c1fa8bb57 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4382,10 +4382,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (r < sizeof(struct kvm_xsave))
 			r = sizeof(struct kvm_xsave);
 		break;
+	}
 	case KVM_CAP_PMU_CAPABILITY:
 		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
 		break;
-	}
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = KVM_X86_VALID_QUIRKS;
 		break;
-- 
2.36.0.rc0.470.gd361397f0d-goog


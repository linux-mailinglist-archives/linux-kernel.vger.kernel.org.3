Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61D4EFDAE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 03:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353655AbiDBBLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 21:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351069AbiDBBK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 21:10:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC148CCEE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:09:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id h15-20020a17090aa88f00b001c9de032a8cso2414478pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=8RHA9aUNJxFpM8yTJhP4ef1t/aKUFmzX6SMgtUXeSlU=;
        b=mu6m/a5O3VjsafgbIgGavNyaMXeK5i+9etdubuU+TMNUVKvHADJfk8RbYW9jX8JI6L
         fGcg3as7WwEUTD6BKHO8x+X8rl/KoQ0vXmuQKH+tbFQNlDrVvXZfTE7zAoIuYPNuYoyG
         4rF6f4FEvRvKghKoT+T7LWlsqJkTfx+WAiA7dIFsjZBYLQK5i2aQ5Q3aDkknDP5IkLuK
         8PZqwQKJXWZbP5fXXW8tZzVRpDTNYrHK2DY3GJtJN+1PdWtwqmiueLkl/nNduvbKONov
         n1k+OwCK0aN+DiRconoQP9ZKaQXkMGXCPrWjncL4jUH0SPVC14/yi5H2rq2jZXbaJ8IA
         nYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=8RHA9aUNJxFpM8yTJhP4ef1t/aKUFmzX6SMgtUXeSlU=;
        b=Zlb1Vs2W2hIPtvP07lITFFugPTb3Hh/ylsPx+xjQxxLay1+dlo2DO4Hd1zR4IqTbCj
         j2U1PqAgPXGKWgzrUalks4GTuzJR3p0ny+NnSxw8hPl/1sn2W4ws/U1Ie2xvYpQer3GZ
         k2z7vj3C4jzZm5iw7hfjlbfQZpwpdStmTZbgrLTbqnp+bhX9p7SDS1gH4UQeMaWU9EB1
         Or48Y8CAyjh7Y7WGA+BDL4QjbHWMgXGHEXdOKn2Szn46Riq4bY4GODWkJP9npUTzNkts
         zxqtJf/SjQ63N20m7Weq0toFIuVDAM+7BEhLyGWDsvJ3xFxLSwNP/tVRsGjWLJ5QME3M
         wwtg==
X-Gm-Message-State: AOAM530sjSE8AOhgjS+EFghB2Tj/bL4Mocj37ycNz4dZBaGW/muoNSMI
        3PFTWIrCjf+iZcWva60uvUA9fHzyf+g=
X-Google-Smtp-Source: ABdhPJz6eEt/o/RMT6jRF4o5mIUgYCP3Lxw3z5+HYs6xIhuayeX7wPusWKnd7JasHteXF2zCH0UcWHuQWv8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:114e:b0:4c8:55f7:faad with SMTP id
 b14-20020a056a00114e00b004c855f7faadmr13709370pfm.86.1648861749019; Fri, 01
 Apr 2022 18:09:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  2 Apr 2022 01:08:57 +0000
In-Reply-To: <20220402010903.727604-1-seanjc@google.com>
Message-Id: <20220402010903.727604-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220402010903.727604-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH 2/8] KVM: SVM: Downgrade BUG_ON() to WARN_ON() in svm_inject_irq()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
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

From: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

There is no need to bring down the whole host just because there might be
some issue with respect to guest GIF handling in KVM.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 95b26dbfd561..2c86bd9176c6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3383,7 +3383,7 @@ static void svm_inject_irq(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	BUG_ON(!(gif_set(svm)));
+	WARN_ON(!gif_set(svm));
 
 	trace_kvm_inj_virq(vcpu->arch.interrupt.nr);
 	++vcpu->stat.irq_injections;
-- 
2.35.1.1094.g7c7d902a7c-goog


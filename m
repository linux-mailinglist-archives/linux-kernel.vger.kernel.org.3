Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261C4D58F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbiCKDaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbiCKD3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:29:44 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8764EEA51
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:22 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p5-20020a17090a748500b001bee6752974so4417916pjk.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hDEsiW/1JCBAL6rnpjAoAKowK88eFadHJbQ+k7mmB9A=;
        b=RFF8YW6U9Bnsdg9ppIYdODr3twU98mGctgU6cl8f3boBCowDbMpo4eeue3p4MdWSAa
         Np0Tk6nTzyjg/sEQU+UR2QiiO6C8feFoVBL7/Y0GoWRFEgnprHnc6zXbr+57unQbg+np
         p0RKvMzLCgSglH5rGIauZNKXmiV4jtNhKYAg1rTY6ZTFO8dJD9j2oM83HenlbGmp+ImU
         1+gqT1Bkr7JdXwCHbdixFiuOOWrFCzmT5TwRAutxA1YQxwvDD5zE0JU8GSQAaDL7tr1a
         u2ewtiIGWsw3pGrmLNImaBnmXeGnzi0UHAbwqBv0MPeUuWUnf0mdg3FRmwGHI6aZcSIt
         Ayrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hDEsiW/1JCBAL6rnpjAoAKowK88eFadHJbQ+k7mmB9A=;
        b=OpMs4d4/jJXLkog0Xc4/bIxkmRmD5t0ikwxFcbQxaelpxY8msziyWgdR6QbJL759p2
         qqacPj0fnUX9kpoAu0ly8oqAgEF7444iYeacqG5zSgWmWkIiSdgMJj4zE9mKmpX48t48
         SaMjaXXUJelvTecei2vy4wEIjS0rhzLgq/VYnOCuCZeA9dmyqYrW5KfRXDk7H+xkShxY
         K+u7bHFuwdv8SqEpZmIT/EqDQwkxn4iA8OJOG5IYTZzNrh56zICVw68hRl54yDpGHSAV
         q9RKcr9IHobDXVFc2Qu+8gcKui8NakcOnnkt/a7iyDwVFyGSfg6UDqUJMGUGsMp9yjhw
         xZOQ==
X-Gm-Message-State: AOAM532G9Ke0brfTOeXLwf1jsV9SI9v4H5W5xypJRsbkCgWIsq+Gb6Sa
        0ONrIXZgPtdJ9T4AefiKban+/dmMkhA=
X-Google-Smtp-Source: ABdhPJyhaE75SPhWVJQ1hIPPBNsxEpMhN69TxBTr0IeMQB2WoyGtw6PbXHuvKQdeNPQ/xASLq5yjvdDpSNA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:a3c3:b0:151:ec83:d88 with SMTP id
 q3-20020a170902a3c300b00151ec830d88mr8717054plb.9.1646969302136; Thu, 10 Mar
 2022 19:28:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 03:27:51 +0000
In-Reply-To: <20220311032801.3467418-1-seanjc@google.com>
Message-Id: <20220311032801.3467418-12-seanjc@google.com>
Mime-Version: 1.0
References: <20220311032801.3467418-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 11/21] KVM: VMX: Inject #PF on ENCLS as "emulated" #PF
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
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

Treat #PFs that occur during emulation of ENCLS as, wait for it, emulated
page faults.  Practically speaking, this is a glorified nop as the
exception is never of the nested flavor, and it's extremely unlikely the
guest is relying on the side effect of an implicit INVLPG on the faulting
address.

Fixes: 70210c044b4e ("KVM: VMX: Add SGX ENCLS[ECREATE] handler to enforce CPUID restrictions")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 35e7ec91ae86..966cfa228f2a 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -129,7 +129,7 @@ static int sgx_inject_fault(struct kvm_vcpu *vcpu, gva_t gva, int trapnr)
 		ex.address = gva;
 		ex.error_code_valid = true;
 		ex.nested_page_fault = false;
-		kvm_inject_page_fault(vcpu, &ex);
+		kvm_inject_emulated_page_fault(vcpu, &ex);
 	} else {
 		kvm_inject_gp(vcpu, 0);
 	}
-- 
2.35.1.723.g4982287a31-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64427535565
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349037AbiEZVYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245759AbiEZVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:24:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378EE5F252
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:19 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i4-20020a17090a718400b001e09f0af976so1629961pjk.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qcb34r8lBkv1bGkFkoJYhaFMYHoFB0Pd8gzL2lqLpkQ=;
        b=T2zruDflY/r2OIUodskEq7SMCOGDU5zIxLD6CKLlpC+X1tooGQxFlorAGyJySJiLcT
         BcnQsYeLkficbXY1grZaMSOthPCBy2G7UlNRMgaw3Fki/sHXjUDSydOFdzfhioLz6vax
         4gHW6WF6P1CeKQeh8tEypLoVOrZhs4imn/tnXHLtiJtPtiOHluXDiIrjkY2f4TIIprjj
         YZQ+SkB3IFIn1h4C/asUwTVq0bKcWzu/4OEdoRTcStiO25m1gWa5ZjOfxfEhXAeSDusp
         IKml40YTsbiAdMUFSg2RxerihFBAvv7pjgmFfk+SnKpam8IBWV1VQ9BNzawlaSa5Rw7p
         SnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qcb34r8lBkv1bGkFkoJYhaFMYHoFB0Pd8gzL2lqLpkQ=;
        b=x3pruN6apF13Sh/8QKyT0oiSB71dQrjjtFhjFs5tsYuAo8qd+lZzwEnrPry6CU57uK
         5jkSjG5S2zSAEtQxEbx0S4rv5TGyvTorrWHoyGiGyHBb18T3G0HO/nXAP5dk9dN45b8Y
         EoLzVWZAX3dDEZVXfnMonbXJlfh9AQoiTdyRN5T0Q6ERPv6c1XlTyEmiI7LEgAflynPn
         cpXkRxaaguvTVaFXec4wt++s6Ews/4kXyZ+loJb7ClLnL4hqPqbxTYH1y4vMWnYRkXIn
         Fcwltvm17Ainnr6xp3jHQuUt49N9SQMawPtURJdfn8gHiW563BldlCbrUoheaVNazmp8
         /Vgw==
X-Gm-Message-State: AOAM530dGgiXn9bOhjieID0PLwUOAMKH5rWa02/+JF6VnVNR2caACPKA
        zsTUR0K1vBsnwSy/pTwzGHpYgy/y8Jo=
X-Google-Smtp-Source: ABdhPJxAeFvGXx51xtaRc6ldC7mkeitVeSpk0Q3pavUjwHjAZWr2uqsYLQND033oUCn3RqxKULma6C2BFAg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:6dc3:0:b0:505:895a:d38b with SMTP id
 i186-20020a626dc3000000b00505895ad38bmr40875071pfc.7.1653600258711; Thu, 26
 May 2022 14:24:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 26 May 2022 21:08:10 +0000
In-Reply-To: <20220526210817.3428868-1-seanjc@google.com>
Message-Id: <20220526210817.3428868-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220526210817.3428868-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 1/8] KVM: x86: Grab regs_dirty in local 'unsigned long'
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Robert Dinse <nanook@eskimo.com>
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

Capture ctxt->regs_dirty in a local 'unsigned long' instead of casting it
to an 'unsigned long *' for use in for_each_set_bit().  The bitops helpers
really do read the entire 'unsigned long', even though the walking of the
read value is capped at the specified size.  I.e. 64-bit KVM is reading
memory beyond ctxt->regs_dirty, which is a u32 and thus 4 bytes, whereas
an unsigned long is 8 bytes.  Functionally it's not an issue because
regs_dirty is in the middle of x86_emulate_ctxt, i.e. KVM is just reading
its own memory, but relying on that coincidence is gross and unsafe.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 89b11e7dca8a..7226a127ccb4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -269,9 +269,10 @@ static ulong *reg_rmw(struct x86_emulate_ctxt *ctxt, unsigned nr)
 
 static void writeback_registers(struct x86_emulate_ctxt *ctxt)
 {
+	unsigned long dirty = ctxt->regs_dirty;
 	unsigned reg;
 
-	for_each_set_bit(reg, (ulong *)&ctxt->regs_dirty, 16)
+	for_each_set_bit(reg, &dirty, 16)
 		ctxt->ops->write_gpr(ctxt, reg, ctxt->_regs[reg]);
 }
 
-- 
2.36.1.255.ge46751e96f-goog


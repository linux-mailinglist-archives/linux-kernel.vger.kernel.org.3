Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8E52AF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiERARH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiERARA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:17:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025C537A1D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 2-20020a631542000000b003f5f09dd8c0so331983pgv.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5YuCWLet/PPts9g4RSdVal6LTdb/KAIKbqIvcb+vduY=;
        b=dA/qIleBSlZrZBhR7t57h+6p/ZhZLnqSXMaXUXu9jhDey23Igr2eYKnVrjc9gKwmr0
         gFbDHINheRaVvWwg1bcNtFrvGhHJpC7VCRW/PVvwyN0mxmYErJsWJk7RUDpAQDKa2rZJ
         ICqG3XwJDV9mOi6Vnwke9oDgWXScDvseqk51ny/CoGNvVel6lmhsVWblT40ComgXwh6l
         zE7pOMFLOUMwoqhG76YKVubmdeoW1pVNVf5zByuX+ex9rVNPDXBQs70UWjIEvxwPV72A
         nRKqKyAs2spHVJogw1NY+76kPvH0k4gfRmb0IqXIFC9mzt4eebl7PVJhlBZ55UO3ZePz
         aGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5YuCWLet/PPts9g4RSdVal6LTdb/KAIKbqIvcb+vduY=;
        b=VoFkoFv2JiWAUisYXEYOawOm8PnzSrKTgSMyOGTV3YaicaXVdR386kULVZI4ZHA2YM
         bXftJ0kF8S+mFpusmBfNBb/cHxcm6FvicCUkSfYN9kZERgpAuXrNeDklQ2HBVwNQ2OmV
         BybxFUKZf7zrjG99d28INqk4dymSoHQUHQwjBaJHIsH09kXTiLlpJhp3Y4t2lBPpvIMX
         ztv25Gi5klQnF6QaokZVOJjAiTnqkk7mmbafRXsEe2YDqukpcb88+6B6v+Pz9W39lqmq
         4kSg7RdWwFLC02njIx1YbqpYlY4EIOt9AXV3XeNWfKIG5pQfHAJYX0w+ARBJLiBxNCpV
         r2GA==
X-Gm-Message-State: AOAM5334VsLd+AFV3V+PA0cc0c0Z9ROsIhbel08qGqnaepKzPbejBAJV
        CQiXwv+menfQarKvO3UvfeGvv2sFMbE=
X-Google-Smtp-Source: ABdhPJxCHwscxVux3DXDPYVIjUJRhP48xvpihTLk7ont3PQnsFHZ4oYLJBoczxVPH4z+ghGchclueiLqaOg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:bc86:b0:161:5f4e:d7d0 with SMTP id
 bb6-20020a170902bc8600b001615f4ed7d0mr16123631plb.119.1652833018477; Tue, 17
 May 2022 17:16:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 18 May 2022 00:16:47 +0000
In-Reply-To: <20220518001647.1291448-1-seanjc@google.com>
Message-Id: <20220518001647.1291448-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220518001647.1291448-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 3/3] x86/virt: Fold __cpu_emergency_vmxoff() into its sole caller
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

Fold __cpu_emergency_vmxoff() into cpu_emergency_vmxoff(), its sole
remaining caller, to discourage crash/emergency code from handling VMX
but not SVM.  The behavior of VMX and SVM is so similar that it's highly
unlikely that there will be a scenario where VMX needs to be disabled,
but SVM can be left enabled.  In other words, during a crash and/or
emergency reboot, funnel all virtualization teardown sequences through
cpu_crash_disable_virtualization().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 8757078d4442..a9414ef5269e 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -60,22 +60,12 @@ static inline int cpu_vmx_enabled(void)
 	return __read_cr4() & X86_CR4_VMXE;
 }
 
-/** Disable VMX if it is enabled on the current CPU
- *
- * You shouldn't call this if cpu_has_vmx() returns 0.
- */
-static inline void __cpu_emergency_vmxoff(void)
-{
-	if (cpu_vmx_enabled())
-		cpu_vmxoff();
-}
-
 /** Disable VMX if it is supported and enabled on the current CPU
  */
 static inline void cpu_emergency_vmxoff(void)
 {
-	if (cpu_has_vmx())
-		__cpu_emergency_vmxoff();
+	if (cpu_has_vmx() && cpu_vmx_enabled())
+		cpu_vmxoff();
 }
 
 
-- 
2.36.0.550.gb090851708-goog


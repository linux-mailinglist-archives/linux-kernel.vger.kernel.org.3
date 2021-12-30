Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8D48206C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbhL3VcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 16:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhL3VcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 16:32:07 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404FBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 13:32:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o13-20020a17090ab88d00b001b2080bbfaaso16406473pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=Tk5FZPUOSG5QUOTxbwl+dObOTlfYMpElTWW624XpkPA=;
        b=izh4Bx1VTJfQVigtB58+Qbfy/kZORdXMlI6hyUHX6Y3uVXKJkkAWxH3Jtkjyjv7eCK
         MrkaOniCgmvRQWAGzXQIdfsYwNpUrWgyM/4xjs2TT3INJReCH59hgxp5Kacyb8QguHiN
         JJnH9plOkST1ZI+K0UzmUNnxd5Pk8w0liM4kBryLRZfWQtRlv9iUTnLtjylPfcA4TZYu
         GCn0Xt9xLLfpFbgAe0HCLcdpzz/qWMX5fopm7utKD6oB0WmMDOcHlWNQf2qTDIn7LWRj
         HmutFJ3Z3nnZn0pcYFsHMm4KXtvs/eef7Hhxq4Nai9wxQJYoPUBCc70s3FfU/cphzpjw
         RibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=Tk5FZPUOSG5QUOTxbwl+dObOTlfYMpElTWW624XpkPA=;
        b=rBhPTccBeiqkKHHgLoq0hsLN4hMS/nbnSlUFuquvm09xr1YUuydYoHqehvt2SFFcrk
         x3l9lFjrAkBhamAmJPN01XI8NZRggKU/tq4nlTTI2jukeIf7odOqNTLVDgEp+nxZhItT
         +uMwTn6zc76sB/3413mj8eaIt4bTO3dH/jQqgDDfumhVpuWB1cdH1d4lNJuT9ZCi4hvY
         MavAVaAt3qPq0yskQA0jhdRlWAxnxEJaG86mFnpDo6cg0/+/y/qTFu4+2c1ZaL30EWZ9
         srWbgsg2m7tj7FZz/F6Jq+n4r0ujBO0toHU2pZlKYtsnKYNzl2xkAwdfhPJ0/OJscJ4W
         ycsg==
X-Gm-Message-State: AOAM533NP/vIzDnHuT5YPd+iA+7DtRgTegRhopp6R/QtESX8QASXDqR8
        y16B99iRG+V1pxwOdbOPko6aN7XJRpw=
X-Google-Smtp-Source: ABdhPJxHo/nfFcTiVVRyT1NJGaHL2s2Bi5JczRCTb57599pmdyGwkhnIVN8YKno0sdCcieP9YguwYPSSqso=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:da89:b0:149:304b:fd4c with SMTP id
 j9-20020a170902da8900b00149304bfd4cmr32747343plx.72.1640899926417; Thu, 30
 Dec 2021 13:32:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 30 Dec 2021 21:32:03 +0000
Message-Id: <20211230213203.2316921-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH] KVM: SVM: Create stack frames in VMRUN wrappers to make
 objtool happy
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "mov %rSP, %rBP" to the prologs of the VMRUN assembly wrappers to
create proper stack frames for the sole purpose of eliminating objtool
warnings about using rBP as a scratch register.  When the kernel is built
with CONFIG_FRAME_POINTER=y, i.e. frame pointers are used to unwind,
objtool is used to validate that assembly functions don't mess with rBP
as that can cause callers to be skipped by the unwinder.  SVM needs to
save/restore rBP across VMRUN, which triggers a false positive as objtool
thinks the PUSP+POP without creating a stack frame is indicative of using
rBP as a scratch register.

SVM's VMRUN wrappers don't truly need a stack frame as they don't make
any function calls of their own (ignoring the CALLs emitted to fill the
RSB), i.e. won't break unwinding, but the extra MOV is basically free and
eliminating objtool warning allows for a completely clean build with many
configs.

  warning: objtool: __svm_vcpu_run()+0xde: BP used as a scratch register
  warning: objtool: __svm_sev_es_vcpu_run()+0x46: BP used as a scratch register

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/vmenter.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 4fa17df123cd..b62b1fd53caf 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -36,6 +36,7 @@
  */
 SYM_FUNC_START(__svm_vcpu_run)
 	push %_ASM_BP
+	mov  %_ASM_SP, %_ASM_BP
 #ifdef CONFIG_X86_64
 	push %r15
 	push %r14
@@ -164,6 +165,7 @@ SYM_FUNC_END(__svm_vcpu_run)
  */
 SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	push %_ASM_BP
+	mov  %_ASM_SP, %_ASM_BP
 #ifdef CONFIG_X86_64
 	push %r15
 	push %r14
-- 
2.34.1.448.ga2b2bfdf31-goog


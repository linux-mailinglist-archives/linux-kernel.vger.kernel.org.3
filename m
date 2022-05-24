Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F1A5332B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiEXU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbiEXU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:57:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D89D3B033
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:57:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s10-20020a170902a50a00b00162359521c9so2722565plq.23
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lupwoiIHSZjNm5eHKqOy8JlCyVBIv5yC/9yPkxpNszU=;
        b=jfYeSvEJH6TVFdfqmAQGSWOVWnNJxEe8cvgyyfm7cJc+NUP0MamvlUzq+Or2qri1wU
         tXuJkNgi6gdZs20UxzlO9LckiD8gc1ewFWvKwSy514IxXuISxbq0aAWC/ABsy6kZE5jD
         ywG609MHA9DTgBoKAGUTNUXREoy3qoWGjuQyrkGUf/KDQnBvOKpaDNeMhUKcKUitR3nf
         +8F7Ls6sdcSKGsol/j137oy6quro/SCyWZqexkweR/2S0NHOMoZX7NNRHMElgAFUJwml
         TmsG+kIXG4KHI4Rr2ZP7pt2sUiXs3v5NmmfRRTdgUx8UvNYCYne0bNyntNxpJEAnnHXQ
         An5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lupwoiIHSZjNm5eHKqOy8JlCyVBIv5yC/9yPkxpNszU=;
        b=Lesua5dCh5wKu36OZuNBaLzETMrjf11UE6rQvxIkl+qYbywhcMQtiqLGFt7k5NHKyA
         5gLTrm9Q1/OqbFbUFmunZ0Nuoa6z+sRqX1D9Kq7G09au6ZpdYjmlnZqJzi8gzGrYOz4r
         EdSMNg1izspXXBAUixx+hCsAg6vx9saKuYTPBHa3fHARAFlsP3HS9EtqFNM1emhIGUNz
         Q3kZnKInWF7gusDvmRxb/W234bYWIumsxLrtm+9oC/L9JH0jr5QdMRENelSYTf/rrRLv
         ruaXDgXnuiYeM6TYurLZcM29/6zxOSYsTYXRzQQJpNhS5jlNxPGRdlnre7UGQdvslWMg
         4WwA==
X-Gm-Message-State: AOAM533fRhu+thRyw53HTx/Pp5PDWEPl6lpuqRHw1WSrO5Obuj9KTRGR
        7+VQ9Yj6z2kg1jp3uoivmotMQXqnaWbOz+VF
X-Google-Smtp-Source: ABdhPJxYsghOrwW3NIvkkEKuM9QOpMmpIRLpmckMl2sc+0UeXOdkcGXwo48/Sg+GsxaJnAh3qIALbm0o+t7ncVE5
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:1494:b0:518:b738:5876 with
 SMTP id v20-20020a056a00149400b00518b7385876mr8184004pfu.58.1653425828701;
 Tue, 24 May 2022 13:57:08 -0700 (PDT)
Date:   Tue, 24 May 2022 20:56:45 +0000
In-Reply-To: <20220524205646.1798325-1-vannapurve@google.com>
Message-Id: <20220524205646.1798325-3-vannapurve@google.com>
Mime-Version: 1.0
References: <20220524205646.1798325-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC V1 PATCH 2/3] selftests: kvm: sev: Handle hypercall exit
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Add support for forwarding hypercalls to vmm from
VC handler.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/lib/x86_64/sev_exitlib.c    | 39 ++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c b/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
index b3f7b0297e5b..749b9264f90d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
@@ -199,6 +199,31 @@ static int handle_vc_cpuid(struct ghcb *ghcb, u64 ghcb_gpa, struct ex_regs *regs
 	return 0;
 }
 
+static int handle_vc_vmmcall(struct ghcb *ghcb, u64 ghcb_gpa, struct ex_regs *regs)
+{
+	int ret;
+
+	ghcb_set_rax(ghcb, regs->rax);
+	ghcb_set_rbx(ghcb, regs->rbx);
+	ghcb_set_rcx(ghcb, regs->rcx);
+	ghcb_set_rdx(ghcb, regs->rdx);
+	ghcb_set_rsi(ghcb, regs->rsi);
+	ghcb_set_cpl(ghcb, 0);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ghcb_gpa, SVM_EXIT_VMMCALL);
+	if (ret)
+		return ret;
+
+	if (!ghcb_rax_is_valid(ghcb))
+		return 1;
+
+	regs->rax = ghcb->save.rax;
+
+	regs->rip += 3;
+
+	return 0;
+}
+
 static int handle_msr_vc_cpuid(struct ex_regs *regs)
 {
 	uint32_t fn = regs->rax & 0xFFFFFFFF;
@@ -239,11 +264,15 @@ static int handle_msr_vc_cpuid(struct ex_regs *regs)
 
 int sev_es_handle_vc(void *ghcb, u64 ghcb_gpa, struct ex_regs *regs)
 {
-	if (regs->error_code != SVM_EXIT_CPUID)
-		return 1;
+	if (regs->error_code == SVM_EXIT_CPUID) {
+		if (!ghcb)
+			return handle_msr_vc_cpuid(regs);
+
+		return handle_vc_cpuid(ghcb, ghcb_gpa, regs);
+	}
 
-	if (!ghcb)
-		return handle_msr_vc_cpuid(regs);
+	if (regs->error_code == SVM_EXIT_VMMCALL)
+		return handle_vc_vmmcall(ghcb, ghcb_gpa, regs);
 
-	return handle_vc_cpuid(ghcb, ghcb_gpa, regs);
+	return 1;
 }
-- 
2.36.1.124.g0e6072fb45-goog


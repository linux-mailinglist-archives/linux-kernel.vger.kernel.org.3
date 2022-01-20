Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6395A49455D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358139AbiATBHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358067AbiATBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:07:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD97C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:07:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i25-20020a635859000000b003486e456e52so2679489pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=etmFS5aQ8X6vAJnSs1+UFq6/lLfLZRuqqadMgpcY+H4=;
        b=IZeBbskZYHHbh9MmvaLxBTCLgAh/+23lV4uSE8Kr3gsvq/d0mmmx0WbWXGB/rojdbP
         7dZh7UtuGnSJuvzxILtGWx0nKdSSL4aEARVKqgpTOflP5I887OUu2O2WFTJKRLuSZ5PG
         YX4wF6R3Y+iJ6dsUtEwPBkY7+EugAMWitpnmG0EBisvjscdUmyxVN4V1hZkS8HcCFvB/
         U7spOaT5SSKl3EUYJxcNh7VrhpM1iszDOX5pV1DkvVKnNOmMyd4O95S4rP6e1b7OGRk9
         ysYTm0TwWaLOQDGYtYHjQBsFGfKh+OnSWfnioFvpB2OaAfAdP8mFGEYRJUEX2qPTbeJf
         DWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=etmFS5aQ8X6vAJnSs1+UFq6/lLfLZRuqqadMgpcY+H4=;
        b=zEn6icDeaUgTwrcIN4S46T8GHFnXEAi0kD0TYTMFSpSrthQ0ApvPAOZ8ZeQJEdezHz
         GL1fV5iGwhG5VPeOCXyEx1HWIN1CA+V6Nxjd6aHYdsOuZO8NTmnpJ78DFacJ8NrSHsJn
         Ogew+pJeL/0pDT+/SW0XRy+Z0iXH8RwujBOZWXJwNEGZ/nuYTk3WaEKh8chuhuz2rCvx
         8kmYX6YMwgt5YR0z4506Bd+O1LuwTp0kqhrlGArWhxWXlMvfiQRPkju2UiarVrK3VBpl
         SRvCLetUpYGSMJdBJIukrPDM/6S0+WID7m04KI8IQfm8Vkw+JyFEvMsq6CNXIYz5jZRa
         ZDEg==
X-Gm-Message-State: AOAM533D7YbXvobbiimasHZv51BtDGDNJP200mM9QyfaBb0hNaB3gbB7
        awlQhMS0fA2TeUQk61mwmfhTFhRnb0g=
X-Google-Smtp-Source: ABdhPJz//VfhQY7uDSpPFJC1RKvS96ldqzb5J6rUkijGyq4uR2uWEtf7fV8kfxwvh9RZNa8/pbVS0NaY4YI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:70c7:b0:149:d966:789d with SMTP id
 l7-20020a17090270c700b00149d966789dmr35860150plt.164.1642640850279; Wed, 19
 Jan 2022 17:07:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 20 Jan 2022 01:07:14 +0000
In-Reply-To: <20220120010719.711476-1-seanjc@google.com>
Message-Id: <20220120010719.711476-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220120010719.711476-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 4/9] KVM: SVM: Explicitly require DECODEASSISTS to enable SEV support
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sanity check on DECODEASSIST being support if SEV is supported, as
KVM cannot read guest private memory and thus relies on the CPU to
provide the instruction byte stream on #NPF for emulation.  The intent of
the check is to document the dependency, it should never fail in practice
as producing hardware that supports SEV but not DECODEASSISTS would be
non-sensical.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6a22798eaaee..17b53457d866 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2100,8 +2100,13 @@ void __init sev_hardware_setup(void)
 	if (!sev_enabled || !npt_enabled)
 		goto out;
 
-	/* Does the CPU support SEV? */
-	if (!boot_cpu_has(X86_FEATURE_SEV))
+	/*
+	 * SEV must obviously be supported in hardware.  Sanity check that the
+	 * CPU supports decode assists, which is mandatory for SEV guests to
+	 * support instruction emulation.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_SEV) ||
+	    WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_DECODEASSISTS)))
 		goto out;
 
 	/* Retrieve SEV CPUID information */
-- 
2.34.1.703.g22d0c6ccf7-goog


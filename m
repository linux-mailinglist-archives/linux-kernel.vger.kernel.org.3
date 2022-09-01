Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA84C5AA16D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiIAVSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiIAVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:18:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687A88DD3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:18:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g9-20020a17090a290900b001fd59cc2c14so110157pjd.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date;
        bh=9FbEF2u2Wd8nNdrOcqEf1hjJETad70OGAaRnEVrgyZs=;
        b=tA8U8AtVPwpwQJnv8/Ju0yEsJiQZCkhrdkYMvlM69umJFpREDp09tZkqcrtJE6Ea50
         vEEzYBmJvqkSEv7G2cZGTFVawCI07V0/XU7MFjgB4d8BUW5JdhHi6iKziJ3ZGC7/S/iK
         kCq0ldUplUfnTIAErUg3T07G9Yu3H8UCcCxwsmqAULKhqWaeP8K9oMEK/LhYa8LllzIR
         HJcKzFw/huceUzaEoJAy5OarWAa2mVMHFpyVAteBBF7p6g0YHotU14D67EhFuKGDDa+W
         SZFYEZ4wThGwUO92HWAS9QOY+MMZt8DMMJW92BSQq+MJnPg9FH1qJogTuJEqzX1ST5VN
         JxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9FbEF2u2Wd8nNdrOcqEf1hjJETad70OGAaRnEVrgyZs=;
        b=pXH+DSZkU35pvubT5svx7tuAzwQh1RTemfRx/TM4Lp6dlGuUlflRvwWBLvK7qNrgOa
         bmQqVaVa0g5ixBXsbu1gLzcSrdk1aYNNGoXAzQxT+b78n6EW3uONd9fkgFH2tLKOUFXf
         01YD5+2MykbbVuki5tgEujI62Et/8at2V9G3unL9FPzC16JTtxik4f8/qZBdlPnSBKk4
         +Or6RuN+yaiUy7+IIUMKhidXavaILzV+4ERLux+UjMIJu4EuTTarSlYWwKskr8WJXLIz
         1lc6EHw2K/ozEYuzE/5OqYrJ6HLt7Y7GFw1K8IxOYjvCFkPOxSqbaP0s8mUXBmbcQXgW
         9eOQ==
X-Gm-Message-State: ACgBeo0I+nO+0I+jAO1zrAmg670kDiUrIlbYS1Y3tF/b0dQEBNN517B1
        nQdh963t9KSPPOmCrQVR9bU+EOKV52rx9A==
X-Google-Smtp-Source: AA6agR4STjdtNy5UpF+u2VbqMIU5QX+iFd/AvwiK97WR//zap/n8GulygyWoxlkeLxeH5L+xApfuS5OrslhvXw==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP
 id ei24-20020a17090ae55800b001fbc4b71a24mr107677pjb.1.1662067123612; Thu, 01
 Sep 2022 14:18:43 -0700 (PDT)
Date:   Thu,  1 Sep 2022 14:18:07 -0700
In-Reply-To: <20220901211811.2883855-1-jmattson@google.com>
Mime-Version: 1.0
References: <20220901211811.2883855-1-jmattson@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901211811.2883855-2-jmattson@google.com>
Subject: [PATCH v3 2/2] KVM: x86: Expose CPUID.(EAX=7,ECX=1).EAX[12:10] to the guest
From:   Jim Mattson <jmattson@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Babu Moger <babu.moger@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" 
        <kvm@vger.kernel.org>
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

Fast zero-length REP MOVSB, fast short REP STOSB, and fast short REP
{CMPSB,SCASB} are inherent features of the processor that cannot be
hidden by the hypervisor. When these features are present on the host,
enumerate them in KVM_GET_SUPPORTED_CPUID.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 75dcf7a72605..172cbfd60946 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -636,7 +636,7 @@ void kvm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
 
 	kvm_cpu_cap_mask(CPUID_7_1_EAX,
-		F(AVX_VNNI) | F(AVX512_BF16)
+		F(AVX_VNNI) | F(AVX512_BF16) | F(FZRM) | F(FSRS) | F(FSRC)
 	);
 
 	kvm_cpu_cap_mask(CPUID_D_1_EAX,
-- 
2.37.2.789.g6183377224-goog


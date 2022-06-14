Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AC054BB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357619AbiFNULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357334AbiFNUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:10:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242194D9E4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:37 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o16-20020a170902d4d000b00166d7813226so5345261plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=PJnlmNpDUw7STxIFmSjFwcfSAZgkd9fbeUjZMsv1LHA=;
        b=TkCuCdr3DpRCtXXD9LiJCJrqfX+6Ep+D8GsO66RIYfJwCWm5tsN2UpsnNeUbqoDgzc
         IOC34y1OqtMQEGzm7jZUBS49jRI2mCT/eS4ICJHTlXx6UHxeecv8ypgle+JVcW8+7H/t
         NYL1JDtBBSVyMWUVbXUAbkWSzYM1xSsCYxlmXykCMMPnFnc5IpE5jlkRIZNmh/kODxNv
         VIWAL0KiWsooPZ9RuMDQodhhq81fekiwE5qBgGNm5bK2tflgpkaKkrt/b66Z45SMkJ63
         LGEzJitMPuLtHyIC73JET0BVf94Ip3e6rBKAcBMVfVJ/iDGgxqeD8DqSA2p/WFsdr29v
         /4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=PJnlmNpDUw7STxIFmSjFwcfSAZgkd9fbeUjZMsv1LHA=;
        b=YZnzvZl4qhcOECZr2U3qrj0hbSK9XpkYCB93kL2EppXOplEK0mXszCEdZa18t3meV8
         7Wa6Ki9EAOvL2DODPUs9Bkm3m2eS4oCmfS4GcNzi8KiSfTO9ATpacLRAUzQJRlPAGGeo
         +oc89DAZ2Xz0M4OwdhWIdjlB3p0P9ecsSUpAU+uzhsScyaIwfFhiefHaAAPDK3P0jBRV
         Q2D6mlpdG7Z8H/90z2VMtUSxDdIGKN1+lngOS41jhxz09coxurHaO9YNCCQTMkYyodHZ
         bD8hj4kkV+ISXmwHz/eQRbFmXjQ8AgCGdmdbWPgcBtpwat2EDEHRyXK3Jja0WRYs5jwg
         5c2A==
X-Gm-Message-State: AOAM532Qsji5BXDWs4ech4klYeEL303qx1fxmONDFE67aR+Y73D/veFU
        hzlrN5fmIUqHmhpACrcjpyzru9Wh7bM=
X-Google-Smtp-Source: ABdhPJzcaivXKiKvWFdb2C7A5+oPu4QwxuurTm707cyW1Zg6UjB+HkY6ZL43Uxh2Enfsj4DSX85UowNeAMk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:d10e:0:b0:51b:d711:b189 with SMTP id
 z14-20020a62d10e000000b0051bd711b189mr6449271pfg.40.1655237307579; Tue, 14
 Jun 2022 13:08:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:07:07 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-43-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 42/42] KVM: selftests: Drop unused SVM_CPUID_FUNC macro
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
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

Drop SVM_CPUID_FUNC to reduce the probability of tests open coding CPUID
checks instead of using kvm_cpu_has() or this_cpu_has().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/svm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm.h b/tools/testing/selftests/kvm/include/x86_64/svm.h
index 2225e5077350..c8343ff84f7f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm.h
@@ -218,8 +218,6 @@ struct __attribute__ ((__packed__)) vmcb {
 	struct vmcb_save_area save;
 };
 
-#define SVM_CPUID_FUNC 0x8000000a
-
 #define SVM_VM_CR_SVM_DISABLE 4
 
 #define SVM_SELECTOR_S_SHIFT 4
-- 
2.36.1.476.g0c4daa206d-goog


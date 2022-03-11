Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3D4D59A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346354AbiCKEgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiCKEgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:36:22 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342BC0869
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:35:19 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p5-20020a17090a748500b001bee6752974so4492337pjk.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=1qfqx9Ge9u0RWGm7AmaLO27aDOSV7ERQbUebM2K5eIY=;
        b=YeZ+VU1UQHIBL6iA/MyWjoA1R4+0a3ABLlbvh4P+lqW8FYFeySrsGTXzAFodGTfxwU
         jWWT95kARPSTdr2MxmNXGRDMlvqoYXDBRPE6Yqd5EGhCDVx/t4OEKvJsYfEa3xZr7n52
         NEGyJHWAuvz1LEPEzU2Z47MygIxwDEWzQHMSd8v6U5X8dYBET5a/t9ehkN8JpCcAaYgL
         HqWMofOFcozvU+M36kJCH3Y5k7lScXi7l0+5U3bspy3FjQgHS7eribEfIFo8Kkwqs8tn
         UucmIGnLgInOqy8GaIglDO74lh1vcDxrFSX+HIkYXbBB4rE/gwMrYd43AUnAsvnTKg1U
         jSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=1qfqx9Ge9u0RWGm7AmaLO27aDOSV7ERQbUebM2K5eIY=;
        b=P7ei9J5joGYhws1meW42+LFJGlN/HIPLzaL9pJ4cISkrX+bL7wKwV1nBTeEeFZhHTi
         OxK8/mqdnYq8c134nHVToqpWBiYX25icGHkA4n2Z8xkxjX3BwSW2fnLrzjsequstDuPI
         XLWNy1+iJX1wRSR/tgEJMnWJeO8wTGIhxm7b3mRc8b/5E7KMD+81PVrZ1D2LLIPpWXa9
         e1cdRl2rUqLHjrKHgzMpMd4z/eOuQjJ3mLaoPQqdZNIDKiIPtqrcdN2dF9gLfR6+R/oU
         zGj0ytp0Ra70Q6OSxNnjeXbgVAa0LmfQZYNRceG2v9ftjT5gn1nLxgJE+d0GeysrqzKi
         I0TQ==
X-Gm-Message-State: AOAM531vXH8nJZYQY3327iRP5DHP8pXF7shIa9YsLiSuCWhy65BYxL+E
        n2kMQfh7t55lMFahPzxq1YQ0NjH7uBI=
X-Google-Smtp-Source: ABdhPJxiDydGN/XneCmpn4T2UZiWQQwIScbRjNgi871DtBiUQmNZ5uYWWwiEMun7Bs2iGMA7VXfly0Rg7Rk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a07:b0:4f3:eba5:42ae with SMTP id
 g7-20020a056a001a0700b004f3eba542aemr8167929pfv.53.1646973319389; Thu, 10 Mar
 2022 20:35:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 04:35:14 +0000
Message-Id: <20220311043517.17027-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 0/3] KVM: x86: APICv inhibition cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Refactor the APICv inhibition code to use small set/clear wrappers instead
of passing an impressively ambiguous "activate" boolean.  Opportunistically
enhance the related tracepoint so that debugging why a VM can't use APICv
is slightly less painful.

Sean Christopherson (3):
  KVM: x86: Make APICv inihibit reasons an enum and cleanup naming
  KVM: x86: Add wrappers for setting/clearing APICv inhibits
  KVM: x86: Trace all APICv inhibit changes and capture overall status

 arch/x86/include/asm/kvm_host.h | 39 ++++++++++++++++--------
 arch/x86/kvm/hyperv.c           | 10 ++++--
 arch/x86/kvm/i8254.c            |  6 ++--
 arch/x86/kvm/svm/avic.c         |  4 +--
 arch/x86/kvm/svm/svm.c          | 11 +++----
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/trace.h            | 22 ++++++++------
 arch/x86/kvm/vmx/vmx.c          |  4 +--
 arch/x86/kvm/x86.c              | 54 ++++++++++++++++++++-------------
 9 files changed, 90 insertions(+), 62 deletions(-)


base-commit: ce41d078aaa9cf15cbbb4a42878cc6160d76525e
-- 
2.35.1.723.g4982287a31-goog


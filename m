Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563DD4EB704
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbiC2Xwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiC2Xwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:52:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFED1CAF14
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:51:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o13-20020a17090ab88d00b001c96a912b04so2277713pjr.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=WvAzX2UFzrcmnGH2vmugmzpfgQULkOHCxxh3/x0LXYU=;
        b=BPlx2KF1D8FGHH5fvfR/iEDQ83SwMjjzz/qj+xyb30YOS3YUQMblHjgRJ47tO+skVq
         k6IZmMkCv88Xu+AlID712AQM1WVpN61JbneX5V7OvxF/VO9waSGZV3kWefJSDRzm88Ov
         fs8GR01P+siNqRTGplL0gZZCRzy3YhMmHVGeV4Wyv+0GXtpdtUbTYGKNVLNQQd05qC9o
         D1lPrKR2tVKLPyDTBAGVSLjkj49pXIF3j/kgkMfHYgSBpk7PJFFoW6RAri6eXDDQaCkw
         ICHc2Kb/grs2xK///Gu7nfWGBxgJ6Y5LbE+GtwAQjr20+91orcJUiRLsXkGU4plOytYI
         xJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=WvAzX2UFzrcmnGH2vmugmzpfgQULkOHCxxh3/x0LXYU=;
        b=3aVq80HUC29AU+S8ozQEzcVZqhiMlLzkEEEYch5aGlGE/9AW27PtY3WT4JeqXHJyJt
         zRlyvO00IBtku2I+aOX7yeEa8vwBr62iKzOJ/KzZmrKgjFKETSG8wc5+v96FXXodboN0
         q0dqq4NHf06rLHi51vb67LApJ85M4Da6AQDI6GC5Z2Dmy5DYr8myjVhc6dA3bTJeSp12
         +9Ddp9c7v7G7SooMF+Kfh6p7awudy6ZE1P+vOvPG8Nz/gFhgJF6UE/c/crGF031aXlV0
         TbFBmH4EIP6sYdXBfRZVJqm5gEWV4spZLRyayr4exdgurZ7X6PNMPSVDm/ikoHlceGS3
         KTnA==
X-Gm-Message-State: AOAM53119x/PXcfaZ3UBFHFGVcE/SU1qKhJq+IHBzSM2knWG01OOEOoF
        I9CvNXxfE3oTCsdgf2jhLiv8u0eKl6A=
X-Google-Smtp-Source: ABdhPJx7118GWysS/qqYEiOU63qQ829NqxgTMLaXG2hSAvMcoVU8gU73LCEArubw1Cu4QyMD/CisSipYb+Y=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:9f98:b0:154:a809:7f0f with SMTP id
 g24-20020a1709029f9800b00154a8097f0fmr32287189plq.118.1648597863760; Tue, 29
 Mar 2022 16:51:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 29 Mar 2022 23:50:50 +0000
Message-Id: <20220329235054.3534728-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3.1 0/4] KVM: x86: Use static calls to reduce kvm_pmu_ops overhead
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>
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

This is a minor iteration on Like's v3 to allow kvm_pmu_ops (the global
variable, not the struct) be static.  I ran the PMU unit tests and compiled,
but otherwise it's untested.  Strongly recommend waiting for Like to give
a thumbs up before applying :-)

[*] https://lore.kernel.org/all/20220307115920.51099-1-likexu@tencent.com

Like Xu (4):
  KVM: x86: Move kvm_ops_static_call_update() to x86.c
  KVM: x86: Copy kvm_pmu_ops by value to eliminate layer of indirection
  KVM: x86: Move .pmu_ops to kvm_x86_init_ops and tag as __initdata
  KVM: x86: Use static calls to reduce kvm_pmu_ops overhead

 arch/x86/include/asm/kvm-x86-pmu-ops.h | 31 ++++++++++++
 arch/x86/include/asm/kvm_host.h        | 17 +------
 arch/x86/kvm/pmu.c                     | 66 ++++++++++++++++++--------
 arch/x86/kvm/pmu.h                     |  7 +--
 arch/x86/kvm/svm/pmu.c                 |  2 +-
 arch/x86/kvm/svm/svm.c                 |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c           |  2 +-
 arch/x86/kvm/vmx/vmx.c                 |  2 +-
 arch/x86/kvm/x86.c                     | 21 +++++++-
 9 files changed, 102 insertions(+), 48 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm-x86-pmu-ops.h


base-commit: 19164ad08bf668bca4f4bfbaacaa0a47c1b737a6
-- 
2.35.1.1021.g381101b075-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4E5426BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442213AbiFHB7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835814AbiFGX5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:57:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6677B9E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:23:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lk16-20020a17090b33d000b001e68a9ac3a1so10017351pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=bo5BCelcXXt3fHu9uBgQz0Xkxt3J+8ZEKQKzX+su88Q=;
        b=AiWxLo79QymuoxjFrVU0MccHOPdDVerKMgDPDOQLVx7/paevTTfLP5MwnqRr0H2DQ1
         uWS0vJOABqTtIaXzHaSqXGOrcdd9nuhFb7ZbsL0rf6NF5PwgMuLZ2wl0J5PVJlVuqWZj
         npkbf1QsdROJjca6fCWGfw3CI5Uzx9EyRv+7Lbe9Q3fYDnyxqsi9wUDqJJBSxKS5Z2KK
         BTO5PvSVRPL8Y295Rirvtu71qnFQSp+pCXjEKkb7t53+qd6RV5MdPRnGzkbHNdBrosdp
         W9ML1PpUppa5yLI+rn8oRKOfmaKPLjGfhIXb2LVFqVLE/6cOBADFiTsySyENVhxwwRGR
         NRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=bo5BCelcXXt3fHu9uBgQz0Xkxt3J+8ZEKQKzX+su88Q=;
        b=Q8dw0z3Iv2UMvfWpwyui5FoHBRy0g+v2brIkddWLJw5rV6UdtpZ8LpfQbZaq6QXtap
         O6lGkavLkBP8n6KH7i+Ga9GBmNzYKA7RKgAqqAtuc+IzELFKSWjhN/NJ12xd4ZU6qsvx
         8Q7stQds0W0gGoQF1XhxTp3F/Lv+2VDhe569+4AbAUvBgycCEmtfv7C3Q3JeAKeahgdU
         m55U2t4e0YJ7TaczlCvD6T3/aMNwl6dbep9e39Y8OJ97wruSHbTsjXAutOFVQ+3sjUeN
         O4jmPdd1tQWyEbBXctUBxjTGMT2vOMDFgVTMQU7KJho9cL/XbWhTh+uS88vdEV8tdJb4
         hTPQ==
X-Gm-Message-State: AOAM530vuha1I4tco62Mn937a0Ti1DibtUMUv2IKixOuHAx3FPG1NSNQ
        QWfYh110IXs7zNN1pyJrXJgWjzNKGbA=
X-Google-Smtp-Source: ABdhPJyWjszfOTBfQZ2L5GPUQD53SR9MIfNT6OkCd2LGRz0f74hUIQI6IopOkm2dZFMlwhpBGzb0jy7Rp8c=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:807:b0:51b:f4b5:db82 with SMTP id
 m7-20020a056a00080700b0051bf4b5db82mr19693888pfk.57.1654644236226; Tue, 07
 Jun 2022 16:23:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Jun 2022 23:23:50 +0000
Message-Id: <20220607232353.3375324-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 0/3] KVM: VMX: Let userspace set IA32_FEAT_CTL at will
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where KVM requires userspace to set the guest CPUID model
in order to enable features via IA32_FEAT_CTL.

Note, the selftest builds on the vmx_msrs_test from the VMX MSRs series[*],
i.e. it won't apply cleanly on kvm/queue.  

[*] https://lkml.kernel.org/r/20220607213604.3346000-1-seanjc@google.com

Sean Christopherson (3):
  KVM: VMX: Allow userspace to set all supported FEATURE_CONTROL bits
  KVM: VMX: Move MSR_IA32_FEAT_CTL.LOCKED check into "is valid" helper
  KVM: selftests: Verify userspace can stuff IA32_FEATURE_CONTROL at
    will

 arch/x86/kvm/vmx/vmx.c                        | 43 ++++++++++++++---
 .../selftests/kvm/include/x86_64/processor.h  |  2 +
 .../selftests/kvm/x86_64/vmx_msrs_test.c      | 47 +++++++++++++++++++
 3 files changed, 85 insertions(+), 7 deletions(-)


base-commit: 838fd3e5a7208ee3b95bf73898c135a44a0c589d
-- 
2.36.1.255.ge46751e96f-goog


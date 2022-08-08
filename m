Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E391B58BE7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiHHAgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiHHAgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:36:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99C63E0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:36:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 92-20020a17090a09e500b001d917022847so3590870pjo.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to:from:to:cc;
        bh=ldduIU/m0IhSFb2TxSrTcvwnMILyzEYEmP5XNPE0Qxk=;
        b=XECQ1hV/f1lERFZRWFkfRrPsJsInZJhd2r1LY+BtWKd480OKauaMlHs1IC0brcLyVh
         8DkWQcxAQH1+XXwZGg3Rtb6mnwjSEm1R35ggyyi279XGTaWChfTvUjYU6V5eoHYFcR6B
         vXcmAC8jaTOG6lxq2UfN3ReLi2IVlJzIdqw6qtShM5MxSws8lqpiLTrwUFWquiYYIeDy
         QBeJVXPBoeYJCmJEsKwyJPyQFjNhshrVUGDR1sh8KXg5mzM92OPVEhx9Rfcs6EKSCc8i
         jNtIP3RtShUkHN0uK3LKG0sSP0Ge8yLCOaXXB329/aiprRTFozS4C2v8Sbaw+8jaDTj+
         jrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=ldduIU/m0IhSFb2TxSrTcvwnMILyzEYEmP5XNPE0Qxk=;
        b=GDBZTodIyhIKPHeY3GMsJ0o7IgQCcaPUBEXd5SDHhkqsXPDoI7GCxZWQfgbGWwJtPY
         MR1hgRNwXcs3oo3O/MVlco6Lsx/WD6z13u9Eye52uX9ggp9a4QGZto/qkVnvZQGymSmX
         B5ucMacWJh3K7gvvK/XuhVSidjeHTg7mPAYVxUMXBexn4VC1+f5+fWWF+8nWEqMrRP8h
         jmpHOhvvxB3rnzq8d2qWRPPqPIUgLMbu8nGnX4SldvsMefnumfTGsurebL5Vbny1XNMX
         +00xPG0oG6UdmQgzVJbqpUwXPf6nUl6U8TlTC2airxu3Xya7Sm57T2acq76YCHZDxUvP
         RgOQ==
X-Gm-Message-State: ACgBeo2te2lvtY1l7xzKiY1AJJesOpp8LgxqCLanDxO56RVKHPMN1w8M
        y9PAo2f4ABOZvSWBRZ4dTyiaZ9pXNN2p
X-Google-Smtp-Source: AA6agR55KsqCqECm9mnYdYXVsUD/wRg7jWiFCeWc/7oOo2Lx/gEmqO74hvY/fEGgRhnFa/2NwUSM9VZal+7I
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90a:5b0d:b0:1f3:137d:7927 with SMTP id
 o13-20020a17090a5b0d00b001f3137d7927mr17953562pji.18.1659918969226; Sun, 07
 Aug 2022 17:36:09 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon,  8 Aug 2022 00:36:03 +0000
Message-Id: <20220808003606.424212-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 0/3] Extend KVM trace_kvm_nested_vmrun() to support VMX
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>
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

This patch set update trace_kvm_nested_vmrun() to support VMX. In
addition, add the guest_pgd field to enrich the trace information.

v2 -> v3:
 - Split the insertion of guest pgd field into a separate patch [seanjc].
 - Update field names as suggested [seanjc].

v2:
 - https://lore.kernel.org/lkml/YurMLf3MDAK0RiZc@google.com/T/

v1 link:
 - https://lore.kernel.org/lkml/20220708232304.1001099-2-mizhang@google.com/T/

David Matlack (1):
  KVM: nVMX: Add tracepoint for nested vmenter

Mingwei Zhang (2):
  KVM: x86: Update trace function for nested VM entry to support VMX
  KVM: x86: Print guest pgd in kvm_nested_vmenter()

 arch/x86/kvm/svm/nested.c |  8 ++++++--
 arch/x86/kvm/trace.h      | 33 +++++++++++++++++++++++----------
 arch/x86/kvm/vmx/nested.c | 10 ++++++++++
 arch/x86/kvm/x86.c        |  2 +-
 4 files changed, 40 insertions(+), 13 deletions(-)


base-commit: 922d4578cfd017da67f545bfd07331bda86f795d
-- 
2.37.1.559.g78731f0fdb-goog


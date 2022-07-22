Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6392557E9F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiGVWoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiGVWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:44:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0A109C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:44:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l6-20020a25bf86000000b00668c915a3f2so4599936ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=j8oRiyx9dXqV7vPKYboluXt1U7dVeZU4Z3i7e3MK2Qw=;
        b=qbTvZCxh50eBdy6iEkrMwum5y36MtOX6vakynZX0gRRTQmJHuMYRyKPuoBBvttjeAr
         R8oM5sSRd2QMVj1mujp1n6poemzmhqFWldIBO+oxhWI3lr2fHLxU0l9OwTz2eLbtAc9Q
         aLemE5fS0+iyNo8j00F4F6v2CN+XXvQwwk9eIB1nu5IkAVM2ITMVLqHXaI172doHI42u
         quOIFaJg7K7iHqNO9sREC/ksrAcsWE98619qW6zYZrdL+F2hGt+WYNiavR3/VMmGoCnR
         +w8p0jXUePe6P7DGUvWYg4mGVY9vxQDoPt6amKVAEQRdrwtBMo9doQQNDxO8F80LCbkw
         7FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=j8oRiyx9dXqV7vPKYboluXt1U7dVeZU4Z3i7e3MK2Qw=;
        b=0d1tK611mxC/QDOCqH6UZkEt7yfljGSSWy0K+NKcTYh9TJwzWtTKpkIumFiZkFXKu3
         25bNrLz+GP1k8rFF09uNWuIu22m/LN1aAmyG4Bq29+mb5bIMEkqfYvUtPpucpRkkMLtn
         GPxiX0jte+SXzWrV8ygp54vsU3XqcG3n0+qMZ1v1dlHAoCWRJtBT5ZiWcf9Epb0z4gCV
         nVf8+qDtFxgS4r8QRB1ZS1bLjYKj+A9WDSYrmoZfkKjFEJY11nJU8xAKypFR1AQd8ihO
         tIzD14tjQdOsIO/8KtOp76b2+queQXKwovUGWVJEwg6+8RjPKQs+k7V0P3SZeRooG5IX
         z4kw==
X-Gm-Message-State: AJIora8Iyj6+63ealtAV50AsfOPB0BESrmBsuzh77WlZbuocP23bB6pz
        sN+yEES6HyLhs8tIBV5jUE63mXmBzU0=
X-Google-Smtp-Source: AGRyM1v8iz/eHevRQ9dlbWckZAJONNTGRk/tyTPHxUfg114rq00aDrMVnAe88/HNVtcM1Fme6/GFvB9oUBM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:102:b0:2ef:48d8:24c3 with SMTP id
 bd2-20020a05690c010200b002ef48d824c3mr1831929ywb.153.1658529852712; Fri, 22
 Jul 2022 15:44:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jul 2022 22:44:04 +0000
Message-Id: <20220722224409.1336532-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 0/5] KVM: VMX: PERF_GLOBAL_CTRL fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is intended as a replacement for commit 00590a384408 ("Revert "KVM:
nVMX: Expose load IA32_PERF_GLOBAL_CTRL VM-{Entry,Exit} control"").

The basic idea is the same, except instead of skipping the load if
the desired value is the same, skip the load if the MSR doesn't exist.
AFAICT, that plugs all holes where a mischievious usersepace can get
KVM to WARN.

I dropped the CR4 changes for now.  I'd still prefer to give userspace
control, but AFAIK it doesn't cause problems, yet...

Paolo Bonzini (1):
  Revert "KVM: nVMX: Expose load IA32_PERF_GLOBAL_CTRL VM-{Entry,Exit}
    control"

Sean Christopherson (4):
  Revert "Revert "KVM: nVMX: Expose load IA32_PERF_GLOBAL_CTRL
    VM-{Entry,Exit} control""
  KVM: VMX: Mark all PERF_GLOBAL_(OVF)_CTRL bits reserved if there's no
    vPMU
  KVM: VMX: Add helper to check if the guest PMU has PERF_GLOBAL_CTRL
  KVM: nVMX: Attempt to load PERF_GLOBAL_CTRL on nVMX xfer iff it exists

 arch/x86/kvm/vmx/nested.c    |  6 +++---
 arch/x86/kvm/vmx/pmu_intel.c |  6 ++++--
 arch/x86/kvm/vmx/vmx.h       | 12 ++++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)


base-commit: 1a4d88a361af4f2e91861d632c6a1fe87a9665c2
-- 
2.37.1.359.gd136c6c3e2-goog


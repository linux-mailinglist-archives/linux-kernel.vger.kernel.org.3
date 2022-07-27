Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B25835AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiG0Xef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG0Xed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:34:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6AE564E4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:34:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v19-20020a252f13000000b0067174f085e9so366169ybv.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=L3m2JC5GapMYqTiLfpgpy+Syxp+egGM8zqBmpln74FQ=;
        b=QvTYidN+KmLvcyrB45xodWUwi/AdeLijHMBx02iEklp/7wl57m7u637uhOrULFDewY
         TqAKGaiQ7JdJhAgxOWdP05ycp1WblrYbO0SCtaXgJg8L0lR2xMIw+Oe8OzAv+uEDD2l9
         6fnOpN1vv4D2yUKVaT2JHZCS2EgkHP4db9EM4l7ip3q37wL7F5uWFshBXczDGRMuJUox
         1SWxuGx+0993mtZ+Goym38hbqGpcArVYyE9t6b8l8IbutN+O5/7yXiMnDR/M7FhIVISX
         d/9g9w1XuC97w6ae9THw15cTzlH/zf/Ipxh6j8XnRZkXRmCG0oeyVTrqdwPkKIPMu/34
         kGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=L3m2JC5GapMYqTiLfpgpy+Syxp+egGM8zqBmpln74FQ=;
        b=x/1O0LdAty+IT31gYoahBf0yOmVrMoAgYuxzPaR1hfDlMWlORFI2XAjpkzLiwui1Sy
         JH4RZCWVta548c+Vq+pCO08IgvicHvD8+0WW9mKwetb09YJssYmI4EgHI4WagVXi9zU/
         bTJXoKMpaBxqxYEqJM4XXq2EUMusZgpTulrZDWnqAv2p0cT6mzb395ekQ8YsbTJnVpMx
         hz8DJMd3bsJU28ziz4yg7Qlok2uGZZ4nOScyFRHJQarPQz918Sd1Irbc6V5/UlIo6gNY
         WOj34XpK5yvy6rzEI/j+a1qDmONZweLjdWc2hsnq3QMHrjdN8S0L6TiKhu4Pwq1IRh5/
         bg0w==
X-Gm-Message-State: AJIora8HCYdtYmepSdIjf68QoF77oMe0KWrLBEjp1ie4bsDpAO5DnUR7
        5TnfRDpOR80M+/7/BTNr/tXLRmVXmn0=
X-Google-Smtp-Source: AGRyM1sca9IphNd8CVhj6GCoCv/IHqCsRy7Rx96SSaFVhtFNf05rx3qu5MLsio63ysQSa/8xeUoPppboX9I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:1c45:0:b0:31f:539b:91db with SMTP id
 c66-20020a811c45000000b0031f539b91dbmr7764607ywc.435.1658964872253; Wed, 27
 Jul 2022 16:34:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Jul 2022 23:34:21 +0000
Message-Id: <20220727233424.2968356-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 0/3] KVM: x86: Intel PERF_CAPABILITIES fix and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
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

Fix a bug where KVM doesn't refresh the vPMU after userspace writes
PERF_CAPABILITIES, and then leverage that fix to avoiding checking
guest_cpuid_has(X86_FEATURE_PDCM) during VM-Enter, which is slow enough
that it shows up in perf traces[*].

[*] https://gist.github.com/avagin/f50a6d569440c9ae382281448c187f4e

Sean Christopherson (3):
  KVM: x86: Refresh PMU after writes to MSR_IA32_PERF_CAPABILITIES
  KVM: VMX: Use proper type-safe functions for vCPU => LBRs helpers
  KVM: VMX: Adjust number of LBR records for PERF_CAPABILITIES at
    refresh

 arch/x86/kvm/vmx/pmu_intel.c | 12 +++---------
 arch/x86/kvm/vmx/vmx.h       | 29 ++++++++++++++++++++---------
 arch/x86/kvm/x86.c           |  4 ++--
 3 files changed, 25 insertions(+), 20 deletions(-)


base-commit: 1a4d88a361af4f2e91861d632c6a1fe87a9665c2
-- 
2.37.1.359.gd136c6c3e2-goog


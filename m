Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF4578828
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiGRRNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiGRRNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:13:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3E2B261
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:13:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i9-20020a17090a65c900b001f03395643dso9767284pjs.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=hBW555vzZ9VwsiwxyvqF8/j7N4IdLZ1Pm2etmGkj9Ok=;
        b=EqOXIAFmmesXHqqQFo3pONu5uf32f5JqWCF2lKIjhQd4BOWd19v/3vwgO9In29blAz
         oMa8JbfevDRcwU1N4l97vw6esfc1WgiX18pg8XjHK8EY1i6N0JW65KpmARgyhOaWgftV
         ZSdz+oUM37q4T1JPfJcXLMD3Np0m5MWop0YBUCkyTBeo7bhFgExeoOlJbJNjLMP2SF4W
         YfWuJzBLfBCmm8BGPZcfULXGD7sjQb3TTclxTUn6HBf8EQjT/FP+n94FIqe5+RvBSQfb
         F4OS1GENnPqUPZOB8jHsOiRUnbuV7dRAn1XscKeYfNghwrnRueLHUHgOzecgiu8MQGQK
         +DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=hBW555vzZ9VwsiwxyvqF8/j7N4IdLZ1Pm2etmGkj9Ok=;
        b=TiHF3XI9R3WDSFnuO0gjLN+OAs1m43bTCLAXyBY6qGblT48rg6sZNFkF3YwPGA6G0H
         0qCzjAYqR0exrTCm59lV1V27MKzfQrEuhtaPDrYkviF06qojNZZILVYSV9GKyRF3rue9
         EC3GmzOTjzbdAH1mioOqcs4XM9FQf6K5p/fz5tr/3eln5LkNql643jJ+pNB1bzopB/3v
         NE9jGE8Veh+m3STd9HoDB6SyhGV7zGp49CNjKAWpcFj7h7bhT4qrTsndfPlj4NBMMv1b
         jPncguz7ZKswtFrmi9eIvtfWiPkD8PPtGpk8B/0XfPCjm3wlKMki0V9d3irlLElDY5JN
         Pavg==
X-Gm-Message-State: AJIora+TMsfQgZ14/piTWUykbgvshqfRDDyb4lh9I5hHmSJbQTFCpSjJ
        AOUfJOLSvvel1f+wi/ydr/P8BLEt/udz
X-Google-Smtp-Source: AGRyM1tNyE9t7NLqrrVSjIDGyHcYXyS3Ib48NX9s+UucFR8qcFtBGC2Zl8iwLf0L2nIH/7d+e4u+QANdsxDC
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:f68c:b0:16c:4eb6:913c with SMTP id
 l12-20020a170902f68c00b0016c4eb6913cmr28593782plg.2.1658164416047; Mon, 18
 Jul 2022 10:13:36 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 18 Jul 2022 17:13:30 +0000
Message-Id: <20220718171333.1321831-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2 0/2] Extend KVM trace_kvm_nested_vmrun() to support VMX
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set update trace_kvm_nested_vmrun() to support VMX:
 - Change the print of EPT/NPT enabled boolean to print of nested
   EPT/NPT address in the trace;
 - Add a caller from vmx/nested.c.
 - Fix some minor format fixes from the callsites and Update the trace
   output naming according to the x86 vendor.

v1 -> v2:
 - fix some format issue in trace_kvm_nested_vmrun() in vmx/nested.

v1 link:
 - https://lore.kernel.org/lkml/20220708232304.1001099-2-mizhang@google.com/T/

David Matlack (1):
  kvm: nVMX: add tracepoint for kvm:kvm_nested_vmrun

Mingwei Zhang (1):
  KVM: nested/x86: update trace_kvm_nested_vmrun() to suppot VMX

 arch/x86/kvm/svm/nested.c |  4 +++-
 arch/x86/kvm/trace.h      | 19 +++++++++++++------
 arch/x86/kvm/vmx/nested.c |  9 +++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog


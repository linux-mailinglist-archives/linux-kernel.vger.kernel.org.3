Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB075A1CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiHYW6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244311AbiHYW6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:58:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3BC6EA7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:58:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k3-20020a170902c40300b001743aafd6c6so37531plk.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc;
        bh=y+lzaBk65ww51hCvJgNyxoyJqrGC7YrgWGmE6om5SXc=;
        b=ceIE676UVZGKZm2E6Mt/s5wpUNVii4s5j4u15I933eTsczM6yQlR9HER8rvL67CEBh
         tMJiMWWqXr1cNE7tYmrfMsGab+TAx9LRvYC5yPgH/KHemrsnAr1Rb/fZTcbneTdNA0Lw
         o25UuDmuir0bBEQkRhLbBfZWjVkYGrAmAAHGY2ziK9y7ZgwL7tSbA16Z5DDmETEzt3AI
         JNPqxMHFjw2486Smpe56NI6yUCl9oZ/WBNQd35P1ZuBxRRAhKAxx+WkL3D+F/byUkb80
         sGhG7iUmX/0Oux2alHWN+IyKRqPgQhT62UVR/AlBcmnVNg05eEacNyVFmD4yVD1Y7dEr
         /ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=y+lzaBk65ww51hCvJgNyxoyJqrGC7YrgWGmE6om5SXc=;
        b=Gy9QUcecviLezI3Bi5+H0ObyC6eWR0EYxagX2ACcovGjERzeRePSAOs5UeGbs3zMuY
         C+tHCuCO7KWFF50GCRYlfzfd0IdfL9pJ5ZeMADZgDEJZGzqRd6nLC+ILjlkRjRA/JC8Q
         rwE8eQF22iHQVEaFyw+4JNvUd2U3+s9yQ4b1/lKjdMvLLsrJl8tG+4fMt+RzmSi5Q4En
         /LbjEjxBT17j73KTW2nwfdAcPURciTrkbdGB2QGYqx/Ji3WqFfSC8ZPlrFDN3xAItHLm
         A9jjS/GIAMrPUykiKQjtxqzMDffRpS0GzaRh0vKnvtHBa2KHtmsKxuBkUBZp6gndNDd9
         Dcyw==
X-Gm-Message-State: ACgBeo1N0KhkFIQRbiPlstbo3e73932ANJEHLbNgPnLiAgSDEAZwi+a4
        EPZLWK/XUI2YKfZeMoj7CVZPjcJy/8JV
X-Google-Smtp-Source: AA6agR7vZwPSASd9sVEMyperT8XtrEmCG6kXiaFQSuzjtM1/GuniGBXVT5lFXlTLDnM9AW1zi/7lNtpjXqw2
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:aa7:8430:0:b0:536:5173:a2c6 with SMTP id
 q16-20020aa78430000000b005365173a2c6mr1207357pfn.4.1661468284842; Thu, 25 Aug
 2022 15:58:04 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Thu, 25 Aug 2022 22:57:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825225755.907001-1-mizhang@google.com>
Subject: [PATCH v4 0/3] Extend KVM trace_kvm_nested_vmrun() to support VMX
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
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

v3 -> v4:
 - Rebase to tip of kvm/queue.

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


base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
-- 
2.37.2.672.g94769d06f0-goog


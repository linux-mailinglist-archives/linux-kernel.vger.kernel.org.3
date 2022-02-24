Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0CA4C35AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiBXTTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiBXTTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:19:51 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DD71B84C9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:19:21 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id t7-20020a17090a3b4700b001bc366c58faso4065006pjf.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=6f9rSiA8EDiLaM0B3Hbnw5EwlveWA1Ldae2Sb5yxk2E=;
        b=nYJn+JKr12seAv5JQcy4T/E/n76x8MDX/iXirgCs53CzjHGjFOUmeQrE6nQME0NUV9
         Fpwv3tE+MsTwzmB+Ownnv6AEFF1n4PWha7w/4fPcmAqhEmXW17wxq0w4CoN19+LiDgzt
         Jqw7k/erIlmjJ5BROlluuf+jTnMA419Gj7aWUksZY6jt9C5xHfz/WtQ/cBUjiXRxeZ1n
         LY14I9NvSXVWBJdL9QeZhvKd8GXiM1WgYh56HUextaDrM9L4qxPzSJvpy5lMQLIinias
         ynpjRNCjhbR+sFQTIjwvVjSbUT6W9mTd9QSL18S8JT1dmR+obQcV7koaA9Dx7otk2I2+
         Mm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=6f9rSiA8EDiLaM0B3Hbnw5EwlveWA1Ldae2Sb5yxk2E=;
        b=AMGLI/O4vQ0vJge2fyOY89GbcQOKlqEl2j7mMFJ4YZ/CcTrV8PUKCBHsGKexmFApuI
         M5VwTUU4A9Z224aw6gcdiz+v0kSp+NSaMx/ahXk3albsNohv+THM4VwaTR6nX2F9vc9t
         08G8O+H9645jI5fNtm28MIf0icVgEQcHcHi2TbrocFUw8qKl3zyfyJYvpSqAtgY5JBve
         HL8+ZE9yMgKDOvHf9d2dSUT9Q4+kewPRhwIb3JHElNuE6jgJRFVgjt2U/ksPaRZhVLjv
         gv4T/pVzy+nuOwJCBTlGiaPEqIv0mK6qPAo3EQfcwBcvi4KycvyrQlZgHLnAG5hpFu1H
         y6Ew==
X-Gm-Message-State: AOAM533I1ryuuy9+Ue3FMCo1atI0ptRWSYKFo5nShqLGSuF5hxJPnF40
        DkjCbUjkBuWHvIiI5sd3ZR7d0ALSGkA=
X-Google-Smtp-Source: ABdhPJwTtPCp8FpXcgbnEpGrzBD/c5OI5FBmvcnkI6RURmACggq+OZbnWqT2dHgZJXdzmC35I3K6bAfTJvc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1f07:b0:4e1:3335:9dd6 with SMTP id
 be7-20020a056a001f0700b004e133359dd6mr4030287pfb.76.1645730360871; Thu, 24
 Feb 2022 11:19:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Feb 2022 19:19:15 +0000
Message-Id: <20220224191917.3508476-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 0/2] KVM: VMX: Revert back to refreshing HOST_CR3 at ->run
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wanpeng Li <kernellwp@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
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

Revert back to refreshing vmcs.HOST_CR3 in vmx_vcpu_run(), the PCID in
CR3 can be bumped in KVM context if KVM triggers code patching of any
kind, e.g. when updating the apic_hw_disabled static key in response to
a WRMSR(APIC_BASE).

Sean Christopherson (2):
  Revert "KVM: VMX: Save HOST_CR3 in vmx_set_host_fs_gs()"
  Revert "KVM: VMX: Save HOST_CR3 in vmx_prepare_switch_to_guest()"

 arch/x86/kvm/vmx/nested.c | 11 ++++++++---
 arch/x86/kvm/vmx/vmx.c    | 28 +++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.h    |  5 ++---
 3 files changed, 27 insertions(+), 17 deletions(-)


base-commit: 8b9c948fd3c1cbd8fed00646e11651cf3d4c86cc
-- 
2.35.1.574.g5d30c73bfb-goog


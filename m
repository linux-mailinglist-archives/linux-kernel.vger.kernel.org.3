Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADB46114D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbhK2Jwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:52:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238670AbhK2Jua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638179232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mwp0gBwc6gvcsvlfC3q+oEEiELWsgNE32DBmNySkG/Y=;
        b=Qiv5CECZ5Ynm75FUllfaPBK3FTAbjvVT3e/ontYYDHHo/lTm4+U0Olgi6n9bpYhRHl69ta
        DY8j9EIgYnRU2kkT/BJdGeVd9QgTz8b6APN1tNjddIdXNyIe8Emq95KwHGY/OQiVZd5ywn
        4EpVT6r3EJyV3OVDIbu9Ll0cWITLvqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-eM9-RiCANdaAlYaBqO-uFw-1; Mon, 29 Nov 2021 04:47:09 -0500
X-MC-Unique: eM9-RiCANdaAlYaBqO-uFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3924183DD20;
        Mon, 29 Nov 2021 09:47:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.195.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 814465D6B1;
        Mon, 29 Nov 2021 09:47:06 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] KVM: nVMX: Enlightened MSR Bitmap feature for Hyper-V on KVM
Date:   Mon, 29 Nov 2021 10:47:00 +0100
Message-Id: <20211129094704.326635-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since "[PATCH v4 0/8] KVM: nVMX: Enlightened MSR Bitmap feature for
Hyper-V on KVM (+ KVM: x86: MSR filtering and related fixes)":
- Drop Sean's "KVM: x86: MSR filtering and related fixes" as they're
 already queued, rebase to the latest kvm/queue.

Original description of the feature:

Updating MSR bitmap for L2 is not cheap and rearly needed. TLFS for Hyper-V
offers 'Enlightened MSR Bitmap' feature which allows L1 hypervisor to
inform L0 when it changes MSR bitmap, this eliminates the need to examine
L1's MSR bitmap for L2 every time when 'real' MSR bitmap for L2 gets
constructed.

When the feature is enabled for Win10+WSL2, it shaves off around 700 CPU
cycles from a nested vmexit cost (tight cpuid loop test).

First patch of the series is unrelated to the newly implemented feature,
it fixes a bug in Enlightened MSR Bitmap usage when KVM runs as a nested
hypervisor on top of Hyper-V.

Vitaly Kuznetsov (4):
  KVM: nVMX: Don't use Enlightened MSR Bitmap for L3
  KVM: VMX: Introduce vmx_msr_bitmap_l01_changed() helper
  KVM: nVMX: Track whether changes in L0 require MSR bitmap for L2 to be
    rebuilt
  KVM: nVMX: Implement Enlightened MSR Bitmap feature

 arch/x86/kvm/hyperv.c     |  2 ++
 arch/x86/kvm/vmx/nested.c | 23 +++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.c    | 41 ++++++++++++++++++++++++++-------------
 arch/x86/kvm/vmx/vmx.h    |  9 +++++++++
 4 files changed, 61 insertions(+), 14 deletions(-)

-- 
2.33.1


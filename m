Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354A846E23E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhLIGJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhLIGJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:09:31 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB934C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:05:58 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q2-20020a056a00084200b004a2582fcec1so2994644pfk.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=qwv+MtWdNXPfGgD9RjFjKocfKOgtRSiMi4c3d+DlY6s=;
        b=KAb5WLPeO2WPBeGDm72DwNt9bn9uz0npWT6Lz2kndBUDP5ioM+Wo3oMPS2FrabijBc
         ALd5ppM3JvDbBrhgkMaIscZWDOukdMhZ0fW3l4yqp2grICT0fVp1n316XPpGYEUqlOgn
         i4tB12FIkI1fACJPWt+4XoQE48a3NGbU+mjWnVMGwuhKY2mohaX6QG7sz5497J/D1LBp
         cv7U8z0HNKpl9yULNRgCKQCVxvK80+3Bo/T53xS4aC+S58+QTzgnqEUaSd9uQ4BAObA5
         RJ41sjcLmPpuBMqIGgUBAccj3cZ55+e3sU5hvMTQUwVNmknprSQE5qAP+n/T8yUJrMkc
         Xi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=qwv+MtWdNXPfGgD9RjFjKocfKOgtRSiMi4c3d+DlY6s=;
        b=GP0sDMrveVo3o1E5XuT8NjYvksVMKeLuUJZKtBIUfX0jotdmH1n1xalV1/apEaO4Nb
         OwaHK3CfJnw0VlI77gzsLnmCl8zGwJ7ebU27EcIpR4z9RL9h9hxusmNPE8tyi02ZKGvS
         8aLvPUHibXf+aPwgOXfs+i3P60zioxpOIzyPZbyM0UUoqrLn0aKMPflJfxg1IicS5ocm
         jymQFpOxffuiwC22Or7rppmBTNT8SZxa8Nd2OT9IGq59QB+3IWRWki1eZWwYEAkSGh9i
         +owGeE1Ae9WJshWhxVj5WIxykdmHKc6N/xufKG9DWo0D7UKv1H2MPfu2RgVdPsXyYblK
         /apw==
X-Gm-Message-State: AOAM533GsDp2OsVIezhwod9jkYtGZ24uINeeSURk8stcsE0fjVLPhh9K
        1UFKnzbPFv5na9MpVWG7THAewKmvAWs=
X-Google-Smtp-Source: ABdhPJx9YUac7XYCh1+9fs9ZzPE/LZaP2GhNXiFEJe6XSs1otNkJDPrim2tRw4TXykCJD6tZVXCK8tPCZIc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:1208:b0:143:e4e9:4ce3 with SMTP id
 l8-20020a170903120800b00143e4e94ce3mr64543483plh.21.1639029958169; Wed, 08
 Dec 2021 22:05:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Dec 2021 06:05:45 +0000
Message-Id: <20211209060552.2956723-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 0/7]  KVM: x86/mmu: Obsolete root shadow page fix
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 01 fixes a complete braino and lack of testing :-(

The rest of the series is an enhancement to address a performance issue
I encountered when implementing the aforementioned fix.  I wanted to WARN
if KVM_REQ_MMU_LOAD was pending with a valid root shadow page, but it
fired like crazy because the roots in prev_roots have an elevated
root_count and thus can trigger KVM_REQ_MMU_LOAD when the guest zaps a
cached root's corresponding PGD (in the guest).

Patches 2+ haven't been super well tested, I'll beat on 'em more and
holler if anything pops up.

Sean Christopherson (7):
  KVM: x86: Retry page fault if MMU reload is pending and root has no sp
  KVM: x86: Invoke kvm_mmu_unload() directly on CR4.PCIDE change
  KVM: Drop kvm_reload_remote_mmus(), open code request in x86 users
  KVM: x86/mmu: Zap only obsolete roots if a root shadow page is zapped
  KVM: s390: Replace KVM_REQ_MMU_RELOAD usage with arch specific request
  KVM: Drop KVM_REQ_MMU_RELOAD and update vcpu-requests.rst
    documentation
  KVM: WARN if is_unsync_root() is called on a root without a shadow
    page

 Documentation/virt/kvm/vcpu-requests.rst |  7 +-
 arch/s390/include/asm/kvm_host.h         |  2 +
 arch/s390/kvm/kvm-s390.c                 |  8 +-
 arch/s390/kvm/kvm-s390.h                 |  2 +-
 arch/x86/include/asm/kvm_host.h          |  2 +
 arch/x86/kvm/mmu.h                       |  1 +
 arch/x86/kvm/mmu/mmu.c                   | 98 +++++++++++++++++++++---
 arch/x86/kvm/x86.c                       | 15 ++--
 include/linux/kvm_host.h                 |  4 +-
 virt/kvm/kvm_main.c                      |  5 --
 10 files changed, 107 insertions(+), 37 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog


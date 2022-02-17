Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A04B984E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiBQFbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:31:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiBQFbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D172A2A4158
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645075860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uFBBw2tgMmvMILcFyIEW04OTQxTvIVNcdkX2nRs0QPQ=;
        b=NLAUAuRUkAX6tmf3yhmU+Eh/+jHCzu8uog9+zNDsAHTWxv4SuWT9GBi6Fqp1lnltTbPh8u
        mnoaV4356yWy1YTEsuID7W+pTOgNzxTmiPP9RB7vuzc5vE1SSfOLubIRpNuZdw+EMfV3LU
        r+G4bTxL4ZnIzo/bb0SW4+6d79NGIAA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-mBQSiORfMcKGEqUw8nV7ew-1; Thu, 17 Feb 2022 00:30:59 -0500
X-MC-Unique: mBQSiORfMcKGEqUw8nV7ew-1
Received: by mail-ot1-f72.google.com with SMTP id e21-20020a9d7315000000b005a6d56ac70bso2504126otk.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFBBw2tgMmvMILcFyIEW04OTQxTvIVNcdkX2nRs0QPQ=;
        b=x/DsENvFHqI56WdpHTtHqCojFlkawqnqzntihqCVQRWl2zJnxAZwmdY1+QiFbhjy5f
         USuX2Rxh1wSClbhsPIQxMOUFfHU3D8ISYCK09bcYJdfXRar6JRwtGdqgc8/3JbDdm9q/
         jWl3X57yViRWc55HLOk5bOSc9sgaKD4fH9bWU9x0r29wFlXqfzE2Fbmq3ubS6RLuJm8t
         2ZP/4+n3M1h9s4rxjzfriae2Y+PXoEVIVLoYzrDehY0tCv9l2Q9P16cCcGKmD+nrGT8u
         NEPVx1ZFSTlr3JUsv1iI/dK9GHhPK7/S62/+CWTYAqK8VsBUyErHFuZNVawR5JSyJXhh
         hWvg==
X-Gm-Message-State: AOAM533gEy387CyF+J+mKa/huIzCmgcDsV9CmuItCdEZmFIrITvFiTej
        tfr7MZQEHPMd4WhQAQAA9nMB8hb1O5XxCjSIw8HkF5xAMryxG3v60xpBQg30pU3/q5ikQx2kgwQ
        ZkXTfhSBF29bmG5rXbWtKRPA8
X-Received: by 2002:a05:6870:1387:b0:d2:d214:ff08 with SMTP id 7-20020a056870138700b000d2d214ff08mr1775421oas.263.1645075858515;
        Wed, 16 Feb 2022 21:30:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+BmcOIFLw6KCSl33oU3m/GTZdl5F2TLOC9bRSjVOBLuT31iY9LrOEKtUXsraZhQnmxpagPg==
X-Received: by 2002:a05:6870:1387:b0:d2:d214:ff08 with SMTP id 7-20020a056870138700b000d2d214ff08mr1775409oas.263.1645075858298;
        Wed, 16 Feb 2022 21:30:58 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7f1:c12c:38a3:24a6:f679:3afd])
        by smtp.gmail.com with ESMTPSA id cm18sm8571688oab.7.2022.02.16.21.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 21:30:57 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Gilbert <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] x86/kvm/fpu: Fix guest migration bugs that can crash guest
Date:   Thu, 17 Feb 2022 02:30:27 -0300
Message-Id: <20220217053028.96432-1-leobras@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset comes from a bug I found during qemu guest migration from a
host with newer CPU to a host with an older version of this CPU, and thus 
having less FPU features.

When the guests were created, the one with less features is used as 
config, so migration is possible.

Patch 1 fix a bug that always happens during this migration, and is
related to the fact that xsave saves all feature flags, but xrstor does
not touch the PKRU flag. It also changes how fpstate->user_xfeatures
is set, going from kvm_check_cpuid() to the later called
kvm_vcpu_after_set_cpuid().

Patch 2 removes kvm_vcpu_arch.guest_supported_xcr0 since it now 
duplicates guest_fpu.fpstate->user_xfeatures. Some wrappers were
introduced in order to make it easier to read the replaced version.

Patches were compile-tested, and could fix the bug found.

Please let me know of anything to improve!

Best regards,
Leo

--
Changes since v3:
- Add new patch to remove the use of kvm_vcpu_arch.guest_supported_xcr0,
  since it is now duplicating guest_fpu.fpstate->user_xfeatures.
- On patch 1, also avoid setting user_xfeatures on kvm_check_cpuid(),
  since it is already set in kvm_vcpu_after_set_cpuid() now.
Changes since v2:
- Fix building error because I forgot to EXPORT_SYMBOL(fpu_user_cfg)
Changes since v1:
- Instead of masking xfeatures, mask user_xfeatures instead. This will
  only change the value sent to user, instead of the one saved in buf.
- Above change removed the need of the patch 2/2
- Instead of masking the current value of user_xfeatures, save on it
  fpu_user_cfg.default_features & vcpu->arch.guest_supported_xcr0 

Leonardo Bras (2):
  x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
  x86/kvm/fpu: Remove kvm_vcpu_arch.guest_supported_xcr0

 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kernel/fpu/xstate.c    |  5 ++++-
 arch/x86/kvm/cpuid.c            |  5 ++++-
 arch/x86/kvm/x86.c              | 20 +++++++++++++++-----
 4 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.35.1


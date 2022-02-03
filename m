Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC82C4A81F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiBCJv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237370AbiBCJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643881914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QK7QeelnBgMuLDC5Mt99kveOzip384EfbthyE/YqvhQ=;
        b=cCi7cc/R323hupEPnQRY/c6n/xKl8eqdslc8iYdSnzX5wHEWNSggnpcDWDeSutJFxMcgwK
        RYaeGm/kWdP27FojTmd29XghPT3I56dYxFCB/O7ztHZ/h2AsB7xEkgdb63x0/rDdMLZXbS
        hVDCFfO/IlS/qsoTy3I8GHUJOaelD4s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-Eq2KUWZAMTSAPSdIke71YQ-1; Thu, 03 Feb 2022 04:51:52 -0500
X-MC-Unique: Eq2KUWZAMTSAPSdIke71YQ-1
Received: by mail-ed1-f69.google.com with SMTP id q10-20020a5085ca000000b0040e3ecf0ec2so1160703edh.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 01:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QK7QeelnBgMuLDC5Mt99kveOzip384EfbthyE/YqvhQ=;
        b=FuUFrw7/sn2vHBn+f4wsUKOOvivsRayU+LIlWcB2XgHcn0t+ZbIMIn2GWPX9lccnX4
         8z2aP6/QnrVFBElCxTLeOGQsaboR81ICpby/v1UWXi9HKc5J3GGWnxvLkkaodhjju0hz
         VK8vPF5R3SRt4BcihMKzPWBp8OuFXu/29hNmHJ1Ziq48LtapXLG90cm+D1kQ9YFxae30
         ycsnHTm8y9qh+CwaEXxmJXqnuyD4smv0zSLsoQFPg7NL2Svi2ALKIAzphgHUFbPnnzdD
         9WgtcTZ1bEVLV8082MeNrbytBB6AtzHWZ7Rr4j4brUT1oXnfcpYDdHk9MfVNe3HCfQlS
         LD6Q==
X-Gm-Message-State: AOAM533iD01qLnx+HeoRIi9TMDD5ItMgSx/miJtu+gCrIz4mPsFeNTLa
        umDef0dzokKD6UVdWrMSWiaDHOUJBuO9d7Cq1Ejlpl+Y2r4l48DjiBr/AiyVENdxzkPEPTbia7O
        Ion/aFGDymxeixA6yawZhrV8TAPCJr8DJIPGmwjzL73bAP4RrkPEUjQtrDbCOxqXyJPWQNYHqvt
        Gc
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr34787600eds.392.1643881911563;
        Thu, 03 Feb 2022 01:51:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/idJWteG3a2i4lVifO74FtI/xr/NVTP5oo/QwQcQFsQSvQVVdEMI4k/TDJkIvwi541lQNJw==
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr34787584eds.392.1643881911408;
        Thu, 03 Feb 2022 01:51:51 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bx18sm18752074edb.93.2022.02.03.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 01:51:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] KVM: SVM: nSVM: Implement Enlightened MSR-Bitmap
 for Hyper-V-on-KVM
In-Reply-To: <429afd81-7bef-8ead-6ca4-12671378d581@redhat.com>
References: <20220202095100.129834-1-vkuznets@redhat.com>
 <429afd81-7bef-8ead-6ca4-12671378d581@redhat.com>
Date:   Thu, 03 Feb 2022 10:51:49 +0100
Message-ID: <87czk4b7m2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/2/22 10:50, Vitaly Kuznetsov wrote:
...
>>    KVM: nSVM: Implement Enlightened MSR-Bitmap feature
...
>
> Queued, thanks.

While writing a selftest for the feature, I've discovered an embarassing
bug: in nested_svm_vmrun_msrpm() I check bit number instead of bit
mask. It worked in testing by pure luck, it seems genuine Hyper-V sets
some other clean fields simultaneously.

Would it be possible to squash the attached patch in? Thanks!

I'll be sending out selftests shortly.

-- 
Vitaly


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-KVM-nSVM-Fix-the-check-for-VMCB_HV_NESTED_ENLIGHTENM.patch

From cfb538876ccc59dade7cadde553863bea8312f90 Mon Sep 17 00:00:00 2001
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Thu, 3 Feb 2022 10:22:30 +0100
Subject: [PATCH] KVM: nSVM: Fix the check for VMCB_HV_NESTED_ENLIGHTENMENTS
 bin in nested_svm_vmrun_msrpm()

VMCB_HV_NESTED_ENLIGHTENMENTS (VMCB_SW) is a bit number, not a bit mask.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7b26a4b518f7..7acf4f2aa445 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -188,7 +188,7 @@ static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
 	if (!svm->nested.force_msr_bitmap_recalc &&
 	    kvm_hv_hypercall_enabled(&svm->vcpu) &&
 	    hve->hv_enlightenments_control.msr_bitmap &&
-	    (svm->nested.ctl.clean & VMCB_HV_NESTED_ENLIGHTENMENTS))
+	    (svm->nested.ctl.clean & BIT(VMCB_HV_NESTED_ENLIGHTENMENTS)))
 		goto set_msrpm_base_pa;
 
 	if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT)))
-- 
2.34.1


--=-=-=--


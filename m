Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD554E69BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353264AbiCXUSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbiCXUSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:18:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB326E9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:17:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t13so3485153pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vvhzKYHeLjR6iFrBrY2eRdssp7T8VuQTF1cgPnun9tU=;
        b=Dkz6aoAiH79t0F9ceUKw95qE6p3TvMeElZz+mooOeci4+rp7qruJz16sjJqMG2g/Ed
         Bv3BWjBCBNL+LMyupB/9KXb/iCjyoTMObeGksAFrZQ5xJR+2LnU/JP3WlGXp5PVrw+Mm
         bhcMId5OR2grnZfGjv83VPjReAKid5CG6oyWzFlX00Dg+A/nG7k9wg6meW2M8VLNef/G
         KbDOMt8cxkxD7Fo/SzLNwv5C4coJOqQIWFc33cn6XLQtk9/dSymnv5c2B4IUlQTIxn6n
         MHWwdfXixOw7vmJG34Vk58RiRtOSijO3NXZ5dnB9KJThzAIpPpN7nMUbuZ75bjPMi8Ch
         mbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vvhzKYHeLjR6iFrBrY2eRdssp7T8VuQTF1cgPnun9tU=;
        b=jPAfKarhc+UJvaGQdX8qPbbulSVkKedHrA24AH2QulHLJj0lvKmQzOhcWP+XIKPFGU
         qt/DFaNZjhmYZ4+Xmq+vx7p1O1rihQy63O4dF70VDa7HabDlqZGmsA0hzMWrQth/zGBs
         7sKrVGh9TaWIR4LQXkZpvqUwk/TJrHFT4o9dPKpF1sqsylNVgo+UCnSzRlSP7Z5n0Mev
         NCPVlHtLExo/oiqu3cHs5s3vK9b8tJXd3v0zYUUgqaV2mIObIlk+GiiU4VLD1L1RcqBl
         hrfvTsqoGu/zSScqCDzOjbkDqV1afbfD0IWSCAnv72qRZ7Q4JZhOQDag9h7GvFHXrZd/
         hC+A==
X-Gm-Message-State: AOAM533Oy0MMEaBNH/KrwlGLCfN7sgOeBgd/alstWAEQ3VROb/vI8NUz
        SJG0BwujUHXpsYyG2+y0v3jIFg==
X-Google-Smtp-Source: ABdhPJw7wXA+2HCR3ZtcnCvgiJUSC2XIWuKPagWMMEn3DFHaZrXzfED7gFPCpBoaIvt5yNr/c7J0TQ==
X-Received: by 2002:a05:6a00:1687:b0:4e1:45d:3ded with SMTP id k7-20020a056a00168700b004e1045d3dedmr6565477pfc.0.1648153028986;
        Thu, 24 Mar 2022 13:17:08 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 3-20020a630003000000b003828fc1455esm3283860pga.60.2022.03.24.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:17:08 -0700 (PDT)
Date:   Thu, 24 Mar 2022 20:17:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Don't rebuild page when the page is synced
 and no tlb flushing is required
Message-ID: <YjzRwDSPQNbpTrZ9@google.com>
References: <0dabeeb789f57b0d793f85d073893063e692032d.1647336064.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dabeeb789f57b0d793f85d073893063e692032d.1647336064.git.houwenlong.hwl@antgroup.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022, Hou Wenlong wrote:
> Before Commit c3e5e415bc1e6 ("KVM: X86: Change kvm_sync_page()
> to return true when remote flush is needed"), the return value
> of kvm_sync_page() indicates whether the page is synced, and
> kvm_mmu_get_page() would rebuild page when the sync fails.
> But now, kvm_sync_page() returns false when the page is
> synced and no tlb flushing is required, which leads to
> rebuild page in kvm_mmu_get_page(). So return the return
> value of mmu->sync_page() directly and check it in
> kvm_mmu_get_page(). If the sync fails, the page will be
> zapped and the invalid_list is not empty, so set flush as
> true is accepted in mmu_sync_children().
> 
> Fixes: c3e5e415bc1e6 ("KVM: X86: Change kvm_sync_page() to return true when remote flush is needed")
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3b8da8b0745e..8efd165ee27c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1866,17 +1866,14 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
>  	  &(_kvm)->arch.mmu_page_hash[kvm_page_table_hashfn(_gfn)])	\
>  		if ((_sp)->gfn != (_gfn) || (_sp)->role.direct) {} else
>  
> -static bool kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
> +static int kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>  			 struct list_head *invalid_list)
>  {
>  	int ret = vcpu->arch.mmu->sync_page(vcpu, sp);
>  
> -	if (ret < 0) {
> +	if (ret < 0)
>  		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
> -		return false;
> -	}
> -
> -	return !!ret;
> +	return ret;

Hrm, this creates an oddity in mmu_sync_children(), which does a logical-OR of
the result into a boolean.  It doesn't actually change the functionality since
kvm_mmu_remote_flush_or_zap() will prioritize invalid_list, but it's weird.

What about checking invalid_list directly and keeping the boolean return?  Compile
tested only.

From: Sean Christopherson <seanjc@google.com>
Date: Thu, 24 Mar 2022 13:07:32 -0700
Subject: [PATCH] KVM: x86/mmu: Fix shadow reuse when unsync sp doesn't need
 TLB flush

Use invalid_list to detect if synchronizing an unsync shadow page failed
and resulted in the page being zapped.  Since commit c3e5e415bc1e ("KVM:
X86: Change kvm_sync_page() to return true when remote flush is needed"),
kvm_sync_page() returns whether or not a TLB flush is required, it doesn't
provide any indication as to whether or not the sync was successful.  If
the sync is successful but doesn't require a TLB flush, checking the
TLB flush result will cause KVM to unnecessarily rebuild the shadow page.

Fixes: c3e5e415bc1e6 ("KVM: X86: Change kvm_sync_page() to return true when remote flush is needed")
Cc: stable@vger.kernel.org
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1361eb4599b4..b6350fec1b11 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2086,16 +2086,19 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 			 * This way the validity of the mapping is ensured, but the
 			 * overhead of write protection is not incurred until the
 			 * guest invalidates the TLB mapping.  This allows multiple
-			 * SPs for a single gfn to be unsync.
-			 *
+			 * SPs for a single gfn to be unsync.  kvm_sync_page()
+			 * returns true if a TLB flush is needed to ensure the
+			 * guest sees the synchronized shadow page.
+			 */
+			if (kvm_sync_page(vcpu, sp, &invalid_list))
+				kvm_flush_remote_tlbs(vcpu->kvm);
+
+			/*
 			 * If the sync fails, the page is zapped.  If so, break
 			 * in order to rebuild it.
 			 */
-			if (!kvm_sync_page(vcpu, sp, &invalid_list))
+			if (!list_empty(&invalid_list))
 				break;
-
-			WARN_ON(!list_empty(&invalid_list));
-			kvm_flush_remote_tlbs(vcpu->kvm);
 		}

 		__clear_sp_write_flooding_count(sp);

base-commit: 9b6a3be37eacee49a659232e86019e733597c045
--



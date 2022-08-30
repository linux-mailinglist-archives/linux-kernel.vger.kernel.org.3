Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA95A6A74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiH3R3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiH3R3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:29:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B26E15C7A1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:26:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa2so4092144pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zAKSO26c9m8B+oXZ5FSXMQLoDUzeWAGDmdsownEQVv0=;
        b=lIlqhwrzGQDmf0O81swu6nyaW8iX2n3RRGvkOJIWt0iw1hpt0Oo/ClGjgbeE5moYix
         ShYSdqrqjdZJmcr8XsHCnEorT8McR7+lBiiOSKuVJ06S3Mc++LMYpAYVeNdjklldSu25
         uqPROlC9zzPY9qXFsSGZcigz2j/4zbTTzs+FBQN8hb3xYlXHCCiwSsDpmddb7fWUywtf
         cIzWIkRuH71Z3nMYwgS8qCsPei/2Basu36iuvpJO97ZgmnekEwi5Cwh0c8bELRQZ8dHH
         iKbjIjF4TE5Irgu8Tb7kTOHxFmJuV269Hhq3p6kIU+vFtFW7/t69LKDUdXu698hHt1Ap
         2Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zAKSO26c9m8B+oXZ5FSXMQLoDUzeWAGDmdsownEQVv0=;
        b=OLfH2/+SMvtVfO/sOzpLnr6K1osRxxTtXiSoMfd160tj6cT5sHvctCOhyBYj8VN38X
         NDcRw9CQO3o6pQgkTcat/AugIr7rmaSx5UO5k1EtUqDVUcqnjbLCQkuWzRVRj13d6Mmz
         g2tyJKP+1XjUDXZ2BxEVtHrYysG6RRhKhkEigwVjCxkcV7Vo4hmrZ8nJzgXzwIXStxBf
         AzGFZjajmtNVy4m7+nziACvaN9uo4Hw+XYdzMtNEoUgHK6VkS1L8wVZmllibu2FT7veA
         BDuwl/q615byTvk5rruow9sm0LbC5s/fHjsaAWdicxFmZ8XkfP7iBdoVH6Rq2aj/lr+j
         y/YQ==
X-Gm-Message-State: ACgBeo3EkStv83EbEmzh22aq4gzRcW79vxjbAPItLZvutb2/ftJTodHT
        B4JF397Qt6NYtDQ8LGwRRpfh5w==
X-Google-Smtp-Source: AA6agR5/CrwJJ1oc1zoSSIGRTxCXmnO0RTdlJEzjr25ib60dcSg/E4dy8E5Dpei3WfFN3UvG/pl56w==
X-Received: by 2002:a17:902:e741:b0:175:2ffe:9280 with SMTP id p1-20020a170902e74100b001752ffe9280mr2341124plf.153.1661880297742;
        Tue, 30 Aug 2022 10:24:57 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n27-20020a056a00213b00b0052d327f67b9sm9549713pfj.152.2022.08.30.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:24:57 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:24:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Fix comment typo
Message-ID: <Yw5H5ZYlPLixSlcn@google.com>
References: <20220715044659.20282-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715044659.20282-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022, Jason Wang wrote:
> The double `we' is duplicated in line 2569, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index fbeda5aa72e1..cd99e49d7ff1 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2566,7 +2566,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	 * bits which we consider mandatory enabled.
>  	 * The CR0_READ_SHADOW is what L2 should have expected to read given
>  	 * the specifications by L1; It's not enough to take
> -	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we we
> +	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we
>  	 * have more bits than L1 expected.
>  	 */

I'd prefer to rewrite this entire comment.  The key part is that KVM needs to
override the shadows that are set by vmx_set_cr0/4(), and then in the comment
above the helpers call out that the value+mask in vmcs02 may not match vmcs12.

---
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Aug 2022 10:11:41 -0700
Subject: [PATCH] KVM: nVMX: Reword comments about generating nested CR0/4 read
 shadows

Reword the comments that (attempt to) document when nVMX overrides that
CR0/4 read shadows for L2 after calling vmx_set_cr0/4().  The important
behavior that needs to be documented is that KVM needs to override the
shadows to account for L1's masks, even though the shadow are set by the
common helpers.

This also fixes a repeated "we we" reported by Jason.

Cc: Jason Wang <wangborong@cdjrlc.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 9 +++------
 arch/x86/kvm/vmx/nested.h | 7 ++++---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ddd4367d4826..12f57a99f725 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2566,12 +2566,9 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		nested_ept_init_mmu_context(vcpu);

 	/*
-	 * This sets GUEST_CR0 to vmcs12->guest_cr0, possibly modifying those
-	 * bits which we consider mandatory enabled.
-	 * The CR0_READ_SHADOW is what L2 should have expected to read given
-	 * the specifications by L1; It's not enough to take
-	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we we
-	 * have more bits than L1 expected.
+	 * Override the CR0/CR4 read shadows after setting the effective guest
+	 * CR0/CR4.  The common helpers also set the shadows, but they don't
+	 * account for vmcs12's cr0/4_guest_host_mask.
 	 */
 	vmx_set_cr0(vcpu, vmcs12->guest_cr0);
 	vmcs_writel(CR0_READ_SHADOW, nested_read_cr0(vmcs12));
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 88b00a7359e4..8b700ab4baea 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -79,9 +79,10 @@ static inline bool nested_ept_ad_enabled(struct kvm_vcpu *vcpu)
 }

 /*
- * Return the cr0 value that a nested guest would read. This is a combination
- * of the real cr0 used to run the guest (guest_cr0), and the bits shadowed by
- * its hypervisor (cr0_read_shadow).
+ * Return the cr0/4 value that a nested guest would read. This is a combination
+ * of L1's "real" cr0 used to run the guest (guest_cr0), and the bits shadowed
+ * by the L1 hypervisor (cr0_read_shadow).  KVM must emulate CPU behavior as
+ * the value+mask loaded into vmcs02 may not match the vmcs12 fields.
  */
 static inline unsigned long nested_read_cr0(struct vmcs12 *fields)
 {

base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
--


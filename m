Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94555C30F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiF0Ojs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiF0Ojp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:39:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC0646F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:39:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z14so9348915pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODo85vksqxfNlwx8IGhUrPmazqQ90GEXdELj2np2ST8=;
        b=YA8WfGqU7USs/E2HJ5c9hXsNZXatb0VsXxWOrOJXkeU9rQw0mWZUL3Baqf5V6VnqhG
         kVAu+9/+pka4ilRbefJG58CPgG6VGIqnTOCP4IuVM7Ty886YdhOsEgx/6RIVhRiJFJgm
         BckfEV0n6dP0NB9DegAbNd1jev8JkR7d9quJO5zmo1gy+Sfi8rx1FM3TyifehF/9HTTC
         2fRAracHAXX8SCi7+GVCXSv2czc//42oJmDvx8NXk74VBLBX7D5DaoSABKZ4NnpcbzEk
         ZnDWYsUZgCU9lqV9cR1WAoa5apIyJdfK6P8VPD1mpVbgtoWWeS+WPjC3SiSmjuN29Btd
         tV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODo85vksqxfNlwx8IGhUrPmazqQ90GEXdELj2np2ST8=;
        b=HPUuLQ/orAu9+gNMUt15OL7ZICjZ4Ea0VV0yWrNrk5CXRwn7qBsj39F4t9eW4NX/If
         h+HILRrl0qPHuxC/wl8ShAFRmLmidm+sG+LFa/TITKWtmOq0M2bgWl46U6HXjAw5Jawy
         EOC2gwAmrD92z48+xE9g0Kt6/vLYGtsd2TnCdAg/eHnMcbTdT16IcMrTHY2R+DfLRs/k
         wkGzhVcmz/e6kLcg+SZnvPhr25shqUVvcQ/IbQr2pDYjm5s3fKhPDaJws7JoTQjUgBYe
         PnYGWyr+8i/E8pH35dB2KiYj4e0x5SeqplUaiBmw/RxGs5Wnx7Hd27x+ArWsdM/sl6Iv
         UvPg==
X-Gm-Message-State: AJIora9ylL5QZFa+djbNgmjgRR0a5ctpcmbmcOJOFr4DDaIIJFaqcIwA
        uww/mUWYyxvkd+QeWnu3m7CNqg==
X-Google-Smtp-Source: AGRyM1sYjHgK7wq2bO2XW8AvY7XmBYu8FpCwaa0o1KlAeYvExwUH9S47Az2Ehx1MhCD4ijqDrOfI2g==
X-Received: by 2002:aa7:91cd:0:b0:525:63e5:9690 with SMTP id z13-20020aa791cd000000b0052563e59690mr15117123pfa.1.1656340784122;
        Mon, 27 Jun 2022 07:39:44 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b0016a68098e8fsm1705499pln.242.2022.06.27.07.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:39:43 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:39:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH] kvm: nVMX: add tracepoint for kvm:kvm_nested_vmrun
Message-ID: <YrnBLLRljyHCyeOe@google.com>
References: <20220626200538.3210528-1-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626200538.3210528-1-mizhang@google.com>
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

On Sun, Jun 26, 2022, Mingwei Zhang wrote:
> From: David Matlack <dmatlack@google.com>
> 
> This tracepoint is called by nested SVM during emulated VMRUN. Call
> also during emulated VMLAUNCH and VMRESUME in nested VMX.
> 
> Attempt to use analagous VMCS fields to the VMCB fields that are
> reported in the SVM case:
> 
> "int_ctl": 32-bit field of the VMCB that the CPU uses to deliver virtual
> interrupts. The analagous VMCS field is the 16-bit "guest interrupt
> status".
> 
> "event_inj": 32-bit field of VMCB that is used to inject events
> (exceptions and interrupts) into the guest. The analagous VMCS field
> is the "VM-entry interruption-information field".
> 
> "npt": 1 when the VCPU has enabled nested paging. The analagous VMCS
> field is the enable-EPT execution control.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> [Move the code into the nested_vmx_enter_non_root_mode().]
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index f5cb18e00e78..29cc36cf2568 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3367,6 +3367,13 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  	};
>  	u32 failed_index;
>  
> +	trace_kvm_nested_vmrun(
> +		kvm_rip_read(vcpu), vmx->nested.current_vmptr,
> +		vmcs12->guest_rip,

Be consistent; either put each parameter on it's own line or wrap only when
necessary.

> +		vmcs12->guest_intr_status,
> +		vmcs12->vm_entry_intr_info_field,
> +		vmcs12->secondary_vm_exec_control & SECONDARY_EXEC_ENABLE_EPT);
> +

Align the parameters to the opening '(', that "rule" trumps the 80 char soft limit.

	trace_kvm_nested_vmrun(kvm_rip_read(vcpu),
			       vmx->nested.current_vmptr,
			       vmcs12->guest_rip,
			       vmcs12->guest_intr_status,
			       vmcs12->vm_entry_intr_info_field,
			       vmcs12->secondary_vm_exec_control & SECONDARY_EXEC_ENABLE_EPT);

And if we're going to add nVMX, we should clean up the tracepoint output.  E.g.
pass in KVM_ISA_{SVM,VMX} to different VMCB vs. VMCS and npt vs. ept (and maybe
print nNPT and nEPT to make it obvious it's the vmcs12 setting?).  The "nrip"
field is wrong even for SVM; the tracepoint prints the L2 rip, not the next_rip
field in vmcs12.  Maybe "L2 rip"?

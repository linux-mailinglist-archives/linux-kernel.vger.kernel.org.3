Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DD48DF97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiAMV3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiAMV3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:29:15 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BFC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:29:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z3so11491896plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v66kQJPQ7cVIvaUPj32GpP29/XbkcAvgruVgXIm7Hck=;
        b=dmT1uQrp7+MVBjrnFisZDuP9hfD/dPkKX+Wj8ki+Wm5H/AqrM6/C7DY0ZGI7k7a78J
         lfBmQe9gqgqiSHYLjUNK2CMKJ+R+PFqUjSGVdbRChRTESTGGRmPJTukQFVQ8zQyV0/X+
         gUGeI2fJe1I9oERuruuXLN6AXBTRCkVQq+VTXAjt03lFpS15qEIeg+MqHjnzYSua9tqf
         AZn8ag2VVa1/g0C2yjc+dg5Sz+XMxhMINgeGVH8YDkw5QZc0W5R46hthT4EsHJ/oG39W
         B9c4Hqp8nmukDxkzoRy0nlH5vErubnIBD0pS0lHFf0eNZToQeyiogUM+zCSu02G02Y7F
         UkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v66kQJPQ7cVIvaUPj32GpP29/XbkcAvgruVgXIm7Hck=;
        b=5HT9uBR7ARvKB4u/kEVL7nuKkfwc6d1lp0L8GhssCtQgkJBC8VZzmKY14gL5IUybQl
         f+6XQmY/5mBggLYdTHpouHD4htBZ9NFqFcx1OZaEIB3wnpSZBtxQ2ot8bnDX5mzOE5Lb
         9XtHxZmDEEbfOxXXoAGH4kWf2eB/1P7aQn7sGmgXyNACEsuYsNQtcLCxZuVKMyGOau43
         f9W/sAFExEOSH8VNYkWjyjGKwJo5d6gbNZFjlcNTUuFdhhDTcLRMjqoNNS+H1XHHxA1z
         betp2FDuu5IsWvmaciSbm/HJxxmkFNLuuTynYZrxbrjGMckvHqTiwqVMaV0l8tUxee1H
         /u/A==
X-Gm-Message-State: AOAM5311n30UJLeCcUwzqJ3iiCGPkNXOgaWSJ7QN2wvQ+RqhpN3u3BMX
        xYL6fuorJrjU1WZwjDYUBPMtuw==
X-Google-Smtp-Source: ABdhPJy6OboZEza1UKblpwHYxX0CmsSLLxRzvzXs8rjBa0gryLiZRloWdOvGfOtaZ6fL8gfN7c8n/A==
X-Received: by 2002:a17:902:6a89:b0:149:732e:d335 with SMTP id n9-20020a1709026a8900b00149732ed335mr6690282plk.136.1642109354299;
        Thu, 13 Jan 2022 13:29:14 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t21sm9288425pjq.9.2022.01.13.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 13:29:13 -0800 (PST)
Date:   Thu, 13 Jan 2022 21:29:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Gao Chao <chao.gao@intel.com>
Subject: Re: [PATCH v5 5/8] KVM: x86: Support interrupt dispatch in x2APIC
 mode with APIC-write VM exit
Message-ID: <YeCZpo+qCkvx5l5m@google.com>
References: <20211231142849.611-1-guang.zeng@intel.com>
 <20211231142849.611-6-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231142849.611-6-guang.zeng@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021, Zeng Guang wrote:
> In VMX non-root operation, new behavior applies to

"new behavior" is ambiguous, it's not clear if it refers to new hardware behavior,
new KVM behavior, etc...

> virtualize WRMSR to vICR in x2APIC mode. Depending

Please wrap at ~75 chars, this is too narrow.

> on settings of the VM-execution controls, CPU would
> produce APIC-write VM-exit following the 64-bit value
> written to offset 300H on the virtual-APIC page(vICR).
> KVM needs to retrieve the value written by CPU and
> emulate the vICR write to deliver an interrupt.
> 
> Current KVM doesn't consider to handle the 64-bit setting
> on vICR in trap-like APIC-write VM-exit. Because using
> kvm_lapic_reg_write() to emulate writes to APIC_ICR requires
> the APIC_ICR2 is already programmed correctly. But in the
> above APIC-write VM-exit, CPU writes the whole 64 bits to
> APIC_ICR rather than program higher 32 bits and lower 32
> bits to APIC_ICR2 and APIC_ICR respectively. So, KVM needs
> to retrieve the whole 64-bit value and program higher 32 bits
> to APIC_ICR2 first.

I think this is simply saying:

  Upcoming Intel CPUs will support virtual x2APIC MSR writes to the vICR,
  i.e. will trap and generate an APIC-write VM-Exit instead of intercepting
  the WRMSR.  Add support for handling "nodecode" x2APIC writes, which were
  previously impossible.

  Note, x2APIC MSR writes are 64 bits wide.

and then the shortlog can be:

  KVM: x86: Add support for vICR APIC-write VM-Exits in x2APIC mode

The "interrupt dispatch" part is quite confusing because it's not really germane
to the change; yes, the vICR write does (eventually) dispatch an IRQ, but that
has nothing to do with the code being modified.

> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> ---
>  arch/x86/kvm/lapic.c | 12 +++++++++---
>  arch/x86/kvm/lapic.h |  5 +++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index f206fc35deff..3ce7142ba00e 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2186,15 +2186,21 @@ EXPORT_SYMBOL_GPL(kvm_lapic_set_eoi);
>  /* emulate APIC access in a trap manner */
>  void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
>  {
> -	u32 val = 0;
> +	struct kvm_lapic *apic = vcpu->arch.apic;
> +	u64 val = 0;
>  
>  	/* hw has done the conditional check and inst decode */
>  	offset &= 0xff0;
>  
> -	kvm_lapic_reg_read(vcpu->arch.apic, offset, 4, &val);
> +	/* exception dealing with 64bit data on vICR in x2apic mode */
> +	if ((offset == APIC_ICR) && apic_x2apic_mode(apic)) {

Sorry, I failed to reply to your response in the previous version.  I suggested
a WARN_ON(offset != APIC_ICR), but you were concerned that apic_x2apic_mode()
would be expensive to check before @offset.  I don't think that's a valid concern
as apic_x2apic_mode() is simply:

	apic->vcpu->arch.apic_base & X2APIC_ENABLE

And is likely well-predicted by the CPU, especially in single tenant or pinned
scenarios where the pCPU is running a single VM/vCPU, i.e. will amost never see
X2APIC_ENABLE toggling.

So I stand behind my previous feedback[*] that we should split on x2APIC.

> +		val = kvm_lapic_get_reg64(apic, offset);
> +		kvm_lapic_reg_write(apic, APIC_ICR2, (u32)(val>>32));
> +	} else
> +		kvm_lapic_reg_read(apic, offset, 4, &val);

Needs curly braces.  But again, I stand behind my previous feedback that this
would be better written as:

        if (apic_x2apic_mode(apic)) {
                if (WARN_ON_ONCE(offset != APIC_ICR))
                        return 1;

                kvm_lapic_reg_read(apic, offset, 8, &val);
                kvm_lapic_reg_write64(apic, offset, val);
        } else {
                kvm_lapic_reg_read(apic, offset, 4, &val);
                kvm_lapic_reg_write(apic, offset, val);
        }

after a patch (provided in earlier feedback) to introduce kvm_lapic_reg_write64().

[*] https://lore.kernel.org/all/YTvcJZSd1KQvNmaz@google.com

>  	/* TODO: optimize to just emulate side effect w/o one more write */
> -	kvm_lapic_reg_write(vcpu->arch.apic, offset, val);
> +	kvm_lapic_reg_write(apic, offset, (u32)val);
>  }
>  EXPORT_SYMBOL_GPL(kvm_apic_write_nodecode);
>  

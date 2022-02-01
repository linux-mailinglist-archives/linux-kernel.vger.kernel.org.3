Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76934A6884
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiBAX1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiBAX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:27:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDB3C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:27:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643758068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igJcNET0lMnurWDqVKRFrGd2pHtcwOoqY95DNGOCDE0=;
        b=jy58iVcPuwhCt3ZJTN/ruHUoRuodHjunS7MycOVJhIxnBNFjRo+0b1iwMH8Co/9EOS/Y8R
        MsHe8yinl+Q0+KfcuX3cRnRn02YrKlM6mlGx/5zx6o3mRXBZk7MMUVAbsHaPPLJcKW7IG2
        kZ58cdnIwBy8VjM/BRMwpZ1gEFLiy4vJ+LvwJqq2CJc+eAudFBEJkn1pTV+A5/qBBLdQfN
        69bROde5ncZfzmFGhIDnSIA8Ls8mkAD/XAnIP8hln/YVdiYAc1VfCRLYHRv1orEmFiwYH6
        hYC44hk0Eu0o/Z1+PmBDB9JXg1Uk0+FtiRDFyrBzgG+La0LyaaQUkRoUgjnnPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643758068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igJcNET0lMnurWDqVKRFrGd2pHtcwOoqY95DNGOCDE0=;
        b=/wQR6xtsQ8WQkZ8Qt3JVkW1Q/YwbQJkxcRySqjAiU23h9W2l39os1utdZp34nGVXOMpNuZ
        BtAvKv3NB+tWcbCA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 17/29] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
In-Reply-To: <20220124150215.36893-18-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-18-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 00:27:47 +0100
Message-ID: <87v8xyw4jw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> +#ifdef CONFIG_X86_64
> +/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> +static u64 acpi_mp_wake_mailbox_paddr;
> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +/* Lock to protect mailbox (acpi_mp_wake_mailbox) from parallel access */
> +static DEFINE_SPINLOCK(mailbox_lock);
> +#endif
> +
>  #ifdef CONFIG_X86_IO_APIC
>  /*
>   * Locks related to IOAPIC hotplug
> @@ -336,6 +345,80 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
>  	return 0;
>  }
>  
> +#ifdef CONFIG_X86_64
> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +	static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
> +	unsigned long flags;
> +	u8 timeout;
> +
> +	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
> +	if (physids_empty(apic_id_wakemap)) {
> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +						sizeof(*acpi_mp_wake_mailbox),
> +						MEMREMAP_WB);
> +	}
> +
> +	/*
> +	 * According to the ACPI specification r6.4, section titled
> +	 * "Multiprocessor Wakeup Structure" the mailbox-based wakeup
> +	 * mechanism cannot be used more than once for the same CPU.
> +	 * Skip wakeups if they are attempted more than once.
> +	 */
> +	if (physid_isset(apicid, apic_id_wakemap)) {
> +		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
> +		       apicid);
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&mailbox_lock, flags);

What's the reason that interrupts need to be disabled here? The comment
above this invocation is not really informative ...

> +	/*
> +	 * Mailbox memory is shared between firmware and OS. Firmware will
> +	 * listen on mailbox command address, and once it receives the wakeup
> +	 * command, CPU associated with the given apicid will be booted.
> +	 *
> +	 * The value of apic_id and wakeup_vector has to be set before updating
> +	 * the wakeup command. To let compiler preserve order of writes, use
> +	 * smp_store_release.

What? If the only purpose is to tell the compiler to preserve code
ordering then why are you using smp_store_release() here?
smp_store_release() is way more than that...

> +	 */
> +	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
> +	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> +	smp_store_release(&acpi_mp_wake_mailbox->command,
> +			  ACPI_MP_WAKE_COMMAND_WAKEUP);
> +
> +	/*
> +	 * After writing the wakeup command, wait for maximum timeout of 0xFF
> +	 * for firmware to reset the command address back zero to indicate
> +	 * the successful reception of command.
> +	 * NOTE: 0xFF as timeout value is decided based on our experiments.
> +	 *
> +	 * XXX: Change the timeout once ACPI specification comes up with
> +	 *      standard maximum timeout value.
> +	 */
> +	timeout = 0xFF;
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> +		cpu_relax();
> +
> +	/* If timed out (timeout == 0), return error */
> +	if (!timeout) {

So this leaves a stale acpi_mp_wake_mailbox->command. What checks that
acpi_mp_wake_mailbox->command is 0 on the next invocation?

Aside of that assume timeout happens and the firmware acts after this
returned. Then you have inconsistent state as well. Error handling is
not trivial, but making it hope based is the worst kind.

> +		spin_unlock_irqrestore(&mailbox_lock, flags);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * If the CPU wakeup process is successful, store the
> +	 * status in apic_id_wakemap to prevent re-wakeup
> +	 * requests.
> +	 */
> +	physid_set(apicid, apic_id_wakemap);
> +
> +	spin_unlock_irqrestore(&mailbox_lock, flags);
> +
> +	return 0;
> +}
> +#endif
>  #endif				/*CONFIG_X86_LOCAL_APIC */

Thanks,

        tglx

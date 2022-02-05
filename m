Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB844AA8C9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377385AbiBEMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:37:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:19893 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbiBEMh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644064678; x=1675600678;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=8iaV4TWvTl9pltdsUEK1DEZ07Ywbfv1t+2DkUAFsY84=;
  b=Cx8icPK7LSgtJW9tNuzBEyzj4VqDZ+juaXd1fr3WT7A/eZ2AzQVPVECx
   nRzY28iqxMVoO0Hd+MgPEAeqPso+h0dZ1C71sLTNUUey3JfODulfT9Dwy
   WPe+ccIzdjSK0yUClBZvD64w0culeBi9pb2+QUeyl3FWKKSa61cUjDOnG
   lmoecM/gMAi0qBmPG6f3R62CYq99uWI6E7PK979G+XBybHn0sJflRh73r
   6YTW2a9R2sQ1T/5jiJ5cPgvbQB5P+UIEch40XINxrU5P3QWJ/98BgvMrD
   9s7SIDEXEA0dhAdsVBQ89qE5hzV08aaPgtAgH4XZq3JpWyenl6TxCTnY5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="273019228"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="273019228"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 04:37:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="481105072"
Received: from skuppusw-mobl.amr.corp.intel.com (HELO [10.252.79.131]) ([10.252.79.131])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 04:37:47 -0800
Message-ID: <be29984f-7bc5-a308-9c8b-b2dbe59180e4@linux.intel.com>
Date:   Sat, 5 Feb 2022 04:37:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCHv2 17/29] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-18-kirill.shutemov@linux.intel.com>
 <87v8xyw4jw.ffs@tglx>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
In-Reply-To: <87v8xyw4jw.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2022 3:27 PM, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
>> +#ifdef CONFIG_X86_64
>> +/* Physical address of the Multiprocessor Wakeup Structure mailbox */
>> +static u64 acpi_mp_wake_mailbox_paddr;
>> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
>> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
>> +/* Lock to protect mailbox (acpi_mp_wake_mailbox) from parallel access */
>> +static DEFINE_SPINLOCK(mailbox_lock);
>> +#endif
>> +
>>   #ifdef CONFIG_X86_IO_APIC
>>   /*
>>    * Locks related to IOAPIC hotplug
>> @@ -336,6 +345,80 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_X86_64
>> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
>> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>> +{
>> +	static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
>> +	unsigned long flags;
>> +	u8 timeout;
>> +
>> +	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
>> +	if (physids_empty(apic_id_wakemap)) {
>> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
>> +						sizeof(*acpi_mp_wake_mailbox),
>> +						MEMREMAP_WB);
>> +	}
>> +
>> +	/*
>> +	 * According to the ACPI specification r6.4, section titled
>> +	 * "Multiprocessor Wakeup Structure" the mailbox-based wakeup
>> +	 * mechanism cannot be used more than once for the same CPU.
>> +	 * Skip wakeups if they are attempted more than once.
>> +	 */
>> +	if (physid_isset(apicid, apic_id_wakemap)) {
>> +		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
>> +		       apicid);
>> +		return -EINVAL;
>> +	}
>> +
>> +	spin_lock_irqsave(&mailbox_lock, flags);
> What's the reason that interrupts need to be disabled here? The comment
> above this invocation is not really informative ...

I initially thought this routine is getting called from interrupt 
context. But after
re-investigation, this seems not true. So we don't need to disable IRQ here.
Regular spin_lock/unlock variant is suffice. Sorry for the mistake.

>
>> +	/*
>> +	 * Mailbox memory is shared between firmware and OS. Firmware will
>> +	 * listen on mailbox command address, and once it receives the wakeup
>> +	 * command, CPU associated with the given apicid will be booted.
>> +	 *
>> +	 * The value of apic_id and wakeup_vector has to be set before updating
>> +	 * the wakeup command. To let compiler preserve order of writes, use
>> +	 * smp_store_release.
> What? If the only purpose is to tell the compiler to preserve code
> ordering then why are you using smp_store_release() here?
> smp_store_release() is way more than that...

Order of execution is not the only reason. Since this memory is shared with
firmware, I thought it is better to keep it volatile.  So used 
smp_store_release()
variant.  I have initially used only WRITE_ONCE(), but suggestion to use
smp_store_release came out of community review.

>
>> +	 */
>> +	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
>> +	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
>> +	smp_store_release(&acpi_mp_wake_mailbox->command,
>> +			  ACPI_MP_WAKE_COMMAND_WAKEUP);
>> +
>> +	/*
>> +	 * After writing the wakeup command, wait for maximum timeout of 0xFF
>> +	 * for firmware to reset the command address back zero to indicate
>> +	 * the successful reception of command.
>> +	 * NOTE: 0xFF as timeout value is decided based on our experiments.
>> +	 *
>> +	 * XXX: Change the timeout once ACPI specification comes up with
>> +	 *      standard maximum timeout value.
>> +	 */
>> +	timeout = 0xFF;
>> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
>> +		cpu_relax();
>> +
>> +	/* If timed out (timeout == 0), return error */
>> +	if (!timeout) {
> So this leaves a stale acpi_mp_wake_mailbox->command. What checks that
> acpi_mp_wake_mailbox->command is 0 on the next invocation?


  For each invocation, acpi_mp_wake_mailbox->comand value is set as 1. So I
think we don't have to worry about the previous state. Please correct me
if I don't understand your query.

>
> Aside of that assume timeout happens and the firmware acts after this
> returned. Then you have inconsistent state as well. Error handling is
> not trivial, but making it hope based is the worst kind.

Current assumption is, once the timeout happens, current wakeup request is
considered failed and firmware will not update the command address. But
current ACPI spec does not document the above assumption. I will check with
the spec owner about this issue and get back to you.

>
>> +		spin_unlock_irqrestore(&mailbox_lock, flags);
>> +		return -EIO;
>> +	}
>> +
>> +	/*
>> +	 * If the CPU wakeup process is successful, store the
>> +	 * status in apic_id_wakemap to prevent re-wakeup
>> +	 * requests.
>> +	 */
>> +	physid_set(apicid, apic_id_wakemap);
>> +
>> +	spin_unlock_irqrestore(&mailbox_lock, flags);
>> +
>> +	return 0;
>> +}
>> +#endif
>>   #endif				/*CONFIG_X86_LOCAL_APIC */
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


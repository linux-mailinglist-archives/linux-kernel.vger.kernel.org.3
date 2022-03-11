Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF24D683E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiCKSC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350861AbiCKSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:02:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1121D3DA1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647021709; x=1678557709;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=NtmMBDLCAlXGhSIm2dCcpv5zKxa1w71GkSjSQRaO4jo=;
  b=gjXNIVKnjWUFhT7qZhH7SuGDdyt+/Yn4otduVJurLfqT06woXOSrqCXa
   MqZwyI/DcwdKaROYRyLpzElrgbRKHn3GCejY7H0NaiRTPE/8VFtWdoW3z
   /GR+ff5OiV1W8/IgajhcEbyd4Fkx6JuZjIPnR5l+k4Jv7AhF4uMWd90kt
   lcvsuH+kPto3qimZeS3Cn+kCbXJRaCa5xBA2oYYw0Pq7gPNfHJE5fUK5G
   ok00+tRdGm7temZscv+cIxyX5HAbMlM/0I1g0b+5+sLgo4wLHZHTQO19b
   q/7hOSaOUm+Hr17p1fcIlqW76cy+QCDgiXiwM5lFWzeNCUAA1XjYmEcCG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="243069257"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="243069257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 10:01:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="645004193"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 10:01:48 -0800
Message-ID: <781bd032-1e80-7c1c-2dbc-4a123238af9a@intel.com>
Date:   Fri, 11 Mar 2022 10:01:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
 <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
 <20220310005145.hzv2lzxgs7uxblfr@black.fi.intel.com>
 <da0056e8-58cf-2c95-fe66-4dad1ae9c4da@intel.com>
 <20220310164839.erpjijvxwuzjql5x@black.fi.intel.com>
 <9b2836ce-5267-8342-65eb-1084ba7e0cdf@intel.com>
 <20220311171848.g5wobw3rmi4e2zkd@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220311171848.g5wobw3rmi4e2zkd@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 09:18, Kirill A. Shutemov wrote:
> On Thu, Mar 10, 2022 at 09:53:01AM -0800, Dave Hansen wrote:
>> On 3/10/22 08:48, Kirill A. Shutemov wrote:
>> I think this is good enough:
>>
>>    - All guest code is expected to be in TD-private memory.  Being
>>      private to the TD, VMMs have no way to access TD-private memory and
>>      no way to read the instruction to decode and emulate it.
> 
> Looks good.
> 
> One remark: executing from shared memory (or walking page tables in shared
> memory) triggers #PF.

Good point.  I thought that little nugget was AMD only.  Thanks for the
reminder.

   - TDX does not allow guests to execute from shared memory.  All
     executed instructions are in TD-private memory.  Being private to
     the TD, VMMs have no way to access TD-private memory and no way to
     read the instruction to decode and emulate it.

...
>> I'd feel a lot better if this was slightly better specified.  Even
>> booting with a:
>>
>> 	printf("rip: %lx\n", regs->rip);
>>
>> in the #VE handler would give some hard data about these.  This still
>> feels to me like something that Sean got booting two years ago and
>> nobody has really reconsidered.
> 
> Here the list I see on boot. It highly depends on QEMU setup. Any form of
> device filtering will cut the further.
> 
> MMIO: ahci_enable_ahci
> MMIO: ahci_freeze
> MMIO: ahci_init_controller
> MMIO: ahci_port_resume
> MMIO: ahci_postreset
> MMIO: ahci_reset_controller
> MMIO: ahci_save_initial_config
> MMIO: ahci_scr_read
> MMIO: ahci_scr_write
> MMIO: ahci_set_em_messages
> MMIO: ahci_start_engine
> MMIO: ahci_stop_engine
> MMIO: ahci_thaw

OK, so this is one of the random drivers that will probably be replaced
with virtio in practice in real TD guests.

> MMIO: ioapic_set_affinity
> MMIO: ioread16
> MMIO: ioread32
> MMIO: ioread8
> MMIO: iowrite16
> MMIO: iowrite32
> MMIO: iowrite8
> MMIO: mask_ioapic_irq
> MMIO: mp_irqdomain_activate
> MMIO: mp_irqdomain_deactivate
> MMIO: native_io_apic_read
> MMIO: __pci_enable_msix_range
> MMIO: pci_mmcfg_read
> MMIO: pci_msi_mask_irq
> MMIO: pci_msi_unmask_irq
> MMIO: __pci_write_msi_msg
> MMIO: restore_ioapic_entries
> MMIO: startup_ioapic_irq
> MMIO: update_no_reboot_bit_mem
> 
> ioread*/iowrite* comes from virtio.

I think we *actually* have some real facts to go on now instead of just
random hand waving about unknown MMIO in the the depths of arch/x86.
Thanks for doing that.

Just spot-checking these, I think all of these end up going through some
->ops function pointers:

	irq_chip
	x86_apic_ops
	pci_raw_ops

That doesn't really help your case, though.  Presumably, with some
amount of work, we could paravirtualize these users.  The list of things
doesn't seem very large at all.  But, each of those things will need
TDX-specific code.

So, do we go patching those things with TDX-specific code?  Or do we
just do this one, universal, slow #VE thing for now?

Kirill, I know what camp you are in. :)

Looking at the *actual* work that would be required, I'm a little more
on the fence and leaning toward being ok with the universal #VE.

Does anybody feel differently?

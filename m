Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5C4D6770
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350731AbiCKRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350711AbiCKRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:19:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A15E61F9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647019117; x=1678555117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PxS7x+AuHC3Av3QB9AykfsPjmUja5dgEY8E3OQd2mmc=;
  b=ENycImBkzwa6lRsP+CBXayGJ3EKxPDXwtgrL8MYEK6d18nHsv1J3hwnC
   7YvkhHGBQ5eVvoQPyjuY8PKHax40QuWz4S6O3wRMcxI38qttC8rLgW1MS
   oBkplMRaMheRmvcvhGSyPDAG4/lAxjhlCJdBocgU/srE8gxdCf4FongWd
   UDpV6Zi094jMVGrYshIaqISg5fxTuskAr1Du2MfSfHmHts5/ku+VsaNUM
   hoRColpbvI6Xd9Hxrh29zjzw2Sug/pOOHebvqFxVH4kSHtZiPfj9s9b8o
   grYYwOexUmmZupu8ba39toxTlhBlzg1oRTypBJDo0c/b5gMAThJk4sem/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="236216031"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="236216031"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="712907140"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 09:18:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 40F42132; Fri, 11 Mar 2022 19:18:49 +0200 (EET)
Date:   Fri, 11 Mar 2022 20:18:48 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220311171848.g5wobw3rmi4e2zkd@black.fi.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
 <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
 <20220310005145.hzv2lzxgs7uxblfr@black.fi.intel.com>
 <da0056e8-58cf-2c95-fe66-4dad1ae9c4da@intel.com>
 <20220310164839.erpjijvxwuzjql5x@black.fi.intel.com>
 <9b2836ce-5267-8342-65eb-1084ba7e0cdf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2836ce-5267-8342-65eb-1084ba7e0cdf@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:53:01AM -0800, Dave Hansen wrote:
> On 3/10/22 08:48, Kirill A. Shutemov wrote:
> I think this is good enough:
> 
>    - All guest code is expected to be in TD-private memory.  Being
>      private to the TD, VMMs have no way to access TD-private memory and
>      no way to read the instruction to decode and emulate it.

Looks good.

One remark: executing from shared memory (or walking page tables in shared
memory) triggers #PF.

> 
> We don't have to rehash what private memory is or how it is implemented.
> 
> >> This problem was laid out as having three cases:
> >> 1. virtio
> >> 2. x86-specific drivers
> >> 3. random drivers (everything else)
> >>
> >> #1 could be done with paravirt
> >> #2 is unspecified and unknown
> >> #3 use doesn't as far as I know exist in TDX guests today
> > 
> > #2 doesn't matter from performance point of view and there is no
> > convenient place where they can be intercepted as they are scattered
> > across the tree. Patching them doesn't bring any benefit, only pain.
> 
> I'd feel a lot better if this was slightly better specified.  Even
> booting with a:
> 
> 	printf("rip: %lx\n", regs->rip);
> 
> in the #VE handler would give some hard data about these.  This still
> feels to me like something that Sean got booting two years ago and
> nobody has really reconsidered.

Here the list I see on boot. It highly depends on QEMU setup. Any form of
device filtering will cut the further.

MMIO: ahci_enable_ahci
MMIO: ahci_freeze
MMIO: ahci_init_controller
MMIO: ahci_port_resume
MMIO: ahci_postreset
MMIO: ahci_reset_controller
MMIO: ahci_save_initial_config
MMIO: ahci_scr_read
MMIO: ahci_scr_write
MMIO: ahci_set_em_messages
MMIO: ahci_start_engine
MMIO: ahci_stop_engine
MMIO: ahci_thaw
MMIO: ioapic_set_affinity
MMIO: ioread16
MMIO: ioread32
MMIO: ioread8
MMIO: iowrite16
MMIO: iowrite32
MMIO: iowrite8
MMIO: mask_ioapic_irq
MMIO: mp_irqdomain_activate
MMIO: mp_irqdomain_deactivate
MMIO: native_io_apic_read
MMIO: __pci_enable_msix_range
MMIO: pci_mmcfg_read
MMIO: pci_msi_mask_irq
MMIO: pci_msi_unmask_irq
MMIO: __pci_write_msi_msg
MMIO: restore_ioapic_entries
MMIO: startup_ioapic_irq
MMIO: update_no_reboot_bit_mem

ioread*/iowrite* comes from virtio.

> > #3 some customers already declared that they will use device passthough
> > (yes, it is not safe). CSP may want to emulate random device, depending on
> > setup. Like, a power button or something.
> 
> I'm not sure I'm totally on board with that.
> 
> But, let's try to make a coherent changelog out of that mess.
> 
> 	This approach is bad for performance.  But, it has (virtually)
> 	no impact on the size of the kernel image and will work for a
> 	wide variety of drivers.  This allows TDX deployments to use
> 	arbitrary devices and device drivers, including virtio.  TDX
> 	customers have asked for the capability to use random devices in
> 	their deployments.
> 
> 	In other words, even if all of the work was done to
> 	paravirtualize all x86 MMIO users and virtio, this approach
> 	would still be needed.  There is essentially no way to get rid
> 	of this code.
> 
> 	This approach is functional for all in-kernel MMIO users current
> 	and future and does so with a minimal amount of code and kernel
> 	image bloat.
> 
> Does that summarize it?

I will integrate it in the commit message.

> But, I'd like to see one of two things:
> 1. Change the BUG()s to WARN()s.
> 2. Make it utterly clear that handle_mmio() is for handling kernel MMIO
>    only.  Definitely change the naming, possibly add a check for
>    user_mode().  In other words, make it even _less_ generic.
> 
> None of that should be hard.

Okay, I will downgrade BUG() to WARN() and return false for user_mode()
with warning.

> BTW, the BUG()s made me think about how the gp_try_fixup_and_notify()
> code would work for MMIO.  For instance, are there any places where
> fixup might be done for MMIO?  If so, an earlier BUG() wouldn't allow
> the fixup to occur.

I can be wrong, but I don't think we do fixups for MMIO.

> Do we *WANT* #VE's to be exposed to the #GP fixup machinery?

We need the fixup at least for MSRs.

-- 
 Kirill A. Shutemov

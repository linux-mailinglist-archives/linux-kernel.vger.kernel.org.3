Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76E47BD0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhLUJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhLUJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:41:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F87C06173F;
        Tue, 21 Dec 2021 01:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3TyUeCtPFu25blTe8pPZ7aMDA1fevstO4Ab7cYMMS8=; b=dgj8frmj/7wSJT7JSoL0ZBhRzM
        iWWVrukpPUoX79+n/kp26ioeS21iwyOW6k+64wx/zHAal58119VJv5T4IhsRp2e2RlZjN7I6WtnO6
        HKDOr02Mg7UhmX8yw5SShNT1An6gTkB+aeq4YwrKeb3o7LWasgUz0mh++EW1y3tlHG5kn6UCzNKgG
        LN2EGINugpRafraZI2k7+te2SwvbLIFxxPCBzq8oFv+GQbYcJ/9VQNbTd5NGfrAcuOiXjUJsEMqSM
        jLAk3QrVzf6kruuOvN3NRbSsIQZCMH7TYaBbvPbieXPsg/3tV0hyJZigRcLAKufb1ZN3RiBlMhH9E
        9h7L9tzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzbdb-002LiA-JZ; Tue, 21 Dec 2021 09:40:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDF923002BE;
        Tue, 21 Dec 2021 10:40:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 869302C9C5155; Tue, 21 Dec 2021 10:40:50 +0100 (CET)
Date:   Tue, 21 Dec 2021 10:40:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 02:55:07PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
> > I can reproduce this.
> > Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
> > 
> > 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
> 
> I can confirm, reverting that solves the boot hang, things aren't quite
> working for me though.

I've been poking at this a little, find debug patch and full dmesg
below. The TL;DR version of the dmesg seems to be:

[    4.984148] xhci_dbc:xdbc_start: waiting for connection timed out
[    4.984149] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host

Initially I thought this was due to delay not being set up properly, but
I 'fixed' that, and I've ran out of ideas. I really don't know anything
about USB :/

---

 arch/x86/kernel/tsc.c        |  1 +
 arch/x86/lib/delay.c         |  6 +++++-
 drivers/usb/early/xhci-dbc.c | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 2e076a459a0c..cd8b5cac542a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1485,6 +1485,7 @@ void __init tsc_early_init(void)
 	loops_per_jiffy = get_loops_per_jiffy();
 
 	tsc_enable_sched_clock();
+	use_tsc_delay();
 }
 
 void __init tsc_init(void)
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 65d15df6212d..a9df2fd08997 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -173,20 +173,24 @@ static void delay_halt(u64 __cycles)
 
 void __init use_tsc_delay(void)
 {
-	if (delay_fn == delay_loop)
+	if (delay_fn == delay_loop) {
+		pr_err("delay_tsc\n");
 		delay_fn = delay_tsc;
+	}
 }
 
 void __init use_tpause_delay(void)
 {
 	delay_halt_fn = delay_halt_tpause;
 	delay_fn = delay_halt;
+	pr_err("delay_halt/tpause");
 }
 
 void use_mwaitx_delay(void)
 {
 	delay_halt_fn = delay_halt_mwaitx;
 	delay_fn = delay_halt;
+	pr_err("delay_halt/mwaitx");
 }
 
 int read_current_timer(unsigned long *timer_val)
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index de4fb6c1d4ff..1cb66c1ef12d 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -29,11 +29,15 @@
 static struct xdbc_state xdbc;
 static bool early_console_keep;
 
+#if 0
 #ifdef XDBC_TRACE
 #define	xdbc_trace	trace_printk
 #else
 static inline void xdbc_trace(const char *fmt, ...) { }
 #endif /* XDBC_TRACE */
+#else
+#define xdbc_trace	pr_err
+#endif
 
 static void __iomem * __init xdbc_map_pci_mmio(u32 bus, u32 dev, u32 func)
 {
@@ -554,43 +558,61 @@ static int __init xdbc_early_setup(void)
 {
 	int ret;
 
+	pr_err("XXX A\n");
+
 	writel(0, &xdbc.xdbc_reg->control);
 	ret = handshake(&xdbc.xdbc_reg->control, CTRL_DBC_ENABLE, 0, 100000, 100);
 	if (ret)
 		return ret;
 
+	pr_err("XXX B\n");
+
 	/* Allocate the table page: */
 	xdbc.table_base = xdbc_get_page(&xdbc.table_dma);
 	if (!xdbc.table_base)
 		return -ENOMEM;
 
+	pr_err("XXX C\n");
+
 	/* Get and store the transfer buffer: */
 	xdbc.out_buf = xdbc_get_page(&xdbc.out_dma);
 	if (!xdbc.out_buf)
 		return -ENOMEM;
 
+	pr_err("XXX D\n");
+
 	/* Allocate the event ring: */
 	ret = xdbc_alloc_ring(&xdbc.evt_seg, &xdbc.evt_ring);
 	if (ret < 0)
 		return ret;
 
+	pr_err("XXX E\n");
+
 	/* Allocate IN/OUT endpoint transfer rings: */
 	ret = xdbc_alloc_ring(&xdbc.in_seg, &xdbc.in_ring);
 	if (ret < 0)
 		return ret;
 
+	pr_err("XXX F\n");
+
 	ret = xdbc_alloc_ring(&xdbc.out_seg, &xdbc.out_ring);
 	if (ret < 0)
 		return ret;
 
+	pr_err("XXX G\n");
+
 	xdbc_mem_init();
 
+	pr_err("XXX H\n");
+
 	ret = xdbc_start();
 	if (ret < 0) {
 		writel(0, &xdbc.xdbc_reg->control);
 		return ret;
 	}
 
+	pr_err("XXX I\n");
+
 	xdbc.flags |= XDBC_FLAGS_INITIALIZED | XDBC_FLAGS_CONFIGURED;
 
 	xdbc_bulk_transfer(NULL, XDBC_MAX_PACKET, true);


-----



[    0.000000] Linux version 5.16.0-rc3+ (root@tigerlake) (gcc (Debian 11.2.0-12) 11.2.0, GNU ld (GNU Binutils for Debian) 2.37) #13 SMP PREEMPT Tue Dec 21 10:30:38 CET 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc,keep force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000038180fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000038181000-0x0000000040b91fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040b92000-0x0000000040c5dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000040c5e000-0x0000000040d1cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000040d1d000-0x000000004173afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004173b000-0x00000000417fefff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000417ff000-0x00000000417fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000041800000-0x0000000047ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000048e00000-0x000000004f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004b07fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: ACPI=0x40cce000 ACPI 2.0=0x40cce014 SMBIOS=0x41568000 SMBIOS 3.0=0x41567000 MEMATTR=0x31355018 ESRT=0x35190298 MOKvar=0x3134c000 
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Intel(R) Client Systems NUC11PAHi7/NUC11PABi7, BIOS PATGL357.0041.2021.0811.1505 08/11/2021
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2803.200 MHz TSC
[    0.000002] delay_tsc
[    0.000921] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000922] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000926] last_pfn = 0x4b0800 max_arch_pfn = 0x400000000
[    0.001029] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002145] last_pfn = 0x41800 max_arch_pfn = 0x400000000
[    0.021141] esrt: Reserving ESRT space from 0x0000000035190298 to 0x0000000035190370.
[    0.021145] e820: update [mem 0x35190000-0x35190fff] usable ==> reserved
[    0.021152] e820: update [mem 0x3134c000-0x3134efff] usable ==> reserved
[    0.021162] Using GB pages for direct mapping
[    0.021432] Secure boot could not be determined
[    0.021432] RAMDISK: [mem 0x2f8e0000-0x30b4afff]
[    0.021434] ACPI: Early table checksum verification disabled
[    0.021436] ACPI: RSDP 0x0000000040CCE014 000024 (v02 INTEL )
[    0.021439] ACPI: XSDT 0x0000000040CCD728 0000EC (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021442] ACPI: FACP 0x0000000040C57000 000114 (v06 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021446] ACPI: DSDT 0x0000000040BFC000 05AB35 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021448] ACPI: FACS 0x0000000040D19000 000040
[    0.021449] ACPI: MCFG 0x0000000040C5B000 00003C (v01 INTEL  NUC11PAB 00000029 MSFT 00000097)
[    0.021451] ACPI: SSDT 0x0000000040C58000 00255D (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021453] ACPI: FIDT 0x0000000040BFB000 00009C (v01 INTEL  NUC11PAB 00000029 AMI  00010013)
[    0.021455] ACPI: SSDT 0x0000000040BF8000 002C3E (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021457] ACPI: SSDT 0x0000000040BF4000 003435 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021458] ACPI: SSDT 0x0000000040BE8000 00B27A (v02 INTEL  NUC11PAB 00001000 INTL 20191018)
[    0.021460] ACPI: HPET 0x0000000040C5D000 000038 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021462] ACPI: APIC 0x0000000040C5C000 00012C (v04 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021464] ACPI: SSDT 0x0000000040BE2000 00590A (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021466] ACPI: SSDT 0x0000000040BE1000 000B5E (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021467] ACPI: NHLT 0x0000000040BE0000 00002D (v00 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021469] ACPI: UEFI 0x0000000040CBB000 000048 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021471] ACPI: LPIT 0x0000000040BDF000 0000CC (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021473] ACPI: SSDT 0x0000000040BDB000 002720 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021474] ACPI: SSDT 0x0000000040BDA000 00012A (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021476] ACPI: DBGP 0x0000000040BD9000 000034 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021478] ACPI: DBG2 0x0000000040BD8000 000054 (v00 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021480] ACPI: SSDT 0x0000000040BD6000 0015FC (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021481] ACPI: DMAR 0x0000000040BD5000 0000B8 (v02 INTEL  NUC11PAB 00000029      01000013)
[    0.021483] ACPI: SSDT 0x0000000040BD4000 000823 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021485] ACPI: SSDT 0x0000000040BD3000 000144 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021487] ACPI: PTDT 0x0000000040BD2000 000D44 (v00 INTEL  NUC11PAB 00000029 MSFT 0100000D)
[    0.021488] ACPI: WSMT 0x0000000040BDE000 000028 (v01 INTEL  NUC11PAB 00000029 AMI  00010013)
[    0.021490] ACPI: FPDT 0x0000000040BD1000 000044 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021492] ACPI: Reserving FACP table memory at [mem 0x40c57000-0x40c57113]
[    0.021493] ACPI: Reserving DSDT table memory at [mem 0x40bfc000-0x40c56b34]
[    0.021493] ACPI: Reserving FACS table memory at [mem 0x40d19000-0x40d1903f]
[    0.021494] ACPI: Reserving MCFG table memory at [mem 0x40c5b000-0x40c5b03b]
[    0.021495] ACPI: Reserving SSDT table memory at [mem 0x40c58000-0x40c5a55c]
[    0.021495] ACPI: Reserving FIDT table memory at [mem 0x40bfb000-0x40bfb09b]
[    0.021496] ACPI: Reserving SSDT table memory at [mem 0x40bf8000-0x40bfac3d]
[    0.021496] ACPI: Reserving SSDT table memory at [mem 0x40bf4000-0x40bf7434]
[    0.021497] ACPI: Reserving SSDT table memory at [mem 0x40be8000-0x40bf3279]
[    0.021497] ACPI: Reserving HPET table memory at [mem 0x40c5d000-0x40c5d037]
[    0.021498] ACPI: Reserving APIC table memory at [mem 0x40c5c000-0x40c5c12b]
[    0.021499] ACPI: Reserving SSDT table memory at [mem 0x40be2000-0x40be7909]
[    0.021499] ACPI: Reserving SSDT table memory at [mem 0x40be1000-0x40be1b5d]
[    0.021500] ACPI: Reserving NHLT table memory at [mem 0x40be0000-0x40be002c]
[    0.021500] ACPI: Reserving UEFI table memory at [mem 0x40cbb000-0x40cbb047]
[    0.021501] ACPI: Reserving LPIT table memory at [mem 0x40bdf000-0x40bdf0cb]
[    0.021502] ACPI: Reserving SSDT table memory at [mem 0x40bdb000-0x40bdd71f]
[    0.021502] ACPI: Reserving SSDT table memory at [mem 0x40bda000-0x40bda129]
[    0.021503] ACPI: Reserving DBGP table memory at [mem 0x40bd9000-0x40bd9033]
[    0.021503] ACPI: Reserving DBG2 table memory at [mem 0x40bd8000-0x40bd8053]
[    0.021504] ACPI: Reserving SSDT table memory at [mem 0x40bd6000-0x40bd75fb]
[    0.021505] ACPI: Reserving DMAR table memory at [mem 0x40bd5000-0x40bd50b7]
[    0.021505] ACPI: Reserving SSDT table memory at [mem 0x40bd4000-0x40bd4822]
[    0.021506] ACPI: Reserving SSDT table memory at [mem 0x40bd3000-0x40bd3143]
[    0.021506] ACPI: Reserving PTDT table memory at [mem 0x40bd2000-0x40bd2d43]
[    0.021507] ACPI: Reserving WSMT table memory at [mem 0x40bde000-0x40bde027]
[    0.021508] ACPI: Reserving FPDT table memory at [mem 0x40bd1000-0x40bd1043]
[    0.021883] No NUMA configuration found
[    0.021884] Faking a node at [mem 0x0000000000000000-0x00000004b07fffff]
[    0.021889] NODE_DATA(0) allocated [mem 0x4b07d5000-0x4b07fefff]
[    0.022065] xhci_dbc:xdbc_early_setup: XXX A
[    0.022068] xhci_dbc:xdbc_early_setup: XXX B
[    0.022068] xhci_dbc:xdbc_early_setup: XXX C
[    0.022069] xhci_dbc:xdbc_early_setup: XXX D
[    0.022070] xhci_dbc:xdbc_early_setup: XXX E
[    0.022071] xhci_dbc:xdbc_early_setup: XXX F
[    0.022071] xhci_dbc:xdbc_early_setup: XXX G
[    0.022073] xhci_dbc:xdbc_early_setup: XXX H
[    4.984148] xhci_dbc:xdbc_start: waiting for connection timed out
[    4.984149] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
[    4.984160] Zone ranges:
[    4.984160]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    4.984162]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    4.984163]   Normal   [mem 0x0000000100000000-0x00000004b07fffff]
[    4.984164]   Device   empty
[    4.984164] Movable zone start for each node
[    4.984165] Early memory node ranges
[    4.984166]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    4.984167]   node   0: [mem 0x0000000000100000-0x0000000038180fff]
[    4.984168]   node   0: [mem 0x00000000417ff000-0x00000000417fffff]
[    4.984168]   node   0: [mem 0x0000000100000000-0x00000004b07fffff]
[    4.984170] Initmem setup node 0 [mem 0x0000000000001000-0x00000004b07fffff]
[    4.984172] On node 0, zone DMA: 1 pages in unavailable ranges
[    4.984195] On node 0, zone DMA: 97 pages in unavailable ranges
[    4.985647] On node 0, zone DMA32: 38526 pages in unavailable ranges
[    4.985984] On node 0, zone Normal: 26624 pages in unavailable ranges
[    4.986158] On node 0, zone Normal: 30720 pages in unavailable ranges
[    4.986199] Reserving Intel graphics memory at [mem 0x4b800000-0x4f7fffff]
[    4.987240] ACPI: PM-Timer IO Port: 0x1808
[    4.987244] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    4.987245] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    4.987246] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    4.987246] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    4.987247] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    4.987247] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    4.987248] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    4.987248] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    4.987249] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    4.987249] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    4.987250] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    4.987250] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    4.987250] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    4.987251] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    4.987252] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    4.987252] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    4.987336] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    4.987338] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    4.987339] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    4.987342] ACPI: Using ACPI (MADT) for SMP configuration information
[    4.987343] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    4.987345] TSC deadline timer available
[    4.987346] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    4.987356] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    4.987357] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    4.987359] PM: hibernation: Registered nosave memory: [mem 0x3134c000-0x3134efff]
[    4.987360] PM: hibernation: Registered nosave memory: [mem 0x35190000-0x35190fff]
[    4.987361] PM: hibernation: Registered nosave memory: [mem 0x38181000-0x40b91fff]
[    4.987361] PM: hibernation: Registered nosave memory: [mem 0x40b92000-0x40c5dfff]
[    4.987362] PM: hibernation: Registered nosave memory: [mem 0x40c5e000-0x40d1cfff]
[    4.987362] PM: hibernation: Registered nosave memory: [mem 0x40d1d000-0x4173afff]
[    4.987363] PM: hibernation: Registered nosave memory: [mem 0x4173b000-0x417fefff]
[    4.987364] PM: hibernation: Registered nosave memory: [mem 0x41800000-0x47ffffff]
[    4.987364] PM: hibernation: Registered nosave memory: [mem 0x48000000-0x48dfffff]
[    4.987365] PM: hibernation: Registered nosave memory: [mem 0x48e00000-0x4f7fffff]
[    4.987365] PM: hibernation: Registered nosave memory: [mem 0x4f800000-0xbfffffff]
[    4.987366] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xcfffffff]
[    4.987366] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfdffffff]
[    4.987367] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    4.987367] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    4.987368] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    4.987369] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    4.987369] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    4.987370] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed1ffff]
[    4.987370] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    4.987371] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfedfffff]
[    4.987371] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    4.987372] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    4.987372] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    4.987373] [mem 0x4f800000-0xbfffffff] available for PCI devices
[    4.987374] Booting paravirtualized kernel on bare hardware
[    4.987376] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    4.992206] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    4.992318] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
[    4.992323] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=1*2097152
[    4.992324] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    4.992339] Fallback order for Node 0: 0 
[    4.992341] Built 1 zonelists, mobility grouping on.  Total pages: 4034139
[    4.992342] Policy zone: Normal
[    4.992343] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc,keep force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
[    4.992392] sysrq: sysrq always enabled.
[    4.992436] Unknown kernel command line parameters "force_early_printk nokaslr BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+", will be passed to user space.
[    4.992830] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    4.993031] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    4.993083] mem auto-init: stack:off, heap alloc:on, heap free:off
[    5.003365] Memory: 797624K/16393344K available (20499K kernel code, 4046K rwdata, 14220K rodata, 2800K init, 4768K bss, 541540K reserved, 0K cma-reserved)
[    5.003369] random: get_random_u64 called from __kmem_cache_create+0x2a/0x530 with crng_init=0
[    5.003466] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    5.003474] ftrace: allocating 63035 entries in 247 pages
[    5.016293] ftrace: allocated 247 pages with 7 groups
[    5.016445] Starting tracer 'nop'
[    5.017223] Dynamic Preempt: voluntary
[    5.017242] rcu: Preemptible hierarchical RCU implementation.
[    5.017243] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    5.017244] 	Trampoline variant of Tasks RCU enabled.
[    5.017245] 	Rude variant of Tasks RCU enabled.
[    5.017245] 	Tracing variant of Tasks RCU enabled.
[    5.017246] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    5.017246] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    5.019598] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    5.020295] random: crng done (trusting CPU's manufacturer)
[    5.020312] Console: colour dummy device 80x25
[    5.020510] printk: console [tty0] enabled
[    5.020520] ACPI: Core revision 20210930
[    5.020705] hpet: HPET dysfunctional in PC10. Force disabled.
[    5.020707] APIC: Switch to symmetric I/O mode setup
[    5.020709] DMAR: Host address width 39
[    5.020710] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    5.020714] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 69e2ff0505e
[    5.020716] DMAR: DRHD base: 0x000000fed84000 flags: 0x0
[    5.020719] DMAR: dmar1: reg_base_addr fed84000 ver 1:0 cap d2008c40660462 ecap f050da
[    5.020722] DMAR: DRHD base: 0x000000fed87000 flags: 0x0
[    5.020724] DMAR: dmar2: reg_base_addr fed87000 ver 1:0 cap d2008c40660462 ecap f050da
[    5.020727] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    5.020730] DMAR: dmar3: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    5.020735] DMAR: RMRR base: 0x0000004b000000 end: 0x0000004f7fffff
[    5.020737] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 3
[    5.020739] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    5.020740] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    5.025116] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    5.025118] x2apic enabled
[    5.025169] Switched APIC routing to cluster x2apic.
[    5.036849] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    5.036856] Calibrating delay loop (skipped), value calculated using timer frequency.. 5606.40 BogoMIPS (lpj=11212800)
[    5.036859] pid_max: default: 32768 minimum: 301
[    5.039405] LSM: Security Framework initializing
[    5.039412] Yama: becoming mindful.
[    5.039426] AppArmor: AppArmor initialized
[    5.039428] TOMOYO Linux initialized
[    5.039452] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    5.039471] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    5.039623] CPU0: Thermal monitoring enabled (TM1)
[    5.039625] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    5.039712] process: using mwait in idle threads
[    5.039714] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    5.039715] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    5.039718] Speculative Store Bypass: Vulnerable
[    5.040854] Freeing SMP alternatives memory: 60K
[    5.040854] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1499
[    5.040854] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz (family: 0x6, model: 0x8c, stepping: 0x1)
[    5.040854] Performance Events: PEBS fmt4+-baseline,  AnyThread deprecated, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    5.040854] ... version:                5
[    5.040854] ... bit width:              48
[    5.040854] ... generic registers:      8
[    5.040854] ... value mask:             0000ffffffffffff
[    5.040854] ... max period:             00007fffffffffff
[    5.040854] ... fixed-purpose events:   4
[    5.040854] ... event mask:             0001000f000000ff
[    5.040854] rcu: Hierarchical SRCU implementation.
[    5.040854] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    5.040854] smp: Bringing up secondary CPUs ...
[    5.040854] x86: Booting SMP configuration:
[    5.040854] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    5.041770] smp: Brought up 1 node, 8 CPUs
[    5.041770] smpboot: Max logical packages: 1
[    5.041770] smpboot: Total of 8 processors activated (44851.20 BogoMIPS)
[    5.044886] CPU0 attaching sched-domain(s):
[    5.044887]  domain-0: span=0,4 level=SMT
[    5.044889]   groups: 0:{ span=0 }, 4:{ span=4 }
[    5.044892]   domain-1: span=0-7 level=MC
[    5.044894]    groups: 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }
[    5.044901] CPU1 attaching sched-domain(s):
[    5.044902]  domain-0: span=1,5 level=SMT
[    5.044903]   groups: 1:{ span=1 }, 5:{ span=5 }
[    5.044906]   domain-1: span=0-7 level=MC
[    5.044907]    groups: 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }
[    5.044912] CPU2 attaching sched-domain(s):
[    5.044913]  domain-0: span=2,6 level=SMT
[    5.044914]   groups: 2:{ span=2 }, 6:{ span=6 }
[    5.044916]   domain-1: span=0-7 level=MC
[    5.044918]    groups: 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }
[    5.044923] CPU3 attaching sched-domain(s):
[    5.044924]  domain-0: span=3,7 level=SMT
[    5.044925]   groups: 3:{ span=3 }, 7:{ span=7 }
[    5.044927]   domain-1: span=0-7 level=MC
[    5.044928]    groups: 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }
[    5.044934] CPU4 attaching sched-domain(s):
[    5.044934]  domain-0: span=0,4 level=SMT
[    5.044936]   groups: 4:{ span=4 }, 0:{ span=0 }
[    5.044938]   domain-1: span=0-7 level=MC
[    5.044939]    groups: 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }
[    5.044944] CPU5 attaching sched-domain(s):
[    5.044945]  domain-0: span=1,5 level=SMT
[    5.044946]   groups: 5:{ span=5 }, 1:{ span=1 }
[    5.044948]   domain-1: span=0-7 level=MC
[    5.044950]    groups: 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }
[    5.044955] CPU6 attaching sched-domain(s):
[    5.044956]  domain-0: span=2,6 level=SMT
[    5.044957]   groups: 6:{ span=6 }, 2:{ span=2 }
[    5.044959]   domain-1: span=0-7 level=MC
[    5.044960]    groups: 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }
[    5.044966] CPU7 attaching sched-domain(s):
[    5.044966]  domain-0: span=3,7 level=SMT
[    5.044968]   groups: 7:{ span=7 }, 3:{ span=3 }
[    5.044970]   domain-1: span=0-7 level=MC
[    5.044971]    groups: 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }
[    5.044976] root domain span: 0-7 (max cpu_capacity = 1024)
[    5.061291] node 0 deferred pages initialised in 16ms
[    5.061291] devtmpfs: initialized
[    5.061291] x86/mm: Memory block size: 128MB
[    5.061482] ACPI: PM: Registering ACPI NVS region [mem 0x40c5e000-0x40d1cfff] (782336 bytes)
[    5.061482] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    5.061482] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    5.061482] pinctrl core: initialized pinctrl subsystem
[    5.061482] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    5.061482] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    5.061482] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    5.061557] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    5.061565] audit: initializing netlink subsys (disabled)
[    5.061574] audit: type=2000 audit(1640079120.024:1): state=initialized audit_enabled=0 res=1
[    5.061574] thermal_sys: Registered thermal governor 'fair_share'
[    5.061574] thermal_sys: Registered thermal governor 'bang_bang'
[    5.061574] thermal_sys: Registered thermal governor 'step_wise'
[    5.061574] thermal_sys: Registered thermal governor 'user_space'
[    5.061574] thermal_sys: Registered thermal governor 'power_allocator'
[    5.061574] cpuidle: using governor ladder
[    5.061574] cpuidle: using governor menu
[    5.061574] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    5.061574] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    5.061574] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    5.061574] PCI: Using configuration type 1 for base access
[    5.061574] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    5.065316] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    5.065322] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    5.065322] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    5.065322] cryptd: max_cpu_qlen set to 1000
[    5.132855] raid6: avx512x4 gen() 64842 MB/s
[    5.200855] raid6: avx512x4 xor() 18374 MB/s
[    5.268854] raid6: avx512x2 gen() 74611 MB/s
[    5.336854] raid6: avx512x2 xor() 41557 MB/s
[    5.404854] raid6: avx512x1 gen() 63693 MB/s
[    5.472854] raid6: avx512x1 xor() 35172 MB/s
[    5.540855] raid6: avx2x4   gen() 50165 MB/s
[    5.608855] raid6: avx2x4   xor() 18990 MB/s
[    5.676854] raid6: avx2x2   gen() 56715 MB/s
[    5.744854] raid6: avx2x2   xor() 26813 MB/s
[    5.812854] raid6: avx2x1   gen() 43331 MB/s
[    5.880855] raid6: avx2x1   xor() 24194 MB/s
[    5.948855] raid6: sse2x4   gen() 14423 MB/s
[    6.016855] raid6: sse2x4   xor()  7061 MB/s
[    6.084855] raid6: sse2x2   gen() 14720 MB/s
[    6.152855] raid6: sse2x2   xor()  8099 MB/s
[    6.220855] raid6: sse2x1   gen() 13575 MB/s
[    6.288855] raid6: sse2x1   xor()  7489 MB/s
[    6.288856] raid6: using algorithm avx512x2 gen() 74611 MB/s
[    6.288857] raid6: .... xor() 41557 MB/s, rmw enabled
[    6.288858] raid6: using avx512x2 recovery algorithm
[    6.288927] ACPI: Added _OSI(Module Device)
[    6.288929] ACPI: Added _OSI(Processor Device)
[    6.288930] ACPI: Added _OSI(3.0 _SCP Extensions)
[    6.288931] ACPI: Added _OSI(Processor Aggregator Device)
[    6.288932] ACPI: Added _OSI(Linux-Dell-Video)
[    6.288933] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    6.288934] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    6.337708] ACPI: 12 ACPI AML tables successfully acquired and loaded
[    6.338306] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^SPI1.SPFD.CVFD (20210930/dspkginit-438)
[    6.338311] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^SPI1.SPFD.CVFD (20210930/dspkginit-438)
[    6.338314] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^XHCI.RHUB.HS04.VI2C (20210930/dspkginit-438)
[    6.338322] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^XHCI.RHUB.HS04.VI2C (20210930/dspkginit-438)
[    6.345464] ACPI: Dynamic OEM Table Load:
[    6.345471] ACPI: SSDT 0xFFFF888102858200 0001CB (v02 PmRef  Cpu0Psd  00003000 INTL 20191018)
[    6.346057] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    6.347442] ACPI: Dynamic OEM Table Load:
[    6.347446] ACPI: SSDT 0xFFFF88810241A800 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20191018)
[    6.348131] ACPI: Dynamic OEM Table Load:
[    6.348136] ACPI: SSDT 0xFFFF888102420800 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20191018)
[    6.348855] ACPI: Dynamic OEM Table Load:
[    6.348859] ACPI: SSDT 0xFFFF88810241DC00 000266 (v02 PmRef  Cpu0Hwp  00003000 INTL 20191018)
[    6.349630] ACPI: Dynamic OEM Table Load:
[    6.349634] ACPI: SSDT 0xFFFF888100312000 0008E7 (v02 PmRef  ApIst    00003000 INTL 20191018)
[    6.350376] ACPI: Dynamic OEM Table Load:
[    6.350380] ACPI: SSDT 0xFFFF888102427000 00048A (v02 PmRef  ApHwp    00003000 INTL 20191018)
[    6.351072] ACPI: Dynamic OEM Table Load:
[    6.351076] ACPI: SSDT 0xFFFF888102421800 0004D4 (v02 PmRef  ApPsd    00003000 INTL 20191018)
[    6.351770] ACPI: Dynamic OEM Table Load:
[    6.351774] ACPI: SSDT 0xFFFF888102420000 00048A (v02 PmRef  ApCst    00003000 INTL 20191018)
[    6.776893] ACPI: EC: EC started
[    6.776895] ACPI: EC: interrupt blocked
[    6.776923] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    6.776925] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC used to handle transactions
[    6.776928] ACPI: Interpreter enabled
[    6.776979] ACPI: PM: (supports S0 S3 S4 S5)
[    6.776981] ACPI: Using IOAPIC for interrupt routing
[    6.777027] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    6.778727] ACPI: Enabled 7 GPEs in block 00 to 7F
[    6.783858] ACPI: PM: Power Resource [PXP]
[    6.784721] ACPI: PM: Power Resource [PXP]
[    6.790853] ACPI: PM: Power Resource [BTPR]
[    6.791378] ACPI: PM: Power Resource [PAUD]
[    6.793189] ACPI: PM: Power Resource [V0PR]
[    6.793262] ACPI: PM: Power Resource [V1PR]
[    6.793328] ACPI: PM: Power Resource [V2PR]
[    6.795155] ACPI: PM: Power Resource [PXTC]
[    6.795358] ACPI: PM: Power Resource [PTPL]
[    6.795745] ACPI: PM: Power Resource [PXTC]
[    6.796180] ACPI: PM: Power Resource [PXTC]
[    6.797494] ACPI: PM: Power Resource [WRST]
[    6.799507] ACPI: PM: Power Resource [TBT0]
[    6.799703] ACPI: PM: Power Resource [TBT1]
[    6.799893] ACPI: PM: Power Resource [D3C]
[    7.060739] ACPI: PM: Power Resource [FN00]
[    7.060787] ACPI: PM: Power Resource [FN01]
[    7.060835] ACPI: PM: Power Resource [FN02]
[    7.061390] ACPI: PM: Power Resource [PIN]
[    7.061671] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    7.061677] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    7.064338] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    7.069124] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[    7.070744] PCI host bridge to bus 0000:00
[    7.070745] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    7.070747] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    7.070749] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    7.070750] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    7.070751] pci_bus 0000:00: root bus resource [mem 0x4f800000-0xbfffffff window]
[    7.070753] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    7.070755] pci_bus 0000:00: root bus resource [bus 00-fe]
[    7.070868] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000
[    7.071144] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000
[    7.071152] pci 0000:00:02.0: reg 0x10: [mem 0x603c000000-0x603cffffff 64bit]
[    7.071158] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 64bit pref]
[    7.071162] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    7.071175] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    7.071199] pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
[    7.071200] pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
[    7.071205] pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
[    7.071206] pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
[    7.071347] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400
[    7.071437] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    7.071474] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    7.071849] pci 0000:00:07.0: [8086:9a23] type 01 class 0x060400
[    7.071918] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    7.071941] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
[    7.073039] pci 0000:00:07.3: [8086:9a29] type 01 class 0x060400
[    7.073109] pci 0000:00:07.3: PME# supported from D0 D3hot D3cold
[    7.073132] pci 0000:00:07.3: DPC: RP PIO log size 0 is invalid
[    7.074241] pci 0000:00:08.0: [8086:9a11] type 00 class 0x088000
[    7.074249] pci 0000:00:08.0: reg 0x10: [mem 0x603d1b2000-0x603d1b2fff 64bit]
[    7.074379] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330
[    7.074391] pci 0000:00:0d.0: reg 0x10: [mem 0x603d190000-0x603d19ffff 64bit]
[    7.074443] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    7.075472] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340
[    7.075483] pci 0000:00:0d.2: reg 0x10: [mem 0x603d140000-0x603d17ffff 64bit]
[    7.075489] pci 0000:00:0d.2: reg 0x18: [mem 0x603d1b1000-0x603d1b1fff 64bit]
[    7.075520] pci 0000:00:0d.2: supports D1 D2
[    7.075521] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    7.075592] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340
[    7.075602] pci 0000:00:0d.3: reg 0x10: [mem 0x603d100000-0x603d13ffff 64bit]
[    7.075609] pci 0000:00:0d.3: reg 0x18: [mem 0x603d1b0000-0x603d1b0fff 64bit]
[    7.075639] pci 0000:00:0d.3: supports D1 D2
[    7.075640] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[    7.075850] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330
[    7.075873] pci 0000:00:14.0: reg 0x10: [mem 0x603d180000-0x603d18ffff 64bit]
[    7.075973] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    7.077023] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000
[    7.077046] pci 0000:00:14.2: reg 0x10: [mem 0x603d1a8000-0x603d1abfff 64bit]
[    7.077062] pci 0000:00:14.2: reg 0x18: [mem 0x603d1af000-0x603d1affff 64bit]
[    7.077222] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000
[    7.077265] pci 0000:00:14.3: reg 0x10: [mem 0x603d1a4000-0x603d1a7fff 64bit]
[    7.077415] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    7.078123] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000
[    7.078854] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    7.082061] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000
[    7.082087] pci 0000:00:16.0: reg 0x10: [mem 0x603d1ad000-0x603d1adfff 64bit]
[    7.082185] pci 0000:00:16.0: PME# supported from D3hot
[    7.082530] pci 0000:00:17.0: [8086:a0d3] type 00 class 0x010601
[    7.082551] pci 0000:00:17.0: reg 0x10: [mem 0x6a600000-0x6a601fff]
[    7.082561] pci 0000:00:17.0: reg 0x14: [mem 0x6a603000-0x6a6030ff]
[    7.082572] pci 0000:00:17.0: reg 0x18: [io  0x3090-0x3097]
[    7.082582] pci 0000:00:17.0: reg 0x1c: [io  0x3080-0x3083]
[    7.082593] pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]
[    7.082603] pci 0000:00:17.0: reg 0x24: [mem 0x6a602000-0x6a6027ff]
[    7.082670] pci 0000:00:17.0: PME# supported from D3hot
[    7.083086] pci 0000:00:1c.0: [8086:a0bc] type 01 class 0x060400
[    7.083209] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    7.083250] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    7.083678] pci 0000:00:1c.6: [8086:a0be] type 01 class 0x060400
[    7.083794] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    7.083835] pci 0000:00:1c.6: PTM enabled (root), 4ns granularity
[    7.084220] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100
[    7.084525] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040380
[    7.084587] pci 0000:00:1f.3: reg 0x10: [mem 0x603d1a0000-0x603d1a3fff 64bit]
[    7.084663] pci 0000:00:1f.3: reg 0x20: [mem 0x603d000000-0x603d0fffff 64bit]
[    7.084821] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    7.085142] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500
[    7.085174] pci 0000:00:1f.4: reg 0x10: [mem 0x603d1ac000-0x603d1ac0ff 64bit]
[    7.085209] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    7.085401] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000
[    7.085423] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    7.085903] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[    7.085919] pci 0000:01:00.0: reg 0x10: [mem 0x6a500000-0x6a503fff 64bit]
[    7.086095] pci 0000:00:06.0: PCI bridge to [bus 01]
[    7.086098] pci 0000:00:06.0:   bridge window [mem 0x6a500000-0x6a5fffff]
[    7.086129] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[    7.086133] pci 0000:00:07.0:   bridge window [mem 0x5e000000-0x6a1fffff]
[    7.086138] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    7.086166] pci 0000:00:07.3: PCI bridge to [bus 2d-57]
[    7.086170] pci 0000:00:07.3:   bridge window [mem 0x50000000-0x5c1fffff]
[    7.086174] pci 0000:00:07.3:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    7.086333] pci 0000:58:00.0: [17a0:9755] type 00 class 0x080501
[    7.086368] pci 0000:58:00.0: reg 0x10: [mem 0x6a400000-0x6a400fff]
[    7.086721] pci 0000:58:00.0: supports D1 D2
[    7.086723] pci 0000:58:00.0: PME# supported from D1 D2 D3hot D3cold
[    7.087134] pci 0000:00:1c.0: PCI bridge to [bus 58]
[    7.087139] pci 0000:00:1c.0:   bridge window [mem 0x6a400000-0x6a4fffff]
[    7.087302] pci 0000:59:00.0: [8086:15f3] type 00 class 0x020000
[    7.087321] pci 0000:59:00.0: reg 0x10: [mem 0x6a200000-0x6a2fffff]
[    7.087346] pci 0000:59:00.0: reg 0x1c: [mem 0x6a300000-0x6a303fff]
[    7.087472] pci 0000:59:00.0: PME# supported from D0 D3hot D3cold
[    7.087603] pci 0000:00:1c.6: PCI bridge to [bus 59]
[    7.087608] pci 0000:00:1c.6:   bridge window [mem 0x6a200000-0x6a3fffff]
[    7.091693] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    7.091760] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    7.091826] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    7.091892] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    7.091957] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    7.092022] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    7.092088] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    7.092153] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    7.112877] ACPI: EC: interrupt unblocked
[    7.112879] ACPI: EC: event unblocked
[    7.112922] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    7.112924] ACPI: EC: GPE=0x6e
[    7.112925] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC initialization complete
[    7.112927] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to handle transactions and events
[    7.112976] iommu: Default domain type: Translated 
[    7.112976] iommu: DMA domain TLB invalidation policy: lazy mode 
[    7.112976] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    7.112976] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    7.112976] pci 0000:00:02.0: vgaarb: bridge control possible
[    7.112976] vgaarb: loaded
[    7.112976] SCSI subsystem initialized
[    7.112976] libata version 3.00 loaded.
[    7.112976] ACPI: bus type USB registered
[    7.112976] usbcore: registered new interface driver usbfs
[    7.112976] usbcore: registered new interface driver hub
[    7.112976] usbcore: registered new device driver usb
[    7.112976] pps_core: LinuxPPS API ver. 1 registered
[    7.112976] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    7.112976] PTP clock support registered
[    7.112976] EDAC MC: Ver: 3.0.0
[    7.113524] Registered efivars operations
[    7.113524] Advanced Linux Sound Architecture Driver Initialized.
[    7.113524] Bluetooth: Core ver 2.22
[    7.113524] NET: Registered PF_BLUETOOTH protocol family
[    7.113524] Bluetooth: HCI device and connection manager initialized
[    7.113524] Bluetooth: HCI socket layer initialized
[    7.113524] Bluetooth: L2CAP socket layer initialized
[    7.113524] Bluetooth: SCO socket layer initialized
[    7.113524] NetLabel: Initializing
[    7.113524] NetLabel:  domain hash size = 128
[    7.113524] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    7.113524] NetLabel:  unlabeled traffic allowed by default
[    7.113524] PCI: Using ACPI for IRQ routing
[    7.188634] PCI: pci_cache_line_size set to 64 bytes
[    7.189098] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no compatible bridge window
[    7.189646] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    7.189648] e820: reserve RAM buffer [mem 0x3134c000-0x33ffffff]
[    7.189649] e820: reserve RAM buffer [mem 0x35190000-0x37ffffff]
[    7.189650] e820: reserve RAM buffer [mem 0x38181000-0x3bffffff]
[    7.189651] e820: reserve RAM buffer [mem 0x41800000-0x43ffffff]
[    7.189653] e820: reserve RAM buffer [mem 0x4b0800000-0x4b3ffffff]
[    7.189657] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    7.189657] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    7.189657] clocksource: Switched to clocksource tsc-early
[    7.195422] VFS: Disk quotas dquot_6.6.0
[    7.195432] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    7.195501] AppArmor: AppArmor Filesystem Enabled
[    7.195509] pnp: PnP ACPI init
[    7.195800] system 00:00: [io  0x0a00-0x0a0f] has been reserved
[    7.195802] system 00:00: [io  0x0a10-0x0a2f] has been reserved
[    7.195804] system 00:00: [io  0x0a30-0x0a4f] has been reserved
[    7.195805] system 00:00: [io  0x0a50-0x0a6f] has been reserved
[    7.195806] system 00:00: [io  0x0a70-0x0a7f] has been reserved
[    7.195807] system 00:00: [io  0x0a80-0x0a8f] has been reserved
[    7.195846] system 00:01: [io  0x0680-0x069f] has been reserved
[    7.195846] system 00:01: [io  0x164e-0x164f] has been reserved
[    7.195846] system 00:02: [io  0x1854-0x1857] has been reserved
[    7.195846] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    7.195846] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    7.195846] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    7.195846] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    7.195846] system 00:03: [mem 0xfed20000-0xfed7ffff] has been reserved
[    7.195846] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    7.195846] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    7.195846] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[    7.198575] system 00:04: [io  0x1800-0x18fe] could not be reserved
[    7.198577] system 00:04: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    7.198579] system 00:04: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    7.198580] system 00:04: [mem 0xfe050000-0xfe0affff] has been reserved
[    7.198582] system 00:04: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    7.198584] system 00:04: [mem 0xfe200000-0xfe7fffff] has been reserved
[    7.198585] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    7.198587] system 00:04: [mem 0xfd000000-0xfd68ffff] has been reserved
[    7.198588] system 00:04: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[    7.198590] system 00:04: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    7.198805] system 00:05: [io  0x2000-0x20fe] has been reserved
[    7.199051] system 00:07: [mem 0xfe410400-0xfe4104fe] has been reserved
[    7.199117] pnp: PnP ACPI: found 8 devices
[    7.204221] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    7.204262] NET: Registered PF_INET protocol family
[    7.204387] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    7.205310] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    7.205376] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    7.205502] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    7.205543] TCP: Hash tables configured (established 131072 bind 65536)
[    7.205600] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[    7.205644] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    7.205672] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    7.205753] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    7.205839] RPC: Registered named UNIX socket transport module.
[    7.205840] RPC: Registered udp transport module.
[    7.205841] RPC: Registered tcp transport module.
[    7.205842] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.205942] NET: Registered PF_XDP protocol family
[    7.205946] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    7.205953] pci 0000:00:02.0: BAR 9: assigned [mem 0x4020000000-0x40ffffffff 64bit pref]
[    7.205957] pci 0000:00:02.0: BAR 7: assigned [mem 0x4010000000-0x4016ffffff 64bit]
[    7.205960] pci 0000:00:07.0: BAR 13: assigned [io  0x4000-0x4fff]
[    7.205962] pci 0000:00:07.3: BAR 13: assigned [io  0x5000-0x5fff]
[    7.205964] pci 0000:00:15.0: BAR 0: assigned [mem 0x4017000000-0x4017000fff 64bit]
[    7.206312] pci 0000:00:1f.5: BAR 0: assigned [mem 0x4f800000-0x4f800fff]
[    7.206320] pci 0000:00:06.0: PCI bridge to [bus 01]
[    7.206329] pci 0000:00:06.0:   bridge window [mem 0x6a500000-0x6a5fffff]
[    7.206345] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[    7.206347] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    7.206350] pci 0000:00:07.0:   bridge window [mem 0x5e000000-0x6a1fffff]
[    7.206353] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    7.206357] pci 0000:00:07.3: PCI bridge to [bus 2d-57]
[    7.206359] pci 0000:00:07.3:   bridge window [io  0x5000-0x5fff]
[    7.206362] pci 0000:00:07.3:   bridge window [mem 0x50000000-0x5c1fffff]
[    7.206365] pci 0000:00:07.3:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    7.206370] pci 0000:00:1c.0: PCI bridge to [bus 58]
[    7.206388] pci 0000:00:1c.0:   bridge window [mem 0x6a400000-0x6a4fffff]
[    7.206395] pci 0000:00:1c.6: PCI bridge to [bus 59]
[    7.206399] pci 0000:00:1c.6:   bridge window [mem 0x6a200000-0x6a3fffff]
[    7.206407] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    7.206409] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    7.206410] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    7.206411] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff window]
[    7.206413] pci_bus 0000:00: resource 8 [mem 0x4f800000-0xbfffffff window]
[    7.206414] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff window]
[    7.206416] pci_bus 0000:01: resource 1 [mem 0x6a500000-0x6a5fffff]
[    7.206417] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    7.206418] pci_bus 0000:02: resource 1 [mem 0x5e000000-0x6a1fffff]
[    7.206419] pci_bus 0000:02: resource 2 [mem 0x6020000000-0x603bffffff 64bit pref]
[    7.206421] pci_bus 0000:2d: resource 0 [io  0x5000-0x5fff]
[    7.206422] pci_bus 0000:2d: resource 1 [mem 0x50000000-0x5c1fffff]
[    7.206423] pci_bus 0000:2d: resource 2 [mem 0x6000000000-0x601bffffff 64bit pref]
[    7.206425] pci_bus 0000:58: resource 1 [mem 0x6a400000-0x6a4fffff]
[    7.206426] pci_bus 0000:59: resource 1 [mem 0x6a200000-0x6a3fffff]
[    7.206519] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    7.207328] PCI: CLS 64 bytes, default 64
[    7.207333] DMAR: Intel-IOMMU force enabled due to platform opt in
[    7.207341] DMAR: No ATSR found
[    7.207342] DMAR: No SATC found
[    7.207344] DMAR: IOMMU feature fl1gp_support inconsistent
[    7.207345] DMAR: IOMMU feature pgsel_inv inconsistent
[    7.207346] DMAR: IOMMU feature nwfs inconsistent
[    7.207347] DMAR: IOMMU feature pds inconsistent
[    7.207347] DMAR: IOMMU feature dit inconsistent
[    7.207348] DMAR: IOMMU feature eafs inconsistent
[    7.207349] DMAR: IOMMU feature prs inconsistent
[    7.207350] DMAR: IOMMU feature nest inconsistent
[    7.207351] DMAR: IOMMU feature mts inconsistent
[    7.207352] DMAR: IOMMU feature sc_support inconsistent
[    7.207352] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    7.207354] DMAR: dmar2: Using Queued invalidation
[    7.207357] DMAR: dmar1: Using Queued invalidation
[    7.207360] DMAR: dmar0: Using Queued invalidation
[    7.207362] DMAR: dmar3: Using Queued invalidation
[    7.207369] Unpacking initramfs...
[    7.207487] pci 0000:00:00.0: Adding to iommu group 0
[    7.207494] pci 0000:00:02.0: Adding to iommu group 1
[    7.207507] pci 0000:00:06.0: Adding to iommu group 2
[    7.207513] pci 0000:00:07.0: Adding to iommu group 3
[    7.207519] pci 0000:00:07.3: Adding to iommu group 4
[    7.207524] pci 0000:00:08.0: Adding to iommu group 5
[    7.207535] pci 0000:00:0d.0: Adding to iommu group 6
[    7.207539] pci 0000:00:0d.2: Adding to iommu group 6
[    7.207544] pci 0000:00:0d.3: Adding to iommu group 6
[    7.207552] pci 0000:00:14.0: Adding to iommu group 7
[    7.207557] pci 0000:00:14.2: Adding to iommu group 7
[    7.207563] pci 0000:00:14.3: Adding to iommu group 8
[    7.207569] pci 0000:00:15.0: Adding to iommu group 9
[    7.207576] pci 0000:00:16.0: Adding to iommu group 10
[    7.207583] pci 0000:00:17.0: Adding to iommu group 11
[    7.207604] pci 0000:00:1c.0: Adding to iommu group 12
[    7.207618] pci 0000:00:1c.6: Adding to iommu group 13
[    7.207629] pci 0000:00:1f.0: Adding to iommu group 14
[    7.207635] pci 0000:00:1f.3: Adding to iommu group 14
[    7.207640] pci 0000:00:1f.4: Adding to iommu group 14
[    7.207646] pci 0000:00:1f.5: Adding to iommu group 14
[    7.207658] pci 0000:01:00.0: Adding to iommu group 15
[    7.207679] pci 0000:58:00.0: Adding to iommu group 16
[    7.207694] pci 0000:59:00.0: Adding to iommu group 17
[    7.207797] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    7.207798] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    7.207800] software IO TLB: mapped [mem 0x000000002b8e0000-0x000000002f8e0000] (64MB)
[    7.207914] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff], which spans more than pnp 00:03 [mem 0xfedc0000-0xfedc7fff]
[    7.207917] caller tgl_uncore_imc_freerunning_init_box+0xb7/0xf0 mapping multiple BARs
[    7.295896] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    7.295961] clocksource: Switched to clocksource tsc
[    7.295974] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    7.296233] Initialise system trusted keyrings
[    7.296243] Key type blacklist registered
[    7.296304] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    7.296925] zbud: loaded
[    7.297108] NFS: Registering the id_resolver key type
[    7.297112] Key type id_resolver registered
[    7.297113] Key type id_legacy registered
[    7.297123] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.297124] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    7.297125] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    7.297228] fuse: init (API version 7.35)
[    7.297306] integrity: Platform Keyring initialized
[    7.304158] NET: Registered PF_ALG protocol family
[    7.304160] xor: automatically using best checksumming function   avx       
[    7.304163] async_tx: api initialized (async)
[    7.304165] Key type asymmetric registered
[    7.304166] Asymmetric key parser 'x509' registered
[    7.304180] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    7.304238] io scheduler mq-deadline registered
[    7.311596] pcieport 0000:00:06.0: PME: Signaling with IRQ 124
[    7.311766] pcieport 0000:00:07.0: PME: Signaling with IRQ 125
[    7.311780] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    7.311995] pcieport 0000:00:07.3: PME: Signaling with IRQ 126
[    7.312008] pcieport 0000:00:07.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    7.374036] Freeing initrd memory: 18860K
[    7.433613] pcieport 0000:00:1c.0: PME: Signaling with IRQ 127
[    7.553623] pcieport 0000:00:1c.6: PME: Signaling with IRQ 128
[    7.553770] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.553957] Monitor-Mwait will be used to enter C-1 state
[    7.553977] Monitor-Mwait will be used to enter C-2 state
[    7.553984] Monitor-Mwait will be used to enter C-3 state
[    7.553988] ACPI: \_SB_.PR00: Found 3 idle states
[    7.554322] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    7.554342] ACPI: button: Sleep Button [SLPB]
[    7.554368] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    7.554383] ACPI: button: Power Button [PWRB]
[    7.554408] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    7.554434] ACPI: button: Power Button [PWRF]
[    7.554678] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1499
[    7.555582] thermal LNXTHERM:00: registered as thermal_zone0
[    7.555585] ACPI: thermal: Thermal Zone [TZ0] (-263 C)
[    7.555925] thermal LNXTHERM:01: registered as thermal_zone1
[    7.555927] ACPI: thermal: Thermal Zone [TZ00] (42 C)
[    7.556031] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.556697] hpet_acpi_add: no address or irqs in _CRS
[    7.556717] Linux agpgart interface v0.103
[    7.556765] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[    7.556880] ACPI: bus type drm_connector registered
[    7.557438] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    7.557443] i915 0000:00:02.0: vgaarb: deactivate vga console
[    7.557481] i915 0000:00:02.0: [drm] Transparent Hugepage mode 'huge=within_size'
[    7.559466] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    7.560098] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/tgl_dmc_ver2_12.bin (v2.12)
[    7.675934] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    7.676759] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    7.677137] acpi device:48: registered as cooling_device11
[    7.677281] acpi device:49: registered as cooling_device12
[    7.677325] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    7.678316] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    7.678571] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    7.678594] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    7.678793] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    7.685735] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops)
[    7.697035] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    7.697349] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    7.703449] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    7.703510] nvme nvme0: pci function 0000:01:00.0
[    7.703525] ahci 0000:00:17.0: version 3.0
[    7.704319] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    7.704322] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds 
[    7.704587] scsi host0: ahci
[    7.704653] scsi host1: ahci
[    7.704684] ata1: SATA max UDMA/133 abar m2048@0x6a602000 port 0x6a602100 irq 131
[    7.704686] ata2: SATA max UDMA/133 abar m2048@0x6a602000 port 0x6a602180 irq 131
[    7.704724] Intel(R) 2.5G Ethernet Linux Driver
[    7.704726] Copyright(c) 2018 Intel Corporation.
[    7.704827] igc 0000:59:00.0: enabling device (0000 -> 0002)
[    7.704977] igc 0000:59:00.0: PTM enabled, 4ns granularity
[    7.711156] nvme nvme0: missing or invalid SUBNQN field.
[    7.711169] nvme nvme0: Shutdown timeout set to 8 seconds
[    7.722664] nvme nvme0: 8/0/0 default/read/poll queues
[    7.724688]  nvme0n1: p1 p2 p3
[    7.755411] pps pps0: new PPS source ptp0
[    7.755540] igc 0000:59:00.0 (unnamed net_device) (uninitialized): PHC added
[    7.820554] igc 0000:59:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    7.820563] igc 0000:59:00.0 eth0: MAC: 1c:69:7a:ac:a4:aa
[    7.820596] Intel(R) Wireless WiFi driver for Linux
[    7.820652] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    7.822734] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-67.ucode failed with error -2
[    7.822746] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-66.ucode failed with error -2
[    7.822755] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-65.ucode failed with error -2
[    7.822762] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-64.ucode failed with error -2
[    7.822770] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-63.ucode failed with error -2
[    7.822778] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-62.ucode failed with error -2
[    7.822785] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-61.ucode failed with error -2
[    7.822793] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-60.ucode failed with error -2
[    7.822800] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-59.ucode failed with error -2
[    7.822808] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-58.ucode failed with error -2
[    7.822816] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-57.ucode failed with error -2
[    7.822824] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-56.ucode failed with error -2
[    7.822832] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-55.ucode failed with error -2
[    7.822839] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-54.ucode failed with error -2
[    7.822848] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-53.ucode failed with error -2
[    7.822856] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-52.ucode failed with error -2
[    7.822864] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-51.ucode failed with error -2
[    7.822872] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-50.ucode failed with error -2
[    7.822879] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-49.ucode failed with error -2
[    7.822887] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-48.ucode failed with error -2
[    7.822895] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-47.ucode failed with error -2
[    7.822903] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-46.ucode failed with error -2
[    7.822910] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-45.ucode failed with error -2
[    7.822918] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-44.ucode failed with error -2
[    7.822927] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-43.ucode failed with error -2
[    7.822935] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-42.ucode failed with error -2
[    7.822942] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-41.ucode failed with error -2
[    7.822949] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-40.ucode failed with error -2
[    7.822957] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-39.ucode failed with error -2
[    7.822960] iwlwifi 0000:00:14.3: no suitable firmware found!
[    7.822962] iwlwifi 0000:00:14.3: minimum version required: iwlwifi-QuZ-a0-hr-b0-39
[    7.822964] iwlwifi 0000:00:14.3: maximum version supported: iwlwifi-QuZ-a0-hr-b0-67
[    7.822966] iwlwifi 0000:00:14.3: check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
[    7.823116] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    7.823121] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[    7.824273] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    7.824810] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[    7.824814] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.824817] usb usb1: Product: xHCI Host Controller
[    7.824818] usb usb1: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[    7.824820] usb usb1: SerialNumber: 0000:00:0d.0
[    7.824921] hub 1-0:1.0: USB hub found
[    7.824926] hub 1-0:1.0: 1 port detected
[    7.825033] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    7.825037] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    7.825039] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
[    7.825066] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[    7.825069] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.825071] usb usb2: Product: xHCI Host Controller
[    7.825073] usb usb2: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[    7.825074] usb usb2: SerialNumber: 0000:00:0d.0
[    7.825159] hub 2-0:1.0: USB hub found
[    7.825169] hub 2-0:1.0: 4 ports detected
[    7.825714] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.825718] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    7.826833] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
[    7.827073] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[    7.827076] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.827078] usb usb3: Product: xHCI Host Controller
[    7.827080] usb usb3: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[    7.827081] usb usb3: SerialNumber: 0000:00:14.0
[    7.827232] hub 3-0:1.0: USB hub found
[    7.827260] hub 3-0:1.0: 12 ports detected
[    7.828095] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.828098] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    7.828099] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    7.828136] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[    7.828138] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.828139] usb usb4: Product: xHCI Host Controller
[    7.828140] usb usb4: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[    7.828141] usb usb4: SerialNumber: 0000:00:14.0
[    7.828259] hub 4-0:1.0: USB hub found
[    7.828278] hub 4-0:1.0: 4 ports detected
[    7.866408] i8042: PNP: No PS/2 controller found.
[    7.866652] mousedev: PS/2 mouse device common for all mice
[    7.867018] usbcore: registered new interface driver synaptics_usb
[    7.867055] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    7.867140] rtc_cmos rtc_cmos: RTC can wake from S4
[    7.868836] rtc_cmos rtc_cmos: registered as rtc0
[    7.869259] rtc_cmos rtc_cmos: setting system clock to 2021-12-21T09:32:03 UTC (1640079123)
[    7.869272] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    7.869497] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    7.869592] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    7.871685] i2c i2c-14: 2/2 memory slots populated (from DMI)
[    7.872808] ee1004 14-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[    7.872811] i2c i2c-14: Successfully instantiated SPD at 0x50
[    7.874493] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[    7.874600] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    7.874607] iTCO_vendor_support: vendor-support=0
[    7.874716] usbcore: registered new interface driver btusb
[    7.874719] intel_pstate: Intel P-state driver initializing
[    7.875240] intel_pstate: HWP enabled
[    7.875244] sdhci: Secure Digital Host Controller Interface driver
[    7.875246] sdhci: Copyright(c) Pierre Ossman
[    7.875257] sdhci-pci 0000:58:00.0: SDHCI controller found [17a0:9755] (rev 0)
[    7.875327] sdhci-pci 0000:58:00.0: enabling device (0000 -> 0002)
[    7.875969] mmc0: SDHCI controller on PCI [0000:58:00.0] using ADMA 64-bit
[    7.876245] ledtrig-cpu: registered to indicate activity on CPUs
[    7.888364] pstore: Registered efi as persistent store backend
[    7.888374] hid: raw HID events driver (C) Jiri Kosina
[    7.888383] usbcore: registered new interface driver usbhid
[    7.888384] usbhid: USB HID core driver
[    7.888460] intel_pmc_core INT33A1:00:  initialized
[    7.888510] intel_rapl_msr: PL4 support detected.
[    7.888601] intel_rapl_common: Found RAPL domain package
[    7.888605] intel_rapl_common: Found RAPL domain core
[    7.888606] intel_rapl_common: Found RAPL domain uncore
[    7.888609] intel_rapl_common: Found RAPL domain psys
[    7.888879] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
[    7.888901] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    7.889121] NET: Registered PF_INET6 protocol family
[    7.889170] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
[    7.893569] Segment Routing with IPv6
[    7.893575] In-situ OAM (IOAM) with IPv6
[    7.893588] mip6: Mobile IPv6
[    7.893589] NET: Registered PF_PACKET protocol family
[    7.893592] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.893593] Bluetooth: BNEP filters: protocol multicast
[    7.893595] Bluetooth: BNEP socket layer initialized
[    7.893739] Key type dns_resolver registered
[    7.893741] mpls_gso: MPLS GSO support
[    7.894374] microcode: sig=0x806c1, pf=0x80, revision=0x72
[    7.894393] microcode: Microcode Update Driver: v2.2.
[    7.894436] resctrl: L2 allocation detected
[    7.894440] IPI shorthand broadcast: enabled
[    7.894445] AVX2 version of gcm_enc/dec engaged.
[    7.894481] AES CTR mode by8 optimization enabled
[    7.894611] sched_clock: Marking stable (7877969249, 16636612)->(7909215074, -14609213)
[    7.894750] registered taskstats version 1
[    7.894752] Loading compiled-in X.509 certificates
[    7.910365] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC256: line_outs=1 (0x21/0x0/0x0/0x0/0x0) type:hp
[    7.910369] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.910371] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.910372] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    7.910374] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    7.910375] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x13
[    7.910376] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[    7.932017] Loaded X.509 cert 'Build time autogenerated kernel key: 03137a584dfb08dfb89c47acef0b1d7589f4ca2a'
[    7.932531] zswap: loaded using pool lzo/zbud
[    7.932672] ------------[ cut here ]------------
[    7.932673] Debug warning: early ioremap leak of 1 areas detected.
               please boot with early_ioremap_debug and report the dmesg.
[    7.932679] WARNING: CPU: 4 PID: 1 at mm/early_ioremap.c:91 check_early_ioremap_leak+0x31/0x39
[    7.932684] Modules linked in:
[    7.932685] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc3+ #13
[    7.932687] Hardware name: Intel(R) Client Systems NUC11PAHi7/NUC11PABi7, BIOS PATGL357.0041.2021.0811.1505 08/11/2021
[    7.932689] RIP: 0010:check_early_ioremap_leak+0x31/0x39
[    7.932691] Code: 31 c0 48 83 3c d5 00 dc 04 84 00 74 02 ff c0 48 ff c2 48 83 fa 08 75 ea 85 c0 74 15 89 c6 48 c7 c7 78 f8 b7 82 e8 b0 7f 1d fe <0f> 0b b8 01 00 00 00 c3 0f 1f 44 00 00 41 57 48 89 f1 41 56 49 89
[    7.932693] RSP: 0000:ffffc90000067e30 EFLAGS: 00010286
[    7.932695] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    7.932696] RDX: 0000000000000001 RSI: 00000000ffffefff RDI: 00000000ffffffff
[    7.932698] RBP: ffffffff83efaee0 R08: 0000000000000000 R09: ffffc90000067c60
[    7.932699] R10: ffffc90000067c58 R11: ffffffff834f8ae8 R12: ffff888101f54d00
[    7.932700] R13: ffffffff8411881c R14: 0000000000000000 R15: 0000000000000000
[    7.932701] FS:  0000000000000000(0000) GS:ffff8884a0500000(0000) knlGS:0000000000000000
[    7.932703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.932704] CR2: 0000000000000000 CR3: 0000000006810001 CR4: 0000000000770ee0
[    7.932706] PKRU: 55555554
[    7.932707] Call Trace:
[    7.932709]  <TASK>
[    7.932710]  do_one_initcall+0x41/0x200
[    7.932714]  kernel_init_freeable+0x21b/0x282
[    7.932717]  ? rest_init+0xd0/0xd0
[    7.932719]  kernel_init+0x16/0x120
[    7.932721]  ret_from_fork+0x1f/0x30
[    7.932723]  </TASK>
[    7.932724] ---[ end trace f899c701f4cdaadd ]---
[    7.932739] Key type ._fscrypt registered
[    7.932741] Key type .fscrypt registered
[    7.932741] Key type fscrypt-provisioning registered
[    7.932849] pstore: Using crash dump compression: deflate
[    7.934871] Key type encrypted registered
[    7.934875] AppArmor: AppArmor sha1 policy hashing enabled
[    7.935463] integrity: Loading X.509 certificate: UEFI:db
[    7.935484] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    7.935486] integrity: Loading X.509 certificate: UEFI:db
[    7.935500] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    7.936419] integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
[    7.936542] integrity: Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    7.936546] ima: No TPM chip found, activating TPM-bypass!
[    7.936549] ima: Allocated hash algorithm: sha256
[    7.936555] ima: No architecture policies found
[    7.936562] evm: Initialising EVM extended attributes:
[    7.936563] evm: security.selinux
[    7.936564] evm: security.SMACK64 (disabled)
[    7.936565] evm: security.SMACK64EXEC (disabled)
[    7.936565] evm: security.SMACK64TRANSMUTE (disabled)
[    7.936566] evm: security.SMACK64MMAP (disabled)
[    7.936567] evm: security.apparmor
[    7.936568] evm: security.ima
[    7.936569] evm: security.capability
[    7.936570] evm: HMAC attrs: 0x1
[    7.963502] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[    7.973814] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input5
[    7.973834] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input6
[    7.973852] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
[    7.973869] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[    7.973885] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[    7.973900] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    7.973917] input: HDA Intel PCH HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    7.973932] input: HDA Intel PCH HDMI/DP,pcm=12 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    7.973948] input: HDA Intel PCH HDMI/DP,pcm=13 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    7.973964] input: HDA Intel PCH HDMI/DP,pcm=14 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    7.973979] input: HDA Intel PCH HDMI/DP,pcm=15 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    7.973994] input: HDA Intel PCH HDMI/DP,pcm=16 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    7.974010] input: HDA Intel PCH HDMI/DP,pcm=17 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    8.019408] ata1: SATA link down (SStatus 4 SControl 300)
[    8.019825] ata2: SATA link down (SStatus 4 SControl 300)
[    8.024660] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.024782] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.024791] ALSA device list:
[    8.024792]   #0: HDA Intel PCH at 0x603d1a0000 irq 148
[    8.027366] Freeing unused decrypted memory: 2036K
[    8.027730] Freeing unused kernel image (initmem) memory: 2800K
[    8.027757] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    8.027760] cfg80211: failed to load regulatory.db
[    8.041023] Write protecting the kernel read-only data: 36864k
[    8.041073] usb usb4-port4: config error
[    8.041607] Freeing unused kernel image (text/rodata gap) memory: 2028K
[    8.041676] Freeing unused kernel image (rodata/data gap) memory: 116K
[    8.049894] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    8.049902] Run /init as init process
[    8.049905]   with arguments:
[    8.049906]     /init
[    8.049908]     force_early_printk
[    8.049910]     nokaslr
[    8.049911]   with environment:
[    8.049913]     HOME=/
[    8.049914]     TERM=linux
[    8.049916]     BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+
[    8.080907] usb 3-5: new full-speed USB device number 2 using xhci_hcd
[    8.112369] igc 0000:59:00.0 enp89s0: renamed from eth0
[    8.213043] usb 3-5: device descriptor read/64, error -71
[    8.453105] usb 3-5: device descriptor read/64, error -71
[    8.688987] usb 3-5: new full-speed USB device number 3 using xhci_hcd
[    8.817073] usb 3-5: device descriptor read/64, error -71
[    9.053226] usb 3-5: device descriptor read/64, error -71
[    9.164962] usb usb3-port5: attempt power cycle
[    9.576973] usb 3-5: new full-speed USB device number 4 using xhci_hcd
[    9.577384] usb 3-5: Device not responding to setup address.
[    9.785290] usb 3-5: Device not responding to setup address.
[    9.992976] usb 3-5: device not accepting address 4, error -71
[   10.120988] usb 3-5: new full-speed USB device number 5 using xhci_hcd
[   10.121300] usb 3-5: Device not responding to setup address.
[   10.329378] usb 3-5: Device not responding to setup address.
[   10.536975] usb 3-5: device not accepting address 5, error -71
[   10.537086] usb usb3-port5: unable to enumerate USB device
[   10.664989] usb 3-10: new full-speed USB device number 6 using xhci_hcd
[   10.816422] usb 3-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
[   10.816437] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   10.819699] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[   10.820663] Bluetooth: hci0: Device revision is 2
[   10.820673] Bluetooth: hci0: Secure boot is enabled
[   10.820677] Bluetooth: hci0: OTP lock is enabled
[   10.820680] Bluetooth: hci0: API lock is enabled
[   10.820683] Bluetooth: hci0: Debug lock is disabled
[   10.820686] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   10.820715] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-0-4.sfi (-2)
[   12.121113] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   12.121187] usb usb4-port4: config error
[   16.193142] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   16.193339] usb usb4-port4: config error
[   20.265103] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   20.265177] usb usb4-port4: config error
[   24.337104] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   24.337188] usb usb4-port4: config error
[   28.409077] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   28.409149] usb usb4-port4: config error
[   32.481086] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   32.481296] usb usb4-port4: config error
[   36.553081] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   36.553152] usb usb4-port4: config error
[   40.625093] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   40.625309] usb usb4-port4: config error
[   40.696018] PM: Image not found (code -22)
[   40.745828] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   40.768429] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[   40.832744] systemd[1]: systemd 249.7-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP -LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   40.832770] systemd[1]: No virtualization found in DMI vendor table.
[   40.832794] systemd[1]: DMI BIOS Extension table does not indicate virtualization.
[   40.849081] systemd[1]: UML virtualization not found in /proc/cpuinfo.
[   40.849101] systemd[1]: No virtualization found in CPUID
[   40.849117] systemd[1]: Virtualization XEN not found, /proc/xen does not exist
[   40.849135] systemd[1]: This platform does not support /proc/device-tree
[   40.849138] systemd[1]: This platform does not support /proc/sysinfo
[   40.849143] systemd[1]: Found VM virtualization none
[   40.849149] systemd[1]: Detected architecture x86-64.
[   40.849276] systemd[1]: Detected initialized system, this is not the first boot.
[   40.849634] systemd[1]: Hostname set to <tigerlake>.
[   40.850179] systemd[1]: Successfully added address 127.0.0.1 to loopback interface
[   40.850189] systemd[1]: Successfully added address ::1 to loopback interface
[   40.850196] systemd[1]: Successfully brought loopback interface up
[   40.850401] systemd[1]: Setting 'fs/file-max' to '9223372036854775807'.
[   40.851105] systemd[1]: Found cgroup2 on /sys/fs/cgroup/, full unified hierarchy
[   40.851113] systemd[1]: Unified cgroup hierarchy is located at /sys/fs/cgroup.
[   40.873383] systemd[1]: Got EBADF when using BPF_F_ALLOW_MULTI, which indicates it is supported. Yay!
[   40.873482] systemd[1]: Controller 'cpu' supported: yes
[   40.873510] systemd[1]: Controller 'cpuacct' supported: no
[   40.873511] systemd[1]: Controller 'cpuset' supported: yes
[   40.873513] systemd[1]: Controller 'io' supported: yes
[   40.873514] systemd[1]: Controller 'blkio' supported: no
[   40.873515] systemd[1]: Controller 'memory' supported: yes
[   40.873517] systemd[1]: Controller 'devices' supported: no
[   40.873518] systemd[1]: Controller 'pids' supported: yes
[   40.873519] systemd[1]: Controller 'bpf-firewall' supported: yes
[   40.873520] systemd[1]: Controller 'bpf-devices' supported: yes
[   40.873522] systemd[1]: Controller 'bpf-foreign' supported: yes
[   40.873523] systemd[1]: Controller 'bpf-socket-bind' supported: no
[   40.873530] systemd[1]: Set up TFD_TIMER_CANCEL_ON_SET timerfd.
[   40.873645] systemd[1]: Enabling (yes) showing of status (commandline).
[   40.873761] systemd[1]: Successfully forked off '(sd-executor)' as PID 371.
[   40.874201] systemd[371]: Successfully forked off '(direxec)' as PID 372.
[   40.874268] systemd[371]: Successfully forked off '(direxec)' as PID 373.
[   40.874332] systemd[371]: Successfully forked off '(direxec)' as PID 374.
[   40.874409] systemd[371]: Successfully forked off '(direxec)' as PID 375.
[   40.874472] systemd[371]: Successfully forked off '(direxec)' as PID 376.
[   40.874538] systemd[371]: Successfully forked off '(direxec)' as PID 377.
[   40.874612] systemd[371]: Successfully forked off '(direxec)' as PID 378.
[   40.874724] systemd[371]: Successfully forked off '(direxec)' as PID 379.
[   40.874831] systemd[371]: Successfully forked off '(direxec)' as PID 380.
[   40.874931] systemd[371]: Successfully forked off '(direxec)' as PID 381.
[   40.875030] systemd[371]: Successfully forked off '(direxec)' as PID 382.
[   40.875141] systemd[371]: Successfully forked off '(direxec)' as PID 383.
[   40.875244] systemd[371]: Successfully forked off '(direxec)' as PID 384.
[   40.877254] systemd-bless-boot-generator[373]: Skipping generator, not booted with boot counting in effect.
[   40.877261] systemd-fstab-generator[376]: Parsing /etc/fstab...
[   40.877311] systemd-fstab-generator[376]: Found entry what=/dev/disk/by-uuid/a652986c-fbc6-4341-85c3-b4ad4402f130 where=/ type=ext4 makefs=no growfs=no noauto=no nofail=no
[   40.877399] systemd-gpt-auto-generator[378]: Disabling root partition auto-detection, root= is defined.
[   40.877426] systemd-gpt-auto-generator[378]: Failed to chase block device '/', ignoring: No such file or directory
[   40.877441] systemd-hibernate-resume-generator[379]: Not running in an initrd, quitting.
[   40.877788] systemd-gpt-auto-generator[378]: nvme0n1p2: Root device /dev/nvme0n1.
[   40.878071] systemd-fstab-generator[376]: SELinux enabled state cached to: disabled
[   40.878493] systemd-fstab-generator[376]: Found entry what=/dev/disk/by-uuid/7F40-7E64 where=/boot/efi type=vfat makefs=no growfs=no noauto=no nofail=no
[   40.878912] systemd-fstab-generator[376]: Checking was requested for /dev/disk/by-uuid/7F40-7E64, but fsck.vfat does not exist.
[   40.878942] systemd-fstab-generator[376]: Found entry what=/dev/disk/by-uuid/63cfb962-43f6-416b-8f7d-dcb57f471473 where=none type=swap makefs=no growfs=no noauto=no nofail=no
[   40.879606] systemd-rc-local-generator[380]: /etc/rc.local does not exist, skipping.
[   40.880629] systemd-sysv-generator[383]: Native unit for procps.service already exists, skipping.
[   40.880851] systemd-sysv-generator[383]: Native unit for smartmontools.service already exists, skipping.
[   40.881066] systemd-sysv-generator[383]: Native unit for lvm2-lvmpolld.service already exists, skipping.
[   40.881227] systemd-sysv-generator[383]: Native unit for dbus.service already exists, skipping.
[   40.881295] systemd-sysv-generator[383]: Native unit for cron.service already exists, skipping.
[   40.881320] systemd-sysv-generator[383]: Native unit for hwclock.service already exists, skipping.
[   40.881386] systemd-sysv-generator[383]: Native unit for console-setup.service already exists, skipping.
[   40.881410] systemd-sysv-generator[383]: Native unit for sudo.service already exists, skipping.
[   40.881544] systemd-sysv-generator[383]: Native unit for udev.service already exists, skipping.
[   40.881610] systemd-sysv-generator[383]: Native unit for rsync.service already exists, skipping.
[   40.881901] systemd-sysv-generator[383]: Native unit for nfs-common.service already exists, skipping.
[   40.881927] systemd-sysv-generator[383]: Native unit for x11-common.service already exists, skipping.
[   40.881992] systemd-sysv-generator[383]: Native unit for acpid.service already exists, skipping.
[   40.882058] systemd-sysv-generator[383]: Native unit for uuidd.service already exists, skipping.
[   40.882331] systemd-gpt-auto-generator[378]: swap specified in fstab, ignoring.
[   40.882359] systemd-gpt-auto-generator[378]: "/boot" already populated, ignoring.
[   40.882382] systemd-sysv-generator[383]: Native unit for apparmor.service already exists, skipping.
[   40.882401] systemd-sysv-generator[383]: Native unit for live-tools.service already exists, skipping.
[   40.882424] systemd-sysv-generator[383]: Native unit for alsa-utils.service already exists, skipping.
[   40.882490] systemd-sysv-generator[383]: Native unit for bluetooth.service already exists, skipping.
[   40.882551] systemd-sysv-generator[383]: Native unit for ssh.service already exists, skipping.
[   40.882608] systemd-sysv-generator[383]: Native unit for anacron.service already exists, skipping.
[   40.882663] systemd-sysv-generator[383]: Native unit for keyboard-setup.service already exists, skipping.
[   40.882718] systemd-sysv-generator[383]: Native unit for networking.service already exists, skipping.
[   40.882729] systemd-sysv-generator[383]: Cannot find unit exim4.service.
[   40.882732] systemd-sysv-generator[383]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[   40.882753] systemd-sysv-generator[383]: Native unit for lvm2.service already exists, skipping.
[   40.882774] systemd-sysv-generator[383]: Native unit for mdadm-waitidle.service already exists, skipping.
[   40.882829] systemd-sysv-generator[383]: Native unit for rpcbind.service already exists, skipping.
[   40.882850] systemd-sysv-generator[383]: Native unit for mdadm.service already exists, skipping.
[   40.882967] systemd-sysv-generator[383]: Native unit for kmod.service already exists, skipping.
[   40.883021] systemd-sysv-generator[383]: Native unit for sysstat.service already exists, skipping.
[   40.883078] systemd-sysv-generator[383]: Native unit for lm-sensors.service already exists, skipping.
[   40.883309] systemd-sysv-generator[383]: Ignoring S01cron symlink in rc2.d, not generating cron.service.
[   40.883312] systemd-sysv-generator[383]: Ignoring S01mdadm symlink in rc2.d, not generating mdadm.service.
[   40.883314] systemd-sysv-generator[383]: Ignoring S01lvm2-lvmpolld symlink in rc2.d, not generating lvm2-lvmpolld.service.
[   40.883316] systemd-sysv-generator[383]: Ignoring S01bluetooth symlink in rc2.d, not generating bluetooth.service.
[   40.883319] systemd-sysv-generator[383]: Ignoring S01rsync symlink in rc2.d, not generating rsync.service.
[   40.883321] systemd-sysv-generator[383]: Ignoring S01sudo symlink in rc2.d, not generating sudo.service.
[   40.883322] systemd-sysv-generator[383]: Ignoring S01dbus symlink in rc2.d, not generating dbus.service.
[   40.883324] systemd-sysv-generator[383]: Ignoring S01sysstat symlink in rc2.d, not generating sysstat.service.
[   40.883327] systemd-sysv-generator[383]: Ignoring S01uuidd symlink in rc2.d, not generating uuidd.service.
[   40.883329] systemd-sysv-generator[383]: Ignoring S01anacron symlink in rc2.d, not generating anacron.service.
[   40.883331] systemd-sysv-generator[383]: Ignoring S01acpid symlink in rc2.d, not generating acpid.service.
[   40.883333] systemd-sysv-generator[383]: Ignoring S01ssh symlink in rc2.d, not generating ssh.service.
[   40.883335] systemd-sysv-generator[383]: Ignoring S01console-setup.sh symlink in rc2.d, not generating console-setup.service.
[   40.883337] systemd-sysv-generator[383]: Ignoring S01smartmontools symlink in rc2.d, not generating smartmontools.service.
[   40.883476] systemd-sysv-generator[383]: Ignoring S01cron symlink in rc3.d, not generating cron.service.
[   40.883479] systemd-sysv-generator[383]: Ignoring S01mdadm symlink in rc3.d, not generating mdadm.service.
[   40.883481] systemd-sysv-generator[383]: Ignoring S01lvm2-lvmpolld symlink in rc3.d, not generating lvm2-lvmpolld.service.
[   40.883483] systemd-sysv-generator[383]: Ignoring S01bluetooth symlink in rc3.d, not generating bluetooth.service.
[   40.883485] systemd-sysv-generator[383]: Ignoring S01rsync symlink in rc3.d, not generating rsync.service.
[   40.883487] systemd-sysv-generator[383]: Ignoring S01sudo symlink in rc3.d, not generating sudo.service.
[   40.883489] systemd-sysv-generator[383]: Ignoring S01dbus symlink in rc3.d, not generating dbus.service.
[   40.883491] systemd-sysv-generator[383]: Ignoring S01sysstat symlink in rc3.d, not generating sysstat.service.
[   40.883493] systemd-sysv-generator[383]: Ignoring S01uuidd symlink in rc3.d, not generating uuidd.service.
[   40.883495] systemd-sysv-generator[383]: Ignoring S01anacron symlink in rc3.d, not generating anacron.service.
[   40.883497] systemd-sysv-generator[383]: Ignoring S01acpid symlink in rc3.d, not generating acpid.service.
[   40.883499] systemd-sysv-generator[383]: Ignoring S01ssh symlink in rc3.d, not generating ssh.service.
[   40.883501] systemd-sysv-generator[383]: Ignoring S01console-setup.sh symlink in rc3.d, not generating console-setup.service.
[   40.883503] systemd-sysv-generator[383]: Ignoring S01smartmontools symlink in rc3.d, not generating smartmontools.service.
[   40.883665] systemd-sysv-generator[383]: Ignoring S01cron symlink in rc4.d, not generating cron.service.
[   40.883667] systemd-sysv-generator[383]: Ignoring S01mdadm symlink in rc4.d, not generating mdadm.service.
[   40.883669] systemd-sysv-generator[383]: Ignoring S01lvm2-lvmpolld symlink in rc4.d, not generating lvm2-lvmpolld.service.
[   40.883671] systemd-sysv-generator[383]: Ignoring S01bluetooth symlink in rc4.d, not generating bluetooth.service.
[   40.883673] systemd-sysv-generator[383]: Ignoring S01rsync symlink in rc4.d, not generating rsync.service.
[   40.883675] systemd-sysv-generator[383]: Ignoring S01sudo symlink in rc4.d, not generating sudo.service.
[   40.883677] systemd-sysv-generator[383]: Ignoring S01dbus symlink in rc4.d, not generating dbus.service.
[   40.883679] systemd-sysv-generator[383]: Ignoring S01sysstat symlink in rc4.d, not generating sysstat.service.
[   40.883681] systemd-sysv-generator[383]: Ignoring S01uuidd symlink in rc4.d, not generating uuidd.service.
[   40.883683] systemd-sysv-generator[383]: Ignoring S01anacron symlink in rc4.d, not generating anacron.service.
[   40.883685] systemd-sysv-generator[383]: Ignoring S01acpid symlink in rc4.d, not generating acpid.service.
[   40.883687] systemd-sysv-generator[383]: Ignoring S01ssh symlink in rc4.d, not generating ssh.service.
[   40.883689] systemd-sysv-generator[383]: Ignoring S01console-setup.sh symlink in rc4.d, not generating console-setup.service.
[   40.883691] systemd-sysv-generator[383]: Ignoring S01smartmontools symlink in rc4.d, not generating smartmontools.service.
[   40.883767] systemd-sysv-generator[383]: Ignoring S01cron symlink in rc5.d, not generating cron.service.
[   40.883770] systemd-sysv-generator[383]: Ignoring S01mdadm symlink in rc5.d, not generating mdadm.service.
[   40.883772] systemd-sysv-generator[383]: Ignoring S01lvm2-lvmpolld symlink in rc5.d, not generating lvm2-lvmpolld.service.
[   40.883774] systemd-sysv-generator[383]: Ignoring S01bluetooth symlink in rc5.d, not generating bluetooth.service.
[   40.883775] systemd-sysv-generator[383]: Ignoring S01rsync symlink in rc5.d, not generating rsync.service.
[   40.883777] systemd-sysv-generator[383]: Ignoring S01sudo symlink in rc5.d, not generating sudo.service.
[   40.883779] systemd-sysv-generator[383]: Ignoring S01dbus symlink in rc5.d, not generating dbus.service.
[   40.883781] systemd-sysv-generator[383]: Ignoring S01sysstat symlink in rc5.d, not generating sysstat.service.
[   40.883783] systemd-sysv-generator[383]: Ignoring S01uuidd symlink in rc5.d, not generating uuidd.service.
[   40.883785] systemd-sysv-generator[383]: Ignoring S01anacron symlink in rc5.d, not generating anacron.service.
[   40.883787] systemd-sysv-generator[383]: Ignoring S01acpid symlink in rc5.d, not generating acpid.service.
[   40.883789] systemd-sysv-generator[383]: Ignoring S01ssh symlink in rc5.d, not generating ssh.service.
[   40.883791] systemd-sysv-generator[383]: Ignoring S01console-setup.sh symlink in rc5.d, not generating console-setup.service.
[   40.883793] systemd-sysv-generator[383]: Ignoring S01smartmontools symlink in rc5.d, not generating smartmontools.service.
[   40.883799] systemd-sysv-generator[383]: Loading SysV script /etc/init.d/exim4
[   40.884065] systemd-sysv-generator[383]: SELinux enabled state cached to: disabled
[   40.884285] systemd[371]: /usr/lib/systemd/system-generators/systemd-sysv-generator succeeded.
[   40.884295] systemd[371]: /usr/lib/systemd/system-generators/systemd-hibernate-resume-generator succeeded.
[   40.884301] systemd[371]: /usr/lib/systemd/system-generators/systemd-system-update-generator succeeded.
[   40.891311] systemd[371]: /usr/lib/systemd/system-generators/lvm2-activation-generator succeeded.
[   40.891321] systemd[371]: /usr/lib/systemd/system-generators/systemd-gpt-auto-generator succeeded.
[   40.891327] systemd[371]: /usr/lib/systemd/system-generators/systemd-bless-boot-generator succeeded.
[   40.891332] systemd[371]: /usr/lib/systemd/system-generators/systemd-veritysetup-generator succeeded.
[   40.891337] systemd[371]: /usr/lib/systemd/system-generators/systemd-debug-generator succeeded.
[   40.891342] systemd[371]: /usr/lib/systemd/system-generators/systemd-rc-local-generator succeeded.
[   40.891347] systemd[371]: /usr/lib/systemd/system-generators/systemd-run-generator succeeded.
[   40.891352] systemd[371]: /usr/lib/systemd/system-generators/systemd-cryptsetup-generator succeeded.
[   40.891357] systemd[371]: /usr/lib/systemd/system-generators/systemd-getty-generator succeeded.
[   40.891363] systemd[371]: /usr/lib/systemd/system-generators/systemd-fstab-generator succeeded.
[   40.891521] systemd[1]: (sd-executor) succeeded.
[   40.891538] systemd[1]: Looking for unit files in (higher priority first):
[   40.891540] systemd[1]: 	/etc/systemd/system.control
[   40.891541] systemd[1]: 	/run/systemd/system.control
[   40.891542] systemd[1]: 	/run/systemd/transient
[   40.891543] systemd[1]: 	/run/systemd/generator.early
[   40.891544] systemd[1]: 	/etc/systemd/system
[   40.891545] systemd[1]: 	/etc/systemd/system.attached
[   40.891547] systemd[1]: 	/run/systemd/system
[   40.891548] systemd[1]: 	/run/systemd/system.attached
[   40.891549] systemd[1]: 	/run/systemd/generator
[   40.891550] systemd[1]: 	/usr/local/lib/systemd/system
[   40.891551] systemd[1]: 	/lib/systemd/system
[   40.891552] systemd[1]: 	/usr/lib/systemd/system
[   40.891553] systemd[1]: 	/run/systemd/generator.late
[   40.892413] systemd[1]: Modification times have changed, need to update cache.
[   40.892455] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-org.bluez.service \xe2\x86\x92 bluetooth.service
[   40.892477] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-org.freedesktop.timesync1.service \xe2\x86\x92 systemd-timesyncd.service
[   40.892496] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-fi.w1.wpa_supplicant1.service \xe2\x86\x92 wpa_supplicant.service
[   40.892516] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/smartd.service \xe2\x86\x92 smartmontools.service
[   40.892535] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/sshd.service \xe2\x86\x92 ssh.service
[   40.892561] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/syslog.service \xe2\x86\x92 rsyslog.service
[   40.892573] systemd[1]: unit_file_build_name_map: linked unit file: /etc/systemd/system/live-tools.service \xe2\x86\x92 /dev/null
[   40.892591] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/dev-disk-by\x2duuid-63cfb962\x2d43f6\x2d416b\x2d8f7d\x2ddcb57f471473.swap
[   40.892594] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/boot-efi.mount
[   40.892607] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/-.mount
[   40.892690] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpcbind.socket
[   40.892699] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/hwclock.service \xe2\x86\x92 /dev/null
[   40.892703] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat-collect.timer
[   40.892709] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/machine.slice
[   40.892712] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-sysext.service
[   40.892715] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd-wait-online.service
[   40.892718] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-cleanup.service
[   40.892722] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-modules-load.service
[   40.892726] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/hibernate.target
[   40.892729] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald-dev-log.socket
[   40.892732] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-pstore.service
[   40.892736] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-udevd-control.socket
[   40.892740] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/powertop.service
[   40.892744] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-ask-password-console.path
[   40.892747] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald-audit.socket
[   40.892754] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-cryptsetup.target
[   40.892757] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd.service
[   40.892760] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/anacron.timer
[   40.892763] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald.socket
[   40.892767] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/uuidd.socket
[   40.892783] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/printer.target
[   40.892786] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-volatile-root.service
[   40.892789] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nss-lookup.target
[   40.892792] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/alsa-restore.service
[   40.892811] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/default.target \xe2\x86\x92 graphical.target
[   40.892814] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/kexec.target
[   40.892817] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nss-user-lookup.target
[   40.892820] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/exim4-base.timer
[   40.892831] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/rcS.service \xe2\x86\x92 /dev/null
[   40.892834] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald@.service
[   40.892838] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-fs.target
[   40.892847] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/cryptdisks.service \xe2\x86\x92 /dev/null
[   40.892851] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-suspend-then-hibernate.service
[   40.892863] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/suspend.target
[   40.892868] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-reboot.service
[   40.892871] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-parse-etc.service
[   40.892875] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpcbind.service
[   40.892878] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-resolved.service
[   40.892882] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/apt-daily.service
[   40.892891] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rsync.service
[   40.892894] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sys-fs-fuse-connections.mount
[   40.892897] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/time-sync.target
[   40.892900] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-timedated.service
[   40.892903] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/apt-daily-upgrade.timer
[   40.892907] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-boot-system-token.service
[   40.892911] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sleep.target
[   40.892914] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/local-fs-pre.target
[   40.892918] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-setup.service
[   40.892921] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysinit.target
[   40.892925] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/modprobe@.service
[   40.892928] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub@.service
[   40.892931] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd.socket
[   40.892935] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/mdcheck_start.timer
[   40.892938] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/bluetooth.target
[   40.892949] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/x11-common.service \xe2\x86\x92 /dev/null
[   40.892952] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/mdadm-grow-continue@.service
[   40.892956] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-sysusers.service
[   40.892959] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/acpid.socket
[   40.892961] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat.service
[   40.892982] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/autovt@.service \xe2\x86\x92 getty@.service
[   40.893002] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.hostname1.service \xe2\x86\x92 systemd-hostnamed.service
[   40.893006] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/timers.target
[   40.893009] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/anacron.service
[   40.893034] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sound.target
[   40.893038] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-time-wait-sync.service
[   40.893041] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-root-device.target
[   40.893059] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.locale1.service \xe2\x86\x92 systemd-localed.service
[   40.893063] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_all.service
[   40.893067] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rescue-ssh.target
[   40.893070] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd.target
[   40.893073] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-exit.service
[   40.893076] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_all.timer
[   40.893079] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-fs.target
[   40.893082] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/cron.service
[   40.893085] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nfs-idmapd.service
[   40.893088] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-ask-password-wall.path
[   40.893091] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-setup-dev.service
[   40.893095] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-clean.service
[   40.893098] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-hibernate.service
[   40.893101] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/console-setup.service
[   40.893104] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/system-update.target
[   40.893107] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/emergency.service
[   40.893110] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/halt.target
[   40.893113] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lvm2-lvmpolld.socket
[   40.893122] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/lvm2.service \xe2\x86\x92 /dev/null
[   40.893140] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/runlevel5.target \xe2\x86\x92 graphical.target
[   40.893143] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/getty-pre.target
[   40.893163] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/alsa-utils.service \xe2\x86\x92 /dev/null
[   40.893166] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-update-utmp-runlevel.service
[   40.893170] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/user-runtime-dir@.service
[   40.893173] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/run-qemu.mount
[   40.893176] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/boot-complete.target
[   40.893179] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ssh@.service
[   40.893182] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-clean.timer
[   40.893186] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/shutdown.target
[   40.893188] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-binfmt.service
[   40.893192] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-switch-root.service
[   40.893210] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/ctrl-alt-del.target \xe2\x86\x92 reboot.target
[   40.893213] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sys-kernel-tracing.mount
[   40.893216] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/basic.target
[   40.893220] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-machine-id-commit.service
[   40.893223] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/auth-rpcgss-module.service
[   40.893226] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-timesyncd.service
[   40.893231] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/dbus.socket
[   40.893234] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat-summary.timer
[   40.893253] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.timedate1.service \xe2\x86\x92 systemd-timedated.service
[   40.893256] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpc-statd-notify.service
[   40.893259] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/getty.target
[   40.893262] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-suspend.service
[   40.893277] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/kmod.service \xe2\x86\x92 systemd-modules-load.service
[   40.893281] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journal-flush.service
[   40.893284] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-initctl.service
[   40.893287] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-veritysetup.target
[   40.893291] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-fs-pre.target
[   40.893295] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ssh.socket
[   40.893298] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/veritysetup.target
[   40.893301] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lvm2-lvmpolld.service
[   40.893304] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-remount-fs.service
[   40.893308] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/swap.target
[   40.893311] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpc-statd.service
[   40.893314] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-rfkill.socket
[   40.893317] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-user-sessions.service
[   40.893320] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-switch-root.target
[   40.893324] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-rfkill.service
[   40.893327] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rc-local.service
[   40.893331] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/man-db.service
[   40.893334] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ifupdown-pre.service
[   40.893338] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/logrotate.service
[   40.893341] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-fsckd.socket
[   40.893364] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/runlevel3.target \xe2\x86\x92 multi-user.target
[   40.893367] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_reap.service
[   40.893371] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-root-fs.target
[   40.893374] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/run-rpc_pipefs.mount
[   40.893377] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/veritysetup-pre.target
[   40.893381] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/uuidd.service
[   40.893385] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/network-online.target
[   40.893388] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/blockdev@.target
[   40.893392] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/bluetooth.service
[   40.893395] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lm-sensors.service
[   40.893398] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/local-fs.target
[   40.946136] EXT4-fs (nvme0n1p2): re-mounted. Opts: errors=remount-ro. Quota mode: none.
[   40.947631] systemd-journald[402]: SELinux enabled state cached to: disabled
[   40.947651] systemd-journald[402]: Auditing in kernel turned off.
[   40.948602] systemd-journald[402]: Journal effective settings seal=no keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   40.948626] systemd-journald[402]: Fixed min_use=16.0M max_use=156.1M max_size=19.5M min_size=512.0K keep_free=78.0M n_max_files=100
[   40.948639] systemd-journald[402]: Reserving 333 entries in field hash table.
[   40.949983] systemd-journald[402]: Reserving 35534 entries in data hash table.
[   40.950127] systemd-journald[402]: Vacuuming...
[   40.950135] systemd-journald[402]: Vacuuming done, freed 0B of archived journals from /run/log/journal/3aa984411adf418abc91217f7a356b70.
[   40.950141] systemd-journald[402]: Flushing /dev/kmsg...
[   40.972233] systemd-journald[402]: systemd-journald running as PID 402 for the system.
[   40.972311] systemd-journald[402]: Sent READY=1 notification.
[   40.972324] systemd-journald[402]: Sent WATCHDOG=1 notification.
[   40.972469] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.972560] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.972625] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.972688] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.972749] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.972813] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.972958] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973020] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973082] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973141] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973206] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973270] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973352] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973401] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973450] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973497] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973562] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.973816] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.974035] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.974104] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.974169] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.974210] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   40.975433] systemd-journald[402]: varlink: New incoming connection.
[   40.975442] systemd-journald[402]: varlink-22: Setting state idle-server
[   40.975472] systemd-journald[402]: varlink-22: New incoming message: {"method":"io.systemd.Journal.FlushToVar","parameters":{}}
[   40.975485] systemd-journald[402]: varlink-22: Changing state idle-server \xe2\x86\x92 processing-method
[   40.975488] systemd-journald[402]: Received client request to flush runtime journal.
[   40.975894] systemd-journald[402]: Journal effective settings seal=yes keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   40.976539] systemd-journald[402]: Fixed min_use=16.0M max_use=4.0G max_size=128.0M min_size=512.0K keep_free=4.0G n_max_files=100
[   40.980142] systemd-journald[402]: Flushing to /var/log/journal/3aa984411adf418abc91217f7a356b70...
[   40.980147] systemd-journald[402]: Considering root directory '/run/log/journal'.
[   40.980155] systemd-journald[402]: Root directory /run/log/journal added.
[   40.980160] systemd-journald[402]: Considering directory '/run/log/journal/3aa984411adf418abc91217f7a356b70'.
[   40.980167] systemd-journald[402]: Directory /run/log/journal/3aa984411adf418abc91217f7a356b70 added.
[   40.980174] systemd-journald[402]: Journal effective settings seal=no keyed_hash=yes compress=no compress_threshold_bytes=8B
[   40.980186] systemd-journald[402]: File /run/log/journal/3aa984411adf418abc91217f7a356b70/system.journal added.
[   40.980190] systemd-journald[402]: Considering root directory '/var/log/journal'.
[   40.980192] systemd-journald[402]: Considering root directory '/var/log/journal/remote'.
[   41.103359] systemd-journald[402]: Directory /run/log/journal/3aa984411adf418abc91217f7a356b70 removed.
[   41.103365] systemd-journald[402]: Root directory /run/log/journal removed.
[   41.103368] systemd-journald[402]: mmap cache statistics: 87711 context cache hit, 3 window list hit, 1 miss
[   41.103377] systemd-journald[402]: Journal effective settings seal=no keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   41.103446] systemd-journald[402]: Vacuuming...
[   41.109161] systemd-journald[402]: Vacuuming done, freed 0B of archived journals from /var/log/journal/3aa984411adf418abc91217f7a356b70.
[   41.109896] systemd-journald[402]: varlink-22: Sending message: {"parameters":{}}
[   41.109899] systemd-journald[402]: varlink-22: Changing state processing-method \xe2\x86\x92 processed-method
[   41.109901] systemd-journald[402]: varlink-22: Changing state processed-method \xe2\x86\x92 idle-server
[   41.110137] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.110923] systemd-journald[402]: varlink-22: Got POLLHUP from socket.
[   41.110928] systemd-journald[402]: varlink-22: Changing state idle-server \xe2\x86\x92 pending-disconnect
[   41.110931] systemd-journald[402]: varlink-22: Changing state pending-disconnect \xe2\x86\x92 processing-disconnect
[   41.110933] systemd-journald[402]: varlink-22: Changing state processing-disconnect \xe2\x86\x92 disconnected
[   41.275362] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.276173] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.292218] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.293214] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.293824] Adding 999420k swap on /dev/nvme0n1p3.  Priority:-2 extents:1 across:999420k SSFS
[   41.309824] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.310868] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.312553] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.315882] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.324089] audit: type=1400 audit(1640079156.948:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=467 comm="apparmor_parser"
[   41.324474] audit: type=1400 audit(1640079156.948:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=468 comm="apparmor_parser"
[   41.324479] audit: type=1400 audit(1640079156.948:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=468 comm="apparmor_parser"
[   41.324751] audit: type=1400 audit(1640079156.948:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=469 comm="apparmor_parser"
[   41.324755] audit: type=1400 audit(1640079156.948:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=469 comm="apparmor_parser"
[   41.324757] audit: type=1400 audit(1640079156.948:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=469 comm="apparmor_parser"
[   41.346363] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.383207] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.386298] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.388747] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.439786] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.480685] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.481186] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.481720] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.482276] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.484391] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.485106] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.486249] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.486818] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.487883] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.488368] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.490267] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.495965] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   41.514250] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   44.701121] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   44.701198] usb usb4-port4: config error
[   44.915859] igc 0000:59:00.0 enp89s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   44.917112] IPv6: ADDRCONF(NETDEV_CHANGE): enp89s0: link becomes ready
[   48.773113] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   48.773346] usb usb4-port4: config error
[   52.845122] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   52.845200] usb usb4-port4: config error
[   53.579329] igc 0000:59:00.0 enp89s0: NIC Link is Down
[   56.917130] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   56.917347] usb usb4-port4: config error
[   56.952249] igc 0000:59:00.0 enp89s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   60.989087] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   60.989163] usb usb4-port4: config error
[   65.061082] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   65.061318] usb usb4-port4: config error
[   69.133094] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   69.133168] usb usb4-port4: config error
[   73.237427] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   73.237633] usb usb4-port4: config error
[   77.425429] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   77.425503] usb usb4-port4: config error
[   78.769529] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   81.564031] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   81.564203] usb usb4-port4: config error
[   81.579989] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   81.728053] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   81.730093] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   81.731753] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   81.745599] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   81.800094] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   81.819268] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   82.126924] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   82.131068] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   82.225595] systemd-journald[402]: Successfully sent stream file descriptor to service manager.
[   85.682377] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   85.682444] usb usb4-port4: config error
[   89.776659] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   89.776724] usb usb4-port4: config error
[   93.861429] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   93.861493] usb usb4-port4: config error
[   97.940895] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   97.940958] usb usb4-port4: config error
[  102.017222] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  102.017286] usb usb4-port4: config error
[  106.090870] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  106.090932] usb usb4-port4: config error
[  110.162155] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  110.162220] usb usb4-port4: config error
[  114.233542] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  114.233606] usb usb4-port4: config error
[  118.305084] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  118.305148] usb usb4-port4: config error
[  122.376690] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  122.376752] usb usb4-port4: config error
[  126.448373] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  126.448438] usb usb4-port4: config error
[  130.520111] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  130.520175] usb usb4-port4: config error
[  134.591879] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  134.591940] usb usb4-port4: config error
[  134.596138] systemd-journald[402]: Sent WATCHDOG=1 notification.
[  138.663696] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  138.663758] usb usb4-port4: config error
[  142.735511] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  142.735575] usb usb4-port4: config error
[  146.807356] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  146.807418] usb usb4-port4: config error
[  150.879223] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  150.879287] usb usb4-port4: config error
[  154.951089] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  154.951154] usb usb4-port4: config error
[  159.022964] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  159.023027] usb usb4-port4: config error
[  163.094847] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  163.094910] usb usb4-port4: config error
[  167.166732] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  167.166793] usb usb4-port4: config error
[  171.238875] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  171.238939] usb usb4-port4: config error
[  175.311163] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  175.311230] usb usb4-port4: config error
[  179.383360] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  179.383425] usb usb4-port4: config error
[  183.455547] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  183.455610] usb usb4-port4: config error
[  187.531730] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  187.531796] usb usb4-port4: config error
[  191.603853] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  191.603918] usb usb4-port4: config error
[  195.675961] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  195.676023] usb usb4-port4: config error
[  199.748056] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  199.748119] usb usb4-port4: config error
[  203.820140] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  203.820205] usb usb4-port4: config error
[  207.892200] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  207.892264] usb usb4-port4: config error
[  211.964250] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  211.964314] usb usb4-port4: config error
[  216.036288] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  216.036353] usb usb4-port4: config error
[  220.108311] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  220.108374] usb usb4-port4: config error
[  224.180332] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  224.180395] usb usb4-port4: config error
[  224.184632] systemd-journald[402]: Sent WATCHDOG=1 notification.
[  228.252325] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  228.252390] usb usb4-port4: config error
[  232.324344] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  232.324407] usb usb4-port4: config error
[  236.396346] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  236.396411] usb usb4-port4: config error
[  240.468306] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  240.468369] usb usb4-port4: config error
[  244.540316] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  244.540382] usb usb4-port4: config error
[  248.612296] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  248.612360] usb usb4-port4: config error
[  252.684264] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  252.684328] usb usb4-port4: config error
[  256.756247] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  256.756312] usb usb4-port4: config error
[  260.828203] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  260.828265] usb usb4-port4: config error
[  264.900164] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  264.900231] usb usb4-port4: config error
[  268.972144] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  268.972208] usb usb4-port4: config error
[  273.044099] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  273.044163] usb usb4-port4: config error
[  277.116054] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  277.116115] usb usb4-port4: config error
[  281.187999] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  281.188060] usb usb4-port4: config error
[  285.259966] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  285.260030] usb usb4-port4: config error
[  289.331922] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  289.331986] usb usb4-port4: config error
[  293.403888] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  293.403952] usb usb4-port4: config error
[  297.475900] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  297.475963] usb usb4-port4: config error
[  301.548083] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  301.548150] usb usb4-port4: config error
[  305.620224] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  305.620290] usb usb4-port4: config error
[  309.696398] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  309.696463] usb usb4-port4: config error
[  313.768552] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  313.768617] usb usb4-port4: config error
[  313.772813] systemd-journald[402]: Sent WATCHDOG=1 notification.
[  317.840675] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  317.840740] usb usb4-port4: config error
[  321.912786] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  321.912853] usb usb4-port4: config error
[  325.984897] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  325.984960] usb usb4-port4: config error
[  330.057003] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  330.057069] usb usb4-port4: config error
[  334.129083] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  334.129146] usb usb4-port4: config error
[  338.201168] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  338.201233] usb usb4-port4: config error

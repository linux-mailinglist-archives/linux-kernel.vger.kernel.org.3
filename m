Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95B55FD46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiF2K1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiF2K11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27F6436B5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656498442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/6A5g0UIX+w5x2ib6cynKHcUdmJcl5fJanHugCow3M=;
        b=WrAE8n5H7oEnMYEbASSdbgr3892fkqx8jxp/Us8767EyhSIugGW6ZtYCx06X5aEtjMESp7
        DksNPUK5YJk08+9XAZoxXIpPqyigqMW9Hj8WOVWS3jfI/mGw1h5Qjvrs+96B1GckvnJnO/
        7TPpCYm3wdPoocYvuDr9PUQ3SzC1H1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-FodiIvpHOGejBxMvxqNLBQ-1; Wed, 29 Jun 2022 06:27:16 -0400
X-MC-Unique: FodiIvpHOGejBxMvxqNLBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 598A8804191;
        Wed, 29 Jun 2022 10:27:16 +0000 (UTC)
Received: from localhost (ovpn-12-201.pek2.redhat.com [10.72.12.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FDEB492CA9;
        Wed, 29 Jun 2022 10:27:12 +0000 (UTC)
Date:   Wed, 29 Jun 2022 18:27:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org
Subject: Re: Unstable tsc caused soft lockup in kdump kernel
Message-ID: <Yrwo/pu8MPK1cFTe@MiWiFi-R3L-srv>
References: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/22 at 06:25pm, Baoquan He wrote:
> Hi,
> 
> On a HP machine, after crash triggered via sysrq-c, kdump kernel will
> boot and get soft lockup as below. And this can be always reproduced.
> 
> From log, it seems that unreliable tsc was marked as unstable in
> clocksource_watchdog, then worker sched_clock_work was scheduled. And
> this tsc unstable marking always happened after sysrq-c is triggered.
> And the cpu where worker smp_call_function_many_cond is running won't
> be stopped and hang there and keep locks, even though the cpu should be
> stopped. While kdump kernel is running in a different cpu and boot, then
> soft lockup happened because other workers or the relevant threads are
> waiting for locks taken by the hang sched_clock_work worker.

Forget mentioning that adding 'tsc=unstable' to 1st kernel can work
around this issue to make kdump kernel work well.

> 
> Any idea or suggestion?
> 
> The normal kernel boot log and kdump kernel log, kernel config, are all
> attached, please check.
> 
> Thanks
> Baoquan
> 
> =====
> [ 5173.871886] watchdog: BUG: soft lockup - CPU#43 stuck for 52s! [kworker/43:2:1375]
> [ 5173.871886] Modules linked in: qrtr ......
> [ 5173.871886] irq event stamp: 120854
> [ 5173.871886] hardirqs last  enabled at (120853): [<ffffffffa1a00d0b>] asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [ 5173.871886] hardirqs last disabled at (120854): [<ffffffffa19a975b>] sysvec_apic_timer_interrupt+0xb/0x90
> [ 5173.871886] softirqs last  enabled at (120850): [<ffffffffa1c00319>] __do_softirq+0x319/0x44a
> [ 5173.871886] softirqs last disabled at (120845): [<ffffffffa0ef574b>] __irq_exit_rcu+0xbb/0xf0
> [ 5173.871886] CPU: 43 PID: 1375 Comm: kworker/43:2 Kdump: loaded Tainted: G             L    5.19.0-rc2+ #5
> [ 5173.871886] Hardware name: HP ProLiant DL585 G7, BIOS A16 06/04/2013
> [ 5173.871886] Workqueue: events __sched_clock_work
> [ 5173.871886] RIP: 0010:smp_call_function_many_cond+0x133/0x380
> [ 5173.871886] Code: 43 48 8b 75 08 e8 6d d1 43 00 3b 05 c7 a1 a1 01 89 c7 73 30 48 63 c7 48 8b 4d 00 48 03 0c c5 20 ab 2
> 3 a2 8b 41 08 a8 01 74 0a <f3> 90 8b 51 08 83 e2 01 75 f6 eb cb 49 0f a3 1a 0f 92 44 24 1b e9
> [ 5173.871886] RSP: 0018:ffffb3d01c7b7d40 EFLAGS: 00000202
> [ 5173.871886] RAX: 0000000000000011 RBX: 0000000000000001 RCX: ffff9a5a7fc3d700
> [ 5173.871886] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> [ 5173.871886] RBP: ffff9b1a7fd33a40 R08: 0000000000000000 R09: 0000000000000000
> [ 5173.890970] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [ 5173.890970] R13: 0000000000000000 R14: 0000000000000030 R15: ffff9b1a7fd[ 5173.890970] FS:  0000000000000000(0000) GS:
> ffff9b1a7fd00000(0000) knlGS:0000000000000000
> [ 5173.890970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5173.890970] CR2: 000055fbcc0bc008 CR3: 000000526ee26000 CR4: 00000000000406e0
> [ 5173.890970] Call Trace:
> [ 5173.890970]  <TASK>
> [ 5173.890970]  ? optimize_nops+0x210/0x210
> [ 5173.890970]  on_each_cpu_cond_mask+0x20/0x30
> [ 5173.890970]  text_poke_bp_batch+0xf4/0x370
> [ 5173.890970]  ? arch_jump_label_transform_apply+0x13/0x30
> [ 5173.890970]  text_poke_finish+0x1b/0x30
> [ 5173.890970]  arch_jump_label_transform_apply+0x18/0x30
> [ 5173.890970]  static_key_disable_cpuslocked+0x5b/0x90
> [ 5173.890970]  static_key_disable+0x16/0x20
> [ 5173.890970]  process_one_work+0x274/0x590
> [ 5173.890970]  ? process_one_work+0x590/0x590
> [ 5173.890970]  worker_thread+0x52/0x3a0
> [ 5173.890970]  ? process_one_work+0x590/0x590
> [ 5173.890970]  kthread+0xd8/0x100
> [ 5173.890970]  ? kthread_complete_and_exit+0x20/0x20
> [ 5173.890970]  ret_from_fork+0x22/0x30
> [ 5173.890970]  </TASK>
> 
> ======
> clocksource_watchdog()
>   -->__clocksource_unstable()
>      -->tsc_cs_mark_unstable()
>         -->tsc_cs_mark_unstable()
>           -->clear_sched_clock_stable()
>              -->__clear_sched_clock_stable()
>              static DECLARE_WORK(sched_clock_work, __sched_clock_work);
>              __sched_clock_work()
>              -->static_branch_disable(&__sched_clock_stable);
>                -->static_key_disable_cpuslocked()
>                  -->arch_jump_label_transform_apply()
>                    -->text_poke_finish()
>                      -->text_poke_flush()
>                        -->text_poke_bp_batch()
>                          -->text_poke_sync()
>                            -->on_each_cpu()
>                              -->on_each_cpu_cond_mask()
>                                -->smp_call_function_many_cond()
> 

> [Jun21 23:09] Linux version 5.19.0-rc2+ (root@hp-dl585g7-01.rhts.eng.pek2.redhat.com) (gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9), GNU ld version 2.35.2-17.el9) #7 SMP PREEMPT_DYNAMIC Sat Jun 18 09:47:32 EDT 2022
> [  +0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+ root=/dev/mapper/rhel_hp--dl585g7--01-root ro crashkernel=512M resume=/dev/mapper/rhel_hp--dl585g7--01-swap rd.lvm.lv=rhel_hp-dl585g7-01/root rd.lvm.lv=rhel_hp-dl585g7-01/swap console=ttyS1,115200n81
> [  +0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [  +0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [  +0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [  +0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [  +0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [  +0.000000] signal: max sigframe size: 1776
> [  +0.000000] BIOS-provided physical RAM map:
> [  +0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009bfff] usable
> [  +0.000000] BIOS-e820: [mem 0x000000000009c000-0x000000000009ffff] reserved
> [  +0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [  +0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bde0dfff] usable
> [  +0.000000] BIOS-e820: [mem 0x00000000bde0e000-0x00000000bde4dfff] ACPI data
> [  +0.000000] BIOS-e820: [mem 0x00000000bde4e000-0x00000000bde4efff] usable
> [  +0.000000] BIOS-e820: [mem 0x00000000bde4f000-0x00000000cfffffff] reserved
> [  +0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fee0ffff] reserved
> [  +0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
> [  +0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000fcfeffefff] usable
> [  +0.000000] NX (Execute Disable) protection: active
> [  +0.000000] SMBIOS 2.7 present.
> [  +0.000000] DMI: HP ProLiant DL585 G7, BIOS A16 06/04/2013
> [  +0.000000] tsc: Fast TSC calibration using PIT
> [  +0.000000] tsc: Detected 2593.537 MHz processor
> [  +0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [  +0.000006] e820: remove [mem 0x000a0000-0x000fffff] usable
> [  +0.000010] last_pfn = 0xfcfefff max_arch_pfn = 0x400000000
> [  +0.004913] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [  +0.000804] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
> [  +0.000024] last_pfn = 0xbde4f max_arch_pfn = 0x400000000
> [  +0.002686] found SMP MP-table at [mem 0x000f4f60-0x000f4f6f]
> [  +0.000042] Using GB pages for direct mapping
> [  +0.000791] RAMDISK: [mem 0x313e6000-0x349eafff]
> [  +0.000007] ACPI: Early table checksum verification disabled
> [  +0.000008] ACPI: RSDP 0x00000000000F4EE0 000024 (v02 HP    )
> [  +0.000008] ACPI: XSDT 0x00000000BDE117C0 0000BC (v01 HP     ProLiant 00000002 \xd2?   0000162E)
> [  +0.000010] ACPI: FACP 0x00000000BDE118C0 0000F4 (v03 HP     ProLiant 00000002 \xd2?   0000162E)
> [  +0.000010] ACPI: DSDT 0x00000000BDE119C0 00CD60 (v01 HP     DSDT     00000001 INTL 20061109)
> [  +0.000007] ACPI: FACS 0x00000000BDE0E140 000040
> [  +0.000005] ACPI: FACS 0x00000000BDE0E140 000040
> [  +0.000005] ACPI: SPCR 0x00000000BDE0E180 000050 (v01 HP     SPCRRBSU 00000001 \xd2?   0000162E)
> [  +0.000006] ACPI: MCFG 0x00000000BDE0E200 00003C (v01 HP     ProLiant 00000001      00000000)
> [  +0.000006] ACPI: HPET 0x00000000BDE0E240 000038 (v01 HP     ProLiant 00000002 \xd2?   0000162E)
> [  +0.000006] ACPI: SPMI 0x00000000BDE0E280 000040 (v05 HP     ProLiant 00000001 \xd2?   0000162E)
> [  +0.000006] ACPI: ERST 0x00000000BDE0E2C0 0001D0 (v01 HP     ProLiant 00000001 \xd2?   0000162E)
> [  +0.000006] ACPI: APIC 0x00000000BDE0E4C0 0001EA (v01 HP     ProLiant 00000002      00000000)
> [  +0.000006] ACPI: SRAT 0x00000000BDE0E7C0 0004C0 (v02 AMD    AGESA    00000001 AMD  00000001)
> [  +0.000006] ACPI: FFFF 0x00000000BDE0EFC0 000176 (v01 HP     ProLiant 00000001 \xd2?   0000162E)
> [  +0.000005] ACPI: BERT 0x00000000BDE0F140 000030 (v01 HP     ProLiant 00000001 \xd2?   0000162E)
> [  +0.000006] ACPI: HEST 0x00000000BDE0F180 00018C (v01 HP     ProLiant 00000001 \xd2?   0000162E)
> [  +0.000005] ACPI: FFFF 0x00000000BDE0F340 000064 (v02 HP     ProLiant 00000002 \xd2?   0000162E)
> [  +0.000005] ACPI: SLIT 0x00000000BDE0F3C0 00006C (v01 AMD    AGESA    00000001 AMD  00000001)
> [  +0.000006] ACPI: FFFF 0x00000000BDE0F7C0 000000 (v00                 00000000      00000000)
> [  +0.000006] ACPI: SSDT 0x00000000BDE1E740 000125 (v03 HP     CRSPCI0  00000002 HP   00000001)
> [  +0.000005] ACPI: SSDT 0x00000000BDE1E880 00BD3D (v03 HP     pci1cmn  00000002 INTL 20090625)
> [  +0.000006] ACPI: SSDT 0x00000000BDE2A5C0 000076 (v03 HP     CRSPCI1  00000002 HP   00000001)
> [  +0.000005] ACPI: SSDT 0x00000000BDE2A640 000377 (v01 HP     pmab     00000001 INTL 20090625)
> [  +0.000006] ACPI: SSDT 0x00000000BDE2A9C0 001164 (v02 AMD    POWERNOW 00000001 AMD  00000001)
> [  +0.000005] ACPI: Reserving FACP table memory at [mem 0xbde118c0-0xbde119b3]
> [  +0.000002] ACPI: Reserving DSDT table memory at [mem 0xbde119c0-0xbde1e71f]
> [  +0.000002] ACPI: Reserving FACS table memory at [mem 0xbde0e140-0xbde0e17f]
> [  +0.000002] ACPI: Reserving FACS table memory at [mem 0xbde0e140-0xbde0e17f]
> [  +0.000002] ACPI: Reserving SPCR table memory at [mem 0xbde0e180-0xbde0e1cf]
> [  +0.000002] ACPI: Reserving MCFG table memory at [mem 0xbde0e200-0xbde0e23b]
> [  +0.000002] ACPI: Reserving HPET table memory at [mem 0xbde0e240-0xbde0e277]
> [  +0.000002] ACPI: Reserving SPMI table memory at [mem 0xbde0e280-0xbde0e2bf]
> [  +0.000001] ACPI: Reserving ERST table memory at [mem 0xbde0e2c0-0xbde0e48f]
> [  +0.000002] ACPI: Reserving APIC table memory at [mem 0xbde0e4c0-0xbde0e6a9]
> [  +0.000002] ACPI: Reserving SRAT table memory at [mem 0xbde0e7c0-0xbde0ec7f]
> [  +0.000002] ACPI: Reserving FFFF table memory at [mem 0xbde0efc0-0xbde0f135]
> [  +0.000002] ACPI: Reserving BERT table memory at [mem 0xbde0f140-0xbde0f16f]
> [  +0.000002] ACPI: Reserving HEST table memory at [mem 0xbde0f180-0xbde0f30b]
> [  +0.000001] ACPI: Reserving FFFF table memory at [mem 0xbde0f340-0xbde0f3a3]
> [  +0.000002] ACPI: Reserving SLIT table memory at [mem 0xbde0f3c0-0xbde0f42b]
> [  +0.000065] SRAT: PXM 0 -> APIC 0x20 -> Node 0
> [  +0.000003] SRAT: PXM 0 -> APIC 0x21 -> Node 0
> [  +0.000002] SRAT: PXM 0 -> APIC 0x22 -> Node 0
> [  +0.000001] SRAT: PXM 0 -> APIC 0x23 -> Node 0
> [  +0.000002] SRAT: PXM 0 -> APIC 0x24 -> Node 0
> [  +0.000002] SRAT: PXM 0 -> APIC 0x25 -> Node 0
> [  +0.000002] SRAT: PXM 1 -> APIC 0x26 -> Node 1
> [  +0.000002] SRAT: PXM 1 -> APIC 0x27 -> Node 1
> [  +0.000001] SRAT: PXM 1 -> APIC 0x28 -> Node 1
> [  +0.000003] SRAT: PXM 1 -> APIC 0x29 -> Node 1
> [  +0.000002] SRAT: PXM 1 -> APIC 0x2a -> Node 1
> [  +0.000002] SRAT: PXM 1 -> APIC 0x2b -> Node 1
> [  +0.000002] SRAT: PXM 2 -> APIC 0x40 -> Node 2
> [  +0.000002] SRAT: PXM 2 -> APIC 0x41 -> Node 2
> [  +0.000002] SRAT: PXM 2 -> APIC 0x42 -> Node 2
> [  +0.000002] SRAT: PXM 2 -> APIC 0x43 -> Node 2
> [  +0.000001] SRAT: PXM 2 -> APIC 0x44 -> Node 2
> [  +0.000002] SRAT: PXM 2 -> APIC 0x45 -> Node 2
> [  +0.000002] SRAT: PXM 3 -> APIC 0x46 -> Node 3
> [  +0.000002] SRAT: PXM 3 -> APIC 0x47 -> Node 3
> [  +0.000002] SRAT: PXM 3 -> APIC 0x48 -> Node 3
> [  +0.000002] SRAT: PXM 3 -> APIC 0x49 -> Node 3
> [  +0.000002] SRAT: PXM 3 -> APIC 0x4a -> Node 3
> [  +0.000002] SRAT: PXM 3 -> APIC 0x4b -> Node 3
> [  +0.000002] SRAT: PXM 4 -> APIC 0x60 -> Node 4
> [  +0.000002] SRAT: PXM 4 -> APIC 0x61 -> Node 4
> [  +0.000002] SRAT: PXM 4 -> APIC 0x62 -> Node 4
> [  +0.000002] SRAT: PXM 4 -> APIC 0x63 -> Node 4
> [  +0.000002] SRAT: PXM 4 -> APIC 0x64 -> Node 4
> [  +0.000002] SRAT: PXM 4 -> APIC 0x65 -> Node 4
> [  +0.000002] SRAT: PXM 5 -> APIC 0x66 -> Node 5
> [  +0.000002] SRAT: PXM 5 -> APIC 0x67 -> Node 5
> [  +0.000002] SRAT: PXM 5 -> APIC 0x68 -> Node 5
> [  +0.000002] SRAT: PXM 5 -> APIC 0x69 -> Node 5
> [  +0.000002] SRAT: PXM 5 -> APIC 0x6a -> Node 5
> [  +0.000001] SRAT: PXM 5 -> APIC 0x6b -> Node 5
> [  +0.000002] SRAT: PXM 6 -> APIC 0x86 -> Node 6
> [  +0.000002] SRAT: PXM 6 -> APIC 0x87 -> Node 6
> [  +0.000002] SRAT: PXM 6 -> APIC 0x88 -> Node 6
> [  +0.000002] SRAT: PXM 6 -> APIC 0x89 -> Node 6
> [  +0.000002] SRAT: PXM 6 -> APIC 0x8a -> Node 6
> [  +0.000002] SRAT: PXM 6 -> APIC 0x8b -> Node 6
> [  +0.000002] SRAT: PXM 7 -> APIC 0x80 -> Node 7
> [  +0.000002] SRAT: PXM 7 -> APIC 0x81 -> Node 7
> [  +0.000002] SRAT: PXM 7 -> APIC 0x82 -> Node 7
> [  +0.000001] SRAT: PXM 7 -> APIC 0x83 -> Node 7
> [  +0.000002] SRAT: PXM 7 -> APIC 0x84 -> Node 7
> [  +0.000002] SRAT: PXM 7 -> APIC 0x85 -> Node 7
> [  +0.000004] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
> [  +0.000003] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
> [  +0.000003] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x203fffffff]
> [  +0.000002] ACPI: SRAT: Node 1 PXM 1 [mem 0x2040000000-0x403fffffff]
> [  +0.000002] ACPI: SRAT: Node 2 PXM 2 [mem 0x4040000000-0x603fffffff]
> [  +0.000003] ACPI: SRAT: Node 3 PXM 3 [mem 0x6040000000-0x803fffffff]
> [  +0.000002] ACPI: SRAT: Node 4 PXM 4 [mem 0x8040000000-0xa03fffffff]
> [  +0.000002] ACPI: SRAT: Node 5 PXM 5 [mem 0xa040000000-0xc03fffffff]
> [  +0.000002] ACPI: SRAT: Node 6 PXM 6 [mem 0xc040000000-0xe03fffffff]
> [  +0.000002] ACPI: SRAT: Node 7 PXM 7 [mem 0xe040000000-0xfcfeffffff]
> [  +0.000008] NUMA: Initialized distance table, cnt=8
> [  +0.000007] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
> [  +0.000004] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x203fffffff] -> [mem 0x00000000-0x203fffffff]
> [  +0.000020] NODE_DATA(0) allocated [mem 0x203ffd5000-0x203fffffff]
> [  +0.000033] NODE_DATA(1) allocated [mem 0x403ffd5000-0x403fffffff]
> [  +0.000039] NODE_DATA(2) allocated [mem 0x603ffd5000-0x603fffffff]
> [  +0.000045] NODE_DATA(3) allocated [mem 0x803ffd5000-0x803fffffff]
> [  +0.000058] NODE_DATA(4) allocated [mem 0xa03ffd5000-0xa03fffffff]
> [  +0.000059] NODE_DATA(5) allocated [mem 0xc03ffd5000-0xc03fffffff]
> [  +0.000058] NODE_DATA(6) allocated [mem 0xe03ffd5000-0xe03fffffff]
> [  +0.000051] NODE_DATA(7) allocated [mem 0xfcfefd3000-0xfcfeffdfff]
> [  +0.000240] Reserving 512MB of memory at 2512MB for crashkernel (System RAM: 1035213MB)
> [  +0.002574] Zone ranges:
> [  +0.000001]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [  +0.000004]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [  +0.000004]   Normal   [mem 0x0000000100000000-0x000000fcfeffefff]
> [  +0.000003]   Device   empty
> [  +0.000002] Movable zone start for each node
> [  +0.000005] Early memory node ranges
> [  +0.000001]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
> [  +0.000002]   node   0: [mem 0x0000000000100000-0x00000000bde0dfff]
> [  +0.000003]   node   0: [mem 0x00000000bde4e000-0x00000000bde4efff]
> [  +0.000002]   node   0: [mem 0x0000000100000000-0x000000203fffffff]
> [  +0.000016]   node   1: [mem 0x0000002040000000-0x000000403fffffff]
> [  +0.000015]   node   2: [mem 0x0000004040000000-0x000000603fffffff]
> [  +0.000016]   node   3: [mem 0x0000006040000000-0x000000803fffffff]
> [  +0.000016]   node   4: [mem 0x0000008040000000-0x000000a03fffffff]
> [  +0.000015]   node   5: [mem 0x000000a040000000-0x000000c03fffffff]
> [  +0.000016]   node   6: [mem 0x000000c040000000-0x000000e03fffffff]
> [  +0.000016]   node   7: [mem 0x000000e040000000-0x000000fcfeffefff]
> [  +0.000015] Initmem setup node 0 [mem 0x0000000000001000-0x000000203fffffff]
> [  +0.000008] Initmem setup node 1 [mem 0x0000002040000000-0x000000403fffffff]
> [  +0.000004] Initmem setup node 2 [mem 0x0000004040000000-0x000000603fffffff]
> [  +0.000003] Initmem setup node 3 [mem 0x0000006040000000-0x000000803fffffff]
> [  +0.000004] Initmem setup node 4 [mem 0x0000008040000000-0x000000a03fffffff]
> [  +0.000004] Initmem setup node 5 [mem 0x000000a040000000-0x000000c03fffffff]
> [  +0.000003] Initmem setup node 6 [mem 0x000000c040000000-0x000000e03fffffff]
> [  +0.000004] Initmem setup node 7 [mem 0x000000e040000000-0x000000fcfeffefff]
> [  +0.000007] On node 0, zone DMA: 1 pages in unavailable ranges
> [  +0.000055] On node 0, zone DMA: 100 pages in unavailable ranges
> [  +0.011593] On node 0, zone DMA32: 64 pages in unavailable ranges
> [  +0.000707] On node 0, zone Normal: 8625 pages in unavailable ranges
> [  +0.005447] On node 7, zone Normal: 4097 pages in unavailable ranges
> [  +0.000247] ACPI: PM-Timer IO Port: 0x920
> [  +0.000022] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [  +0.000034] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-23
> [  +0.000006] IOAPIC[1]: apic_id 9, version 33, address 0xdfffc000, GSI 24-55
> [  +0.000006] IOAPIC[2]: apic_id 10, version 33, address 0xfddfc000, GSI 56-87
> [  +0.000004] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> [  +0.000005] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [  +0.000007] ACPI: Using ACPI (MADT) for SMP configuration information
> [  +0.000002] ACPI: HPET id: 0x1166a201 base: 0xfed00000
> [  +0.000009] ACPI: SPCR: SPCR table version 1
> [  +0.000002] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
> [  +0.000003] ACPI: SPCR: console: uart,mmio,0x0,9600
> [  +0.000003] smpboot: Allowing 48 CPUs, 0 hotplug CPUs
> [  +0.000033] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [  +0.000003] PM: hibernation: Registered nosave memory: [mem 0x0009c000-0x0009ffff]
> [  +0.000002] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [  +0.000002] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [  +0.000003] PM: hibernation: Registered nosave memory: [mem 0xbde0e000-0xbde4dfff]
> [  +0.000003] PM: hibernation: Registered nosave memory: [mem 0xbde4f000-0xcfffffff]
> [  +0.000002] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfebfffff]
> [  +0.000001] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfee0ffff]
> [  +0.000002] PM: hibernation: Registered nosave memory: [mem 0xfee10000-0xff7fffff]
> [  +0.000001] PM: hibernation: Registered nosave memory: [mem 0xff800000-0xffffffff]
> [  +0.000005] [mem 0xd0000000-0xfebfffff] available for PCI devices
> [  +0.000002] Booting paravirtualized kernel on bare hardware
> [  +0.000006] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [  +0.006064] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:48 nr_cpu_ids:48 nr_node_ids:8
> [  +0.008340] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u262144
> [  +0.000027] pcpu-alloc: s217088 r8192 d28672 u262144 alloc=1*2097152
> [  +0.000007] pcpu-alloc: [0] 00 04 08 12 16 20 -- -- [1] 01 05 09 13 17 21 -- -- 
> [  +0.000022] pcpu-alloc: [2] 02 06 10 14 18 22 -- -- [3] 03 07 11 15 19 23 -- -- 
> [  +0.000020] pcpu-alloc: [4] 24 28 32 36 40 44 -- -- [5] 25 29 33 37 41 45 -- -- 
> [  +0.000019] pcpu-alloc: [6] 26 30 34 38 42 46 -- -- [7] 27 31 35 39 43 47 -- -- 
> [  +0.000126] Fallback order for Node 0: 0 1 2 4 5 3 6 7 
> [  +0.000023] Fallback order for Node 1: 1 2 6 0 4 5 7 3 
> [  +0.000012] Fallback order for Node 2: 2 7 3 0 1 5 6 4 
> [  +0.000013] Fallback order for Node 3: 3 5 7 2 6 4 0 1 
> [  +0.000012] Fallback order for Node 4: 4 6 7 5 0 1 2 3 
> [  +0.000012] Fallback order for Node 5: 5 0 3 4 7 6 2 1 
> [  +0.000012] Fallback order for Node 6: 6 7 4 1 0 2 3 5 
> [  +0.000012] Fallback order for Node 7: 7 2 3 4 6 0 1 5 
> [  +0.000025] Built 8 zonelists, mobility grouping on.  Total pages: 260873685
> [  +0.000003] Policy zone: Normal
> [  +0.000011] Kernel command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+ root=/dev/mapper/rhel_hp--dl585g7--01-root ro crashkernel=512M resume=/dev/mapper/rhel_hp--dl585g7--01-swap rd.lvm.lv=rhel_hp-dl585g7-01/root rd.lvm.lv=rhel_hp-dl585g7-01/swap console=ttyS1,115200n81
> [  +0.000139] Unknown kernel command line parameters "BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+", will be passed to user space.
> [  +0.000269] mem auto-init: stack:off, heap alloc:off, heap free:off
> [  +1.846500] Memory: 3513124K/1060058788K available (14342K kernel code, 6117K rwdata, 5020K rodata, 2572K init, 17352K bss, 17278068K reserved, 0K cma-reserved)
> [  +0.001505] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=48, Nodes=8
> [  +0.000097] ftrace: allocating 43912 entries in 172 pages
> [  +0.013110] ftrace: allocated 172 pages with 4 groups
> [  +0.002299] Dynamic Preempt: voluntary
> [  +0.000484] Running RCU self tests
> [  +0.000028] rcu: Preemptible hierarchical RCU implementation.
> [  +0.000002] rcu: 	RCU lockdep checking is enabled.
> [  +0.000002] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=48.
> [  +0.000003] 	Trampoline variant of Tasks RCU enabled.
> [  +0.000001] 	Rude variant of Tasks RCU enabled.
> [  +0.000001] 	Tracing variant of Tasks RCU enabled.
> [  +0.000002] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [  +0.000002] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=48
> [  +0.007197] NR_IRQS: 524544, nr_irqs: 1896, preallocated irqs: 16
> [  +0.000375] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [  +0.006731] Console: colour VGA+ 80x25
> [  +5.845868] printk: console [ttyS1] enabled
> [  +0.001898] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [  +0.004004] ... MAX_LOCKDEP_SUBCLASSES:  8
> [  +0.001854] ... MAX_LOCK_DEPTH:          48
> [  +0.001885] ... MAX_LOCKDEP_KEYS:        8192
> [  +0.001946] ... CLASSHASH_SIZE:          4096
> [  +0.002045] ... MAX_LOCKDEP_ENTRIES:     32768
> [  +0.002002] ... MAX_LOCKDEP_CHAINS:      65536
> [  +0.002039] ... CHAINHASH_SIZE:          32768
> [  +0.001986]  memory used by lock dependency info: 6365 kB
> [  +0.002689]  memory used for stack traces: 4224 kB
> [  +0.501903]  per task-struct memory footprint: 1920 bytes
> [  +0.002701] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
> [  +0.005042] ACPI: Core revision 20220331
> [  +0.002390] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [  +0.004198] APIC: Switch to symmetric I/O mode setup
> [  +0.002333] Switched APIC routing to physical flat.
> [  +0.003120] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [  +0.007458] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x256262cce24, max_idle_ns: 440795209023 ns
> [  +0.004820] Calibrating delay loop (skipped), value calculated using timer frequency.. 5187.07 BogoMIPS (lpj=2593537)
> [  +0.001001] pid_max: default: 49152 minimum: 384
> [  +0.002063] LSM: Security Framework initializing
> [  +0.001002] Yama: becoming mindful.
> [  +0.000975] SELinux:  Initializing.
> [  +0.001205] LSM support for eBPF active
> [  +0.088292] Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes, vmalloc hugepage)
> [  +0.044668] Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc hugepage)
> [  +0.002609] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
> [  +0.002120] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
> [  +0.002952] LVT offset 1 assigned for vector 0xf9
> [  +0.000145] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
> [  +0.000968] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
> [  +0.001013] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [  +0.000989] Spectre V2 : Mitigation: Retpolines
> [  +0.000998] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [  +0.001002] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [  +0.003525] Freeing SMP alternatives memory: 36K
> [  +0.103259] smpboot: CPU0: AMD Opteron(tm) Processor 6344 (family: 0x15, model: 0x2, stepping: 0x0)
> [  +0.001688] cblist_init_generic: Setting adjustable number of callback queues.
> [  +0.000526] cblist_init_generic: Setting shift to 6 and lim to 1.
> [  +0.001137] cblist_init_generic: Setting shift to 6 and lim to 1.
> [  +0.000996] cblist_init_generic: Setting shift to 6 and lim to 1.
> [  +0.000954] Running RCU-tasks wait API self tests
> [  +0.111091] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
> [  +0.000824] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 430076)
> [  +0.001000] AMD PMU driver.
> [  +0.001010] ... version:                0
> [  +0.000990] ... bit width:              48
> [  +0.001000] ... generic registers:      6
> [  +0.001000] ... value mask:             0000ffffffffffff
> [  +0.001000] ... max period:             00007fffffffffff
> [  +0.001000] ... fixed-purpose events:   0
> [  +0.000999] ... event mask:             000000000000003f
> [  +0.002391] rcu: Hierarchical SRCU implementation.
> [  +0.000075] printk: console [ttyS1] printing thread started
> [  +0.003576] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [  +0.002050] Callback from call_rcu_tasks_trace() invoked.
> [  +0.004432] smp: Bringing up secondary CPUs ...
> [  +0.002090] x86: Booting SMP configuration:
> [  +0.000002] .... node  #2, CPUs:        #1
> [  -2.325462] smpboot: CPU 1 Converting physical 2 to logical die 1
> 
> [  +2.390220] .... node  #4, CPUs:    #2
> [  -2.390220] smpboot: CPU 2 Converting physical 4 to logical die 2
> [  +2.456969] Callback from call_rcu_tasks_rude() invoked.
> 
> [  +0.000940] .... node  #7, CPUs:    #3
> [  -2.457909] smpboot: CPU 3 Converting physical 7 to logical die 3
> [  +0.000000] calibrate_delay_direct() dropping max bogoMips estimate 0 = 3112480
> 
> [  +2.523911] .... node  #0, CPUs:    #4
> [  +0.004119] .... node  #2, CPUs:    #5
> [  +0.004461] .... node  #4, CPUs:    #6
> [  +0.004490] .... node  #7, CPUs:    #7
> [  +0.004494] .... node  #0, CPUs:    #8
> [  +0.004528] .... node  #2, CPUs:    #9
> [  +0.004331] .... node  #4, CPUs:   #10
> [  +0.004768] .... node  #7, CPUs:   #11
> [  +0.004900] .... node  #0, CPUs:   #12
> [  +0.005169] .... node  #2, CPUs:   #13
> [  +0.001719] Callback from call_rcu_tasks() invoked.
> 
> [  +0.005472] .... node  #4, CPUs:   #14
> [  +0.004151] .... node  #7, CPUs:   #15
> [  +0.004658] .... node  #0, CPUs:   #16
> [  +0.004872] .... node  #2, CPUs:   #17
> [  +0.004975] .... node  #4, CPUs:   #18
> [  +0.005171] .... node  #7, CPUs:   #19
> [  +0.004941] .... node  #0, CPUs:   #20
> [  +0.005042] .... node  #2, CPUs:   #21
> [  +0.005034] .... node  #4, CPUs:   #22
> [  +0.005170] .... node  #7, CPUs:   #23
> [  +0.004815] .... node  #1, CPUs:   #24
> [  -2.621191] smpboot: CPU 24 Converting physical 1 to logical die 4
> 
> [  +2.629439] .... node  #3, CPUs:   #25
> [  -2.629439] smpboot: CPU 25 Converting physical 3 to logical die 5
> 
> [  +2.635410] .... node  #5, CPUs:   #26
> [  -2.635410] smpboot: CPU 26 Converting physical 5 to logical die 6
> 
> [  +2.642486] .... node  #6, CPUs:   #27
> [  -2.642486] smpboot: CPU 27 Converting physical 6 to logical die 7
> 
> [  +2.649341] .... node  #1, CPUs:   #28
> [  +0.004238] .... node  #3, CPUs:   #29
> [  +0.004731] .... node  #5, CPUs:   #30
> [  +0.004679] .... node  #6, CPUs:   #31
> [  +0.005496] .... node  #1, CPUs:   #32
> [  +0.004958] .... node  #3, CPUs:   #33
> [  +0.004951] .... node  #5, CPUs:   #34
> [  +0.005000] .... node  #6, CPUs:   #35
> [  +0.005078] .... node  #1, CPUs:   #36
> [  +0.005079] .... node  #3, CPUs:   #37
> [  +0.004928] .... node  #5, CPUs:   #38
> [  +0.005010] .... node  #6, CPUs:   #39
> [  +0.005008] .... node  #1, CPUs:   #40
> [  +0.005051] .... node  #3, CPUs:   #41
> [  +0.005022] .... node  #5, CPUs:   #42
> [  +0.005002] .... node  #6, CPUs:   #43
> [  +0.004990] .... node  #1, CPUs:   #44
> [  +0.004587] .... node  #3, CPUs:   #45
> [  +0.005456] .... node  #5, CPUs:   #46
> [  +0.004978] .... node  #6, CPUs:   #47
> [  +0.004528] smp: Brought up 8 nodes, 48 CPUs
> [  +0.000004] smpboot: Max logical packages: 4
> [  +0.000011] smpboot: Total of 48 processors activated (248725.34 BogoMIPS)
> [  +0.430956] node 1 deferred pages initialised in 419ms
> [  +0.001011] node 6 deferred pages initialised in 417ms
> [  +0.001903] node 5 deferred pages initialised in 419ms
> [  +0.001467] node 3 deferred pages initialised in 421ms
> [  +0.015617] node 0 deferred pages initialised in 439ms
> [  +0.022104] node 7 deferred pages initialised in 457ms
> [  +0.022865] node 2 deferred pages initialised in 483ms
> [  +0.006875] node 4 deferred pages initialised in 489ms
> [  +0.113126] devtmpfs: initialized
> [  +0.000099] x86/mm: Memory block size: 2048MB
> [  +0.543926] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [  +0.000099] futex hash table entries: 16384 (order: 9, 2097152 bytes, vmalloc)
> [  +0.004522] pinctrl core: initialized pinctrl subsystem
> [  +0.011716] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [  +0.001519] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> [  +0.000063] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [  +0.000052] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [  +0.000147] audit: initializing netlink subsys (disabled)
> [  +0.000058] audit: type=2000 audit(1655852948.008:1): state=initialized audit_enabled=0 res=1
> [  +0.002047] thermal_sys: Registered thermal governor 'fair_share'
> [  +0.000008] thermal_sys: Registered thermal governor 'step_wise'
> [  +0.000004] thermal_sys: Registered thermal governor 'user_space'
> [  +0.002644] cpuidle: using governor menu
> [  +0.007168] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
> [  +0.000042] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [  +0.000003] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [  +0.000955] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
> [  +0.000013] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
> [  +0.000077] PCI: Using configuration type 1 for base access
> [  +0.029993] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [  +0.005635] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
> [  +0.000000] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [  +0.000000] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [  +0.005245] cryptd: max_cpu_qlen set to 1000
> [  +0.006504] ACPI: Added _OSI(Module Device)
> [  +0.000005] ACPI: Added _OSI(Processor Device)
> [  +0.000004] ACPI: Added _OSI(3.0 _SCP Extensions)
> [  +0.000005] ACPI: Added _OSI(Processor Aggregator Device)
> [  +0.000007] ACPI: Added _OSI(Linux-Dell-Video)
> [  +0.000007] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [  +0.000007] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [  +0.152637] ACPI: 6 ACPI AML tables successfully acquired and loaded
> [  +0.130082] ACPI: Interpreter enabled
> [  +0.000072] ACPI: PM: (supports S0 S4 S5)
> [  +0.000014] ACPI: Using IOAPIC for interrupt routing
> [  +0.000217] HEST: Table parsing has been initialized.
> [  +0.000257] GHES: APEI firmware first mode is enabled by WHEA _OSC.
> [  +0.000002] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [  +0.000002] PCI: Using E820 reservations for host bridge windows
> [  +0.179323] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
> [  +0.000014] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [  +0.000243] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> [  +0.000003] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [  +0.002462] PCI host bridge to bus 0000:00
> [  +0.000004] pci_bus 0000:00: root bus resource [mem 0xdff00000-0xfdbfffff window]
> [  +0.000005] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
> [  +0.000003] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
> [  +0.000003] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [  +0.000003] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
> [  +0.000003] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed03fff window]
> [  +0.000003] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
> [  +0.000003] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
> [  +0.000003] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
> [  +0.000002] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [  +0.000004] pci_bus 0000:00: root bus resource [bus 00-3f]
> [  +0.000171] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
> [  +0.000440] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
> [  +0.000069] pci 0000:00:02.0: enabling Extended Tags
> [  +0.000100] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> [  +0.000803] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
> [  +0.000070] pci 0000:00:04.0: enabling Extended Tags
> [  +0.000096] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
> [  +0.000584] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
> [  +0.000069] pci 0000:00:0a.0: enabling Extended Tags
> [  +0.000099] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
> [  +0.000625] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
> [  +0.000039] pci 0000:00:11.0: reg 0x10: [io  0x1000-0x1007]
> [  +0.000023] pci 0000:00:11.0: reg 0x14: [io  0x1008-0x100b]
> [  +0.000023] pci 0000:00:11.0: reg 0x18: [io  0x1010-0x1017]
> [  +0.000021] pci 0000:00:11.0: reg 0x1c: [io  0x1018-0x101b]
> [  +0.000020] pci 0000:00:11.0: reg 0x20: [io  0x1020-0x102f]
> [  +0.000020] pci 0000:00:11.0: reg 0x24: [mem 0xed8f0000-0xed8f03ff]
> [  +0.000058] pci 0000:00:11.0: set SATA to AHCI mode
> [  +0.000253] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
> [  +0.000039] pci 0000:00:12.0: reg 0x10: [mem 0xed8e0000-0xed8e0fff]
> [  +0.000422] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
> [  +0.000037] pci 0000:00:12.1: reg 0x10: [mem 0xed8d0000-0xed8d0fff]
> [  +0.000346] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
> [  +0.000038] pci 0000:00:12.2: reg 0x10: [mem 0xed8c0000-0xed8c00ff]
> [  +0.000211] pci 0000:00:12.2: supports D1 D2
> [  +0.000001] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
> [  +0.000360] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
> [  +0.000037] pci 0000:00:13.0: reg 0x10: [mem 0xed8b0000-0xed8b0fff]
> [  +0.000322] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
> [  +0.000040] pci 0000:00:13.1: reg 0x10: [mem 0xed8a0000-0xed8a0fff]
> [  +0.000325] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
> [  +0.000038] pci 0000:00:13.2: reg 0x10: [mem 0xed890000-0xed8900ff]
> [  +0.000292] pci 0000:00:13.2: supports D1 D2
> [  +0.000001] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
> [  +0.000255] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
> [  +0.000771] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
> [  +0.000039] pci 0000:00:14.1: reg 0x10: [io  0x01f0-0x01f7]
> [  +0.000022] pci 0000:00:14.1: reg 0x14: [io  0x03f4-0x03f7]
> [  +0.000021] pci 0000:00:14.1: reg 0x18: [io  0x0170-0x0177]
> [  +0.000020] pci 0000:00:14.1: reg 0x1c: [io  0x0374-0x0377]
> [  +0.000020] pci 0000:00:14.1: reg 0x20: [io  0x0500-0x050f]
> [  +0.000048] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [  +0.000002] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [  +0.000002] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [  +0.000002] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [  +0.000250] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
> [  +0.000643] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
> [  +0.000481] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
> [  +0.000392] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
> [  +0.000205] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
> [  +0.000204] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
> [  +0.000209] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
> [  +0.000309] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
> [  +0.000209] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
> [  +0.000237] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
> [  +0.000202] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
> [  +0.000402] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
> [  +0.000215] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
> [  +0.000196] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
> [  +0.000207] pci 0000:00:1a.0: [1022:1600] type 00 class 0x060000
> [  +0.000325] pci 0000:00:1a.1: [1022:1601] type 00 class 0x060000
> [  +0.000200] pci 0000:00:1a.2: [1022:1602] type 00 class 0x060000
> [  +0.000194] pci 0000:00:1a.3: [1022:1603] type 00 class 0x060000
> [  +0.000213] pci 0000:00:1a.4: [1022:1604] type 00 class 0x060000
> [  +0.000351] pci 0000:00:1a.5: [1022:1605] type 00 class 0x060000
> [  +0.000215] pci 0000:00:1b.0: [1022:1600] type 00 class 0x060000
> [  +0.000214] pci 0000:00:1b.1: [1022:1601] type 00 class 0x060000
> [  +0.000220] pci 0000:00:1b.2: [1022:1602] type 00 class 0x060000
> [  +0.000338] pci 0000:00:1b.3: [1022:1603] type 00 class 0x060000
> [  +0.000203] pci 0000:00:1b.4: [1022:1604] type 00 class 0x060000
> [  +0.000199] pci 0000:00:1b.5: [1022:1605] type 00 class 0x060000
> [  +0.000206] pci 0000:00:1c.0: [1022:1600] type 00 class 0x060000
> [  +0.000289] pci 0000:00:1c.1: [1022:1601] type 00 class 0x060000
> [  +0.000300] pci 0000:00:1c.2: [1022:1602] type 00 class 0x060000
> [  +0.000207] pci 0000:00:1c.3: [1022:1603] type 00 class 0x060000
> [  +0.000216] pci 0000:00:1c.4: [1022:1604] type 00 class 0x060000
> [  +0.000259] pci 0000:00:1c.5: [1022:1605] type 00 class 0x060000
> [  +0.000267] pci 0000:00:1d.0: [1022:1600] type 00 class 0x060000
> [  +0.000223] pci 0000:00:1d.1: [1022:1601] type 00 class 0x060000
> [  +0.000201] pci 0000:00:1d.2: [1022:1602] type 00 class 0x060000
> [  +0.000217] pci 0000:00:1d.3: [1022:1603] type 00 class 0x060000
> [  +0.000336] pci 0000:00:1d.4: [1022:1604] type 00 class 0x060000
> [  +0.000203] pci 0000:00:1d.5: [1022:1605] type 00 class 0x060000
> [  +0.000208] pci 0000:00:1e.0: [1022:1600] type 00 class 0x060000
> [  +0.000218] pci 0000:00:1e.1: [1022:1601] type 00 class 0x060000
> [  +0.000328] pci 0000:00:1e.2: [1022:1602] type 00 class 0x060000
> [  +0.000208] pci 0000:00:1e.3: [1022:1603] type 00 class 0x060000
> [  +0.000214] pci 0000:00:1e.4: [1022:1604] type 00 class 0x060000
> [  +0.000203] pci 0000:00:1e.5: [1022:1605] type 00 class 0x060000
> [  +0.000352] pci 0000:00:1f.0: [1022:1600] type 00 class 0x060000
> [  +0.000234] pci 0000:00:1f.1: [1022:1601] type 00 class 0x060000
> [  +0.000193] pci 0000:00:1f.2: [1022:1602] type 00 class 0x060000
> [  +0.000202] pci 0000:00:1f.3: [1022:1603] type 00 class 0x060000
> [  +0.000310] pci 0000:00:1f.4: [1022:1604] type 00 class 0x060000
> [  +0.000218] pci 0000:00:1f.5: [1022:1605] type 00 class 0x060000
> [  +0.000341] pci 0000:04:00.0: [4040:0100] type 00 class 0x020000
> [  +0.000030] pci 0000:04:00.0: reg 0x10: [mem 0xfda00000-0xfdbfffff 64bit]
> [  +0.000044] pci 0000:04:00.0: reg 0x20: [mem 0xfa000000-0xfbffffff 64bit]
> [  +0.000118] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [  +0.000428] pci 0000:04:00.1: [4040:0100] type 00 class 0x020000
> [  +0.000030] pci 0000:04:00.1: reg 0x10: [mem 0xf9e00000-0xf9ffffff 64bit]
> [  +0.000043] pci 0000:04:00.1: reg 0x20: [mem 0xf6000000-0xf7ffffff 64bit]
> [  +0.000118] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
> [  +0.000270] pci 0000:04:00.2: [4040:0100] type 00 class 0x020000
> [  +0.000030] pci 0000:04:00.2: reg 0x10: [mem 0xf5e00000-0xf5ffffff 64bit]
> [  +0.000044] pci 0000:04:00.2: reg 0x20: [mem 0xf2000000-0xf3ffffff 64bit]
> [  +0.000117] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
> [  +0.000337] pci 0000:04:00.3: [4040:0100] type 00 class 0x020000
> [  +0.000030] pci 0000:04:00.3: reg 0x10: [mem 0xf1e00000-0xf1ffffff 64bit]
> [  +0.000043] pci 0000:04:00.3: reg 0x20: [mem 0xee000000-0xefffffff 64bit]
> [  +0.000120] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> [  +0.000385] pci 0000:00:02.0: PCI bridge to [bus 04]
> [  +0.000011] pci 0000:00:02.0:   bridge window [mem 0xee000000-0xfdbfffff]
> [  +0.000156] pci 0000:03:00.0: [103c:323a] type 00 class 0x010400
> [  +0.000122] pci 0000:03:00.0: reg 0x10: [mem 0xede00000-0xedffffff 64bit]
> [  +0.000028] pci 0000:03:00.0: reg 0x18: [mem 0xeddf0000-0xeddf0fff 64bit]
> [  +0.000017] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
> [  +0.000025] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
> [  +0.000101] pci 0000:03:00.0: PME# supported from D0
> [  +0.000045] pci 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:04.0 (capable of 32.000 Gb/s with 5.0 GT/s PCIe x8 link)
> [  +0.000248] pci 0000:00:04.0: PCI bridge to [bus 03]
> [  +0.000009] pci 0000:00:04.0:   bridge window [io  0x4000-0x4fff]
> [  +0.000005] pci 0000:00:04.0:   bridge window [mem 0xedd00000-0xedffffff]
> [  +0.000212] pci 0000:02:00.0: [103c:3306] type 00 class 0x088000
> [  +0.000040] pci 0000:02:00.0: reg 0x10: [io  0x3000-0x30ff]
> [  +0.000023] pci 0000:02:00.0: reg 0x14: [mem 0xedcf0000-0xedcf01ff]
> [  +0.000021] pci 0000:02:00.0: reg 0x18: [io  0x3400-0x34ff]
> [  +0.000709] pci 0000:02:00.2: [103c:3307] type 00 class 0x088000
> [  +0.000040] pci 0000:02:00.2: reg 0x10: [io  0x3800-0x38ff]
> [  +0.000022] pci 0000:02:00.2: reg 0x14: [mem 0xedce0000-0xedce00ff]
> [  +0.000021] pci 0000:02:00.2: reg 0x18: [mem 0xedb00000-0xedbfffff]
> [  +0.000021] pci 0000:02:00.2: reg 0x1c: [mem 0xeda80000-0xedafffff]
> [  +0.000021] pci 0000:02:00.2: reg 0x20: [mem 0xeda70000-0xeda77fff]
> [  +0.000020] pci 0000:02:00.2: reg 0x24: [mem 0xeda60000-0xeda67fff]
> [  +0.000021] pci 0000:02:00.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [  +0.000137] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
> [  +0.000398] pci 0000:02:00.4: [103c:3300] type 00 class 0x0c0300
> [  +0.000120] pci 0000:02:00.4: reg 0x20: [io  0x3c00-0x3c1f]
> [  +0.002809] pci 0000:00:0a.0: PCI bridge to [bus 02]
> [  +0.000010] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
> [  +0.000005] pci 0000:00:0a.0:   bridge window [mem 0xeda00000-0xedcfffff]
> [  +0.000034] pci_bus 0000:01: extended config space not accessible
> [  +0.000115] pci 0000:01:03.0: [1002:515e] type 00 class 0x030000
> [  +0.000042] pci 0000:01:03.0: reg 0x10: [mem 0xe0000000-0xe7ffffff pref]
> [  +0.000023] pci 0000:01:03.0: reg 0x14: [io  0x2000-0x20ff]
> [  +0.000023] pci 0000:01:03.0: reg 0x18: [mem 0xed9f0000-0xed9fffff]
> [  +0.000084] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
> [  +0.000047] pci 0000:01:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [  +0.000061] pci 0000:01:03.0: supports D1 D2
> [  +0.000264] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
> [  +0.000008] pci 0000:00:14.4:   bridge window [io  0x2000-0x2fff]
> [  +0.000006] pci 0000:00:14.4:   bridge window [mem 0xed900000-0xed9fffff]
> [  +0.000006] pci 0000:00:14.4:   bridge window [mem 0xe0000000-0xe7ffffff pref]
> [  +0.000003] pci 0000:00:14.4:   bridge window [mem 0xdff00000-0xfdbfffff window] (subtractive decode)
> [  +0.000004] pci 0000:00:14.4:   bridge window [io  0x1000-0xffff window] (subtractive decode)
> [  +0.000003] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
> [  +0.000002] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
> [  +0.000003] pci 0000:00:14.4:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
> [  +0.000003] pci 0000:00:14.4:   bridge window [mem 0xfed00000-0xfed03fff window] (subtractive decode)
> [  +0.000003] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
> [  +0.000003] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
> [  +0.000002] pci 0000:00:14.4:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
> [  +0.000003] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [  +0.002659] ACPI: PCI: Interrupt link I020 configured for IRQ 24
> [  +0.002134] ACPI: PCI: Interrupt link I021 configured for IRQ 25
> [  +0.002206] ACPI: PCI: Interrupt link I022 configured for IRQ 26
> [  +0.002260] ACPI: PCI: Interrupt link I023 configured for IRQ 27
> [  +0.002164] ACPI: PCI: Interrupt link I030 configured for IRQ 28
> [  +0.002181] ACPI: PCI: Interrupt link I031 configured for IRQ 29
> [  +0.002224] ACPI: PCI: Interrupt link I032 configured for IRQ 30
> [  +0.002337] ACPI: PCI: Interrupt link I033 configured for IRQ 31
> [  +0.002151] ACPI: PCI: Interrupt link I040 configured for IRQ 44
> [  +0.002228] ACPI: PCI: Interrupt link I041 configured for IRQ 45
> [  +0.002224] ACPI: PCI: Interrupt link I042 configured for IRQ 46
> [  +0.002367] ACPI: PCI: Interrupt link I043 configured for IRQ 47
> [  +0.002273] ACPI: PCI: Interrupt link I050 configured for IRQ 48
> [  +0.002274] ACPI: PCI: Interrupt link I051 configured for IRQ 49
> [  +0.002257] ACPI: PCI: Interrupt link I052 configured for IRQ 50
> [  +0.002402] ACPI: PCI: Interrupt link I053 configured for IRQ 51
> [  +0.002348] ACPI: PCI: Interrupt link I060 configured for IRQ 47
> [  +0.002212] ACPI: PCI: Interrupt link I061 configured for IRQ 44
> [  +0.002348] ACPI: PCI: Interrupt link I062 configured for IRQ 45
> [  +0.002295] ACPI: PCI: Interrupt link I063 configured for IRQ 46
> [  +0.002314] ACPI: PCI: Interrupt link I070 configured for IRQ 24
> [  +0.002415] ACPI: PCI: Interrupt link I071 configured for IRQ 25
> [  +0.002325] ACPI: PCI: Interrupt link I072 configured for IRQ 26
> [  +0.002400] ACPI: PCI: Interrupt link I073 configured for IRQ 27
> [  +0.000583] ACPI: PCI: Interrupt link I090 configured for IRQ 24
> [  +0.000589] ACPI: PCI: Interrupt link I091 configured for IRQ 24
> [  +0.000514] ACPI: PCI: Interrupt link I092 configured for IRQ 24
> [  +0.000577] ACPI: PCI: Interrupt link I093 configured for IRQ 24
> [  +0.002361] ACPI: PCI: Interrupt link I0A0 configured for IRQ 24
> [  +0.002525] ACPI: PCI: Interrupt link I0A1 configured for IRQ 25
> [  +0.002394] ACPI: PCI: Interrupt link I0A2 configured for IRQ 26
> [  +0.002460] ACPI: PCI: Interrupt link I0A3 configured for IRQ 27
> [  +0.002413] ACPI: PCI: Interrupt link I0B0 configured for IRQ 32
> [  +0.002432] ACPI: PCI: Interrupt link I0B1 configured for IRQ 33
> [  +0.002536] ACPI: PCI: Interrupt link I0B2 configured for IRQ 34
> [  +0.002460] ACPI: PCI: Interrupt link I0B3 configured for IRQ 35
> [  +0.002479] ACPI: PCI: Interrupt link I0C0 configured for IRQ 24
> [  +0.002435] ACPI: PCI: Interrupt link I0C1 configured for IRQ 25
> [  +0.002567] ACPI: PCI: Interrupt link I0C2 configured for IRQ 26
> [  +0.002552] ACPI: PCI: Interrupt link I0C3 configured for IRQ 27
> [  +0.002474] ACPI: PCI: Interrupt link I0D0 configured for IRQ 40
> [  +0.002502] ACPI: PCI: Interrupt link I0D1 configured for IRQ 41
> [  +0.002651] ACPI: PCI: Interrupt link I0D2 configured for IRQ 42
> [  +0.002588] ACPI: PCI: Interrupt link I0D3 configured for IRQ 43
> [  +0.000237] ACPI: PCI: Interrupt link BI02 configured for IRQ 52
> [  +0.000262] ACPI: PCI: Interrupt link BI03 configured for IRQ 52
> [  +0.000296] ACPI: PCI: Interrupt link BI04 configured for IRQ 52
> [  +0.000426] ACPI: PCI: Interrupt link BI05 configured for IRQ 52
> [  +0.000362] ACPI: PCI: Interrupt link BI06 configured for IRQ 54
> [  +0.000461] ACPI: PCI: Interrupt link BI07 configured for IRQ 24
> [  +0.000425] ACPI: PCI: Interrupt link BI08 configured for IRQ 24
> [  +0.000461] ACPI: PCI: Interrupt link BI09 configured for IRQ 24
> [  +0.000641] ACPI: PCI: Interrupt link BI0A configured for IRQ 24
> [  +0.000594] ACPI: PCI: Interrupt link BI0B configured for IRQ 54
> [  +0.000557] ACPI: PCI: Interrupt link BI0C configured for IRQ 54
> [  +0.000690] ACPI: PCI: Interrupt link BI0D configured for IRQ 54
> [  +0.000317] ACPI: PCI: Interrupt link PI20 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI20 disabled
> [  +0.000462] ACPI: PCI: Interrupt link PI21 configured for IRQ 0
> [  +0.000003] ACPI: PCI: Interrupt link PI21 disabled
> [  +0.000381] ACPI: PCI: Interrupt link PI22 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI22 disabled
> [  +0.000448] ACPI: PCI: Interrupt link PI23 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI23 disabled
> [  +0.000379] ACPI: PCI: Interrupt link PI30 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI30 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PI31 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI31 disabled
> [  +0.000448] ACPI: PCI: Interrupt link PI32 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI32 disabled
> [  +0.000376] ACPI: PCI: Interrupt link PI33 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI33 disabled
> [  +0.000468] ACPI: PCI: Interrupt link PI40 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI40 disabled
> [  +0.000380] ACPI: PCI: Interrupt link PI41 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI41 disabled
> [  +0.000376] ACPI: PCI: Interrupt link PI42 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI42 disabled
> [  +0.000447] ACPI: PCI: Interrupt link PI43 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI43 disabled
> [  +0.000375] ACPI: PCI: Interrupt link PI50 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI50 disabled
> [  +0.000454] ACPI: PCI: Interrupt link PI51 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI51 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PI52 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI52 disabled
> [  +0.000376] ACPI: PCI: Interrupt link PI53 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI53 disabled
> [  +0.000459] ACPI: PCI: Interrupt link PI60 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI60 disabled
> [  +0.000375] ACPI: PCI: Interrupt link PI61 configured for IRQ 0
> [  +0.000003] ACPI: PCI: Interrupt link PI61 disabled
> [  +0.000483] ACPI: PCI: Interrupt link PI62 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI62 disabled
> [  +0.000377] ACPI: PCI: Interrupt link PI63 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI63 disabled
> [  +0.000447] ACPI: PCI: Interrupt link PI70 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI70 disabled
> [  +0.000380] ACPI: PCI: Interrupt link PI71 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI71 disabled
> [  +0.000377] ACPI: PCI: Interrupt link PI72 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI72 disabled
> [  +0.000447] ACPI: PCI: Interrupt link PI73 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI73 disabled
> [  +0.000377] ACPI: PCI: Interrupt link PI90 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI90 disabled
> [  +0.000457] ACPI: PCI: Interrupt link PI91 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI91 disabled
> [  +0.000377] ACPI: PCI: Interrupt link PI92 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI92 disabled
> [  +0.000374] ACPI: PCI: Interrupt link PI93 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI93 disabled
> [  +0.000496] ACPI: PCI: Interrupt link PIA0 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA0 disabled
> [  +0.000374] ACPI: PCI: Interrupt link PIA1 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA1 disabled
> [  +0.000451] ACPI: PCI: Interrupt link PIA2 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA2 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIA3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA3 disabled
> [  +0.000376] ACPI: PCI: Interrupt link PIB0 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIB0 disabled
> [  +0.000456] ACPI: PCI: Interrupt link PIB1 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIB1 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIB2 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIB2 disabled
> [  +0.000434] ACPI: PCI: Interrupt link PIB3 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIB3 disabled
> [  +0.000377] ACPI: PCI: Interrupt link PIC0 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIC0 disabled
> [  +0.000469] ACPI: PCI: Interrupt link PIC1 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIC1 disabled
> [  +0.000385] ACPI: PCI: Interrupt link PIC2 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIC2 disabled
> [  +0.000375] ACPI: PCI: Interrupt link PIC3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIC3 disabled
> [  +0.000447] ACPI: PCI: Interrupt link PID0 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PID0 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PID1 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PID1 disabled
> [  +0.000469] ACPI: PCI: Interrupt link PID2 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PID2 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PID3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PID3 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIR2 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIR2 disabled
> [  +0.000447] ACPI: PCI: Interrupt link PIR3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR3 disabled
> [  +0.000374] ACPI: PCI: Interrupt link PIR4 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR4 disabled
> [  +0.000483] ACPI: PCI: Interrupt link PIR5 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR5 disabled
> [  +0.000379] ACPI: PCI: Interrupt link PIR6 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR6 disabled
> [  +0.000508] ACPI: PCI: Interrupt link PIR7 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIR7 disabled
> [  +0.000385] ACPI: PCI: Interrupt link PIR8 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR8 disabled
> [  +0.000372] ACPI: PCI: Interrupt link PIR9 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR9 disabled
> [  +0.000447] ACPI: PCI: Interrupt link PIRA configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIRA disabled
> [  +0.000376] ACPI: PCI: Interrupt link PIRB configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIRB disabled
> [  +0.000442] ACPI: PCI: Interrupt link PIRC configured for IRQ 0
> [  +0.000003] ACPI: PCI: Interrupt link PIRC disabled
> [  +0.000373] ACPI: PCI: Interrupt link PIRD configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIRD disabled
> [  +0.000322] ACPI: PCI: Interrupt link USB1 configured for IRQ 22
> [  +0.000375] ACPI: PCI: Interrupt link USB2 configured for IRQ 23
> [  +0.000310] ACPI: PCI: Interrupt link USB3 configured for IRQ 23
> [  +0.000335] ACPI: PCI: Interrupt link USB4 configured for IRQ 22
> [  +0.000926] ACPI: PCI: Interrupt link U1PI configured for IRQ 0
> [  +0.000945] ACPI: PCI: Interrupt link U2PI configured for IRQ 0
> [  +0.000963] ACPI: PCI: Interrupt link U3PI configured for IRQ 0
> [  +0.001044] ACPI: PCI: Interrupt link U4PI configured for IRQ 0
> [  +0.000188] ACPI: PCI: Interrupt link SATA configured for IRQ 16
> [  +0.000457] ACPI: PCI: Interrupt link SATP configured for IRQ 0
> [  +0.000190] ACPI: PCI: Interrupt link VIDA configured for IRQ 16
> [  +0.000391] ACPI: PCI: Interrupt link VIDP configured for IRQ 0
> [  +0.001220] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 40-7f])
> [  +0.000011] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [  +0.000229] acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> [  +0.000003] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
> [  +0.000016] acpi PNP0A08:01: [Firmware Bug]: no _PXM; falling back to node 7 from hardware (may be inconsistent with ACPI node numbers)
> [  +0.001761] PCI host bridge to bus 0000:40
> [  +0.000003] pci_bus 0000:40: root bus resource [mem 0xfdd00000-0xfdffffff window]
> [  +0.000004] pci_bus 0000:40: root bus resource [bus 40-7f]
> [  +0.000092] pci 0000:40:00.0: [1002:5a10] type 00 class 0x060000
> [  +0.000285] pci 0000:40:0c.0: [1002:5a20] type 01 class 0x060400
> [  +0.000040] pci 0000:40:0c.0: enabling Extended Tags
> [  +0.000063] pci 0000:40:0c.0: PME# supported from D0 D3hot D3cold
> [  +0.001401] pci 0000:47:00.0: [19a2:0710] type 00 class 0x020000
> [  +0.000030] pci 0000:47:00.0: reg 0x10: [mem 0xfdff0000-0xfdff3fff 64bit]
> [  +0.000019] pci 0000:47:00.0: reg 0x18: [mem 0xfdfc0000-0xfdfdffff 64bit]
> [  +0.000018] pci 0000:47:00.0: reg 0x20: [mem 0xfdfa0000-0xfdfbffff 64bit]
> [  +0.000013] pci 0000:47:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [  +0.000119] pci 0000:47:00.0: PME# supported from D3hot D3cold
> [  +0.000488] pci 0000:47:00.1: [19a2:0710] type 00 class 0x020000
> [  +0.000029] pci 0000:47:00.1: reg 0x10: [mem 0xfdf90000-0xfdf93fff 64bit]
> [  +0.000020] pci 0000:47:00.1: reg 0x18: [mem 0xfdf60000-0xfdf7ffff 64bit]
> [  +0.000019] pci 0000:47:00.1: reg 0x20: [mem 0xfdf40000-0xfdf5ffff 64bit]
> [  +0.000012] pci 0000:47:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [  +0.000118] pci 0000:47:00.1: PME# supported from D3hot D3cold
> [  +0.000587] pci 0000:47:00.2: [19a2:0714] type 00 class 0x0c0400
> [  +0.000029] pci 0000:47:00.2: reg 0x10: [mem 0xfdf30000-0xfdf33fff 64bit]
> [  +0.000019] pci 0000:47:00.2: reg 0x18: [mem 0xfdf00000-0xfdf1ffff 64bit]
> [  +0.000018] pci 0000:47:00.2: reg 0x20: [mem 0xfdee0000-0xfdefffff 64bit]
> [  +0.000013] pci 0000:47:00.2: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [  +0.000117] pci 0000:47:00.2: PME# supported from D3hot D3cold
> [  +0.000561] pci 0000:47:00.3: [19a2:0714] type 00 class 0x0c0400
> [  +0.000029] pci 0000:47:00.3: reg 0x10: [mem 0xfded0000-0xfded3fff 64bit]
> [  +0.000019] pci 0000:47:00.3: reg 0x18: [mem 0xfdea0000-0xfdebffff 64bit]
> [  +0.000019] pci 0000:47:00.3: reg 0x20: [mem 0xfde80000-0xfde9ffff 64bit]
> [  +0.000013] pci 0000:47:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [  +0.000117] pci 0000:47:00.3: PME# supported from D3hot D3cold
> [  +0.003680] pci 0000:40:0c.0: PCI bridge to [bus 47-49]
> [  +0.000010] pci 0000:40:0c.0:   bridge window [mem 0xfde00000-0xfdffffff]
> [  +0.002333] ACPI: PCI: Interrupt link I020 configured for IRQ 56
> [  +0.002158] ACPI: PCI: Interrupt link I021 configured for IRQ 57
> [  +0.002188] ACPI: PCI: Interrupt link I022 configured for IRQ 58
> [  +0.002305] ACPI: PCI: Interrupt link I023 configured for IRQ 59
> [  +0.002139] ACPI: PCI: Interrupt link I030 configured for IRQ 56
> [  +0.002178] ACPI: PCI: Interrupt link I031 configured for IRQ 57
> [  +0.002691] ACPI: PCI: Interrupt link I032 configured for IRQ 58
> [  +0.002230] ACPI: PCI: Interrupt link I033 configured for IRQ 59
> [  +0.002208] ACPI: PCI: Interrupt link I040 configured for IRQ 76
> [  +0.002223] ACPI: PCI: Interrupt link I041 configured for IRQ 77
> [  +0.002550] ACPI: PCI: Interrupt link I042 configured for IRQ 78
> [  +0.002263] ACPI: PCI: Interrupt link I043 configured for IRQ 79
> [  +0.002216] ACPI: PCI: Interrupt link I050 configured for IRQ 80
> [  +0.002315] ACPI: PCI: Interrupt link I051 configured for IRQ 81
> [  +0.002264] ACPI: PCI: Interrupt link I052 configured for IRQ 82
> [  +0.002313] ACPI: PCI: Interrupt link I053 configured for IRQ 83
> [  +0.002399] ACPI: PCI: Interrupt link I060 configured for IRQ 79
> [  +0.002239] ACPI: PCI: Interrupt link I061 configured for IRQ 76
> [  +0.002258] ACPI: PCI: Interrupt link I062 configured for IRQ 77
> [  +0.002397] ACPI: PCI: Interrupt link I063 configured for IRQ 78
> [  +0.002288] ACPI: PCI: Interrupt link I070 configured for IRQ 56
> [  +0.002308] ACPI: PCI: Interrupt link I071 configured for IRQ 57
> [  +0.002439] ACPI: PCI: Interrupt link I072 configured for IRQ 58
> [  +0.002444] ACPI: PCI: Interrupt link I073 configured for IRQ 59
> [  +0.000600] ACPI: PCI: Interrupt link I090 configured for IRQ 24
> [  +0.000514] ACPI: PCI: Interrupt link I091 configured for IRQ 24
> [  +0.000610] ACPI: PCI: Interrupt link I092 configured for IRQ 24
> [  +0.000510] ACPI: PCI: Interrupt link I093 configured for IRQ 24
> [  +0.002415] ACPI: PCI: Interrupt link I0A0 configured for IRQ 56
> [  +0.002383] ACPI: PCI: Interrupt link I0A1 configured for IRQ 57
> [  +0.002797] ACPI: PCI: Interrupt link I0A2 configured for IRQ 58
> [  +0.002424] ACPI: PCI: Interrupt link I0A3 configured for IRQ 59
> [  +0.002439] ACPI: PCI: Interrupt link I0B0 configured for IRQ 64
> [  +0.002414] ACPI: PCI: Interrupt link I0B1 configured for IRQ 65
> [  +0.002497] ACPI: PCI: Interrupt link I0B2 configured for IRQ 66
> [  +0.002470] ACPI: PCI: Interrupt link I0B3 configured for IRQ 67
> [  +0.002471] ACPI: PCI: Interrupt link I0C0 configured for IRQ 68
> [  +0.002432] ACPI: PCI: Interrupt link I0C1 configured for IRQ 69
> [  +0.002547] ACPI: PCI: Interrupt link I0C2 configured for IRQ 70
> [  +0.002499] ACPI: PCI: Interrupt link I0C3 configured for IRQ 71
> [  +0.002497] ACPI: PCI: Interrupt link I0D0 configured for IRQ 72
> [  +0.002477] ACPI: PCI: Interrupt link I0D1 configured for IRQ 73
> [  +0.002553] ACPI: PCI: Interrupt link I0D2 configured for IRQ 74
> [  +0.002553] ACPI: PCI: Interrupt link I0D3 configured for IRQ 75
> [  +0.000228] ACPI: PCI: Interrupt link BI02 configured for IRQ 84
> [  +0.000324] ACPI: PCI: Interrupt link BI03 configured for IRQ 56
> [  +0.000295] ACPI: PCI: Interrupt link BI04 configured for IRQ 56
> [  +0.000326] ACPI: PCI: Interrupt link BI05 configured for IRQ 56
> [  +0.000444] ACPI: PCI: Interrupt link BI06 configured for IRQ 86
> [  +0.000394] ACPI: PCI: Interrupt link BI07 configured for IRQ 56
> [  +0.000514] ACPI: PCI: Interrupt link BI08 configured for IRQ 56
> [  +0.000466] ACPI: PCI: Interrupt link BI09 configured for IRQ 56
> [  +0.000563] ACPI: PCI: Interrupt link BI0A configured for IRQ 56
> [  +0.000520] ACPI: PCI: Interrupt link BI0B configured for IRQ 86
> [  +0.000636] ACPI: PCI: Interrupt link BI0C configured for IRQ 86
> [  +0.000588] ACPI: PCI: Interrupt link BI0D configured for IRQ 86
> [  +0.000388] ACPI: PCI: Interrupt link PI20 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI20 disabled
> [  +0.000383] ACPI: PCI: Interrupt link PI21 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI21 disabled
> [  +0.000488] ACPI: PCI: Interrupt link PI22 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI22 disabled
> [  +0.000382] ACPI: PCI: Interrupt link PI23 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI23 disabled
> [  +0.000458] ACPI: PCI: Interrupt link PI30 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI30 disabled
> [  +0.000381] ACPI: PCI: Interrupt link PI31 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI31 disabled
> [  +0.000381] ACPI: PCI: Interrupt link PI32 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI32 disabled
> [  +0.000440] ACPI: PCI: Interrupt link PI33 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI33 disabled
> [  +0.000381] ACPI: PCI: Interrupt link PI40 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI40 disabled
> [  +0.000468] ACPI: PCI: Interrupt link PI41 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI41 disabled
> [  +0.000382] ACPI: PCI: Interrupt link PI42 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI42 disabled
> [  +0.000381] ACPI: PCI: Interrupt link PI43 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI43 disabled
> [  +0.000485] ACPI: PCI: Interrupt link PI50 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI50 disabled
> [  +0.000379] ACPI: PCI: Interrupt link PI51 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI51 disabled
> [  +0.000448] ACPI: PCI: Interrupt link PI52 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI52 disabled
> [  +0.000376] ACPI: PCI: Interrupt link PI53 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI53 disabled
> [  +0.000375] ACPI: PCI: Interrupt link PI60 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI60 disabled
> [  +0.000445] ACPI: PCI: Interrupt link PI61 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI61 disabled
> [  +0.000380] ACPI: PCI: Interrupt link PI62 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI62 disabled
> [  +0.000447] ACPI: PCI: Interrupt link PI63 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI63 disabled
> [  +0.000380] ACPI: PCI: Interrupt link PI70 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI70 disabled
> [  +0.000469] ACPI: PCI: Interrupt link PI71 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI71 disabled
> [  +0.000393] ACPI: PCI: Interrupt link PI72 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI72 disabled
> [  +0.000382] ACPI: PCI: Interrupt link PI73 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI73 disabled
> [  +0.000449] ACPI: PCI: Interrupt link PI90 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI90 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PI91 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI91 disabled
> [  +0.000441] ACPI: PCI: Interrupt link PI92 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PI92 disabled
> [  +0.000390] ACPI: PCI: Interrupt link PI93 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PI93 disabled
> [  +0.000380] ACPI: PCI: Interrupt link PIA0 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA0 disabled
> [  +0.000449] ACPI: PCI: Interrupt link PIA1 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA1 disabled
> [  +0.000380] ACPI: PCI: Interrupt link PIA2 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA2 disabled
> [  +0.000467] ACPI: PCI: Interrupt link PIA3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIA3 disabled
> [  +0.000377] ACPI: PCI: Interrupt link PIB0 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIB0 disabled
> [  +0.000376] ACPI: PCI: Interrupt link PIB1 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIB1 disabled
> [  +0.000522] ACPI: PCI: Interrupt link PIB2 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIB2 disabled
> [  +0.000380] ACPI: PCI: Interrupt link PIB3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIB3 disabled
> [  +0.000456] ACPI: PCI: Interrupt link PIC0 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIC0 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIC1 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIC1 disabled
> [  +0.000445] ACPI: PCI: Interrupt link PIC2 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIC2 disabled
> [  +0.000376] ACPI: PCI: Interrupt link PIC3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIC3 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PID0 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PID0 disabled
> [  +0.000477] ACPI: PCI: Interrupt link PID1 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PID1 disabled
> [  +0.000377] ACPI: PCI: Interrupt link PID2 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PID2 disabled
> [  +0.000449] ACPI: PCI: Interrupt link PID3 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PID3 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIR2 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIR2 disabled
> [  +0.000446] ACPI: PCI: Interrupt link PIR3 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR3 disabled
> [  +0.000381] ACPI: PCI: Interrupt link PIR4 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR4 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIR5 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIR5 disabled
> [  +0.000462] ACPI: PCI: Interrupt link PIR6 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR6 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIR7 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR7 disabled
> [  +0.000466] ACPI: PCI: Interrupt link PIR8 configured for IRQ 0
> [  +0.000001] ACPI: PCI: Interrupt link PIR8 disabled
> [  +0.000382] ACPI: PCI: Interrupt link PIR9 configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIR9 disabled
> [  +0.000378] ACPI: PCI: Interrupt link PIRA configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIRA disabled
> [  +0.000452] ACPI: PCI: Interrupt link PIRB configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIRB disabled
> [  +0.000381] ACPI: PCI: Interrupt link PIRC configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIRC disabled
> [  +0.000441] ACPI: PCI: Interrupt link PIRD configured for IRQ 0
> [  +0.000002] ACPI: PCI: Interrupt link PIRD disabled
> [  +0.002031] iommu: Default domain type: Translated 
> [  +0.000000] iommu: DMA domain TLB invalidation policy: lazy mode 
> [  +0.001100] SCSI subsystem initialized
> [  +0.000124] ACPI: bus type USB registered
> [  +0.000142] usbcore: registered new interface driver usbfs
> [  +0.000058] usbcore: registered new interface driver hub
> [  +0.000108] usbcore: registered new device driver usb
> [  +0.000148] pps_core: LinuxPPS API ver. 1 registered
> [  +0.000001] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [  +0.000014] PTP clock support registered
> [  +0.000255] EDAC MC: Ver: 3.0.0
> [  +0.002310] NetLabel: Initializing
> [  +0.000001] NetLabel:  domain hash size = 128
> [  +0.000001] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [  +0.000072] NetLabel:  unlabeled traffic allowed by default
> [  +0.000001] PCI: Using ACPI for IRQ routing
> [  +0.019602] PCI: pci_cache_line_size set to 64 bytes
> [  +0.000232] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
> [  +0.000004] e820: reserve RAM buffer [mem 0xbde0e000-0xbfffffff]
> [  +0.000003] e820: reserve RAM buffer [mem 0xbde4f000-0xbfffffff]
> [  +0.000002] e820: reserve RAM buffer [mem 0xfcfefff000-0xfcffffffff]
> [  +0.000951] pci 0000:01:03.0: vgaarb: setting as boot VGA device
> [  +0.000000] pci 0000:01:03.0: vgaarb: bridge control possible
> [  +0.000000] pci 0000:01:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [  +0.000000] vgaarb: loaded
> [  +0.000750] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [  +0.000008] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
> [  +0.334122] clocksource: Switched to clocksource tsc-early
> [  +0.002255] VFS: Disk quotas dquot_6.6.0
> [  +0.000072] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [  +0.000487] pnp: PnP ACPI init
> [  +0.008350] system 00:00: [io  0x0379-0x037a] has been reserved
> [  +0.000005] system 00:00: [io  0x0400-0x043f] has been reserved
> [  +0.000004] system 00:00: [io  0x04d0-0x04d1] has been reserved
> [  +0.000003] system 00:00: [io  0x04d6] has been reserved
> [  +0.000004] system 00:00: [io  0x0520] has been reserved
> [  +0.000003] system 00:00: [io  0x0580-0x059f] has been reserved
> [  +0.000003] system 00:00: [io  0x0600-0x067f] has been reserved
> [  +0.000003] system 00:00: [io  0x0700-0x0703] has been reserved
> [  +0.000003] system 00:00: [io  0x0820-0x082f] has been reserved
> [  +0.000004] system 00:00: [io  0x0900-0x09fe] has been reserved
> [  +0.000003] system 00:00: [io  0x0c06-0x0c07] has been reserved
> [  +0.000003] system 00:00: [io  0x0c14] has been reserved
> [  +0.000003] system 00:00: [io  0x0c4a] has been reserved
> [  +0.000003] system 00:00: [io  0x0c50-0x0c52] has been reserved
> [  +0.000003] system 00:00: [io  0x0c6c] has been reserved
> [  +0.000003] system 00:00: [io  0x0c6f] has been reserved
> [  +0.000003] system 00:00: [io  0x0c80-0x0c83] has been reserved
> [  +0.000003] system 00:00: [io  0x0c90-0x0c9f] has been reserved
> [  +0.000003] system 00:00: [io  0x0ca0-0x0ca5] could not be reserved
> [  +0.000004] system 00:00: [io  0x0cd0-0x0cdf] has been reserved
> [  +0.000003] system 00:00: [io  0x0f50-0x0f58] has been reserved
> [  +0.000003] system 00:00: [io  0x0b00-0x0b3f] has been reserved
> [  +0.000004] system 00:00: [io  0x02f8-0x02ff] has been reserved
> [  +0.000003] system 00:00: [mem 0xc0000000-0xcfffffff] has been reserved
> [  +0.008671] pnp: PnP ACPI: found 5 devices
> [  +0.016997] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [  +0.000330] NET: Registered PF_INET protocol family
> [  +0.000902] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> [  +0.005514] tcp_listen_portaddr_hash hash table entries: 65536 (order: 10, 4718592 bytes, vmalloc)
> [  +0.002826] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
> [  +0.000239] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
> [  +0.001898] TCP bind hash table entries: 65536 (order: 10, 4718592 bytes, vmalloc)
> [  +0.002507] TCP: Hash tables configured (established 524288 bind 65536)
> [  +0.002728] MPTCP token hash table entries: 65536 (order: 10, 5767168 bytes, vmalloc)
> [  +0.002365] UDP hash table entries: 65536 (order: 11, 10485760 bytes, vmalloc)
> [  +0.005678] UDP-Lite hash table entries: 65536 (order: 11, 10485760 bytes, vmalloc)
> [  +0.006268] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [  +0.000019] NET: Registered PF_XDP protocol family
> [  +0.000050] pci 0000:00:02.0: PCI bridge to [bus 04]
> [  +0.000010] pci 0000:00:02.0:   bridge window [mem 0xee000000-0xfdbfffff]
> [  +0.000015] pci 0000:03:00.0: BAR 6: assigned [mem 0xedd00000-0xedd7ffff pref]
> [  +0.000004] pci 0000:00:04.0: PCI bridge to [bus 03]
> [  +0.000003] pci 0000:00:04.0:   bridge window [io  0x4000-0x4fff]
> [  +0.000005] pci 0000:00:04.0:   bridge window [mem 0xedd00000-0xedffffff]
> [  +0.000011] pci 0000:02:00.2: BAR 6: assigned [mem 0xeda00000-0xeda0ffff pref]
> [  +0.000004] pci 0000:00:0a.0: PCI bridge to [bus 02]
> [  +0.000002] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
> [  +0.000005] pci 0000:00:0a.0:   bridge window [mem 0xeda00000-0xedcfffff]
> [  +0.000013] pci 0000:00:14.4: PCI bridge to [bus 01]
> [  +0.000003] pci 0000:00:14.4:   bridge window [io  0x2000-0x2fff]
> [  +0.000008] pci 0000:00:14.4:   bridge window [mem 0xed900000-0xed9fffff]
> [  +0.000005] pci 0000:00:14.4:   bridge window [mem 0xe0000000-0xe7ffffff pref]
> [  +0.000031] pci_bus 0000:00: resource 4 [mem 0xdff00000-0xfdbfffff window]
> [  +0.000002] pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
> [  +0.000002] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
> [  +0.000002] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
> [  +0.000001] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
> [  +0.000002] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed03fff window]
> [  +0.000002] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed44fff window]
> [  +0.000001] pci_bus 0000:00: resource 11 [io  0x03b0-0x03bb window]
> [  +0.000002] pci_bus 0000:00: resource 12 [io  0x03c0-0x03df window]
> [  +0.000002] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
> [  +0.000002] pci_bus 0000:04: resource 1 [mem 0xee000000-0xfdbfffff]
> [  +0.000002] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
> [  +0.000002] pci_bus 0000:03: resource 1 [mem 0xedd00000-0xedffffff]
> [  +0.000002] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
> [  +0.000001] pci_bus 0000:02: resource 1 [mem 0xeda00000-0xedcfffff]
> [  +0.000002] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
> [  +0.000002] pci_bus 0000:01: resource 1 [mem 0xed900000-0xed9fffff]
> [  +0.000001] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xe7ffffff pref]
> [  +0.000002] pci_bus 0000:01: resource 4 [mem 0xdff00000-0xfdbfffff window]
> [  +0.000001] pci_bus 0000:01: resource 5 [io  0x1000-0xffff window]
> [  +0.000002] pci_bus 0000:01: resource 6 [io  0x0000-0x03af window]
> [  +0.000001] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
> [  +0.000002] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
> [  +0.000001] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed03fff window]
> [  +0.000002] pci_bus 0000:01: resource 10 [mem 0xfed40000-0xfed44fff window]
> [  +0.000002] pci_bus 0000:01: resource 11 [io  0x03b0-0x03bb window]
> [  +0.000001] pci_bus 0000:01: resource 12 [io  0x03c0-0x03df window]
> [  +0.000002] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
> [  +0.000515] pci 0000:47:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
> [  +0.000004] pci 0000:47:00.1: BAR 6: assigned [mem 0xfde40000-0xfde7ffff pref]
> [  +0.000004] pci 0000:47:00.2: BAR 6: no space for [mem size 0x00040000 pref]
> [  +0.000016] pci 0000:47:00.2: BAR 6: failed to assign [mem size 0x00040000 pref]
> [  +0.000004] pci 0000:47:00.3: BAR 6: no space for [mem size 0x00040000 pref]
> [  +0.000002] pci 0000:47:00.3: BAR 6: failed to assign [mem size 0x00040000 pref]
> [  +0.000003] pci 0000:40:0c.0: PCI bridge to [bus 47-49]
> [  +0.000005] pci 0000:40:0c.0:   bridge window [mem 0xfde00000-0xfdffffff]
> [  +0.000006] pci_bus 0000:40: resource 4 [mem 0xfdd00000-0xfdffffff window]
> [  +0.000002] pci_bus 0000:47: resource 1 [mem 0xfde00000-0xfdffffff]
> [  +0.000957] ACPI: \_SB_.PCI0.USB1: Enabled at IRQ 22
> [  +0.012394] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x140 took 12589 usecs
> [  +0.011831] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x140 took 11536 usecs
> [  +0.000445] ACPI: \_SB_.PCI0.USB2: Enabled at IRQ 23
> [  +0.011545] pci 0000:00:12.2: quirk_usb_early_handoff+0x0/0x140 took 11690 usecs
> [  +0.000438] ACPI: \_SB_.PCI0.USB3: Enabled at IRQ 23
> [  +0.011569] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x140 took 11712 usecs
> [  +0.012000] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x140 took 11705 usecs
> [  +0.000469] ACPI: \_SB_.PCI0.USB4: Enabled at IRQ 22
> [  +0.011525] pci 0000:00:13.2: quirk_usb_early_handoff+0x0/0x140 took 11691 usecs
> [  +0.000800] ACPI: \_SB_.PCI0.BI0A: Enabled at IRQ 24
> [  +0.000980] ACPI: \_SB_.PCI0.I061: Enabled at IRQ 44
> [  +0.000219] PCI: CLS 64 bytes, default 64
> [  +0.000090] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [  +0.000001] software IO TLB: mapped [mem 0x0000000099000000-0x000000009d000000] (64MB)
> [  +0.000031] ACPI: bus type thunderbolt registered
> [  +0.000294] LVT offset 0 assigned for vector 0x400
> [  +0.000332] Unpacking initramfs...
> [  +0.153800] perf: AMD IBS detected (0x000000ff)
> [  +0.000337] amd_uncore: 4  amd_nb counters detected
> [  +0.728743] Initialise system trusted keyrings
> [  +0.000163] Key type blacklist registered
> [  +0.002478] workingset: timestamp_bits=36 max_order=28 bucket_order=0
> [  +0.026682] zbud: loaded
> [  +0.489000] tsc: Refined TSC clocksource calibration: 2593.528 MHz
> [  +0.000065] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25625a45293, max_idle_ns: 440795282137 ns
> [  +0.045326] Freeing initrd memory: 55316K
> [  +0.000182] clocksource: Switched to clocksource tsc
> [  +0.014614] integrity: Platform Keyring initialized
> [  +0.012584] NET: Registered PF_ALG protocol family
> [  +0.000032] xor: automatically using best checksumming function   avx       
> [  +0.000002] Key type asymmetric registered
> [  +0.000013] Asymmetric key parser 'x509' registered
> [  +0.026294] alg: self-tests for CTR-KDF (hmac(sha256)) passed
> [  +0.000089] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [  +0.000403] io scheduler mq-deadline registered
> [  +0.000002] io scheduler kyber registered
> [  +0.000329] io scheduler bfq registered
> [  +0.404330] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [  +0.003814] ACPI: \_SB_.PCI0.BI02: Enabled at IRQ 52
> [  +0.002781] ACPI: \_SB_.PCI0.BI04: Enabled at IRQ 52
> [  +0.002646] ACPI: \_SB_.PCI1.BI0C: Enabled at IRQ 86
> [  +0.001570] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [  +0.002126] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [  +0.001165] ACPI: button: Power Button [PWRF]
> [  +0.000227] ACPI: \_SB_.C000: Found 2 idle states
> [  +0.000853] ACPI: \_SB_.C00C: Found 2 idle states
> [  +0.000552] ACPI: \_SB_.C018: Found 2 idle states
> [  +0.000540] ACPI: \_SB_.C024: Found 2 idle states
> [  +0.000549] ACPI: \_SB_.C001: Found 2 idle states
> [  +0.000506] ACPI: \_SB_.C00D: Found 2 idle states
> [  +0.000568] ACPI: \_SB_.C019: Found 2 idle states
> [  +0.000526] ACPI: \_SB_.C025: Found 2 idle states
> [  +0.000567] ACPI: \_SB_.C002: Found 2 idle states
> [  +0.000539] ACPI: \_SB_.C00E: Found 2 idle states
> [  +0.000517] ACPI: \_SB_.C01A: Found 2 idle states
> [  +0.000548] ACPI: \_SB_.C026: Found 2 idle states
> [  +0.000529] ACPI: \_SB_.C003: Found 2 idle states
> [  +0.000639] ACPI: \_SB_.C00F: Found 2 idle states
> [  +0.000510] ACPI: \_SB_.C01B: Found 2 idle states
> [  +0.000549] ACPI: \_SB_.C027: Found 2 idle states
> [  +0.000513] ACPI: \_SB_.C004: Found 2 idle states
> [  +0.000573] ACPI: \_SB_.C010: Found 2 idle states
> [  +0.000517] ACPI: \_SB_.C01C: Found 2 idle states
> [  +0.000903] ACPI: \_SB_.C028: Found 2 idle states
> [  +0.000539] ACPI: \_SB_.C005: Found 2 idle states
> [  +0.000543] ACPI: \_SB_.C011: Found 2 idle states
> [  +0.000550] ACPI: \_SB_.C01D: Found 2 idle states
> [  +0.000558] ACPI: \_SB_.C029: Found 2 idle states
> [  +0.000523] ACPI: \_SB_.C006: Found 2 idle states
> [  +0.000538] ACPI: \_SB_.C012: Found 2 idle states
> [  +0.000516] ACPI: \_SB_.C01E: Found 2 idle states
> [  +0.000570] ACPI: \_SB_.C02A: Found 2 idle states
> [  +0.000533] ACPI: \_SB_.C007: Found 2 idle states
> [  +0.277512] ACPI: \_SB_.C013: Found 2 idle states
> [  +0.000267] ACPI: \_SB_.C01F: Found 2 idle states
> [  +0.000271] ACPI: \_SB_.C02B: Found 2 idle states
> [  +0.000273] ACPI: \_SB_.C008: Found 2 idle states
> [  +0.000264] ACPI: \_SB_.C014: Found 2 idle states
> [  +0.000249] ACPI: \_SB_.C020: Found 2 idle states
> [  +0.000269] ACPI: \_SB_.C02C: Found 2 idle states
> [  +0.000276] ACPI: \_SB_.C009: Found 2 idle states
> [  +0.000270] ACPI: \_SB_.C015: Found 2 idle states
> [  +0.000249] ACPI: \_SB_.C021: Found 2 idle states
> [  +0.000264] ACPI: \_SB_.C02D: Found 2 idle states
> [  +0.000286] ACPI: \_SB_.C00A: Found 2 idle states
> [  +0.000268] ACPI: \_SB_.C016: Found 2 idle states
> [  +0.000262] ACPI: \_SB_.C022: Found 2 idle states
> [  +0.000302] ACPI: \_SB_.C02E: Found 2 idle states
> [  +0.000279] ACPI: \_SB_.C00B: Found 2 idle states
> [  +0.000265] ACPI: \_SB_.C017: Found 2 idle states
> [  +0.000260] ACPI: \_SB_.C023: Found 2 idle states
> [  +0.000284] ACPI: \_SB_.C02F: Found 2 idle states
> [  +0.001048] ERST: Failed to get Error Log Address Range.
> [  +0.000753] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [  +0.000353] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [  +0.119374] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [  +0.004995] Non-volatile memory driver v1.3
> [  +0.031863] rdac: device handler registered
> [  +0.000306] hp_sw: device handler registered
> [  +0.000002] emc: device handler registered
> [  +0.001049] alua: device handler registered
> [  +0.000858] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [  +0.000040] ehci-pci: EHCI PCI platform driver
> [  +0.001304] ehci-pci 0000:00:12.2: EHCI Host Controller
> [  +0.001178] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
> [  +0.000071] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [  +0.000030] ehci-pci 0000:00:12.2: debug port 1
> [  +0.000376] ehci-pci 0000:00:12.2: irq 23, io mem 0xed8c0000
> [  +0.006559] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
> [  +0.000974] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
> [  +0.000008] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  +0.000005] usb usb1: Product: EHCI Host Controller
> [  +0.000003] usb usb1: Manufacturer: Linux 5.19.0-rc2+ ehci_hcd
> [  +0.000004] usb usb1: SerialNumber: 0000:00:12.2
> [  +0.002055] hub 1-0:1.0: USB hub found
> [  +0.000120] hub 1-0:1.0: 6 ports detected
> [  +0.003963] ehci-pci 0000:00:13.2: EHCI Host Controller
> [  +0.000565] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
> [  +0.000056] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [  +0.000022] ehci-pci 0000:00:13.2: debug port 1
> [  +0.000204] ehci-pci 0000:00:13.2: irq 22, io mem 0xed890000
> [  +0.006939] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
> [  +0.000477] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
> [  +0.000007] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  +0.000005] usb usb2: Product: EHCI Host Controller
> [  +0.000004] usb usb2: Manufacturer: Linux 5.19.0-rc2+ ehci_hcd
> [  +0.000003] usb usb2: SerialNumber: 0000:00:13.2
> [  +0.001067] hub 2-0:1.0: USB hub found
> [  +0.000062] hub 2-0:1.0: 6 ports detected
> [  +0.002208] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [  +0.000018] ohci-pci: OHCI PCI platform driver
> [  +0.000809] ohci-pci 0000:00:12.0: OHCI PCI host controller
> [  +0.000721] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
> [  +0.000240] ohci-pci 0000:00:12.0: irq 22, io mem 0xed8e0000
> [  +0.055946] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [  +0.000009] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  +0.000005] usb usb3: Product: OHCI PCI host controller
> [  +0.000004] usb usb3: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [  +0.000003] usb usb3: SerialNumber: 0000:00:12.0
> [  +0.001377] hub 3-0:1.0: USB hub found
> [  +0.000126] hub 3-0:1.0: 3 ports detected
> [  +0.002431] ohci-pci 0000:00:12.1: OHCI PCI host controller
> [  +0.000572] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 4
> [  +0.000216] ohci-pci 0000:00:12.1: irq 22, io mem 0xed8d0000
> [  +0.056100] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [  +0.000009] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  +0.000006] usb usb4: Product: OHCI PCI host controller
> [  +0.000003] usb usb4: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [  +0.000004] usb usb4: SerialNumber: 0000:00:12.1
> [  +0.001089] hub 4-0:1.0: USB hub found
> [  +0.000065] hub 4-0:1.0: 3 ports detected
> [  +0.002124] ohci-pci 0000:00:13.0: OHCI PCI host controller
> [  +0.000444] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
> [  +0.000129] ohci-pci 0000:00:13.0: irq 23, io mem 0xed8b0000
> [  +0.056136] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [  +0.000009] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  +0.000005] usb usb5: Product: OHCI PCI host controller
> [  +0.000003] usb usb5: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [  +0.000004] usb usb5: SerialNumber: 0000:00:13.0
> [  +0.001124] hub 5-0:1.0: USB hub found
> [  +0.000065] hub 5-0:1.0: 3 ports detected
> [  +0.002232] ohci-pci 0000:00:13.1: OHCI PCI host controller
> [  +0.000401] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 6
> [  +0.000132] ohci-pci 0000:00:13.1: irq 23, io mem 0xed8a0000
> [  +0.056039] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [  +0.000009] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  +0.000005] usb usb6: Product: OHCI PCI host controller
> [  +0.000004] usb usb6: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [  +0.000003] usb usb6: SerialNumber: 0000:00:13.1
> [  +0.001062] hub 6-0:1.0: USB hub found
> [  +0.000066] hub 6-0:1.0: 3 ports detected
> [  +0.001415] uhci_hcd: USB Universal Host Controller Interface driver
> [  +0.000992] uhci_hcd 0000:02:00.4: UHCI Host Controller
> [  +0.000372] uhci_hcd 0000:02:00.4: new USB bus registered, assigned bus number 7
> [  +0.000030] uhci_hcd 0000:02:00.4: detected 8 ports
> [  +0.000004] uhci_hcd 0000:02:00.4: port count misdetected? forcing to 2 ports
> [  +0.000171] uhci_hcd 0000:02:00.4: irq 32, io port 0x00003c00
> [  +0.000520] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [  +0.000007] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  +0.000005] usb usb7: Product: UHCI Host Controller
> [  +0.000003] usb usb7: Manufacturer: Linux 5.19.0-rc2+ uhci_hcd
> [  +0.000004] usb usb7: SerialNumber: 0000:02:00.4
> [  +0.001117] hub 7-0:1.0: USB hub found
> [  +0.000077] hub 7-0:1.0: 2 ports detected
> [  +0.001440] usbcore: registered new interface driver usbserial_generic
> [  +0.000181] usbserial: USB Serial support registered for generic
> [  +0.000154] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
> [  +0.002278] serio: i8042 KBD port at 0x60,0x64 irq 1
> [  +0.000108] serio: i8042 AUX port at 0x60,0x64 irq 12
> [  +0.001067] mousedev: PS/2 mouse device common for all mice
> [  +0.000860] rtc_cmos 00:04: RTC can wake from S4
> [  +0.001231] rtc_cmos 00:04: registered as rtc0
> [  +0.000138] rtc_cmos 00:04: setting system clock to 2022-06-21T23:09:20 UTC (1655852960)
> [  +0.000164] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [  +0.006362] hid: raw HID events driver (C) Jiri Kosina
> [  +0.000210] usbcore: registered new interface driver usbhid
> [  +0.000002] usbhid: USB HID core driver
> [  +0.000417] drop_monitor: Initializing network drop monitor service
> [  +0.000250] Initializing XFRM netlink socket
> [  +0.001082] NET: Registered PF_INET6 protocol family
> [  +0.004919] Segment Routing with IPv6
> [  +0.000036] In-situ OAM (IOAM) with IPv6
> [  +0.000105] NET: Registered PF_PACKET protocol family
> [  +0.000545] mpls_gso: MPLS GSO support
> [  +0.000009] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
> [  +0.197151] usb 7-1: new full-speed USB device number 2 using uhci_hcd
> [  +0.134119] microcode: CPU0: patch_level=0x06000822
> [  +0.000140] microcode: CPU1: patch_level=0x06000822
> [  +0.000162] microcode: CPU2: patch_level=0x06000822
> [  +0.000159] microcode: CPU3: patch_level=0x06000822
> [  +0.000038] microcode: CPU4: patch_level=0x06000822
> [  +0.000023] microcode: CPU5: patch_level=0x06000822
> [  +0.000034] microcode: CPU6: patch_level=0x06000822
> [  +0.000034] microcode: CPU7: patch_level=0x06000822
> [  +0.000163] microcode: CPU8: patch_level=0x06000822
> [  +0.000159] microcode: CPU9: patch_level=0x06000822
> [  +0.000161] microcode: CPU10: patch_level=0x06000822
> [  +0.000161] microcode: CPU11: patch_level=0x06000822
> [  +0.000092] microcode: CPU12: patch_level=0x06000822
> [  +0.000090] microcode: CPU13: patch_level=0x06000822
> [  +0.000037] microcode: CPU14: patch_level=0x06000822
> [  +0.000033] microcode: CPU15: patch_level=0x06000822
> [  +0.000182] microcode: CPU16: patch_level=0x06000822
> [  +0.000201] microcode: CPU17: patch_level=0x06000822
> [  +0.000162] microcode: CPU18: patch_level=0x06000822
> [  +0.000159] microcode: CPU19: patch_level=0x06000822
> [  +0.000088] microcode: CPU20: patch_level=0x06000822
> [  +0.000093] microcode: CPU21: patch_level=0x06000822
> [  +0.000036] microcode: CPU22: patch_level=0x06000822
> [  +0.000034] microcode: CPU23: patch_level=0x06000822
> [  +0.000043] microcode: CPU24: patch_level=0x06000822
> [  +0.000157] microcode: CPU25: patch_level=0x06000822
> [  +0.000212] microcode: CPU26: patch_level=0x06000822
> [  +0.000159] microcode: CPU27: patch_level=0x06000822
> [  -0.002026] microcode: CPU28: patch_level=0x06000822
> [  +0.002703] microcode: CPU29: patch_level=0x06000822
> [  +0.000160] microcode: CPU30: patch_level=0x06000822
> [  +0.000157] microcode: CPU31: patch_level=0x06000822
> [  +0.000159] microcode: CPU32: patch_level=0x06000822
> [  +0.000058] microcode: CPU33: patch_level=0x06000822
> [  +0.000159] microcode: CPU34: patch_level=0x06000822
> [  +0.000161] microcode: CPU35: patch_level=0x06000822
> [  +0.000036] microcode: CPU36: patch_level=0x06000822
> [  +0.000034] microcode: CPU37: patch_level=0x06000822
> [  +0.000034] microcode: CPU38: patch_level=0x06000822
> [  +0.000058] microcode: CPU39: patch_level=0x06000822
> [  +0.000185] microcode: CPU40: patch_level=0x06000822
> [  +0.000170] microcode: CPU41: patch_level=0x06000822
> [  +0.000158] microcode: CPU42: patch_level=0x06000822
> [  +0.000157] microcode: CPU43: patch_level=0x06000822
> [  +0.000126] microcode: CPU44: patch_level=0x06000822
> [  +0.000127] microcode: CPU45: patch_level=0x06000822
> [  +0.000121] microcode: CPU46: patch_level=0x06000822
> [  +0.000036] microcode: CPU47: patch_level=0x06000822
> [  +0.000020] microcode: Microcode Update Driver: v2.2.
> [  +0.000014] IPI shorthand broadcast: enabled
> [  +0.000059] AVX version of gcm_enc/dec engaged.
> [  +0.010170] usb 7-1: New USB device found, idVendor=03f0, idProduct=7029, bcdDevice= 0.02
> [  +0.000010] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [  +0.000005] usb 7-1: Product: Virtual Keyboard 
> [  +0.000003] usb 7-1: Manufacturer: HP 
> [  +0.009581] input: HP  Virtual Keyboard  as /devices/pci0000:00/0000:00:0a.0/0000:02:00.4/usb7/7-1/7-1:1.0/0003:03F0:7029.0001/input/input4
> [  +0.012825] AES CTR mode by8 optimization enabled
> [  +0.003238] sched_clock: Marking stable (8303847158, 6399872472)->(16141248300, -1437528670)
> [  +0.038395] hid-generic 0003:03F0:7029.0001: input,hidraw0: USB HID v1.01 Keyboard [HP  Virtual Keyboard ] on usb-0000:02:00.4-1/input0
> [  +0.005202] input: HP  Virtual Keyboard  as /devices/pci0000:00/0000:00:0a.0/0000:02:00.4/usb7/7-1/7-1:1.1/0003:03F0:7029.0002/input/input5
> [  +0.001424] hid-generic 0003:03F0:7029.0002: input,hidraw1: USB HID v1.01 Mouse [HP  Virtual Keyboard ] on usb-0000:02:00.4-1/input1
> [  +0.377228] registered taskstats version 1
> [  +0.021337] Loading compiled-in X.509 certificates
> [  +0.108575] Loaded X.509 cert 'Build time autogenerated kernel key: 67cb6d2492a17d9861a4ac6ba7a04726ea6886bf'
> [  +0.010732] zswap: loaded using pool lzo/zbud
> [  +0.408069] page_owner is disabled
> [  +0.000227] Key type big_key registered
> [  +0.503695] Key type encrypted registered
> [  +0.000344] ima: No TPM chip found, activating TPM-bypass!
> [  +0.000047] Loading compiled-in module X.509 certificates
> [  +0.002176] Loaded X.509 cert 'Build time autogenerated kernel key: 67cb6d2492a17d9861a4ac6ba7a04726ea6886bf'
> [  +0.000011] ima: Allocated hash algorithm: sha256
> [  +0.000118] ima: No architecture policies found
> [  +0.000164] evm: Initialising EVM extended attributes:
> [  +0.000002] evm: security.selinux
> [  +0.000001] evm: security.SMACK64 (disabled)
> [  +0.000003] evm: security.SMACK64EXEC (disabled)
> [  +0.000001] evm: security.SMACK64TRANSMUTE (disabled)
> [  +0.000002] evm: security.SMACK64MMAP (disabled)
> [  +0.000002] evm: security.apparmor (disabled)
> [  +0.000002] evm: security.ima
> [  +0.000001] evm: security.capability
> [  +0.000002] evm: HMAC attrs: 0x1
> [  +1.531507] Freeing unused decrypted memory: 2036K
> [  +0.044295] Freeing unused kernel image (initmem) memory: 2572K
> [  +0.000083] Write protecting the kernel read-only data: 22528k
> [  +0.005554] Freeing unused kernel image (text/rodata gap) memory: 2040K
> [  +0.002772] Freeing unused kernel image (rodata/data gap) memory: 1124K
> [  +0.049228] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [  +0.000016] Run /init as init process
> [  +0.000002]   with arguments:
> [  +0.000003]     /init
> [  +0.000001]   with environment:
> [  +0.000001]     HOME=/
> [  +0.000001]     TERM=linux
> [  +0.000001]     BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+
> [  +0.460491] systemd[1]: systemd 250-6.el9_0 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [  +0.000909] systemd[1]: Detected architecture x86-64.
> [  +0.000005] systemd[1]: Running in initial RAM disk.
> [  +3.099469] systemd[1]: Hostname set to <hp-dl585g7-01.rhts.eng.pek2.redhat.com>.
> [  +0.431393] systemd[1]: Queued start job for default target Initrd Default Target.
> [  +1.134542] random: crng init done
> [  +0.509976] systemd[1]: Created slice Slice /system/systemd-hibernate-resume.
> [  +2.596181] systemd[1]: Reached target Initrd /usr File System.
> [  +1.307100] systemd[1]: Reached target Slice Units.
> [  +0.744004] systemd[1]: Reached target Swaps.
> [  +1.918991] systemd[1]: Reached target Timer Units.
> [  +1.178858] systemd[1]: Listening on D-Bus System Message Bus Socket.
> [  +1.540476] systemd[1]: Listening on Journal Socket (/dev/log).
> [  +0.508534] systemd[1]: Listening on Journal Socket.
> [  +1.026609] systemd[1]: Listening on udev Control Socket.
> [  +0.520136] systemd[1]: Listening on udev Kernel Socket.
> [  +0.004381] systemd[1]: Reached target Socket Units.
> [  +0.514093] systemd[1]: Starting Create List of Static Device Nodes...
> [  +0.017276] systemd[1]: Starting Journal Service...
> [  +0.015141] systemd[1]: Starting Load Kernel Modules...
> [  +0.004859] systemd[1]: Create System Users was skipped because of a failed condition check (ConditionNeedsUpdate=/etc).
> [  +0.008423] systemd[1]: Starting Setup Virtual Console...
> [  +0.010984] systemd[1]: Finished Create List of Static Device Nodes.
> [  +0.013800] systemd[1]: Starting Create Static Device Nodes in /dev...
> [  +0.018911] fuse: init (API version 7.36)
> [  +0.013412] IPMI message handler: version 39.2
> [  +0.007920] ipmi device interface
> [  +0.009735] systemd[1]: Finished Create Static Device Nodes in /dev.
> [  +0.007868] systemd[1]: Finished Load Kernel Modules.
> [  +0.406887] systemd[1]: Finished Setup Virtual Console.
> [  +0.004712] systemd[1]: dracut ask for additional cmdline parameters was skipped because all trigger condition checks failed.
> [  +0.010498] systemd[1]: Starting dracut cmdline hook...
> [  +0.014390] systemd[1]: Starting Apply Kernel Variables...
> [  +0.003998] systemd[1]: Started Journal Service.
> [  +0.807670] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [  +0.000342] device-mapper: uevent: version 1.0.3
> [  +0.001021] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
> [  +1.441081] ACPI: \_SB_.PCI0.I060: Enabled at IRQ 47
> [  +0.002224] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: NMI decoding initialized
> [  +0.004900] QLogic/NetXen Network Driver v4.0.82
> [  +0.003264] ACPI: \_SB_.PCI0.I020: Enabled at IRQ 24
> [  +0.000500] netxen_nic 0000:04:00.0: 2MB memory map
> [  +0.010376] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: Version: 2.0.4
> [  +0.000012] hpwdt 0000:02:00.0: timeout: 30 seconds (nowayout=0)
> [  +0.000005] hpwdt 0000:02:00.0: pretimeout: on.
> [  +0.000004] hpwdt 0000:02:00.0: kdumptimeout: -1.
> [  +0.052593] libata version 3.00 loaded.
> [  +0.095018] ACPI: bus type drm_connector registered
> [  +0.130249] netxen_nic 0000:04:00.0: Incompatibility detected between driver and firmware version on flash. This configuration is not recommended. Please update the firmware on flash immediately
> [  +0.001009] HP HPSA Driver (v 3.4.20-200)
> [  +0.000161] hpsa 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
> [  +0.004323] ACPI: \_SB_.PCI0.I040: Enabled at IRQ 44
> [  +0.005271] netxen_nic 0000:04:00.0: Direct firmware load for nx3fwct.bin failed with error -2
> [  +0.000131] ahci 0000:00:11.0: version 3.0
> [  +0.001822] ACPI: \_SB_.PCI0.SATA: Enabled at IRQ 16
> [  +0.003693] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
> [  +0.000010] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
> [  +0.002478] hpsa 0000:03:00.0: Logical aborts not supported
> [  +0.000005] hpsa 0000:03:00.0: HP SSD Smart Path aborts not supported
> [  +0.011770] scsi host1: ahci
> [  +0.003087] ata1: SATA max UDMA/133 abar m1024@0xed8f0000 port 0xed8f0100 irq 16
> [  +0.003472] scsi host0: hpsa
> [  +0.003129] hpsa can't handle SMP requests
> [  +0.016442] hpsa 0000:03:00.0: scsi 0:0:0:0: added RAID              HP       P410i            controller SSDSmartPathCap- En- Exp=1
> [  +0.000013] hpsa 0000:03:00.0: scsi 0:0:1:0: masked Direct-Access     HP       EG0146FAWHU      PHYS DRV SSDSmartPathCap- En- Exp=0
> [  +0.000009] hpsa 0000:03:00.0: scsi 0:0:2:0: masked Direct-Access     HP       EG0146FAWHU      PHYS DRV SSDSmartPathCap- En- Exp=0
> [  +0.000007] hpsa 0000:03:00.0: scsi 0:0:3:0: masked Enclosure         PMCSIERA  SRC 8x6G        enclosure SSDSmartPathCap- En- Exp=0
> [  +0.000008] hpsa 0000:03:00.0: scsi 0:1:0:0: added Direct-Access     HP       LOGICAL VOLUME   RAID-1(+0) SSDSmartPathCap- En- Exp=1
> [  +0.001112] hpsa can't handle SMP requests
> [  +0.002955] scsi 0:0:0:0: RAID              HP       P410i            5.14 PQ: 0 ANSI: 5
> [  +0.001959] scsi 0:1:0:0: Direct-Access     HP       LOGICAL VOLUME   5.14 PQ: 0 ANSI: 5
> [  +0.153842] netxen_nic 0000:04:00.0: Gen2 strapping detected
> [  +0.000048] netxen_nic 0000:04:00.0: using 64-bit dma mask
> [  +0.010947] netxen_nic: failed card response code:0x10
> [  +0.000009] netxen_nic 0000:04:00.0: Can't get template size 16843009
> [  +0.000007] netxen_nic 0000:04:00.0: Failed to setup minidump rcode = -5
> [  +0.000004] netxen_nic: NX3031 Gigabit Ethernet Board S/N \xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff  Chip rev 0x42
> [  +0.000005] netxen_nic 0000:04:00.0: Driver v4.0.82, firmware v4.0.527 [legacy]
> [  +0.000595] netxen_nic 0000:04:00.0: using msi-x interrupts
> [  +0.005474] netxen_nic 0000:04:00.0: eth0: GbE port initialized
> [  +0.001746] netxen_nic 0000:04:00.1: 2MB memory map
> [  +0.000145] netxen_nic 0000:04:00.1: using 64-bit dma mask
> [  +0.036025] [drm] radeon kernel modesetting enabled.
> [  +0.000877] radeon 0000:01:03.0: vgaarb: deactivate vga console
> [  +0.002946] Console: switching to colour dummy device 80x25
> [  +0.002452] ACPI: \_SB_.PCI0.VIDA: Enabled at IRQ 16
> [  +0.003973] [drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
> [  +0.000020] radeon 0000:01:03.0: vram limit (0) must be a power of 2
> [  +0.002204] radeon 0000:01:03.0: VRAM: 128M 0x00000000E0000000 - 0x00000000E7FFFFFF (64M used)
> [  +0.000009] radeon 0000:01:03.0: GTT: 512M 0x00000000C0000000 - 0x00000000DFFFFFFF
> [  +0.000079] [drm] Detected VRAM RAM=128M, BAR=128M
> [  +0.000004] [drm] RAM width 16bits DDR
> [  +0.002661] [drm] radeon: 64M of VRAM memory ready
> [  +0.000024] [drm] radeon: 512M of GTT memory ready.
> [  +0.000492] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [  +0.021922] [drm] PCI GART of 512M enabled (table at 0x0000000034600000).
> [  +0.000503] radeon 0000:01:03.0: WB disabled
> [  +0.000013] radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c0000000
> [  +0.001377] [drm] radeon: irq initialized.
> [  +0.000359] [drm] Loading R100 Microcode
> [  +0.024604] [drm] radeon: ring at 0x00000000C0001000
> [  +0.000164] [drm] ring test succeeded in 0 usecs
> [  +0.001824] [drm] ib test succeeded in 0 usecs
> [  +0.006508] ata1: SATA link down (SStatus 0 SControl 300)
> [  +0.006110] [drm] No TV DAC info found in BIOS
> [  +0.001653] [drm] Radeon Display Connectors
> [  +0.000007] [drm] Connector 0:
> [  +0.000102] [drm]   VGA-1
> [  +0.000006] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
> [  +0.000017] [drm]   Encoders:
> [  +0.000004] [drm]     CRT1: INTERNAL_DAC1
> [  +0.000007] [drm] Connector 1:
> [  +0.000006] [drm]   VGA-2
> [  +0.000004] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
> [  +0.000014] [drm]   Encoders:
> [  +0.000006] [drm]     CRT2: INTERNAL_DAC2
> [  +0.081427] [drm] fb mappable at 0xE0040000
> [  +0.000037] [drm] vram apper at 0xE0000000
> [  +0.000007] [drm] size 1572864
> [  +0.000005] [drm] fb depth is 16
> [  +0.000006] [drm]    pitch is 2048
> [  +0.000071] netxen_nic: failed card response code:0x10
> [  +0.000015] netxen_nic 0000:04:00.1: Can't get template size 16843009
> [  +0.000012] netxen_nic 0000:04:00.1: Failed to setup minidump rcode = -5
> [  +0.000011] netxen_nic 0000:04:00.1: Driver v4.0.82, firmware v4.0.527 [legacy]
> [  +0.002850] netxen_nic 0000:04:00.1: using msi-x interrupts
> [  +0.005542] netxen_nic 0000:04:00.1: eth1: GbE port initialized
> [  +0.004356] netxen_nic 0000:04:00.2: 2MB memory map
> [  +0.000275] netxen_nic 0000:04:00.2: using 64-bit dma mask
> [  +0.139956] fbcon: radeondrmfb (fb0) is primary device
> [  +0.095680] scsi 0:0:0:0: Attached scsi generic sg0 type 12
> [  +0.000473] scsi 0:1:0:0: Attached scsi generic sg1 type 0
> [  +0.057406] Console: switching to colour frame buffer device 128x48
> [  +0.000127] netxen_nic: failed card response code:0x10
> [  +0.000007] netxen_nic 0000:04:00.2: Can't get template size 16843009
> [  +0.000005] netxen_nic 0000:04:00.2: Failed to setup minidump rcode = -5
> [  +0.000005] netxen_nic 0000:04:00.2: Driver v4.0.82, firmware v4.0.527 [legacy]
> [  +0.000690] netxen_nic 0000:04:00.2: using msi-x interrupts
> [  +0.008092] sd 0:1:0:0: [sda] 286677120 512-byte logical blocks: (147 GB/137 GiB)
> [  +0.000840] sd 0:1:0:0: [sda] Write Protect is off
> [  +0.000007] sd 0:1:0:0: [sda] Mode Sense: 6b 00 00 08
> [  +0.001008] sd 0:1:0:0: [sda] Write cache: disabled, read cache: disabled, doesn't support DPO or FUA
> [  +0.024712]  sda: sda1 sda2
> [  +0.002199] sd 0:1:0:0: [sda] Attached SCSI disk
> [  +0.007342] radeon 0000:01:03.0: [drm] fb0: radeondrmfb frame buffer device
> [  +0.006273] netxen_nic 0000:04:00.2: eth2: GbE port initialized
> [  +0.001700] netxen_nic 0000:04:00.3: 2MB memory map
> [  +0.000213] netxen_nic 0000:04:00.3: using 64-bit dma mask
> [  +0.067912] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:03.0 on minor 0
> [  +0.043300] clocksource: timekeeping watchdog on CPU13: hpet wd-wd read-back delay of 78222ns
> [  +0.000075] clocksource: wd-tsc-wd read-back delay of 193600ns, clock-skew test skipped!
> [  +0.008689] netxen_nic: failed card response code:0x10
> [  +0.000081] netxen_nic 0000:04:00.3: Can't get template size 16843009
> [  +0.000005] netxen_nic 0000:04:00.3: Failed to setup minidump rcode = -5
> [  +0.000040] netxen_nic 0000:04:00.3: Driver v4.0.82, firmware v4.0.527 [legacy]
> [  +0.002194] netxen_nic 0000:04:00.3: using msi-x interrupts
> [  +0.001332] netxen_nic 0000:04:00.3: eth3: GbE port initialized
> [  +0.009674] netxen_nic 0000:04:00.2 enp4s0f2: renamed from eth2
> [  +0.022154] netxen_nic 0000:04:00.3 enp4s0f3: renamed from eth3
> [  +0.161496] netxen_nic 0000:04:00.0 enp4s0f0: renamed from eth0
> [  +0.103787] netxen_nic 0000:04:00.1 enp4s0f1: renamed from eth1
> [  +1.887558] PM: Image not found (code -22)
> [  +1.406457] SGI XFS with ACLs, security attributes, scrub, quota, no debug enabled
> [  +0.010494] XFS (dm-0): Mounting V5 Filesystem
> [  +0.136462] XFS (dm-0): Starting recovery (logdev: internal)
> [  +0.061715] XFS (dm-0): Ending recovery (logdev: internal)
> [  +1.394257] systemd-journald[592]: Received SIGTERM from PID 1 (systemd).
> [  +1.064109] audit: type=1404 audit(1655852991.787:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
> [  +0.357385] SELinux:  Class mctp_socket not defined in policy.
> [  +0.000013] SELinux:  Class io_uring not defined in policy.
> [  +0.000003] SELinux: the above unknown classes and permissions will be allowed
> [  +0.076377] SELinux:  policy capability network_peer_controls=1
> [  +0.000007] SELinux:  policy capability open_perms=1
> [  +0.000002] SELinux:  policy capability extended_socket_class=1
> [  +0.000002] SELinux:  policy capability always_check_network=0
> [  +0.000002] SELinux:  policy capability cgroup_seclabel=1
> [  +0.000002] SELinux:  policy capability nnp_nosuid_transition=1
> [  +0.000002] SELinux:  policy capability genfs_seclabel_symlinks=0
> [  +0.000001] SELinux:  policy capability ioctl_skip_cloexec=0
> [  +0.198350] audit: type=1403 audit(1655852992.420:3): auid=4294967295 ses=4294967295 lsm=selinux res=1
> [  +0.005363] systemd[1]: Successfully loaded SELinux policy in 645.300ms.
> [  +0.169517] systemd[1]: RTC configured in localtime, applying delta of -240 minutes to system time.
> [  +0.160906] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgroup in 129.838ms.
> [  +0.027597] systemd[1]: systemd 250-6.el9_0 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [  +0.000911] systemd[1]: Detected architecture x86-64.
> [  +0.242198] systemd-rc-local-generator[1035]: /etc/rc.d/rc.local is not marked executable, skipping.
> [Jun21 23:10] systemd[1]: initrd-switch-root.service: Deactivated successfully.
> [  +0.001475] systemd[1]: Stopped Switch Root.
> [  +0.002623] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
> [  +0.005763] systemd[1]: Created slice Slice /system/getty.
> [  +0.005268] systemd[1]: Created slice Slice /system/modprobe.
> [  +0.010275] systemd[1]: Created slice Slice /system/serial-getty.
> [  +0.005395] systemd[1]: Created slice Slice /system/sshd-keygen.
> [  +0.006114] systemd[1]: Created slice User and Session Slice.
> [  +0.000210] systemd[1]: Dispatch Password Requests to Console Directory Watch was skipped because of a failed condition check (ConditionPathExists=!/run/plymouth/pid).
> [  +0.000936] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [  +0.002187] systemd[1]: Arbitrary Executable File Formats File System Automount Point was skipped because of a failed condition check (ConditionPathExists=/proc/sys/fs/binfmt_misc).
> [  +0.000074] systemd[1]: Reached target Local Encrypted Volumes.
> [  +0.002167] systemd[1]: Stopped target Switch Root.
> [  +0.001714] systemd[1]: Stopped target Initrd File Systems.
> [  +0.000544] systemd[1]: Stopped target Initrd Root File System.
> [  +0.000143] systemd[1]: Reached target Local Integrity Protected Volumes.
> [  +0.001556] systemd[1]: Reached target Slice Units.
> [  +0.001413] systemd[1]: Reached target System Time Set.
> [  +0.000164] systemd[1]: Reached target Local Verity Protected Volumes.
> [  +0.002173] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [  +0.013478] systemd[1]: Listening on LVM2 poll daemon socket.
> [  +0.000504] systemd[1]: multipathd control socket was skipped because of a failed condition check (ConditionPathExists=/etc/multipath.conf).
> [  +0.005525] systemd[1]: Listening on Process Core Dump Socket.
> [  +0.000901] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [  +0.016293] systemd[1]: Listening on udev Control Socket.
> [  +0.001503] systemd[1]: Listening on udev Kernel Socket.
> [  +0.297849] systemd[1]: Activating swap /dev/mapper/rhel_hp--dl585g7--01-swap...
> [  +0.006581] systemd[1]: Mounting Huge Pages File System...
> [  +0.085406] Adding 4194300k swap on /dev/mapper/rhel_hp--dl585g7--01-swap.  Priority:-2 extents:1 across:4194300k FS
> [  +0.102436] systemd[1]: Mounting POSIX Message Queue File System...
> [  +0.006321] systemd[1]: Mounting Kernel Debug File System...
> [  +0.006674] systemd[1]: Mounting Kernel Trace File System...
> [  +0.017052] systemd[1]: Starting Create List of Static Device Nodes...
> [  +0.006966] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [  +0.009343] systemd[1]: Starting Load Kernel Module configfs...
> [  +0.368174] systemd[1]: Starting Load Kernel Module drm...
> [  +0.010980] systemd[1]: Starting Load Kernel Module fuse...
> [  +0.143527] systemd[1]: Starting Read and set NIS domainname from /etc/sysconfig/network...
> [  +0.000518] systemd[1]: plymouth-switch-root.service: Deactivated successfully.
> [  +0.000501] systemd[1]: Stopped Plymouth switch root service.
> [  +0.000959] systemd[1]: systemd-fsck-root.service: Deactivated successfully.
> [  +0.000397] systemd[1]: Stopped File System Check on Root Device.
> [  +0.002110] systemd[1]: Stopped Journal Service.
> [  +0.019539] systemd[1]: Starting Journal Service...
> [  +0.016726] systemd[1]: Starting Load Kernel Modules...
> [  +0.012131] systemd[1]: Starting Generate network units from Kernel command line...
> [  +0.235917] systemd[1]: Starting Remount Root and Kernel File Systems...
> [  +0.000770] systemd[1]: Repartition Root Disk was skipped because all trigger condition checks failed.
> [  +0.012465] systemd[1]: Starting Coldplug All udev Devices...
> [  +0.185389] systemd[1]: Activated swap /dev/mapper/rhel_hp--dl585g7--01-swap.
> [  +0.063780] systemd[1]: Started Journal Service.
> [  +0.197422] systemd-journald[1059]: Received client request to flush runtime journal.
> [  +1.159527] power_meter ACPI000D:00: Found ACPI power meter.
> [  +0.000185] power_meter ACPI000D:00: Ignoring unsafe software power cap!
> [  +0.000035] power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [  +0.223877] ipmi_si: IPMI System Interface driver
> [  +0.000507] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [  +0.000005] ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> [  +0.000190] ipmi_si: Adding SMBIOS-specified kcs state machine
> [  +0.004234] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
> [  +0.000104] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
> [  +0.066891] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
> [  +0.000011] ipmi_si: Adding ACPI-specified kcs state machine
> [  +0.001585] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
> [  +0.034572] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [  +0.060439] input: PC Speaker as /devices/platform/pcspkr/input/input6
> [  +0.070371] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x13)
> [  +0.120190] ipmi_si IPI0001:00: IPMI kcs interface initialized
> [  +0.150770] ipmi_ssif: IPMI SSIF Interface driver
> [  +0.133345] SVM: TSC scaling supported
> [  +0.000006] kvm: Nested Virtualization enabled
> [  +0.000002] SVM: kvm: Nested Paging enabled
> [  +0.000199] SVM: LBR virtualization supported
> [  +0.126429] MCE: In-kernel MCE decoding enabled.
> [  +0.062285] EDAC amd64: MCT channel count: 2
> [  +0.003348] EDAC MC0: Giving out device to module amd64_edac controller F15h: DEV 0000:00:18.3 (INTERRUPT)
> [  +0.000009] EDAC amd64: F15h detected (node 0).
> [  +0.000004] EDAC MC: DCT0 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000005] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000004] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000004] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000004] EDAC MC: DCT1 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000003] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000004] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000003] EDAC amd64: using x8 syndromes.
> [  +0.000665] EDAC amd64: MCT channel count: 2
> [  +0.001422] EDAC MC1: Giving out device to module amd64_edac controller F15h: DEV 0000:00:19.3 (INTERRUPT)
> [  +0.000007] EDAC amd64: F15h detected (node 1).
> [  +0.000002] EDAC MC: DCT0 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000003] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000003] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC MC: DCT1 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000002] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC amd64: using x8 syndromes.
> [  +0.000527] EDAC amd64: MCT channel count: 2
> [  +0.001419] EDAC MC2: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1a.3 (INTERRUPT)
> [  +0.000006] EDAC amd64: F15h detected (node 2).
> [  +0.000003] EDAC MC: DCT0 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000004] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000003] EDAC MC: DCT1 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000002] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC amd64: using x8 syndromes.
> [  +0.000548] EDAC amd64: MCT channel count: 2
> [  +0.001554] EDAC MC3: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1b.3 (INTERRUPT)
> [  +0.000006] EDAC amd64: F15h detected (node 3).
> [  +0.000003] EDAC MC: DCT0 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000003] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000003] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000003] EDAC MC: DCT1 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000002] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC amd64: using x8 syndromes.
> [  +0.000566] EDAC amd64: MCT channel count: 2
> [  +0.001614] EDAC MC4: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1c.3 (INTERRUPT)
> [  +0.000006] EDAC amd64: F15h detected (node 4).
> [  +0.000003] EDAC MC: DCT0 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000003] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000003] EDAC MC: DCT1 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000003] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000002] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000003] EDAC amd64: using x8 syndromes.
> [  +0.000574] EDAC amd64: MCT channel count: 2
> [  +0.001407] EDAC MC5: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1d.3 (INTERRUPT)
> [  +0.000006] EDAC amd64: F15h detected (node 5).
> [  +0.000004] EDAC MC: DCT0 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000003] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000002] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000003] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC MC: DCT1 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000002] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000002] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000003] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC amd64: using x8 syndromes.
> [  +0.000763] EDAC amd64: MCT channel count: 2
> [  +0.001376] EDAC MC6: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1e.3 (INTERRUPT)
> [  +0.000006] EDAC amd64: F15h detected (node 6).
> [  +0.000003] EDAC MC: DCT0 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000002] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000003] EDAC MC: DCT1 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000002] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC amd64: using x8 syndromes.
> [  +0.000614] EDAC amd64: MCT channel count: 2
> [  +0.001440] EDAC MC7: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1f.3 (INTERRUPT)
> [  +0.000007] EDAC amd64: F15h detected (node 7).
> [  +0.000002] EDAC MC: DCT0 chip selects:
> [  +0.000002] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000003] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000002] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000003] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000003] EDAC MC: DCT1 chip selects:
> [  +0.000001] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [  +0.000002] EDAC amd64: MC: 2:     0MB 3:     0MB
> [  +0.000003] EDAC amd64: MC: 4:  8192MB 5:  8192MB
> [  +0.000002] EDAC amd64: MC: 6:     0MB 7:     0MB
> [  +0.000002] EDAC amd64: using x8 syndromes.
> [  +0.000392] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
> [  +0.000006] AMD64 EDAC driver v3.5.0
> [  +1.189655] XFS (sda1): Mounting V5 Filesystem
> [  +0.145626] XFS (sda1): Starting recovery (logdev: internal)
> [  +0.059891] XFS (sda1): Ending recovery (logdev: internal)
> [  +0.108896] XFS (dm-2): Mounting V5 Filesystem
> [  +0.104825] XFS (dm-2): Starting recovery (logdev: internal)
> [  +0.050927] XFS (dm-2): Ending recovery (logdev: internal)
> [  +4.077169] NET: Registered PF_QIPCRTR protocol family
> [  +0.269527] netxen_nic: enp4s0f0 NIC Link is up
> [  +0.001125] IPv6: ADDRCONF(NETDEV_CHANGE): enp4s0f0: link becomes ready

> hp-dl585g7-01 login: [14780.388669] sysrq: Trigger a crash
> [14780.389486] Kernel panic - not syncing: sysrq triggered crash
> [14780.390461] CPU: 2 PID: 1995 Comm: bash Kdump: loaded Not tainted 5.19.0-rc2+ #7
> [14780.391636] Hardware name: HP ProLiant DL585 G7, BIOS A16 06/04/2013
> [14780.392264] Call Trace:
> [14780.392445]  <TASK>
> [14780.393052]  dump_stack_lvl+0x45/0x59
> [14780.393363]  panic+0x114/0x2c1
> [14780.394054]  sysrq_handle_crash+0x16/0x20
> [14780.394353]  __handle_sysrq.cold+0x43/0x11b
> [14780.394670]  write_sysrq_trigger+0x3f/0x50
> [14780.395042]  proc_reg_write+0x55/0xa0
> [14780.395314]  ? rcu_read_lock_any_held+0x6e/0x90
> [14780.396128]  vfs_write+0xb5/0x330
> [14780.396852]  ksys_write+0x65/0xe0
> [14780.397516]  do_syscall_64+0x3b/0x90
> [14780.397942]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [14780.398304] RIP: 0033:0x7f6ea2944127
> [14780.398609] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 7
> 5 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [14780.400468] RSP: 002b:00007ffc11418378 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [14780.401577] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6ea2944127
> [14780.402576] RDX: 0000000000000002 RSI: 000055dddfe16fa0 RDI: 0000000000000001
> [14780.403583] RBP: 000055dddfe16fa0 R08: 0000000000000000 R09: 00007f6ea28c2320
> [14780.404573] R10: 00007f6ea29b63e0 R11: 0000000000000246 R12: 0000000000000002
> [14780.405579] R13: 00007f6ea29fb5a0 R14: 0000000000000002 R15: 00007f6ea29fb7a0
> [14780.406650]  </TASK>
> [14781.881049] clocksource: timekeeping watchdog on CPU29: Marking clocksource 'tsc' as unstable because the skew is too 
> large:
> [14781.882601] clocksource:                       'hpet' wd_nsec: 30761241 wd_now: 4108d720 wd_last: 41021ea3 mask: fffff
> fff
> [14781.883461] clocksource:                       'tsc' cs_nsec: 503974375 cs_now: 23f07293011e cs_last: 23f024aaac88 mas
> k: ffffffffffffffff
> [14781.884451] clocksource:                       'tsc' is current clocksource.
> [14781.886447] tsc: Marking TSC unstable due to clocksource watchdog
> [14781.887673] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> [14781.889072] sched_clock: Marking unstable (14776940604027, 4947084098)<-(14783325191838, -1437528670)
> [    0.000000] Linux version 5.19.0-rc2+ (root@hp-dl585g7-01.rhts.eng.pek2.redhat.com) (gcc (GCC) 11.2.1 20220127 (Red Ha
> t 11.2.1-9), GNU ld version 2.35.2-17.el9) #7 SMP PREEMPT_DYNAMIC Sat Jun 18 09:47:32 EDT 2022
> [    0.000000] Command line: elfcorehdr=0x9d000000 BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+ ro resume=/dev/mapper/rhel
> _hp--dl585g7--01-swap console=ttyS1,115200n81 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev
> .children-max=2 panic=10 acpi_no_memhotplug transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0 hugetlb_cma=
> 0 tsc=unstable disable_cpu_apicid=32 hpwdt.pretimeout=0 hpwdt.kdumptimeout=0
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [    0.000000] signal: max sigframe size: 1776
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009bfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009c000-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000009d001000-0x00000000bcffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bde0e000-0x00000000bde4dfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000bde4f000-0x00000000cfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fee0ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.7 present.
> [    0.000000] DMI: HP ProLiant DL585 G7, BIOS A16 06/04/2013
> [    0.000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2593.421 MHz processor
> [    0.000720] last_pfn = 0xbd000 max_arch_pfn = 0x400000000
> [    0.003972] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.007068] found SMP MP-table at [mem 0x000f4f60-0x000f4f6f]
> [    0.007101] Using GB pages for direct mapping
> [    0.007359] RAMDISK: [mem 0xb7b99000-0xb8ffffff]
> [    0.007364] ACPI: Early table checksum verification disabled
> [    0.007371] ACPI: RSDP 0x00000000000F4EE0 000024 (v02 HP    )
> [    0.007377] ACPI: XSDT 0x00000000BDE117C0 0000BC (v01 HP     ProLiant 00000002 �?   0000162E)
> [    0.007387] ACPI: FACP 0x00000000BDE118C0 0000F4 (v03 HP     ProLiant 00000002 �?   0000162E)
> [    0.007396] ACPI: DSDT 0x00000000BDE119C0 00CD60 (v01 HP     DSDT     00000001 INTL 20061109)
> [    0.007401] ACPI: FACS 0x00000000BDE0E140 000040
> [    0.007405] ACPI: FACS 0x00000000BDE0E140 000040
> [    0.007410] ACPI: SPCR 0x00000000BDE0E180 000050 (v01 HP     SPCRRBSU 00000001 �?   0000162E)
> [    0.007415] ACPI: MCFG 0x00000000BDE0E200 00003C (v01 HP     ProLiant 00000001      00000000)
> [    0.007420] ACPI: HPET 0x000000008 (v01 HP     ProLiant 00000002 �?   0000162E)
> [    0.007425] ACPI: SPMI 0x00000000BDE0E280 000040 (v05 HP     ProLiant 00000001 �?   0000162E)
> [    0.007430] ACPI: ERST 0x00000000BDE0E2C0 0001D0 (v01 HP     ProLiant 00000001 �?   0000162E)
> [    0.007435] ACPI: APIC 0x00000000BDE0E4C0 0001EA (v01 HP     ProLiant 00000002      00000000)
> [    0.007439] ACPI: SRAT 0x00000000BDE0E7C0 0004C0 (v02 AMD    AGESA    00000001 AMD  00000001)
> [    0.007444] ACPI: FFFF 0x00000000BDE0EFC0 000176 (v01 HP     ProLiant 00000001 �?   0000162E)
> [    0.007449] ACPI: BERT 0x00000000BDE0F140 000030 (v01 HP     ProLiant 00000001 �?   0000162E)
> [    0.007454] ACPI: HEST 0x00000000BDE0F180 00018C (v01 HP     ProLiant 00000001 �?   0000162E)
> [    0.007458] ACPI: FFFF 0x00000000BDE0F340 000064 (v02 HP     Prant 00000002 �?   0000162E)
> [    0.007463] ACPI: SLIT 0x00000000BDE0F3C0 00006C (v01 AMD    AGESA    00000001 AMD  00000001)
> [    0.007468] ACPI: FFFF 0x00000000BDE0F7C0 000000 (v00                 00000000      00000000)
> [    0.007472] ACPI: SSDT 0x00000000BDE1E740 000125 (v03 HP    0002 HP   00000001)
> [    0.007477] ACPI: SSDT 0x00000000BDE1E880 00BD3D (v03 HP     pci1cmn  00000002 INTL 20090625)
> [    0.007482] ACPI: SSDT 0x00000000BDE2A5C0 000076 (v03 HP     CRSPCI1  00000002 HP   00000001)
> [    0.007487] ACPI: SSDT 0x00000000BDE2A640 000377 (v01 HP     pmab     00000001 INTL 20090625)
> [    0.007492] ACPI: SSDT 0x00000000BDE2A9C0 001164 (v02 AMD    POWERNOW 00000001 AMD  00000001)
> [    0.007496] ACPI: Reserving FACP table memory at [mem 0xbde118c0-0xbde119b3]
> [    0.007498] ACPI: Reserving DSDT table memory at [mem 0xbde119c0-0xbde1e71f]
> [    0.007500] ACPI: Reserving FACS table memory at [mem 0xbde0e140-0xbde0e17f]
> [    0.007502] ACPI: Reserving FACS table memory at [mem 0xbde0e140-0xbde0e17f]
> [    0.007503] ACPI: Reserving SPCR table memory at [mem 0xbde0e180-0xbde0e1cf]
> [    0.007505] ACPI: Reserving MCFG table memory at [mem 0xbde00-0xbde0e23b]
> [    0.007507] ACPI: Reserving HPET table memory at [mem 0xbde0e240-0xbde0e277]
> [    0.007508] ACPI: Reserving SPMI table memory at [mem 0xbde0e280-0xbde0e2bf]
> [    0.007510] ACPI: Reserving ERST table memory at [mem 0xbde0e2c0-0xbde0e48f]
> [    0.007512] ACPI: Reserving APIC table memory at [mem 0xbde0e4c0-0xbde0e6a9]
> [    0.007513] ACPI: Reserving SRAT table memory at [mem 0xb]
> [    0.007515] ACPI: Reserving FFFF table memory at [mem 0xbde0efc0-0xbde0f135]
> [    0.007516] ACPI: Reserving BERT table memory at [mem 0xbde0f140-0xbde0f16f]
> [    0.007518] ACPI: Reserving HEST table memory at [mem 0xbde0f180-0xbde0f30b]
> [    0.007520] ACPI: Reserving FFFF table memory at [mem 0xbde0f340-0xbde0f3a3]
> [    0.007521] ACPI: Reserving SLIT table memory at [mem 0xbde0f3c0-0xbde0f42b]
> [    0.007568] NUMA turned off
> [    0.007570] Faking a node at [mem 0x0000000000000000-0x00000000bcffffff]
> [    0.007585] NODE_DATA(0) allocated [mem 0xbcfd5000-0xbcffffff]
> [    0.007668] Zone ranges:
> [    0.007670]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.007673]   DMA32    [mem 0x0000000001000000-0x00000000bcffffff]
> [    0.007676]   Normal   empty
> [    0.007678]   Device   empty
> [    0.007680] Movable zone start for each node
> [    0.007684] Early memory node ranges
> [    0.007685]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
> [    0.007687]   node   0: [mem 0x000000009d001000-0x00000000bcffffff]
> [    0.007690] Initmem setup node 0 [mem 0x0000000000001000-0x00000000bcffffff]
> [    0.007700] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.009809] On node 0, zone DMA32: 53093 plable ranges
> [    0.010085] On node 0, zone DMA32: 12288 pages in unavailable ranges
> [    0.010316] ACPI: PM-Timer IO Port: 0x920
> [    0.010323] APIC: Disabling requested cpu. Processor 0/0x20 ignored.
> [    0.010325] APIC: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 1/0x40 ig
> nored.
> [    0.010327] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 3/0x80 ignored.
> [    0.010329] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 4/0x21 ignored.
> [    0.010331] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 5/0x41 ignored.
> [    0.010333] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 6/0x61 ignored.
> [    0.010334] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 7/0x81 ignored.
> [    0.010336] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 8/0x22 ignored.
> [    0.010337] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 9/0x42 ignored.
> [    0.010339] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 10/0x62 ignored.
> [    0.010341] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 11/0x82 ignored.
> [    0.010342] APIC: NR_CPUS/possible_cpus limit of eached. Processor 12/0x23 ignored.
> [    0.010344] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 13/0x43 ignored.
> [    0.010345] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 14/0x63 ignored.
> [    0.010347] APIC: Nus limit of 1 reached. Processor 15/0x83 ignored.
> [    0.010349] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 16/0x24 ignored.
> [    0.010350] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 17/0x44 ignored.
> [    0.010352] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 18/0x64 ignored.
> [    0.010353] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 19/0x84 ignored.
> [    0.010355] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 20/0x25 ignored.
> [    0.010357] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 21/0x45 ignored.
> [    0.010358] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 22/0x65 ignored.
> [    0.010360] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 23/0x85 ignored.
> [    0.010361] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 24/0x26 ignored.
> [    0.010363] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 25/0x46 ignored.
> [    0.010365] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 26/0x66 ignored.
> [    0.010366] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 27/0x86 ignored.
> [    0.010368] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 28/0x27 ignored.
> [    0.010369]/possible_cpus limit of 1 reached. Processor 29/0x47 ignored.
> [    0.010371] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 30/0x67 ignored.
> [    0.010373] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 31/0x87 ignored.
> [    0.010374] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 32/0x28 ignored.
> [    0.010376] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 33/0x48 ignored.
> [    0.010377] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 34/0x68 ignored.
> [    0.010379] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 35/0x88 ignored.
> [    0.010381] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 36/0x29 ignored.
> [    0.010382] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 37/0x49 ignored.
> [    0.010384] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 38/0x69 ignored.
> [    0.010385] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 39/0x89 ignored.
> [    0.010387] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 40/0x2a ignored.
> [    0.010389] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 41/0x4a ignored.
> [    0.010390] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 42/0x6a ignored.
> [  NR_CPUS/possible_cpus limit of 1 reached. Processor 43/0x8a ignored.
> [    0.010393] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 44/0x2b ignored.
> [    0.010395] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 45/0x4b ignored.
> [    0.010397] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 46/0x6b ignored.
> [    0.010398] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 47/0x8b ignored.
> [    0.010402] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.010423] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-23
> [    0.010428] IOAPIC[1]: apic_id 9, version 33, address 0xdfffc000, GSI 24-55
> [    0.010433] IOAPIC[2]: apic_id 10, version 33, address 0xfddfc000, GSI 56-87
> [    0.010436] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> [    0.010440] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.010445] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.010447] ACPI: HPET id: 0x1166a201 base: 0xfed00000
> [    0.010452] ACPI: SPCR: SPCR table version 1
> [    0.010453] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
> [    0.010456] ACPI: SPCR: console: uart,mmio,0x0,9600
> [    0.010458] smpboot: 48 Processors exceeds NR_CPUS limit of 1
> [smpboot: Allowing 1 CPUs, 0 hotplug CPUs
> [    0.010480] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.010484] PM: hibernation:gistered nosave memory: [mem 0x0009c000-0x0009ffff]
> [    0.010486] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.010487] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.010489] PM: hibernation: Registered nosave memory: [mem 0x00100000-0x9d000fff]
> [    0.010493] [mem 0x00100000-0x9d000fff] available for PCI devices
> [    0.010495] Booting paravirtualized kernel on bare hardware
> [    0.010499] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.015925] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
> [    0.016737] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u2097152
> [    0.016806] Fallback order for Node 0: 0 
> [    0.016817] Built 1 zonelists, mobility grouping on.  Total pages: 129175
> [    0.016819] Policy zone: DMA32
> [    0.016827] Kernel command line: elfcorehdr=0x9d000000 BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+ ro resume=/dev/m-dl
> 585g7--01-swap console=ttyS1,115200n81 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.childr
> en-max=2 panic=10 acpi_no_memhotplug transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0 hugetlb_cma=0 tsc=u
> nstable disable_cpu_apicid=32 hpwdt.pretimeout=0 hpwdt.kdumptimeout=0
> [    0.016919] Misrouted IRQ fixup and polling support enabled
> [    0.016920] This may significantly impact system performance
> [    0.017053] cgroup: Disabling memory control group subsystem
> [    0.017191] tsc: Marking TSC unstable due to boot parameter
> [    0.017245] Unknown kernel command line parameters "nokaslr BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+", will be pass
> ed to user space.
> [    0.017421] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.017502] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.017526] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.026032] Memory: 179964K/524904K available (14342K kernel code, 6117K rwdata, 5020K rodata, 2572K init, 17352K bss,
>  88372K reserved, 0K cma-reserved)
> [    0.026489] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.026531] ftrace: allocating 43912 entries in 172 p71] ftrace: allocated 172 pages with 4 groups
> [    0.040614] Dynamic Preempt: voluntary
> [    0.040734] Running RCU self tests
> [    0.040742] rcu: Preemptible hierarchical RCU implementation.
> [    0.040743] rcu: 	RCU lockdep checking is enabled.
> [    0.040745] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=1.
> [    0.040747] 	Trampoline variant of Tasks RCU enabled.
> [    0.040749] 	Rude variant of Tasks RCU enabled.
> [    0.040750] 	Tracing variant of Tasks RCU enabled.
> [    0.040751] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.040753] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> [    0.046632] NR_IRQS: 524544, nr_irqs: 256, preallocated irqs: 16
> [    0.046885] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.046979] Spurious LAPIC timer interrupt on cpu 0
> [    0.052990] Console: colour VGA+ 80x25
> [    5.623857] printk: console [ttyS1] enabled
> [    5.625936] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    5.629825] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    5.631940] ... MAX_LOCK_DEPTH:          48
> [    5.634028] ... MAX_LOCKDEP_KEYS:        8192
> [    5.636158] ... CLASSHASH_SIZE:          4096
> [    5.638304] ... MAX_LOCKDEP_ENTRIES:    5.914003] ... MAX_LOCKDEP_CHAINS:      65536
> [    6.042813] ... CHAINHASH_SIZE:          32768
> [    6.045060]  memory used by lock dependency info: 6365 kB
> [    6.047609]  memory used for stack traces: 4224 kB
> [    6.050061]  per task-struct memory footprint: 1920 bytes
> [    6.052862] ACPI: Core revision 20220331
> [    6.055249] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    6.059964] APIC: Switch to symmetric I/O mode setup
> [    6.063242] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    6.070900] Calibrating delay loop (skipped), value calculated using timer frequency.. 5186.84 BogoMIPS (lpj=2593421)
> [    6.071893] pid_max: default: 32768 minimum: 301
> [    6.073009] LSM: Security Framework initializing
> [    6.073916] Yama: becoming mindful.
> [    6.074910] SELinux:  Initializing.
> [    6.075984] LSM support for eBPF active
> [    6.077018] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
> [    6.077895] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
> [    6.080367] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
> [    6.080902] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
> [    6.081905] Spectre V1 :opy/swapgs barriers and __user pointer sanitization
> [    6.082895] Spectre V2 : Mitigation: Retpolines
> [    6.083892] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    6.084894] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    6.093508] Freeing SMP alternatives memory: 36K
> [    6.094173] smpboot: CPU 0 Converting physical 2 to logical package 0
> [    6.094895] smpboot: CPU 0 Converting physical 4 to logical die 0
> [    6.198630] smpboot: CPU0: AMD Opteron(tm) Processor 6344 (family: 0x15, model: 0x2, stepping: 0x0)
> [    6.200205] cblist_init_generic: Setting adjustable number of callback queues.
> [    6.200888] cblist_init_generic: Setting shift to 0 and lim to 1.
> [    6.201991] cblist_init_generic: Setting shift to 0 and lim to 1.
> [    6.202975] cblist_init_generic: Setting shift to 0 and lim to 1.
> [    6.203968] Running RCU-tasks wait API self tests
> [    6.312008] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
> [    6.312888] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 430076)
> [    6.313889] AMD PMU driver.
> [    6.314895] ... version:                0
> [    6.315888] ... bit width:              48
> [    6.316888] ... generic registers:      6
> [    6.317894] ... value mask:      0000ffffffffffff
> [    6.318889] ... max period:             00007fffffffffff
> [    6.320888] ... fixed-purpose events:   0
> [    6.321888] ... event mask:             000000000000003f
> [    6.322907] Callback from call_rcu_tasks_trace() invoked.
> [    6.325198] rcu: Hierarchical SRCU implementation.
> [    6.325256] printk: console [ttyS1] printing thread started
> [    6.328571] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    6.328736] smp: Bringing up secondary CPUs ...
> [    6.328737] smp: Brought up 1 node, 1 CPU
> [    6.328739] smpboot: Max logical packages: 48
> [    6.328740] smpboot: Total of 1 processors activated (5186.84 BogoMIPS)
> [    6.337848] node 0 deferred pages initialised in 2ms
> [    6.340297] devtmpfs: initialized
> [    6.340545] x86/mm: Memory block size: 128MB
> [    6.344087] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    6.344096] futex hash table entries: 256 (order: 3, 32768 bytes, linear)
> [    6.344414] pinctrl core: initialized pinctrl subsystem
> [    6.348046] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    6.348716] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
> [    6.348727] DMA: preallocat128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    6.348773] audit: initializing netlink subsys (disabled)
> [    6.353396] thermal_sys: Registered tr 'fair_share'
> [    6.353399] thermal_sys: Registered thermal governor 'step_wise'
> [    6.353401] thermal_sys: Registered thermal governor 'user_space'
> [    6.353419] cpuidle: using governor menu
> [    6.353651] HugeTLB: can optimize 409memmap pages for hugepages-1048576kB
> [    6.353667] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    6.353671] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    6.354072] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
> [    6.354080] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
> [    6.354115] PCI: Using configuration type 1 for base access
> [    6.354922] audit: type=2000 audit(1655867729.289:1): state=initialized audit_enabled=0 res=1
> [    6.370217] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    6.401957] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
> [    6.401962] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    6.401964] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    6.407177] cryptd: max_cpu_qlen set to 1000
> [    6.408207] ACPI: Added _OSI(Module Device)
> [    6.408209] ACPI: Added _OSI(Processor Device)
> [    6.408210] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    6.408212] ACPI: Added _OSI(Processor Aggregator Device)
> [    6.408214] ACPI: Added _OVideo)
> [    6.408217] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    6.408226] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    6.415913] Callback from call_rcu_tasks_rude() invoked.
> [    6.479230] ACPI: 6 ACPI AML tables successfully acquired and loaded
> [    6.564806] ACPI: Interpreter enabled
> [    6.564868] ACPI: PM: (supports S0 S4 S5)
> [    6.564879] ACPI: Using IOAPIC for interrupt routing
> [    6.568064] HEST: Table parsing disabled.
> [    6.568065] GHES: HEST is not enabled!
> [    6.568068] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    6.568069] PCI: Using E820 reservations for host bridge windows
> [    6.715940] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
> [    6.715953] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    6.716125] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> [    6.716127] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    6.722101] PCI host bridge to bus 0000:00
> 6.722106] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]fffff window]
> [    6.722109] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
> [    6.722111] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [    6.722113] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
> [    6.722115] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed03fff window]
> [    6.722117] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
> [    6.722119] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
> [    6.722121] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
> [    6.722123] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    6.722125] pci_bus 0000:00: root bus resource [bus 00-3f]
> [    6.722246] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
> [    6.722528] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
> [    6.722609] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> [    6.723145] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
> [    6.723224] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
> [    6.723551] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
> [    6.723628] pci 0000:00:0a.0: PME# supported f3cold
> [    6.723991] pci 0000:00:11.0: [1002:4390] type 00 class 0x010601
> [    6.724013] pci 0000:00:11.0: reg 0x10: [io  0x1000-0x1007]
> [    6.724025] pci 0000:00:11.0: reg 0x14: [io  0x1008-0x100b]
> [    6.724036] pci 0000:00:11.0: reg 0x18: [io  0x1010-0x1017]
> [    6.724047] pci 0000:00:11.0: reg 0x1c: [io  0x1018-0x101b]
> [    6.724058] pci 0000:00:11.0: reg 0x20: [io  0x1020-0x102f]
> [    6.724070] pci 0000:00:11.0: reg 0x24: [mem 0xed8f0000-0xed8f03ff]
> [    6.724259] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
> [    6.724279] pci 0000:00:12.0: reg 0x10: [mem 0xed8e0000-0xed8e0fff]
> [    6.724484] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
> [    6.724504] pci 0000:00:12.1: reg 0x10: [mem 0xed8d0000-0xed8d0fff]
> [    6.724703] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
> [    6.724723] pci 0000:00:12.2: reg 0x10: [mem 0xed8c0000-0xed8c00ff]
> [    6.724830] pci 0000:00:12.2: supports D1 D2
> [    6.724831] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
> [    6.728022] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
> [    6.728042] pci 0000:00:13.0: reg 0x10: [mem 0xed8b0000-0xed8b0fff]
> [    6.728235] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
> [    6.728255] pci 0000:00:13.0xed8a0000-0xed8a0fff]
> [    6.728461] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
> [    6.728481] pci 0000:00:13.2: reg 0x10: [mem 0xed890000-0xed8900ff]
> [    6.728890] pci 0000:00:13.2: supports D1 D2
> [    6.728891] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
> [    6.729071] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
> [    6.729434] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
> [    6.729454] pci 0000:00:14.1: reg 0x10: [io  0x01f0-0x01f7]
> [    6.729466] pci 0000:00:14.1: reg 0x14: [io  0x03f4-0x03f7]
> [    6.729477] pci 0000:00:14.1: reg 0x18: [io  0x0170-0x0177]
> [    6.729489] pci 0000:00:14.1: reg 0x1c: [io  0x0374-0x0377]
> [    6.729504] pci 0000:00:14.1: reg 0x20: [io  0x0500-0x050f]
> [    6.729528] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    6.729530] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    6.729531] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    6.729532] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    6.729699] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
> [    6.730059] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
> [    0000:00:18.0: [1022:1600] type 00 class 0x060000
> [    6.730547] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
> [    6.730689] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
> [    6.730833] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
> [    6.731005] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
> [    6.731157] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
> [    6.731309] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
> [    6.731472] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
> [    6.731622] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
> [    6.731772] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
> [    6.736897] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
> [    6.737046] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
> [    6.737206] pci 0000:00:1a.0: [1022:1600] type 00 class 0x060000
> [    6.737376] pci 0000:00:1a.1: [1022:1601] type 00 class 0x060000
> [    6.737522] pci 0000:00:1a.2: [1022:1602] type 00 class 0x060000
> [    6.737674] pci 0000:00:1a.3: [1022:1603] type 00 class 0x060000
> [    6.737831] pci 0000:00:1a.4: [1022:1604] type 00 class 0x060000
> [    6.738012] .5: [1022:1605] type 00 class 0x060000
> [    6.738164] pci 0000:00:1b.0: [1022:1600] type 00 class 0x060000
> [    6.738332] pci 0000:00:1b.1: [1022:1601] type 00 class 0x060000
> [    6.738483] pci 0000:00:1b.2: [1022:1602] type 00 class 0x060000
> [    6.738633] pci 0000:00:1b.3: [1022:1603] type 00 class 0x060000
> [    6.738795] pci 0000:00:1b.4: [1022:1604] type 00 class 0x060000
> [    6.738952] pci 0000:00:1b.5: [1022:1605] type 00 class 0x060000
> [    6.739102] pci 0000:00:1c.0: [1022:1600] type 00 class 0x060000
> [    6.739271] pci 0000:00:1c.1: [1022:1601] type 00 class 0x060000
> [    6.739412] pci 0000:00:1c.2: [1022:1602] type 00 class 0x060000
> [    6.739553] pci 0000:00:1c.3: [1022:1603] type 00 class 0x060000
> [    6.739711] pci 0000:00:1c.4: [1022:1604] type 00 class 0x060000
> [    6.739864] pci 0000:00:1c.5: [1022:1605] type 00 class 0x060000
> [    6.744025] pci 0000:00:1d.0: [1022:1600] type 00 class 0x060000
> [    6.744185] pci 0000:00:1d.1: [1022:1601] type 00 class 0x060000
> [    6.744334] pci 0000:00:1d.2: [1022:1602] type 00 class 0x060000
> [    6.744482] pci 0000:00:1d.3: [1022:1603] type 00 class 0x060000
> [    6.744997] pci 0000:00:1d.4: [1022:1604] type 00 class 0x060000
> [    6.745139] pci 0000:00:1d.5: [1022:1605] type 00 class 0x060000
> [    6.745298] pci 0000:00:1e.0: [1022:1600] type 00 class 0x060000
> [    6.745458] pci 0000:00:1e.1: [1022:1601] type 00 class 0x060000
> [    6.745599] pci22:1602] type 00 class 0x060000
> [    6.745747] pci 0000:00:1e.3: [1022:1603] type 00 class 0x060000
> [    6.745904] pci 0000:00:1e.4: [1022:1604] type 00 class 0x060000
> [    6.746058] pci 0000:00:1e.5: [1022:1605] type 00 class 0x060000
> [    6.746204] pci 0000:00:1f.0: [1022:1600] type 00 class 0x060000
> [    6.746372] pci 0000:00:1f.1: [1022:1601] type 00 class 0x060000
> [    6.746519] pci 0000:00:1f.2: [1022:1602] type 00 class 0x060000
> [    6.746669] pci 0000:00:1f.3: [1022:1603] type 00 class 0x060000
> [    6.746821] pci 0000:00:1f.4: [1022:1604] type 00 class 0x060000
> [    6.746985] pci 0000:00:1f.5: [1022:1605] type 00 class 0x060000
> [    6.747233] pci 0000:04:00.0: [4040:0100] type 00 class 0x020000
> [    6.747252] pci 0000:04:00.0: reg 0x10: [mem 0xfda00000-0xfdbfffff 64bit]
> [    6.747279] pci 0000:04:00.0: reg 0x20: [mem 0xfa000000-0xfbffffff 64bit]
> [    6.747356] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [    6.747552] pci 0000:04:00.1: [4040:0100] type 00 class 0x020000
> [    6.747572] pci 0000:04:00.1: reg 0x10: [mem 0xf9e00000-0xf9ffffff 64bit]
> [    6.747598] pci 0000:04:00.1: reg 0x20: [mem 0xf6000000-0xf7ffffff 64bit]
> [    6.747674] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
> [    0000:04:00.2: [4040:0100] type 00 class 0x020000
> [    6.747879] pci 0000:04:00.2: reg 0x10: [mem 0xf5e00000-0xf5ffffff 64bit]
> [    6.747913] pci 0000:04:00.2: reg 0x20: [mem 0xf2000000-0xf3ffffff 64bit]
> [    6.753921] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
> [    6.754111] pci 0000:04:00.3: [4040:0100] type 00 class 0x020000
> [    6.754130] pci 0000:04:00.3: reg 0x10: [mem 0xf1e00000-0xf1ffffff 64bit]
> [    6.754157] pci 0000:04:00.3: reg 0x20: [mem 0xee000000-0xefffffff 64bit]
> [    6.754233] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> [    6.756939] pci 0000:00:02.0: PCI bridge to [bus 04]
> [    6.756946] pci 0000:00:02.0:   bridge window [mem 0xee000000-0xfdbfffff]
> [    6.757042] pci 0000:03:00.0: [103c:323a] type 00 class 0x010400
> [    6.757061] pci 0000:03:00.0: reg 0x10: [mem 0xede00000-0xedffffff 64bit]
> [    6.757074] pci 0000:03:00.0: reg 0x18: [mem 0xeddf0000-0xeddf0fff 64bit]
> [    6.757082] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
> [    6.757098] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
> [    6.757940] pci 0000:03:00.0: PME# supported from D0
> [    6.757967] pci 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:04.0 (
> capable of 32.000 Gb/s with 5.0 GT/s PCIe x8 link)
> [    6.758131] pci 0000:00:04.0: PCI bridge to [bus 03]
> [    6.758135] pci 0000:00:04.0:   bridge window [i
>                                                    [    6.758139] pci 0000:00:04.0:   bridge window [mem 0xedd00000-0xedf
> fffff]
> [    6.758276] pci 0000:02:00.0: [103c:3306] type 00 class 0x088000
> [    6.758296] pci 0000:02:00.0: reg 0x10: [io  0x3000-0x30ff]
> [    6.758308] pci 0000:02:00.0: reg 0x14: [mem 0xedcf0000-0xedcf01ff]
> [    6.758319] pci 0000:02:00.0: reg 0x18: [io  0x3400-0x34ff]
> [    6.758728] pci 0000:02:00.2: [103c:3307] type 00 class 0x088000
> [    6.758748] pci 0000:02:00.2: reg 0x10: [io  0x3800-0x38ff]
> [    6.758760] pci 0000:02:00.2: reg 0x14: [mem 0xedce0000-0xedce00ff]
> [    6.758771] pci 0000:02:00.2: reg 0x18: [mem 0xedb00000-0xedbfffff]
> [    6.758782] pci 0000:02:00.2: reg 0x1c: [mem 0xeda80000-0xedafffff]
> [    6.758793] pci 0000:02:00.2: reg 0x20: [mem 0xeda70000-0xeda77fff]
> [    6.758805] pci 0000:02:00.2: reg 0x24: [mem 0xeda60000-0xeda67fff]
> [    6.758816] pci 0000:02:00.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [    6.758896] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
> [    6.759078] pci 0000:02:00.4: [103c:3300] type 00 class 0x0c0300
> [    6.759137] pci 0000:02:00.4: reg 0x20: [io  0x3c00-0x3c1f]
> [    6.761925] pci 0000:00:0a.0: PCI bridge to [bus 02]
> [    6.761930] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
> [    6.761933] pci 0000:00:0aindow [mem 0xeda00000-0xedcfffff]
> [    6.761952] pci_bus 0000:01: extended config space not accessible
> [    6.762031] pci 0000:01:03.0: [1002:515e] type 00 class 0x030000
> [    6.762057] pci 0000:01:03.0: reg 0x10: [mem 0xe0000000-0xe7ffffff pref]
> [    6.762072] pci 0000:01:03.0: reg 0x14: [io  0x2000-0x20ff]
> [    6.762086] pci 0000:01:03.0: reg 0x18: [mem 0xed9f0000-0xed9fffff]
> [    6.762137] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
> [    6.762167] pci 0000:01:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    6.762207] pci 0000:01:03.0: supports D1 D2
> [    6.762380] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
> [    6.762385] pci 0000:00:14.4:   bridge window [io  0x2000-0x2fff]
> [    6.762389] pci 0000:00:14.4:   bridge window [mem 0xed900000-0xed9fffff]
> [    6.762394] pci 0000:00:14.4:   bridge window [mem 0xe0000000-0xe7ffffff pref]
> [    6.762396] pci 0000:00:14.4:   bridge window [mem 0xdff00000-0xfdbfffff window] (subtractive decode)
> [    6.762398] pci 0000:00:14.4:   bridge window [io  0x1000-0xffff window] (subtractive decode)
> [    6.762400] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
> [    6.762402] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
> [    6.76240:14.4:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
> [    6.762406] pci 0000:00:14.4:   bridge window [mem 0xfed00000-0xfed03fff window] (subtractive decode)
> [    6.762408] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
> [    6.762410] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
> [    6.762412] pci 0000:00:14.4:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
> [    6.762414] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [    6.764166] ACPI: PCI: Interrupt link I020 configured for IRQ 24
> [    6.770159] ACPI: PCI: Interrupt link I021 configured for IRQ 25
> [    6.772199] ACPI: PCI: Interrupt link I022 configured for IRQ 26
> [    6.773686] ACPI: PCI: Interrupt link I023 configured for IRQ 27
> [    6.779671] ACPI: PCI: Interrupt link I030 configured for IRQ 28
> [    6.781130] ACPI: PCI: Interrupt link I031 configured for IRQ 29
> [    6.782601] ACPI: PCI: Interrupt link I032 configured for IRQ 30
> [    6.788666] ACPI: PCI: Interrupt link I033 configured for IRQ 31
> [    6.790123] ACPI: PCI: Interrupt link I040 configured for IRQ 44
> [    6.795599] ACPI: PCI: Interrupt link I IRQ 45
> [    6.797368] ACPI: PCI: Interrupt link I042 configured for IRQ 46
> [    6.802894] ACPI: PCI: Interrupt link I043 configured for IRQ 47
> [    6.804793] ACPI: PCI: Interrupt link I050 configured for IRQ 48
> [    6.806293] ACPI: PCI: Interrupt link I051 configured for IRQ 49
> [    6.807813] ACPI: PCI: Interrupt link I052 configured for IRQ 50
> [    6.814301] ACPI: PCI: Interrupt link I053 configured for IRQ 51
> [    6.815861] ACPI: PCI: Interrupt link I060 configured for IRQ 47
> [    6.821364] ACPI: PCI: Interrupt link I061 configured for IRQ 44
> [    6.823249] ACPI: PCI: Interrupt link I062 configured for IRQ 45
> [    6.824786] ACPI: PCI: Interrupt link I063 configured for IRQ 46
> [    6.831011] ACPI: PCI: Interrupt link I070 configured for IRQ 24
> [    6.831904] Callback from call_rcu_tasks() invoked.
> [    6.832572] ACPI: PCI: Interrupt link I071 configured for IRQ 25
> [    6.834145] ACPI: PCI: Interrupt link I072 configured for IRQ 26
> [    6.835730] ACPI: PCI: Interrupt link I073 configured for IRQ 27
> [    6.840106] ACPI: PCI: Interrupt link I090 configured for IRQ 24
> [    6.840467] ACPI: PCI: Interrupt link I091 configured for IRQ 24
> [    6.840830] ACPI: PCI: Interrupt link I092 configured for IRQ 24
> [    6.841221] ACPI: PCI: Interrupt link I093 configured for IRQ 24
> [    6.842788] ACPI: PCI: Interrupt link I0A0 confi24
> [    6.848390] ACPI: PCI: Interrupt link I0A1 configured for IRQ 25
> [    6.850253] ACPI: PCI: Interrupt link I0A2 configured for IRQ 26
> [    6.855898] ACPI: PCI: Interrupt link I0A3 configured for IRQ 27
> [    6.857678] ACPI: PCI: Interrupt link I0B0 configured for IRQ 32
> [    6.859297] ACPI: PCI: Interrupt link I0B1 configured for IRQ 33
> [    6.865236] ACPI: PCI: Interrupt link I0B2 configured for IRQ 34
> [    6.866900] ACPI: PCI: Interrupt link I0B3 configured for IRQ 35
> [    6.872989] ACPI: PCI: Interrupt link I0C0 configured for IRQ 24
> [    6.874625] ACPI: PCI: Interrupt link I0C1 configured for IRQ 25
> [    6.880294] ACPI: PCI: Interrupt link I0C2 configured for IRQ 26
> [    6.882137] ACPI: PCI: Interrupt link I0C3 configured for IRQ 27
> [    6.883765] ACPI: PCI: Interrupt link I0D0 configured for IRQ 40
> [    6.889892] ACPI: PCI: Interrupt link I0D1 configured for IRQ 41
> [    6.891569] ACPI: PCI: Interrupt link I0D2 configured for IRQ 42
> [    6.897851] ACPI: PCI: Interrupt link I0D3 configured for IRQ 43
> [    6.898020] ACPI: PCI: Interrupt link BI02 configured for IRQ 52
> [    6.898203] ACPI: PCI: Interrupt link BI03 configured for 
>                                                              [    6.898408] ACPI: PCI: Interrupt link BI04 configured for
>  IRQ 52
> [    6.898637] ACPI: PCI: Interrupt link BI05 configured for IRQ 52
> [    6.898899] ACPI: PCI: Interrupt link BI06 configured for IRQ 54
> [    6.899175] ACPI: PCI: Interrupt link BI07 configured for IRQ 24
> [    6.899474] ACPI: PCI: Interrupt link BI08 configured for IRQ 24
> [    6.899796] ACPI: PCI: Interrupt link BI09 configured for IRQ 24
> [    6.904155] ACPI: PCI: Interrupt link BI0A configured for IRQ 24
> [    6.904523] ACPI: PCI: Interrupt link BI0B configured for IRQ 54
> [    6.905127] ACPI: PCI: Interrupt link BI0C configured for IRQ 54
> [    6.905540] ACPI: PCI: Interrupt link BI0D configured for IRQ 54
> [    6.905764] ACPI: PCI: Interrupt link PI20 configured for IRQ 0
> [    6.905766] ACPI: PCI: Interrupt link PI20 disabled
> [    6.906042] ACPI: PCI: Interrupt link PI21 configured for IRQ 0
> [    6.906043] ACPI: PCI: Interrupt link PI21 disabled
> [    6.906309] ACPI: PCI: Interrupt link PI22 configured for IRQ 0
> [    6.906310] ACPI: PCI: Interrupt link PI22 disabled
> [    6.906575] ACPI: PCI: Interrupt link PI23 configured for IRQ 0
> [    6.906576] ACPI: PCI: Interrupt link PI23 disabled
> [    6.906840] ACPI: PCI: Interrupt link PI30 configured for IRQ 0
> [    6.906841] ACPI: PCrrupt link PI30 disabled
> [    6.907113] ACPI: PCI: Interrupt link PI31 configured for IRQ 0
> [    6.907114] ACPI: PCI: Interrupt link PI31 disabled
> [    6.907378] ACPI: PCI: Interrupt link PI32 configured for IRQ 0
> [    6.907379] ACPI: PCI: Interrupt link PI32 disabled
> [    6.907642] ACPI: PCI: Interrupt link PI33 configured for IRQ 0
> [    6.907643] ACPI: PCI: Interrupt link PI33 disabled
> [    6.907924] ACPI: PCI: Interrupt link PI40 configured for IRQ 0
> [    6.907926] ACPI: PCI: Interrupt link PI40 disabled
> [    6.908190] ACPI: PCI: Interrupt link PI41 configured for IRQ 0
> [    6.908191] ACPI: PCI: Interrupt link PI41 disabled
> [    6.908454] ACPI: PCI: Interrupt link PI42 configured for IRQ 0
> [    6.908455] ACPI: PCI: Interrupt link PI42 disabled
> [    6.908719] ACPI: PCI: Interrupt link PI43 configured for IRQ 0
> [    6.908720] ACPI: PCI: Interrupt link PI43 disabled
> [    6.913025] ACPI: PCI: Interrupt link PI50 configured for IRQ 0
> [    6.913027] ACPI: PCI: Interrupt link PI50 disabled
> [    6.913292] ACPI: PCI: Interrupt link PI51 configured for IRQ 0
> [    6.913293] ACPI: PCI: Interrupt link PI51 disabled
> [    6.913557] ACPI: PCI: Interrupt link PI52 configured for IRQ 0
> [    6.913558] ACPI: PCI: Interrupt link[    6.913820] ACPI: PCI: Interrupt link PI53 configured for IRQ 0
> [    6.913821] ACPI: PCI: Interrupt link PI53 disabled
> [    6.914097] ACPI: PCI: Interrupt link PI60 configured for IRQ 0
> [    6.914098] ACPI: PCI: Interrupt link PI60 disabled
> [    6.914363] ACPI: PCI: Interrupt link PI61 configured for IRQ 0
> [    6.914365] ACPI: PCI: Interrupt link PI61 disabled
> [    6.914628] ACPI: PCI: Interrupt link PI62 configured for IRQ 0
> [    6.914629] ACPI: PCI: Interrupt link PI62 disabled
> [    6.914900] ACPI: PCI: Interrupt link PI63 configured for IRQ 0
> [    6.914901] ACPI: PCI: Interrupt link PI63 disabled
> [    6.915166] ACPI: PCI: Interrupt link PI70 configured for IRQ 0
> [    6.915167] ACPI: PCI: Interrupt link PI70 disabled
> [    6.915430] ACPI: PCI: Interrupt link PI71 configured for IRQ 0
> [    6.915431] ACPI: PCI: Interrupt link PI71 disabled
> [    6.915695] ACPI: PCI: Interrupt link PI72 configured for IRQ 0
> [    6.915696] ACPI: PCI: Interrupt link PI72 disabled
> [    6.915969] ACPI: PCI: Interrupt link PI73 configured for IRQ 0
> [    6.915970] ACPI: PCI: Interrupt link PI73 disabled
> [    6.916234] ACPI: PCI: Interrupt link PI90 configured for IRQ 0
> [    6.916235] ACPI: PCI: Interrupt link PI90 disabled
> [    6.916499] ACPI: PCI: Interrupt link PI91 configured for IRQ 0
> [    6.916500] ACPI: k PI91 disabled
> [    6.916766] ACPI: PCI: Interrupt link PI92 configured for IRQ 0
> [    6.916767] ACPI: PCI: Interrupt link PI92 disabled
> [    6.917038] ACPI: PCI: Interrupt link PI93 configured for IRQ 0
> [    6.917040] ACPI: PCI: Interrupt link PI93 disabled
> [    6.917303] ACPI: PCI: Interrupt link PIA0 configured for IRQ 0
> [    6.917304] ACPI: PCI: Interrupt link PIA0 disabled
> [    6.917568] ACPI: PCI: Interrupt link PIA1 configured for IRQ 0
> [    6.917569] ACPI: PCI: Interrupt link PIA1 disabled
> [    6.917832] ACPI: PCI: Interrupt link PIA2 configured for IRQ 0
> [    6.917833] ACPI: PCI: Interrupt link PIA2 disabled
> [    6.922111] ACPI: PCI: Interrupt link PIA3 configured for IRQ 0
> [    6.922112] ACPI: PCI: Interrupt link PIA3 disabled
> [    6.922376] ACPI: PCI: Interrupt link PIB0 configured for IRQ 0
> [    6.922378] ACPI: PCI: Interrupt link PIB0 disabled
> [    6.922642] ACPI: PCI: Interrupt link PIB1 configured for IRQ 0
> [    6.922643] ACPI: PCI: Interrupt link PIB1 disabled
> [    6.922920] ACPI: PCI: Interrupt link PIB2 configured for IRQ 0
> [    6.922921] ACPI: PCI: Interrupt link PIB2 disabled
> [    6.923186] ACPI: PCI: Interrupt link PIB3 configured for IRQ 0
> [    6.923187] ACPI: PCI: Interrupt link PIB3 disabled
> [    6.923450] ACPI:  link PIC0 configured for IRQ 0
> [    6.923451] ACPI: PCI: Interrupt link PIC0 disabled
> [    6.923714] ACPI: PCI: Interrupt link PIC1 configured for IRQ 0
> [    6.923715] ACPI: PCI: Interrupt link PIC1 disabled
> [    6.923988] ACPI: PCI: Interrupt link PIC2 configured for IRQ 0
> [    6.923989] ACPI: PCI: Interrupt link PIC2 disabled
> [    6.924254] ACPI: PCI: Interrupt link PIC3 configured for IRQ 0
> [    6.924255] ACPI: PCI: Interrupt link PIC3 disabled
> [    6.924525] ACPI: PCI: Interrupt link PID0 configured for IRQ 0
> [    6.924527] ACPI: PCI: Interrupt link PID0 disabled
> [    6.924791] ACPI: PCI: Interrupt link PID1 configured for IRQ 0
> [    6.924792] ACPI: PCI: Interrupt link PID1 disabled
> [    6.925064] ACPI: PCI: Interrupt link PID2 configured for IRQ 0
> [    6.925065] ACPI: PCI: Interrupt link PID2 disabled
> [    6.925328] ACPI: PCI: Interrupt link PID3 configured for IRQ 0
> [    6.925329] ACPI: PCI: Interrupt link PID3 disabled
> [    6.925592] ACPI: PCI: Interrupt link PIR2 configured for IRQ 0
> [    6.925593] ACPI: PCI: Interrupt link PIR2 disabled
> [    6.925857] ACPI: PCI: Interrupt link PIR3 configured for IRQ 0
> [    6.925858] ACPI: PCI: Interrupt link PIR3 disabled
> [    6.930135] ACPI: PCI: Interrupt link PIRRQ 0
> [    6.930136] ACPI: PCI: Interrupt link PIR4 disabled
> [    6.931022] ACPI: PCI: Interrupt link PIR5 configured for IRQ 0
> [    6.931024] ACPI: PCI: Interrupt link PIR5 disabled
> [    6.931287] ACPI: PCI: Interrupt link PIR6 configured for IRQ 0
> [    6.931288] ACPI: PCI: Interrupt link PIR6 disabled
> [    6.931552] ACPI: PCI: Interrupt link PIR7 configured for IRQ 0
> [    6.931553] ACPI: PCI: Interrupt link PIR7 disabled
> [    6.931816] ACPI: PCI: Interrupt link PIR8 configured for IRQ 0
> [    6.931817] ACPI: PCI: Interrupt link PIR8 disabled
> [    6.932089] ACPI: PCI: Interrupt link PIR9 configured for IRQ 0
> [    6.932090] ACPI: PCI: Interrupt link PIR9 disabled
> [    6.932354] ACPI: PCI: Interrupt link PIRA configured for IRQ 0
> [    6.932355] ACPI: PCI: Interrupt link PIRA disabled
> [    6.932621] ACPI: PCI: Interrupt link PIRB configured for IRQ 0
> [    6.932622] ACPI: PCI: Interrupt link PIRB disabled
> [    6.932894] ACPI: PCI: Interrupt link PIRC configured for IRQ 0
> [    6.932895] ACPI: PCI: Interrupt link PIRC disabled
> [    6.933161] ACPI: PCI: Interrupt link PIRD configured for IRQ 0
> [    6.933162] ACPI: PCI: Interrupt link PIRD disabled
> [    6.933386] ACPI: PCI: Interrupt link USB1 configured for IRQ 22
> [    6.933577] ACPI: PCI: Interrupt link USB2 configured for IRQ 23
> [    6.933792] ACPI: PCI: Interrupt link USB3 configured for IRQ 23
> [    6.936054] ACPI: PCInk USB4 configured for IRQ 22
> [    6.936638] ACPI: PCI: Interrupt link U1PI configured for IRQ 0
> [    6.937392] ACPI: PCI: Interrupt link U2PI configured for IRQ 0
> [    6.938034] ACPI: PCI: Interrupt link U3PI configured for IRQ 0
> [    6.938683] ACPI: PCI: Interrupt link U4PI configured for IRQ 0
> [    6.938813] ACPI: PCI: Interrupt link SATA configured for IRQ 16
> [    6.939096] ACPI: PCI: Interrupt link SATP configured for IRQ 0
> [    6.939227] ACPI: PCI: Interrupt link VIDA configured for IRQ 16
> [    6.939500] ACPI: PCI: Interrupt link VIDP configured for IRQ 0
> [    6.945109] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 40-7f])
> [    6.945116] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    6.945278] acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> [    6.945280] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
> [    6.945291] acpi PNP0A08:01: [Firmware Bug]: no _PXM; falling back to node 7 from hardware (may be inconsistent with A
> CPI node numbers)
> [    6.946427] PCI host bridge to bus 0000:40
> [    6.946429] pci_bus 0000:40: root bus resource [mem 0xfdd00000-0xfdffffff window]
> [    6.946432] pci_bus 0000:40: rce [bus 40-7f]
> [    6.946494] pci 0000:40:00.0: [1002:5a10] type 00 class 0x060000
> [    6.946705] pci 0000:40:0c.0: [1002:5a20] type 01 class 0x060400
> [    6.946783] pci 0000:40:0c.0: PME# supported from D0 D3hot D3cold
> [    6.947639] pci 0000:47:00.0: [19a2:0710] type 00 class 0x020000
> [    6.947665] pci 0000:47:00.0: reg 0x10: [mem 0xfdff0000-0xfdff3fff 64bit]
> [    6.947681] pci 0000:47:00.0: reg 0x18: [mem 0xfdfc0000-0xfdfdffff 64bit]
> [    6.947697] pci 0000:47:00.0: reg 0x20: [mem 0xfdfa0000-0xfdfbffff 64bit]
> [    6.947708] pci 0000:47:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [    6.947809] pci 0000:47:00.0: PME# supported from D3hot D3cold
> [    6.953091] pci 0000:47:00.1: [19a2:0710] type 00 class 0x020000
> [    6.953116] pci 0000:47:00.1: reg 0x10: [mem 0xfdf90000-0xfdf93fff 64bit]
> [    6.953132] pci 0000:47:00.1: reg 0x18: [mem 0xfdf60000-0xfdf7ffff 64bit]
> [    6.953148] pci 0000:47:00.1: reg 0x20: [mem 0xfdf40000-0xfdf5ffff 64bit]
> [    6.953159] pci 0000:47:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [    6.953259] pci 0000:47:00.1: PME# supported from D3hot D3cold
> [    6.953632] pci 0000:47:00.2: [19a2:0714] type 00 class 0x0c0400
> [    6.953657] pci 0000:47:00.2: reg 0x10: [mem 0xfdf30000-0xfdf33fff 64bit]
> [    6.953673] pci 0000:47:00.2: reg 0x18: [mem 0xfdf00000-0xfdf  6.953689] pci 0000:47:00.2: reg 0x20: [mem 0xfdee0000-0
> xfdefffff 64bit]
> [    6.953700] pci 0000:47:00.2: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [    6.953799] pci 0000:47:00.2: PME# supported from D3hot D3cold
> [    6.954161] pci 0000:47:00.3: [19a2:0714] type 00 class 0x0c0400
> [    6.954186] pci 0000:47:00.3: reg 0x10: [mem 0xfded0000-0xfded3fff 64bit]
> [    6.954202] pci 0000:47:00.3: reg 0x18: [mem 0xfdea0000-0xfdebffff 64bit]
> [    6.954218] pci 0000:47:00.3: reg 0x20: [mem 0xfde80000-0xfde9ffff 64bit]
> [    6.954229] pci 0000:47:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [    6.954329] pci 0000:47:00.3: PME# supported from D3hot D3cold
> [    6.954705] pci 0000:40:0c.0: PCI bridge to [bus 47-49]
> [    6.954711] pci 0000:40:0c.0:   bridge window [mem 0xfde00000-0xfdffffff]
> [    6.960218] ACPI: PCI: Interrupt link I020 configured for IRQ 56
> [    6.961749] ACPI: PCI: Interrupt link I021 configured for IRQ 57
> [    6.963194] ACPI: PCI: Interrupt link I022 configured for IRQ 58
> [    6.969357] ACPI: PCI: Interrupt link I023 configured for IRQ 59
> [    6.970769] ACPI: PCI: Interrupt link I030 configured for IRQ 56
> [    6.972217] ACPI: PCI: Interrupt link I031 configured for IRQ 57
> [    6.978271] ACPI: PCI: Inter configured for IRQ 58
> [    6.979753] ACPI: PCI: Interrupt link I033 configured for IRQ 59
> [    6.981199] ACPI: PCI: Interrupt link I040 configured for IRQ 76
> [    6.986663] ACPI: PCI: Interrupt link I041 configured for IRQ 77
> [    6.988353] ACPI: PCI: Interrupt link I042 configured for IRQ 78
> [    6.989860] ACPI: PCI: Interrupt link I043 configured for IRQ 79
> [    6.995563] ACPI: PCI: Interrupt link I050 configured for IRQ 80
> [    6.997063] ACPI: PCI: Interrupt link I051 configured for IRQ 81
> [    7.002928] ACPI: PCI: Interrupt link I052 configured for IRQ 82
> [    7.004461] ACPI: PCI: Interrupt link I053 configured for IRQ 83
> [    7.010032] ACPI: PCI: Interrupt link I060 configured for IRQ 79
> [    7.012333] ACPI: PCI: Interrupt link I061 configured for IRQ 76
> [    7.013843] ACPI: PCI: Interrupt link I062 configured for IRQ 77
> [    7.020007] ACPI: PCI: Interrupt link I063 configured for IRQ 78
> [    7.021510] ACPI: PCI: Interrupt link I070 configured for IRQ 56
> [    7.023051] ACPI: PCI: Interrupt link I071 configured for IRQ 57
> [    7.028970] ACPI: PCI: Interrupt link I072 configured for IRQ 58
> [    7.030547] ACPI: PCI: Interrupt link I073 configured for IRQ 59
> [    7.030918] ACPI: PCI: Interrupt link I090 configured for IRQ 24
> [    7.03127rrupt link I091 configured for IRQ 24
> [    7.031637] ACPI: PCI: Interrupt link I092 configured for IRQ 24
> [    7.036010] ACPI: PCI: Interrupt link I093 configured for IRQ 24
> [    7.037731] ACPI: PCI: Interrupt link I0A0 configured for IRQ 56
> [    7.039312] ACPI: PCI: Interrupt link I0A1 configured for IRQ 57
> [    7.045203] ACPI: PCI: Interrupt link I0A2 configured for IRQ 58
> [    7.046821] ACPI: PCI: Interrupt link I0A3 configured for IRQ 59
> [    7.048405] ACPI: PCI: Interrupt link I0B0 configured for IRQ 64
> [    7.054185] ACPI: PCI: Interrupt link I0B1 configured for IRQ 65
> [    7.055810] ACPI: PCI: Interrupt link I0B2 configured for IRQ 66
> [    7.062218] ACPI: PCI: Interrupt link I0B3 configured for IRQ 67
> [    7.063812] ACPI: PCI: Interrupt link I0C0 configured for IRQ 68
> [    7.065444] ACPI: PCI: Interrupt link I0C1 configured for IRQ 69
> [    7.072065] ACPI: PCI: Interrupt link I0C2 configured for IRQ 70
> [    7.073736] ACPI: PCI: Interrupt link I0C3 configured for IRQ 71
> [    7.079971] ACPI: PCI: Interrupt link I0D0 configured for IRQ 72
> [    7.081614] ACPI: PCI: Interrupt link I0D1 configured for IRQ 73
> [    7.088027] ACPI: PCI: Interrupt link I0D2 configured for IRQ 74
> [    7.089717] ACPI: PCI: Interrupt lgured for IRQ 75
> [    7.089877] ACPI: PCI: Interrupt link BI02 configured for IRQ 84
> [    7.090069] ACPI: PCI: Interrupt link BI03 configured for IRQ 56
> [    7.090275] ACPI: PCI: Interrupt link BI04 configured for IRQ 56
> [    7.090502] ACPI: PCI: Interrupt link BI05 configured for IRQ 56
> [    7.090754] ACPI: PCI: Interrupt link BI06 configured for IRQ 86
> [    7.091040] ACPI: PCI: Interrupt link BI07 configured for IRQ 56
> [    7.091336] ACPI: PCI: Interrupt link BI08 configured for IRQ 56
> [    7.091656] ACPI: PCI: Interrupt link BI09 configured for IRQ 56
> [    7.096012] ACPI: PCI: Interrupt link BI0A configured for IRQ 56
> [    7.096381] ACPI: PCI: Interrupt link BI0B configured for IRQ 86
> [    7.096770] ACPI: PCI: Interrupt link BI0C configured for IRQ 86
> [    7.097289] ACPI: PCI: Interrupt link BI0D configured for IRQ 86
> [    7.097510] ACPI: PCI: Interrupt link PI20 configured for IRQ 0
> [    7.097511] ACPI: PCI: Interrupt link PI20 disabled
> [    7.097781] ACPI: PCI: Interrupt link PI21 configured for IRQ 0
> [    7.097783] ACPI: PCI: Interrupt link PI21 disabled
> [    7.098060] ACPI: PCI: Interrupt link PI22 configured for IRQ 0
> [    7.098061] ACPI: PCI: Interrupt link PI22 disabled
> [    7.098327] ACPI: PCI: Interrupt link PI23 configured for IRQ 0
> [    7.098328] ACPI: PCI: Interrupt link PI23 disabled
> [    7.098594] A: PCI: Interrupt link PI30 configured for IRQ 0
> [    7.098596] ACPI: PCI: Interabled
> [    7.098859] ACPI: PCI: Interrupt link PI31 configured for IRQ 0
> [    7.098861] ACPI: PCI: Interrupt link PI31 disabled
> [    7.099134] ACPI: PCI: Interrupt link PI32 configured for IRQ 0
> [    7.099135] ACPI: PCI: Interrupt link PI32 disabled
> [    7.099399] ACPI: PCI: Interrupt link PI33 configured for IRQ 0
> [    7.099400] ACPI: PCI: Interrupt link PI33 disabled
> [    7.099663] ACPI: PCI: Interrupt link PI40 configured for IRQ 0
> [    7.099664] ACPI: PCI: Interrupt link PI40 disabled
> [    7.103949] ACPI: PCI: Interrupt link PI41 configured for IRQ 0
> [    7.103950] ACPI: PCI: Interrupt link PI41 disabled
> [    7.104215] ACPI: PCI: Interrupt link PI42 configured for IRQ 0
> [    7.104216] ACPI: PCI: Interrupt link PI42 disabled
> [    7.104900] ACPI: PCI: Interrupt link PI43 configured for IRQ 0
> [    7.104901] ACPI: PCI: Interrupt link PI43 disabled
> [    7.105166] ACPI: PCI: Interrupt link PI50 configured for IRQ 0
> [    7.105167] ACPI: PCI: Interrupt link PI50 disabled
> [    7.105432] ACPI: PCI: Interrupt link PI51 configured for IRQ 0
> [    7.105433] ACPI: PCI: Interrupt link PI51 disabled
> [    7.105697] ACPI: PCI: Interrupt link PI52 configured for IRQ 0
> [    7.105698] ACPI: PCI: Interrupt link PI52 disabled
> [ CPI: PCI: Interrupt link PI53 configured for IRQ 0
> [    7.105972] ACPI: PCI: Interrupt link PI53 disabled
> [    7.106237] ACPI: PCI: Interrupt link PI60 configured for IRQ 0
> [    7.106238] ACPI: PCI: Interrupt link PI60 disabled
> [    7.106502] ACPI: PCI: Interrupt link PI61 configured for IRQ 0
> [    7.106503] ACPI: PCI: Interrupt link PI61 disabled
> [    7.106766] ACPI: PCI: Interrupt link PI62 configured for IRQ 0
> [    7.106767] ACPI: PCI: Interrupt link PI62 disabled
> [    7.107040] ACPI: PCI: Interrupt link PI63 configured for IRQ 0
> [    7.107041] ACPI: PCI: Interrupt link PI63 disabled
> [    7.107306] ACPI: PCI: Interrupt link PI70 configured for IRQ 0
> [    7.107307] ACPI: PCI: Interrupt link PI70 disabled
> [    7.107572] ACPI: PCI: Interrupt link PI71 configured for IRQ 0
> [    7.107573] ACPI: PCI: Interrupt link PI71 disabled
> [    7.107837] ACPI: PCI: Interrupt link PI72 configured for IRQ 0
> [    7.107838] ACPI: PCI: Interrupt link PI72 disabled
> [    7.112116] ACPI: PCI: Interrupt link PI73 configured for IRQ 0
> [    7.112117] ACPI: PCI: Interrupt link PI73 disabled
> [    7.112382] ACPI: PCI: Interrupt link PI90 configured for IRQ 0
> [    7.112383] ACPI: PCI: Interrupt link PI90 disabled
> [    7.112647] ACPI: PCI: Interrupt link PI91 configured for IRQ 0
> [    7.112649] ACPI: PCI: Interrupt li
>                                       [    7.113094] ACPI: PCI: Interrupt link PI92 configured for IRQ 0
> [    7.113095] ACPI: PCI: Interrupt link PI92 disabled
> [    7.113359] ACPI: PCI: Interrupt link PI93 configured for IRQ 0
> [    7.113360] ACPI: PCI: Interrupt link PI93 disabled
> [    7.113626] ACPI: PCI: Interrupt link PIA0 configured for IRQ 0
> [    7.113627] ACPI: PCI: Interrupt link PIA0 disabled
> [    7.113901] ACPI: PCI: Interrupt link PIA1 configured for IRQ 0
> [    7.113902] ACPI: PCI: Interrupt link PIA1 disabled
> [    7.114167] ACPI: PCI: Interrupt link PIA2 configured for IRQ 0
> [    7.114168] ACPI: PCI: Interrupt link PIA2 disabled
> [    7.114433] ACPI: PCI: Interrupt link PIA3 configured for IRQ 0
> [    7.114434] ACPI: PCI: Interrupt link PIA3 disabled
> [    7.114698] ACPI: PCI: Interrupt link PIB0 configured for IRQ 0
> [    7.114699] ACPI: PCI: Interrupt link PIB0 disabled
> [    7.114971] ACPI: PCI: Interrupt link PIB1 configured for IRQ 0
> [    7.114972] ACPI: PCI: Interrupt link PIB1 disabled
> [    7.115237] ACPI: PCI: Interrupt link PIB2 configured for IRQ 0
> [    7.115238] ACPI: PCI: Interrupt link PIB2 disabled
> [    7.115501] ACPI: PCI: Interrupt link PIB3 configured for IRQ 0
> [    7.115502] ACPI: PCI: Interrupt link PIB3 disabled
> [    7.115765] ACPI: PCI: Interrupt igured for IRQ 0
> [    7.115766] ACPI: PCI: Interrupt link PIC0 disabled
> [    7.116042] ACPI: PCI: Interrupt link PIC1 configured for IRQ 0
> [    7.116043] ACPI: PCI: Interrupt link PIC1 disabled
> [    7.116306] ACPI: PCI: Interrupt link PIC2 configured for IRQ 0
> [    7.116307] ACPI: PCI: Interrupt link PIC2 disabled
> [    7.116571] ACPI: PCI: Interrupt link PIC3 configured for IRQ 0
> [    7.116573] ACPI: PCI: Interrupt link PIC3 disabled
> [    7.116838] ACPI: PCI: Interrupt link PID0 configured for IRQ 0
> [    7.116839] ACPI: PCI: Interrupt link PID0 disabled
> [    7.121124] ACPI: PCI: Interrupt link PID1 configured for IRQ 0
> [    7.121125] ACPI: PCI: Interrupt link PID1 disabled
> [    7.121390] ACPI: PCI: Interrupt link PID2 configured for IRQ 0
> [    7.121391] ACPI: PCI: Interrupt link PID2 disabled
> [    7.121656] ACPI: PCI: Interrupt link PID3 configured for IRQ 0
> [    7.121657] ACPI: PCI: Interrupt link PID3 disabled
> [    7.122075] ACPI: PCI: Interrupt link PIR2 configured for IRQ 0
> [    7.122076] ACPI: PCI: Interrupt link PIR2 disabled
> [    7.122340] ACPI: PCI: Interrupt link PIR3 configured for IRQ 0
> [    7.122341] ACPI: PCI: Interrupt link PIR3 disabled
> [    7.122606] ACPI: PCI: Interrupt link PIR4 configured for2607] ACPI: PCI: Interrupt link PIR4 disabled
> [    7.122872] ACPI: PCI: Interrupt link PIR5 configured for IRQ 0
> [    7.122873] ACPI: PCI: Interrupt link PIR5 disabled
> [    7.123145] ACPI: PCI: Interrupt link PIR6 configured for IRQ 0
> [    7.123146] ACPI: PCI: Interrupt link PIR6 disabled
> [    7.123410] ACPI: PCI: Interrupt link PIR7 configured for IRQ 0
> [    7.123411] ACPI: PCI: Interrupt link PIR7 disabled
> [    7.123675] ACPI: PCI: Interrupt link PIR8 configured for IRQ 0
> [    7.123676] ACPI: PCI: Interrupt link PIR8 disabled
> [    7.123949] ACPI: PCI: Interrupt link PIR9 configured for IRQ 0
> [    7.123950] ACPI: PCI: Interrupt link PIR9 disabled
> [    7.124214] ACPI: PCI: Interrupt link PIRA configured for IRQ 0
> [    7.124215] ACPI: PCI: Interrupt link PIRA disabled
> [    7.124478] ACPI: PCI: Interrupt link PIRB configured for IRQ 0
> [    7.124479] ACPI: PCI: Interrupt link PIRB disabled
> [    7.124741] ACPI: PCI: Interrupt link PIRC configured for IRQ 0
> [    7.124742] ACPI: PCI: Interrupt link PIRC disabled
> [    7.129018] ACPI: PCI: Interrupt link PIRD configured for IRQ 0
> [    7.129019] ACPI: PCI: Interrupt link PIRD disabled
> [    7.130428] iommu: Default domain type: Translated 
> [    7.130430] iommu: DMA domaation policy: lazy mode 
> [    7.131057] SCSI subsystem initialized
> [    7.131141] ACPI: bus type USB registered
> [    7.131247] usbcore: registered new interface driver usbfs
> [    7.131290] usbcore: registered new interface driver hub
> [    7.131320] usbcore: registered new device driver usb
> [    7.131411] pps_core: LinuxPPS API ver. 1 registered
> [    7.131412] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    7.131421] PTP clock support registered
> [    7.134936] EDAC MC: Ver: 3.0.0
> [    7.136898] NetLabel: Initializing
> [    7.136899] NetLabel:  domain hash size = 128
> [    7.136900] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    7.136959] NetLabel:  unlabeled traffic allowed by default
> [    7.136960] PCI: Using ACPI for IRQ routing
> [    7.155687] pci 0000:01:03.0: vgaarb: setting as boot VGA device
> [    7.155690] pci 0000:01:03.0: vgaarb: bridge control possible
> [    7.155691] pci 0000:01:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    7.155696] vgaarb: loaded
> [    7.156075] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [    7.156081] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
> [    7.163999] clocksource: Switched to clocksource hpet
> [    7.512534] VFS: Disk quotas dquot_6.6.0
> [    7.512574] VFS: Dquot-cache hash table entries: 512 (or
> [    7.512747] Warning: Zero PT_NOTE entries found
> [    7.512767] Warning: Zero PT_NOTE entries found
> [    7.512778] Warning: Zero PT_NOTE entries found
> [    7.512788] Warning: Zero PT_NOTE entries found
> [    7.512799] Warning: Zero PT_NOTE entries found
> [    7.512809] Warning: Zero PT_NOTE entries found
> [    7.512819] Warning: Zero PT_NOTE entries found
> [    7.512829] Warning: Zero PT_NOTE entries found
> [    7.512839] Warning: Zero PT_NOTE entries found
> [    7.512850] Warning: Zero PT_NOTE entries found
> [    7.512860] Warning: Zero PT_NOTE entries found
> [    7.512870] Warning: Zero PT_NOTE entries found
> [    7.512881] Warning: Zero PT_NOTE entries found
> [    7.512906] Warning: Zero PT_NOTE entries found
> [    7.512916] Warning: Zero PT_NOTE entries found
> [    7.512927] Warning: Zero PT_NOTE entries found
> [    7.512937] Warning: Zero PT_NOTE entries found
> [    7.512947] Warning: Zero PT_NOTE entries found
> [    7.512966] Warning: Zero PT_NOTE entries found
> [    7.512978] Warning: Zero PT_NOTE entries found
> [    7.513005] Warning: Zero PT_NOTE entries found
> [    7.513016] Warning: Zero PT_NOTE entries found
> [    7.513026] Warning: Zero PT_NOTE entries found
> [    7.513036] Warning: Zero PT_NOTE entries found
> [    7.513047] Warning: Zero PT_NOTE entries found
> [    7.513057] Warning: Zerfound
> [    7.513067] Warning: Zero PT_NOTE entries found
> [    7.513078] Warning: Zero PT_NOTE entries found
> [    7.513088] Warning: Zero PT_NOTE entries found
> [    7.513098] Warning: Zero PT_NOTE entries found
> [    7.513108] Warning: Zero PT_NOTE entries found
> [    7.513118] Warning: Zero PT_NOTE entries found
> [    7.513128] Warning: Zero PT_NOTE entries found
> [    7.513138] Warning: Zero PT_NOTE entries found
> [    7.513148] Warning: Zero PT_NOTE entries found
> [    7.513158] Warning: Zero PT_NOTE entries found
> [    7.513168] Warning: Zero PT_NOTE entries found
> [    7.513178] Warning: Zero PT_NOTE entries found
> [    7.513188] Warning: Zero PT_NOTE entries found
> [    7.513198] Warning: Zero PT_NOTE entries found
> [    7.513208] Warning: Zero PT_NOTE entries found
> [    7.513218] Warning: Zero PT_NOTE entries found
> [    7.513228] Warning: Zero PT_NOTE entries found
> [    7.513239] Warning: Zero PT_NOTE entries found
> [    7.513249] Warning: Zero PT_NOTE entries found
> [    7.513259] Warning: Zero PT_NOTE entries found
> [    7.513588] pnp: PnP ACPI init
> [    7.521040] system 00:00: [io  0x0379-0x037a] has been reserved
> [    7.521046] system 00:00: [io  0x0400-0x043f] has been reserved
> [    7.521049] system 00:00: [id1] has been reserved
> [    7.521052] system 00:00: [io  0x04d6] has been reserved
> [    7.521055] system 00:00: [io  0x0520] has been reserved
> [    7.521058] system 00:00: [io  0x0580-0x059f] has been reserved
> [    7.521061] system 00:00: [io  0x0600-0x067f] has been reserved
> [    7.521063] system 00:00: [io  0x0700-0x0703] has been reserved
> [    7.521066] system 00:00: [io  0x0820-0x082f] has been reserved
> [    7.521069] system 00:00: [io  0x0900-0x09fe] has been reserved
> [    7.521072] system 00:00: [io  0x0c06-0x0c07] has been reserved
> [    7.521074] system 00:00: [io  0x0c14] has been reserved
> [    7.521077] system 00:00: [io  0x0c4a] has been reserved
> [    7.521080] system 00:00: [io  0x0c50-0x0c52] has been reserved
> [    7.521082] system 00:00: [io  0x0c6c] has been reserved
> [    7.521085] system 00:00: [io  0x0c6f] has been reserved
> [    7.521088] system 00:00: [io  0x0c80-0x0c83] has been reserve9wGo-#fos2:
>                                                                             .5219Mknkamdcc dbsi20 wpiam cdi6_rof odptlekl
> y ttus3lo ea_ilimo  asia tcme_gmv  
>                                     9ia 
>                                         59hsn6)0yertb0
> ul9C8e2 et.#b                                         e7hss6)favepeu
>             eHePDL 1/
> 
>                      ]Weslw
>                            73Rml_m_/0
>                                      ]3C 5ca 5a 04 0c b0 81  a 4
>                                                                 09Rf2ES
> 0R0000R c0
>           s9R0000  00
>                      e9R7700R 0sF0:f000:00
>                                           01C00C 03
>                                                     1C6500C 00
>                                                               51C
>                                                                   4 
>                                                                      4 _+0
> ed1 t                                                                     e cd0
>       el
>          h
>           7 _+
>                bx
>                  4 b
>                     1 k
>                         o
>                          3 x
>                             3 o
>                                ]  1
>                                    4 e0
>                                         x
>                                           
>                                           [    7.521102] system 00:00: [io  0x0b00-0x0b3f] has been reserved
> [    7.521105] system 00:00: [io  0x02f8-0x02ff] has been reserved
> [    7.521108] system 00:00: [mem 0xc0000000-0xcfffffff] has been reserved
> [    7.528692] pnp: PnP ACPI: found 5 devices
> [    7.539782] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    7.539971] NET: Registered PF_INET protocol family
> [    7.540079] IP idents hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    7.540638] tcp_listen_portaddr_hash hash table entries: 256 (order: 2, 18432 bytes, linear)
> [    7.540649] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    7.540663] TCP established hash table entries: 4096 (order: 3, 32768 bytes, linear)
> [    7.540696] TCP bind hash table entries: 4096 (order: 6, 294912 bytes, linear)
> [    7.540853] TCP: Hash tables configured (established 4096 bind 4096)
> [    7.541041] MPTCP token hash table entries: 512 (order: 3, 45056 bytes, linear)
> [    7.541087] UDP hash table entries: 256 (order: 3, 40960 bytes, linear)
> [    7.541113] UDP-Lite hash table entries: 256 (order: 3, 40960 bytes, linear)
> [    7.541274] NET: Registered PF_UNIX/PF_LOCALly
> [    7.541288] NET: Registered PF_XDP protocol family
> [    7.541310] pci 0000:00:02.0: PCI bridge to [bus 04]
> [    7.541317] pci 0000:00:02.0:   bridge window [mem 0xee000000-0xfdbfffff]
> [    7.541327] pci 0000:03:00.0: BAR 6: assigned [mem 0xedd00000-0xedd7ffff pref]
> [    7.541331] pci 0000:00:04.0: PCI bridge to [bus 03]
> [    7.541334] pci 0000:00:04.0:   bridge window [io  0x4000-0x4fff]
> [    7.541337] pci 0000:00:04.0:   bridge window [mem 0xedd00000-0xedffffff]
> [    7.541344] pci 0000:02:00.2: BAR 6: assigned [mem 0xeda00000-0xeda0ffff pref]
> [    7.541347] pci 0000:00:0a.0: PCI bridge to [bus 02]
> [    7.541349] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
> [    7.541352] pci 0000:00:0a.0:   bridge window [mem 0xeda00000-0xedcfffff]
> [    7.541360] pci 0000:00:14.4: PCI bridge to [bus 01]
> [    7.541362] pci 0000:00:14.4:   bridge window [io  0x2000-0x2fff]
> [    7.541368] pci 0000:00:14.4:   bridge window [mem 0xed900000-0xed9fffff]
> [    7.541372] pci 0000:00:14.4:   bridge window [mem 0xe0000000-0xe7ffffff pref]
> [    7.541384] pci_bus 0000:00: resource 4 [mem 0xdff00000-0xfdbfffff window]
> [    7.541386] pci_bus 0000:00: resource 5 [io  0x1000-0xfff.541388] pci_bus 0000:00: resource 6 [io  0x0000-0x03af windo
> w]
> [    7.541389] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
> [    7.541391] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
> [    7.541392] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed03fff window]
> [    7.541394] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed44fff window]
> [    7.541395] pci_bus 0000:00: resource 11 [io  0x03b0-0x03bb window]
> [    7.541397] pci_bus 0000:00: resource 12 [io  0x03c0-0x03df window]
> [    7.541398] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
> [    7.541400] pci_bus 0000:04: resource 1 [mem 0xee000000-0xfdbfffff]
> [    7.541402] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
> [    7.541403] pci_bus 0000:03: resource 1 [mem 0xedd00000-0xedffffff]
> [    7.541405] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
> [    7.541406] pci_bus 0000:02: resource 1 [mem 0xeda00000-0xedcfffff]
> [    7.541408] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
> [    7.541409] pci_bus 0000:01: resource 1 [mem 0xed900000-0xed9fffff]
> [    7.541411] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xe7ffffff pref]
> [    7.541412] pci_bus 0000:01: resource 4 [mem 0xdff00000-0xfdbfffff window]
> [    7.541413] pci_bus 0000:01: resource 5 [io  0x1000-0xffff window]
> [    7.541415] pci_bus 0000:01: r000-0x03af window]
> [    7.541416] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
> [    7.541417] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
> [    7.541419] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed03fff window]
> [    7.541420] pci_bus 0000:01: resource 10 [mem 0xfed40000-0xfed44fff window]
> [    7.541422] pci_bus 0000:01: resource 11 [io  0x03b0-0x03bb window]
> [    7.541423] pci_bus 0000:01: resource 12 [io  0x03c0-0x03df window]
> [    7.541424] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
> [    7.541807] pci 0000:47:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
> [    7.541810] pci 0000:47:00.1: BAR 6: assigned [mem 0xfde40000-0xfde7ffff pref]
> [    7.541813] pci 0000:47:00.2: BAR 6: no space for [mem size 0x00040000 pref]
> [    7.541826] pci 0000:47:00.2: BAR 6: failed to assign [mem size 0x00040000 pref]
> [    7.541829] pci 0000:47:00.3: BAR 6: no space for [mem size 0x00040000 pref]
> [    7.541831] pci 0000:47:00.3: BAR 6: failed to assign [mem size 0x00040000 pref]
> [    7.541833] pci 0000:40:0c.0: PCI bridge to [bus 47-49]
> [    7.541837] pci 0000:40:0c.0:   bridge window [mem 0xfde00000-0    7.541842] pci_bus 0000:40: resource 4 [mem 0xfdd000
> 00-0xfdffffff window]
> [    7.541844] pci_bus 0000:47: resource 1 [mem 0xfde00000-0xfdffffff]
> [    7.542619] ACPI: \_SB_.PCI0.USB1: Enabled at IRQ 22
> [    7.544134] ACPI: \_SB_.PCI0.USB2: Enabled at IRQ 23
> [    7.544833] ACPI: \_SB_.PCI0.USB3: Enabled at IRQ 23
> [    7.546134] ACPI: \_SB_.PCI0.USB4: Enabled at IRQ 22
> [    7.547241] ACPI: \_SB_.PCI0.BI0A: Enabled at IRQ 24
> [    7.548108] ACPI: \_SB_.PCI0.I061: Enabled at IRQ 44
> [    7.548300] PCI: CLS 64 bytes, default 64
> [    7.548358] ACPI: bus type thunderbolt registered
> [    7.548630] LVT offset 0 assigned for vector 0x400
> [    7.549233] Unpacking initramfs...
> [    7.687854] perf: AMD IBS detected (0x000000ff)
> [    7.687932] amd_uncore: 4  amd_nb counters detected
> [    7.690734] Initialise system trusted keyrings
> [    7.690796] Key type blacklist registered
> [    7.696691] workingset: timestamp_bits=36 max_order=17 bucket_order=0
> [    7.716158] zbud: loaded
> [    7.722039] integrity: Platform Keyring initialized
> [    7.746083] NET: Registered PF_ALG protocol family
> [    7.746156] xor: automatically using best checksumming function   avx       
> [    7.746160] Key type asymmetric registered
> [    7.746172] Asymmetric key parser 'x509' r.886726] Freeing initrd memory: 20892K
> [    7.905775] alg: self-tests for CTR-KDF (hmac(sha256)) passed
> [    7.905846] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [    7.908709] io scheduler mq-deadline registered
> [    7.908712] io scheduler kyber registered
> [    7.908931] io scheduler bfq registered
> [    7.913007] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [    7.914429] ACPI: \_SB_.PCI0.BI02: Enabled at IRQ 52
> [    7.915572] ACPI: \_SB_.PCI0.BI04: Enabled at IRQ 52
> [    7.916498] ACPI: \_SB_.PCI1.BI0C: Enabled at IRQ 86
> [    7.917217] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    7.918184] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    7.918609] ACPI: button: Power Button [PWRF]
> [    7.918704] ACPI: \_SB_.C018: Found 2 idle states
> [    7.922750] ERST: Failed to get Error Log Address Range.
> [    7.923227] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    7.923469] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    7.923934] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [    7.925449 memory driver v1.3
> [    7.926446] rdac: device handler registered
> [    7.929261] hp_sw: device handler registered
> [    7.929262] emc: device handler registered
> [    7.929375] alua: device handler registered
> [    7.930077] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    7.930087] ehci-pci: EHCI PCI platform driver
> [    7.930577] ehci-pci 0000:00:12.2: EHCI Host Controller
> [    7.931063] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
> [    7.931094] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    7.931109] ehci-pci 0000:00:12.2: debug port 1
> [    7.931294] ehci-pci 0000:00:12.2: irq 23, io mem 0xed8c0000
> [    7.939439] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
> [    7.939838] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
> [    7.939841] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.939844] usb usb1: Product: EHCI Host Controller
> [    7.939845] usb usb1: Manufacturer: Linux 5.19.0-rc2+ ehci_hcd
> [    7.939847] usb usb1: SerialNumber: 0000:00:12.2
> [    7.940622] hub 1-0:1.0: USB hub found
> [    7.940681] hub 1-0:1.0: 6 ports detected
> [    7.942563] ehci-pci 0000:00:13.2: EHCI Host Controller
> [    7.942705] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
> [  ci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    7.942723] ehci-pci 0000:00:13.2: debug port 1
> [    7.942818] ehci-pci 0000:00:13.2: irq 22, io mem 0xed890000
> [    7.950591] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
> [    7.950841] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
> [    7.950844] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.950846] usb usb2: Product: EHCI Host Controller
> [    7.950848] usb usb2: Manufacturer: Linux 5.19.0-rc2+ ehci_hcd
> [    7.950849] usb usb2: SerialNumber: 0000:00:13.2
> [    7.951268] hub 2-0:1.0: USB hub found
> [    7.951298] hub 2-0:1.0: 6 ports detected
> [    7.952267] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    7.952277] ohci-pci: OHCI PCI platform driver
> [    7.952637] ohci-pci 0000:00:12.0: OHCI PCI host controller
> [    7.952972] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
> [    7.953082] ohci-pci 0000:00:12.0: irq 22, io mem 0xed8e0000
> [    8.176816] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [    8.176819] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    8.176822] usb usb3: Produost controller
> [    8.176823] usb usb3: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [    8.176825] usb usb3: SerialNumber: 0000:00:12.0
> [    8.177387] hub 3-0:1.0: USB hub found
> [    8.177440] hub 3-0:1.0: 3 ports detected
> [    8.178504] ohci-pci 0000:00:12.1: OHCI PCI host controller
> [    8.178670] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 4
> [    8.178754] ohci-pci 0000:00:12.1: irq 22, io mem 0xed8d0000
> [    8.676100] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [    8.676103] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    8.676105] usb usb4: Product: OHCI PCI host controller
> [    8.676107] usb usb4: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [    8.676108] usb usb4: SerialNumber: 0000:00:12.1
> [    8.676488] hub 4-0:1.0: USB hub found
> [    8.676520] hub 4-0:1.0: 3 ports detected
> [    8.677414] ohci-pci 0000:00:13.0: OHCI PCI host controller
> [    8.677568] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
> [    8.677624] ohci-pci 0000:00:13.0: irq 23, io mem 0xed8b0000
> [    8.734816] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [    8.734819] usb usb5: New USB device strings: Mfr=3,Number=1
> [    8.734821] usb usb5: Product: OHCI PCI host controller
> [    8.734823] usb usb5: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [    8.734824] usb usb5: SerialNumber: 0000:00:13.0
> [    8.735224] hub 5-0:1.0: USB hub found
> [    8.735256] hub 5-0:1.0: 3 ports detected
> [    8.736145] ohci-pci 0000:00:13.1: OHCI PCI host controller
> [    8.736320] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 6
> [    8.736389] ohci-pci 0000:00:13.1: irq 23, io mem 0xed8a0000
> [    9.291804] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [    9.291807] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    9.291809] usb usb6: Product: OHCI PCI host controller
> [    9.291811] usb usb6: Manufacturer: Linux 5.19.0-rc2+ ohci_hcd
> [    9.291812] usb usb6: SerialNumber: 0000:00:13.1
> [    9.292225] hub 6-0:1.0: USB hub found
> [    9.292280] hub 6-0:1.0: 3 ports detected
> [    9.292873] uhci_hcd: USB Universal Host Controller Interface driver
> [    9.293324] uhci_hcd 0000:02:00.4: UHCI Host Controller
> [    9.293467] uhci_hcd 0000:02:00.4: new USB bus registered, assigned bus number 7
> [    9.293482] uhci_hcd 0000:02:00.4: detected 8 ports
> [    9.293484] uhci_hcd 0000:02:00.4: port count misdetected? frts
> [    9.293577] uhci_hcd 0000:02:00.4: irq 32, io port 0x00003c00
> [    9.297] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
> [    9.293809] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    9.293811] usb usb7: Product: UHCI Host Controller
> [    9.293813] usb usb7: Manufacturer: Linux 5.19.0-rc2+ uhci_hcd
> [    9.293814] usb usb7: SerialNumber: 0000:02:00.4
> [    9.294230] hub 7-0:1.0: USB hub found
> [    9.294268] hub 7-0:1.0: 2 ports detected
> [    9.294917] usbcore: registered new interface driver usbserial_generic
> [    9.294983] usbserial: USB Serial support registered for generic
> [    9.295100] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
> [    9.299990] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    9.300017] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    9.300277] mousedev: PS/2 mouse device common for all mice
> [    9.300771] rtc_cmos 00:04: RTC can wake from S4
> [    9.302163] rtc_cmos 00:04: registered as rtc0
> [    9.302217] rtc_cmos 00:04: setting system clock to 2022-06-22T03:15:46 UTC (1655867746)
> [    9.302316] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    9.306763] hid: raw HID events driver (C) Jiri Kosina
> [    9.306919] usbcore: registered new interface driver usb06920] usbhid: USB HID core driver
> [    9.307145] drop_monitor: Initializing network drop monitor service
> [    9.307299] Initializing XFRM netlink socket
> [    9.307935] NET: Registered PF_INET6 protocol family
> [   10.319124] Segment Routing with IPv6
> [   10.319144] In-situ OAM (IOAM) with IPv6
> [   10.319180] NET: Registered PF_PACKET protocol family
> [   10.319340] mpls_gso: MPLS GSO support
> [   10.319344] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
> [   10.319354] mce: Unable to init MCE device (rc: -5)
> [   10.319737] microcode: CPU0: patch_level=0x06000822
> [   10.319746] microcode: Microcode Update Driver: v2.2.
> [   10.319751] IPI shorthand broadcast: enabled
> [   10.319790] AVX version of gcm_enc/dec engaged.
> [   10.319820] AES CTR mode by8 optimization enabled
> [   10.321211] registered taskstats version 1
> [   10.321492] Loading compiled-in X.509 certificates
> [   10.368695] Loaded X.509 cert 'Build time autogenerated kernel key: 67cb6d2492a17d9861a4ac6ba7a04726ea6886bf'
> [   10.369145] zswap: loaded using pool lzo/zbud
> [   10.369363] page_owner is disabled
> [   10.369542] Key type big_key registered
> [   10.369931] usb 7-1: new full-speed USB device number 2 using uhci_hcd
> [   11.3w USB device found, idVendor=03f0, idProduct=7029, bcdDevice= 0.02
> [   11.340536] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   11.340538] usb 7-1: Product: Virtual Keyboard 
> [   11.340540] usb 7-1: Manufacturer: HP 
> [   11.859676] input: HP  Virtual Keyboard  as /devices/pci0000:00/0000:00:0a.0/0000:02:00.4/usb7/7-1/7-1:1.0/0003:03F0:7
> 029.0001/input/input7
> [   12.314804] hid-generic 0003:03F0:7029.0001: input,hidraw0: USB HID v1.01 Keyboard [HP  Virtual Keyboard ] on usb-0000
> :02:00.4-1/input0
> [   12.318877] input: HP  Virtual Keyboard  as /devices/pci0000:00/0000:00:0a.0/0000:02:00.4/usb7/7-1/7-1:1.1/0003:03F0:7
> 029.0002/input/input8
> [   12.319274] hid-generic 0003:03F0:7029.0002: input,hidraw1: USB HID v1.01 Mouse [HP  Virtual Keyboard ] on usb-0000:02
> :00.4-1/input1
> [   12.878178] Key type encrypted registered
> [   12.878217] ima: No TPM chip found, activating TPM-bypass!
> [   12.878227] Loading compiled-in module X.509 certificates
> [   12.879168] Loaded X.509 cert 'Build time autogenerated kernel key: 67cb6d2492a17d9861a4ac6ba7a04726ea6886bf'
> [   12.879172] ima: Allocated hash algorithm: sha256
> [   12.879231] ima: No architecture policies foun336] evm: Initialising EVM extended attributes:
> [   12.879337] evm: security.selinux
> [   12.879338] evm: security.SMACK64 (disabled)
> [   12.879339] evm: security.SMACK64EXEC (disabled)
> [   12.879340] evm: security.SMACK64TRANSMUTE (disabled)
> [   12.879341] evm: security.SMACK64MMAP (disabled)
> [   12.879341] evm: security.apparmor (disabled)
> [   12.879342] evm: security.ima
> [   12.879343] evm: security.capability
> [   12.879343] evm: HMAC attrs: 0x1
> [   25.534068] Unstable clock detected, switching default tracing clock to "global"
> [   25.534068] If you want to keep using the local clock, then add:
> [   25.534068]   "trace_clock=local"
> [   25.534068] on the kernel command line
> [   25.540306] Freeing unused decrypted memory: 2036K
> [   25.542017] Freeing unused kernel image (initmem) memory: 2572K
> [   25.547986] Write protecting the kernel read-only data: 22528k
> [   25.549734] Freeing unused kernel image (text/rodata gap) memory: 2040K
> [   25.550359] Freeing unused kernel image (rodata/data gap) memory: 1124K
> [   25.598746] x86/mm: Checked W+X mappings: passed, no W+X pages fystemd[1]: RTC configured in localtime, applying delta
>  of -240 minutes to system time.
> 
> Welcome to Red Hat Ente[   25.832599] systemd[1]: systemd 250-6.el9_0 running in system mode (+PAM +AUDIT +SELINUX -APPAR
> MOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETU
> P +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT def
> ault-hierarchy=unified)
> rprise Linux 9.0[   25.833437] systemd[1]: Detected architecture x86-64.
>  (Plow) dracut-0[   25.833443] systemd[1]: Running in initial RAM disk.
> 55-45.git20220404.el9_0 (Initramfs)!
> 
> [   25.840229] systemd[1]: Hostname set to <hp-dl585g7-01.rhts.eng.pek2.redhat.com>.
> [   25.930866] systemd[1]: /usr/lib/systemd/system/kdump-capture.service:23: Standard output type syslog is obsolete, aut
> omatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   25.930879] systemd[1]: /usr/lib/systemd/system/kdump-capture.service:24: Standard output type syslog+console is obsol
> ete, automatically updating to journal+console. Please update your unit file, and co[   25.955161] systemd[1]: Queued sta
> rt job for default target Initrd Default Target.
> [  OK  ] Started Dispatch Pa[   26.597977] random: crng init done
> [   26.598402] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> ssword …ts to Console Directory Watch.
> [  OK  ] Reached target Initrd Root Device.
> [   26.603196] systemd[1]: Reached target Initrd Root Device.
> [  OK  ] Reached target Initrd /usr File System.
> [   26.606252] systemd[1]: Reached target Initrd /usr File System.
> [  OK  ] Reached target Path Units.
> [   26.609235] systemd[1]: Reached target Path Units.
> [  OK  ] Reached target Slice Units.
> [   26.612238] systemd[1]: Reached target Slice Units.
> [  OK  ] Reached target Swaps.
> [   26.615233] systemd[1]: Reached target Swaps.
> [  OK  ] Reached target Timer Units.
> [   26.618234] systemd[1]: Reached target Timer Units.
> [  OK  ] Listening on Journa[   26.621559] systemd[1]: Listening on Journal Socket (/dev/log).
> l Socket (/dev/log).
> [  OK  ] Listening on Journa[   26.626540] syl Socket.
> [  OK  ] Listening on[   26.830628] systemd[1]: Listening on udev Control Socket.
>  udev Control Socket.
> [  OK  ] Listening on udev Kernel Socket[   26.834434] systemd[1]: Listening on udev Kernel Socket.
> .
> [  OK  ] Reached target Socket Units.
> [   26.838219] systemd[1]: Reached target Socket Units.
>          Starting Create List of Static Device Nodes...
>          Starting Journal Service...
> [   26.844679] systemd[1]: Starting Create List of Static Device Nodes...
> [   26.853397] systemd[1]: Starting Journal Service...
>          Starting Load Kernel Modules...
> [   26.864041] systemd[1]: Starting Load Kernel Modules...
>          Starting Setup Virtual Console...
> [   26.874095] systemd[1]: Starting Setup Virtual Console...
> [  OK  ] Finished Create List of Static Device Nodes.
> [   26.889224] systemd[1]: Finished Create List of Static Device Nodes.
>          Starting Create Static Device Nodes in /dev...
> [   26.901140] systemd[1]: Starting Create Static Device Nodes in /dev...
> [  OK  ] Finished Create Static Device Nodes in /dev.
> [   26.939294] fuse: init (API version 7.36)
> [   26.950106] systemd[1]: Finished Create Static Device[   27.041510] systemd[1]: Started Journal Service.
> [  OK  ] Started    27.129605] ipmi device interface
> 1;39mJournal Service.
> [  OK  ] Finished Load Kernel Modules.
> [  OK  ] Finished Setup Virtual Console.
>          Starting dracut ask for additional cmdline parameters...
>          Starting Apply Kernel Variables...
> [  OK  ] Finished Apply Kernel Variables.
> [   20.936907] systemd-modules-load[203]: Inserted module 'fuse'
> [   21.380506] systemd-modules-load[203]: Module 'msr' is built in
> [   21.384853] systemd-modules-load[203]: Inserted module 'ipmi_devintf'
> [   21.389026] systemd[1]: Finished Load Kernel Modules.
> [   21.392558] systemd[1]: Finished Setup Virtual Console.
> [   21.396621] systemd[1]: Starting dracut ask for additional cmdline parameters...
> [   21.400556] systemd[1]: Starting Apply Kernel Variables...
> [   21.404378] systemd[1]: Finished Apply Kernel Variables.
> [  OK  ] Finished dracut ask for additional cmdline parameters.
>          Starting dracut cmdline hook...
> [   21.436166] systemd[1]: Finished dracut ask for additional cmdline parameters.
> [   21.462970] systemd[1]: Starting dracut cmdline hook...
> [   21.470712] dracut-cmdline[222]: dracut-9.0 (Plow) dracut-055-45.git20220404.el9_0
> [   21.477365] dracut-cmdline[222]: Using kernel command line parameters:  rd.lvm.lv=rhel_hp-dl585g7-01/root   elfcorehdr
> =0x9d000000 BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc2+ ro resume=/dev/mapper/rhel_hp--dl585g7--01-swap console=ttyS1,115
> 200n81 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 acpi_no_memhot
> plug transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0 hugetlb_cma=0 tsc=unstable disable_cpu_apicid=32 hp
> wdt.pretimeout=0 hpwdt.kdumptimeout=0
> [   21.884647] systemd[1]: Finished dracut cmdline hook.
> [  OK  ] Finished dracut cmdline hook.
> [   21.893607] systemd[1]: Starting dracut pre-udev hook...
>          Starting dracut pre-udev hook...
> [   27.969514] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorde
> d in the IMA log.
> [   27.969676] device-mapper: uevent: version 1.0.3
> [   27.971937] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
> [   22.032762] systemd[1]: Finished dracut pre-udev hook.
> [  OK  ] Finished dracut pre-udev hook.
> [   22.047584] systemd[1]: Starting Rule-based Manager for Device Events and Files...
>          Starting Rule-based Manage…for Device Events and Files...
> [  OK  ] Started Rule-based Manager for Device Events and Files.
> [   22.129090] systemd[1]: Started Rule-based Manager for Device Events and Files.
> [   22.137325] systemd[1]: dracut pre-trigger hook was skipped because all trigger condition checks failed.
> [   22.141793] systemd[1]: Starting Coldplug All udev Devices...
>          Starting Coldplug All udev Devices...
> [  OK  ] Finished Coldplug All udev Devices.
> [   22.664561] systemd[1]: Finished Coldplug All udev Devices.
> [   22.672091] systemd[1]: Starting dracut initqueue hook...
>          Starting dracut initqueue hook...
> [   28.973365] ACPI: \_SB_.PCI0.I060: Enabled at IRQ 47
> [   28.973515] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: NMI decoding initialized
> [   28.975919] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: Version: 2.0.4
> [   28.975921] hpwdt 0000:02:00.0: timeout: 30 seconds (nowayout=0)
> [   28.975923] hpwdt 0000:02:00.0: pretimeout: off.
> [   28.975925] hpwdt 0000:02:00.0: kdumptimeout: 0.
> [   28.986851] HP HPSA Driver (v 3.4.20-200)
> [   28.987775] ACPI: \_SB_.PCI0.I040: Enabled at IRQ 44
> [   29.091996] ACPI: bus type drm_connector registered
> [   29.252386] [drm] radeon kernel modesetting enabled.
> [   29.252810] radeon 0000:01:03.0: vgaarb: deactivate vga console
> [   29.255050] Console: switching to colour dummy device 80x25
> [   29.255715] ACPI: \_SB_.PCI0.VIDA: Enabled at IRQ 16
> [   29.257387] hpsa 0000:03:00.0: using doorbell to reset controller
> [   29.260654] [drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
> [   29.260659] radeon 0000:01:03.0: vram limit (0) must be a power of 2
> [   29.260919] radeon 0000:01:03.0: VRAM: 128M 0x00000000E0000000 - 0x00000000E7FFFFFF (64M used)
> [   29.260923] radeon 0000:01:03.0: GTT: 512M 0x00000000C0000000 - 0x00000000DFFFFFFF
> [   29.263690] [drm] Detected VRAM RAM=128M, BAR=128M
> [   29.263691] [drm] RAM width 16bits DDR
> [   29.264180] [drm] radeon: 64M of VRAM memory ready
> [   29.264184] [drm] radeon: 512M of GTT memory ready.
> [   29.264233] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   29.285333] [drm] PCI GART of 512M enabled (table at 0x00000000BC300000).
> [   29.291379] radeon 0000:01:03.0: WB disabled
> [   29.291382] radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c0000000
> [   29.294189] [drm] radeon: irq initialized.
> [   29.294215] [drm] Loading R100 Microcode
> [   29.297432] [drm] radeon: ring at 0x00000000C0001000
> [   29.297492] [drm] ring test succeeded in 1 usecs
> [   29.297779] [drm] ib test succeeded in 0 usecs
> [   29.302529] [drm] No TV DAC info found in BIOS
> [   29.304092] [drm] Radeon Display Connectors
> [   29.304093] [drm] Connector 0:
> [   29.304095] [drm]   VGA-1
> [   29.304095] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
> [   29.304098] [drm]   Encoders:
> [   29.304098] [drm]     CRT1: INTERNAL_DAC1
> [   29.304099] [drm] Connector 1:
> [   29.304100] [drm]   VGA-2
> [   29.304100] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
> [   29.304102] [drm]   Encoders:
> [   29.304103] [drm]     CRT2: INTERNAL_DAC2
> [   29.383228] [drm] fb mappable at 0xE0040000
> [   29.383241] [drm] vram apper at 0xE0000000
> [   29.383242] [drm] size 1572864
> [   29.383243] [drm] fb depth is 16
> [   29.383244] [drm]    pitch is 2048
> [   29.386758] fbcon: radeondrmfb (fb0) is primary device
> [   29.538350] Console: switching to colour frame buffer device 128x48
> [   29.581938] radeon 0000:01:03.0: [drm] fb0: radeondrmfb frame buffer device
> [   29.582011] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:03.0 on minor 0
> [14835.604937] watchdog: BUG: soft lockup - CPU#29 stuck for 52s! [kworker/29:2:1868]
> [14835.604938] Modules linked in: qrtr rfkill amd64_edac edac_mce_amd kvm_amd ccp ipmi_ssif joydev kvm irqbypass pcspkr h
> pilo i2c_piix4 k10temp fam15h_power acpi_ipmi ipmi_si acpi_power_meter xfs libcrc32c sd_mod t10_pi crc64_rocksoft_generic
>  crc64_rocksoft crc64 sg radeon i2c_algo_bit drm_ttm_helper ttm drm_display_helper drm_kms_helper syscopyarea sysfillrect
>  crct10dif_pclmul sysimgblt crc32_pclmul fb_sys_fops crc32c_intel ghash_clmulni_intel ata_generic drm ahci serio_raw liba
> hci cec libata hpsa scsi_transport_sas hpwdt netxen_nic dm_mirror dm_region_hash dm_log dm_mod ipmi_devintf ipmi_msghandl
> er fuse
> [14835.604938] irq event stamp: 123768
> [14835.604938] hardirqs last  enabled at (123767): [<ffffffffa6600d0b>] asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [14835.604938] hardirqs last disabled at (123768): [<ffffffffa65a875b>] sysvec_apic_timer_interrupt+0xb/0x90
> [14835.604938] softirqs last  enabled at (123706): [<ffffffffa6800319>] __do_softirq+0x319/0x44a
> [14835.604938] softirqs last disabled at (123701): [<ffffffffa5af574b>] __irq_exit_rcu+0xbb/0xf0
> [14835.604938] CPU: 29 PID: 1868 Comm: kworker/29:2 Kdump: loaded Tainted: G             L    5.19.0-rc2+ #7
> [14835.604938] Hardware name: HP ProLiant DL585 G7, BIOS A16 06/04/2013
> [14835.604938] Workqueue: events __sched_clock_work
> [14835.604938] RIP: 0010:smp_call_function_many_cond+0x138/0x380
> [14835.604938] Code: e8 5d ca 43 00 3b 05 57 a1 a1 01 89 c7 73 30 48 63 c7 48 8b 4d 00 48 03 0c c5 20 ab e3 a6 8b 41 08 a
> 8 01 74 0a f3 90 8b 51 08 <83> e2 01 75 f6 eb cb 49 0f a3 1a 0f 92 44 24 1b e9 3e ff ff ff 48
> [14835.604938] RSP: 0018:ffffb1285c65fd40 EFLAGS: 00000202
> [14835.604938] RAX: 0000000000000011 RBX: 0000000000000001 RCX: ffff96ea7fc3d540
> [14835.604938] RDX: 0000000000000011 RSI: 0000000000000000 RDI: 0000000000000000
> [14835.604938] RBP: ffff974a7fc73a40 R08: 0000000000000000 R09: 0000000000000000
> [14835.604938] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [14835.604938] R13: 0000000000000000 R14: 0000000000000030 R15: ffff974a7fc73a40
> [14835.625041] FS:  0000000000000000(0000) GS:ffff974a7fc40000(0000) knlGS:0000000000000000
> [14835.625041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14835.625041] CR2: 00007f1677256230 CR3: 0000007a0d226000 CR4: 00000000000406e0
> [14835.625041] Call Trace:
> [14835.625041]  <TASK>
> [14835.625041]  ? optimize_nops+0x210/0x210
> [14835.625041]  on_each_cpu_cond_mask+0x20/0x30
> [14835.625041]  text_poke_bp_batch+0xf4/0x370
> [14835.625041]  ? arch_jump_label_transform_apply+0x13/0x30
> [14835.625041]  text_poke_finish+0x1b/0x30
> [14835.625041]  arch_jump_label_transform_apply+0x18/0x30
> [14835.625041]  static_key_disable_cpuslocked+0x5b/0x90
> [14835.625041]  static_key_disable+0x16/0x20
> [14835.625041]  process_one_work+0x274/0x590
> [14835.625041]  ? process_one_work+0x590/0x590worker_thread+0x52/0x3a0
> [14835.713164]  ? process_one_work+0x590/0x590
> [14835.713164]  kthread+0xd8/0x100
> [14835.713164]  ? kthread_complete_and_exit+0x20/0x20
> [14835.713164]  ret_from_fork+0x22/0x30
> [14835.713164]  </TASK>
> [14863.604936] watchdog: BUG: soft lockup - CPU#29 stuck for 78s! [kworker/29:2:1868]
> [14863.604936] Modules linked in: qrtr rfkill amd64_edac edac_mce_amd kvm_amd ccp ipmi_ssif joydev kvm irqbypass pcspkr h
> pilo i2c_piix4 k10temp fam15h_power acpi_ipmi ipmi_si acpi_power_meter xfs libcrc32c sd_mod t10_pi crc64_rocksoft_generic
>  crc64_rocksoft crc64 sg radeon i2c_algo_bit drm_ttm_helper ttm drm_display_helper drm_kms_helper syscopyarea sysfillrect
>  crct10dif_pclmul sysimgblt crc32_pclmul fb_sys_fops crc32c_intel ghash_clmulni_intel ata_generic drm ahci serio_raw liba
> hci cec libata hpsa scsi_transport_sas hpwdt netxen_nic dm_mirror dm_region_hash dm_log dm_mod ipmi_devintf ipmi_msghandl
> er fuse
> [14863.604936] irq event stamp: 183280
> [14863.604936] hardirqs last  enabled at (183279): [<ffffffffa6600d0b>] asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [14863.604936] hardirqs last disabled at (183280): [<ffffffffa65a875b>] sysvec_apic_timer_interrupt+0xb/0x90
> [14863.604936] softirqs last  enabled at (183272): [<ffffffffa6800319>] __do_softirq+0x319/0x44a
> [14863.604936] softirqs last disabled at (183267): [<ffffffffa5af574b>] __irq_exit_rcu+0xbb/0xf0
> [14863.604936] CPU: 29 PID: 1868 Comm: kworker/29:2 Kdump: loaded Tainted: G             L    5.19.0-rc2+ #7
> [14863.604936] Hardware name: HP ProLiant DL585 G7, BIOS A16 06/04/2013
> [14863.604936] Workqueue: events __sched_clock_work
> [14863.604936] RIP: 0010:smp_call_function_many_cond+0x135/0x380
> [14863.604936] Code: 8b 75 08 e8 5d ca 43 00 3b 05 57 a1 a1 01 89 c7 73 30 48 63 c7 48 8b 4d 00 48 03 0c c5 20 ab e3 a6 8
> b 41 08 a8 01 74 0a f3 90 <8b> 51 08 83 e2 01 75 f6 eb cb 49 0f a3 1a 0f 92 44 24 1b e9 3e ff
> [14863.604936] RSP: 0018:ffffb1285c65fd40 EFLAGS: 00000202
> [14863.604936] RAX: 0000000000000011 RBX: 0000000000000001 RCX: ffff96ea7fc3d540
> [14863.604936] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> [14863.604936] RBP: ffff974a7fc73a40 R08: 0000000000000000 R09: 0000000000000000
> [14863.604936] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [14863.625034] R13: 0000000000000000 R14: 0000000000000030 R15: ffff974a7fc73a40
> [14863.625034] FS:  0000000000000000(0000) GS:ffff974a7fc40000(0000) knlGS:0000000000000000
> [14863.625034] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14863.625034] CR2: 00007f1677256230 CR3: 0000007a0d226000 CR4: 00000000000406e0
> [14863.625034] Call Trace:
> [14863.625034]  <TASK>
> [14863.625034]  ? optimize_nops+0x210/0x210
> [14863.625034]  on_each_cpu_cond_mask+0x20/0x30
> [14863.625034]  text_poke_bp_batch+0xf4/0x370
> [14863.625034]  ? arch_jump_label_transform_apply+0x13/0x30
> [14863.625034]  text_poke_finish+0x1b/0x30
> [14863.625034]  arch_jump_label_transform_apply+0x18/0x30
> [14863.625034]  static_key_disable_cpuslocked+0x5b/0x90
> [14863.625034]  static_key_di[14863.685142]  process_one_work+0x274/0x590
> [14863.685142]  ? process_one_work+0x590/0x590
> [14863.685142]  worker_thread+0x52/0x3a0
> [14863.685142]  ? process_one_work+0x590/0x590
> [14863.685142]  kthread+0xd8/0x100
> [14863.685142]  ? kthread_complete_and_exit+0x20/0x20
> [14863.685142]  ret_from_fork+0x22/0x30
> [14863.685142]  </TASK>
> [14869.169221] hpsa 0000:03:00.0: lockup detected after 30 but scratchpad register is zero
> [14869.170036] hpsa 0000:03:00.0: Controller lockup detected: 0xffffffff after 30
> [14869.171504] hpsa 0000:03:00.0: failed 3 commands in fail_all

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 5.12.0 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9)"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=110201
> CONFIG_CLANG_VERSION=0
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23502
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_UAPI_HEADER_TEST=y
> CONFIG_LOCALVERSION=""
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_BUILD_SALT="5.14.0-70.14.1.el9_0.x86_64"
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> CONFIG_WATCH_QUEUE=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_IRQ_MSI_IOMMU=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> CONFIG_CONTEXT_TRACKING=y
> # CONFIG_CONTEXT_TRACKING_FORCE is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_SCHED_AVG_IRQ=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> CONFIG_PSI=y
> CONFIG_PSI_DEFAULT_DISABLED=y
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_NOCB_CPU=y
> # end of RCU Subsystem
> 
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=m
> # CONFIG_IKCONFIG_PROC is not set
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NUMA_BALANCING=y
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_SWAP=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_BPF=y
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> CONFIG_IPC_NS=y
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> CONFIG_BOOT_CONFIG=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_BPF_LSM=y
> CONFIG_BPF_SYSCALL=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> CONFIG_BPF_JIT_ALWAYS_ON=y
> CONFIG_BPF_JIT_DEFAULT_ON=y
> # CONFIG_BPF_PRELOAD is not set
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_SLAB_FREELIST_HARDENED=y
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ZONE_DMA32=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_HAVE_INTEL_TXT=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_DYNAMIC_PHYSICAL_MASK=y
> CONFIG_PGTABLE_LEVELS=5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_ZONE_DMA=y
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_X2APIC=y
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=y
> CONFIG_X86_CPU_RESCTRL=y
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=y
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=y
> CONFIG_X86_AMD_PLATFORM_DEVICE=y
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=y
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_XEN=y
> # CONFIG_XEN_PV is not set
> CONFIG_XEN_PVHVM=y
> CONFIG_XEN_PVHVM_SMP=y
> CONFIG_XEN_PVHVM_GUEST=y
> CONFIG_XEN_SAVE_RESTORE=y
> # CONFIG_XEN_DEBUG_FS is not set
> # CONFIG_XEN_PVH is not set
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> CONFIG_PVH=y
> CONFIG_PARAVIRT_TIME_ACCOUNTING=y
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> # CONFIG_GART_IOMMU is not set
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCELOG_LEGACY=y
> CONFIG_X86_MCE_INTEL=y
> CONFIG_X86_MCE_AMD=y
> CONFIG_X86_MCE_THRESHOLD=y
> # CONFIG_X86_MCE_INJECT is not set
> 
> #
> # Performance monitoring
> #
> # CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
> # CONFIG_PERF_EVENTS_INTEL_RAPL is not set
> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # end of Performance monitoring
> 
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_X86_IOPL_IOPERM=y
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> # CONFIG_MICROCODE_OLD_INTERFACE is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_5LEVEL=y
> CONFIG_X86_DIRECT_GBPAGES=y
> CONFIG_X86_CPA_STATISTICS=y
> CONFIG_AMD_MEM_ENCRYPT=y
> # CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
> CONFIG_NUMA=y
> CONFIG_AMD_NUMA=y
> CONFIG_X86_64_ACPI_NUMA=y
> CONFIG_NUMA_EMU=y
> CONFIG_NODES_SHIFT=10
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> # CONFIG_X86_PMEM_LEGACY is not set
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_X86_SGX=y
> CONFIG_EFI=y
> CONFIG_EFI_STUB=y
> CONFIG_EFI_MIXED=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> CONFIG_KEXEC_SIG=y
> # CONFIG_KEXEC_SIG_FORCE is not set
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_CRASH_DUMP=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> CONFIG_HOTPLUG_CPU=y
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_LEGACY_VSYSCALL_EMULATE is not set
> CONFIG_LEGACY_VSYSCALL_XONLY=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_LIVEPATCH=y
> # end of Processor type and features
> 
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_HIBERNATION_SNAPSHOT_DEV=y
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_ENERGY_MODEL=y
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> # CONFIG_ACPI_VIDEO is not set
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_IPMI=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> # CONFIG_ACPI_SBS is not set
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> CONFIG_ACPI_BGRT=y
> # CONFIG_ACPI_NFIT is not set
> CONFIG_ACPI_NUMA=y
> CONFIG_ACPI_HMAT=y
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> CONFIG_ACPI_APEI_PCIEAER=y
> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> # CONFIG_ACPI_APEI_EINJ is not set
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> CONFIG_ACPI_DPTF=y
> # CONFIG_DPTF_POWER is not set
> # CONFIG_DPTF_PCH_FIVR is not set
> # CONFIG_ACPI_EXTLOG is not set
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_PMIC_OPREGION=y
> CONFIG_X86_PM_TIMER=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> # CONFIG_X86_PCC_CPUFREQ is not set
> # CONFIG_X86_ACPI_CPUFREQ is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
> 
> #
> # shared options
> #
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> CONFIG_CPU_IDLE_GOV_HALTPOLL=y
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_XEN=y
> CONFIG_MMCONF_FAM10H=y
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> # CONFIG_X86_SYSFB is not set
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=y
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_SYSVIPC_COMPAT=y
> # end of Binary Emulations
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> CONFIG_DMI_SYSFS=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_ISCSI_IBFT is not set
> CONFIG_FW_CFG_SYSFS=y
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=y
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_VARS_PSTORE=y
> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
> CONFIG_EFI_RUNTIME_MAP=y
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_SOFT_RESERVE=y
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> CONFIG_APPLE_PROPERTIES=y
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> CONFIG_EFI_RCI2_TABLE=y
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
> 
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> CONFIG_EFI_DEV_PATH_PARSER=y
> CONFIG_EFI_EARLYCON=y
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_HAVE_KVM_NO_POLL=y
> CONFIG_KVM_XFER_TO_GUEST_WORK=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=m
> # CONFIG_KVM_INTEL is not set
> CONFIG_KVM_AMD=m
> CONFIG_KVM_AMD_SEV=y
> # CONFIG_KVM_XEN is not set
> # CONFIG_KVM_MMU_AUDIT is not set
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_GENERIC_ENTRY=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=y
> CONFIG_KPROBES_ON_FTRACE=y
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_STATIC_CALL_INLINE=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_MODVERSIONS=y
> CONFIG_ASM_MODVERSIONS=y
> CONFIG_MODULE_SRCVERSION_ALL=y
> CONFIG_MODULE_SIG=y
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=y
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> # CONFIG_MODULE_SIG_SHA256 is not set
> # CONFIG_MODULE_SIG_SHA384 is not set
> CONFIG_MODULE_SIG_SHA512=y
> CONFIG_MODULE_SIG_HASH="sha512"
> # CONFIG_MODULE_COMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_CGROUP_RWSTAT=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=m
> CONFIG_BLK_DEV_ZONED=y
> CONFIG_BLK_DEV_THROTTLING=y
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> # CONFIG_BLK_CMDLINE_PARSER is not set
> CONFIG_BLK_WBT=y
> CONFIG_BLK_CGROUP_IOLATENCY=y
> # CONFIG_BLK_CGROUP_IOCOST is not set
> CONFIG_BLK_WBT_MQ=y
> CONFIG_BLK_DEBUG_FS=y
> CONFIG_BLK_DEBUG_FS_ZONED=y
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> CONFIG_OSF_PARTITION=y
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=y
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=y
> # CONFIG_KARMA_PARTITION is not set
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> # end of Partition Types
> 
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=y
> CONFIG_BFQ_GROUP_IOSCHED=y
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
> 
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> # CONFIG_BINFMT_MISC is not set
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_NEED_MULTIPLE_NODES=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_NUMA_KEEP_MEMINFO=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG_SPARSE=y
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_MEMORY_FAILURE=y
> # CONFIG_HWPOISON_INJECT is not set
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> # CONFIG_CLEANCACHE is not set
> CONFIG_FRONTSWAP=y
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> # CONFIG_CMA_DEBUGFS is not set
> CONFIG_CMA_AREAS=7
> CONFIG_MEM_SOFT_DIRTY=y
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> # CONFIG_Z3FOLD is not set
> CONFIG_ZSMALLOC=y
> CONFIG_ZSMALLOC_STAT=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_PTE_DEVMAP=y
> CONFIG_ZONE_DEVICE=y
> CONFIG_DEV_PAGEMAP_OPS=y
> CONFIG_DEVICE_PRIVATE=y
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> CONFIG_PERCPU_STATS=y
> # CONFIG_GUP_TEST is not set
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_SKB_EXTENSIONS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_DIAG=y
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_UNIX_DIAG=y
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_USER=y
> # CONFIG_XFRM_USER_COMPAT is not set
> # CONFIG_XFRM_INTERFACE is not set
> CONFIG_XFRM_SUB_POLICY=y
> CONFIG_XFRM_MIGRATE=y
> CONFIG_XFRM_STATISTICS=y
> # CONFIG_NET_KEY is not set
> CONFIG_XDP_SOCKETS=y
> # CONFIG_XDP_SOCKETS_DIAG is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_FIB_TRIE_STATS=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> CONFIG_INET_UDP_DIAG=y
> CONFIG_INET_RAW_DIAG=y
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=y
> # CONFIG_TCP_CONG_BIC is not set
> CONFIG_TCP_CONG_CUBIC=y
> # CONFIG_TCP_CONG_WESTWOOD is not set
> # CONFIG_TCP_CONG_HTCP is not set
> # CONFIG_TCP_CONG_HSTCP is not set
> # CONFIG_TCP_CONG_HYBLA is not set
> # CONFIG_TCP_CONG_VEGAS is not set
> # CONFIG_TCP_CONG_NV is not set
> # CONFIG_TCP_CONG_SCALABLE is not set
> # CONFIG_TCP_CONG_LP is not set
> # CONFIG_TCP_CONG_VENO is not set
> # CONFIG_TCP_CONG_YEAH is not set
> # CONFIG_TCP_CONG_ILLINOIS is not set
> # CONFIG_TCP_CONG_DCTCP is not set
> # CONFIG_TCP_CONG_CDG is not set
> # CONFIG_TCP_CONG_BBR is not set
> CONFIG_DEFAULT_CUBIC=y
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG="cubic"
> CONFIG_TCP_MD5SIG=y
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_PREF=y
> CONFIG_IPV6_ROUTE_INFO=y
> CONFIG_IPV6_OPTIMISTIC_DAD=y
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_ILA is not set
> # CONFIG_IPV6_VTI is not set
> # CONFIG_IPV6_SIT is not set
> # CONFIG_IPV6_TUNNEL is not set
> CONFIG_IPV6_MULTIPLE_TABLES=y
> # CONFIG_IPV6_SUBTREES is not set
> CONFIG_IPV6_MROUTE=y
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IPV6_PIMSM_V2=y
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> CONFIG_NETLABEL=y
> CONFIG_MPTCP=y
> CONFIG_INET_MPTCP_DIAG=y
> CONFIG_MPTCP_IPV6=y
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> # CONFIG_NETFILTER_NETLINK_QUEUE is not set
> # CONFIG_NETFILTER_NETLINK_LOG is not set
> # CONFIG_NETFILTER_NETLINK_OSF is not set
> # CONFIG_NF_CONNTRACK is not set
> # CONFIG_NF_LOG_NETDEV is not set
> # CONFIG_NF_TABLES is not set
> CONFIG_NETFILTER_XTABLES=y
> 
> #
> # Xtables combined modules
> #
> # CONFIG_NETFILTER_XT_MARK is not set
> 
> #
> # Xtables targets
> #
> # CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
> # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
> # CONFIG_NETFILTER_XT_TARGET_HMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> # CONFIG_NETFILTER_XT_TARGET_LOG is not set
> # CONFIG_NETFILTER_XT_TARGET_MARK is not set
> # CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
> # CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
> # CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
> # CONFIG_NETFILTER_XT_TARGET_TEE is not set
> # CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
> 
> #
> # Xtables matches
> #
> # CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
> # CONFIG_NETFILTER_XT_MATCH_BPF is not set
> # CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
> # CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
> # CONFIG_NETFILTER_XT_MATCH_CPU is not set
> # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
> # CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
> # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
> # CONFIG_NETFILTER_XT_MATCH_ECN is not set
> # CONFIG_NETFILTER_XT_MATCH_ESP is not set
> # CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_HL is not set
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> # CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
> # CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_MAC is not set
> # CONFIG_NETFILTER_XT_MATCH_MARK is not set
> # CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> # CONFIG_NETFILTER_XT_MATCH_OSF is not set
> # CONFIG_NETFILTER_XT_MATCH_OWNER is not set
> # CONFIG_NETFILTER_XT_MATCH_POLICY is not set
> # CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
> # CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
> # CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
> # CONFIG_NETFILTER_XT_MATCH_REALM is not set
> # CONFIG_NETFILTER_XT_MATCH_RECENT is not set
> # CONFIG_NETFILTER_XT_MATCH_SCTP is not set
> # CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
> # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
> # CONFIG_NETFILTER_XT_MATCH_STRING is not set
> # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
> 
> # CONFIG_IP_SET is not set
> # CONFIG_IP_VS is not set
> 
> #
> # IP: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV4 is not set
> # CONFIG_NF_TPROXY_IPV4 is not set
> # CONFIG_NF_DUP_IPV4 is not set
> # CONFIG_NF_LOG_ARP is not set
> # CONFIG_NF_LOG_IPV4 is not set
> # CONFIG_NF_REJECT_IPV4 is not set
> # CONFIG_IP_NF_IPTABLES is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV6 is not set
> # CONFIG_NF_TPROXY_IPV6 is not set
> # CONFIG_NF_DUP_IPV6 is not set
> # CONFIG_NF_REJECT_IPV6 is not set
> # CONFIG_NF_LOG_IPV6 is not set
> # CONFIG_IP6_NF_IPTABLES is not set
> # end of IPv6: Netfilter Configuration
> 
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> # CONFIG_NET_SCH_CBQ is not set
> # CONFIG_NET_SCH_HTB is not set
> # CONFIG_NET_SCH_HFSC is not set
> # CONFIG_NET_SCH_PRIO is not set
> # CONFIG_NET_SCH_MULTIQ is not set
> # CONFIG_NET_SCH_RED is not set
> # CONFIG_NET_SCH_SFB is not set
> # CONFIG_NET_SCH_SFQ is not set
> # CONFIG_NET_SCH_TEQL is not set
> # CONFIG_NET_SCH_TBF is not set
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> # CONFIG_NET_SCH_TAPRIO is not set
> # CONFIG_NET_SCH_GRED is not set
> # CONFIG_NET_SCH_DSMARK is not set
> # CONFIG_NET_SCH_NETEM is not set
> # CONFIG_NET_SCH_DRR is not set
> # CONFIG_NET_SCH_MQPRIO is not set
> # CONFIG_NET_SCH_SKBPRIO is not set
> # CONFIG_NET_SCH_CHOKE is not set
> # CONFIG_NET_SCH_QFQ is not set
> # CONFIG_NET_SCH_CODEL is not set
> CONFIG_NET_SCH_FQ_CODEL=y
> # CONFIG_NET_SCH_CAKE is not set
> # CONFIG_NET_SCH_FQ is not set
> # CONFIG_NET_SCH_HHF is not set
> # CONFIG_NET_SCH_PIE is not set
> # CONFIG_NET_SCH_INGRESS is not set
> # CONFIG_NET_SCH_PLUG is not set
> # CONFIG_NET_SCH_ETS is not set
> CONFIG_NET_SCH_DEFAULT=y
> CONFIG_DEFAULT_FQ_CODEL=y
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH="fq_codel"
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> # CONFIG_NET_CLS_BASIC is not set
> # CONFIG_NET_CLS_TCINDEX is not set
> # CONFIG_NET_CLS_ROUTE4 is not set
> # CONFIG_NET_CLS_FW is not set
> # CONFIG_NET_CLS_U32 is not set
> # CONFIG_NET_CLS_RSVP is not set
> # CONFIG_NET_CLS_RSVP6 is not set
> # CONFIG_NET_CLS_FLOW is not set
> CONFIG_NET_CLS_CGROUP=y
> # CONFIG_NET_CLS_BPF is not set
> # CONFIG_NET_CLS_FLOWER is not set
> # CONFIG_NET_CLS_MATCHALL is not set
> # CONFIG_NET_EMATCH is not set
> CONFIG_NET_CLS_ACT=y
> # CONFIG_NET_ACT_POLICE is not set
> # CONFIG_NET_ACT_GACT is not set
> # CONFIG_NET_ACT_MIRRED is not set
> # CONFIG_NET_ACT_SAMPLE is not set
> # CONFIG_NET_ACT_IPT is not set
> # CONFIG_NET_ACT_NAT is not set
> # CONFIG_NET_ACT_PEDIT is not set
> # CONFIG_NET_ACT_SIMP is not set
> # CONFIG_NET_ACT_SKBEDIT is not set
> # CONFIG_NET_ACT_CSUM is not set
> # CONFIG_NET_ACT_MPLS is not set
> # CONFIG_NET_ACT_VLAN is not set
> # CONFIG_NET_ACT_BPF is not set
> # CONFIG_NET_ACT_SKBMOD is not set
> # CONFIG_NET_ACT_IFE is not set
> # CONFIG_NET_ACT_TUNNEL_KEY is not set
> # CONFIG_NET_ACT_GATE is not set
> CONFIG_NET_TC_SKB_EXT=y
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> # CONFIG_DNS_RESOLVER is not set
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> CONFIG_NETLINK_DIAG=y
> CONFIG_MPLS=y
> CONFIG_NET_MPLS_GSO=y
> # CONFIG_MPLS_ROUTING is not set
> CONFIG_NET_NSH=y
> # CONFIG_HSR is not set
> CONFIG_NET_SWITCHDEV=y
> CONFIG_NET_L3_MASTER_DEV=y
> CONFIG_QRTR=m
> # CONFIG_QRTR_TUN is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> CONFIG_CGROUP_NET_PRIO=y
> CONFIG_CGROUP_NET_CLASSID=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_JIT=y
> CONFIG_BPF_STREAM_PARSER=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NET_DROP_MONITOR=y
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=y
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> CONFIG_RFKILL=m
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> # CONFIG_RFKILL_GPIO is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=y
> CONFIG_LWTUNNEL_BPF=y
> CONFIG_GRO_CELLS=y
> CONFIG_NET_SOCK_MSG=y
> # CONFIG_FAILOVER is not set
> CONFIG_ETHTOOL_NETLINK=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> # CONFIG_PCIEAER_INJECT is not set
> CONFIG_PCIE_ECRC=y
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> # CONFIG_PCIE_PTM is not set
> CONFIG_PCIE_EDR=y
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=y
> # CONFIG_PCI_PF_STUB is not set
> CONFIG_XEN_PCIDEV_FRONTEND=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PRI=y
> CONFIG_PCI_PASID=y
> CONFIG_PCI_P2PDMA=y
> CONFIG_PCI_LABEL=y
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> CONFIG_HOTPLUG_PCI_SHPC=y
> 
> #
> # PCI controller drivers
> #
> CONFIG_VMD=y
> 
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> CONFIG_CXL_BUS=y
> # CONFIG_CXL_MEM is not set
> CONFIG_PCCARD=y
> # CONFIG_PCMCIA is not set
> # CONFIG_CARDBUS is not set
> 
> #
> # PC-card bridges
> #
> # CONFIG_YENTA is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_FW_LOADER_COMPRESS=y
> # CONFIG_FW_CACHE is not set
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_HMEM_REPORTING=y
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_XEN_BLKDEV_FRONTEND is not set
> # CONFIG_VIRTIO_BLK is not set
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> # CONFIG_BLK_DEV_NVME is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TARGET is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_SGI_XP is not set
> CONFIG_HP_ILO=m
> # CONFIG_SGI_GRU is not set
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> # CONFIG_ISL29020 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_PVPANIC=y
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> # CONFIG_EEPROM_LEGACY is not set
> # CONFIG_EEPROM_MAX6875 is not set
> # CONFIG_EEPROM_93CX6 is not set
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> # CONFIG_CB710_CORE is not set
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> # CONFIG_ALTERA_STAPL is not set
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_UACCE is not set
> # end of Misc devices
> 
> CONFIG_HAVE_IDE=y
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=m
> # CONFIG_CHR_DEV_SCH is not set
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> CONFIG_SCSI_SAS_ATTRS=m
> # CONFIG_SCSI_SAS_LIBSAS is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> # end of SCSI Transports
> 
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> CONFIG_SCSI_HPSA=m
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_MPT3SAS is not set
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> # CONFIG_XEN_SCSI_FRONTEND is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> # CONFIG_SCSI_ISCI is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_VIRTIO is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=y
> CONFIG_SCSI_DH_HP_SW=y
> CONFIG_SCSI_DH_EMC=y
> CONFIG_SCSI_DH_ALUA=y
> # end of SCSI device support
> 
> CONFIG_ATA=m
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_SATA_AHCI_PLATFORM=m
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> # CONFIG_ATA_PIIX is not set
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
> 
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_RZ1000 is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=m
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID10 is not set
> # CONFIG_MD_RAID456 is not set
> # CONFIG_MD_MULTIPATH is not set
> # CONFIG_MD_FAULTY is not set
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=m
> CONFIG_DM_DEBUG=y
> # CONFIG_DM_UNSTRIPED is not set
> # CONFIG_DM_CRYPT is not set
> # CONFIG_DM_SNAPSHOT is not set
> # CONFIG_DM_THIN_PROVISIONING is not set
> # CONFIG_DM_CACHE is not set
> # CONFIG_DM_WRITECACHE is not set
> # CONFIG_DM_EBS is not set
> # CONFIG_DM_ERA is not set
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=m
> # CONFIG_DM_LOG_USERSPACE is not set
> # CONFIG_DM_RAID is not set
> # CONFIG_DM_ZERO is not set
> # CONFIG_DM_MULTIPATH is not set
> # CONFIG_DM_DELAY is not set
> # CONFIG_DM_DUST is not set
> CONFIG_DM_UEVENT=y
> # CONFIG_DM_FLAKEY is not set
> # CONFIG_DM_VERITY is not set
> # CONFIG_DM_SWITCH is not set
> # CONFIG_DM_LOG_WRITES is not set
> # CONFIG_DM_INTEGRITY is not set
> # CONFIG_DM_ZONED is not set
> # CONFIG_TARGET_CORE is not set
> CONFIG_FUSION=y
> # CONFIG_FUSION_SPI is not set
> # CONFIG_FUSION_SAS is not set
> CONFIG_FUSION_MAX_SGE=128
> CONFIG_FUSION_LOGGING=y
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_NET_FC=y
> # CONFIG_IFB is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_VIRTIO_NET is not set
> # CONFIG_NLMON is not set
> # CONFIG_NET_VRF is not set
> # CONFIG_ARCNET is not set
> 
> #
> # Distributed Switch Architecture drivers
> #
> # CONFIG_NET_DSA_MV88E6XXX_PTP is not set
> # end of Distributed Switch Architecture drivers
> 
> CONFIG_ETHERNET=y
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_VENDOR_ADAPTEC is not set
> # CONFIG_NET_VENDOR_AGERE is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> # CONFIG_NET_VENDOR_ALTEON is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> # CONFIG_NET_VENDOR_CADENCE is not set
> # CONFIG_NET_VENDOR_CAVIUM is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> # CONFIG_NET_VENDOR_CORTINA is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> # CONFIG_NET_VENDOR_EZCHIP is not set
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> # CONFIG_NET_VENDOR_I825XX is not set
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> # CONFIG_E1000 is not set
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_IXGBEVF is not set
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> # CONFIG_IGC is not set
> # CONFIG_JME is not set
> # CONFIG_NET_VENDOR_MARVELL is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> # CONFIG_NET_VENDOR_NETERION is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> # CONFIG_NET_VENDOR_NI is not set
> # CONFIG_NET_VENDOR_NVIDIA is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> # CONFIG_NET_VENDOR_PACKET_ENGINES is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> CONFIG_NETXEN_NIC=m
> # CONFIG_QED is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RDC is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> CONFIG_NET_VENDOR_ROCKER=y
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> # CONFIG_NET_VENDOR_SIS is not set
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> # CONFIG_NET_VENDOR_SUN is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_TEHUTI is not set
> # CONFIG_NET_VENDOR_TI is not set
> # CONFIG_NET_VENDOR_VIA is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> # CONFIG_NET_VENDOR_XILINX is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> CONFIG_LED_TRIGGER_PHY=y
> CONFIG_FIXED_PHY=y
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_ADIN_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> # CONFIG_AX88796B_PHY is not set
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_BCM54140_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM84881_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_REALTEK_PHY is not set
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_MDIO_DEVRES=y
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> # CONFIG_MDIO_THUNDER is not set
> 
> #
> # MDIO Multiplexers
> #
> 
> #
> # PCS device drivers
> #
> # CONFIG_PCS_XPCS is not set
> # end of PCS device drivers
> 
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=y
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_RTL8152 is not set
> # CONFIG_USB_LAN78XX is not set
> # CONFIG_USB_USBNET is not set
> # CONFIG_USB_HSO is not set
> # CONFIG_USB_IPHETH is not set
> CONFIG_WLAN=y
> # CONFIG_WLAN_VENDOR_ADMTEK is not set
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> # CONFIG_WLAN_VENDOR_ATMEL is not set
> CONFIG_WLAN_VENDOR_BROADCOM=y
> # CONFIG_WLAN_VENDOR_CISCO is not set
> CONFIG_WLAN_VENDOR_INTEL=y
> # CONFIG_WLAN_VENDOR_INTERSIL is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> # CONFIG_WLAN_VENDOR_RSI is not set
> # CONFIG_WLAN_VENDOR_ST is not set
> # CONFIG_WLAN_VENDOR_TI is not set
> # CONFIG_WLAN_VENDOR_ZYDAS is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> CONFIG_WAN=y
> # CONFIG_HDLC is not set
> # CONFIG_SBNI is not set
> # CONFIG_XEN_NETDEV_FRONTEND is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_USB4_NET is not set
> # CONFIG_NETDEVSIM is not set
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> # CONFIG_NVM is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_SPARSEKMAP is not set
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> CONFIG_MOUSE_PS2_ELANTECH=y
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> CONFIG_MOUSE_PS2_SENTELIC=y
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> CONFIG_MOUSE_PS2_VMMOUSE=y
> CONFIG_MOUSE_PS2_SMBUS=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> CONFIG_INPUT_TABLET=y
> # CONFIG_TABLET_USB_ACECAD is not set
> # CONFIG_TABLET_USB_AIPTEK is not set
> # CONFIG_TABLET_USB_HANWANG is not set
> # CONFIG_TABLET_USB_KBTAB is not set
> # CONFIG_TABLET_USB_PEGASUS is not set
> # CONFIG_TABLET_SERIAL_WACOM4 is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_PROPERTIES=y
> # CONFIG_TOUCHSCREEN_ADS7846 is not set
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> # CONFIG_TOUCHSCREEN_BU21029 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> # CONFIG_TOUCHSCREEN_EXC3000 is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> # CONFIG_TOUCHSCREEN_HIDEEP is not set
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_S6SY761 is not set
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> # CONFIG_TOUCHSCREEN_ELAN is not set
> # CONFIG_TOUCHSCREEN_ELO is not set
> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> # CONFIG_TOUCHSCREEN_MCS5000 is not set
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> # CONFIG_TOUCHSCREEN_MK712 is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> # CONFIG_TOUCHSCREEN_TSC2005 is not set
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> # CONFIG_TOUCHSCREEN_SX8654 is not set
> # CONFIG_TOUCHSCREEN_TPS6507X is not set
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> # CONFIG_TOUCHSCREEN_ZINITIX is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_PCSPKR=m
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_APANEL is not set
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> # CONFIG_INPUT_ATLAS_BTNS is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> # CONFIG_INPUT_UINPUT is not set
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_PWM_BEEPER is not set
> # CONFIG_INPUT_PWM_VIBRA is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_IQS269A is not set
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=m
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=64
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_KGDB_NMI is not set
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_CONSOLE_POLL=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_ROCKETPORT is not set
> # CONFIG_CYCLADES is not set
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> # CONFIG_SYNCLINK_GT is not set
> # CONFIG_ISI is not set
> # CONFIG_N_HDLC is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_TRACE_SINK is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_IRQ=y
> CONFIG_HVC_XEN=y
> CONFIG_HVC_XEN_FRONTEND=y
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_VIRTIO_CONSOLE is not set
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_SI=m
> CONFIG_IPMI_SSIF=m
> # CONFIG_IPMI_WATCHDOG is not set
> # CONFIG_IPMI_POWEROFF is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> # CONFIG_HW_RANDOM_INTEL is not set
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_BA431 is not set
> # CONFIG_HW_RANDOM_VIA is not set
> CONFIG_HW_RANDOM_VIRTIO=y
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=y
> # CONFIG_DEVKMEM is not set
> CONFIG_NVRAM=y
> # CONFIG_RAW_DRIVER is not set
> CONFIG_DEVPORT=y
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> # CONFIG_HPET_MMAP_DEFAULT is not set
> # CONFIG_HANGCHECK_TIMER is not set
> # CONFIG_UV_MMTIMER is not set
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> # CONFIG_TCG_NSC is not set
> # CONFIG_TCG_ATMEL is not set
> # CONFIG_TCG_INFINEON is not set
> # CONFIG_TCG_XEN is not set
> CONFIG_TCG_CRB=y
> # CONFIG_TCG_VTPM_PROXY is not set
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> # CONFIG_TELCLOCK is not set
> # CONFIG_XILLYBUS is not set
> # end of Character devices
> 
> CONFIG_RANDOM_TRUST_CPU=y
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> # CONFIG_I2C_CHARDEV is not set
> # CONFIG_I2C_MUX is not set
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_ALGOBIT=m
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> CONFIG_I2C_PIIX4=m
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PCA_PLATFORM is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> # end of I2C Hardware Bus support
> 
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> # CONFIG_SPI_MEM is not set
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_NXP_FLEXSPI is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_ROCKCHIP is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> CONFIG_SPI_AMD=y
> 
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=y
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> # CONFIG_DP83640_PHY is not set
> # CONFIG_PTP_1588_CLOCK_INES is not set
> # CONFIG_PTP_1588_CLOCK_KVM is not set
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # CONFIG_PTP_1588_CLOCK_OCP is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> CONFIG_PINCTRL_AMD=y
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
> CONFIG_PINCTRL_BAYTRAIL=y
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=y
> # CONFIG_PINCTRL_ALDERLAKE is not set
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LAKEFIELD is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> # CONFIG_PINCTRL_TIGERLAKE is not set
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_CDEV=y
> # CONFIG_GPIO_CDEV_V1 is not set
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_ICH is not set
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> # end of Virtual GPIO drivers
> 
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_BD99954 is not set
> CONFIG_HWMON=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> # CONFIG_SENSORS_ABITUGURU3 is not set
> # CONFIG_SENSORS_AD7314 is not set
> # CONFIG_SENSORS_AD7414 is not set
> # CONFIG_SENSORS_AD7418 is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM1177 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> # CONFIG_SENSORS_ADT7462 is not set
> # CONFIG_SENSORS_ADT7470 is not set
> # CONFIG_SENSORS_ADT7475 is not set
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AS370 is not set
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> # CONFIG_SENSORS_K8TEMP is not set
> CONFIG_SENSORS_K10TEMP=m
> CONFIG_SENSORS_FAM15H_POWER=m
> # CONFIG_SENSORS_AMD_ENERGY is not set
> # CONFIG_SENSORS_APPLESMC is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ASPEED is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> # CONFIG_SENSORS_DS620 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_DELL_SMM is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_FSCHMD is not set
> # CONFIG_SENSORS_FTSTEUTATES is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> # CONFIG_SENSORS_IBMAEM is not set
> # CONFIG_SENSORS_IBMPEX is not set
> # CONFIG_SENSORS_I5500 is not set
> # CONFIG_SENSORS_CORETEMP is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_JC42 is not set
> # CONFIG_SENSORS_POWR1220 is not set
> # CONFIG_SENSORS_LINEAGE is not set
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> # CONFIG_SENSORS_LTC4260 is not set
> # CONFIG_SENSORS_LTC4261 is not set
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> # CONFIG_SENSORS_MAX16065 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_MAX1668 is not set
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6642 is not set
> # CONFIG_SENSORS_MAX6650 is not set
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_MLXREG_FAN is not set
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM70 is not set
> # CONFIG_SENSORS_LM73 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_LM93 is not set
> # CONFIG_SENSORS_LM95234 is not set
> # CONFIG_SENSORS_LM95241 is not set
> # CONFIG_SENSORS_LM95245 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> # CONFIG_SENSORS_NCT6683 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SHT15 is not set
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_DME1737 is not set
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC6W201 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_SCH5627 is not set
> # CONFIG_SENSORS_SCH5636 is not set
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> # CONFIG_SENSORS_ADS7871 is not set
> # CONFIG_SENSORS_AMC6821 is not set
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_TMP513 is not set
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83793 is not set
> # CONFIG_SENSORS_W83795 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=m
> # CONFIG_SENSORS_ATK0110 is not set
> CONFIG_THERMAL=y
> CONFIG_THERMAL_NETLINK=y
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_X86_THERMAL_VECTOR=y
> # CONFIG_X86_PKG_TEMP_THERMAL is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_PCH_THERMAL is not set
> # end of Intel thermal drivers
> 
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> CONFIG_WATCHDOG_SYSFS=y
> 
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> 
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_WDAT_WDT is not set
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_MLX_WDT is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_EBC_C384_WDT is not set
> # CONFIG_F71808E_WDT is not set
> # CONFIG_SP5100_TCO is not set
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_IBMASR is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I6300ESB_WDT is not set
> # CONFIG_IE6XX_WDT is not set
> # CONFIG_ITCO_WDT is not set
> # CONFIG_IT8712F_WDT is not set
> # CONFIG_IT87_WDT is not set
> CONFIG_HP_WATCHDOG=m
> CONFIG_HPWDT_NMI_DECODING=y
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> # CONFIG_NV_TCO is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> # CONFIG_SMSC_SCH311X_WDT is not set
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> # CONFIG_VIA_WDT is not set
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_W83977F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> # CONFIG_XEN_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
> 
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> CONFIG_MFD_INTEL_LPSS_PCI=y
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_INTEL_PMT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SEC_CORE is not set
> # CONFIG_MFD_SI476X_CORE is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_ABX500_CORE is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # end of Multifunction device drivers
> 
> # CONFIG_REGULATOR is not set
> # CONFIG_RC_CORE is not set
> CONFIG_CEC_CORE=m
> CONFIG_MEDIA_CEC_SUPPORT=y
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_SECO is not set
> # CONFIG_USB_PULSE8_CEC is not set
> # CONFIG_USB_RAINSHADOW_CEC is not set
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=64
> CONFIG_VGA_SWITCHEROO=y
> CONFIG_DRM=m
> CONFIG_DRM_DP_AUX_CHARDEV=y
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=m
> CONFIG_DRM_KMS_FB_HELPER=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_DP_CEC=y
> CONFIG_DRM_TTM=m
> CONFIG_DRM_TTM_HELPER=m
> 
> #
> # I2C encoder or helper chips
> #
> # CONFIG_DRM_I2C_CH7006 is not set
> # CONFIG_DRM_I2C_SIL164 is not set
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> CONFIG_DRM_RADEON=m
> CONFIG_DRM_RADEON_USERPTR=y
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> # CONFIG_DRM_I915 is not set
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_VMWGFX is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> # CONFIG_DRM_QXL is not set
> # CONFIG_DRM_BOCHS is not set
> # CONFIG_DRM_VIRTIO_GPU is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> # CONFIG_DRM_CIRRUS_QEMU is not set
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> # CONFIG_DRM_XEN is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=m
> CONFIG_FB_SYS_COPYAREA=m
> CONFIG_FB_SYS_IMAGEBLIT=m
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=m
> CONFIG_FB_DEFERRED_IO=y
> # CONFIG_FB_MODE_HELPERS is not set
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_EFI=y
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_XEN_FBDEV_FRONTEND is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> # CONFIG_BACKLIGHT_APPLE is not set
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_LP855X is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
> 
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
> 
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> # end of Graphics support
> 
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_HIDRAW=y
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> # CONFIG_HID_ACCUTOUCH is not set
> # CONFIG_HID_ACRUX is not set
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_APPLEIR is not set
> # CONFIG_HID_ASUS is not set
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> # CONFIG_HID_BETOP_FF is not set
> # CONFIG_HID_BIGBEN_FF is not set
> # CONFIG_HID_CHERRY is not set
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> # CONFIG_HID_CMEDIA is not set
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELAN is not set
> # CONFIG_HID_ELECOM is not set
> # CONFIG_HID_ELO is not set
> # CONFIG_HID_EZKEY is not set
> # CONFIG_HID_GEMBIRD is not set
> # CONFIG_HID_GFRM is not set
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_GT683R is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_UCLOGIC is not set
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> # CONFIG_HID_ITE is not set
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> # CONFIG_HID_KENSINGTON is not set
> # CONFIG_HID_LCPOWER is not set
> # CONFIG_HID_LED is not set
> # CONFIG_HID_LENOVO is not set
> # CONFIG_HID_LOGITECH is not set
> CONFIG_HID_MAGICMOUSE=y
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_REDRAGON is not set
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NTI is not set
> CONFIG_HID_NTRIG=y
> # CONFIG_HID_ORTEK is not set
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PENMOUNT is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_PLAYSTATION is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> # CONFIG_HID_SAITEK is not set
> # CONFIG_HID_SAMSUNG is not set
> # CONFIG_HID_SONY is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEAM is not set
> # CONFIG_HID_STEELSERIES is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> # CONFIG_HID_GREENASIA is not set
> # CONFIG_HID_SMARTJOYPLUS is not set
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THINGM is not set
> # CONFIG_HID_THRUSTMASTER is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> # CONFIG_HID_WACOM is not set
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> CONFIG_HID_SENSOR_HUB=y
> # CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
> # CONFIG_HID_ALPS is not set
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> CONFIG_HID_PID=y
> CONFIG_USB_HIDDEV=y
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # end of I2C HID support
> 
> #
> # Intel ISH HID support
> #
> # CONFIG_INTEL_ISH_HID is not set
> # end of Intel ISH HID support
> 
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> CONFIG_USB_MON=y
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_XHCI_DBGCAP=y
> CONFIG_USB_XHCI_PCI=y
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_FSL is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_FOTG210_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=y
> CONFIG_USB_SERIAL_CONSOLE=y
> CONFIG_USB_SERIAL_GENERIC=y
> # CONFIG_USB_SERIAL_SIMPLE is not set
> # CONFIG_USB_SERIAL_AIRCABLE is not set
> # CONFIG_USB_SERIAL_ARK3116 is not set
> # CONFIG_USB_SERIAL_BELKIN is not set
> # CONFIG_USB_SERIAL_CH341 is not set
> # CONFIG_USB_SERIAL_WHITEHEAT is not set
> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> # CONFIG_USB_SERIAL_CP210X is not set
> # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
> # CONFIG_USB_SERIAL_EMPEG is not set
> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> # CONFIG_USB_SERIAL_VISOR is not set
> # CONFIG_USB_SERIAL_IPAQ is not set
> # CONFIG_USB_SERIAL_IR is not set
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> # CONFIG_USB_SERIAL_F81232 is not set
> # CONFIG_USB_SERIAL_F8153X is not set
> # CONFIG_USB_SERIAL_GARMIN is not set
> # CONFIG_USB_SERIAL_IPW is not set
> # CONFIG_USB_SERIAL_IUU is not set
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> # CONFIG_USB_SERIAL_KLSI is not set
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> # CONFIG_USB_SERIAL_MCT_U232 is not set
> # CONFIG_USB_SERIAL_METRO is not set
> # CONFIG_USB_SERIAL_MOS7720 is not set
> # CONFIG_USB_SERIAL_MOS7840 is not set
> # CONFIG_USB_SERIAL_MXUPORT is not set
> # CONFIG_USB_SERIAL_NAVMAN is not set
> # CONFIG_USB_SERIAL_PL2303 is not set
> # CONFIG_USB_SERIAL_OTI6858 is not set
> # CONFIG_USB_SERIAL_QCAUX is not set
> # CONFIG_USB_SERIAL_QUALCOMM is not set
> # CONFIG_USB_SERIAL_SPCP8X5 is not set
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> # CONFIG_USB_SERIAL_SYMBOL is not set
> # CONFIG_USB_SERIAL_TI is not set
> # CONFIG_USB_SERIAL_CYBERJACK is not set
> # CONFIG_USB_SERIAL_OPTION is not set
> # CONFIG_USB_SERIAL_OMNINET is not set
> # CONFIG_USB_SERIAL_OPTICON is not set
> # CONFIG_USB_SERIAL_XSENS_MT is not set
> # CONFIG_USB_SERIAL_WISHBONE is not set
> # CONFIG_USB_SERIAL_SSU100 is not set
> # CONFIG_USB_SERIAL_QT2 is not set
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> # CONFIG_USB_SERIAL_XR is not set
> # CONFIG_USB_SERIAL_DEBUG is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=y
> # CONFIG_TYPEC_TCPM is not set
> CONFIG_TYPEC_UCSI=y
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=y
> # CONFIG_TYPEC_HD3SS3220 is not set
> # CONFIG_TYPEC_TPS6598X is not set
> 
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> 
> #
> # USB Type-C Alternate Mode drivers
> #
> # CONFIG_TYPEC_DP_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
> 
> CONFIG_USB_ROLE_SWITCH=y
> # CONFIG_USB_ROLES_INTEL_XHCI is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_LM3530 is not set
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> # CONFIG_LEDS_LP3944 is not set
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_CLEVO_MAIL is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> # CONFIG_LEDS_MLXCPLD is not set
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> # CONFIG_LEDS_TRIGGER_TIMER is not set
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> CONFIG_LEDS_TRIGGER_DISK=y
> # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> # CONFIG_LEDS_TRIGGER_AUDIO is not set
> # CONFIG_LEDS_TRIGGER_TTY is not set
> 
> #
> # LED Blink
> #
> # CONFIG_LEDS_BLINK is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=m
> CONFIG_EDAC_GHES=y
> CONFIG_EDAC_AMD64=m
> # CONFIG_EDAC_E752X is not set
> # CONFIG_EDAC_I82975X is not set
> # CONFIG_EDAC_I3000 is not set
> # CONFIG_EDAC_I3200 is not set
> # CONFIG_EDAC_IE31200 is not set
> # CONFIG_EDAC_X38 is not set
> # CONFIG_EDAC_I5400 is not set
> # CONFIG_EDAC_I7CORE is not set
> # CONFIG_EDAC_I5000 is not set
> # CONFIG_EDAC_I5100 is not set
> # CONFIG_EDAC_I7300 is not set
> # CONFIG_EDAC_SBRIDGE is not set
> # CONFIG_EDAC_SKX is not set
> # CONFIG_EDAC_I10NM is not set
> # CONFIG_EDAC_PND2 is not set
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> # CONFIG_RTC_DRV_DS1307 is not set
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_ISL12022 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_BQ32K is not set
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> # CONFIG_RTC_DRV_RX8010 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> # CONFIG_RTC_DRV_RX4581 is not set
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_DS2404 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_V3020 is not set
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> # CONFIG_INTEL_IDMA64 is not set
> # CONFIG_INTEL_IDXD is not set
> # CONFIG_INTEL_IOATDMA is not set
> # CONFIG_PLX_DMA is not set
> # CONFIG_XILINX_ZYNQMP_DPDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=y
> # CONFIG_DW_DMAC is not set
> CONFIG_DW_DMAC_PCI=y
> # CONFIG_DW_EDMA is not set
> # CONFIG_DW_EDMA_PCIE is not set
> CONFIG_HSU_DMA=y
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> # CONFIG_DMATEST is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> CONFIG_DMABUF_MOVE_NOTIFY=y
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> CONFIG_DMABUF_HEAPS=y
> CONFIG_DMABUF_HEAPS_SYSTEM=y
> # CONFIG_DMABUF_HEAPS_CMA is not set
> # end of DMABUF options
> 
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_VFIO is not set
> CONFIG_IRQ_BYPASS_MANAGER=m
> CONFIG_VIRT_DRIVERS=y
> # CONFIG_VBOXGUEST is not set
> # CONFIG_NITRO_ENCLAVES is not set
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_PCI_LIB=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> # CONFIG_VIRTIO_BALLOON is not set
> # CONFIG_VIRTIO_MEM is not set
> # CONFIG_VIRTIO_INPUT is not set
> # CONFIG_VIRTIO_MMIO is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_NET is not set
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
> 
> #
> # Xen driver support
> #
> # CONFIG_XEN_BALLOON is not set
> # CONFIG_XEN_DEV_EVTCHN is not set
> # CONFIG_XEN_BACKEND is not set
> # CONFIG_XENFS is not set
> CONFIG_XEN_SYS_HYPERVISOR=y
> CONFIG_XEN_XENBUS_FRONTEND=y
> # CONFIG_XEN_GNTDEV is not set
> # CONFIG_XEN_GRANT_DEV_ALLOC is not set
> # CONFIG_XEN_GRANT_DMA_ALLOC is not set
> CONFIG_SWIOTLB_XEN=y
> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> CONFIG_XEN_PRIVCMD=m
> CONFIG_XEN_EFI=y
> CONFIG_XEN_AUTO_XLATE=y
> CONFIG_XEN_ACPI=y
> # CONFIG_XEN_UNPOPULATED_ALLOC is not set
> # end of Xen driver support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_STAGING is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> # CONFIG_ACPI_WMI is not set
> # CONFIG_UV_SYSFS is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_AMD_PMC is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_ASUS_LAPTOP is not set
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_EEEPC_LAPTOP is not set
> CONFIG_X86_PLATFORM_DRIVERS_DELL=y
> # CONFIG_DCDBAS is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DELL_RBTN is not set
> # CONFIG_DELL_SMBIOS is not set
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_AMILO_RFKILL is not set
> # CONFIG_FUJITSU_LAPTOP is not set
> # CONFIG_FUJITSU_TABLET is not set
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_HP_ACCEL is not set
> # CONFIG_HP_WIRELESS is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_IDEAPAD_LAPTOP is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_THINKPAD_ACPI is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_HID_EVENT is not set
> # CONFIG_INTEL_INT0002_VGPIO is not set
> # CONFIG_INTEL_MENLOW is not set
> # CONFIG_INTEL_OAKTRAIL is not set
> # CONFIG_INTEL_VBTN is not set
> # CONFIG_MSI_LAPTOP is not set
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_SAMSUNG_LAPTOP is not set
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_ACPI_CMPC is not set
> # CONFIG_COMPAL_LAPTOP is not set
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_SONY_LAPTOP is not set
> # CONFIG_SYSTEM76_ACPI is not set
> # CONFIG_TOPSTAR_LAPTOP is not set
> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> # CONFIG_INTEL_IPS is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> 
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
> 
> CONFIG_INTEL_TURBO_MAX_3=y
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> # CONFIG_INTEL_PMC_CORE is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_CHROME_PLATFORMS is not set
> CONFIG_MELLANOX_PLATFORM=y
> # CONFIG_SURFACE_PLATFORMS is not set
> CONFIG_HAVE_CLK=y
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_HWSPINLOCK=y
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOASID=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IO_PGTABLE=y
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=y
> CONFIG_AMD_IOMMU=y
> # CONFIG_AMD_IOMMU_V2 is not set
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> CONFIG_INTEL_IOMMU_SVM=y
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
> CONFIG_IRQ_REMAP=y
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_DWC is not set
> # CONFIG_PWM_LPSS_PCI is not set
> # CONFIG_PWM_LPSS_PLATFORM is not set
> # CONFIG_PWM_PCA9685 is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> # CONFIG_IPACK_BUS is not set
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_RESET_BRCMSTB_RESCAL is not set
> # CONFIG_RESET_TI_SYSCON is not set
> 
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> # CONFIG_INTEL_RAPL is not set
> # CONFIG_IDLE_INJECT is not set
> # CONFIG_DTPM is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> # CONFIG_RAS_CEC is not set
> CONFIG_USB4=y
> # CONFIG_USB4_DEBUGFS_WRITE is not set
> # CONFIG_USB4_DMA_TEST is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
> 
> # CONFIG_LIBNVDIMM is not set
> CONFIG_DAX=y
> # CONFIG_DEV_DAX is not set
> # CONFIG_DEV_DAX_HMEM is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> # CONFIG_UNISYS_VISORBUS is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=m
> CONFIG_XFS_SUPPORT_V4=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_ONLINE_SCRUB=y
> # CONFIG_XFS_ONLINE_REPAIR is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> # CONFIG_ZONEFS_FS is not set
> CONFIG_FS_DAX=y
> CONFIG_FS_DAX_PMD=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=m
> # CONFIG_CUSE is not set
> # CONFIG_VIRTIO_FS is not set
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_VMCORE=y
> CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_PROC_CPU_RESCTRL=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> CONFIG_TMPFS_INODE64=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_SQUASHFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=y
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> # CONFIG_PSTORE_RAM is not set
> # CONFIG_PSTORE_BLK is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> # CONFIG_NFS_FS is not set
> # CONFIG_NFSD is not set
> # CONFIG_CEPH_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=y
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> # CONFIG_NLS_UTF8 is not set
> # CONFIG_DLM is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_BIG_KEYS=y
> CONFIG_TRUSTED_KEYS=y
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_KEY_NOTIFICATIONS=y
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_SECURITY_NETWORK_XFRM=y
> # CONFIG_SECURITY_PATH is not set
> CONFIG_INTEL_TXT=y
> CONFIG_LSM_MMAP_MIN_ADDR=65535
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_FALLBACK=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=y
> # CONFIG_SECURITY_SAFESETID is not set
> CONFIG_SECURITY_LOCKDOWN_LSM=y
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
> CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> CONFIG_INTEGRITY_PLATFORM_KEYRING=y
> CONFIG_LOAD_UEFI_KEYS=y
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> # CONFIG_IMA_TEMPLATE is not set
> # CONFIG_IMA_NG_TEMPLATE is not set
> CONFIG_IMA_SIG_TEMPLATE=y
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
> # CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
> CONFIG_IMA_DEFAULT_HASH_SHA256=y
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH="sha256"
> CONFIG_IMA_WRITE_POLICY=y
> CONFIG_IMA_READ_POLICY=y
> CONFIG_IMA_APPRAISE=y
> CONFIG_IMA_ARCH_POLICY=y
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> CONFIG_IMA_APPRAISE_MODSIG=y
> CONFIG_IMA_TRUSTED_KEYRING=y
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> # CONFIG_EVM_ADD_XATTRS is not set
> # CONFIG_EVM_LOAD_X509 is not set
> CONFIG_DEFAULT_SECURITY_SELINUX=y
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM="lockdown,yama,integrity,selinux,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_FIPS=y
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_USER=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> # CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_PCRYPT is not set
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_SEQIV=y
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_LRW is not set
> CONFIG_CRYPTO_OFB=y
> # CONFIG_CRYPTO_PCBC is not set
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=m
> # CONFIG_CRYPTO_CRC32 is not set
> CONFIG_CRYPTO_CRC32_PCLMUL=m
> # CONFIG_CRYPTO_XXHASH is not set
> # CONFIG_CRYPTO_BLAKE2B is not set
> # CONFIG_CRYPTO_BLAKE2S is not set
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
> CONFIG_CRYPTO_GHASH=y
> # CONFIG_CRYPTO_POLY1305 is not set
> CONFIG_CRYPTO_POLY1305_X86_64=y
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA1_SSSE3=y
> CONFIG_CRYPTO_SHA256_SSSE3=y
> CONFIG_CRYPTO_SHA512_SSSE3=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> # CONFIG_CRYPTO_SM3 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> # CONFIG_CRYPTO_WP512 is not set
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_NI_INTEL=y
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_CHACHA20 is not set
> CONFIG_CRYPTO_CHACHA20_X86_64=y
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_SM4 is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_TWOFISH_X86_64 is not set
> # CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
> # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_USER_API_SKCIPHER=y
> CONFIG_CRYPTO_USER_API_RNG=y
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=y
> # CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
> CONFIG_CRYPTO_STATS=y
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_PADLOCK is not set
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=y
> CONFIG_CRYPTO_DEV_CCP_DD=m
> CONFIG_CRYPTO_DEV_SP_CCP=y
> # CONFIG_CRYPTO_DEV_CCP_CRYPTO is not set
> CONFIG_CRYPTO_DEV_SP_PSP=y
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> # CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> # CONFIG_CORDIC is not set
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=m
> # CONFIG_CRC4 is not set
> # CONFIG_CRC7 is not set
> CONFIG_LIBCRC32C=m
> # CONFIG_CRC8 is not set
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_COHERENT_POOL=y
> CONFIG_DMA_CMA=y
> # CONFIG_DMA_PERNUMA_CMA is not set
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_SEL_MBYTES=y
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_COPY_MC=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACK_HASH_ORDER=20
> CONFIG_SBITMAP=y
> # CONFIG_STRING_SELFTEST is not set
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> # CONFIG_PRINTK_CALLER is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_REDUCED is not set
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_BTF is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=2048
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> CONFIG_HEADERS_INSTALL=y
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_STACK_VALIDATION=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> CONFIG_KGDB=y
> CONFIG_KGDB_HONOUR_BLOCKLIST=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> CONFIG_KGDB_TESTS=y
> # CONFIG_KGDB_TESTS_ON_BOOT is not set
> CONFIG_KGDB_LOW_LEVEL_TRAP=y
> CONFIG_KGDB_KDB=y
> CONFIG_KDB_DEFAULT_ENABLE=0x0
> CONFIG_KDB_KEYBOARD=y
> CONFIG_KDB_CONTINUE_CATASTROPHIC=0
> CONFIG_ARCH_HAS_EARLY_DEBUG=y
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=y
> CONFIG_HAVE_KCSAN_COMPILER=y
> # CONFIG_KCSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_PAGE_POISONING=y
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_DEBUG_WX=y
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> # CONFIG_KASAN is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> # CONFIG_DEBUG_LOCKDEP is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_OBJTOOL_MCOUNT=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_BOOTTIME_TRACING=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_FUNCTION_PROFILER=y
> CONFIG_STACK_TRACER=y
> # CONFIG_IRQSOFF_TRACER is not set
> CONFIG_SCHED_TRACER=y
> CONFIG_HWLAT_TRACER=y
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_KPROBE_EVENTS=y
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> # CONFIG_BPF_KPROBE_OVERRIDE is not set
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_MCOUNT_USE_CC=y
> CONFIG_TRACING_MAP=y
> CONFIG_SYNTH_EVENTS=y
> CONFIG_HIST_TRIGGERS=y
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_EARLY_PRINTK_USB=y
> # CONFIG_X86_VERBOSE_BOOTUP is not set
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_X86_DECODER_SELFTEST=y
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_SORT is not set
> # CONFIG_KPROBES_SANITY_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> CONFIG_TEST_KSTRTOX=y
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_LIVEPATCH is not set
> # CONFIG_TEST_STACKINIT is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_HMM is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_MEMTEST is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5425D4C6731
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiB1Km5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiB1Kmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D7CD387A4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646044934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9JNZucF6cOUWHfUrK9ypxvqnvV+SEApFPtcKfU80kI=;
        b=cNvIYLFV8i+GtxiYbTnNri20u8naruDFfDsMRSFTNL2ZOGo5iJnD49oAN5m5OUN+lwJJq2
        azOXvNiZTMXmkIDFeSF6UcdPZh6QrZxp8xwjTFR6I6JsZFdw0Rp3kTvwhcLbxg/Nf+SGHC
        XBJKtDr2gkM52o2rx4CWs4pVkb4o4e0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-_Tv_IIVCMG6-xJfHajpGWQ-1; Mon, 28 Feb 2022 05:42:12 -0500
X-MC-Unique: _Tv_IIVCMG6-xJfHajpGWQ-1
Received: by mail-ed1-f70.google.com with SMTP id b13-20020a056402278d00b0041311e02a9bso5564955ede.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m9JNZucF6cOUWHfUrK9ypxvqnvV+SEApFPtcKfU80kI=;
        b=slDdq2mFQ+HawoM+rbByNWiE4dK1t742+4nKi8CUT8exQl3ZErggRYN5ZhURUxntxX
         JCD1P8S+Eoay7vtFZHDHkjlwxjxA5c18hRNoPQjAPH1KkTDWeIRsCfDnWXqpRsiKWPBq
         0IcLNrO4k6+3o15fLfd5cU8kBvEFaNdhTonHGnol/Bi2afVm67nSVZlaPaxFt0TAfqDf
         pLjzNkcfjcljAYJ8aqTSIkL/UUZZ/YnNSgq3eIbFMS7tzxe0TVscGeUmPgndNTum/qrP
         vhmnqB3rWoToANaVgquxmDD5ifkmVFSl57xzR+MwzcK+0FtZ6YrqfQhV1gnDSzsMHD7n
         IQKQ==
X-Gm-Message-State: AOAM531TsjV07aJCCHPjgsu2DTJH/B1ILnLY8Rl8RmXW/rDfomz16WTb
        NCC01MtUtVJ3pI18ITrS2VNUb5RO1cxHL+SfPr8XZYLnOqxRgQvGNV+tQBle9EPyIEI3LdNPg0L
        WdXNa2z4gJVeyaRJnld46BV4n
X-Received: by 2002:a05:6402:1e8e:b0:412:cfd8:4d12 with SMTP id f14-20020a0564021e8e00b00412cfd84d12mr18673696edf.343.1646044931221;
        Mon, 28 Feb 2022 02:42:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiKa2FUpEeX9d8vFLT+kjzm7dftt1aVsPZaA1svifqCoGu+USwFbrZ4AVlxwwGqaEFanDFFQ==
X-Received: by 2002:a05:6402:1e8e:b0:412:cfd8:4d12 with SMTP id f14-20020a0564021e8e00b00412cfd84d12mr18673684edf.343.1646044930928;
        Mon, 28 Feb 2022 02:42:10 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm4244832ejj.74.2022.02.28.02.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 02:42:10 -0800 (PST)
Message-ID: <6c7be14f-fba9-f230-6b02-b2ae9fb1f893@redhat.com>
Date:   Mon, 28 Feb 2022 11:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [x86/PCI] 62fabd56fa:
 BUG:KASAN:use-after-free_in_pci_acpi_root_prepare_resources
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20220228040021.GB29932@xsang-OptiPlex-9020>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220228040021.GB29932@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/28/22 05:00, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 62fabd56faafe033eb0be3ba24000b8db13d4c17 ("x86/PCI: Disable exclusion of E820 reserved addresses in some cases")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Ugh, yeah this is my bad, the code now looks like this:

                       if (resource_is_pcicfg_ioport(entry->res))
                               resource_list_destroy_entry(entry);
                       if (resource_is_efi_mmio_region(entry->res)) {
                               dev_info(&device->dev,
                                       "host bridge window %pR is marked by EFI as 
                                       entry->res);
                               pci_use_e820 = false;
                       }

So yeah the second check is defering a just destroyed entry in case of
resource_is_pcicfg_ioport() returning true.

This also makes me realize that resource_is_efi_mmio_region should
check the type of the resource.

I'll send a new version fixing both, sorry about this.

Regards,

Hans



> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [ 2.507461][ T1] BUG: KASAN: use-after-free in pci_acpi_root_prepare_resources (include/linux/list.h:150 include/linux/resource_ext.h:48 include/linux/resource_ext.h:59 arch/x86/pci/acpi.c:361) 
> [    2.507461][    T1] Read of size 8 at addr ffff8881433c6190 by task swapper/0/1
> [    2.507461][    T1]
> [    2.507461][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc5-00001-g62fabd56faaf #1
> [    2.507461][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    2.507461][    T1] Call Trace:
> [    2.507461][    T1]  <TASK>
> [ 2.507461][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
> [ 2.507461][ T1] print_address_description+0x21/0x180 
> [ 2.507461][ T1] ? pci_acpi_root_prepare_resources (include/linux/list.h:150 include/linux/resource_ext.h:48 include/linux/resource_ext.h:59 arch/x86/pci/acpi.c:361) 
> [ 2.507461][ T1] kasan_report.cold (mm/kasan/report.c:443 mm/kasan/report.c:459) 
> [ 2.507461][ T1] ? vscnprintf (lib/vsprintf.c:2974) 
> [ 2.507461][ T1] ? pci_acpi_root_prepare_resources (include/linux/list.h:150 include/linux/resource_ext.h:48 include/linux/resource_ext.h:59 arch/x86/pci/acpi.c:361) 
> [ 2.507461][ T1] pci_acpi_root_prepare_resources (include/linux/list.h:150 include/linux/resource_ext.h:48 include/linux/resource_ext.h:59 arch/x86/pci/acpi.c:361) 
> [ 2.507461][ T1] ? pci_acpi_root_init_info.cold (arch/x86/pci/acpi.c:188 arch/x86/pci/acpi.c:219 arch/x86/pci/acpi.c:267) 
> [ 2.507461][ T1] ? acpi_get_parent (drivers/acpi/acpica/nsxfobj.c:127) 
> [ 2.507461][ T1] acpi_pci_root_create (drivers/acpi/pci_root.c:897) 
> [ 2.507461][ T1] pci_acpi_scan_root (arch/x86/pci/acpi.c:431) 
> [ 2.507461][ T1] ? pci_acpi_root_init_info (arch/x86/pci/acpi.c:390) 
> [ 2.507461][ T1] ? decode_osc_bits+0x18a/0x18a 
> [ 2.507461][ T1] ? acpi_pci_find_companion (drivers/pci/pci-acpi.c:108) 
> [ 2.507461][ T1] acpi_pci_root_add.cold (drivers/acpi/pci_root.c:604) 
> [ 2.507461][ T1] ? get_root_bridge_busnr_callback (drivers/acpi/pci_root.c:524) 
> [ 2.507461][ T1] ? klist_next (lib/klist.c:403) 
> [ 2.507461][ T1] ? acpi_bus_get_status_handle (drivers/acpi/bus.c:97) 
> [ 2.507461][ T1] acpi_bus_attach (drivers/acpi/scan.c:2181 drivers/acpi/scan.c:2228) 
> [ 2.507461][ T1] ? acpi_generic_device_attach (drivers/acpi/scan.c:2194) 
> [ 2.507461][ T1] ? __device_attach (drivers/base/dd.c:942) 
> [ 2.507461][ T1] ? device_bind_driver (drivers/base/dd.c:942) 
> [ 2.507461][ T1] acpi_bus_attach (drivers/acpi/scan.c:2248 (discriminator 3)) 
> [ 2.507461][ T1] ? acpi_generic_device_attach (drivers/acpi/scan.c:2194) 
> [ 2.507461][ T1] ? __device_attach (drivers/base/dd.c:942) 
> [ 2.507461][ T1] ? device_bind_driver (drivers/base/dd.c:942) 
> [ 2.507461][ T1] acpi_bus_attach (drivers/acpi/scan.c:2248 (discriminator 3)) 
> [ 2.507461][ T1] ? acpi_generic_device_attach (drivers/acpi/scan.c:2194) 
> [ 2.507461][ T1] ? up (include/linux/list.h:292 kernel/locking/semaphore.c:187) 
> [ 2.507461][ T1] ? acpi_os_signal_semaphore (drivers/acpi/osl.c:1305) 
> [ 2.507461][ T1] ? acpi_ut_release_read_lock (drivers/acpi/acpica/utlock.c:111) 
> [ 2.507461][ T1] ? acpi_bus_check_add_2 (drivers/acpi/scan.c:2116) 
> [ 2.507461][ T1] ? acpi_walk_namespace (drivers/acpi/acpica/nsxfeval.c:616 drivers/acpi/acpica/nsxfeval.c:554) 
> [ 2.507461][ T1] acpi_bus_scan (drivers/acpi/scan.c:2441) 
> [ 2.507461][ T1] ? acpi_bus_check_add_1 (drivers/acpi/scan.c:2423) 
> [ 2.507461][ T1] acpi_scan_init (drivers/acpi/scan.c:2603) 
> [ 2.507461][ T1] ? acpi_match_madt (drivers/acpi/scan.c:2553) 
> [ 2.507461][ T1] ? acpi_ut_release_mutex (drivers/acpi/acpica/utmutex.c:329) 
> [ 2.507461][ T1] ? acpi_install_address_space_handler (drivers/acpi/acpica/evxfregn.c:88) 
> [ 2.507461][ T1] acpi_init (drivers/acpi/bus.c:1335) 
> [ 2.507461][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1311) 
> [ 2.507461][ T1] do_one_initcall (init/main.c:1300) 
> [ 2.507461][ T1] ? perf_trace_initcall_level (init/main.c:1291) 
> [ 2.507461][ T1] ? parameq (kernel/params.c:170) 
> [ 2.507461][ T1] ? kasan_unpoison (mm/kasan/shadow.c:108 mm/kasan/shadow.c:142) 
> [ 2.507461][ T1] ? __kasan_slab_alloc (mm/kasan/common.c:431 mm/kasan/common.c:469) 
> [ 2.507461][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
> [ 2.507461][ T1] ? console_on_rootfs (init/main.c:1584) 
> [ 2.507461][ T1] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:82 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
> [ 2.507461][ T1] ? _raw_spin_lock (kernel/locking/spinlock.c:169) 
> [ 2.507461][ T1] ? rest_init (init/main.c:1494) 
> [ 2.507461][ T1] kernel_init (init/main.c:1504) 
> [ 2.507461][ T1] ret_from_fork (arch/x86/entry/entry_64.S:301) 
> [    2.507461][    T1]  </TASK>
> [    2.507461][    T1]
> [    2.507461][    T1] Allocated by task 1:
> [ 2.507461][ T1] kasan_save_stack (mm/kasan/common.c:39) 
> [ 2.507461][ T1] __kasan_kmalloc (mm/kasan/common.c:45 mm/kasan/common.c:436 mm/kasan/common.c:515 mm/kasan/common.c:524) 
> [ 2.507461][ T1] resource_list_create_entry (kernel/resource.c:1783) 
> [ 2.507461][ T1] acpi_dev_new_resource_entry (drivers/acpi/resource.c:564) 
> [ 2.507461][ T1] acpi_dev_process_resource (drivers/acpi/resource.c:601 drivers/acpi/resource.c:575) 
> [ 2.507461][ T1] acpi_walk_resource_buffer (drivers/acpi/acpica/rsxface.c:548) 
> [ 2.507461][ T1] acpi_walk_resources (include/acpi/platform/aclinuxex.h:62 drivers/acpi/acpica/rsxface.c:624 drivers/acpi/acpica/rsxface.c:594) 
> [ 2.507461][ T1] __acpi_dev_get_resources (drivers/acpi/resource.c:635 drivers/acpi/resource.c:614) 
> [ 2.507461][ T1] acpi_pci_probe_root_resources (drivers/acpi/pci_root.c:777) 
> [ 2.507461][ T1] pci_acpi_root_prepare_resources (arch/x86/pci/acpi.c:358) 
> [ 2.507461][ T1] acpi_pci_root_create (drivers/acpi/pci_root.c:897) 
> [ 2.507461][ T1] pci_acpi_scan_root (arch/x86/pci/acpi.c:431) 
> [ 2.507461][ T1] acpi_pci_root_add.cold (drivers/acpi/pci_root.c:604) 
> [ 2.507461][ T1] acpi_bus_attach (drivers/acpi/scan.c:2181 drivers/acpi/scan.c:2228) 
> [ 2.507461][ T1] acpi_bus_attach (drivers/acpi/scan.c:2248 (discriminator 3)) 
> [ 2.507461][ T1] acpi_bus_scan (drivers/acpi/scan.c:2441) 
> [ 2.507461][ T1] acpi_scan_init (drivers/acpi/scan.c:2603) 
> [ 2.507461][ T1] acpi_init (drivers/acpi/bus.c:1335) 
> [ 2.507461][ T1] do_one_initcall (init/main.c:1300) 
> [ 2.507461][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
> [ 2.507461][ T1] kernel_init (init/main.c:1504) 
> [ 2.507461][ T1] ret_from_fork (arch/x86/entry/entry_64.S:301) 
> [    2.507461][    T1]
> [    2.507461][    T1] Freed by task 1:
> [ 2.507461][ T1] kasan_save_stack (mm/kasan/common.c:39) 
> [ 2.507461][ T1] kasan_set_track (mm/kasan/common.c:45) 
> [ 2.507461][ T1] kasan_set_free_info (mm/kasan/generic.c:372) 
> [ 2.507461][ T1] __kasan_slab_free (mm/kasan/common.c:368 mm/kasan/common.c:328 mm/kasan/common.c:374) 
> [ 2.507461][ T1] kfree (mm/slub.c:1754 mm/slub.c:3509 mm/slub.c:4562) 
> [ 2.507461][ T1] pci_acpi_root_prepare_resources (include/linux/resource_ext.h:53 include/linux/resource_ext.h:60 arch/x86/pci/acpi.c:361) 
> [ 2.507461][ T1] acpi_pci_root_create (drivers/acpi/pci_root.c:897) 
> [ 2.507461][ T1] pci_acpi_scan_root (arch/x86/pci/acpi.c:431) 
> [ 2.507461][ T1] acpi_pci_root_add.cold (drivers/acpi/pci_root.c:604) 
> [ 2.507461][ T1] acpi_bus_attach (drivers/acpi/scan.c:2181 drivers/acpi/scan.c:2228) 
> [ 2.507461][ T1] acpi_bus_attach (drivers/acpi/scan.c:2248 (discriminator 3)) 
> [ 2.507461][ T1] acpi_bus_scan (drivers/acpi/scan.c:2441) 
> [ 2.507461][ T1] acpi_scan_init (drivers/acpi/scan.c:2603) 
> [ 2.507461][ T1] acpi_init (drivers/acpi/bus.c:1335) 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.17.0-rc5-00001-g62fabd56faaf .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 


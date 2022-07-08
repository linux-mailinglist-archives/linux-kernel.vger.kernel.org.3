Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7817556BB2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiGHNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiGHNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:50:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436319034
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:49:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o25so37838449ejm.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=U2Wb9LCC62X9lbCPeSiFSjR24x4zH07X33g9tsJ0Un0=;
        b=kp8cMYKEyEtqWQ3mMQQZIp3X5sk5++vjUJlFoF3tm4zOw4kwvfqCbKlJnJV064CQYb
         v+9l0J5wIuCYaWyFeAjMozsFAyttvCr9c0sjEsefh58m46rL9KJfByvKSt8dguHEhNR3
         6fIwS+JgNpqzunxdwRq1uuSsE3PyOxap+1KqiA9/MBn7WlgRoo//tYyUs/fZ1Q4W6gR0
         99pkvp+2hxz2eX8rdvM6yjm3RdP+ac1FFfhjeCcC3oM4KmZkpfH5mKsdbqTG/ns914oo
         CBBfN9UJRwY9Tc+Jl9OsooeDHoutjG9F508c/n6OS1bIER258Tr/y7F2QLLlrP5+v5eI
         S/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=U2Wb9LCC62X9lbCPeSiFSjR24x4zH07X33g9tsJ0Un0=;
        b=f8PSdAmQ+GAFuiRkkOpNoZA0KhKsrZz0z3lE2CbqN4E+g9q7+TUHCxa1Gc6zDmTIyg
         dyVPwrtZ2ukpg6C7zKjYNeAK6x55McrIAx/LX6P+BsSsQP9wEuuEaZ8VSv28kXozWfTu
         xIzmIsUVmUIndxylDVbSUdP7b6SPxgEKpB1z62u1Zns/bCdibmgwogLI7Q1WN+DJIpzN
         n1wGN+j2fjdYBhlNT3pjKm7AP3xYMqquxlatq4db0UK3snxtDe7vluN5Nk1D2oDUUzYN
         fcRrUQ0fxCvWGXSzB5o7m2vrjAREUXUmotbmbF/DQTgRlA8Co8apWlR/JU+XKb7Uos8D
         TRgg==
X-Gm-Message-State: AJIora+Z9QHEFif7vStc9f37h1wMMuKWXPvrB5pmFTCEjFiEmHod6xef
        uzzxhWRGq6/ee7eYGv/vmRY=
X-Google-Smtp-Source: AGRyM1sWDjh+YPs9qCgpn0UGA+6Pfpuuetp/PgVtQQCQ+oGU/TNm+d6U0Myh92N4sZCN5vwLSpBGrA==
X-Received: by 2002:a17:907:6d86:b0:726:99d7:20e4 with SMTP id sb6-20020a1709076d8600b0072699d720e4mr3841511ejc.342.1657288188711;
        Fri, 08 Jul 2022 06:49:48 -0700 (PDT)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709062a4b00b00726abf9a32bsm16101660eje.138.2022.07.08.06.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:49:47 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:49:42 +0200
From:   Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: PROBLEM: dmesg tracedumps on rtsx_usb module loading during boot
Message-ID: <20220708134942.r3nhwzgh4nchaebi@artix.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f3uetlu5s7siaz6g"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

[1.] One line summary of the problem:
dmesg tracedumps on rtsx_usb module loading during boot
[2.] Full description of the problem/report:
SD card driver does not work.
I tried to pinpoint commit that caused it in staging tree using git
bisect. But 13 commits between "good" and "bad" would not compile due to
errors.
[3.] Keywords (i.e., modules, networking, kernel):
rtsx_usb dma-mapping usb_hcd_map_urb_for_dma
[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
Linux version 5.17.0-12897-g9ae2a143081f (aleksa@artix) (gcc (GCC)
12.1.0, GNU ld (GNU Binutils) 2.38) #2 SMP PREEMPT_DYNAMIC Fri Jul 8
14:25:23 CEST 2022
[4.2.] Kernel .config file:
<attached .config>
[5.] Most recent kernel version which did not have the bug:
5.17.0-12883-g37fcacb50be7
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
37fcacb50be7071d146144a6c5c5bf0194b9a1cf
[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/admin-guide/bug-hunting.rst)
<attached decode_stacktrace.log>
[7.] A small shell script or example program which triggers the
     problem (if possible)
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
<attached ver_linux.log>
[8.2.] Processor information (from /proc/cpuinfo):
<attached cpuinfo.log>
[8.3.] Module information (from /proc/modules):
<attached modules.log>
[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
[8.5.] PCI information ('lspci -vvv' as root)
$ lsusb
Bus 001 Device 003: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129
Card Reader Controller
[8.6.] SCSI information (from /proc/scsi/scsi)
[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

I tried to find that introduced this bug using git bisect but following
13 commits (before 9ae2a143081fa8fba5042431007b33d9a855b7a2) are
unbuildable:
possible first bad commit: [9ae2a143081fa8fba5042431007b33d9a855b7a2]
Merge tag 'dma-mapping-5.18' of
git://git.infradead.org/users/hch/dma-mapping
possible first bad commit: [8ddde07a3d285a0f3cec14924446608320fdc013]
dma-mapping: benchmark: extract a common header file for map_benchmark
definition
possible first bad commit: [80e4390981618e290616dbd06ea190d4576f219d]
dma-debug: fix return value of __setup handlers
possible first bad commit: [f5ff79fddf0efecca538046b5cc20fb3ded2ec4f]
dma-mapping: remove CONFIG_DMA_REMAP
possible first bad commit: [fba09099c6e506608e05e08ac717bf34501f821b]
media: v4l2-pci-skeleton: Remove usage of the deprecated
"pci-dma-compat.h" API
possible first bad commit: [8c155674d9757be855547dc4eb6bcb82d52482e7]
rapidio/tsi721: Remove usage of the deprecated "pci-dma-compat.h" API
possible first bad commit: [0fb3436b4b36cf69f4544385aa2bb8c5a4913509]
sparc: Remove usage of the deprecated "pci-dma-compat.h" API
possible first bad commit: [ffecba83be9c7ced229b9f1d75643d5a49f820c4]
agp/intel: Remove usage of the deprecated "pci-dma-compat.h" API
possible first bad commit: [06cc5cf16591c3b1d63af2bbc9d33a66419ced98]
alpha: Remove usage of the deprecated "pci-dma-compat.h" API
possible first bad commit: [e62c17f0455a74b182ce6373e2777817256afaa1]
MAINTAINERS: update maintainer list of DMA MAPPING BENCHMARK
possible first bad commit: [404f9373c4e5c943ed8a5e71c8dcfef9eddd54ab]
swiotlb: simplify array allocation
possible first bad commit: [c0a4191c27a12d3175283fa33f16db20e91008fd]
swiotlb: tidy up includes
possible first bad commit: [35265899acef135225e946b883fb07acba1d31a2]
swiotlb: simplify debugfs setup
possible first bad commit: [dfcf2e017f5bb928094952d5d56d3566d3d07ba7]
swiotlb: do not zero buffer in set_memory_decrypted()

Errors that occur I had when trying to compile them:
subcmd-util.h:58:31: error: pointer may be used after ‘realloc’
[-Werror=use-after-free]
   58 |                         ret = realloc(ptr, 1);
check.c:2867:58: error: ‘%d’ directive output may be truncated writing
between 1 and 10 bytes into a region of size 9
[-Werror=format-truncation=]
 2867 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]",
 idx);

Full logs:
<attached full_dmesg_bad.log>
<attached full_dmesg_good.log>
<attached git_bisect.log>

I am willing to help with testing/compiling.
Could you please just point me in the right direction (for example
should i disable -Werror or somthing) for the unbuildable commits to
exacly pinpoint bad commit.

Thanks in advance,
Aleksa Vuckovic

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuinfo.log"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 142
model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping	: 9
microcode	: 0xec
cpu MHz		: 2700.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple pml ept_mode_based_exec
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit srbds
bogomips	: 5401.81
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 142
model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping	: 9
microcode	: 0xec
cpu MHz		: 2700.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple pml ept_mode_based_exec
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit srbds
bogomips	: 5401.81
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 142
model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping	: 9
microcode	: 0xec
cpu MHz		: 2700.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple pml ept_mode_based_exec
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit srbds
bogomips	: 5401.81
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 142
model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping	: 9
microcode	: 0xec
cpu MHz		: 600.027
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple pml ept_mode_based_exec
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit srbds
bogomips	: 5401.81
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:


--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="full_dmesg_bad.log"

[    0.000000] Linux version 5.17.0-12897-g9ae2a143081f (aleksa@artix) (gcc (GCC) 12.1.0, GNU ld (GNU Binutils) 2.38) #2 SMP PREEMPT_DYNAMIC Fri Jul 8 14:25:23 CEST 2022
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux5.17.0 root=UUID=d1b5bfc8-4be8-4d91-acd8-77673ad934a3 rw loglevel=3 pci=noaer intel_iommu=on vfio-pci.ids=1002:6665
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 2032
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000090f51fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000090f52000-0x0000000090f52fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000090f53000-0x000000009849cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009849d000-0x00000000984dafff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000984db000-0x0000000098e26fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000098e27000-0x000000009f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000025f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: Dell Inc. Inspiron 3576/0VD8XV, BIOS 1.16.0 12/16/2021
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.000000] tsc: Detected 2699.909 MHz TSC
[    0.000592] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000595] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000600] last_pfn = 0x25f800 max_arch_pfn = 0x400000000
[    0.000696] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001371] last_pfn = 0x90f52 max_arch_pfn = 0x400000000
[    0.007970] found SMP MP-table at [mem 0x000fcf70-0x000fcf7f]
[    0.007985] Using GB pages for direct mapping
[    0.008168] RAMDISK: [mem 0x36df7000-0x376f2fff]
[    0.008171] ACPI: Early table checksum verification disabled
[    0.008175] ACPI: RSDP 0x00000000000EEBA0 000024 (v02 DELL  )
[    0.008179] ACPI: XSDT 0x00000000984A90B8 0000EC (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008184] ACPI: FACP 0x00000000984CDE90 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.008189] ACPI: DSDT 0x00000000984A9230 024C5B (v02 DELL   CBX3     01072009 INTL 20160422)
[    0.008192] ACPI: FACS 0x0000000098E24180 000040
[    0.008194] ACPI: APIC 0x00000000984CDFA0 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.008197] ACPI: FPDT 0x00000000984CE028 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008199] ACPI: FIDT 0x00000000984CE070 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008202] ACPI: MCFG 0x00000000984CE120 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.008204] ACPI: HPET 0x00000000984CE160 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
[    0.008207] ACPI: SSDT 0x00000000984CE198 00036E (v01 SataRe SataTabl 00001000 INTL 20160422)
[    0.008209] ACPI: BOOT 0x00000000984CE508 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008212] ACPI: SSDT 0x00000000984CE530 0012EA (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.008214] ACPI: HPET 0x00000000984CF820 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
[    0.008217] ACPI: SSDT 0x00000000984CF858 001176 (v02 INTEL  xh_OEMBD 00000000 INTL 20160422)
[    0.008220] ACPI: UEFI 0x00000000984D09D0 000042 (v01                 00000000      00000000)
[    0.008222] ACPI: SSDT 0x00000000984D0A18 0017AE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.008225] ACPI: LPIT 0x00000000984D21C8 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    0.008227] ACPI: WSMT 0x00000000984D2260 000028 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    0.008230] ACPI: SSDT 0x00000000984D2288 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.008232] ACPI: SSDT 0x00000000984D2528 000E3F (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.008235] ACPI: DBGP 0x00000000984D3368 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.008237] ACPI: DBG2 0x00000000984D33A0 000061 (v00 INTEL           00000002 MSFT 0000005F)
[    0.008240] ACPI: SSDT 0x00000000984D3408 0049C1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
[    0.008243] ACPI: SLIC 0x00000000984D7DD0 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    0.008245] ACPI: SSDT 0x00000000984D7F48 00069A (v02 SgRef  SgPch    00001000 INTL 20160422)
[    0.008248] ACPI: SSDT 0x00000000984D85E8 000281 (v02 SgRef  SgUlx    00001000 INTL 20160422)
[    0.008250] ACPI: SSDT 0x00000000984D8870 0017FF (v01 AmdRef AmdTabl  00001000 INTL 20160422)
[    0.008253] ACPI: DMAR 0x00000000984DA070 0000EC (v01 INTEL  EDK2     00000001 INTL 00000001)
[    0.008255] ACPI: Reserving FACP table memory at [mem 0x984cde90-0x984cdf9b]
[    0.008256] ACPI: Reserving DSDT table memory at [mem 0x984a9230-0x984cde8a]
[    0.008257] ACPI: Reserving FACS table memory at [mem 0x98e24180-0x98e241bf]
[    0.008258] ACPI: Reserving APIC table memory at [mem 0x984cdfa0-0x984ce023]
[    0.008259] ACPI: Reserving FPDT table memory at [mem 0x984ce028-0x984ce06b]
[    0.008260] ACPI: Reserving FIDT table memory at [mem 0x984ce070-0x984ce11b]
[    0.008260] ACPI: Reserving MCFG table memory at [mem 0x984ce120-0x984ce15b]
[    0.008261] ACPI: Reserving HPET table memory at [mem 0x984ce160-0x984ce197]
[    0.008262] ACPI: Reserving SSDT table memory at [mem 0x984ce198-0x984ce505]
[    0.008263] ACPI: Reserving BOOT table memory at [mem 0x984ce508-0x984ce52f]
[    0.008264] ACPI: Reserving SSDT table memory at [mem 0x984ce530-0x984cf819]
[    0.008265] ACPI: Reserving HPET table memory at [mem 0x984cf820-0x984cf857]
[    0.008265] ACPI: Reserving SSDT table memory at [mem 0x984cf858-0x984d09cd]
[    0.008266] ACPI: Reserving UEFI table memory at [mem 0x984d09d0-0x984d0a11]
[    0.008267] ACPI: Reserving SSDT table memory at [mem 0x984d0a18-0x984d21c5]
[    0.008268] ACPI: Reserving LPIT table memory at [mem 0x984d21c8-0x984d225b]
[    0.008269] ACPI: Reserving WSMT table memory at [mem 0x984d2260-0x984d2287]
[    0.008269] ACPI: Reserving SSDT table memory at [mem 0x984d2288-0x984d2526]
[    0.008270] ACPI: Reserving SSDT table memory at [mem 0x984d2528-0x984d3366]
[    0.008271] ACPI: Reserving DBGP table memory at [mem 0x984d3368-0x984d339b]
[    0.008272] ACPI: Reserving DBG2 table memory at [mem 0x984d33a0-0x984d3400]
[    0.008273] ACPI: Reserving SSDT table memory at [mem 0x984d3408-0x984d7dc8]
[    0.008274] ACPI: Reserving SLIC table memory at [mem 0x984d7dd0-0x984d7f45]
[    0.008275] ACPI: Reserving SSDT table memory at [mem 0x984d7f48-0x984d85e1]
[    0.008275] ACPI: Reserving SSDT table memory at [mem 0x984d85e8-0x984d8868]
[    0.008276] ACPI: Reserving SSDT table memory at [mem 0x984d8870-0x984da06e]
[    0.008277] ACPI: Reserving DMAR table memory at [mem 0x984da070-0x984da15b]
[    0.008373] No NUMA configuration found
[    0.008374] Faking a node at [mem 0x0000000000000000-0x000000025f7fffff]
[    0.008377] NODE_DATA(0) allocated [mem 0x25f7fc000-0x25f7fffff]
[    0.008397] Zone ranges:
[    0.008398]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008400]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008401]   Normal   [mem 0x0000000100000000-0x000000025f7fffff]
[    0.008403]   Device   empty
[    0.008404] Movable zone start for each node
[    0.008404] Early memory node ranges
[    0.008405]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.008406]   node   0: [mem 0x0000000000100000-0x0000000090f51fff]
[    0.008407]   node   0: [mem 0x0000000100000000-0x000000025f7fffff]
[    0.008409] Initmem setup node 0 [mem 0x0000000000001000-0x000000025f7fffff]
[    0.008413] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.008456] On node 0, zone DMA: 100 pages in unavailable ranges
[    0.039508] On node 0, zone Normal: 28846 pages in unavailable ranges
[    0.039537] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.039547] Reserving Intel graphics memory at [mem 0x9b800000-0x9f7fffff]
[    0.039679] ACPI: PM-Timer IO Port: 0x1808
[    0.039686] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.039687] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.039688] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.039689] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.039715] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.039722] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.039726] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.039734] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.039735] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.039738] TSC deadline timer available
[    0.039739] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.039751] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.039753] PM: hibernation: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
[    0.039754] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.039755] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.039756] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.039757] PM: hibernation: Registered nosave memory: [mem 0x90f52000-0x90f52fff]
[    0.039758] PM: hibernation: Registered nosave memory: [mem 0x90f53000-0x9849cfff]
[    0.039758] PM: hibernation: Registered nosave memory: [mem 0x9849d000-0x984dafff]
[    0.039759] PM: hibernation: Registered nosave memory: [mem 0x984db000-0x98e26fff]
[    0.039760] PM: hibernation: Registered nosave memory: [mem 0x98e27000-0x9f7fffff]
[    0.039760] PM: hibernation: Registered nosave memory: [mem 0x9f800000-0xdfffffff]
[    0.039761] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.039762] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
[    0.039762] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.039763] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.039764] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.039764] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    0.039765] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.039766] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.039766] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.039767] [mem 0x9f800000-0xdfffffff] available for PCI devices
[    0.039769] Booting paravirtualized kernel on bare hardware
[    0.039771] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.044623] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:4 nr_node_ids:1
[    0.044834] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
[    0.044839] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
[    0.044841] pcpu-alloc: [0] 0 1 2 3 
[    0.044857] Fallback order for Node 0: 0 
[    0.044859] Built 1 zonelists, mobility grouping on.  Total pages: 2001460
[    0.044861] Policy zone: Normal
[    0.044862] Kernel command line: BOOT_IMAGE=/vmlinuz-linux5.17.0 root=UUID=d1b5bfc8-4be8-4d91-acd8-77673ad934a3 rw loglevel=3 pci=noaer intel_iommu=on vfio-pci.ids=1002:6665
[    0.044926] DMAR: IOMMU enabled
[    0.044939] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-linux5.17.0", will be passed to user space.
[    0.045768] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.046222] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.046503] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.102351] Memory: 7877868K/8133556K available (14343K kernel code, 2059K rwdata, 6096K rodata, 1776K init, 3528K bss, 255428K reserved, 0K cma-reserved)
[    0.102384] random: get_random_u64 called from __kmem_cache_create+0x2a/0x500 with crng_init=0
[    0.102493] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.102507] Kernel/User page tables isolation: enabled
[    0.102522] ftrace: allocating 43989 entries in 172 pages
[    0.109793] ftrace: allocated 172 pages with 4 groups
[    0.109876] Dynamic Preempt: full
[    0.109900] rcu: Preemptible hierarchical RCU implementation.
[    0.109901] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=4.
[    0.109902] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.109903] 	Trampoline variant of Tasks RCU enabled.
[    0.109904] 	Rude variant of Tasks RCU enabled.
[    0.109904] 	Tracing variant of Tasks RCU enabled.
[    0.109905] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    0.109906] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.113278] NR_IRQS: 20736, nr_irqs: 1024, preallocated irqs: 16
[    0.113640] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.113667] random: crng init done (trusting CPU's manufacturer)
[    0.113701] spurious 8259A interrupt: IRQ7.
[    0.113726] Console: colour dummy device 80x25
[    0.113737] printk: console [tty0] enabled
[    0.113754] ACPI: Core revision 20211217
[    0.113999] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.114102] APIC: Switch to symmetric I/O mode setup
[    0.114104] DMAR: Host address width 39
[    0.114105] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.114110] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.114112] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.114115] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.114117] DMAR: RMRR base: 0x000000981f1000 end: 0x00000098210fff
[    0.114119] DMAR: RMRR base: 0x00000098ff2000 end: 0x0000009923bfff
[    0.114120] DMAR: RMRR base: 0x0000009b000000 end: 0x0000009f7fffff
[    0.114121] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.114123] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.114124] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.114125] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.116314] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.116315] x2apic enabled
[    0.116327] Switched APIC routing to cluster x2apic.
[    0.120409] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.134129] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x26eae8729ef, max_idle_ns: 440795235156 ns
[    0.134134] Calibrating delay loop (skipped), value calculated using timer frequency.. 5401.81 BogoMIPS (lpj=8999696)
[    0.134136] pid_max: default: 32768 minimum: 301
[    0.134158] LSM: Security Framework initializing
[    0.134163] landlock: Up and running.
[    0.134164] Yama: becoming mindful.
[    0.134172] LSM support for eBPF active
[    0.134214] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.134241] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.134475] x86/cpu: SGX disabled by BIOS.
[    0.134481] CPU0: Thermal monitoring enabled (TM1)
[    0.134531] process: using mwait in idle threads
[    0.134533] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.134534] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.134538] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.134539] Spectre V2 : Mitigation: Retpolines
[    0.134540] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.134541] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.134542] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.134542] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.134544] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.134549] SRBDS: Mitigation: Microcode
[    0.134550] MDS: Mitigation: Clear CPU buffers
[    0.136894] Freeing SMP alternatives memory: 36K
[    0.137452] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1175
[    0.137463] smpboot: CPU0: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.137465] cblist_init_generic: Setting adjustable number of callback queues.
[    0.137465] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.137465] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.137465] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.137465] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.137465] ... version:                4
[    0.137465] ... bit width:              48
[    0.137465] ... generic registers:      4
[    0.137465] ... value mask:             0000ffffffffffff
[    0.137465] ... max period:             00007fffffffffff
[    0.137465] ... fixed-purpose events:   3
[    0.137465] ... event mask:             000000070000000f
[    0.137465] rcu: Hierarchical SRCU implementation.
[    0.137465] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.137465] smp: Bringing up secondary CPUs ...
[    0.137465] x86: Booting SMP configuration:
[    0.137465] .... node  #0, CPUs:      #1 #2
[    0.137465] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.137465]  #3
[    0.137465] smp: Brought up 1 node, 4 CPUs
[    0.137465] smpboot: Max logical packages: 1
[    0.137465] smpboot: Total of 4 processors activated (21607.24 BogoMIPS)
[    0.137756] devtmpfs: initialized
[    0.137756] x86/mm: Memory block size: 128MB
[    0.137961] ACPI: PM: Registering ACPI NVS region [mem 0x90f52000-0x90f52fff] (4096 bytes)
[    0.137961] ACPI: PM: Registering ACPI NVS region [mem 0x984db000-0x98e26fff] (9748480 bytes)
[    0.137961] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.137961] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.137961] pinctrl core: initialized pinctrl subsystem
[    0.137961] PM: RTC time: 12:30:04, date: 2022-07-08
[    0.138232] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.138609] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.138737] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.138881] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.138908] audit: initializing netlink subsys (disabled)
[    0.138930] audit: type=2000 audit(1657283404.023:1): state=initialized audit_enabled=0 res=1
[    0.138930] thermal_sys: Registered thermal governor 'fair_share'
[    0.138930] thermal_sys: Registered thermal governor 'bang_bang'
[    0.138930] thermal_sys: Registered thermal governor 'step_wise'
[    0.138930] thermal_sys: Registered thermal governor 'user_space'
[    0.138930] thermal_sys: Registered thermal governor 'power_allocator'
[    0.138930] cpuidle: using governor ladder
[    0.138930] cpuidle: using governor menu
[    0.138930] Simple Boot Flag at 0x47 set to 0x80
[    0.138930] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.138930] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.138930] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.138930] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.138930] PCI: Using configuration type 1 for base access
[    0.138930] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.141261] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.141266] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.141266] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.141266] ACPI: Added _OSI(Module Device)
[    0.141266] ACPI: Added _OSI(Processor Device)
[    0.141266] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.141266] ACPI: Added _OSI(Processor Aggregator Device)
[    0.141266] ACPI: Added _OSI(Linux-Dell-Video)
[    0.141266] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.141266] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.180006] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.184128] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.191375] ACPI: Dynamic OEM Table Load:
[    0.191381] ACPI: SSDT 0xFFFF9B5940D7E000 0006B4 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    0.192435] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.193465] ACPI: Dynamic OEM Table Load:
[    0.193470] ACPI: SSDT 0xFFFF9B594038B000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    0.194443] ACPI: Dynamic OEM Table Load:
[    0.194447] ACPI: SSDT 0xFFFF9B5940F08600 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160422)
[    0.195349] ACPI: Dynamic OEM Table Load:
[    0.195353] ACPI: SSDT 0xFFFF9B5940D7D800 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160422)
[    0.196619] ACPI: Dynamic OEM Table Load:
[    0.196625] ACPI: SSDT 0xFFFF9B5940127000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160422)
[    0.198277] ACPI: Dynamic OEM Table Load:
[    0.198282] ACPI: SSDT 0xFFFF9B594038A400 000317 (v02 PmRef  ApHwp    00003000 INTL 20160422)
[    0.199285] ACPI: Dynamic OEM Table Load:
[    0.199289] ACPI: SSDT 0xFFFF9B5940388C00 00030A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.201489] ACPI: EC: EC started
[    0.201490] ACPI: EC: interrupt blocked
[    0.206356] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.206359] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions
[    0.206360] ACPI: Interpreter enabled
[    0.206399] ACPI: PM: (supports S0 S3 S4 S5)
[    0.206400] ACPI: Using IOAPIC for interrupt routing
[    0.206438] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.207077] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.211474] ACPI: PM: Power Resource [PC01]
[    0.232636] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.232644] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.234024] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
[    0.234025] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.234762] PCI host bridge to bus 0000:00
[    0.234764] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.234766] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.234767] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.234768] pci_bus 0000:00: root bus resource [mem 0x9f800000-0xdfffffff window]
[    0.234769] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.234770] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.234784] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    0.234850] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    0.234859] pci 0000:00:02.0: reg 0x10: [mem 0xd1000000-0xd1ffffff 64bit]
[    0.234865] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.234869] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.234886] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.235036] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.235046] pci 0000:00:04.0: reg 0x10: [mem 0xd2320000-0xd2327fff 64bit]
[    0.235348] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.235365] pci 0000:00:14.0: reg 0x10: [mem 0xd2310000-0xd231ffff 64bit]
[    0.235427] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.236019] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.236037] pci 0000:00:14.2: reg 0x10: [mem 0xd2337000-0xd2337fff 64bit]
[    0.236151] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.236172] pci 0000:00:15.0: reg 0x10: [mem 0xd2336000-0xd2336fff 64bit]
[    0.236495] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.236516] pci 0000:00:16.0: reg 0x10: [mem 0xd2335000-0xd2335fff 64bit]
[    0.236587] pci 0000:00:16.0: PME# supported from D3hot
[    0.236951] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    0.236964] pci 0000:00:17.0: reg 0x10: [mem 0xd2330000-0xd2331fff]
[    0.236971] pci 0000:00:17.0: reg 0x14: [mem 0xd2334000-0xd23340ff]
[    0.236979] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    0.236986] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    0.236993] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    0.237000] pci 0000:00:17.0: reg 0x24: [mem 0xd2333000-0xd23337ff]
[    0.237038] pci 0000:00:17.0: PME# supported from D3hot
[    0.237295] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.237363] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.237379] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
[    0.237892] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.237963] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.237981] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    0.238433] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    0.238503] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.238520] pci 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
[    0.238976] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.239259] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.239273] pci 0000:00:1f.2: reg 0x10: [mem 0xd232c000-0xd232ffff]
[    0.239536] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.239559] pci 0000:00:1f.3: reg 0x10: [mem 0xd2328000-0xd232bfff 64bit]
[    0.239591] pci 0000:00:1f.3: reg 0x20: [mem 0xd2300000-0xd230ffff 64bit]
[    0.239639] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.240361] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.240418] pci 0000:00:1f.4: reg 0x10: [mem 0xd2332000-0xd23320ff 64bit]
[    0.240487] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.240812] pci 0000:01:00.0: [1002:6665] type 00 class 0x038000
[    0.240829] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.240840] pci 0000:01:00.0: reg 0x18: [mem 0xd0000000-0xd003ffff 64bit]
[    0.240847] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.240860] pci 0000:01:00.0: reg 0x30: [mem 0xd0040000-0xd005ffff pref]
[    0.240867] pci 0000:01:00.0: enabling Extended Tags
[    0.240919] pci 0000:01:00.0: supports D1 D2
[    0.240920] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.240954] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1c.0 (capable of 63.008 Gb/s with 8.0 GT/s PCIe x8 link)
[    0.241016] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.241019] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.241021] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xd00fffff]
[    0.241085] pci 0000:02:00.0: [10ec:8136] type 00 class 0x020000
[    0.241104] pci 0000:02:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.241129] pci 0000:02:00.0: reg 0x18: [mem 0xd2204000-0xd2204fff 64bit]
[    0.241145] pci 0000:02:00.0: reg 0x20: [mem 0xd2200000-0xd2203fff 64bit pref]
[    0.241246] pci 0000:02:00.0: supports D1 D2
[    0.241247] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.241372] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.241374] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.241377] pci 0000:00:1c.4:   bridge window [mem 0xd2200000-0xd22fffff]
[    0.241679] pci 0000:03:00.0: [168c:0042] type 00 class 0x028000
[    0.242006] pci 0000:03:00.0: reg 0x10: [mem 0xd2000000-0xd21fffff 64bit]
[    0.243351] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.244499] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    0.244503] pci 0000:00:1c.5:   bridge window [mem 0xd2000000-0xd21fffff]
[    0.246353] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.246353] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.246353] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.246353] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.246353] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    0.246353] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    0.246353] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.246353] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.249434] ACPI: EC: interrupt unblocked
[    0.249435] ACPI: EC: event unblocked
[    0.249442] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.249443] ACPI: EC: GPE=0x6e
[    0.249445] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC initialization complete
[    0.249446] ACPI: \_SB_.PCI0.LPCB.ECDV: EC: Used to handle transactions and events
[    0.249500] iommu: Default domain type: Translated 
[    0.249501] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.249625] SCSI subsystem initialized
[    0.249633] libata version 3.00 loaded.
[    0.249633] ACPI: bus type USB registered
[    0.249633] usbcore: registered new interface driver usbfs
[    0.249633] usbcore: registered new interface driver hub
[    0.249633] usbcore: registered new device driver usb
[    0.249633] pps_core: LinuxPPS API ver. 1 registered
[    0.249633] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.249633] PTP clock support registered
[    0.249633] EDAC MC: Ver: 3.0.0
[    0.249633] NetLabel: Initializing
[    0.249633] NetLabel:  domain hash size = 128
[    0.249633] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.249633] NetLabel:  unlabeled traffic allowed by default
[    0.249633] mctp: management component transport protocol core
[    0.249633] NET: Registered PF_MCTP protocol family
[    0.249633] PCI: Using ACPI for IRQ routing
[    0.279109] PCI: pci_cache_line_size set to 64 bytes
[    0.279446] e820: reserve RAM buffer [mem 0x0009c400-0x0009ffff]
[    0.279448] e820: reserve RAM buffer [mem 0x90f52000-0x93ffffff]
[    0.279449] e820: reserve RAM buffer [mem 0x25f800000-0x25fffffff]
[    0.280816] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.280816] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.280816] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.280816] vgaarb: loaded
[    0.280839] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.280845] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.282889] clocksource: Switched to clocksource tsc-early
[    0.287989] VFS: Disk quotas dquot_6.6.0
[    0.288004] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.288075] pnp: PnP ACPI init
[    0.288390] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.288394] system 00:00: [io  0xffff] has been reserved
[    0.288395] system 00:00: [io  0xffff] has been reserved
[    0.288397] system 00:00: [io  0xffff] has been reserved
[    0.288398] system 00:00: [io  0x1800-0x18fe] has been reserved
[    0.288399] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.288527] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.288844] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.288846] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.288848] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.288849] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.288851] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.288852] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.288853] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.288855] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.288856] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.288858] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    0.288894] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.288896] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.288897] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.288899] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.288900] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.288901] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.288903] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.289195] system 00:07: [io  0xff00-0xfffe] has been reserved
[    0.290302] system 00:08: [mem 0xfe035000-0xfe035fff] has been reserved
[    0.290304] system 00:08: [mem 0xfe034008-0xfe034fff] has been reserved
[    0.290858] system 00:09: [mem 0xfe034000-0xfe034007] has been reserved
[    0.292445] pnp: PnP ACPI: found 10 devices
[    0.297842] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.297887] NET: Registered PF_INET protocol family
[    0.297975] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.298785] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.298838] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.298968] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.299035] TCP: Hash tables configured (established 65536 bind 65536)
[    0.299094] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.299127] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.299153] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.299193] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.299197] NET: Registered PF_XDP protocol family
[    0.299214] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.299218] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.299222] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xd00fffff]
[    0.299228] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.299230] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.299233] pci 0000:00:1c.4:   bridge window [mem 0xd2200000-0xd22fffff]
[    0.299238] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    0.299241] pci 0000:00:1c.5:   bridge window [mem 0xd2000000-0xd21fffff]
[    0.299246] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.299248] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.299249] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.299250] pci_bus 0000:00: resource 7 [mem 0x9f800000-0xdfffffff window]
[    0.299251] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    0.299253] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.299254] pci_bus 0000:01: resource 1 [mem 0xc0000000-0xd00fffff]
[    0.299255] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.299256] pci_bus 0000:02: resource 1 [mem 0xd2200000-0xd22fffff]
[    0.299257] pci_bus 0000:03: resource 1 [mem 0xd2000000-0xd21fffff]
[    0.300396] PCI: CLS 0 bytes, default 64
[    0.300412] DMAR: ACPI device "device:6a" under DMAR at fed91000 as 00:15.0
[    0.300421] DMAR: No ATSR found
[    0.300422] DMAR: No SATC found
[    0.300424] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.300425] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.300426] DMAR: IOMMU feature nwfs inconsistent
[    0.300427] DMAR: IOMMU feature pasid inconsistent
[    0.300428] DMAR: IOMMU feature eafs inconsistent
[    0.300428] DMAR: IOMMU feature prs inconsistent
[    0.300429] DMAR: IOMMU feature nest inconsistent
[    0.300429] DMAR: IOMMU feature mts inconsistent
[    0.300430] DMAR: IOMMU feature sc_support inconsistent
[    0.300430] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.300431] DMAR: dmar0: Using Queued invalidation
[    0.300435] DMAR: dmar1: Using Queued invalidation
[    0.300465] Unpacking initramfs...
[    0.300747] pci 0000:00:00.0: Adding to iommu group 0
[    0.300762] pci 0000:00:02.0: Adding to iommu group 1
[    0.300772] pci 0000:00:04.0: Adding to iommu group 2
[    0.300789] pci 0000:00:14.0: Adding to iommu group 3
[    0.300798] pci 0000:00:14.2: Adding to iommu group 3
[    0.300834] pci 0000:00:15.0: Adding to iommu group 4
[    0.300847] pci 0000:00:16.0: Adding to iommu group 5
[    0.300855] pci 0000:00:17.0: Adding to iommu group 6
[    0.300867] pci 0000:00:1c.0: Adding to iommu group 7
[    0.300877] pci 0000:00:1c.4: Adding to iommu group 8
[    0.300889] pci 0000:00:1c.5: Adding to iommu group 9
[    0.300906] pci 0000:00:1f.0: Adding to iommu group 10
[    0.300918] pci 0000:00:1f.2: Adding to iommu group 10
[    0.300927] pci 0000:00:1f.3: Adding to iommu group 10
[    0.300935] pci 0000:00:1f.4: Adding to iommu group 10
[    0.300946] pci 0000:01:00.0: Adding to iommu group 11
[    0.300957] pci 0000:02:00.0: Adding to iommu group 12
[    0.300967] pci 0000:03:00.0: Adding to iommu group 13
[    0.302792] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.302795] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.302796] software IO TLB: mapped [mem 0x000000008cf52000-0x0000000090f52000] (64MB)
[    0.308048] Initialise system trusted keyrings
[    0.308057] Key type blacklist registered
[    0.308155] workingset: timestamp_bits=41 max_order=21 bucket_order=0
[    0.309918] zbud: loaded
[    0.310199] integrity: Platform Keyring initialized
[    0.317533] Key type asymmetric registered
[    0.317540] Asymmetric key parser 'x509' registered
[    0.344819] Freeing initrd memory: 9200K
[    0.346999] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    0.347021] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
[    0.347048] io scheduler mq-deadline registered
[    0.347050] io scheduler kyber registered
[    0.347076] io scheduler bfq registered
[    0.347500] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.347699] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    0.347859] pcieport 0000:00:1c.5: PME: Signaling with IRQ 124
[    0.347932] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.348824] ACPI: AC: AC Adapter [AC] (on-line)
[    0.348869] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.348892] ACPI: button: Lid Switch [LID0]
[    0.348913] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.348929] ACPI: button: Power Button [PBTN]
[    0.348946] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.348957] ACPI: button: Sleep Button [SBTN]
[    0.348975] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.348989] ACPI: button: Power Button [PWRF]
[    0.349105] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1175
[    0.350962] thermal LNXTHERM:00: registered as thermal_zone0
[    0.350964] ACPI: thermal: Thermal Zone [THM] (25 C)
[    0.351126] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.352757] Non-volatile memory driver v1.3
[    0.352759] Linux agpgart interface v0.103
[    0.352760] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[    0.352775] ACPI: bus type drm_connector registered
[    0.354152] ahci 0000:00:17.0: version 3.0
[    0.354337] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
[    0.354385] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    0.354388] ahci 0000:00:17.0: flags: 64bit ncq stag pm led clo only pio slum part deso sadm sds apst 
[    0.354652] scsi host0: ahci
[    0.354758] scsi host1: ahci
[    0.354790] ata1: SATA max UDMA/133 abar m2048@0xd2333000 port 0xd2333100 irq 125
[    0.354793] ata2: SATA max UDMA/133 abar m2048@0xd2333000 port 0xd2333180 irq 125
[    0.354826] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.354828] ehci-pci: EHCI PCI platform driver
[    0.354834] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.354836] ohci-pci: OHCI PCI platform driver
[    0.354840] uhci_hcd: USB Universal Host Controller Interface driver
[    0.354863] usbcore: registered new interface driver usbserial_generic
[    0.354866] usbserial: USB Serial support registered for generic
[    0.354978] rtc_cmos 00:01: RTC can wake from S4
[    0.355703] rtc_cmos 00:01: registered as rtc0
[    0.355850] rtc_cmos 00:01: setting system clock to 2022-07-08T12:30:05 UTC (1657283405)
[    0.355862] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.356080] intel_pstate: Intel P-state driver initializing
[    0.356246] intel_pstate: HWP enabled
[    0.356263] ledtrig-cpu: registered to indicate activity on CPUs
[    0.356476] vesafb: mode is 1920x1080x32, linelength=7680, pages=0
[    0.356477] vesafb: scrolling: redraw
[    0.356478] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.356486] vesafb: framebuffer at 0xb0000000, mapped to 0x00000000c0b3a255, using 8128k, total 8128k
[    0.356512] fbcon: Deferring console take-over
[    0.356512] fb0: VESA VGA frame buffer device
[    0.356525] hid: raw HID events driver (C) Jiri Kosina
[    0.356660] intel_pmc_core INT33A1:00:  initialized
[    0.356743] drop_monitor: Initializing network drop monitor service
[    0.356836] Initializing XFRM netlink socket
[    0.356931] NET: Registered PF_INET6 protocol family
[    0.359299] Segment Routing with IPv6
[    0.359301] RPL Segment Routing with IPv6
[    0.359315] In-situ OAM (IOAM) with IPv6
[    0.359338] NET: Registered PF_PACKET protocol family
[    0.359576] microcode: sig=0x806e9, pf=0x80, revision=0xec
[    0.359588] microcode: Microcode Update Driver: v2.2.
[    0.359593] IPI shorthand broadcast: enabled
[    0.359604] sched_clock: Marking stable (358953377, 568184)->(365883794, -6362233)
[    0.359734] registered taskstats version 1
[    0.360202] Loading compiled-in X.509 certificates
[    0.363323] Loaded X.509 cert 'Build time autogenerated kernel key: 660ea857a76fbc7b77d5a539eca5f26c69d9f91e'
[    0.363523] zswap: loaded using pool lz4/z3fold
[    0.363853] Key type ._fscrypt registered
[    0.363855] Key type .fscrypt registered
[    0.363856] Key type fscrypt-provisioning registered
[    0.366081] PM:   Magic number: 14:356:531
[    0.366083] PM:   hash matches drivers/base/power/main.c:904
[    0.366094] tty ttyS11: hash matches
[    0.366488] RAS: Correctable Errors collector initialized.
[    0.375592] ACPI: battery: Slot [BAT0] (battery present)
[    0.668702] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.670394] ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.670404] ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.670637] ata1.00: ATA-11: TOSHIBA KSG60ZMV256G M.2 2280 256GB, ABDA4102, max UDMA/100
[    0.670700] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    0.671305] ata1.00: Features: Dev-Sleep
[    0.672805] ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.672813] ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.673679] ata1.00: configured for UDMA/100
[    0.673952] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA KSG60ZMV 4102 PQ: 0 ANSI: 5
[    0.674576] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    0.674581] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.674601] sd 0:0:0:0: [sda] Write Protect is off
[    0.674607] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.674637] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.691835]  sda: sda1 sda2 sda3 sda4
[    0.708164] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.988771] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.990815] ata2.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.990824] ata2.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.991725] ata2.00: ATA-8: HGST HTS545050A7E680, GG2OAF10, max UDMA/133
[    0.992201] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    0.994422] ata2.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.994431] ata2.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.995374] ata2.00: configured for UDMA/133
[    0.995544] scsi 1:0:0:0: Direct-Access     ATA      HGST HTS545050A7 AF10 PQ: 0 ANSI: 5
[    0.996039] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    0.996046] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    0.996067] sd 1:0:0:0: [sdb] Write Protect is off
[    0.996072] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.996168] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.314256] tsc: Refined TSC clocksource calibration: 2711.989 MHz
[    1.314270] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x27177c1c581, max_idle_ns: 440795280022 ns
[    1.314307] clocksource: Switched to clocksource tsc
[    1.816898]  sdb: sdb1 sdb2
[    1.831068] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.833665] Freeing unused decrypted memory: 2036K
[    1.834321] Freeing unused kernel image (initmem) memory: 1776K
[    1.834416] Write protecting the kernel read-only data: 22528k
[    1.835454] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    1.835624] Freeing unused kernel image (rodata/data gap) memory: 48K
[    1.885010] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.885014] rodata_test: all tests were successful
[    1.885015] x86/mm: Checking user space page tables
[    1.931659] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.931675] Run /init as init process
[    1.931676]   with arguments:
[    1.931677]     /init
[    1.931678]   with environment:
[    1.931679]     HOME=/
[    1.931679]     TERM=linux
[    1.931680]     BOOT_IMAGE=/vmlinuz-linux5.17.0
[    1.936537] fbcon: Taking over console
[    1.936597] Console: switching to colour frame buffer device 240x67
[    2.179267] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    2.179271] checking generic (b0000000 7f0000) vs hw (d1000000 1000000)
[    2.179273] checking generic (b0000000 7f0000) vs hw (b0000000 10000000)
[    2.179274] fb0: switching to i915 from VESA VGA
[    2.179443] Console: switching to colour dummy device 80x25
[    2.179509] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.179537] i915 0000:00:02.0: [drm] Transparent Hugepage mode 'huge=within_size'
[    2.181852] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.184297] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    2.252770] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    2.255882] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.257292] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    2.263657] fbcon: i915drmfb (fb0) is primary device
[    2.268677] Console: switching to colour frame buffer device 240x67
[    2.290021] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.428998] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    2.429282] i8042: Warning: Keylock active
[    2.430632] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.430675] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.438689] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.438697] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.439835] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    2.440257] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.440261] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.440263] usb usb1: Product: xHCI Host Controller
[    2.440265] usb usb1: Manufacturer: Linux 5.17.0-12897-g9ae2a143081f xhci-hcd
[    2.440266] usb usb1: SerialNumber: 0000:00:14.0
[    2.440378] hub 1-0:1.0: USB hub found
[    2.440395] hub 1-0:1.0: 12 ports detected
[    2.449639] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.449647] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.449651] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.449697] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.17
[    2.449700] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.449702] usb usb2: Product: xHCI Host Controller
[    2.449704] usb usb2: Manufacturer: Linux 5.17.0-12897-g9ae2a143081f xhci-hcd
[    2.449706] usb usb2: SerialNumber: 0000:00:14.0
[    2.450353] hub 2-0:1.0: USB hub found
[    2.450367] hub 2-0:1.0: 6 ports detected
[    2.466469] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    2.690894] usb 1-5: new high-speed USB device number 2 using xhci_hcd
[    2.839446] usb 1-5: New USB device found, idVendor=1bcf, idProduct=28c0, bcdDevice=65.05
[    2.839458] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.839463] usb 1-5: Product: Integrated_Webcam_HD
[    2.839466] usb 1-5: Manufacturer: CN0F08KGLOG00858B6HJA02
[    2.964254] usb 1-6: new high-speed USB device number 3 using xhci_hcd
[    3.107811] usb 1-6: New USB device found, idVendor=0bda, idProduct=0129, bcdDevice=39.60
[    3.107827] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.107835] usb 1-6: Product: USB2.0-CRW
[    3.107841] usb 1-6: Manufacturer: Generic
[    3.107847] usb 1-6: SerialNumber: 20100201396000000
[    3.164354] EXT4-fs (sda3): mounted filesystem with ordered data mode. Quota mode: none.
[    3.230839] usb 1-7: new full-speed USB device number 4 using xhci_hcd
[    3.372376] usb 1-7: New USB device found, idVendor=0cf3, idProduct=e009, bcdDevice= 0.01
[    3.372383] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.601297] EXT4-fs (sda3): re-mounted. Quota mode: none.
[    4.033134] acpi INT33D5:00: intel-hid: created platform device
[    4.035688] Userspace governor deprecated: use thermal netlink notification instead
[    4.040758] input: Intel HID events as /devices/platform/INT33D5:00/input/input7
[    4.064964] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
[    4.096306] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    4.096945] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.105403] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    4.129478] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[    4.130875] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.130920] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    4.131040] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.131079] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.155567] ------------[ cut here ]------------
[    4.155571] xhci_hcd 0000:00:14.0: rejecting DMA map of vmalloc memory
[    4.155582] WARNING: CPU: 3 PID: 493 at include/linux/dma-mapping.h:326 usb_hcd_map_urb_for_dma+0x45b/0x480
[    4.155590] Modules linked in: mc(+) cfg80211(+) rtsx_usb(+) mdio_devres ecdh_generic irqbypass i2c_i801(+) snd psmouse processor_thermal_rapl mei_me sg pcspkr libphy crypto_user drm_ttm_helper intel_lpss_pci intel_xhci_usb_role_switch mei rfkill intel_lpss roles idma64 soundcore intel_pch_thermal intel_rapl_common i2c_smbus i2c_hid_acpi wmi i2c_hid intel_hid int3400_thermal int3403_thermal int3402_thermal mac_hid sparse_keymap int340x_thermal_zone acpi_thermal_rel acpi_pad ext4 crc32c_generic crc16 mbcache jbd2 serio_raw atkbd libps2 crc32c_intel xhci_pci xhci_pci_renesas i8042 serio i915 intel_gtt drm_buddy video drm_dp_helper ttm
[    4.155634] CPU: 3 PID: 493 Comm: udevd Not tainted 5.17.0-12897-g9ae2a143081f #2 ad54f11651c03b63d1f61e3fb0f3752635851a88
[    4.155638] Hardware name: Dell Inc. Inspiron 3576/0VD8XV, BIOS 1.16.0 12/16/2021
[    4.155639] RIP: 0010:usb_hcd_map_urb_for_dma+0x45b/0x480
[    4.155643] Code: 50 c6 05 a0 df fa 00 01 4d 85 e4 75 03 4d 8b 27 4c 89 ff e8 67 86 f4 ff 4c 89 e2 48 c7 c7 a0 12 ac ac 48 89 c6 e8 8e 89 2d 00 <0f> 0b e9 77 ff ff ff 48 8b 05 87 b1 e0 00 e9 e6 fe ff ff 48 8b 05
[    4.155646] RSP: 0018:ffffb86c80f7fa28 EFLAGS: 00010282
[    4.155648] RAX: 0000000000000000 RBX: ffff9b5945988600 RCX: c0000000ffffefff
[    4.155650] RDX: 0000000000000000 RSI: 00000000ffffefff RDI: 0000000000004ffb
[    4.155651] RBP: ffff9b5940c3e000 R08: 0000000000000000 R09: ffffb86c80f7f838
[    4.155653] R10: 0000000000000003 R11: ffffffffaccc9fe8 R12: ffff9b59413d7540
[    4.155654] R13: 000000000000000c R14: ffffb86c803c5000 R15: ffff9b5940d820d0
[    4.155876] FS:  00007fc63a2127c0(0000) GS:ffff9b5a97780000(0000) knlGS:0000000000000000
[    4.155879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.155880] CR2: 000056071b0470c8 CR3: 0000000100e3e003 CR4: 00000000003706e0
[    4.155882] Call Trace:
[    4.155885]  <TASK>
[    4.155887]  usb_hcd_submit_urb+0x7c/0xb30
[    4.155892]  ? __kmalloc+0x16d/0x370
[    4.155896]  usb_start_wait_urb+0x8a/0x180
[    4.155900]  rtsx_usb_send_cmd+0x58/0xa0 [rtsx_usb a989dcc4247852d419d89c90aa8a413a49a9f6f9]
[    4.155907]  rtsx_usb_probe+0x140/0x3a0 [rtsx_usb a989dcc4247852d419d89c90aa8a413a49a9f6f9]
[    4.155913]  usb_probe_interface+0xe2/0x2b0
[    4.155916]  really_probe+0x1a1/0x370
[    4.155920]  __driver_probe_device+0xfc/0x170
[    4.156140]  driver_probe_device+0x1f/0x90
[    4.156145]  __driver_attach+0xbb/0x190
[    4.156148]  ? __device_attach_driver+0xe0/0xe0
[    4.156151]  bus_for_each_dev+0x83/0xc0
[    4.156155]  bus_add_driver+0x14e/0x1f0
[    4.156158]  driver_register+0x89/0xd0
[    4.156161]  usb_register_driver+0x84/0x120
[    4.156165]  ? 0xffffffffc0568000
[    4.156168]  do_one_initcall+0x59/0x220
[    4.156172]  do_init_module+0x4a/0x230
[    4.156176]  __do_sys_init_module+0x138/0x1b0
[    4.156180]  do_syscall_64+0x5b/0x80
[    4.156184]  ? ksys_read+0x6b/0xf0
[    4.156187]  ? syscall_exit_to_user_mode+0x22/0x40
[    4.156190]  ? do_syscall_64+0x67/0x80
[    4.156192]  ? exc_page_fault+0x70/0x170
[    4.156196]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    4.156199] RIP: 0033:0x7fc63a11299e
[    4.156202] Code: 48 8b 0d fd a3 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ca a3 0e 00 f7 d8 64 89 01 48
[    4.156204] RSP: 002b:00007ffedb1ea5e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    4.156207] RAX: ffffffffffffffda RBX: 000056071b030d70 RCX: 00007fc63a11299e
[    4.156209] RDX: 00007fc63a2d8343 RSI: 000000000000926e RDI: 00007fc639b94010
[    4.156589] RBP: 00007fc63a2d8343 R08: 27d4eb2f165667c5 R09: 85ebca77c2b2ae63
[    4.156591] R10: 00007fc63a10768b R11: 0000000000000246 R12: 0000000000020000
[    4.156593] R13: 000056071b03cee0 R14: 000056071b030d70 R15: 000056071b03e9c0
[    4.156596]  </TASK>
[    4.156597] ---[ end trace 0000000000000000 ]---
[    4.161081] mc: Linux media interface: v0.10
[    4.161409] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.164159] rtsx_usb: probe of 1-6:1.0 failed with error -11
[    4.164189] usbcore: registered new interface driver rtsx_usb
[    4.171018] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.171035] i2c i2c-5: 1/2 memory slots populated (from DMI)
[    4.171721] i2c i2c-5: Successfully instantiated SPD at 0x50
[    4.172131] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    4.172136] cfg80211: failed to load regulatory.db
[    4.228509] input: DELL083F:00 04F3:3088 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DELL083F:00/0018:04F3:3088.0001/input/input10
[    4.228572] input: DELL083F:00 04F3:3088 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DELL083F:00/0018:04F3:3088.0001/input/input11
[    4.228626] hid-generic 0018:04F3:3088.0001: input,hidraw0: I2C HID v1.00 Mouse [DELL083F:00 04F3:3088] on i2c-DELL083F:00
[    4.248731] device-mapper: uevent: version 1.0.3
[    4.248793] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    4.259710] videodev: Linux video capture interface: v2.00
[    4.260083] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    4.260085] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.260087] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.260088] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    4.260089] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    4.260090] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    4.272267] intel_rapl_common: Found RAPL domain package
[    4.272271] intel_rapl_common: Found RAPL domain core
[    4.272272] intel_rapl_common: Found RAPL domain uncore
[    4.272273] intel_rapl_common: Found RAPL domain dram
[    4.272274] intel_rapl_common: Found RAPL domain psys
[    4.288912] Bluetooth: Core ver 2.22
[    4.288937] NET: Registered PF_BLUETOOTH protocol family
[    4.288938] Bluetooth: HCI device and connection manager initialized
[    4.288942] Bluetooth: HCI socket layer initialized
[    4.288946] Bluetooth: L2CAP socket layer initialized
[    4.288949] Bluetooth: SCO socket layer initialized
[    4.298485] VFIO - User Level meta-driver version: 0.3
[    4.322739] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
[    4.337690] r8169 0000:02:00.0 eth0: RTL8106e, 54:48:10:c2:64:6b, XID 449, IRQ 129
[    4.339871] cryptd: max_cpu_qlen set to 1000
[    4.347896] iTCO_vendor_support: vendor-support=0
[    4.353951] intel_rapl_common: Found RAPL domain package
[    4.353955] intel_rapl_common: Found RAPL domain dram
[    4.365779] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    4.381948] AVX2 version of gcm_enc/dec engaged.
[    4.381979] AES CTR mode by8 optimization enabled
[    4.383228] ee1004 5-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[    4.408970] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[    4.415985] usbcore: registered new interface driver btusb
[    4.417496] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    4.430320] input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input13
[    4.437608] input: DELL083F:00 04F3:3088 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DELL083F:00/0018:04F3:3088.0001/input/input14
[    4.437717] input: DELL083F:00 04F3:3088 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DELL083F:00/0018:04F3:3088.0001/input/input15
[    4.437850] hid-multitouch 0018:04F3:3088.0001: input,hidraw0: I2C HID v1.00 Mouse [DELL083F:00 04F3:3088] on i2c-DELL083F:00
[    4.444226] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (1bcf:28c0)
[    4.462941] input: Integrated_Webcam_HD: Integrate as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input17
[    4.463008] usbcore: registered new interface driver uvcvideo
[    4.483740] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    4.574583] mousedev: PS/2 mouse device common for all mice
[    4.586210] ath10k_pci 0000:03:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    4.587579] vfio_pci: add [1002:6665[ffffffff:ffffffff]] class 0x000000/00000000
[    4.598155] psmouse serio1: elantech: assuming hardware version 4 (with firmware version 0x4f1001)
[    4.598363] psmouse serio1: elantech: elantech_send_cmd query 0x02 failed.
[    4.598365] psmouse serio1: elantech: failed to query capabilities.
[    4.653416] intel_tcc_cooling: Programmable TCC Offset detected
[    4.654515] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3204: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.654520] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.654523] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    4.654525] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.654527] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.654529] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[    4.654531] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
[    4.654532] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[    4.669463] [drm] radeon kernel modesetting enabled.
[    4.669482] vga_switcheroo: detected switching method \_SB_.PCI0.RP01.PEGP.ATPX handle
[    4.669598] ATPX version 1, functions 0x00000003
[    4.669672] ATPX Hybrid Graphics
[    4.723602] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[    4.723657] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[    4.723699] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[    4.723740] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
[    4.723778] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
[    4.723815] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input23
[    4.886639] ath10k_pci 0000:03:00.0: qca9377 hw1.1 target 0x05020001 chip_id 0x003821ff sub 1028:1810
[    4.886645] ath10k_pci 0000:03:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 0 testmode 0
[    4.887098] ath10k_pci 0000:03:00.0: firmware ver WLAN.TF.2.1-00021-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32 42e41877
[    4.956184] ath10k_pci 0000:03:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
[    5.092503] [drm] amdgpu kernel modesetting enabled.
[    5.092521] amdgpu: vga_switcheroo: detected switching method \_SB_.PCI0.RP01.PEGP.ATPX handle
[    5.092636] ATPX version 1, functions 0x00000003
[    5.092712] ATPX Hybrid Graphics
[    5.092940] amdgpu: CRAT table not found
[    5.092942] amdgpu: Virtual CRAT table created for CPU
[    5.092961] amdgpu: Topology: Add CPU node
[    5.109083] ath10k_pci 0000:03:00.0: htt-ver 3.56 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    5.180937] ath: EEPROM regdomain: 0x6c
[    5.180940] ath: EEPROM indicates we should expect a direct regpair map
[    5.180941] ath: Country alpha2 being used: 00
[    5.180941] ath: Regpair used: 0x6c
[    6.040795] psmouse serio1: Failed to enable mouse on isa0060/serio1
[    6.853260] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input9
[    6.984731] EXT4-fs (sda3): re-mounted. Quota mode: none.
[    7.037865] EXT4-fs (sda4): mounted filesystem with ordered data mode. Quota mode: none.
[    7.041411] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
[    7.041422] ext4 filesystem being mounted at /boot supports timestamps until 2038 (0x7fffffff)
[    7.143402] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Quota mode: none.
[    7.234264] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Quota mode: none.
[    7.261548] Adding 8388604k swap on /dev/sda2.  Priority:-2 extents:1 across:8388604k SSFS
[    7.638336] RTL8208 Fast Ethernet r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[    7.911765] r8169 0000:02:00.0 eth0: Link is Down
[    8.308671] wlan0: authenticate with 7c:9a:54:0f:43:a5
[    8.308710] wlan0: bad VHT capabilities, disabling VHT
[    8.308714] wlan0: 80 MHz not supported, disabling VHT
[    8.341737] wlan0: send auth to 7c:9a:54:0f:43:a5 (try 1/3)
[    8.343510] wlan0: authenticated
[    8.344160] wlan0: associate with 7c:9a:54:0f:43:a5 (try 1/3)
[    8.348192] wlan0: RX AssocResp from 7c:9a:54:0f:43:a5 (capab=0x1411 status=0 aid=2)
[    8.350826] wlan0: associated
[    8.461392] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[    8.571416] elogind[955]: New seat seat0.
[    8.575817] elogind[955]: Watching system buttons on /dev/input/event3 (Power Button)
[    8.576689] elogind[955]: Watching system buttons on /dev/input/event1 (Power Button)
[    8.579091] elogind[955]: Watching system buttons on /dev/input/event0 (Lid Switch)
[    8.579270] elogind[955]: Watching system buttons on /dev/input/event2 (Sleep Button)
[    8.580752] elogind[955]: Watching system buttons on /dev/input/event6 (Intel HID events)
[    8.581144] elogind[955]: Watching system buttons on /dev/input/event5 (AT Translated Set 2 keyboard)
[   10.328897] elogind[955]: New session 1 of user aleksa.
[   10.686261] r8169 0000:02:00.0: invalid VPD tag 0xff (size 0) at offset 0; assume missing optional EEPROM
[   10.694293] L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="full_dmesg_good.log"

[    0.000000] Linux version 5.17.0-12883-g37fcacb50be7 (aleksa@artix) (gcc (GCC) 12.1.0, GNU ld (GNU Binutils) 2.38) #1 SMP PREEMPT_DYNAMIC Fri Jul 8 12:44:43 CEST 2022
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux5.17.0 root=UUID=d1b5bfc8-4be8-4d91-acd8-77673ad934a3 rw loglevel=3 pci=noaer intel_iommu=on vfio-pci.ids=1002:6665
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 2032
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000090f51fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000090f52000-0x0000000090f52fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000090f53000-0x000000009849cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009849d000-0x00000000984dafff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000984db000-0x0000000098e26fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000098e27000-0x000000009f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000025f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: Dell Inc. Inspiron 3576/0VD8XV, BIOS 1.16.0 12/16/2021
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.000000] tsc: Detected 2699.909 MHz TSC
[    0.000552] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000555] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000560] last_pfn = 0x25f800 max_arch_pfn = 0x400000000
[    0.000678] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001336] last_pfn = 0x90f52 max_arch_pfn = 0x400000000
[    0.008036] found SMP MP-table at [mem 0x000fcf70-0x000fcf7f]
[    0.008051] Using GB pages for direct mapping
[    0.008358] RAMDISK: [mem 0x36df7000-0x376f2fff]
[    0.008361] ACPI: Early table checksum verification disabled
[    0.008364] ACPI: RSDP 0x00000000000EEBA0 000024 (v02 DELL  )
[    0.008368] ACPI: XSDT 0x00000000984A90B8 0000EC (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008374] ACPI: FACP 0x00000000984CDE90 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.008378] ACPI: DSDT 0x00000000984A9230 024C5B (v02 DELL   CBX3     01072009 INTL 20160422)
[    0.008381] ACPI: FACS 0x0000000098E24180 000040
[    0.008384] ACPI: APIC 0x00000000984CDFA0 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.008386] ACPI: FPDT 0x00000000984CE028 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008389] ACPI: FIDT 0x00000000984CE070 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008391] ACPI: MCFG 0x00000000984CE120 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.008394] ACPI: HPET 0x00000000984CE160 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
[    0.008396] ACPI: SSDT 0x00000000984CE198 00036E (v01 SataRe SataTabl 00001000 INTL 20160422)
[    0.008399] ACPI: BOOT 0x00000000984CE508 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.008402] ACPI: SSDT 0x00000000984CE530 0012EA (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.008404] ACPI: HPET 0x00000000984CF820 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
[    0.008407] ACPI: SSDT 0x00000000984CF858 001176 (v02 INTEL  xh_OEMBD 00000000 INTL 20160422)
[    0.008409] ACPI: UEFI 0x00000000984D09D0 000042 (v01                 00000000      00000000)
[    0.008412] ACPI: SSDT 0x00000000984D0A18 0017AE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.008415] ACPI: LPIT 0x00000000984D21C8 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    0.008417] ACPI: WSMT 0x00000000984D2260 000028 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    0.008419] ACPI: SSDT 0x00000000984D2288 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.008422] ACPI: SSDT 0x00000000984D2528 000E3F (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.008425] ACPI: DBGP 0x00000000984D3368 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.008427] ACPI: DBG2 0x00000000984D33A0 000061 (v00 INTEL           00000002 MSFT 0000005F)
[    0.008429] ACPI: SSDT 0x00000000984D3408 0049C1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
[    0.008432] ACPI: SLIC 0x00000000984D7DD0 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    0.008435] ACPI: SSDT 0x00000000984D7F48 00069A (v02 SgRef  SgPch    00001000 INTL 20160422)
[    0.008437] ACPI: SSDT 0x00000000984D85E8 000281 (v02 SgRef  SgUlx    00001000 INTL 20160422)
[    0.008440] ACPI: SSDT 0x00000000984D8870 0017FF (v01 AmdRef AmdTabl  00001000 INTL 20160422)
[    0.008442] ACPI: DMAR 0x00000000984DA070 0000EC (v01 INTEL  EDK2     00000001 INTL 00000001)
[    0.008444] ACPI: Reserving FACP table memory at [mem 0x984cde90-0x984cdf9b]
[    0.008446] ACPI: Reserving DSDT table memory at [mem 0x984a9230-0x984cde8a]
[    0.008447] ACPI: Reserving FACS table memory at [mem 0x98e24180-0x98e241bf]
[    0.008448] ACPI: Reserving APIC table memory at [mem 0x984cdfa0-0x984ce023]
[    0.008449] ACPI: Reserving FPDT table memory at [mem 0x984ce028-0x984ce06b]
[    0.008449] ACPI: Reserving FIDT table memory at [mem 0x984ce070-0x984ce11b]
[    0.008450] ACPI: Reserving MCFG table memory at [mem 0x984ce120-0x984ce15b]
[    0.008451] ACPI: Reserving HPET table memory at [mem 0x984ce160-0x984ce197]
[    0.008452] ACPI: Reserving SSDT table memory at [mem 0x984ce198-0x984ce505]
[    0.008453] ACPI: Reserving BOOT table memory at [mem 0x984ce508-0x984ce52f]
[    0.008454] ACPI: Reserving SSDT table memory at [mem 0x984ce530-0x984cf819]
[    0.008454] ACPI: Reserving HPET table memory at [mem 0x984cf820-0x984cf857]
[    0.008455] ACPI: Reserving SSDT table memory at [mem 0x984cf858-0x984d09cd]
[    0.008456] ACPI: Reserving UEFI table memory at [mem 0x984d09d0-0x984d0a11]
[    0.008457] ACPI: Reserving SSDT table memory at [mem 0x984d0a18-0x984d21c5]
[    0.008458] ACPI: Reserving LPIT table memory at [mem 0x984d21c8-0x984d225b]
[    0.008459] ACPI: Reserving WSMT table memory at [mem 0x984d2260-0x984d2287]
[    0.008460] ACPI: Reserving SSDT table memory at [mem 0x984d2288-0x984d2526]
[    0.008460] ACPI: Reserving SSDT table memory at [mem 0x984d2528-0x984d3366]
[    0.008461] ACPI: Reserving DBGP table memory at [mem 0x984d3368-0x984d339b]
[    0.008462] ACPI: Reserving DBG2 table memory at [mem 0x984d33a0-0x984d3400]
[    0.008463] ACPI: Reserving SSDT table memory at [mem 0x984d3408-0x984d7dc8]
[    0.008464] ACPI: Reserving SLIC table memory at [mem 0x984d7dd0-0x984d7f45]
[    0.008465] ACPI: Reserving SSDT table memory at [mem 0x984d7f48-0x984d85e1]
[    0.008466] ACPI: Reserving SSDT table memory at [mem 0x984d85e8-0x984d8868]
[    0.008466] ACPI: Reserving SSDT table memory at [mem 0x984d8870-0x984da06e]
[    0.008467] ACPI: Reserving DMAR table memory at [mem 0x984da070-0x984da15b]
[    0.008564] No NUMA configuration found
[    0.008564] Faking a node at [mem 0x0000000000000000-0x000000025f7fffff]
[    0.008567] NODE_DATA(0) allocated [mem 0x25f7fa000-0x25f7fdfff]
[    0.008587] Zone ranges:
[    0.008588]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008590]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008591]   Normal   [mem 0x0000000100000000-0x000000025f7fffff]
[    0.008593]   Device   empty
[    0.008593] Movable zone start for each node
[    0.008594] Early memory node ranges
[    0.008595]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.008596]   node   0: [mem 0x0000000000100000-0x0000000090f51fff]
[    0.008597]   node   0: [mem 0x0000000100000000-0x000000025f7fffff]
[    0.008599] Initmem setup node 0 [mem 0x0000000000001000-0x000000025f7fffff]
[    0.008603] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.008648] On node 0, zone DMA: 100 pages in unavailable ranges
[    0.039710] On node 0, zone Normal: 28846 pages in unavailable ranges
[    0.039757] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.039771] Reserving Intel graphics memory at [mem 0x9b800000-0x9f7fffff]
[    0.039904] ACPI: PM-Timer IO Port: 0x1808
[    0.039911] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.039913] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.039913] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.039914] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.039940] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.039943] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.039945] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.039948] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.039949] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.039952] TSC deadline timer available
[    0.039953] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.039965] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.039967] PM: hibernation: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
[    0.039968] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.039969] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.039970] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.039971] PM: hibernation: Registered nosave memory: [mem 0x90f52000-0x90f52fff]
[    0.039972] PM: hibernation: Registered nosave memory: [mem 0x90f53000-0x9849cfff]
[    0.039973] PM: hibernation: Registered nosave memory: [mem 0x9849d000-0x984dafff]
[    0.039973] PM: hibernation: Registered nosave memory: [mem 0x984db000-0x98e26fff]
[    0.039974] PM: hibernation: Registered nosave memory: [mem 0x98e27000-0x9f7fffff]
[    0.039975] PM: hibernation: Registered nosave memory: [mem 0x9f800000-0xdfffffff]
[    0.039975] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.039976] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
[    0.039977] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.039977] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.039978] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.039979] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    0.039980] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.039980] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.039981] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.039982] [mem 0x9f800000-0xdfffffff] available for PCI devices
[    0.039983] Booting paravirtualized kernel on bare hardware
[    0.039986] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.044789] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:4 nr_node_ids:1
[    0.045004] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
[    0.045010] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
[    0.045012] pcpu-alloc: [0] 0 1 2 3 
[    0.045045] Fallback order for Node 0: 0 
[    0.045048] Built 1 zonelists, mobility grouping on.  Total pages: 2001460
[    0.045049] Policy zone: Normal
[    0.045050] Kernel command line: BOOT_IMAGE=/vmlinuz-linux5.17.0 root=UUID=d1b5bfc8-4be8-4d91-acd8-77673ad934a3 rw loglevel=3 pci=noaer intel_iommu=on vfio-pci.ids=1002:6665
[    0.045114] DMAR: IOMMU enabled
[    0.045128] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-linux5.17.0", will be passed to user space.
[    0.045956] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.046385] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.046670] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.101888] Memory: 7877860K/8133556K available (14343K kernel code, 2059K rwdata, 6096K rodata, 1772K init, 3536K bss, 255436K reserved, 0K cma-reserved)
[    0.101896] random: get_random_u64 called from __kmem_cache_create+0x2a/0x500 with crng_init=0
[    0.102006] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.102024] Kernel/User page tables isolation: enabled
[    0.102057] ftrace: allocating 43981 entries in 172 pages
[    0.109417] ftrace: allocated 172 pages with 4 groups
[    0.109524] Dynamic Preempt: full
[    0.109550] rcu: Preemptible hierarchical RCU implementation.
[    0.109551] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=4.
[    0.109552] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.109553] 	Trampoline variant of Tasks RCU enabled.
[    0.109553] 	Rude variant of Tasks RCU enabled.
[    0.109554] 	Tracing variant of Tasks RCU enabled.
[    0.109555] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    0.109556] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.113090] NR_IRQS: 20736, nr_irqs: 1024, preallocated irqs: 16
[    0.113479] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.113506] random: crng init done (trusting CPU's manufacturer)
[    0.113541] spurious 8259A interrupt: IRQ7.
[    0.113565] Console: colour dummy device 80x25
[    0.113577] printk: console [tty0] enabled
[    0.113595] ACPI: Core revision 20211217
[    0.113840] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.113943] APIC: Switch to symmetric I/O mode setup
[    0.113945] DMAR: Host address width 39
[    0.113946] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.113951] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.113953] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.113956] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.113958] DMAR: RMRR base: 0x000000981f1000 end: 0x00000098210fff
[    0.113961] DMAR: RMRR base: 0x00000098ff2000 end: 0x0000009923bfff
[    0.113962] DMAR: RMRR base: 0x0000009b000000 end: 0x0000009f7fffff
[    0.113962] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.113965] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.113966] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.113967] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.116128] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.116130] x2apic enabled
[    0.116142] Switched APIC routing to cluster x2apic.
[    0.120208] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.133970] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x26eae8729ef, max_idle_ns: 440795235156 ns
[    0.133974] Calibrating delay loop (skipped), value calculated using timer frequency.. 5401.81 BogoMIPS (lpj=8999696)
[    0.133977] pid_max: default: 32768 minimum: 301
[    0.133998] LSM: Security Framework initializing
[    0.134004] landlock: Up and running.
[    0.134005] Yama: becoming mindful.
[    0.134013] LSM support for eBPF active
[    0.134054] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.134082] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.134297] x86/cpu: SGX disabled by BIOS.
[    0.134303] CPU0: Thermal monitoring enabled (TM1)
[    0.134353] process: using mwait in idle threads
[    0.134361] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.134362] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.134377] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.134381] Spectre V2 : Mitigation: Retpolines
[    0.134381] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.134382] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.134383] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.134384] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.134385] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.134391] SRBDS: Mitigation: Microcode
[    0.134392] MDS: Mitigation: Clear CPU buffers
[    0.136755] Freeing SMP alternatives memory: 36K
[    0.137306] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1175
[    0.137306] smpboot: CPU0: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.137306] cblist_init_generic: Setting adjustable number of callback queues.
[    0.137306] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.137306] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.137306] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.137306] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.137306] ... version:                4
[    0.137306] ... bit width:              48
[    0.137306] ... generic registers:      4
[    0.137306] ... value mask:             0000ffffffffffff
[    0.137306] ... max period:             00007fffffffffff
[    0.137306] ... fixed-purpose events:   3
[    0.137306] ... event mask:             000000070000000f
[    0.137306] rcu: Hierarchical SRCU implementation.
[    0.137306] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.137306] smp: Bringing up secondary CPUs ...
[    0.137306] x86: Booting SMP configuration:
[    0.137306] .... node  #0, CPUs:      #1 #2
[    0.137306] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.137306]  #3
[    0.137306] smp: Brought up 1 node, 4 CPUs
[    0.137306] smpboot: Max logical packages: 1
[    0.137306] smpboot: Total of 4 processors activated (21607.24 BogoMIPS)
[    0.137597] devtmpfs: initialized
[    0.137597] x86/mm: Memory block size: 128MB
[    0.137823] ACPI: PM: Registering ACPI NVS region [mem 0x90f52000-0x90f52fff] (4096 bytes)
[    0.137823] ACPI: PM: Registering ACPI NVS region [mem 0x984db000-0x98e26fff] (9748480 bytes)
[    0.137823] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.137823] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.137823] pinctrl core: initialized pinctrl subsystem
[    0.137823] PM: RTC time: 11:16:52, date: 2022-07-08
[    0.138036] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.138229] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.138357] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.138489] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.138511] audit: initializing netlink subsys (disabled)
[    0.138531] audit: type=2000 audit(1657279012.023:1): state=initialized audit_enabled=0 res=1
[    0.138531] thermal_sys: Registered thermal governor 'fair_share'
[    0.138531] thermal_sys: Registered thermal governor 'bang_bang'
[    0.138531] thermal_sys: Registered thermal governor 'step_wise'
[    0.138531] thermal_sys: Registered thermal governor 'user_space'
[    0.138531] thermal_sys: Registered thermal governor 'power_allocator'
[    0.138531] cpuidle: using governor ladder
[    0.138531] cpuidle: using governor menu
[    0.138531] Simple Boot Flag at 0x47 set to 0x80
[    0.138531] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.138531] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.138531] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.138531] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.138531] PCI: Using configuration type 1 for base access
[    0.138531] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.140882] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.140887] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.140887] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.140887] ACPI: Added _OSI(Module Device)
[    0.140887] ACPI: Added _OSI(Processor Device)
[    0.140887] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.140887] ACPI: Added _OSI(Processor Aggregator Device)
[    0.140887] ACPI: Added _OSI(Linux-Dell-Video)
[    0.140887] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.140887] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.179202] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.183299] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.190412] ACPI: Dynamic OEM Table Load:
[    0.190418] ACPI: SSDT 0xFFFF8D1340DB3800 0006B4 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    0.191477] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.192500] ACPI: Dynamic OEM Table Load:
[    0.192505] ACPI: SSDT 0xFFFF8D13403A2400 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    0.193472] ACPI: Dynamic OEM Table Load:
[    0.193476] ACPI: SSDT 0xFFFF8D1340EFEC00 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160422)
[    0.194387] ACPI: Dynamic OEM Table Load:
[    0.194391] ACPI: SSDT 0xFFFF8D1340DB0000 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160422)
[    0.195663] ACPI: Dynamic OEM Table Load:
[    0.195669] ACPI: SSDT 0xFFFF8D1340127000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160422)
[    0.197324] ACPI: Dynamic OEM Table Load:
[    0.197328] ACPI: SSDT 0xFFFF8D13403A0C00 000317 (v02 PmRef  ApHwp    00003000 INTL 20160422)
[    0.198339] ACPI: Dynamic OEM Table Load:
[    0.198343] ACPI: SSDT 0xFFFF8D13403A3800 00030A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.200538] ACPI: EC: EC started
[    0.200539] ACPI: EC: interrupt blocked
[    0.205392] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.205394] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions
[    0.205395] ACPI: Interpreter enabled
[    0.205434] ACPI: PM: (supports S0 S3 S4 S5)
[    0.205435] ACPI: Using IOAPIC for interrupt routing
[    0.205474] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.206110] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.210449] ACPI: PM: Power Resource [PC01]
[    0.231139] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.231147] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.232524] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
[    0.232526] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.233246] PCI host bridge to bus 0000:00
[    0.233248] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.233250] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.233251] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.233252] pci_bus 0000:00: root bus resource [mem 0x9f800000-0xdfffffff window]
[    0.233254] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.233255] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.233268] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    0.233333] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    0.233342] pci 0000:00:02.0: reg 0x10: [mem 0xd1000000-0xd1ffffff 64bit]
[    0.233348] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.233352] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.233369] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.233518] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.233528] pci 0000:00:04.0: reg 0x10: [mem 0xd2320000-0xd2327fff 64bit]
[    0.233826] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.233843] pci 0000:00:14.0: reg 0x10: [mem 0xd2310000-0xd231ffff 64bit]
[    0.233905] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.234497] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.234514] pci 0000:00:14.2: reg 0x10: [mem 0xd2337000-0xd2337fff 64bit]
[    0.234628] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.234650] pci 0000:00:15.0: reg 0x10: [mem 0xd2336000-0xd2336fff 64bit]
[    0.234964] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.234985] pci 0000:00:16.0: reg 0x10: [mem 0xd2335000-0xd2335fff 64bit]
[    0.235056] pci 0000:00:16.0: PME# supported from D3hot
[    0.235417] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    0.235431] pci 0000:00:17.0: reg 0x10: [mem 0xd2330000-0xd2331fff]
[    0.235438] pci 0000:00:17.0: reg 0x14: [mem 0xd2334000-0xd23340ff]
[    0.235445] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    0.235452] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    0.235459] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    0.235466] pci 0000:00:17.0: reg 0x24: [mem 0xd2333000-0xd23337ff]
[    0.235505] pci 0000:00:17.0: PME# supported from D3hot
[    0.235758] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.235826] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.235842] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
[    0.236306] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.236376] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.236394] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    0.236837] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    0.236906] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.236924] pci 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
[    0.237418] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.237707] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.237721] pci 0000:00:1f.2: reg 0x10: [mem 0xd232c000-0xd232ffff]
[    0.237981] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.238003] pci 0000:00:1f.3: reg 0x10: [mem 0xd2328000-0xd232bfff 64bit]
[    0.238035] pci 0000:00:1f.3: reg 0x20: [mem 0xd2300000-0xd230ffff 64bit]
[    0.238083] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.238789] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.238846] pci 0000:00:1f.4: reg 0x10: [mem 0xd2332000-0xd23320ff 64bit]
[    0.238916] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.239237] pci 0000:01:00.0: [1002:6665] type 00 class 0x038000
[    0.239254] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.239265] pci 0000:01:00.0: reg 0x18: [mem 0xd0000000-0xd003ffff 64bit]
[    0.239272] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.239285] pci 0000:01:00.0: reg 0x30: [mem 0xd0040000-0xd005ffff pref]
[    0.239292] pci 0000:01:00.0: enabling Extended Tags
[    0.239344] pci 0000:01:00.0: supports D1 D2
[    0.239344] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.239379] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1c.0 (capable of 63.008 Gb/s with 8.0 GT/s PCIe x8 link)
[    0.239440] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.239443] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.239445] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xd00fffff]
[    0.239509] pci 0000:02:00.0: [10ec:8136] type 00 class 0x020000
[    0.239528] pci 0000:02:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.239553] pci 0000:02:00.0: reg 0x18: [mem 0xd2204000-0xd2204fff 64bit]
[    0.239569] pci 0000:02:00.0: reg 0x20: [mem 0xd2200000-0xd2203fff 64bit pref]
[    0.239669] pci 0000:02:00.0: supports D1 D2
[    0.239670] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.239794] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.239796] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.239799] pci 0000:00:1c.4:   bridge window [mem 0xd2200000-0xd22fffff]
[    0.240101] pci 0000:03:00.0: [168c:0042] type 00 class 0x028000
[    0.240326] pci 0000:03:00.0: reg 0x10: [mem 0xd2000000-0xd21fffff 64bit]
[    0.241757] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.242799] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    0.242803] pci 0000:00:1c.5:   bridge window [mem 0xd2000000-0xd21fffff]
[    0.244654] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.244654] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.244697] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.244749] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.244800] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    0.244852] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    0.244904] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.244958] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.247707] ACPI: EC: interrupt unblocked
[    0.247708] ACPI: EC: event unblocked
[    0.247716] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.247717] ACPI: EC: GPE=0x6e
[    0.247718] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC initialization complete
[    0.247720] ACPI: \_SB_.PCI0.LPCB.ECDV: EC: Used to handle transactions and events
[    0.247777] iommu: Default domain type: Translated 
[    0.247778] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.247905] SCSI subsystem initialized
[    0.247913] libata version 3.00 loaded.
[    0.247913] ACPI: bus type USB registered
[    0.247913] usbcore: registered new interface driver usbfs
[    0.247913] usbcore: registered new interface driver hub
[    0.247913] usbcore: registered new device driver usb
[    0.247913] pps_core: LinuxPPS API ver. 1 registered
[    0.247913] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.247913] PTP clock support registered
[    0.247913] EDAC MC: Ver: 3.0.0
[    0.247913] NetLabel: Initializing
[    0.247913] NetLabel:  domain hash size = 128
[    0.247913] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.247913] NetLabel:  unlabeled traffic allowed by default
[    0.247913] mctp: management component transport protocol core
[    0.247913] NET: Registered PF_MCTP protocol family
[    0.247913] PCI: Using ACPI for IRQ routing
[    0.274632] PCI: pci_cache_line_size set to 64 bytes
[    0.274968] e820: reserve RAM buffer [mem 0x0009c400-0x0009ffff]
[    0.274970] e820: reserve RAM buffer [mem 0x90f52000-0x93ffffff]
[    0.274971] e820: reserve RAM buffer [mem 0x25f800000-0x25fffffff]
[    0.277314] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.277314] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.277314] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.277317] vgaarb: loaded
[    0.277347] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.277353] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.279428] clocksource: Switched to clocksource tsc-early
[    0.284526] VFS: Disk quotas dquot_6.6.0
[    0.284542] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.284631] pnp: PnP ACPI init
[    0.285025] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.285029] system 00:00: [io  0xffff] has been reserved
[    0.285032] system 00:00: [io  0xffff] has been reserved
[    0.285034] system 00:00: [io  0xffff] has been reserved
[    0.285036] system 00:00: [io  0x1800-0x18fe] has been reserved
[    0.285038] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.285220] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.285641] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.285644] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.285647] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.285649] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.285652] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.285654] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.285656] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.285659] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.285661] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.285664] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    0.285721] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.285724] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.285726] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.285728] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.285731] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.285734] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.285736] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.286100] system 00:07: [io  0xff00-0xfffe] has been reserved
[    0.287656] system 00:08: [mem 0xfe035000-0xfe035fff] has been reserved
[    0.287660] system 00:08: [mem 0xfe034008-0xfe034fff] has been reserved
[    0.288410] system 00:09: [mem 0xfe034000-0xfe034007] has been reserved
[    0.290431] pnp: PnP ACPI: found 10 devices
[    0.295862] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.295908] NET: Registered PF_INET protocol family
[    0.295996] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.296813] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.296865] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.297025] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.297091] TCP: Hash tables configured (established 65536 bind 65536)
[    0.297150] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.297182] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.297206] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.297243] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.297247] NET: Registered PF_XDP protocol family
[    0.297264] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.297268] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.297272] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xd00fffff]
[    0.297277] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.297279] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.297282] pci 0000:00:1c.4:   bridge window [mem 0xd2200000-0xd22fffff]
[    0.297287] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    0.297290] pci 0000:00:1c.5:   bridge window [mem 0xd2000000-0xd21fffff]
[    0.297296] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.297297] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.297298] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.297300] pci_bus 0000:00: resource 7 [mem 0x9f800000-0xdfffffff window]
[    0.297301] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    0.297302] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.297303] pci_bus 0000:01: resource 1 [mem 0xc0000000-0xd00fffff]
[    0.297304] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.297305] pci_bus 0000:02: resource 1 [mem 0xd2200000-0xd22fffff]
[    0.297320] pci_bus 0000:03: resource 1 [mem 0xd2000000-0xd21fffff]
[    0.298458] PCI: CLS 0 bytes, default 64
[    0.298473] DMAR: ACPI device "device:6a" under DMAR at fed91000 as 00:15.0
[    0.298484] DMAR: No ATSR found
[    0.298485] DMAR: No SATC found
[    0.298487] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.298488] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.298489] DMAR: IOMMU feature nwfs inconsistent
[    0.298490] DMAR: IOMMU feature pasid inconsistent
[    0.298491] DMAR: IOMMU feature eafs inconsistent
[    0.298491] DMAR: IOMMU feature prs inconsistent
[    0.298492] DMAR: IOMMU feature nest inconsistent
[    0.298493] DMAR: IOMMU feature mts inconsistent
[    0.298493] DMAR: IOMMU feature sc_support inconsistent
[    0.298494] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.298495] DMAR: dmar0: Using Queued invalidation
[    0.298499] DMAR: dmar1: Using Queued invalidation
[    0.298519] Unpacking initramfs...
[    0.298818] pci 0000:00:00.0: Adding to iommu group 0
[    0.298833] pci 0000:00:02.0: Adding to iommu group 1
[    0.298848] pci 0000:00:04.0: Adding to iommu group 2
[    0.298871] pci 0000:00:14.0: Adding to iommu group 3
[    0.298882] pci 0000:00:14.2: Adding to iommu group 3
[    0.298895] pci 0000:00:15.0: Adding to iommu group 4
[    0.298913] pci 0000:00:16.0: Adding to iommu group 5
[    0.298928] pci 0000:00:17.0: Adding to iommu group 6
[    0.298944] pci 0000:00:1c.0: Adding to iommu group 7
[    0.298959] pci 0000:00:1c.4: Adding to iommu group 8
[    0.298972] pci 0000:00:1c.5: Adding to iommu group 9
[    0.299003] pci 0000:00:1f.0: Adding to iommu group 10
[    0.299017] pci 0000:00:1f.2: Adding to iommu group 10
[    0.299032] pci 0000:00:1f.3: Adding to iommu group 10
[    0.299043] pci 0000:00:1f.4: Adding to iommu group 10
[    0.299054] pci 0000:01:00.0: Adding to iommu group 11
[    0.299067] pci 0000:02:00.0: Adding to iommu group 12
[    0.299078] pci 0000:03:00.0: Adding to iommu group 13
[    0.301241] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.301246] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.301247] software IO TLB: mapped [mem 0x000000008cf52000-0x0000000090f52000] (64MB)
[    0.301923] Initialise system trusted keyrings
[    0.301933] Key type blacklist registered
[    0.301968] workingset: timestamp_bits=41 max_order=21 bucket_order=0
[    0.303555] zbud: loaded
[    0.303794] integrity: Platform Keyring initialized
[    0.311192] Key type asymmetric registered
[    0.311197] Asymmetric key parser 'x509' registered
[    0.342942] Freeing initrd memory: 9200K
[    0.345248] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    0.345270] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
[    0.345296] io scheduler mq-deadline registered
[    0.345297] io scheduler kyber registered
[    0.345322] io scheduler bfq registered
[    0.345753] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.345928] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    0.346089] pcieport 0000:00:1c.5: PME: Signaling with IRQ 124
[    0.346160] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.347061] ACPI: AC: AC Adapter [AC] (on-line)
[    0.347106] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.347130] ACPI: button: Lid Switch [LID0]
[    0.347184] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.347201] ACPI: button: Power Button [PBTN]
[    0.347218] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.347229] ACPI: button: Sleep Button [SBTN]
[    0.347247] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.347262] ACPI: button: Power Button [PWRF]
[    0.347392] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1175
[    0.349296] thermal LNXTHERM:00: registered as thermal_zone0
[    0.349298] ACPI: thermal: Thermal Zone [THM] (25 C)
[    0.349442] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.354855] Non-volatile memory driver v1.3
[    0.354857] Linux agpgart interface v0.103
[    0.354859] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[    0.354879] ACPI: bus type drm_connector registered
[    0.355927] ahci 0000:00:17.0: version 3.0
[    0.356673] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
[    0.356692] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    0.356696] ahci 0000:00:17.0: flags: 64bit ncq stag pm led clo only pio slum part deso sadm sds apst 
[    0.356919] scsi host0: ahci
[    0.357020] scsi host1: ahci
[    0.357043] ata1: SATA max UDMA/133 abar m2048@0xd2333000 port 0xd2333100 irq 125
[    0.357046] ata2: SATA max UDMA/133 abar m2048@0xd2333000 port 0xd2333180 irq 125
[    0.357081] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.357083] ehci-pci: EHCI PCI platform driver
[    0.357091] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.357092] ohci-pci: OHCI PCI platform driver
[    0.357098] uhci_hcd: USB Universal Host Controller Interface driver
[    0.357122] usbcore: registered new interface driver usbserial_generic
[    0.357125] usbserial: USB Serial support registered for generic
[    0.357201] rtc_cmos 00:01: RTC can wake from S4
[    0.358117] rtc_cmos 00:01: registered as rtc0
[    0.358272] rtc_cmos 00:01: setting system clock to 2022-07-08T11:16:52 UTC (1657279012)
[    0.358284] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.358344] intel_pstate: Intel P-state driver initializing
[    0.358643] intel_pstate: HWP enabled
[    0.358689] ledtrig-cpu: registered to indicate activity on CPUs
[    0.359014] vesafb: mode is 1920x1080x32, linelength=7680, pages=0
[    0.359016] vesafb: scrolling: redraw
[    0.359016] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.359025] vesafb: framebuffer at 0xb0000000, mapped to 0x00000000a652891d, using 8128k, total 8128k
[    0.359051] fbcon: Deferring console take-over
[    0.359052] fb0: VESA VGA frame buffer device
[    0.359061] hid: raw HID events driver (C) Jiri Kosina
[    0.359134] intel_pmc_core INT33A1:00:  initialized
[    0.359203] drop_monitor: Initializing network drop monitor service
[    0.359257] Initializing XFRM netlink socket
[    0.359325] NET: Registered PF_INET6 protocol family
[    0.362338] Segment Routing with IPv6
[    0.362341] RPL Segment Routing with IPv6
[    0.362353] In-situ OAM (IOAM) with IPv6
[    0.362381] NET: Registered PF_PACKET protocol family
[    0.363077] microcode: sig=0x806e9, pf=0x80, revision=0xec
[    0.363092] microcode: Microcode Update Driver: v2.2.
[    0.363098] IPI shorthand broadcast: enabled
[    0.363111] sched_clock: Marking stable (362370112, 595742)->(369601694, -6635840)
[    0.363948] registered taskstats version 1
[    0.364108] Loading compiled-in X.509 certificates
[    0.367036] Loaded X.509 cert 'Build time autogenerated kernel key: 660ea857a76fbc7b77d5a539eca5f26c69d9f91e'
[    0.367215] zswap: loaded using pool lz4/z3fold
[    0.367569] Key type ._fscrypt registered
[    0.367572] Key type .fscrypt registered
[    0.367573] Key type fscrypt-provisioning registered
[    0.368653] PM:   Magic number: 14:491:276
[    0.368681] tty tty13: hash matches
[    0.368689] platform INT3400:00: hash matches
[    0.368695] acpi INT3400:00: hash matches
[    0.368794] RAS: Correctable Errors collector initialized.
[    0.375921] ACPI: battery: Slot [BAT0] (battery present)
[    0.672007] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.673376] ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.673384] ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.673683] ata1.00: ATA-11: TOSHIBA KSG60ZMV256G M.2 2280 256GB, ABDA4102, max UDMA/100
[    0.673848] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    0.674637] ata1.00: Features: Dev-Sleep
[    0.676062] ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.676070] ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.677187] ata1.00: configured for UDMA/100
[    0.677511] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA KSG60ZMV 4102 PQ: 0 ANSI: 5
[    0.678105] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    0.678110] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.678119] sd 0:0:0:0: [sda] Write Protect is off
[    0.678122] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.678135] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.694688]  sda: sda1 sda2 sda3 sda4
[    0.711305] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.991991] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.994093] ata2.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.994102] ata2.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.995011] ata2.00: ATA-8: HGST HTS545050A7E680, GG2OAF10, max UDMA/133
[    0.995496] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    0.997769] ata2.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    0.997778] ata2.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    0.998772] ata2.00: configured for UDMA/133
[    0.998916] scsi 1:0:0:0: Direct-Access     ATA      HGST HTS545050A7 AF10 PQ: 0 ANSI: 5
[    0.999654] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    0.999660] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    0.999737] sd 1:0:0:0: [sdb] Write Protect is off
[    0.999743] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.999852] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.310773] tsc: Refined TSC clocksource calibration: 2711.999 MHz
[    1.310785] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x271785701be, max_idle_ns: 440795203568 ns
[    1.310842] clocksource: Switched to clocksource tsc
[    1.981903]  sdb: sdb1 sdb2
[    1.997619] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.000011] Freeing unused decrypted memory: 2036K
[    2.000622] Freeing unused kernel image (initmem) memory: 1772K
[    2.000694] Write protecting the kernel read-only data: 22528k
[    2.001698] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    2.001853] Freeing unused kernel image (rodata/data gap) memory: 48K
[    2.049022] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.049026] rodata_test: all tests were successful
[    2.049028] x86/mm: Checking user space page tables
[    2.094180] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.094219] Run /init as init process
[    2.094221]   with arguments:
[    2.094222]     /init
[    2.094223]   with environment:
[    2.094223]     HOME=/
[    2.094224]     TERM=linux
[    2.094224]     BOOT_IMAGE=/vmlinuz-linux5.17.0
[    2.099190] fbcon: Taking over console
[    2.099251] Console: switching to colour frame buffer device 240x67
[    2.341585] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    2.341589] checking generic (b0000000 7f0000) vs hw (d1000000 1000000)
[    2.341591] checking generic (b0000000 7f0000) vs hw (b0000000 10000000)
[    2.341592] fb0: switching to i915 from VESA VGA
[    2.341758] Console: switching to colour dummy device 80x25
[    2.341798] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.341826] i915 0000:00:02.0: [drm] Transparent Hugepage mode 'huge=within_size'
[    2.344013] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.345651] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    2.413225] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    2.418096] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.419997] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    2.426475] fbcon: i915drmfb (fb0) is primary device
[    2.428407] Console: switching to colour frame buffer device 240x67
[    2.449634] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.570576] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    2.570909] i8042: Warning: Keylock active
[    2.572374] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.572415] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.583699] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.583707] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.584803] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    2.585197] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.585201] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.585203] usb usb1: Product: xHCI Host Controller
[    2.585205] usb usb1: Manufacturer: Linux 5.17.0-12883-g37fcacb50be7 xhci-hcd
[    2.585207] usb usb1: SerialNumber: 0000:00:14.0
[    2.585309] hub 1-0:1.0: USB hub found
[    2.585324] hub 1-0:1.0: 12 ports detected
[    2.587639] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.587644] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.587647] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.587687] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.17
[    2.587690] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.587693] usb usb2: Product: xHCI Host Controller
[    2.587694] usb usb2: Manufacturer: Linux 5.17.0-12883-g37fcacb50be7 xhci-hcd
[    2.587696] usb usb2: SerialNumber: 0000:00:14.0
[    2.587788] hub 2-0:1.0: USB hub found
[    2.587800] hub 2-0:1.0: 6 ports detected
[    2.604911] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    2.840727] usb 1-5: new high-speed USB device number 2 using xhci_hcd
[    2.989333] usb 1-5: New USB device found, idVendor=1bcf, idProduct=28c0, bcdDevice=65.05
[    2.989346] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.989351] usb 1-5: Product: Integrated_Webcam_HD
[    2.989355] usb 1-5: Manufacturer: CN0F08KGLOG00858B6HJA02
[    3.114017] usb 1-6: new high-speed USB device number 3 using xhci_hcd
[    3.254741] usb 1-6: New USB device found, idVendor=0bda, idProduct=0129, bcdDevice=39.60
[    3.254753] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.254758] usb 1-6: Product: USB2.0-CRW
[    3.254762] usb 1-6: Manufacturer: Generic
[    3.254765] usb 1-6: SerialNumber: 20100201396000000
[    3.377324] usb 1-7: new full-speed USB device number 4 using xhci_hcd
[    3.395628] EXT4-fs (sda3): mounted filesystem with ordered data mode. Quota mode: none.
[    3.519357] usb 1-7: New USB device found, idVendor=0cf3, idProduct=e009, bcdDevice= 0.01
[    3.519366] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.791689] EXT4-fs (sda3): re-mounted. Quota mode: none.
[    4.201336] acpi INT33D5:00: intel-hid: created platform device
[    4.201478] input: Intel HID events as /devices/platform/INT33D5:00/input/input7
[    4.210471] Userspace governor deprecated: use thermal netlink notification instead
[    4.224056] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
[    4.276188] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.276744] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    4.278010] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    4.291846] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    4.292285] device-mapper: uevent: version 1.0.3
[    4.293576] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    4.310445] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.310491] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.327697] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.337358] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.337780] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[    4.339215] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.341102] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    4.341109] cfg80211: failed to load regulatory.db
[    4.346923] i2c i2c-4: 1/2 memory slots populated (from DMI)
[    4.352178] i2c i2c-4: Successfully instantiated SPD at 0x50
[    4.360750] Bluetooth: Core ver 2.22
[    4.360767] NET: Registered PF_BLUETOOTH protocol family
[    4.360768] Bluetooth: HCI device and connection manager initialized
[    4.360771] Bluetooth: HCI socket layer initialized
[    4.360773] Bluetooth: L2CAP socket layer initialized
[    4.360776] Bluetooth: SCO socket layer initialized
[    4.365211] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
[    4.375583] VFIO - User Level meta-driver version: 0.3
[    4.384272] mc: Linux media interface: v0.10
[    4.385313] r8169 0000:02:00.0 eth0: RTL8106e, 54:48:10:c2:64:6b, XID 449, IRQ 129
[    4.388879] usbcore: registered new interface driver rtsx_usb
[    4.466951] input: DELL083F:00 04F3:3088 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-5/i2c-DELL083F:00/0018:04F3:3088.0001/input/input10
[    4.466997] input: DELL083F:00 04F3:3088 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-5/i2c-DELL083F:00/0018:04F3:3088.0001/input/input11
[    4.467035] hid-generic 0018:04F3:3088.0001: input,hidraw0: I2C HID v1.00 Mouse [DELL083F:00 04F3:3088] on i2c-DELL083F:00
[    4.485940] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    4.485943] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.485945] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.485946] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    4.485947] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    4.485948] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    4.500517] cryptd: max_cpu_qlen set to 1000
[    4.500868] intel_rapl_common: Found RAPL domain package
[    4.500871] intel_rapl_common: Found RAPL domain core
[    4.500872] intel_rapl_common: Found RAPL domain uncore
[    4.500873] intel_rapl_common: Found RAPL domain dram
[    4.500875] intel_rapl_common: Found RAPL domain psys
[    4.506277] intel_rapl_common: Found RAPL domain package
[    4.506280] intel_rapl_common: Found RAPL domain dram
[    4.508312] usbcore: registered new interface driver btusb
[    4.534377] AVX2 version of gcm_enc/dec engaged.
[    4.534409] AES CTR mode by8 optimization enabled
[    4.534455] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    4.538379] iTCO_vendor_support: vendor-support=0
[    4.550536] videodev: Linux video capture interface: v2.00
[    4.554243] ee1004 4-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[    4.567842] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    4.574980] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[    4.577580] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    4.585676] input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input13
[    4.585724] ath10k_pci 0000:03:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    4.640742] vfio_pci: add [1002:6665[ffffffff:ffffffff]] class 0x000000/00000000
[    4.654491] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3204: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.654499] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.654502] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    4.654505] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.654507] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.654510] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[    4.654513] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
[    4.654515] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[    4.667618] input: DELL083F:00 04F3:3088 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-5/i2c-DELL083F:00/0018:04F3:3088.0001/input/input14
[    4.667687] input: DELL083F:00 04F3:3088 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-5/i2c-DELL083F:00/0018:04F3:3088.0001/input/input15
[    4.667739] hid-multitouch 0018:04F3:3088.0001: input,hidraw0: I2C HID v1.00 Mouse [DELL083F:00 04F3:3088] on i2c-DELL083F:00
[    4.684966] mousedev: PS/2 mouse device common for all mice
[    4.690456] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (1bcf:28c0)
[    4.711630] [drm] radeon kernel modesetting enabled.
[    4.711907] vga_switcheroo: detected switching method \_SB_.PCI0.RP01.PEGP.ATPX handle
[    4.712196] ATPX version 1, functions 0x00000003
[    4.712312] ATPX Hybrid Graphics
[    4.719008] input: Integrated_Webcam_HD: Integrate as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input18
[    4.719109] usbcore: registered new interface driver uvcvideo
[    4.730800] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    4.730849] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[    4.730890] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[    4.730934] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
[    4.730973] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
[    4.731010] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input23
[    4.754319] intel_tcc_cooling: Programmable TCC Offset detected
[    4.864874] psmouse serio1: elantech: assuming hardware version 4 (with firmware version 0x4f1001)
[    4.865081] psmouse serio1: elantech: elantech_send_cmd query 0x02 failed.
[    4.865084] psmouse serio1: elantech: failed to query capabilities.
[    4.890309] ath10k_pci 0000:03:00.0: qca9377 hw1.1 target 0x05020001 chip_id 0x003821ff sub 1028:1810
[    4.890314] ath10k_pci 0000:03:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 0 testmode 0
[    4.890781] ath10k_pci 0000:03:00.0: firmware ver WLAN.TF.2.1-00021-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32 42e41877
[    4.925743] [drm] amdgpu kernel modesetting enabled.
[    4.925764] amdgpu: vga_switcheroo: detected switching method \_SB_.PCI0.RP01.PEGP.ATPX handle
[    4.925884] ATPX version 1, functions 0x00000003
[    4.925958] ATPX Hybrid Graphics
[    4.926145] amdgpu: CRAT table not found
[    4.926147] amdgpu: Virtual CRAT table created for CPU
[    4.926157] amdgpu: Topology: Add CPU node
[    4.955911] ath10k_pci 0000:03:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
[    5.049621] ath10k_pci 0000:03:00.0: htt-ver 3.56 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    5.124638] ath: EEPROM regdomain: 0x6c
[    5.124641] ath: EEPROM indicates we should expect a direct regpair map
[    5.124643] ath: Country alpha2 being used: 00
[    5.124644] ath: Regpair used: 0x6c
[    5.743647] EXT4-fs (sda3): re-mounted. Quota mode: none.
[    6.304349] psmouse serio1: Failed to enable mouse on isa0060/serio1
[    6.319373] EXT4-fs (sda4): mounted filesystem with ordered data mode. Quota mode: none.
[    6.322270] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
[    6.322275] ext4 filesystem being mounted at /boot supports timestamps until 2038 (0x7fffffff)
[    6.425557] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Quota mode: none.
[    6.530364] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Quota mode: none.
[    6.549453] Adding 8388604k swap on /dev/sda2.  Priority:-2 extents:1 across:8388604k SSFS
[    7.112268] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input9
[    7.137637] RTL8208 Fast Ethernet r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[    7.388955] r8169 0000:02:00.0 eth0: Link is Down
[    7.463959] elogind[918]: New seat seat0.
[    7.465302] elogind[918]: Watching system buttons on /dev/input/event3 (Power Button)
[    7.465907] elogind[918]: Watching system buttons on /dev/input/event1 (Power Button)
[    7.467525] elogind[918]: Watching system buttons on /dev/input/event0 (Lid Switch)
[    7.467610] elogind[918]: Watching system buttons on /dev/input/event2 (Sleep Button)
[    7.468350] elogind[918]: Watching system buttons on /dev/input/event6 (Intel HID events)
[    7.468602] elogind[918]: Watching system buttons on /dev/input/event5 (AT Translated Set 2 keyboard)
[    7.800936] wlan0: authenticate with 7c:9a:54:0f:43:a5
[    7.800967] wlan0: bad VHT capabilities, disabling VHT
[    7.800971] wlan0: 80 MHz not supported, disabling VHT
[    7.833871] wlan0: send auth to 7c:9a:54:0f:43:a5 (try 1/3)
[    7.835728] wlan0: authenticated
[    7.837392] wlan0: associate with 7c:9a:54:0f:43:a5 (try 1/3)
[    7.843788] wlan0: RX AssocResp from 7c:9a:54:0f:43:a5 (capab=0x1411 status=0 aid=2)
[    7.846579] wlan0: associated
[    7.957836] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[    8.147595] L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
[    8.152187] r8169 0000:02:00.0: invalid VPD tag 0xff (size 0) at offset 0; assume missing optional EEPROM
[   10.101417] elogind[918]: New session 1 of user aleksa.

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git_bisect.log"

git bisect start
# status: waiting for both good and bad commits
# good: [df0cc57e057f18e44dac8e6c18aba47ab53202f9] Linux 5.16
git bisect good df0cc57e057f18e44dac8e6c18aba47ab53202f9
# status: waiting for bad commit, 1 good commit known
# bad: [f2906aa863381afb0015a9eb7fefad885d4e5a56] Linux 5.19-rc1
git bisect bad f2906aa863381afb0015a9eb7fefad885d4e5a56
# good: [25fd2d41b505d0640bdfe67aa77c549de2d3c18a] selftests: kselftest framework: provide "finished" helper
git bisect good 25fd2d41b505d0640bdfe67aa77c549de2d3c18a
# bad: [fdaf9a5840acaab18694a19e0eb0aa51162eeeed] Merge tag 'folio-5.19' of git://git.infradead.org/users/willy/pagecache
git bisect bad fdaf9a5840acaab18694a19e0eb0aa51162eeeed
# bad: [2c54e18406345b939d78a2cd755c44800bc31829] Merge tag 'rproc-v5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
git bisect bad 2c54e18406345b939d78a2cd755c44800bc31829
# good: [8eb48fc7c54ed627a693a205570f0eceea64274c] Merge tag 'for-v5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
git bisect good 8eb48fc7c54ed627a693a205570f0eceea64274c
# good: [02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa] Merge tag 'char-misc-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa
# good: [7203062171db6669f746d14148c4af76af619e74] Merge tag 'tty-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good 7203062171db6669f746d14148c4af76af619e74
# bad: [ee96dd9614f1c139e719dd2f296acbed7f1ab4b8] Merge tag 'libnvdimm-for-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect bad ee96dd9614f1c139e719dd2f296acbed7f1ab4b8
# bad: [1d59c3b669faddb91737f4e59c09305878a971d8] Merge tag 'pm-5.18-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 1d59c3b669faddb91737f4e59c09305878a971d8
# good: [0a815d0135f1be20c1a04d07f7573a26272ef846] Merge tag 'ucount-rlimit-for-v5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect good 0a815d0135f1be20c1a04d07f7573a26272ef846
# bad: [9ae2a143081fa8fba5042431007b33d9a855b7a2] Merge tag 'dma-mapping-5.18' of git://git.infradead.org/users/hch/dma-mapping
git bisect bad 9ae2a143081fa8fba5042431007b33d9a855b7a2
# skip: [ee1fee900537b5d9560e9f937402de5ddc8412f3] ptrace: Check PTRACE_O_SUSPEND_SECCOMP permission on PTRACE_SEIZE
git bisect skip ee1fee900537b5d9560e9f937402de5ddc8412f3
# skip: [dcbc65aac28360df5f5a3b613043ccc0e81da3cf] ptrace: Remove duplicated include in ptrace.c
git bisect skip dcbc65aac28360df5f5a3b613043ccc0e81da3cf
# skip: [35265899acef135225e946b883fb07acba1d31a2] swiotlb: simplify debugfs setup
git bisect skip 35265899acef135225e946b883fb07acba1d31a2
# skip: [80e4390981618e290616dbd06ea190d4576f219d] dma-debug: fix return value of __setup handlers
git bisect skip 80e4390981618e290616dbd06ea190d4576f219d
# skip: [c0a4191c27a12d3175283fa33f16db20e91008fd] swiotlb: tidy up includes
git bisect skip c0a4191c27a12d3175283fa33f16db20e91008fd
# skip: [03248addadf1a5ef0a03cbcd5ec905b49adb9658] resume_user_mode: Move to resume_user_mode.h
git bisect skip 03248addadf1a5ef0a03cbcd5ec905b49adb9658
# skip: [404f9373c4e5c943ed8a5e71c8dcfef9eddd54ab] swiotlb: simplify array allocation
git bisect skip 404f9373c4e5c943ed8a5e71c8dcfef9eddd54ab
# skip: [8ddde07a3d285a0f3cec14924446608320fdc013] dma-mapping: benchmark: extract a common header file for map_benchmark definition
git bisect skip 8ddde07a3d285a0f3cec14924446608320fdc013
# skip: [0cfcb2b9ef48bbcaf5d43b9f1893f63a938e8176] ptrace: Remove arch_syscall_{enter,exit}_tracehook
git bisect skip 0cfcb2b9ef48bbcaf5d43b9f1893f63a938e8176
# skip: [355f841a3f8ca980c9682937a5257d3a1f6fc09d] tracehook: Remove tracehook.h
git bisect skip 355f841a3f8ca980c9682937a5257d3a1f6fc09d
# skip: [c145137dc990fd67b52fbc52faae5ba46f168cca] ptrace: Remove tracehook_signal_handler
git bisect skip c145137dc990fd67b52fbc52faae5ba46f168cca
# good: [37fcacb50be7071d146144a6c5c5bf0194b9a1cf] phy: PHY_FSL_LYNX_28G should depend on ARCH_LAYERSCAPE
git bisect good 37fcacb50be7071d146144a6c5c5bf0194b9a1cf
# skip: [ffecba83be9c7ced229b9f1d75643d5a49f820c4] agp/intel: Remove usage of the deprecated "pci-dma-compat.h" API
git bisect skip ffecba83be9c7ced229b9f1d75643d5a49f820c4
# skip: [06cc5cf16591c3b1d63af2bbc9d33a66419ced98] alpha: Remove usage of the deprecated "pci-dma-compat.h" API
git bisect skip 06cc5cf16591c3b1d63af2bbc9d33a66419ced98
# skip: [fba09099c6e506608e05e08ac717bf34501f821b] media: v4l2-pci-skeleton: Remove usage of the deprecated "pci-dma-compat.h" API
git bisect skip fba09099c6e506608e05e08ac717bf34501f821b
# skip: [0fb3436b4b36cf69f4544385aa2bb8c5a4913509] sparc: Remove usage of the deprecated "pci-dma-compat.h" API
git bisect skip 0fb3436b4b36cf69f4544385aa2bb8c5a4913509
# skip: [e62c17f0455a74b182ce6373e2777817256afaa1] MAINTAINERS: update maintainer list of DMA MAPPING BENCHMARK
git bisect skip e62c17f0455a74b182ce6373e2777817256afaa1
# skip: [8c155674d9757be855547dc4eb6bcb82d52482e7] rapidio/tsi721: Remove usage of the deprecated "pci-dma-compat.h" API
git bisect skip 8c155674d9757be855547dc4eb6bcb82d52482e7
# skip: [f5ff79fddf0efecca538046b5cc20fb3ded2ec4f] dma-mapping: remove CONFIG_DMA_REMAP
git bisect skip f5ff79fddf0efecca538046b5cc20fb3ded2ec4f
# skip: [dfcf2e017f5bb928094952d5d56d3566d3d07ba7] swiotlb: do not zero buffer in set_memory_decrypted()
git bisect skip dfcf2e017f5bb928094952d5d56d3566d3d07ba7
# only skipped commits left to test
# possible first bad commit: [9ae2a143081fa8fba5042431007b33d9a855b7a2] Merge tag 'dma-mapping-5.18' of git://git.infradead.org/users/hch/dma-mapping
# possible first bad commit: [8ddde07a3d285a0f3cec14924446608320fdc013] dma-mapping: benchmark: extract a common header file for map_benchmark definition
# possible first bad commit: [80e4390981618e290616dbd06ea190d4576f219d] dma-debug: fix return value of __setup handlers
# possible first bad commit: [f5ff79fddf0efecca538046b5cc20fb3ded2ec4f] dma-mapping: remove CONFIG_DMA_REMAP
# possible first bad commit: [fba09099c6e506608e05e08ac717bf34501f821b] media: v4l2-pci-skeleton: Remove usage of the deprecated "pci-dma-compat.h" API
# possible first bad commit: [8c155674d9757be855547dc4eb6bcb82d52482e7] rapidio/tsi721: Remove usage of the deprecated "pci-dma-compat.h" API
# possible first bad commit: [0fb3436b4b36cf69f4544385aa2bb8c5a4913509] sparc: Remove usage of the deprecated "pci-dma-compat.h" API
# possible first bad commit: [ffecba83be9c7ced229b9f1d75643d5a49f820c4] agp/intel: Remove usage of the deprecated "pci-dma-compat.h" API
# possible first bad commit: [06cc5cf16591c3b1d63af2bbc9d33a66419ced98] alpha: Remove usage of the deprecated "pci-dma-compat.h" API
# possible first bad commit: [e62c17f0455a74b182ce6373e2777817256afaa1] MAINTAINERS: update maintainer list of DMA MAPPING BENCHMARK
# possible first bad commit: [404f9373c4e5c943ed8a5e71c8dcfef9eddd54ab] swiotlb: simplify array allocation
# possible first bad commit: [c0a4191c27a12d3175283fa33f16db20e91008fd] swiotlb: tidy up includes
# possible first bad commit: [35265899acef135225e946b883fb07acba1d31a2] swiotlb: simplify debugfs setup
# possible first bad commit: [dfcf2e017f5bb928094952d5d56d3566d3d07ba7] swiotlb: do not zero buffer in set_memory_decrypted()

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="input.log"

[    4.155887]  usb_hcd_submit_urb+0x7c/0xb30
[    4.155892]  ? __kmalloc+0x16d/0x370
[    4.155896]  usb_start_wait_urb+0x8a/0x180
[    4.155900]  rtsx_usb_send_cmd+0x58/0xa0 [rtsx_usb a989dcc4247852d419d89c90aa8a413a49a9f6f9]
[    4.155907]  rtsx_usb_probe+0x140/0x3a0 [rtsx_usb a989dcc4247852d419d89c90aa8a413a49a9f6f9]
[    4.155913]  usb_probe_interface+0xe2/0x2b0
[    4.155916]  really_probe+0x1a1/0x370
[    4.155920]  __driver_probe_device+0xfc/0x170
[    4.156140]  driver_probe_device+0x1f/0x90
[    4.156145]  __driver_attach+0xbb/0x190
[    4.156148]  ? __device_attach_driver+0xe0/0xe0
[    4.156151]  bus_for_each_dev+0x83/0xc0
[    4.156155]  bus_add_driver+0x14e/0x1f0
[    4.156158]  driver_register+0x89/0xd0
[    4.156161]  usb_register_driver+0x84/0x120
[    4.156165]  ? 0xffffffffc0568000
[    4.156168]  do_one_initcall+0x59/0x220
[    4.156172]  do_init_module+0x4a/0x230
[    4.156176]  __do_sys_init_module+0x138/0x1b0
[    4.156180]  do_syscall_64+0x5b/0x80
[    4.156184]  ? ksys_read+0x6b/0xf0
[    4.156187]  ? syscall_exit_to_user_mode+0x22/0x40
[    4.156190]  ? do_syscall_64+0x67/0x80
[    4.156192]  ? exc_page_fault+0x70/0x170
[    4.156196]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    4.156199] RIP: 0033:0x7fc63a11299e
[    4.156202] Code: 48 8b 0d fd a3 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ca a3 0e 00 f7 d8 64 89 01 48

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modules.log"

ccm 20480 6 - Live 0x0000000000000000
amdgpu 8892416 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 86016 1 - Live 0x0000000000000000
gpu_sched 53248 1 amdgpu, Live 0x0000000000000000
snd_ctl_led 24576 0 - Live 0x0000000000000000
radeon 1871872 0 - Live 0x0000000000000000
intel_tcc_cooling 16384 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 20480 0 - Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
coretemp 20480 0 - Live 0x0000000000000000
snd_hda_codec_realtek 167936 1 - Live 0x0000000000000000
snd_hda_codec_generic 98304 1 snd_hda_codec_realtek, Live 0x0000000000000000
kvm_intel 327680 0 - Live 0x0000000000000000
joydev 28672 0 - Live 0x0000000000000000
ath10k_pci 57344 0 - Live 0x0000000000000000
kvm 1101824 1 kvm_intel, Live 0x0000000000000000
mousedev 24576 0 - Live 0x0000000000000000
dell_laptop 32768 0 - Live 0x0000000000000000
ath10k_core 663552 1 ath10k_pci, Live 0x0000000000000000
crct10dif_pclmul 16384 1 - Live 0x0000000000000000
uvcvideo 155648 0 - Live 0x0000000000000000
dell_wmi 28672 1 dell_laptop, Live 0x0000000000000000
vfio_pci 16384 0 - Live 0x0000000000000000
ledtrig_audio 16384 4 snd_ctl_led,snd_hda_codec_generic,dell_laptop,dell_wmi, Live 0x0000000000000000
ath 40960 1 ath10k_core, Live 0x0000000000000000
vfio_pci_core 69632 1 vfio_pci, Live 0x0000000000000000
videobuf2_vmalloc 20480 1 uvcvideo, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_intel 61440 3 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
iTCO_wdt 16384 0 - Live 0x0000000000000000
btusb 65536 0 - Live 0x0000000000000000
vfio_virqfd 16384 1 vfio_pci_core, Live 0x0000000000000000
videobuf2_memops 20480 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_intel_dspcfg 24576 1 snd_hda_intel, Live 0x0000000000000000
aesni_intel 380928 4 - Live 0x0000000000000000
mei_pxp 20480 0 - Live 0x0000000000000000
ee1004 20480 0 - Live 0x0000000000000000
videobuf2_v4l2 40960 1 uvcvideo, Live 0x0000000000000000
btrtl 28672 1 btusb, Live 0x0000000000000000
intel_pmc_bxt 16384 1 iTCO_wdt, Live 0x0000000000000000
mac80211 1245184 1 ath10k_core, Live 0x0000000000000000
dell_smbios 32768 2 dell_laptop,dell_wmi, Live 0x0000000000000000
crypto_simd 16384 1 aesni_intel, Live 0x0000000000000000
hid_multitouch 32768 0 - Live 0x0000000000000000
mei_hdcp 24576 0 - Live 0x0000000000000000
iTCO_vendor_support 16384 1 iTCO_wdt, Live 0x0000000000000000
snd_hda_codec 184320 4 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, Live 0x0000000000000000
processor_thermal_device_pci_legacy 16384 0 - Live 0x0000000000000000
videobuf2_common 86016 4 uvcvideo,videobuf2_vmalloc,videobuf2_memops,videobuf2_v4l2, Live 0x0000000000000000
btbcm 20480 1 btusb, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
vfio_iommu_type1 45056 0 - Live 0x0000000000000000
r8169 106496 0 - Live 0x0000000000000000
wmi_bmof 16384 0 - Live 0x0000000000000000
snd_hda_core 114688 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
btintel 49152 1 btusb, Live 0x0000000000000000
dcdbas 20480 1 dell_smbios, Live 0x0000000000000000
intel_soc_dts_iosf 20480 1 processor_thermal_device_pci_legacy, Live 0x0000000000000000
vfio 45056 2 vfio_pci_core,vfio_iommu_type1, Live 0x0000000000000000
btmtk 16384 1 btusb, Live 0x0000000000000000
processor_thermal_device 20480 1 processor_thermal_device_pci_legacy, Live 0x0000000000000000
realtek 36864 1 - Live 0x0000000000000000
cryptd 28672 2 ghash_clmulni_intel,crypto_simd, Live 0x0000000000000000
snd_pcm 163840 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live 0x0000000000000000
processor_thermal_rfim 16384 1 processor_thermal_device, Live 0x0000000000000000
bluetooth 868352 6 btusb,btrtl,btbcm,btintel,btmtk, Live 0x0000000000000000
intel_rapl_msr 20480 0 - Live 0x0000000000000000
snd_timer 49152 1 snd_pcm, Live 0x0000000000000000
videodev 311296 3 uvcvideo,videobuf2_v4l2,videobuf2_common, Live 0x0000000000000000
dm_multipath 45056 0 - Live 0x0000000000000000
dell_wmi_descriptor 20480 2 dell_wmi,dell_smbios, Live 0x0000000000000000
rapl 16384 0 - Live 0x0000000000000000
processor_thermal_mbox 16384 2 processor_thermal_device,processor_thermal_rfim, Live 0x0000000000000000
dm_mod 184320 1 dm_multipath, Live 0x0000000000000000
libarc4 16384 1 mac80211, Live 0x0000000000000000
dell_smm_hwmon 20480 0 - Live 0x0000000000000000
intel_cstate 20480 0 - Live 0x0000000000000000
intel_uncore 212992 0 - Live 0x0000000000000000
mc 69632 4 uvcvideo,videobuf2_v4l2,videobuf2_common,videodev, Live 0x0000000000000000
cfg80211 1077248 3 ath10k_core,ath,mac80211, Live 0x0000000000000000
rtsx_usb 32768 0 - Live 0x0000000000000000
mdio_devres 16384 1 r8169, Live 0x0000000000000000
ecdh_generic 16384 1 bluetooth, Live 0x0000000000000000
irqbypass 16384 2 kvm,vfio_pci_core, Live 0x0000000000000000
i2c_i801 40960 0 - Live 0x0000000000000000
snd 126976 15 snd_hda_codec_hdmi,snd_ctl_led,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer, Live 0x0000000000000000
psmouse 212992 0 - Live 0x0000000000000000
processor_thermal_rapl 20480 1 processor_thermal_device, Live 0x0000000000000000
mei_me 53248 2 - Live 0x0000000000000000
sg 49152 0 - Live 0x0000000000000000
pcspkr 16384 0 - Live 0x0000000000000000
libphy 167936 3 r8169,realtek,mdio_devres, Live 0x0000000000000000
crypto_user 24576 0 - Live 0x0000000000000000
drm_ttm_helper 16384 2 amdgpu,radeon, Live 0x0000000000000000
intel_lpss_pci 28672 0 - Live 0x0000000000000000
intel_xhci_usb_role_switch 16384 0 - Live 0x0000000000000000
mei 167936 5 mei_pxp,mei_hdcp,mei_me, Live 0x0000000000000000
rfkill 36864 6 dell_laptop,bluetooth,cfg80211, Live 0x0000000000000000
intel_lpss 16384 1 intel_lpss_pci, Live 0x0000000000000000
roles 16384 1 intel_xhci_usb_role_switch, Live 0x0000000000000000
idma64 20480 0 - Live 0x0000000000000000
soundcore 16384 2 snd_ctl_led,snd, Live 0x0000000000000000
intel_pch_thermal 20480 0 - Live 0x0000000000000000
intel_rapl_common 32768 2 intel_rapl_msr,processor_thermal_rapl, Live 0x0000000000000000
i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
i2c_hid_acpi 16384 0 - Live 0x0000000000000000
wmi 45056 4 dell_wmi,dell_smbios,wmi_bmof,dell_wmi_descriptor, Live 0x0000000000000000
i2c_hid 40960 1 i2c_hid_acpi, Live 0x0000000000000000
intel_hid 28672 0 - Live 0x0000000000000000
int3400_thermal 20480 0 - Live 0x0000000000000000
int3403_thermal 20480 0 - Live 0x0000000000000000
int3402_thermal 16384 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
sparse_keymap 16384 2 dell_wmi,intel_hid, Live 0x0000000000000000
int340x_thermal_zone 20480 3 processor_thermal_device,int3403_thermal,int3402_thermal, Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
acpi_pad 24576 0 - Live 0x0000000000000000
ext4 1007616 5 - Live 0x0000000000000000
crc32c_generic 16384 0 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
mbcache 16384 1 ext4, Live 0x0000000000000000
jbd2 192512 1 ext4, Live 0x0000000000000000
serio_raw 20480 0 - Live 0x0000000000000000
atkbd 36864 0 - Live 0x0000000000000000
libps2 20480 2 psmouse,atkbd, Live 0x0000000000000000
crc32c_intel 24576 10 - Live 0x0000000000000000
xhci_pci 20480 0 - Live 0x0000000000000000
xhci_pci_renesas 24576 1 xhci_pci, Live 0x0000000000000000
i8042 45056 1 dell_laptop, Live 0x0000000000000000
serio 28672 6 psmouse,serio_raw,atkbd,i8042, Live 0x0000000000000000
i915 2940928 10 - Live 0x0000000000000000
intel_gtt 24576 1 i915, Live 0x0000000000000000
drm_buddy 20480 1 i915, Live 0x0000000000000000
video 57344 3 dell_laptop,dell_wmi,i915, Live 0x0000000000000000
drm_dp_helper 167936 3 amdgpu,radeon,i915, Live 0x0000000000000000
ttm 86016 4 amdgpu,radeon,drm_ttm_helper,i915, Live 0x0000000000000000

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ver_linux.log"
Content-Transfer-Encoding: quoted-printable

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux artix 5.17.0-12897-g9ae2a143081f #2 SMP PREEMPT_DYNAMIC Fri Jul 8 14:=
25:23 CEST 2022 x86_64 GNU/Linux

GNU C               	12.1.0
GNU Make            	4.3
Binutils            	2.38
Util-linux          	2.38
Mount               	2.38
Module-init-tools   	30
E2fsprogs           	1.46.5
Bison               	3.8.2
Flex                	2.6.4
Linux C++ Library   	6.0.30
Dynamic linker (ldd)	2.35
Procps              	3.3.17
Net-tools           	2.10
Kbd                 	2.5.1
Console-tools       	2.5.1
Sh-utils            	9.1
Udev                	251
Wireless-tools      	30
Modules Loaded      	acpi_pad acpi_thermal_rel aesni_intel amdgpu ath10k_co=
re ath10k_pci ath atkbd bluetooth btbcm btintel btmtk btrtl btusb ccm cfg80=
211 coretemp crc16 crc32c_generic crc32c_intel crc32_pclmul crct10dif_pclmu=
l cryptd crypto_simd crypto_user dcdbas dell_laptop dell_smbios dell_smm_hw=
mon dell_wmi dell_wmi_descriptor dm_mod dm_multipath drm_buddy drm_dp_helpe=
r drm_ttm_helper ecdh_generic ee1004 ext4 ghash_clmulni_intel gpu_sched hid=
_multitouch i2c_hid i2c_hid_acpi i2c_i801 i2c_smbus i8042 i915 idma64 int34=
00_thermal int3402_thermal int3403_thermal int340x_thermal_zone intel_cstat=
e intel_gtt intel_hid intel_lpss intel_lpss_pci intel_pch_thermal intel_pmc=
_bxt intel_powerclamp intel_rapl_common intel_rapl_msr intel_soc_dts_iosf i=
ntel_tcc_cooling intel_uncore intel_xhci_usb_role_switch irqbypass iTCO_ven=
dor_support iTCO_wdt jbd2 joydev kvm kvm_intel ledtrig_audio libarc4 libphy=
 libps2 mac80211 mac_hid mbcache mc mdio_devres mei mei_hdcp mei_me mei_pxp=
 mousedev pcspkr processor_thermal_device processor_thermal_device_pci_lega=
cy processor_thermal_mbox processor_thermal_rapl processor_thermal_rfim psm=
ouse r8169 radeon rapl realtek rfkill roles rtsx_usb serio serio_raw sg snd=
 snd_ctl_led snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi snd_hda=
_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_intel_dspcfg snd_pc=
m snd_timer soundcore sparse_keymap ttm uvcvideo vfio vfio_iommu_type1 vfio=
_pci vfio_pci_core vfio_virqfd video videobuf2_common videobuf2_memops vide=
obuf2_v4l2 videobuf2_vmalloc videodev wmi wmi_bmof x86_pkg_temp_thermal xhc=
i_pci xhci_pci_renesas

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.17.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_KERNEL_ZSTD=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="artixlinux"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
# CONFIG_BPF_PRELOAD_UMD is not set
CONFIG_BPF_LSM=y
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_SCHED_CORE=y
CONFIG_ARCH_WANTS_RT_DELAYED_SIGNALS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_UCLAMP_TASK_GROUP=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
CONFIG_SLS=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_PV_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=y
CONFIG_XEN_DOM0=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
CONFIG_ACRN_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=320
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=5
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=0
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
# CONFIG_ACPI_APEI_EINJ is not set
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_ACPI_DPTF=y
# CONFIG_DPTF_POWER is not set
# CONFIG_DPTF_PCH_FIVR is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_BYTCRC_PMIC_OPREGION=y
CONFIG_CHTCRC_PMIC_OPREGION=y
CONFIG_CHT_WC_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
# CONFIG_HALTPOLL_CPUIDLE is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_X86_SGX_KVM=y
# CONFIG_KVM_AMD is not set
CONFIG_KVM_XEN=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULE_COMPRESS_ZSTD=y
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lz4"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="z3fold"
CONFIG_ZSWAP_DEFAULT_ON=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
CONFIG_DAMON_RECLAIM=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_NV is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
# CONFIG_TCP_CONG_ILLINOIS is not set
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_IPV6_VTI is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
CONFIG_NF_CONNTRACK=m
# CONFIG_NF_LOG_SYSLOG is not set
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
# CONFIG_NF_CT_NETLINK is not set
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
# CONFIG_NFT_CT is not set
# CONFIG_NFT_CONNLIMIT is not set
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
# CONFIG_NFT_HASH is not set
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
# CONFIG_NETFILTER_XT_MARK is not set
# CONFIG_NETFILTER_XT_CONNMARK is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_CONNSECMARK is not set
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
# CONFIG_NETFILTER_XT_TARGET_HL is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
# CONFIG_NETFILTER_XT_NAT is not set
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_TPROXY is not set
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
CONFIG_NF_TABLES_ARP=y
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=m
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_RPFILTER is not set
# CONFIG_IP_NF_MATCH_TTL is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_TTL is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
CONFIG_IP6_NF_IPTABLES=m
# CONFIG_IP6_NF_MATCH_AH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_HL is not set
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_MH is not set
# CONFIG_IP6_NF_MATCH_RPFILTER is not set
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
# CONFIG_IP6_NF_FILTER is not set
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
CONFIG_IP6_NF_MANGLE=m
# CONFIG_IP6_NF_RAW is not set
# CONFIG_IP6_NF_SECURITY is not set
# CONFIG_IP6_NF_NAT is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
# CONFIG_NET_EMATCH_NBYTE is not set
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_IPT is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
# CONFIG_NET_ACT_CSUM is not set
# CONFIG_NET_ACT_MPLS is not set
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
CONFIG_NET_NCSI=y
CONFIG_NCSI_OEM_CMD_GET_MAC=y
CONFIG_NCSI_OEM_CMD_KEEP_PHY=y
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_CMTP is not set
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
CONFIG_BT_AOSPEXT=y
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_MTK=y
CONFIG_BT_HCIBTUSB_RTL=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
# CONFIG_BT_ATH3K is not set
# CONFIG_BT_MTKUART is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=m
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_EDR=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_P2PDMA=y
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=10
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCI_MESON=y
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_XEN_BLKDEV_FRONTEND is not set
# CONFIG_XEN_BLKDEV_BACKEND is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_INTEL_MEI_HDCP=m
CONFIG_INTEL_MEI_PXP=m
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
# CONFIG_DM_UNSTRIPED is not set
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_CLONE is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
CONFIG_DM_MULTIPATH=m
# CONFIG_DM_MULTIPATH_QL is not set
# CONFIG_DM_MULTIPATH_ST is not set
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_ULI526X is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=m
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=m
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=m

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=m
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set

#
# MCTP Device Drivers
#
# CONFIG_MCTP_SERIAL is not set
# CONFIG_MCTP_TRANSPORT_I2C is not set
# end of MCTP Device Drivers

CONFIG_MDIO_DEVICE=m
CONFIG_MDIO_BUS=m
CONFIG_FWNODE_MDIO=m
CONFIG_ACPI_MDIO=m
CONFIG_MDIO_DEVRES=m
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
CONFIG_ATH5K_PCI=y
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=m
# CONFIG_ATH10K_USB is not set
CONFIG_ATH10K_DEBUG=y
CONFIG_ATH10K_DEBUGFS=y
CONFIG_ATH10K_SPECTRAL=y
CONFIG_ATH10K_TRACING=y
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
# CONFIG_MT7921U is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
# CONFIG_WWAN_HWSIM is not set
# CONFIG_IOSM is not set
# end of Wireless WAN

# CONFIG_XEN_NETDEV_FRONTEND is not set
# CONFIG_XEN_NETDEV_BACKEND is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
# CONFIG_MISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=m
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
# CONFIG_TOUCHSCREEN_DA9052 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_PCAP is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8925_ONKEY is not set
# CONFIG_INPUT_MAX8997_HAPTIC is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
# CONFIG_INPUT_TWL4030_VIBRA is not set
# CONFIG_INPUT_TWL6040_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PALMAS_PWRBUTTON is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_DA9052_ONKEY is not set
# CONFIG_INPUT_DA9055_ONKEY is not set
# CONFIG_INPUT_WM831X_ON is not set
# CONFIG_INPUT_PCAP is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=m
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=m
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=m
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
# CONFIG_SERIAL_8250_EXAR is not set
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_CHT_WC is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_INTEL_PCI is not set
# CONFIG_SPI_INTEL_PLATFORM is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
# CONFIG_PTP_1588_CLOCK_KVM is not set
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SX150X=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_CRYSTAL_COVE is not set
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WM831X is not set
# CONFIG_GPIO_WM8350 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
# CONFIG_SENSORS_WM8350 is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=100
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
CONFIG_INTEL_TCC_COOLING=m
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=m
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_INTEL_PMC_BXT=m
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM8607 is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP8788 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8997 is not set
# CONFIG_REGULATOR_MAX8998 is not set
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PALMAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PCAP is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_RC5T583 is not set
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY7636A is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS6586X is not set
# CONFIG_REGULATOR_TPS65910 is not set
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_LIRC=y
# CONFIG_RC_MAP is not set
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
# CONFIG_IR_SHARP_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_USB_GSPCA is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_S2255 is not set
# CONFIG_USB_STKWEBCAM is not set
# CONFIG_VIDEO_USBTV is not set
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
# CONFIG_USB_ZR364XX is not set

#
# Analog TV USB devices
#
# CONFIG_VIDEO_GO7007 is not set
# CONFIG_VIDEO_HDPVR is not set
# CONFIG_VIDEO_PVRUSB2 is not set
# CONFIG_VIDEO_STK1160_COMMON is not set

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set
# CONFIG_VIDEO_CX231XX is not set
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
# CONFIG_DVB_AS102 is not set
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_USB_V2 is not set
# CONFIG_DVB_USB is not set
# CONFIG_SMS_USB_DRV is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_DT3155 is not set
# CONFIG_VIDEO_IVTV is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CX18 is not set
# CONFIG_VIDEO_CX23885 is not set
# CONFIG_VIDEO_CX25821 is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_SAA7164 is not set

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
# CONFIG_DVB_DDBRIDGE is not set
# CONFIG_DVB_DM1105 is not set
# CONFIG_MANTIS_CORE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_DVB_NGENE is not set
# CONFIG_DVB_PLUTO2 is not set
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_BUDGET_CORE is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#
# CONFIG_VIDEO_ASPEED is not set

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#
# CONFIG_VIDEO_CAFE_CCIC is not set

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIM2M is not set
# CONFIG_VIDEO_VICODEC is not set
# CONFIG_VIDEO_VIMC is not set
# CONFIG_VIDEO_VIVID is not set
CONFIG_DVB_TEST_DRIVERS=y
# CONFIG_DVB_VIDTV is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# audio, video and radio I2C drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Video and audio decoders
#

#
# SPI I2C drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Tuner drivers auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m

#
# DVB Frontend drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_DP_HELPER=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
CONFIG_DRM_AMD_DC_HDCP=y
CONFIG_DRM_AMD_DC_SI=y
CONFIG_DRM_AMD_SECURE_DISPLAY=y
# end of Display Engine Configuration

CONFIG_HSA_AMD=y
CONFIG_HSA_AMD_SVM=y
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE="*"
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set
CONFIG_DRM_I915_PXP=y
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
# CONFIG_SND_CTL_VALIDATION is not set
# CONFIG_SND_JACK_INJECTION_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=m
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=1
CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
# CONFIG_SND_USB_CAIAQ is not set
CONFIG_SND_USB_US122L=m
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI is not set
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_INTEL_SKL=m
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
# CONFIG_SND_SOC_INTEL_GLK is not set
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
# CONFIG_SND_SOC_INTEL_SKL_RT286_MACH is not set
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH is not set
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
# CONFIG_SND_SOC_SOF_ACPI is not set
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_AW8738 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_SPI is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_DA7213 is not set
# CONFIG_SND_SOC_DMIC is not set
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
# CONFIG_SND_SOC_ES8316 is not set
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
# CONFIG_SND_SOC_MAX98357A is not set
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
# CONFIG_SND_SOC_MAX98927 is not set
# CONFIG_SND_SOC_MAX98520 is not set
# CONFIG_SND_SOC_MAX98373_I2C is not set
# CONFIG_SND_SOC_MAX98390 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
# CONFIG_SND_SOC_RT5640 is not set
# CONFIG_SND_SOC_RT5659 is not set
# CONFIG_SND_SOC_RT9120 is not set
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS5805M is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
# CONFIG_SND_XEN_FRONTEND is not set
# CONFIG_SND_VIRTIO is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=m
# end of I2C HID support

CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
CONFIG_USB_XHCI_PCI_RENESAS=m
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set
# CONFIG_USB_XEN_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=m
CONFIG_USB_ROLES_INTEL_XHCI=m
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_DECODE_MCE is not set
CONFIG_EDAC_GHES=y
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_I10NM is not set
# CONFIG_EDAC_PND2 is not set
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_LP8788 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8925 is not set
# CONFIG_RTC_DRV_MAX8998 is not set
# CONFIG_RTC_DRV_MAX8997 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_PALMAS is not set
# CONFIG_RTC_DRV_TPS6586X is not set
# CONFIG_RTC_DRV_TPS65910 is not set
# CONFIG_RTC_DRV_RC5T583 is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_WM8350 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_PCAP is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_ACRN_HSM is not set
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_PMEM is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_MEM is not set
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
# CONFIG_XEN_DEV_EVTCHN is not set
CONFIG_XEN_BACKEND=y
# CONFIG_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
CONFIG_XEN_GRANT_DMA_ALLOC=y
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PCIDEV_BACKEND is not set
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PVCALLS_BACKEND=y
# CONFIG_XEN_PRIVCMD is not set
# CONFIG_XEN_ACPI_PROCESSOR is not set
CONFIG_XEN_MCE_LOG=y
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_UNPOPULATED_ALLOC=y
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
CONFIG_INTEL_ATOMISP=y
# CONFIG_VIDEO_ATOMISP is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_IPU3_IMGU is not set
# CONFIG_DVB_AV7110 is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_MXM_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_EEEPC_LAPTOP is not set
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
# CONFIG_ALIENWARE_WMI is not set
CONFIG_DCDBAS=m
CONFIG_DELL_LAPTOP=m
# CONFIG_DELL_RBU is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
# CONFIG_DELL_SMO8800 is not set
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_PRIVACY=y
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_WMI_SYSMAN is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_HP_WMI is not set
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
CONFIG_INTEL_PMC_CORE=y

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_X86_ANDROID_TABLETS is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_INTEL_SCU_IPC_UTIL is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_INTEL_CHT_WC is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77843 is not set
# CONFIG_EXTCON_MAX8997 is not set
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_CRC=y
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
CONFIG_ND_BLK=y
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
# CONFIG_DEV_DAX_HMEM is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=m
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="zstd"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_SMB_SERVER is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
# CONFIG_INTEL_TXT is not set
CONFIG_LSM_MMAP_MIN_ADDR=65536
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
CONFIG_SECURITY_SMACK=y
CONFIG_SECURITY_SMACK_BRINGUP=y
CONFIG_SECURITY_SMACK_NETFILTER=y
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
CONFIG_SECURITY_TOMOYO=y
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/usr/bin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/usr/lib/systemd/systemd"
# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENFORCE=y
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
# CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
# CONFIG_INTEGRITY_MACHINE_KEYRING is not set
CONFIG_LOAD_UEFI_KEYS=y
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=m
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=m
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
# CONFIG_CRYPTO_DEV_CCP_DD is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
# CONFIG_MODULE_SIG_KEY_TYPE_RSA is not set
CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=y
# CONFIG_FONT_6x8 is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=4
CONFIG_CONSOLE_LOGLEVEL_QUIET=1
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
# CONFIG_KFENCE_DEFERRABLE is not set
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--f3uetlu5s7siaz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="decode_stacktrace.log"

$ ./scripts/decode_stacktrace.sh /media/files/git/staging/arch/x86/boot/bzImage /media/files/git/staging < ~/files/report_rtsx/input.log

[    4.155887] usb_hcd_submit_urb+0x7c/0xb30 
[    4.155892] ? __kmalloc+0x16d/0x370 
[    4.155896] usb_start_wait_urb+0x8a/0x180 
Server query failed: No such file or directory
Server query failed: No such file or directory
Server query failed: No such file or directory
readelf: Error: Not an ELF file - it has the wrong magic bytes at the start
readelf: Error: Not an ELF file - it has the wrong magic bytes at the start
readelf: Error: Not an ELF file - it has the wrong magic bytes at the start
WARNING! Modules path isn't set, but is needed to parse this symbol
[    4.155900] rtsx_usb_send_cmd+0x58/0xa0 rtsx_usb
Server query failed: No such file or directory
Server query failed: No such file or directory
Server query failed: No such file or directory
readelf: Error: Not an ELF file - it has the wrong magic bytes at the start
readelf: Error: Not an ELF file - it has the wrong magic bytes at the start
readelf: Error: Not an ELF file - it has the wrong magic bytes at the start
WARNING! Modules path isn't set, but is needed to parse this symbol
[    4.155907] rtsx_usb_probe+0x140/0x3a0 rtsx_usb
[    4.155913] usb_probe_interface+0xe2/0x2b0 
[    4.155916] really_probe+0x1a1/0x370 
[    4.155920] __driver_probe_device+0xfc/0x170 
[    4.156140] driver_probe_device+0x1f/0x90 
[    4.156145] __driver_attach+0xbb/0x190 
[    4.156148] ? __device_attach_driver+0xe0/0xe0 
[    4.156151] bus_for_each_dev+0x83/0xc0 
[    4.156155] bus_add_driver+0x14e/0x1f0 
[    4.156158] driver_register+0x89/0xd0 
[    4.156161] usb_register_driver+0x84/0x120 
[    4.156165]  ? 0xffffffffc0568000
[    4.156168] do_one_initcall+0x59/0x220 
[    4.156172] do_init_module+0x4a/0x230 
[    4.156176] __do_sys_init_module+0x138/0x1b0 
[    4.156180] do_syscall_64+0x5b/0x80 
[    4.156184] ? ksys_read+0x6b/0xf0 
[    4.156187] ? syscall_exit_to_user_mode+0x22/0x40 
[    4.156190] ? do_syscall_64+0x67/0x80 
[    4.156192] ? exc_page_fault+0x70/0x170 
[    4.156196] entry_SYSCALL_64_after_hwframe+0x44/0xae 
[    4.156199] RIP: 0033:0x7fc63a11299e
[ 4.156202] Code: 48 8b 0d fd a3 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ca a3 0e 00 f7 d8 64 89 01 48
All code
========
   0:	48 8b 0d fd a3 0e 00 	mov    0xea3fd(%rip),%rcx        # 0xea404
   7:	f7 d8                	neg    %eax
   9:	64 89 01             	mov    %eax,%fs:(%rcx)
   c:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  10:	c3                   	ret    
  11:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  18:	00 00 00 
  1b:	90                   	nop
  1c:	f3 0f 1e fa          	endbr64 
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 af 00 00 00       	mov    $0xaf,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret    
  33:	48 8b 0d ca a3 0e 00 	mov    0xea3ca(%rip),%rcx        # 0xea404
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret    
   9:	48 8b 0d ca a3 0e 00 	mov    0xea3ca(%rip),%rcx        # 0xea3da
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W

--f3uetlu5s7siaz6g--

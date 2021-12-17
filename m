Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792ED4796D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhLQWEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLQWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:04:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961CCC061574;
        Fri, 17 Dec 2021 14:04:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F191B623FC;
        Fri, 17 Dec 2021 22:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F84C36AE2;
        Fri, 17 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778685;
        bh=wreOyrCZydsXTxmLWbMLdJQSRKhIhiIFjgkG/aj9NCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWRORviYOsq688Z99Nga1Wov/Xjd2I9gWW7fy0Xwb2Tlrh0hI0d76Zo8oo2S5bmE7
         dADXa3tV4GBHWV0oKQvEPz6gd+WM90xlAPH6IQjbQw2qqJiDmgqbsv8jUNBUdzjCpm
         vdbGFS8yniXYzbTVIUx9GfOR1jKFY1l+mcML6JRH0APDHQXNX610mKkqOqJew04Zju
         GY2hkZlquNwgq6UMeowXqEa4isEIx0wYqVH8V45P8vPaGFYuHVthVA2YpF/fBJS8+K
         rA5EzNtepq1MEobImcrDxU7sr0CyYAS2wxsJnXNV4R9wtDFyjEVTrOM1Z1GuDIucX3
         CN4jJ3JigGs4w==
Date:   Fri, 17 Dec 2021 15:04:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Message-ID: <Yb0Jd6Ad6TfTgAEC@archlinux-ax161>
References: <20211116162116.93081-1-jarkko@kernel.org>
 <20211116162116.93081-2-jarkko@kernel.org>
 <YbzhBrimHGGpddDM@archlinux-ax161>
 <b744d47e-4b7f-d372-f8ba-758555c08993@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kO/GpfGXlbU26p1X"
Content-Disposition: inline
In-Reply-To: <b744d47e-4b7f-d372-f8ba-758555c08993@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kO/GpfGXlbU26p1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 01:17:42PM -0800, Dave Hansen wrote:
> On 12/17/21 11:12 AM, Nathan Chancellor wrote:
> > With this patch in -next as commit 50468e431335 ("x86/sgx: Add an
> > attribute for the amount of SGX memory in a NUMA node"), this sysfs node
> > causes an OOPS for me on at least one of my test systems (Intel based):
> 
> Thanks for the report!
> 
> Could you share /proc/cpuinfo and a full dmesg from when this happens?
> I'm curious if your system has SGX at all and if it had any issues
> during initialization.

Sure thing, find them attached (does not look like it does). Let me know
if there is any more information I can provide or test fixes.

Cheers,
Nathan

--kO/GpfGXlbU26p1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuinfo_plus_dmesg.txt"
Content-Transfer-Encoding: quoted-printable

# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x26
cpu MHz		: 800.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_=
tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 =
sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer =
aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti ss=
bd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase ts=
c_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts =
md_clear flush_l1d
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpri=
ority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapg=
s itlb_multihit srbds
bogomips	: 4790.43
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x26
cpu MHz		: 1700.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_=
tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 =
sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer =
aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti ss=
bd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase ts=
c_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts =
md_clear flush_l1d
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpri=
ority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapg=
s itlb_multihit srbds
bogomips	: 4790.43
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x26
cpu MHz		: 2171.251
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_=
tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 =
sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer =
aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti ss=
bd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase ts=
c_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts =
md_clear flush_l1d
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpri=
ority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapg=
s itlb_multihit srbds
bogomips	: 4790.43
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x26
cpu MHz		: 800.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_=
tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 =
sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer =
aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti ss=
bd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase ts=
c_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts =
md_clear flush_l1d
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpri=
ority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapg=
s itlb_multihit srbds
bogomips	: 4790.43
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

# dmesg
[    0.000000] microcode: microcode updated early to revision 0x26, date =
=3D 2019-11-12
[    0.000000] Linux version 5.16.0-rc5-next-20211217-debug (nathan@archlin=
ux-ax161) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.37.50.20211212) #1 SMP=
 PREEMPT Fri Dec 17 18:40:53 UTC 2021
[    0.000000] Command line: initrd=3D\intel-ucode.img initrd=3D\initramfs-=
linux-debug.img root=3DPARTUUID=3D8dd2ef78-91f0-40ff-96ad-6273e7a97147 rw i=
ntel_pstate=3Dno_hwp
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c9abafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9abb000-0x00000000c9ac1fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000c9ac2000-0x00000000ca318fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ca319000-0x00000000ca597fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ca598000-0x00000000d9917fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d9918000-0x00000000d9b1ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000d9b20000-0x00000000d9e5dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d9e5e000-0x00000000dab29fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000dab2a000-0x00000000daffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000dafff000-0x00000000daffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dbc00000-0x00000000dfdfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021f1fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi: ACPI=3D0xdaae5000 ACPI 2.0=3D0xdaae5000 SMBIOS=3D0xdaf5=
2318=20
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. Q302LA/Q302LA, BIOS Q302LA.203 05=
/15/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2394.447 MHz processor
[    0.000078] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000082] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000090] last_pfn =3D 0x21f200 max_arch_pfn =3D 0x400000000
[    0.000204] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000876] total RAM covered: 8110M
[    0.001045] Found optimal setting for mtrr clean up
[    0.001046]  gran_size: 64K 	chunk_size: 128M 	num_reg: 10  	lose cover =
RAM: 0G
[    0.001394] e820: update [mem 0xdbc00000-0xffffffff] usable =3D=3D> rese=
rved
[    0.001399] last_pfn =3D 0xdb000 max_arch_pfn =3D 0x400000000
[    0.010564] Using GB pages for direct mapping
[    0.011324] Secure boot disabled
[    0.011325] RAMDISK: [mem 0x7ef14000-0x7fb72fff]
[    0.011330] ACPI: Early table checksum verification disabled
[    0.011334] ACPI: RSDP 0x00000000DAAE5000 000024 (v02 _ASUS_)
[    0.011338] ACPI: XSDT 0x00000000DAAE5090 0000A4 (v01 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.011345] ACPI: FACP 0x00000000DAAFB750 00010C (v05 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.011352] ACPI: DSDT 0x00000000DAAE5248 016508 (v02 _ASUS_ Notebook 00=
000012 INTL 20120711)
[    0.011356] ACPI: FACS 0x00000000DAB27F80 000040
[    0.011359] ACPI: APIC 0x00000000DAAFB860 000072 (v03 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.011362] ACPI: FPDT 0x00000000DAAFB8D8 000044 (v01 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.011366] ACPI: ECDT 0x00000000DAAFB920 0000C1 (v01 _ASUS_ Notebook 01=
072009 AMI. 00000005)
[    0.011369] ACPI: LPIT 0x00000000DAAFB9E8 000094 (v01 ALASKA          00=
000000 AMI. 00000005)
[    0.011373] ACPI: SSDT 0x00000000DAAFBA80 000539 (v01 PmRef  Cpu0Ist  00=
003000 INTL 20120711)
[    0.011377] ACPI: SSDT 0x00000000DAAFBFC0 000AD8 (v01 PmRef  CpuPm    00=
003000 INTL 20120711)
[    0.011380] ACPI: SSDT 0x00000000DAAFCA98 0002DE (v01 PmRef  Cpu0Tst  00=
003000 INTL 20120711)
[    0.011384] ACPI: SSDT 0x00000000DAAFCD78 000348 (v01 PmRef  ApTst    00=
003000 INTL 20120711)
[    0.011388] ACPI: MCFG 0x00000000DAAFD0C0 00003C (v01 _ASUS_ Notebook 01=
072009 MSFT 00000097)
[    0.011391] ACPI: SSDT 0x00000000DAAFD100 00306D (v01 DptfTa DptfTabl 00=
001000 INTL 20120711)
[    0.011395] ACPI: HPET 0x00000000DAB00170 000038 (v01 _ASUS_ Notebook 01=
072009 AMI. 00000005)
[    0.011398] ACPI: SSDT 0x00000000DAB001A8 0002D7 (v01 SataRe SataTabl 00=
001000 INTL 20120711)
[    0.011402] ACPI: SSDT 0x00000000DAB00480 003F21 (v01 SaSsdt SaSsdt   00=
003000 INTL 20091112)
[    0.011405] ACPI: BGRT 0x00000000DAB043A8 000038 (v00 _ASUS_ Notebook 01=
072009 ASUS 00010013)
[    0.011409] ACPI: MSDM 0x00000000D9B1EE18 000055 (v03 _ASUS_ Notebook 00=
000000 ASUS 00000001)
[    0.011412] ACPI: Reserving FACP table memory at [mem 0xdaafb750-0xdaafb=
85b]
[    0.011414] ACPI: Reserving DSDT table memory at [mem 0xdaae5248-0xdaafb=
74f]
[    0.011415] ACPI: Reserving FACS table memory at [mem 0xdab27f80-0xdab27=
fbf]
[    0.011416] ACPI: Reserving APIC table memory at [mem 0xdaafb860-0xdaafb=
8d1]
[    0.011417] ACPI: Reserving FPDT table memory at [mem 0xdaafb8d8-0xdaafb=
91b]
[    0.011418] ACPI: Reserving ECDT table memory at [mem 0xdaafb920-0xdaafb=
9e0]
[    0.011420] ACPI: Reserving LPIT table memory at [mem 0xdaafb9e8-0xdaafb=
a7b]
[    0.011421] ACPI: Reserving SSDT table memory at [mem 0xdaafba80-0xdaafb=
fb8]
[    0.011422] ACPI: Reserving SSDT table memory at [mem 0xdaafbfc0-0xdaafc=
a97]
[    0.011423] ACPI: Reserving SSDT table memory at [mem 0xdaafca98-0xdaafc=
d75]
[    0.011424] ACPI: Reserving SSDT table memory at [mem 0xdaafcd78-0xdaafd=
0bf]
[    0.011426] ACPI: Reserving MCFG table memory at [mem 0xdaafd0c0-0xdaafd=
0fb]
[    0.011427] ACPI: Reserving SSDT table memory at [mem 0xdaafd100-0xdab00=
16c]
[    0.011428] ACPI: Reserving HPET table memory at [mem 0xdab00170-0xdab00=
1a7]
[    0.011429] ACPI: Reserving SSDT table memory at [mem 0xdab001a8-0xdab00=
47e]
[    0.011430] ACPI: Reserving SSDT table memory at [mem 0xdab00480-0xdab04=
3a0]
[    0.011432] ACPI: Reserving BGRT table memory at [mem 0xdab043a8-0xdab04=
3df]
[    0.011433] ACPI: Reserving MSDM table memory at [mem 0xd9b1ee18-0xd9b1e=
e6c]
[    0.011453] ACPI: CEDT not present
[    0.011489] No NUMA configuration found
[    0.011490] Faking a node at [mem 0x0000000000000000-0x000000021f1fffff]
[    0.011494] NODE_DATA(0) allocated [mem 0x21f1fc000-0x21f1fffff]
[    0.011521] Zone ranges:
[    0.011522]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.011524]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.011526]   Normal   [mem 0x0000000100000000-0x000000021f1fffff]
[    0.011528]   Device   empty
[    0.011529] Movable zone start for each node
[    0.011530] Early memory node ranges
[    0.011531]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.011533]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.011534]   node   0: [mem 0x0000000000100000-0x00000000c9abafff]
[    0.011535]   node   0: [mem 0x00000000c9ac2000-0x00000000ca318fff]
[    0.011536]   node   0: [mem 0x00000000ca598000-0x00000000d9917fff]
[    0.011538]   node   0: [mem 0x00000000d9b20000-0x00000000d9e5dfff]
[    0.011539]   node   0: [mem 0x00000000dafff000-0x00000000daffffff]
[    0.011540]   node   0: [mem 0x0000000100000000-0x000000021f1fffff]
[    0.011542] Initmem setup node 0 [mem 0x0000000000001000-0x000000021f1ff=
fff]
[    0.011546] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.011548] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.011571] On node 0, zone DMA: 98 pages in unavailable ranges
[    0.017483] On node 0, zone DMA32: 7 pages in unavailable ranges
[    0.017944] On node 0, zone DMA32: 639 pages in unavailable ranges
[    0.017959] On node 0, zone DMA32: 520 pages in unavailable ranges
[    0.018005] On node 0, zone DMA32: 4513 pages in unavailable ranges
[    0.026672] On node 0, zone Normal: 20480 pages in unavailable ranges
[    0.026711] On node 0, zone Normal: 3584 pages in unavailable ranges
[    0.026720] Reserving Intel graphics memory at [mem 0xdbe00000-0xdfdffff=
f]
[    0.026798] ACPI: PM-Timer IO Port: 0x1808
[    0.026806] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.026819] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
39
[    0.026822] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026824] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.026828] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.026830] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.026838] e820: update [mem 0xd758c000-0xd75a4fff] usable =3D=3D> rese=
rved
[    0.026850] TSC deadline timer available
[    0.026851] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.026878] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.026880] PM: hibernation: Registered nosave memory: [mem 0x00058000-0=
x00058fff]
[    0.026883] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0=
x0009ffff]
[    0.026884] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.026886] PM: hibernation: Registered nosave memory: [mem 0xc9abb000-0=
xc9ac1fff]
[    0.026888] PM: hibernation: Registered nosave memory: [mem 0xca319000-0=
xca597fff]
[    0.026891] PM: hibernation: Registered nosave memory: [mem 0xd758c000-0=
xd75a4fff]
[    0.026893] PM: hibernation: Registered nosave memory: [mem 0xd9918000-0=
xd9b1ffff]
[    0.026895] PM: hibernation: Registered nosave memory: [mem 0xd9e5e000-0=
xdab29fff]
[    0.026896] PM: hibernation: Registered nosave memory: [mem 0xdab2a000-0=
xdaffefff]
[    0.026898] PM: hibernation: Registered nosave memory: [mem 0xdb000000-0=
xdbbfffff]
[    0.026899] PM: hibernation: Registered nosave memory: [mem 0xdbc00000-0=
xdfdfffff]
[    0.026900] PM: hibernation: Registered nosave memory: [mem 0xdfe00000-0=
xf7ffffff]
[    0.026901] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]
[    0.026902] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfebfffff]
[    0.026903] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.026904] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.026905] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed03fff]
[    0.026906] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0=
xfed1bfff]
[    0.026907] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0=
xfed1ffff]
[    0.026908] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xfedfffff]
[    0.026909] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.026910] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xfeffffff]
[    0.026911] PM: hibernation: Registered nosave memory: [mem 0xff000000-0=
xffffffff]
[    0.026913] [mem 0xdfe00000-0xf7ffffff] available for PCI devices
[    0.026915] Booting paravirtualized kernel on bare hardware
[    0.026917] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.032536] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:4 n=
r_node_ids:1
[    0.032748] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u524288
[    0.032757] pcpu-alloc: s212992 r8192 d28672 u524288 alloc=3D1*2097152
[    0.032760] pcpu-alloc: [0] 0 1 2 3=20
[    0.032787] Fallback order for Node 0: 0=20
[    0.032791] Built 1 zonelists, mobility grouping on.  Total pages: 20348=
49
[    0.032793] Policy zone: Normal
[    0.032795] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-debug.img root=3DPARTUUID=3D8dd2ef78-91f0-40ff-96ad-6273e7a971=
47 rw intel_pstate=3Dno_hwp
[    0.033300] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes, linear)
[    0.033527] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes, linear)
[    0.033691] mem auto-init: stack:byref_all(zero), heap alloc:on, heap fr=
ee:off
[    0.066173] Memory: 7965936K/8269236K available (14343K kernel code, 207=
0K rwdata, 10544K rodata, 1784K init, 4020K bss, 303040K reserved, 0K cma-r=
eserved)
[    0.066180] random: get_random_u64 called from __kmem_cache_create+0x2a/=
0x560 with crng_init=3D0
[    0.066343] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.066356] Kernel/User page tables isolation: enabled
[    0.066379] ftrace: allocating 43546 entries in 171 pages
[    0.083163] ftrace: allocated 171 pages with 5 groups
[    0.083236] Dynamic Preempt: full
[    0.083269] rcu: Preemptible hierarchical RCU implementation.
[    0.083270] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D4.
[    0.083272] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.083273] 	Trampoline variant of Tasks RCU enabled.
[    0.083274] 	Rude variant of Tasks RCU enabled.
[    0.083275] 	Tracing variant of Tasks RCU enabled.
[    0.083275] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.083276] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.088276] NR_IRQS: 20736, nr_irqs: 728, preallocated irqs: 16
[    0.088571] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.088703] Console: colour dummy device 80x25
[    0.088720] printk: console [tty0] enabled
[    0.088741] ACPI: Core revision 20210930
[    0.088893] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.088894] APIC: Switch to symmetric I/O mode setup
[    0.089218] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2283ba1244f, max_idle_ns: 440795326940 ns
[    0.089224] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4790.43 BogoMIPS (lpj=3D7981490)
[    0.089227] pid_max: default: 32768 minimum: 301
[    0.091127] LSM: Security Framework initializing
[    0.091135] landlock: Up and running.
[    0.091136] Yama: becoming mindful.
[    0.091143] LSM support for eBPF active
[    0.091168] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s, linear)
[    0.091185] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes, linear)
[    0.091430] CPU0: Thermal monitoring enabled (TM1)
[    0.091467] process: using mwait in idle threads
[    0.091469] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.091471] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.091475] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.091477] Spectre V2 : Mitigation: Full generic retpoline
[    0.091477] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.091478] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.091480] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.091481] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.091482] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.091486] SRBDS: Mitigation: Microcode
[    0.091487] MDS: Mitigation: Clear CPU buffers
[    0.092555] Freeing SMP alternatives memory: 36K
[    0.092555] smpboot: Estimated ratio of average max frequency by base fr=
equency (times 1024): 1024
[    0.092555] smpboot: CPU0: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz (fam=
ily: 0x6, model: 0x45, stepping: 0x1)
[    0.092555] cblist_init_generic: Setting adjustable number of callback q=
ueues.
[    0.092555] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.092555] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.092555] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.092555] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.092555] ... version:                3
[    0.092555] ... bit width:              48
[    0.092555] ... generic registers:      4
[    0.092555] ... value mask:             0000ffffffffffff
[    0.092555] ... max period:             00007fffffffffff
[    0.092555] ... fixed-purpose events:   3
[    0.092555] ... event mask:             000000070000000f
[    0.092555] rcu: Hierarchical SRCU implementation.
[    0.092555] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.092555] smp: Bringing up secondary CPUs ...
[    0.092555] x86: Booting SMP configuration:
[    0.092555] .... node  #0, CPUs:      #1 #2
[    0.093085] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.093085]  #3
[    0.093085] smp: Brought up 1 node, 4 CPUs
[    0.093085] smpboot: Max logical packages: 1
[    0.093085] smpboot: Total of 4 processors activated (19163.72 BogoMIPS)
[    0.096189] devtmpfs: initialized
[    0.096189] x86/mm: Memory block size: 128MB
[    0.096519] ACPI: PM: Registering ACPI NVS region [mem 0xc9abb000-0xc9ac=
1fff] (28672 bytes)
[    0.096519] ACPI: PM: Registering ACPI NVS region [mem 0xd9e5e000-0xdab2=
9fff] (13418496 bytes)
[    0.096519] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.096519] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.096519] pinctrl core: initialized pinctrl subsystem
[    0.096519] PM: RTC time: 21:56:55, date: 2021-12-17
[    0.096519] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.096601] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.096677] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.096751] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.096765] audit: initializing netlink subsys (disabled)
[    0.096774] audit: type=3D2000 audit(1639778215.006:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.096774] thermal_sys: Registered thermal governor 'fair_share'
[    0.096774] thermal_sys: Registered thermal governor 'bang_bang'
[    0.096774] thermal_sys: Registered thermal governor 'step_wise'
[    0.096774] thermal_sys: Registered thermal governor 'user_space'
[    0.096774] thermal_sys: Registered thermal governor 'power_allocator'
[    0.096774] cpuidle: using governor ladder
[    0.096774] cpuidle: using governor menu
[    0.096774] HugeTLB: can free 4095 vmemmap pages for hugepages-1048576kB
[    0.096774] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.096774] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.096774] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.096774] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.096774] PCI: Using configuration type 1 for base access
[    0.096774] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.096774] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.099657] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.099665] HugeTLB: can free 7 vmemmap pages for hugepages-2048kB
[    0.099665] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.099665] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.099665] ACPI: Added _OSI(Module Device)
[    0.099665] ACPI: Added _OSI(Processor Device)
[    0.099665] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.099665] ACPI: Added _OSI(Processor Aggregator Device)
[    0.099665] ACPI: Added _OSI(Linux-Dell-Video)
[    0.099665] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.099665] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.127364] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.128317] ACPI: EC: EC started
[    0.128318] ACPI: EC: interrupt blocked
[    0.129550] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.129552] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.130631] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.133682] ACPI: Dynamic OEM Table Load:
[    0.133690] ACPI: SSDT 0xFFFF99D5402AF400 0003D3 (v01 PmRef  Cpu0Cst  00=
003001 INTL 20120711)
[    0.135085] ACPI: Dynamic OEM Table Load:
[    0.135091] ACPI: SSDT 0xFFFF99D540BFA800 0005AA (v01 PmRef  ApIst    00=
003000 INTL 20120711)
[    0.136573] ACPI: Dynamic OEM Table Load:
[    0.136578] ACPI: SSDT 0xFFFF99D54021BA00 000119 (v01 PmRef  ApCst    00=
003000 INTL 20120711)
[    0.138810] ACPI: Interpreter enabled
[    0.138848] ACPI: PM: (supports S0 S3 S4 S5)
[    0.138850] ACPI: Using IOAPIC for interrupt routing
[    0.138883] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.139540] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.155371] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.155379] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.155695] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplu=
g SHPCHotplug PME]
[    0.156058] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability L=
TR DPC]
[    0.156060] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.156642] PCI host bridge to bus 0000:00
[    0.156645] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.156648] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.156650] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000efff=
f window]
[    0.156651] pci_bus 0000:00: root bus resource [mem 0xdfe00000-0xfeaffff=
f window]
[    0.156653] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.156668] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.156739] pci 0000:00:02.0: [8086:0a16] type 00 class 0x030000
[    0.156748] pci 0000:00:02.0: reg 0x10: [mem 0xf7800000-0xf7bfffff 64bit]
[    0.156755] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit=
 pref]
[    0.156759] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.156772] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.156852] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.156861] pci 0000:00:03.0: reg 0x10: [mem 0xf7d1c000-0xf7d1ffff 64bit]
[    0.156953] pci 0000:00:04.0: [8086:0a03] type 00 class 0x118000
[    0.156962] pci 0000:00:04.0: reg 0x10: [mem 0xf7d10000-0xf7d17fff 64bit]
[    0.157066] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.157081] pci 0000:00:14.0: reg 0x10: [mem 0xf7d00000-0xf7d0ffff 64bit]
[    0.157136] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.157211] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.157228] pci 0000:00:16.0: reg 0x10: [mem 0xf7d25000-0xf7d2501f 64bit]
[    0.157294] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.157351] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.157366] pci 0000:00:1b.0: reg 0x10: [mem 0xf7d18000-0xf7d1bfff 64bit]
[    0.157430] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.157512] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    0.157596] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.158041] pci 0000:00:1c.3: [8086:9c16] type 01 class 0x060400
[    0.158131] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.158563] pci 0000:00:1d.0: [8086:9c26] type 00 class 0x0c0320
[    0.158579] pci 0000:00:1d.0: reg 0x10: [mem 0xf7d23000-0xf7d233ff]
[    0.158662] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.158747] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.158920] pci 0000:00:1f.2: [8086:9c03] type 00 class 0x010601
[    0.158931] pci 0000:00:1f.2: reg 0x10: [io  0xf0b0-0xf0b7]
[    0.158938] pci 0000:00:1f.2: reg 0x14: [io  0xf0a0-0xf0a3]
[    0.158945] pci 0000:00:1f.2: reg 0x18: [io  0xf090-0xf097]
[    0.158951] pci 0000:00:1f.2: reg 0x1c: [io  0xf080-0xf083]
[    0.158958] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.158964] pci 0000:00:1f.2: reg 0x24: [mem 0xf7d22000-0xf7d227ff]
[    0.158997] pci 0000:00:1f.2: PME# supported from D3hot
[    0.159060] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.159075] pci 0000:00:1f.3: reg 0x10: [mem 0xf7d21000-0xf7d210ff 64bit]
[    0.159093] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.159279] acpiphp: Slot [1] registered
[    0.159291] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.159589] pci 0000:02:00.0: [8086:08b1] type 00 class 0x028000
[    0.159679] pci 0000:02:00.0: reg 0x10: [mem 0xf7c00000-0xf7c01fff 64bit]
[    0.159983] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.160418] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.160423] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.162656] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.162658] ACPI: PCI: Interrupt link LNKA disabled
[    0.162732] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.162734] ACPI: PCI: Interrupt link LNKB disabled
[    0.162806] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.162807] ACPI: PCI: Interrupt link LNKC disabled
[    0.162879] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.162880] ACPI: PCI: Interrupt link LNKD disabled
[    0.162952] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.162953] ACPI: PCI: Interrupt link LNKE disabled
[    0.163027] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.163028] ACPI: PCI: Interrupt link LNKF disabled
[    0.163099] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.163101] ACPI: PCI: Interrupt link LNKG disabled
[    0.163172] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.163173] ACPI: PCI: Interrupt link LNKH disabled
[    0.163835] ACPI: EC: interrupt unblocked
[    0.163837] ACPI: EC: event unblocked
[    0.163843] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.163844] ACPI: EC: GPE=3D0xa
[    0.163846] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot ECDT EC initialization comp=
lete
[    0.163848] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions =
and events
[    0.163911] iommu: Default domain type: Translated=20
[    0.163913] iommu: DMA domain TLB invalidation policy: lazy mode=20
[    0.163928] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.163928] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.163928] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.163928] vgaarb: loaded
[    0.163928] SCSI subsystem initialized
[    0.163928] libata version 3.00 loaded.
[    0.163928] ACPI: bus type USB registered
[    0.163928] usbcore: registered new interface driver usbfs
[    0.163928] usbcore: registered new interface driver hub
[    0.163928] usbcore: registered new device driver usb
[    0.184015] pps_core: LinuxPPS API ver. 1 registered
[    0.184017] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.184021] PTP clock support registered
[    0.184030] EDAC MC: Ver: 3.0.0
[    0.184140] Registered efivars operations
[    0.184140] NetLabel: Initializing
[    0.184140] NetLabel:  domain hash size =3D 128
[    0.184140] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.184140] NetLabel:  unlabeled traffic allowed by default
[    0.184140] PCI: Using ACPI for IRQ routing
[    0.184140] PCI: pci_cache_line_size set to 64 bytes
[    0.184148] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.184151] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.184152] e820: reserve RAM buffer [mem 0xc9abb000-0xcbffffff]
[    0.184154] e820: reserve RAM buffer [mem 0xca319000-0xcbffffff]
[    0.184155] e820: reserve RAM buffer [mem 0xd758c000-0xd7ffffff]
[    0.184156] e820: reserve RAM buffer [mem 0xd9918000-0xdbffffff]
[    0.184158] e820: reserve RAM buffer [mem 0xd9e5e000-0xdbffffff]
[    0.184160] e820: reserve RAM buffer [mem 0xdb000000-0xdbffffff]
[    0.184161] e820: reserve RAM buffer [mem 0x21f200000-0x21fffffff]
[    0.186808] clocksource: Switched to clocksource tsc-early
[    0.195630] VFS: Disk quotas dquot_6.6.0
[    0.195648] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.195744] pnp: PnP ACPI init
[    0.195913] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.196264] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.196267] system 00:01: [io  0xffff] has been reserved
[    0.196269] system 00:01: [io  0xffff] has been reserved
[    0.196271] system 00:01: [io  0xffff] has been reserved
[    0.196272] system 00:01: [io  0x1c00-0x1cfe] has been reserved
[    0.196274] system 00:01: [io  0x1d00-0x1dfe] has been reserved
[    0.196276] system 00:01: [io  0x1e00-0x1efe] has been reserved
[    0.196277] system 00:01: [io  0x1f00-0x1ffe] has been reserved
[    0.196279] system 00:01: [io  0x1800-0x18fe] has been reserved
[    0.196281] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.196370] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.196429] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.196464] system 00:05: [io  0x0240-0x0259] has been reserved
[    0.197041] system 00:08: [mem 0xfe104000-0xfe104fff] has been reserved
[    0.197595] system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.197598] system 00:09: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.197600] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.197602] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.197605] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.197607] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.197609] system 00:09: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.197611] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.197613] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.197615] system 00:09: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.197617] system 00:09: [mem 0xf7fdf000-0xf7fdffff] has been reserved
[    0.197620] system 00:09: [mem 0xf7fe0000-0xf7feffff] has been reserved
[    0.198247] pnp: PnP ACPI: found 11 devices
[    0.204128] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.204189] NET: Registered PF_INET protocol family
[    0.204286] IP idents hash table entries: 131072 (order: 8, 1048576 byte=
s, linear)
[    0.205638] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4,=
 65536 bytes, linear)
[    0.205702] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
[    0.205838] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.205962] TCP: Hash tables configured (established 65536 bind 65536)
[    0.206022] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes=
, linear)
[    0.206073] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.206099] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, l=
inear)
[    0.206152] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.206158] NET: Registered PF_XDP protocol family
[    0.206166] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.206186] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.206191] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.206199] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.206201] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.206203] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000effff windo=
w]
[    0.206205] pci_bus 0000:00: resource 7 [mem 0xdfe00000-0xfeafffff windo=
w]
[    0.206206] pci_bus 0000:02: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    0.206381] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.206848] PCI: CLS 64 bytes, default 64
[    0.206857] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.206858] software IO TLB: mapped [mem 0x00000000d347a000-0x00000000d7=
47a000] (64MB)
[    0.206906] Trying to unpack rootfs image as initramfs...
[    0.216457] Initialise system trusted keyrings
[    0.216471] Key type blacklist registered
[    0.216524] workingset: timestamp_bits=3D41 max_order=3D21 bucket_order=
=3D0
[    0.219140] zbud: loaded
[    0.232653] Key type asymmetric registered
[    0.232658] Asymmetric key parser 'x509' registered
[    0.267448] Freeing initrd memory: 12668K
[    0.270129] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    0.270176] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 243)
[    0.270210] io scheduler mq-deadline registered
[    0.270212] io scheduler kyber registered
[    0.270244] io scheduler bfq registered
[    0.270890] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.271449] ACPI: AC: AC Adapter [AC0] (on-line)
[    0.271522] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input0
[    0.271539] ACPI: button: Lid Switch [LID]
[    0.271566] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input1
[    0.271600] ACPI: button: Sleep Button [SLPB]
[    0.271628] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.271650] ACPI: button: Power Button [PWRF]
[    0.275046] thermal LNXTHERM:00: registered as thermal_zone0
[    0.275049] ACPI: thermal: Thermal Zone [THRM] (35 C)
[    0.275284] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.279386] hpet_acpi_add: no address or irqs in _CRS
[    0.279446] Non-volatile memory driver v1.3
[    0.279447] Linux agpgart interface v0.103
[    0.279449] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em - This is not a bug.
[    0.280498] ahci 0000:00:1f.2: version 3.0
[    0.280737] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.290839] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x=
1 impl SATA mode
[    0.290844] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo only pio=
 slum part deso sadm sds apst=20
[    0.291281] scsi host0: ahci
[    0.291546] scsi host1: ahci
[    0.291701] scsi host2: ahci
[    0.291796] scsi host3: ahci
[    0.291836] ata1: SATA max UDMA/133 abar m2048@0xf7d22000 port 0xf7d2210=
0 irq 40
[    0.291838] ata2: DUMMY
[    0.291839] ata3: DUMMY
[    0.291840] ata4: DUMMY
[    0.291884] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.291888] ehci-pci: EHCI PCI platform driver
[    0.292035] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.292041] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus =
number 1
[    0.292053] ehci-pci 0000:00:1d.0: debug port 2
[    0.295977] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7d23000
[    0.309237] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.309293] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.16
[    0.309296] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.309298] usb usb1: Product: EHCI Host Controller
[    0.309299] usb usb1: Manufacturer: Linux 5.16.0-rc5-next-20211217-debug=
 ehci_hcd
[    0.309301] usb usb1: SerialNumber: 0000:00:1d.0
[    0.309417] hub 1-0:1.0: USB hub found
[    0.309423] hub 1-0:1.0: 2 ports detected
[    0.309592] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.309596] ohci-pci: OHCI PCI platform driver
[    0.309605] uhci_hcd: USB Universal Host Controller Interface driver
[    0.309639] usbcore: registered new interface driver usbserial_generic
[    0.309643] usbserial: USB Serial support registered for generic
[    0.309742] rtc_cmos 00:02: RTC can wake from S4
[    0.309980] rtc_cmos 00:02: registered as rtc0
[    0.310015] rtc_cmos 00:02: setting system clock to 2021-12-17T21:56:55 =
UTC (1639778215)
[    0.310030] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram
[    0.310168] intel_pstate: Intel P-state driver initializing
[    0.310407] ledtrig-cpu: registered to indicate activity on CPUs
[    0.310523] efifb: probing for efifb
[    0.310531] efifb: framebuffer at 0xe0000000, using 4128k, total 4128k
[    0.310533] efifb: mode is 1366x768x32, linelength=3D5504, pages=3D1
[    0.310535] efifb: scrolling: redraw
[    0.310535] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.310573] fbcon: Deferring console take-over
[    0.310574] fb0: EFI VGA frame buffer device
[    0.310589] hid: raw HID events driver (C) Jiri Kosina
[    0.310660] drop_monitor: Initializing network drop monitor service
[    0.310724] Initializing XFRM netlink socket
[    0.310818] NET: Registered PF_INET6 protocol family
[    0.315634] Segment Routing with IPv6
[    0.315637] RPL Segment Routing with IPv6
[    0.315646] In-situ OAM (IOAM) with IPv6
[    0.315670] NET: Registered PF_PACKET protocol family
[    0.315916] microcode: sig=3D0x40651, pf=3D0x40, revision=3D0x26
[    0.315930] microcode: Microcode Update Driver: v2.2.
[    0.315937] IPI shorthand broadcast: enabled
[    0.315952] sched_clock: Marking stable (315158161, 734865)->(323371507,=
 -7478481)
[    0.316118] registered taskstats version 1
[    0.316188] Loading compiled-in X.509 certificates
[    0.323398] ACPI: battery: Slot [BAT0] (battery present)
[    0.325529] Loaded X.509 cert 'Build time autogenerated kernel key: 894e=
a34ad0509d87200dab462aa75a4a6d8980bd'
[    0.325756] zswap: loaded using pool lz4/z3fold
[    0.325921] Key type ._fscrypt registered
[    0.325923] Key type .fscrypt registered
[    0.325924] Key type fscrypt-provisioning registered
[    0.327157] PM:   Magic number: 1:435:955
[    0.327221] memory memory8: hash matches
[    0.327324] RAS: Correctable Errors collector initialized.
[    0.559285] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    0.606325] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.607144] ata1.00: ATA-10: WD easystore 240GB, EF430400, max UDMA/133
[    0.607150] ata1.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 32)
[    0.608990] ata1.00: Features: Dev-Sleep
[    0.614493] ata1.00: configured for UDMA/133
[    0.625138] scsi 0:0:0:0: Direct-Access     ATA      WD easystore 240 04=
00 PQ: 0 ANSI: 5
[    0.625812] sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB=
/224 GiB)
[    0.625833] sd 0:0:0:0: [sda] Write Protect is off
[    0.625838] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.625862] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.653109]  sda: sda1 sda2
[    0.669369] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.670485] Freeing unused decrypted memory: 2036K
[    0.670773] Freeing unused kernel image (initmem) memory: 1784K
[    0.670816] Write protecting the kernel read-only data: 28672k
[    0.671304] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    0.671615] Freeing unused kernel image (rodata/data gap) memory: 1744K
[    0.706302] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
8000, bcdDevice=3D 0.04
[    0.706307] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    0.706591] hub 1-1:1.0: USB hub found
[    0.706674] hub 1-1:1.0: 8 ports detected
[    0.729423] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.729427] rodata_test: all tests were successful
[    0.729429] x86/mm: Checking user space page tables
[    0.778523] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.778527] Run /init as init process
[    0.778528]   with arguments:
[    0.778529]     /init
[    0.778530]   with environment:
[    0.778530]     HOME=3D/
[    0.778531]     TERM=3Dlinux
[    0.793317] fbcon: Taking over console
[    0.793384] Console: switching to colour frame buffer device 170x48
[    0.917349] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.917361] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.918419] i8042: PNP: PS/2 Controller [PNP030b:PS2K,PNP0f03:PS2M] at 0=
x60,0x64 irq 1,12
[    0.918441] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x000000000004b810
[    0.918635] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.16
[    0.918640] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.918642] usb usb2: Product: xHCI Host Controller
[    0.918645] usb usb2: Manufacturer: Linux 5.16.0-rc5-next-20211217-debug=
 xhci-hcd
[    0.918647] usb usb2: SerialNumber: 0000:00:14.0
[    0.918949] hub 2-0:1.0: USB hub found
[    0.918966] hub 2-0:1.0: 9 ports detected
[    0.920723] i8042: Detected active multiplexing controller, rev 1.1
[    0.922409] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.922465] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    0.922500] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    0.922536] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    0.922578] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    0.923653] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.923660] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 3
[    0.923665] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.923722] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.16
[    0.923727] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.923730] usb usb3: Product: xHCI Host Controller
[    0.923732] usb usb3: Manufacturer: Linux 5.16.0-rc5-next-20211217-debug=
 xhci-hcd
[    0.923734] usb usb3: SerialNumber: 0000:00:14.0
[    0.923872] hub 3-0:1.0: USB hub found
[    0.923883] hub 3-0:1.0: 4 ports detected
[    0.933001] random: fast init done
[    0.992593] usb 1-1.3: new high-speed USB device number 3 using ehci-pci
[    1.007071] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input3
[    1.105426] usb 1-1.3: New USB device found, idVendor=3D0b95, idProduct=
=3D772b, bcdDevice=3D 0.01
[    1.105432] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[    1.105434] usb 1-1.3: Product: AX88772B
[    1.105435] usb 1-1.3: Manufacturer: ASIX Elec. Corp.
[    1.105436] usb 1-1.3: SerialNumber: 12AC31
[    1.150812] SGI XFS with ACLs, security attributes, realtime, scrub, rep=
air, quota, no debug enabled
[    1.153002] XFS (sda2): Mounting V5 Filesystem
[    1.179246] usb 1-1.4: new full-speed USB device number 4 using ehci-pci
[    1.184508] XFS (sda2): Ending clean mount
[    1.188958] xfs filesystem being mounted at /new_root supports timestamp=
s until 2038 (0x7fffffff)
[    1.232609] tsc: Refined TSC clocksource calibration: 2394.457 MHz
[    1.232616] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x228=
3c360c9e, max_idle_ns: 440795302742 ns
[    1.232633] clocksource: Switched to clocksource tsc
[    1.281433] usb 1-1.4: New USB device found, idVendor=3D8087, idProduct=
=3D07dc, bcdDevice=3D 0.01
[    1.281439] usb 1-1.4: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    1.352575] usb 1-1.5: new high-speed USB device number 5 using ehci-pci
[    1.438770] random: crng init done
[    1.438781] systemd[1]: Successfully credited entropy passed from boot l=
oader.
[    1.442374] systemd[1]: systemd 249.7-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKB=
COMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    1.456050] systemd[1]: Detected architecture x86-64.
[    1.459568] systemd[1]: Hostname set to <asus>.
[    1.475918] usb 1-1.5: New USB device found, idVendor=3D064e, idProduct=
=3D9700, bcdDevice=3D 1.01
[    1.475924] usb 1-1.5: New USB device strings: Mfr=3D3, Product=3D1, Ser=
ialNumber=3D2
[    1.475926] usb 1-1.5: Product: USB2.0 UVC HD Webcam
[    1.475927] usb 1-1.5: Manufacturer: SuYin
[    1.475929] usb 1-1.5: SerialNumber: HF1019-T838-SN03-Rev0101
[    1.532067] systemd-fstab-generator[220]: Mount point  is not a valid pa=
th, ignoring.
[    1.532698] systemd-fstab-generator[220]: Mount point  is not a valid pa=
th, ignoring.
[    1.552588] usb 1-1.7: new full-speed USB device number 6 using ehci-pci
[    1.651670] usb 1-1.7: New USB device found, idVendor=3D03eb, idProduct=
=3D8a41, bcdDevice=3D10.32
[    1.651676] usb 1-1.7: New USB device strings: Mfr=3D1, Product=3D0, Ser=
ialNumber=3D0
[    1.651678] usb 1-1.7: Manufacturer: Atmel
[    1.685307] systemd[1]: Queued start job for default target Graphical In=
terface.
[    1.686368] systemd[1]: Created slice Slice /system/dhcpcd.
[    1.686731] systemd[1]: Created slice Slice /system/getty.
[    1.687062] systemd[1]: Created slice Slice /system/modprobe.
[    1.687312] systemd[1]: Created slice User and Session Slice.
[    1.687440] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    1.687561] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    1.687765] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    1.687868] systemd[1]: Reached target Local Encrypted Volumes.
[    1.687931] systemd[1]: Reached target Login Prompts.
[    1.688002] systemd[1]: Reached target Path Units.
[    1.688058] systemd[1]: Reached target Remote File Systems.
[    1.688112] systemd[1]: Reached target Slice Units.
[    1.688172] systemd[1]: Reached target Swaps.
[    1.688226] systemd[1]: Reached target Local Verity Protected Volumes.
[    1.688345] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    1.689662] systemd[1]: Listening on Process Core Dump Socket.
[    1.693095] systemd[1]: Listening on Journal Audit Socket.
[    1.693272] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.693443] systemd[1]: Listening on Journal Socket.
[    1.697578] systemd[1]: Listening on udev Control Socket.
[    1.697744] systemd[1]: Listening on udev Kernel Socket.
[    1.698585] systemd[1]: Mounting Huge Pages File System...
[    1.699431] systemd[1]: Mounting POSIX Message Queue File System...
[    1.700286] systemd[1]: Mounting Kernel Debug File System...
[    1.701118] systemd[1]: Mounting Kernel Trace File System...
[    1.702133] systemd[1]: Starting Create List of Static Device Nodes...
[    1.703133] systemd[1]: Starting Load Kernel Module configfs...
[    1.704493] systemd[1]: Starting Load Kernel Module drm...
[    1.705999] systemd[1]: Starting Load Kernel Module fuse...
[    1.706284] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[    1.706359] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[    1.708502] systemd[1]: Starting Journal Service...
[    1.710122] systemd[1]: Starting Load Kernel Modules...
[    1.711349] systemd[1]: Starting Remount Root and Kernel File Systems...
[    1.711562] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.
[    1.712892] systemd[1]: Starting Coldplug All udev Devices...
[    1.715245] systemd[1]: Mounted Huge Pages File System.
[    1.715507] systemd[1]: Mounted POSIX Message Queue File System.
[    1.716547] systemd[1]: Mounted Kernel Debug File System.
[    1.717575] systemd[1]: Mounted Kernel Trace File System.
[    1.718896] systemd[1]: Finished Create List of Static Device Nodes.
[    1.720376] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    1.720705] systemd[1]: Finished Load Kernel Module configfs.
[    1.722434] systemd[1]: Mounting Kernel Configuration File System...
[    1.724722] systemd[1]: Mounted Kernel Configuration File System.
[    1.726705] xfs filesystem being remounted at / supports timestamps unti=
l 2038 (0x7fffffff)
[    1.727556] systemd[1]: Finished Remount Root and Kernel File Systems.
[    1.728308] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.
[    1.736148] Asymmetric key parser 'pkcs8' registered
[    1.737165] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[    1.738366] systemd[1]: Starting Load/Save Random Seed...
[    1.740678] systemd[1]: Starting Create System Users...
[    1.742409] systemd[1]: Finished Load Kernel Modules.
[    1.743434] audit: type=3D1130 audit(1639778216.929:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-modules-load comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    1.744854] systemd[1]: Starting Apply Kernel Variables...
[    1.750052] fuse: init (API version 7.36)
[    1.751127] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    1.751482] systemd[1]: Finished Load Kernel Module fuse.
[    1.752649] audit: type=3D1130 audit(1639778216.939:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@fuse comm=3D"syst=
emd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
[    1.752683] audit: type=3D1131 audit(1639778216.939:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@fuse comm=3D"syst=
emd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
[    1.754072] systemd[1]: Mounting FUSE Control File System...
[    1.759203] systemd[1]: Mounted FUSE Control File System.
[    1.773901] systemd[1]: Finished Apply Kernel Variables.
[    1.775861] audit: type=3D1130 audit(1639778216.959:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysctl comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    1.776475] systemd[1]: Finished Load/Save Random Seed.
[    1.777755] audit: type=3D1130 audit(1639778216.962:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-random-seed comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    1.777983] systemd[1]: Condition check resulted in First Boot Complete =
being skipped.
[    1.779834] ACPI: bus type drm_connector registered
[    1.781274] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    1.781618] systemd[1]: Finished Load Kernel Module drm.
[    1.782775] audit: type=3D1130 audit(1639778216.969:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@drm comm=3D"syste=
md" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[    1.782812] audit: type=3D1131 audit(1639778216.969:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@drm comm=3D"syste=
md" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[    1.785702] systemd[1]: Started Journal Service.
[    1.787009] audit: type=3D1130 audit(1639778216.972:9): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    1.798881] systemd-journald[235]: Received client request to flush runt=
ime journal.
[    1.805966] audit: type=3D1130 audit(1639778216.992:10): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysusers comm=3D"=
systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D=
? res=3Dsuccess'
[    2.213927] input: Asus Wireless Radio Control as /devices/LNXSYSTM:00/L=
NXSYBUS:00/ATK4002:00/input/input8
[    2.290211] Userspace governor deprecated: use thermal netlink notificat=
ion instead
[    2.295877] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[    2.295922] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.299286] i2c i2c-1: 2/4 memory slots populated (from DMI)
[    2.300171] i2c i2c-1: Successfully instantiated SPD at 0x50
[    2.409398] inv-mpu6050-i2c i2c-INVN6500:00: mounting matrix not found: =
using identity...
[    2.409406] inv-mpu6050-i2c i2c-INVN6500:00: supply vdd not found, using=
 dummy regulator
[    2.409448] inv-mpu6050-i2c i2c-INVN6500:00: supply vddio not found, usi=
ng dummy regulator
[    2.471803] mc: Linux media interface: v0.10
[    2.514666] hid-generic 0003:03EB:8A41.0001: hiddev96,hidraw0: USB HID v=
1.11 Device [Atmel] on usb-0000:00:1d.0-1.7/input0
[    2.526213] input: Atmel as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-=
1.7/1-1.7:1.1/0003:03EB:8A41.0002/input/input9
[    2.527576] hid-generic 0003:03EB:8A41.0002: input,hidraw1: USB HID v1.1=
1 Device [Atmel] on usb-0000:00:1d.0-1.7/input1
[    2.527635] usbcore: registered new interface driver usbhid
[    2.527638] usbhid: USB HID core driver
[    2.680110] videodev: Linux video capture interface: v2.00
[    2.723227] input: PC Speaker as /devices/platform/pcspkr/input/input11
[    2.723407] Bluetooth: Core ver 2.22
[    2.723437] NET: Registered PF_BLUETOOTH protocol family
[    2.723438] Bluetooth: HCI device and connection manager initialized
[    2.723443] Bluetooth: HCI socket layer initialized
[    2.723446] Bluetooth: L2CAP socket layer initialized
[    2.723450] Bluetooth: SCO socket layer initialized
[    2.724114] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    2.726052] FAT-fs (sda1): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[    2.738112] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.741685] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    2.741693] cfg80211: failed to load regulatory.db
[    2.847868] input: FocalTechPS/2 FocalTech Touchpad as /devices/platform=
/i8042/serio4/input/input14
[    2.899183] Intel(R) Wireless WiFi driver for Linux
[    2.923164] i2c i2c-0: Added multiplexed i2c bus 2
[    2.927092] iwlwifi 0000:02:00.0: loaded firmware version 17.3216344376.=
0 7260-17.ucode op_mode iwlmvm
[    2.966887] iTCO_vendor_support: vendor-support=3D0
[    3.001080] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3236: l=
ine_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    3.001088] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    3.001093] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    3.001096] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[    3.001099] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    3.001101] snd_hda_codec_realtek hdaudioC1D0:      Mic=3D0x12
[    3.015964] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360=
 ms ovfl timer
[    3.015970] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.015972] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.015974] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.015975] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    3.046856] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1b.0/sound/card1/input15
[    3.091418] intel_rapl_common: Found RAPL domain package
[    3.091423] intel_rapl_common: Found RAPL domain core
[    3.091425] intel_rapl_common: Found RAPL domain uncore
[    3.091427] intel_rapl_common: Found RAPL domain dram
[    3.091433] intel_rapl_common: RAPL package-0 domain package locked by B=
IOS
[    3.091442] intel_rapl_common: RAPL package-0 domain dram locked by BIOS
[    3.093293] at24 1-0050: supply vcc not found, using dummy regulator
[    3.093527] usbcore: registered new interface driver btusb
[    3.093932] at24 1-0050: 256 byte spd EEPROM, read-only
[    3.119292] Bluetooth: hci0: Legacy ROM 2.5 revision 8.0 build 1 week 45=
 2013
[    3.130852] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw=
-37.7.10-fw-1.80.1.2d.d.bseq
[    3.151217] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless A=
C 7260, REV=3D0x144
[    3.152518] checking generic (e0000000 408000) vs hw (f7800000 400000)
[    3.152523] checking generic (e0000000 408000) vs hw (e0000000 10000000)
[    3.152526] fb0: switching to i915 from EFI VGA
[    3.152703] Console: switching to colour dummy device 80x25
[    3.152757] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.153397] cryptd: max_cpu_qlen set to 1000
[    3.154338] mousedev: PS/2 mouse device common for all mice
[    3.154500] usb 1-1.5: Found UVC 1.00 device USB2.0 UVC HD Webcam (064e:=
9700)
[    3.161974] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    3.170888] iwlwifi 0000:02:00.0: base HW address: a0:a8:cd:7a:2c:81
[    3.175918] input: USB2.0 UVC HD Webcam: USB2.0 UV as /devices/pci0000:0=
0/0000:00:1d.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input16
[    3.186137] asus_wmi: ASUS WMI generic driver loaded
[    3.195864] iTCO_wdt iTCO_wdt.1.auto: Found a Lynx Point_LP TCO device (=
Version=3D2, TCOBASE=3D0x1860)
[    3.196207] iTCO_wdt iTCO_wdt.1.auto: initialized. heartbeat=3D30 sec (n=
owayout=3D0)
[    3.202648] asus_wmi: Initialization: 0x1
[    3.202749] asus_wmi: BIOS WMI version: 7.9
[    3.202894] asus_wmi: SFUN value: 0x4a2877
[    3.202898] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    3.202902] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
[    3.203398] AVX2 version of gcm_enc/dec engaged.
[    3.203441] AES CTR mode by8 optimization enabled
[    3.212764] intel-spi intel-spi: s25fl064k (8192 Kbytes)
[    3.214523] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/inp=
ut/input17
[    3.218843] Creating 1 MTD partitions on "intel-spi":
[    3.218850] 0x000000000000-0x000000800000 : "BIOS"
[    3.234043] usbcore: registered new interface driver uvcvideo
[    3.234713] input: Atmel as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-=
1.7/1-1.7:1.1/0003:03EB:8A41.0002/input/input18
[    3.235192] hid-multitouch 0003:03EB:8A41.0002: input,hidraw1: USB HID v=
1.11 Device [Atmel] on usb-0000:00:1d.0-1.7/input1
[    3.245167] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0
[    3.274091] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)
[    3.280624] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input19
[    3.280775] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[    3.284153] fbcon: i915drmfb (fb0) is primary device
[    3.294057] xfs filesystem being remounted at /run/systemd/unit-root/etc=
/iwd supports timestamps until 2038 (0x7fffffff)
[    3.294128] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/iwd supports timestamps until 2038 (0x7fffffff)
[    3.294195] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    3.296212] xfs filesystem being remounted at /run/systemd/unit-root/etc=
/iwd supports timestamps until 2038 (0x7fffffff)
[    3.307342] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/iwd supports timestamps until 2038 (0x7fffffff)
[    3.308143] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    3.310111] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/systemd/linger supports timestamps until 2038 (0x7fffffff)
[    3.310255] xfs filesystem being remounted at /run/systemd/unit-root/etc=
 supports timestamps until 2038 (0x7fffffff)
[    3.310408] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    3.313285] Bluetooth: hci0: unexpected event for opcode 0xfc2f
[    3.314286] Bluetooth: hci0: unexpected event 0xff length: 2 > 0
[    3.316168] xfs filesystem being remounted at /run/systemd/unit-root/etc=
 supports timestamps until 2038 (0x7fffffff)
[    3.330298] Bluetooth: hci0: Intel BT fw patch 0x2a completed & activated
[    3.339210] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/systemd/linger supports timestamps until 2038 (0x7fffffff)
[    3.340631] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    3.343980] NET: Registered PF_ALG protocol family
[    3.382281] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    3.604052] libphy: Asix MDIO Bus: probed
[    3.670778] Asix Electronics AX88772C usb-001:003:10: attached PHY drive=
r (mii_bus:phy_addr=3Dusb-001:003:10, irq=3DPOLL)
[    3.670973] asix 1-1.3:1.0 eth0: register 'asix' at usb-0000:00:1d.0-1.3=
, ASIX AX88772B USB 2.0 Ethernet, 80:6d:97:12:ac:31
[    3.671034] usbcore: registered new interface driver asix
[    3.674892] asix 1-1.3:1.0 enp0s29u1u3: renamed from eth0
[    4.435435] Console: switching to colour frame buffer device 170x48
[    4.452282] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    4.499174] input: HDA Intel HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00=
/0000:00:03.0/sound/card0/input20
[    4.499262] input: HDA Intel HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00=
/0000:00:03.0/sound/card0/input21
[    4.499343] input: HDA Intel HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00=
/0000:00:03.0/sound/card0/input22
[    4.499440] input: HDA Intel HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00=
/0000:00:03.0/sound/card0/input23
[    4.499522] input: HDA Intel HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:0=
0/0000:00:03.0/sound/card0/input24
[    4.552334] 8021q: 802.1Q VLAN Support v1.8
[    4.825281] asix 1-1.3:1.0 enp0s29u1u3: Link is Down
[    6.864741] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s29u1u3: link becomes rea=
dy
[    6.864821] asix 1-1.3:1.0 enp0s29u1u3: Link is Up - 100Mbps/Full - flow=
 control off
[    8.401734] kauditd_printk_skb: 23 callbacks suppressed
[    8.401743] audit: type=3D1131 audit(1639778223.585:34): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"sy=
stemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? =
res=3Dsuccess'
[   12.457912] audit: type=3D1130 audit(1639778227.642:35): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddhcpcd@enp0s29u1u3 comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[   12.462623] audit: type=3D1130 audit(1639778227.649:36): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsshd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   12.470107] audit: type=3D1130 audit(1639778227.655:37): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-user-sessions com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[   12.554056] audit: type=3D1130 audit(1639778227.739:38): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dntpd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   12.558887] audit: type=3D1130 audit(1639778227.742:39): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlightdm comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   13.656521] audit: type=3D1103 audit(1639778228.842:40): pid=3D524 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D=
pam_env,pam_permit acct=3D"lightdm" exe=3D"/usr/bin/lightdm" hostname=3D? a=
ddr=3D? terminal=3D:0 res=3Dsuccess'
[   13.676160] audit: type=3D1130 audit(1639778228.862:41): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@973 comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[   13.693912] audit: type=3D1101 audit(1639778228.879:42): pid=3D528 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=
=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"lightdm" exe=3D"/usr/lib=
/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   13.693960] audit: type=3D1103 audit(1639778228.879:43): pid=3D528 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D=
? acct=3D"lightdm" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dfailed'
[   13.694046] audit: type=3D1006 audit(1639778228.879:44): pid=3D528 uid=
=3D0 old-auid=3D4294967295 auid=3D973 tty=3D(none) old-ses=3D4294967295 ses=
=3D1 res=3D1
[   13.694049] audit: type=3D1300 audit(1639778228.879:44): arch=3Dc000003e=
 syscall=3D1 success=3Dyes exit=3D3 a0=3D9 a1=3D7ffe27ac2f20 a2=3D3 a3=3D3c=
d items=3D0 ppid=3D1 pid=3D528 auid=3D973 uid=3D0 gid=3D0 euid=3D0 suid=3D0=
 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"(system=
d)" exe=3D"/usr/lib/systemd/systemd" key=3D(null)
[   13.694052] audit: type=3D1327 audit(1639778228.879:44): proctitle=3D"(s=
ystemd)"
[   13.695553] audit: type=3D1105 audit(1639778228.879:45): pid=3D528 uid=
=3D0 auid=3D973 ses=3D1 msg=3D'op=3DPAM:session_open grantors=3Dpam_loginui=
d,pam_loginuid,pam_keyinit,pam_systemd_home,pam_limits,pam_unix,pam_permit,=
pam_mail,pam_systemd,pam_env acct=3D"lightdm" exe=3D"/usr/lib/systemd/syste=
md" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   13.701906] audit: type=3D1334 audit(1639778228.885:46): prog-id=3D20 op=
=3DLOAD
[   13.701912] audit: type=3D1300 audit(1639778228.885:46): arch=3Dc000003e=
 syscall=3D321 success=3Dyes exit=3D8 a0=3D5 a1=3D7ffe1c961620 a2=3D78 a3=
=3D7ffe1c961620 items=3D0 ppid=3D1 pid=3D528 auid=3D973 uid=3D973 gid=3D973=
 euid=3D973 suid=3D973 fsuid=3D973 egid=3D973 sgid=3D973 fsgid=3D973 tty=3D=
(none) ses=3D1 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" key=3D(nul=
l)
[   45.891048] kauditd_printk_skb: 4 callbacks suppressed
[   45.891052] audit: type=3D1101 audit(1639778261.075:50): pid=3D566 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=
=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"nathan" exe=3D"/usr/bin/=
sshd" hostname=3D192.168.4.54 addr=3D192.168.4.54 terminal=3Dssh res=3Dsucc=
ess'
[   45.893077] audit: type=3D1103 audit(1639778261.079:51): pid=3D566 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D=
pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock acct=3D"nathan" exe=
=3D"/usr/bin/sshd" hostname=3D192.168.4.54 addr=3D192.168.4.54 terminal=3Ds=
sh res=3Dsuccess'
[   45.893127] audit: type=3D1006 audit(1639778261.079:52): pid=3D566 uid=
=3D0 old-auid=3D4294967295 auid=3D1000 tty=3D(none) old-ses=3D4294967295 se=
s=3D2 res=3D1
[   45.893132] audit: type=3D1300 audit(1639778261.079:52): arch=3Dc000003e=
 syscall=3D1 success=3Dyes exit=3D4 a0=3D3 a1=3D7fff98116f50 a2=3D4 a3=3D3e=
8 items=3D0 ppid=3D505 pid=3D566 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=
=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D2 comm=3D"ssh=
d" exe=3D"/usr/bin/sshd" key=3D(null)
[   45.893136] audit: type=3D1327 audit(1639778261.079:52): proctitle=3D737=
368643A206E617468616E205B707269765D
[   45.906886] audit: type=3D1130 audit(1639778261.092:53): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@1000 com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[   45.913224] audit: type=3D1101 audit(1639778261.099:54): pid=3D569 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=
=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"nathan" exe=3D"/usr/lib/=
systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   45.913302] audit: type=3D1103 audit(1639778261.099:55): pid=3D569 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D=
? acct=3D"nathan" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? te=
rminal=3D? res=3Dfailed'
[   45.913408] audit: type=3D1006 audit(1639778261.099:56): pid=3D569 uid=
=3D0 old-auid=3D4294967295 auid=3D1000 tty=3D(none) old-ses=3D4294967295 se=
s=3D3 res=3D1
[   45.913412] audit: type=3D1300 audit(1639778261.099:56): arch=3Dc000003e=
 syscall=3D1 success=3Dyes exit=3D4 a0=3D9 a1=3D7ffe27ac2f20 a2=3D4 a3=3D3e=
8 items=3D0 ppid=3D1 pid=3D569 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=3D=
0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D3 comm=3D"(syste=
md)" exe=3D"/usr/lib/systemd/systemd" key=3D(null)
[   59.424292] kauditd_printk_skb: 11 callbacks suppressed
[   59.424298] audit: type=3D1100 audit(1639778274.609:65): pid=3D780 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:authentication grantors=3Dpam_f=
aillock,pam_permit,pam_faillock acct=3D"nathan" exe=3D"/usr/bin/doas" hostn=
ame=3Dasus addr=3D? terminal=3Dpts/0 res=3Dsuccess'
[   59.424553] audit: type=3D1101 audit(1639778274.609:66): pid=3D780 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,=
pam_permit,pam_time acct=3D"nathan" exe=3D"/usr/bin/doas" hostname=3Dasus a=
ddr=3D? terminal=3Dpts/0 res=3Dsuccess'
[   59.424671] audit: type=3D1110 audit(1639778274.609:67): pid=3D780 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock=
,pam_permit,pam_faillock acct=3D"root" exe=3D"/usr/bin/doas" hostname=3Dasu=
s addr=3D? terminal=3Dpts/0 res=3Dsuccess'
[   59.424890] audit: type=3D1105 audit(1639778274.609:68): pid=3D780 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:session_open grantors=3Dpam_sys=
temd_home,pam_limits,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bin/doas=
" hostname=3Dasus addr=3D? terminal=3Dpts/0 res=3Dsuccess'
[   91.992495] BUG: kernel NULL pointer dereference, address: 0000000000000=
020
[   91.992503] #PF: supervisor read access in kernel mode
[   91.992506] #PF: error_code(0x0000) - not-present page
[   91.992508] PGD 0 P4D 0=20
[   91.992512] Oops: 0000 [#1] PREEMPT SMP PTI
[   91.992516] CPU: 0 PID: 878 Comm: cat Not tainted 5.16.0-rc5-next-202112=
17-debug #1 15ae5b0f28a4b9b6343440ee595affa8e1b5cf57
[   91.992520] Hardware name: ASUSTeK COMPUTER INC. Q302LA/Q302LA, BIOS Q30=
2LA.203 05/15/2014
[   91.992522] RIP: 0010:sgx_total_bytes_show+0x28/0x40
[   91.992530] Code: 66 90 0f 1f 44 00 00 49 89 f8 48 89 d7 48 c7 c6 5f b1 =
b2 89 41 8b 80 98 02 00 00 48 8d 04 40 48 c1 e0 04 48 03 05 38 b1 3c 02 <48=
> 8b 50 20 e8 ff ee 3b 00 48 98 31 d2 89 d6 89 d7 41 89 d0 c3 0f
[   91.992533] RSP: 0018:ffffaf6141367d38 EFLAGS: 00010246
[   91.992536] RAX: 0000000000000000 RBX: ffffffff8a230ec0 RCX: 00000000000=
00000
[   91.992539] RDX: ffff99d540eab000 RSI: ffffffff89b2b15f RDI: ffff99d540e=
ab000
[   91.992541] RBP: ffffffff897567c0 R08: ffff99d5402a8000 R09: 00000000000=
00000
[   91.992543] R10: 0000000000000000 R11: 0000000000000000 R12: ffffaf61413=
67e00
[   91.992545] R13: ffffaf6141367dd8 R14: ffff99d5422585c8 R15: 00000000000=
00001
[   91.992547] FS:  00007f6825ba2600(0000) GS:ffff99d656e00000(0000) knlGS:=
0000000000000000
[   91.992550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.992553] CR2: 0000000000000020 CR3: 000000010d190003 CR4: 00000000001=
706f0
[   91.992555] Call Trace:
[   91.992558]  <TASK>
[   91.992560]  dev_attr_show+0x19/0x40
[   91.992568]  sysfs_kf_seq_show+0xa1/0x120
[   91.992577]  seq_read_iter+0x12e/0x4c0
[   91.992583]  ? __mod_memcg_lruvec_state+0x41/0x80
[   91.992592]  ? __mod_lruvec_page_state+0xa7/0x150
[   91.992599]  new_sync_read+0x159/0x1f0
[   91.992608]  vfs_read+0xff/0x1a0
[   91.992614]  ksys_read+0x67/0xf0
[   91.992619]  do_syscall_64+0x5c/0x90
[   91.992624]  ? do_user_addr_fault+0x1d7/0x6a0
[   91.992630]  ? do_syscall_64+0x69/0x90
[   91.992633]  ? exc_page_fault+0x72/0x180
[   91.992638]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   91.992644] RIP: 0033:0x7f6825ac4862
[   91.992648] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 5a 29 0a 00 e8 55 e4 01 =
00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48=
> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[   91.992650] RSP: 002b:00007ffe0cefe458 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[   91.992654] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f6825a=
c4862
[   91.992656] RDX: 0000000000020000 RSI: 00007f68256cb000 RDI: 00000000000=
00003
[   91.992658] RBP: 00007f68256cb000 R08: 00007f68256ca010 R09: 00000000000=
00000
[   91.992660] R10: 0000000000000022 R11: 0000000000000246 R12: 00000000000=
20000
[   91.992662] R13: 0000000000000003 R14: 0000000000000000 R15: 00007ffe0ce=
fe6f8
[   91.992666]  </TASK>
[   91.992668] Modules linked in: 8021q garp mrp stp llc snd_hda_codec_hdmi=
 ccm algif_aead ax88796b cbc des_generic libdes ecb algif_skcipher x86_pkg_=
temp_thermal intel_powerclamp cmac coretemp kvm_intel md4 algif_hash kvm af=
_alg irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_spi_=
platform aesni_intel asus_nb_wmi asus_wmi joydev intel_spi iTCO_wdt crypto_=
simd iwlmvm spi_nor mousedev sparse_keymap hid_multitouch cryptd intel_pmc_=
bxt i915 at24 btusb platform_profile intel_rapl_msr mac80211 mtd ak8975 btr=
tl rapl snd_hda_codec_realtek uvcvideo asix iTCO_vendor_support libarc4 snd=
_hda_codec_generic ledtrig_audio videobuf2_vmalloc mei_hdcp btbcm snd_hda_i=
ntel selftests videobuf2_memops iwlwifi intel_cstate btintel i2c_algo_bit s=
nd_intel_dspcfg videobuf2_v4l2 intel_uncore usbnet ttm snd_intel_sdw_acpi b=
tmtk videobuf2_common vfat snd_hda_codec mii psmouse pcspkr drm_kms_helper =
snd_hda_core mdio_devres bluetooth fat processor_thermal_device_pci_legacy =
cfg80211 syscopyarea videodev
[   91.992742]  processor_thermal_device snd_hwdep sysfillrect usbhid libph=
y ecdh_generic processor_thermal_rfim sysimgblt crc16 mc rfkill snd_pcm wmi=
 fb_sys_fops processor_thermal_mbox inv_mpu6050_i2c snd_timer processor_the=
rmal_rapl cec inv_mpu6050 snd intel_rapl_common acpi_als dell_smo8800 indus=
trialio_triggered_buffer mei_me int3400_thermal intel_gtt i2c_i801 int340x_=
thermal_zone i2c_mux soundcore kfifo_buf video mei intel_soc_dts_iosf lpc_i=
ch acpi_thermal_rel mac_hid i2c_smbus asus_wireless soc_button_array indust=
rialio drm fuse pkcs8_key_parser bpf_preload ip_tables x_tables xfs libcrc3=
2c crc32c_generic serio_raw atkbd libps2 crc32c_intel i8042 xhci_pci xhci_p=
ci_renesas serio
[   91.992794] CR2: 0000000000000020
[   91.992824] ---[ end trace 0000000000000000 ]---
[   91.992826] RIP: 0010:sgx_total_bytes_show+0x28/0x40
[   91.992829] Code: 66 90 0f 1f 44 00 00 49 89 f8 48 89 d7 48 c7 c6 5f b1 =
b2 89 41 8b 80 98 02 00 00 48 8d 04 40 48 c1 e0 04 48 03 05 38 b1 3c 02 <48=
> 8b 50 20 e8 ff ee 3b 00 48 98 31 d2 89 d6 89 d7 41 89 d0 c3 0f
[   91.992831] RSP: 0018:ffffaf6141367d38 EFLAGS: 00010246
[   91.992833] RAX: 0000000000000000 RBX: ffffffff8a230ec0 RCX: 00000000000=
00000
[   91.992835] RDX: ffff99d540eab000 RSI: ffffffff89b2b15f RDI: ffff99d540e=
ab000
[   91.992836] RBP: ffffffff897567c0 R08: ffff99d5402a8000 R09: 00000000000=
00000
[   91.992838] R10: 0000000000000000 R11: 0000000000000000 R12: ffffaf61413=
67e00
[   91.992839] R13: ffffaf6141367dd8 R14: ffff99d5422585c8 R15: 00000000000=
00001
[   91.992841] FS:  00007f6825ba2600(0000) GS:ffff99d656e00000(0000) knlGS:=
0000000000000000
[   91.992843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.992844] CR2: 0000000000000020 CR3: 000000010d190003 CR4: 00000000001=
706f0

--kO/GpfGXlbU26p1X--

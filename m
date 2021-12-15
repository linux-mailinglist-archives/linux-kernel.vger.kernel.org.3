Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF464475379
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhLOHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:02:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:23780 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235852AbhLOHCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639551743; x=1671087743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2p33wjph5Fjd4sStLWfrUjYKlfn5BXUR9OqM6vGdkNw=;
  b=l7EJGs8EYT3KDQHQeBiRp6WdsRjo0slKN/pC0PK4l5lBjGP5HyKce+QT
   A3kpWZl7yQSSpOzaQ/KGXr9knsWNsDHNTPltIuH3wH8/i/lrqkNj8t07x
   9WG8HHa5C8VulEKV1D/mn7Ew8+vj0wFgLCOUlVW0bJgIEUYwAuQv4M8Fp
   OUT5/cDC97jTNFqikVVYQbsYErpvqxT52x3Bje6aadtrj7voT2Kmu48eS
   gNoqRNrsjuBQDkiwzN7RFEk3r/vAiY+3aW1YqAtcjUtTcRgaW7sFrcmio
   rWlJ5go7ZPZDMYTfWi3yl6tz9xU33Ce0ikzhmZafXjtxdPnFlT3mby0NW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226023278"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226023278"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 23:02:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518633917"
Received: from carel.sh.intel.com (HELO linux.intel.com) ([10.239.158.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 23:02:15 -0800
Date:   Wed, 15 Dec 2021 15:00:13 +0800
From:   Carel Si <beibei.si@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [x86/mm/64]  f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <20211215070012.GA26582@linux.intel.com>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YbjIoewxGaodXHKF@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, Dec 14, 2021 at 05:38:57PM +0100, Borislav Petkov wrote:
> On Thu, Dec 09, 2021 at 10:41:41PM +0800, kernel test robot wrote:
> >=20
> >=20
> > Greeting,
> >=20
> > FYI, we noticed the following commit (built with clang-14):
> >=20
> > commit: f154f290855b070cc94dd44ad253c0ef8a9337bb ("x86/mm/64: Flush glo=
bal TLB on boot and AP bringup")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> >=20
> > in testcase: boot
> >=20
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 16G
> >=20
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >=20
> >=20
> > +-------------------------------------------------+------------+-------=
-----+
> > |                                                 | 9de4999050 | f154f2=
9085 |
> > +-------------------------------------------------+------------+-------=
-----+
> > | BUG:kernel_reboot-without-warning_in_boot_stage | 0          | 13    =
     |
> > +-------------------------------------------------+------------+-------=
-----+
> >=20
> >=20
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >=20
> >=20
> > Physical KASLR using RDTSC...
> > Virtual KASLR using RDTSC...
> >=20
> > Decompressing Linux... Parsing ELF... Performing relocations... done.
> > Booting the kernel.
> > BUG: kernel reboot-without-warning in boot stage
> > Linux version 5.16.0-rc3-00003-gf154f290855b #1
> > Command line: ip=3D::::vm-snb-192::dhcp root=3D/dev/ram0 user=3Dlkp job=
=3D/lkp/jobs/scheduled/vm-snb-192/boot-1-debian-10.4-x86_64-20200603.cgz-f1=
54f290855b070cc94dd44ad253c0ef8a9337bb-20211208-23538-lnvkeg-5.yaml ARCH=3D=
x86_64 kconfig=3Dx86_64-randconfig-a013-20211207 branch=3Dtip/x86/mm commit=
=3Df154f290855b070cc94dd44ad253c0ef8a9337bb BOOT_IMAGE=3D/pkg/linux/x86_64-=
randconfig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/=
vmlinuz-5.16.0-rc3-00003-gf154f290855b vmalloc=3D128M initramfs_async=3D0 p=
age_owner=3Don max_uptime=3D600 RESULT_ROOT=3D/result/boot/1/vm-snb/debian-=
10.4-x86_64-20200603.cgz/x86_64-randconfig-a013-20211207/clang-14/f154f2908=
55b070cc94dd44ad253c0ef8a9337bb/3 LKP_SERVER=3Dinternal-lkp-server selinux=
=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=
=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 =
nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.=
minor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earl=
yprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutd=
own=3D0 watchdog_thresh=3D240
> >=20
> > Kboot worker: lkp-worker30
> > Elapsed time: 60
>=20
> My guest boots fine here on an AMD host, albeit it takes a while until
> "Booting the kernel" appears.
>=20
> You probably should verify by hand whether your guest simply needs
> longer before it starts booting the kernel...

We have verified by hand, still can reproduce this issue.=20

We also double checked, this issue still exists in 35fa745286 ("x86/mm: Inc=
lude=20
spinlock_t definition in pgtable") which is the head of tip/x86/mm, thanks.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  clang-14/x86_64-randconfig-a013-20211207/debian-10.4-x86_64-20200603.cgz/=
1/vm-snb/boot

commit:=20
  9de4999050 ("x86/realmode: Add comment for Global bit usage in trampoline=
_pgd")
  f154f29085 ("x86/mm/64: Flush global TLB on boot and AP bringup")=20
  35fa745286 ("x86/mm: Include spinlock_t definition in pgtable.")

9de4999050b5f2e8 f154f290855b070cc94dd44ad25 35fa745286ac44ee26ed100c2bd=20
---------------- --------------------------- ---------------------------=20
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |   =20
           :27         100%          27:27         100%          27:27    d=
mesg.BUG:kernel_reboot-without-warning_in_boot_stage

>=20
> early console in setup code
> early console in extract_kernel
> input_data: 0x0000000005ce82e0
> input_len: 0x0000000001d21920
> output: 0x0000000001000000
> output_len: 0x000000000650d2ec
> kernel_total_size: 0x0000000006e2c000
> needed_size: 0x0000000007000000
> trampoline_32bit: 0x000000000009d000
> Physical KASLR using RDTSC...
> Virtual KASLR using RDTSC...
>=20
> Decompressing Linux... Parsing ELF... Performing relocations... done.
> Booting the kernel.
> [    0.000000][    T0] Linux version 5.16.0-rc3-00005-g35fa745286ac (bori=
s@zn) (ClangBuiltLinux clang version 14.0.0 (https://github.com/llvm/llvm-p=
roject 08a770c378ca5d8975ef305d15f297c3f980d186), GNU ld (GNU Binutils for =
Debian) 2.37) #3 PREEMPT Tue Dec 14 17:29:41 CET 2021
> [    0.000000][    T0] Command line: root=3D/dev/sda1 resume=3D/dev/sda2 =
debug ignore_loglevel log_buf_len=3D16M earlyprintk=3DttyS0,115200 console=
=3DttyS0,115200 console=3Dtty0 no_console_suspend net.ifnames=3D0=20
> [    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floa=
ting point registers'
> [    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regi=
sters'
> [    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regi=
sters'
> [    0.000000][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]: =
 256
> [    0.000000][    T0] x86/fpu: Enabled xstate features 0x7, context size=
 is 832 bytes, using 'standard' format.
> [    0.000000][    T0] signal: max sigframe size: 1360
> [    0.000000][    T0] printk: debug: ignoring loglevel setting.
> [    0.000000][    T0] printk: bootconsole [earlyser0] enabled
> [    0.000000][    T0] BIOS-provided physical RAM map:
> ...
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG N=FCrn=
berg
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

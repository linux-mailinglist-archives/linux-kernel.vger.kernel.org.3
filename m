Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FAD48DB01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiAMPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:50:18 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36008 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiAMPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:50:17 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3E4C672C8DC;
        Thu, 13 Jan 2022 18:50:15 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 2E83B7CCA5E; Thu, 13 Jan 2022 18:50:14 +0300 (MSK)
Date:   Thu, 13 Jan 2022 18:50:14 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        strace-devel@lists.strace.io
Subject: Re: [PATCH] powerpc/audit: Simplify syscall_get_arch()
Message-ID: <20220113155014.GA26100@altlinux.org>
References: <4be53b9187a4d8c163968f4d224267e41a7fcc33.1629451479.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be53b9187a4d8c163968f4d224267e41a7fcc33.1629451479.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 09:39:14AM +0000, Christophe Leroy wrote:
> Make use of is_32bit_task() and CONFIG_CPU_LITTLE_ENDIAN
> to simplify syscall_get_arch().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/syscall.h | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Unfortunately, this commit breaks PTRACE_GET_SYSCALL_INFO and therefore
breaks strace support of AUDIT_ARCH_PPC personality on ppc64.

I've got the following report from the test farm:

=====================================================
   strace 5.16: tests-m32/test-suite.log
=====================================================

# TOTAL: 1184
# PASS:  138
# SKIP:  189
# XFAIL: 0
# FAIL:  857
# XPASS: 0
# ERROR: 0

$ hostname -f
gcc203.fsffrance.org
$ uname -a
Linux gcc203 5.15.0-2-powerpc64 #1 SMP Debian 5.15.5-2 (2021-12-18) ppc64 GNU/Linux

It boils down to
$ echo 'int main(){return 0;}' |gcc -m32 -xc -
$ strace --trace=none ./a.out 
syscall_0xc0(0, 0x18357, 0x1, 0x2, 0x3, 0) = 0xf7930000
syscall_0xc0(0x390000, 0x2089c0, 0x5, 0x802, 0x3, 0) = 0x390000
syscall_0xc0(0x580000, 0x20000, 0x3, 0x812, 0x3, 0x1e0) = 0x580000
+++ exited with 0 +++

$ strace -qq --signal=none --trace=ptrace strace -qq --trace=none -o/dev/null ./a.out
...
ptrace(PTRACE_GET_SYSCALL_INFO, 1234567, 88, {op=PTRACE_SYSCALL_INFO_ENTRY, arch=AUDIT_ARCH_PPC64, instruction_pointer=0xf7b34594, stack_pointer=0xffecfbf0, entry={nr=192, args=[0, 0x18357, 0x1, 0x2, 0x3, 0]}}) = 80
ptrace(PTRACE_SYSCALL, 1234567, NULL, 0) = 0
ptrace(PTRACE_GET_SYSCALL_INFO, 1234567, 88, {op=PTRACE_SYSCALL_INFO_EXIT, arch=AUDIT_ARCH_PPC64, instruction_pointer=0xf7b34594, stack_pointer=0xffecfbf0, exit={rval=4155441152, is_error=0}}) = 33
) = 0xf7af0000

As you can see, arch=AUDIT_ARCH_PPC64 is wrong here and causes all the damage.

> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index ba0f88f3a30d..ac766037e8a1 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -116,16 +116,11 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  
>  static inline int syscall_get_arch(struct task_struct *task)
>  {
> -	int arch;
> -
> -	if (IS_ENABLED(CONFIG_PPC64) && !test_tsk_thread_flag(task, TIF_32BIT))
> -		arch = AUDIT_ARCH_PPC64;
> +	if (is_32bit_task())
> +		return AUDIT_ARCH_PPC;
> +	else if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> +		return AUDIT_ARCH_PPC64LE;
>  	else
> -		arch = AUDIT_ARCH_PPC;
> -
> -#ifdef __LITTLE_ENDIAN__
> -	arch |= __AUDIT_ARCH_LE;
> -#endif
> -	return arch;
> +		return AUDIT_ARCH_PPC64;
>  }
>  #endif	/* _ASM_SYSCALL_H */

Please revert or fix.


-- 
ldv

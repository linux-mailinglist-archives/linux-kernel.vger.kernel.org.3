Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7444C28EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiBXKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiBXKKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:10:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA7F228ADAA;
        Thu, 24 Feb 2022 02:10:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5609ED1;
        Thu, 24 Feb 2022 02:10:09 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0349E3F70D;
        Thu, 24 Feb 2022 02:10:07 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:10:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 03/11] arm64: gunyah: Add Gunyah hypercalls ABI
Message-ID: <YhdZen7MwdAIJMsu@lakrids>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220223233729.1571114-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223233729.1571114-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a general thing, this is the *only* patch from this series which has
been Cc'd to linux-arm-kernel, which makes it practically impossible to
understand the context for this, which is somewhat frustrating.

Looking on lore.kernel.org I see that the entire series was Cc'd to
linux-arm-msm, but most people don't subscribe to that list. If you send
one patch in a series to a list, please send the *entire* series there.

On Wed, Feb 23, 2022 at 03:37:21PM -0800, Elliot Berman wrote:
> Add initial support to perform Gunyah hypercalls. The arm64 ABI for
> Gunyah hypercalls generally follows the AAPCS64, and can be summarized:
>  - Function identifier is passed through the imm operand
>  - [r0,r7] are parameter and result registers
>  - [r8-r18] are temporary and saved by the caller (VM)
>  - [r19-r31] are preserved and saved by the hypervisor
>
> The preprocessor macors for creating the necessary HVC instruction
> roughly follows the SMCCC 1.1 implementation in
> include/linux/arm-smccc.h.

I've added the SMCCC maintainers (myself, Lorenzo, and SUdeep) to Cc,
and also Marc who was involvedi n prior discussions in this area. Please
Cc us on any future patches adding HVC or SMCC interfaces (SMCCC or
otherwise).

We've previously said NO to any new hypercall mechanisms which do not
follow SMCCC. There is no reason to fragment this space further; please
use SMCCC (which your hypervisor must already implement in part if it
exposes PSCI to a guest).

NAK to this non-SMCCC interface.

Thanks,
Mark.

> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS                               |   1 +
>  arch/arm64/include/asm/gunyah/hypercall.h | 193 ++++++++++++++++++++++
>  2 files changed, 194 insertions(+)
>  create mode 100644 arch/arm64/include/asm/gunyah/hypercall.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a918f653eac..7e6a8488fa3e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8402,6 +8402,7 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/gunyah/
>  F:	Documentation/virt/gunyah/
> +F:	arch/arm64/include/asm/gunyah/
>  
>  H8/300 ARCHITECTURE
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/arch/arm64/include/asm/gunyah/hypercall.h b/arch/arm64/include/asm/gunyah/hypercall.h
> new file mode 100644
> index 000000000000..626163500e32
> --- /dev/null
> +++ b/arch/arm64/include/asm/gunyah/hypercall.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef __ASM_GH_HYPERCALL_H
> +#define __ASM_GH_HYPERCALL_H
> +
> +#include <linux/types.h>
> +
> +#define ___gh_count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
> +
> +#define __gh_count_args(...)						\
> +	___gh_count_args(_, ## __VA_ARGS__, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +
> +#define __gh_skip_0(...)		__VA_ARGS__
> +#define __gh_skip_1(a, ...)	__VA_ARGS__
> +#define __gh_skip_2(a, b, ...)	__VA_ARGS__
> +#define __gh_skip_3(a, b, c, ...)	__VA_ARGS__
> +#define __gh_skip_4(a, b, c, d, ...)	__VA_ARGS__
> +#define __gh_skip_5(a, b, c, d, e, ...)	__VA_ARGS__
> +#define __gh_skip_6(a, b, c, d, e, f, ...)	__VA_ARGS__
> +#define __gh_skip_7(a, b, c, d, e, f, g, ...)	__VA_ARGS__
> +#define __gh_skip_8(a, b, c, d, e, f, g, h, ...)	__VA_ARGS__
> +
> +#define __gh_declare_arg_0(...)
> +
> +#define __gh_declare_arg_1(a1, ...)					\
> +	typeof(a1) __gh_a1 = (a1);					\
> +	register uintptr_t arg1 asm("r0") = __gh_a1
> +
> +#define __gh_declare_arg_2(a1, a2, ...)					\
> +	__gh_declare_arg_1(a1);						\
> +	typeof(a2) __gh_a2 = (a2);					\
> +	register uintptr_t arg2 asm("r1") = __gh_a2
> +
> +#define __gh_declare_arg_3(a1, a2, a3, ...)				\
> +	__gh_declare_arg_2(a1, a2);					\
> +	typeof(a3) __gh_a3 = (a3);					\
> +	register uintptr_t arg3 asm("r2") = __gh_a3
> +
> +#define __gh_declare_arg_4(a1, a2, a3, a4, ...)				\
> +	__gh_declare_arg_3(a1, a2, a3);					\
> +	typeof(a4) __gh_a4 = (a4);					\
> +	register uintptr_t arg4 asm("r3") = __gh_a4
> +
> +#define __gh_declare_arg_5(a1, a2, a3, a4, a5, ...)			\
> +	__gh_declare_arg_4(a1, a2, a3, a4);				\
> +	typeof(a5) __gh_a5 = (a5);					\
> +	register uintptr_t arg5 asm("r4") = __gh_a5
> +
> +#define __gh_declare_arg_6(a1, a2, a3, a4, a5, a6, ...)			\
> +	__gh_declare_arg_5(a1, a2, a3, a4, a5);				\
> +	typeof(a6) __gh_a6 = (a6);					\
> +	register uintptr_t arg6 asm("r5") = __gh_a6
> +
> +#define __gh_declare_arg_7(a1, a2, a3, a4, a5, a6, a7, ...)		\
> +	__gh_declare_arg_6(a1, a2, a3, a4, a5, a6);			\
> +	typeof(a7) __gh_a7 = (a7);					\
> +	register uintptr_t arg7 asm("r6") = __gh_a7
> +
> +#define __gh_declare_arg_8(a1, a2, a3, a4, a5, a6, a7, a8, ...)		\
> +	__gh_declare_arg_7(a1, a2, a3, a4, a5, a6, a7);			\
> +	typeof(a8) __gh_a8 = (a8);					\
> +	register uintptr_t arg8 asm("r7") = __gh_a8
> +
> +#define ___gh_declare_args(nargs)	__gh_declare_arg_ ## nargs
> +#define __gh_declare_args(nargs)	___gh_declare_args(nargs)
> +#define _gh_declare_args(nargs, ...) __gh_declare_args(nargs)(__VA_ARGS__)
> +
> +#define __gh_constraint_arg_0
> +#define __gh_constraint_arg_1	"r" (arg1),
> +#define __gh_constraint_arg_2	__gh_constraint_arg_1 "r" (arg2),
> +#define __gh_constraint_arg_3	__gh_constraint_arg_2 "r" (arg3),
> +#define __gh_constraint_arg_4	__gh_constraint_arg_3 "r" (arg4),
> +#define __gh_constraint_arg_5	__gh_constraint_arg_4 "r" (arg5),
> +#define __gh_constraint_arg_6	__gh_constraint_arg_5 "r" (arg6),
> +#define __gh_constraint_arg_7	__gh_constraint_arg_6 "r" (arg7),
> +#define __gh_constraint_arg_8	__gh_constraint_arg_7 "r" (arg8),
> +
> +#define _gh_constraint_args(nargs)	__gh_constraint_arg_ ## nargs
> +
> +#define __gh_to_res(nargs, ...)		__gh_skip_ ## nargs (__VA_ARGS__)
> +
> +#define __gh_declare_res_0
> +
> +#define __gh_declare_res_1				\
> +	register uintptr_t res1 asm("r0")
> +
> +#define __gh_declare_res_2				\
> +	__gh_declare_res_1;				\
> +	register uintptr_t res2 asm("r1")
> +
> +#define __gh_declare_res_3				\
> +	__gh_declare_res_2;				\
> +	register uintptr_t res3 asm("r2")
> +
> +#define __gh_declare_res_4				\
> +	__gh_declare_res_3;				\
> +	register uintptr_t res4 asm("r3")
> +
> +#define __gh_declare_res_5				\
> +	__gh_declare_res_4;				\
> +	register uintptr_t res5 asm("r4")
> +
> +#define __gh_declare_res_6				\
> +	__gh_declare_res_5;				\
> +	register uintptr_t res6 asm("r5")
> +
> +#define __gh_declare_res_7				\
> +	__gh_declare_res_6;				\
> +	register uintptr_t res7 asm("r6")
> +
> +#define __gh_declare_res_8				\
> +	__gh_declare_res_7;				\
> +	register uintptr_t res8 asm("r7")
> +
> +#define ___gh_declare_res(nargs)	__gh_declare_res_ ## nargs
> +#define __gh_declare_res(nargs)		___gh_declare_res(nargs)
> +#define _gh_declare_res(...)		__gh_declare_res(__gh_count_args(__VA_ARGS__))
> +
> +#define __gh_constraint_res_0
> +#define __gh_constraint_res_1	"=r" (res1)
> +#define __gh_constraint_res_2	__gh_constraint_res_1, "=r" (res2)
> +#define __gh_constraint_res_3	__gh_constraint_res_2, "=r" (res3)
> +#define __gh_constraint_res_4	__gh_constraint_res_3, "=r" (res4)
> +#define __gh_constraint_res_5	__gh_constraint_res_4, "=r" (res5)
> +#define __gh_constraint_res_6	__gh_constraint_res_5, "=r" (res6)
> +#define __gh_constraint_res_7	__gh_constraint_res_6, "=r" (res7)
> +#define __gh_constraint_res_8	__gh_constraint_res_7, "=r" (res8)
> +
> +#define ___gh_constraint_res(nargs)	__gh_constraint_res_ ## nargs
> +#define __gh_constraint_res(nargs)	___gh_constraint_res(nargs)
> +#define _gh_constraint_res(...)				\
> +	__gh_constraint_res(__gh_count_args(__VA_ARGS__))
> +
> +#define __gh_assign_res_0(...)
> +
> +#define __gh_assign_res_1(r1)					\
> +	r1 = res1;
> +
> +#define __gh_assign_res_2(r1, r2)				\
> +	__gh_assign_res_1(r1);					\
> +	r2 = res2
> +
> +#define __gh_assign_res_3(r1, r2, r3)				\
> +	__gh_assign_res_2(r1, r2);				\
> +	r3 = res3
> +
> +#define __gh_assign_res_4(r1, r2, r3, r4)			\
> +	__gh_assign_res_3(r1, r2, r3);				\
> +	r4 = res4
> +
> +#define __gh_assign_res_5(r1, r2, r3, r4, r5)			\
> +	__gh_assign_res_4(r1, r2, r3, r4);			\
> +	r5 = res5
> +
> +#define __gh_assign_res_6(r1, r2, r3, r4, r5, r6)		\
> +	__gh_assign_res_5(r1, r2, r3, r4, r5);			\
> +	r6 = res6
> +
> +#define __gh_assign_res_7(r1, r2, r3, r4, r5, r6, r7)		\
> +	__gh_assign_res_6(r1, r2, r3, r4, r5, r6);		\
> +	r7 = res7
> +
> +#define __gh_assign_res_8(r1, r2, r3, r4, r5, r6, r7, r8)	\
> +	__gh_assign_res_7(r1, r2, r3, r4, r5, r6, r7);		\
> +	r8 = res8
> +
> +#define ___gh_assign_res(nargs)	__gh_assign_res_ ## nargs
> +#define __gh_assign_res(nargs)	___gh_assign_res(nargs)
> +#define _gh_assign_res(...) __gh_assign_res(__gh_count_args(__VA_ARGS__))(__VA_ARGS__)
> +
> +/**
> + * arch_gh_hypercall() - Performs an AArch64-specific call into hypervisor using Gunyah ABI
> + * @hcall_num: Hypercall function ID to invoke
> + * @nargs: Number of input arguments
> + * @...: First nargs are the input arguments. Remaining arguments are output variables.
> + */
> +#define arch_gh_hypercall(hcall_num, nargs, ...)				\
> +	do {									\
> +		_gh_declare_res(__gh_to_res(nargs, __VA_ARGS__));		\
> +		_gh_declare_args(nargs, __VA_ARGS__);				\
> +		asm volatile(							\
> +			     "hvc	%[num]\n"				\
> +			     : _gh_constraint_res(__gh_to_res(nargs, __VA_ARGS__))	\
> +			     : _gh_constraint_args(nargs)			\
> +			       [num] "i" (hcall_num)				\
> +			     : "x9", "x10", "x11", "x12", "x13", "x14", "x15", "x16", "x17", \
> +			       "memory");					\
> +		_gh_assign_res(__gh_to_res(nargs, __VA_ARGS__));		\
> +	} while (0)
> +
> +#endif
> -- 
> 2.25.1
> 

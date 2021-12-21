Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4847C7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbhLUTl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:41:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:54837 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234571AbhLUTl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:41:56 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1BLJaAxU013501;
        Tue, 21 Dec 2021 13:36:10 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 1BLJa9FH013500;
        Tue, 21 Dec 2021 13:36:09 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 21 Dec 2021 13:36:08 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] powerpc/vdso: augment VDSO32 functions to support 64 bits build
Message-ID: <20211221193608.GD614@gate.crashing.org>
References: <09b25a22cd5179eba4580ae95414f18fc162bedf.1640108961.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b25a22cd5179eba4580ae95414f18fc162bedf.1640108961.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:49:33PM +0000, Christophe Leroy wrote:
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
> index 65244416ab94..db8e167f0166 100644
> --- a/arch/powerpc/kernel/vdso32/datapage.S
> +++ b/arch/powerpc/kernel/vdso32/datapage.S
> @@ -30,11 +30,15 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
>  	mr.	r4,r3
>  	get_datapage	r3
>  	mtlr	r12
> +#ifdef __powerpc64__
> +	addi	r3,r3,CFG_SYSCALL_MAP64
> +#else
>  	addi	r3,r3,CFG_SYSCALL_MAP32
> +#endif
> +	crclr	cr0*4+so
>  	beqlr
>  	li	r0,NR_syscalls
>  	stw	r0,0(r4)
> -	crclr	cr0*4+so
>  	blr

This now clears cr0.3 if r3 is zero on entry.  Is that on purpose?

Rest looks good.

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher

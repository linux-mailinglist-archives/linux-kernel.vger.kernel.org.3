Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B055212F9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiEJLD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiEJLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:03:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE5623AE44;
        Tue, 10 May 2022 03:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC9E6B81C64;
        Tue, 10 May 2022 10:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697D8C385C6;
        Tue, 10 May 2022 10:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652180394;
        bh=mP4OuZOhZwV/dmB0cFoVtzXacKFaCfNyN7n0iv1nrYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faKPlVCxpkkG+QMDYcrORj/z3MB5YVFqVu+wQbcaXs0+6tfnQX0e8v5XuzT70UFh/
         CFLz978/VZkKdqD2rpT3tdddkPoibz/Vv0lgkzMx1B4I4d4p/58knNF8Y/vOwesRqQ
         RDH3snK1vaizTlvvk38vPSmYEaPI2W7gRXyQ/sL7XwoEFGzoEZdmrqvZfTcfUyH9GE
         Pt2LsQGvvSnAW73WmE789tP9DT0fT+eotIpxrELWuth2dYipmMFRfDzsfHeanyIpUi
         3A7s6ky9+vlTiTXBBTljVMB9W3myNjG5ys1s0RwUQWzDhXrQCMuhvcBEYOzvqyW68c
         CeT3cBJ4Mcbgg==
Date:   Tue, 10 May 2022 11:59:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-trace-devel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Kiss <daniel.kiss@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] arm64: Forget syscall if different from
 execve*()
Message-ID: <20220510105948.GB27557@willie-the-truck>
References: <20220509151958.441240-1-flaniel@linux.microsoft.com>
 <20220509151958.441240-2-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509151958.441240-2-flaniel@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:19:57PM +0100, Francis Laniel wrote:
> This patch enables exeve*() to be traced by syscalls:sys_exit_execve
> tracepoint.
> Previously, calling forget_syscall() would set syscall to -1, which impedes
> this tracepoint to prints its information.
> So, this patch makes call to forget_syscall() conditional by only calling
> it when syscall number is not execve() or execveat().
> 
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/processor.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 73e38d9a540c..e12ceb363d6a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -34,6 +34,8 @@
>  
>  #include <vdso/processor.h>
>  
> +#include <asm-generic/unistd.h>
> +
>  #include <asm/alternative.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hw_breakpoint.h>
> @@ -250,8 +252,12 @@ void tls_preserve_current_state(void);
>  
>  static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
>  {
> +	s32 previous_syscall = regs->syscallno;
>  	memset(regs, 0, sizeof(*regs));
> -	forget_syscall(regs);
> +	if (previous_syscall == __NR_execve || previous_syscall == __NR_execveat)
> +		regs->syscallno = previous_syscall;
> +	else
> +		forget_syscall(regs);

Hmm, this really looks like a bodge and it doesn't handle the compat case
either.

How do other architectures handle this?

Will

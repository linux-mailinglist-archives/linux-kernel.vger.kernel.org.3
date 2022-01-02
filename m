Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD0482B6E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiABNc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:32:59 -0500
Received: from elvis.franken.de ([193.175.24.41]:52744 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbiABNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:32:54 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n40yi-0002m7-06; Sun, 02 Jan 2022 14:32:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0406DC0A4B; Sun,  2 Jan 2022 14:31:22 +0100 (CET)
Date:   Sun, 2 Jan 2022 14:31:22 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] MIPS: signal: Return immediately if call fails
Message-ID: <20220102133122.GG3468@alpha.franken.de>
References: <1639974460-3278-1-git-send-email-yangtiezhu@loongson.cn>
 <1639974460-3278-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639974460-3278-3-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:27:39PM +0800, Tiezhu Yang wrote:
> When debug sigaltstack(), copy_siginfo_to_user() fails first in
> setup_rt_frame() if the alternate signal stack is too small, so
> it should return immediately if call fails, no need to call the
> following functions.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/kernel/signal.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index c1632e8..5bce782 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -754,23 +754,25 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
>  			  struct pt_regs *regs, sigset_t *set)
>  {
>  	struct rt_sigframe __user *frame;
> -	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
>  	if (!access_ok(frame, sizeof (*frame)))
>  		return -EFAULT;
>  
>  	/* Create siginfo.  */
> -	err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
> +	if (copy_siginfo_to_user(&frame->rs_info, &ksig->info))
> +		return -EFAULT;
>  
>  	/* Create the ucontext.	 */
> -	err |= __put_user(0, &frame->rs_uc.uc_flags);
> -	err |= __put_user(NULL, &frame->rs_uc.uc_link);
> -	err |= __save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
> -	err |= setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
> -	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
> -
> -	if (err)
> +	if (__put_user(0, &frame->rs_uc.uc_flags))
> +		return -EFAULT;
> +	if (__put_user(NULL, &frame->rs_uc.uc_link))
> +		return -EFAULT;
> +	if (__save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]))
> +		return -EFAULT;
> +	if (setup_sigcontext(regs, &frame->rs_uc.uc_mcontext))
> +		return -EFAULT;
> +	if (__copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set)))
>  		return -EFAULT;
>  
>  	/*
> -- 
> 2.1.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

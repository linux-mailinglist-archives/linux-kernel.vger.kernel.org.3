Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F454797EF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 01:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhLRAxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 19:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhLRAxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 19:53:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yo7plhOiy8BmHyIRU9snpt6EXOlgpuRdS2kKCN6BxCs=; b=Pk8uiSgxJNK4vtqksU80GM/RTE
        QpHcCTdGm2DzEdyKCYYH477WNecK+gv7RaA/YOVMyuZ82M6mQ1hiMZBC41EkX6xus/MlA2BLE/3Wz
        NavNKRk1uv6ty7R0lxLrQFAkLSk6/bY1pZZfLclctpphsvzWiyPl6HGE5zXsuDxzd5c72k7djiZJi
        jnpv/uZL0dUYH/2I7y9Iz9MrTgy3+gtkBpZcdBqiVt3uKY2vm47E5UV/2QWKvWxNTrOiS/OTZs2Lu
        rT+IvisG6wmSSYhNPQbNOnReNpTDWO15Jp8di8Bu4vIxwwanaTaKFWGUOsPRNY81ALuVUZuGxO+K+
        V701Dr4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myNyU-00HCxZ-9Z; Sat, 18 Dec 2021 00:53:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0FB39862C8; Sat, 18 Dec 2021 01:53:22 +0100 (CET)
Date:   Sat, 18 Dec 2021 01:53:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/mce: Reduce number of machine checks taken during
 recovery
Message-ID: <20211218005322.GM16608@worktop.programming.kicks-ass.net>
References: <20211215222016.1390235-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215222016.1390235-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 02:20:16PM -0800, Tony Luck wrote:
> ---
>  arch/x86/lib/copy_user_64.S | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index 2797e630b9b1..8c53be99faa0 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -233,12 +233,19 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   * eax uncopied bytes or 0 if successful.
>   */
>  SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
> +	cmp $X86_TRAP_MC,%eax
> +	je 3f
>  	movl %edx,%ecx
>  1:	rep movsb
>  2:	mov %ecx,%eax
>  	ASM_CLAC
>  	ret
>  
> +3:
> +	movl %edx,%eax
> +	ASM_CLAC
> +	ret
> +
>  	_ASM_EXTABLE_CPY(1b, 2b)
>  SYM_CODE_END(.Lcopy_user_handle_tail)

This patch no longer applies; however, you forgot to change the comment
on top about the calling convention, because now the function expects
rax to contain the trap number.

It's also not obvious from the massive rambling on top that all
callsites were audited to make sure this is in fact true (it appears
so).


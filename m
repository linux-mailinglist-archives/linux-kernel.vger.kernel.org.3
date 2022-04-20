Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F4508D61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380623AbiDTQfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380628AbiDTQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:35:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3643EDC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:32:54 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 631221EC0104;
        Wed, 20 Apr 2022 18:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650472367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UyBlcyj9qmPmLqcx+Y9IVqbgazV7crvGV9M069W33g=;
        b=kiEG+mOgRrJDs9kkDSzfs3HRsquiuc6o84iYCAbyH3h3FzrMTnqNZ0q6kk9yoTRfMqMzbK
        07895Hkv4GbvryjlB/upmx0ALyblW2kpYs5XqVAGBic4V7EPHZTt75s6QLgHy/DDQbxxD9
        fWf7k+nbG2V4scjKjixDxI6Kq+LQ/A8=
Date:   Wed, 20 Apr 2022 18:32:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        =?utf-8?Q?J=C3=BCrgen?= Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V5 5/7] x86/entry: Don't call error_entry() for XENPV
Message-ID: <YmA1q3PyEEWmDtQy@zn.tnic>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
 <20220412121541.4595-6-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412121541.4595-6-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:15:39PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> When in XENPV, it is already in the task stack, and it can't fault for
> native_iret() nor native_load_gs_index() since XENPV uses its own pvops
> for IRET and load_gs_index().  And it doesn't need to switch the CR3.
> 
> So there is no reason to call error_entry() in XENPV.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/entry_64.S | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 7b6a0f15bb20..3aca7815fe79 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -328,8 +328,17 @@ SYM_CODE_END(ret_from_fork)
>  	PUSH_AND_CLEAR_REGS
>  	ENCODE_FRAME_POINTER
>  
> -	call	error_entry
> -	movq	%rax, %rsp			/* switch to the task stack if from userspace */
> +	/*
> +	 * Call error_entry() and switch to the task stack if from userspace.
> +	 *
> +	 * When in XENPV, it is already in the task stack, and it can't fault
> +	 * for native_iret() nor native_load_gs_index() since XENPV uses its
> +	 * own pvops for IRET and load_gs_index().  And it doesn't need to
> +	 * switch the CR3.  So it can skip invoking error_entry().
> +	 */
> +	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
> +		"", X86_FEATURE_XENPV
> +
>  	ENCODE_FRAME_POINTER
>  	UNWIND_HINT_REGS
>  
> -- 

This one needs Jürgen. CCed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0CF58A937
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiHEKIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiHEKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:08:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539E6715E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 03:08:47 -0700 (PDT)
Received: from zn.tnic (p200300ea971b986e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:986e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98D2B1EC026E;
        Fri,  5 Aug 2022 12:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659694121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DzpHSX+K7eDfGmnf5Dvnwuyfcl/ODD52jf3Fxqq6t/8=;
        b=f/5/Evroe8+QTeUxraBf31sfPJVGKvtwt/Lvx1QwsWFkz1Pd6rdR+IgKW4d3pgoPHrIbUd
        /AFShydYAKPgmOQ3P2mGwxZzizTdc7pb58LuGhZQb17ybmDGOjPkCyYd25qx5vztOTY/pl
        W3w2GyFuo/CuN1Ak0ZlEGJ6xqtitiFA=
Date:   Fri, 5 Aug 2022 12:08:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2]  x86,mm: print likely CPU at segfault time
Message-ID: <YuzsJfHi+qV6Z16E@zn.tnic>
References: <20220804155450.08c5b87e@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804155450.08c5b87e@imladris.surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:54:50PM -0400, Rik van Riel wrote:
> Add a printk() to show_signal_msg() to print the CPU, core, and socket
> at segfault time. This is not perfect, since the task might get rescheduled
> on another CPU between when the fault hit, and when the message is printed,
> but in practice this has been good enough to help us identify several bad
> CPU cores.
> 
> segfault[1349]: segfault at 0 ip 000000000040113a sp 00007ffc6d32e360 error 4 in segfault[401000+1000] on CPU 0 (core 0, socket 0)

And what happens when someone is looking at this, the CPU information is
wrong because we got rescheduled but...

> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> CC: Dave Jones <dsj@fb.com>
> ---
>  arch/x86/mm/fault.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index fad8faa29d04..a9b93a7816f9 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -769,6 +769,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>  		unsigned long address, struct task_struct *tsk)
>  {
>  	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
> +	/* This is a racy snapshot, but it's better than nothing. */

... someone is missing this important tidbit here that the CPU info
above is unreliable?

Someone is sent on a wild goose chase.

Can't you read out the CPU number before interrupts are enabled and hand
it down for printing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

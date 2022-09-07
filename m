Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A032E5AFAC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIGDqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGDpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:45:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5092A72C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:45:52 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F1DD1EC0523;
        Wed,  7 Sep 2022 05:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662522344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vlkirMfByXPzhCps8z54tw65b5X5xObKeOI7pZLJdWc=;
        b=LoWISRHJdscjvIFngleNb/Qtv3A4Z7OWOGiOstHh5KD7q/FDK0ipFv+5uCVgwSNcRMgAsz
        7MsoH6pxgmalG51Re8s8K1oU8A832ruu5Jx3kpdyEluQc9SXUP0uMuMSbc4q/SdvEEi69h
        pXRmRzmklFFt4YFMKNLxlW7n2lt5lY8=
Date:   Wed, 7 Sep 2022 05:45:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     bp@suse.de, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Mark Mossberg <mark.mossberg@gmail.com>
Subject: Re: [PATCH] x86/dumpstack: Don't mention RIP in "Code:"
Message-ID: <YxgT5WombFuUofEX@nazgul.tnic>
References: <b772c39f-c5ae-8f17-fe6e-6a2bc4d1f83b@kernel.org>
 <20220906071123.558-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906071123.558-1-jslaby@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 09:11:23AM +0200, Jiri Slaby wrote:
> Commit 238c91115cd0 ("x86/dumpstack: Fix misleading instruction pointer
> error message") changed the "Code:" line in bug reports when RIP is an
> invalid pointer. In particular, the report currently says (for example):
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   ...
>   RIP: 0010:0x0
>   Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> 
> That "Unable to access opcode bytes at RIP 0xffffffffffffffd6." is
> quite confusing as RIP value is 0, not -42. That -42 comes from
> "regs->ip - PROLOGUE_SIZE", because Code is dumped with some prologue
> (and epilogue).
> 
> So do not mention "RIP" on this line in this context.
> 
> Cc: Mark Mossberg <mark.mossberg@gmail.com>
> Cc: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  arch/x86/kernel/dumpstack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index afae4dd77495..b3dba35f466e 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -128,7 +128,7 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
>  		/* No access to the user space stack of other tasks. Ignore. */
>  		break;
>  	default:
> -		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
> +		printk("%sCode: Unable to access opcode bytes at 0x%lx.\n",
>  		       loglvl, prologue);
>  		break;
>  	}

I guess... and it says "opcode bytes" to denote that it is trying to
access instructions so yeah, that RIP might be superfluous.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

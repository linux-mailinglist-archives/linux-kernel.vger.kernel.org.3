Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00784FB7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbiDKJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344579AbiDKJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:39:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBE4403F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:36:53 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 279091EC0202;
        Mon, 11 Apr 2022 11:36:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649669808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yubHAmQOKFXQzNV5jAier9r1b9P81adyeJrEjeDlCUw=;
        b=nfLCSOmQv2gPFZSwZuwH56Qf9el3EYe27Hk7ra/Ew/a7m4WWcNkNcsL+tlVZzjQJTZXRNQ
        aK9DUOCdSHffKLAGMoITCXitPXd5oRivKEAx3MifA8ViS0TArYo3smilmacnmURCPNFgJc
        KU6b3SmlaDskKkiIQkDPJcxgNcZJz+0=
Date:   Mon, 11 Apr 2022 11:36:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V4 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Message-ID: <YlP2s5pbY0YcibAC@zn.tnic>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318143016.124387-2-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:30:10PM +0800, Lai Jiangshan wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 1563fb995005..9fe9cd9d3eeb 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -892,13 +892,8 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
>  }
>  #endif
>  
> -struct bad_iret_stack {
> -	void *error_entry_ret;
> -	struct pt_regs regs;
> -};
> -
>  asmlinkage __visible noinstr
> -struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
> +struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
>  {
>  	/*
>  	 * This is called from entry_64.S early in handling a fault

While at it, unbreak that line:

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9fe9cd9d3eeb..28591132e885 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -892,8 +892,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 }
 #endif
 
-asmlinkage __visible noinstr
-struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
+asmlinkage __visible noinstr struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
 {
 	/*
 	 * This is called from entry_64.S early in handling a fault

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

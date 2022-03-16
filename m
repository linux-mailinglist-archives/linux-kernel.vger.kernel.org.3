Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66EF4DB842
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357810AbiCPSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiCPSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:55:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C52DD52;
        Wed, 16 Mar 2022 11:54:40 -0700 (PDT)
Received: from zn.tnic (p200300ea971561ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E72D31EC0347;
        Wed, 16 Mar 2022 19:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647456875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZKVlRog0zyufiQq5gPxgOQ4dGbYbOvrHBN0ziGtsvuQ=;
        b=IvZEzbaVFgWZ3CEWQ1NHiW3Vt4+ToGyidLb3XbNHKubqDwStpVJgVqkJk52YGxpgTXXtUb
        80HLHNc8pc/rlx0AwSxY/ClEEK0sOy0u4Tn8axeoC3PSaJGU8D+eE3jb5E7+lDAe8uqnpQ
        581a9UeMO73IVmZWkkwKRU6rhvOemFo=
Date:   Wed, 16 Mar 2022 19:54:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chin En Lin <shiyn.lin@gmail.com>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: x86: Fix obsolete name of page fault
 handler
Message-ID: <YjIyZyDfg6+Hsq9a@zn.tnic>
References: <20220314155901.227257-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220314155901.227257-1-shiyn.lin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:59:01PM +0800, Chin En Lin wrote:
> Since commit 91eeafea1e4b ("x86/entry: Switch page fault
> exception to IDTENTRY_RAW"), the function name of page
> fault handler is out of date. This patch change
> do_page_fault() to exc_page_fault().

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Also, do not talk about what your patch does - that should hopefully be
visible in the diff itself. Rather, talk about *why* you're doing what
you're doing.

> Signed-off-by: Chin En Lin <shiyn.lin@gmail.com>
> ---
>  Documentation/x86/exception-tables.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/x86/exception-tables.rst b/Documentation/x86/exception-tables.rst
> index de58110c5ffd..0140a06b2705 100644
> --- a/Documentation/x86/exception-tables.rst
> +++ b/Documentation/x86/exception-tables.rst
> @@ -32,14 +32,14 @@ Whenever the kernel tries to access an address that is currently not
>  accessible, the CPU generates a page fault exception and calls the
>  page fault handler::
>  
> -  void do_page_fault(struct pt_regs *regs, unsigned long error_code)
> +  void exc_page_fault(struct pt_regs *regs, unsigned long error_code)
>  
>  in arch/x86/mm/fault.c. The parameters on the stack are set up by
>  the low level assembly glue in arch/x86/entry/entry_32.S. The parameter
>  regs is a pointer to the saved registers on the stack, error_code
>  contains a reason code for the exception.
>  
> -do_page_fault first obtains the unaccessible address from the CPU
> +exc_page_fault first obtains the unaccessible address from the CPU

Unknown word [unaccessible] in Documentation.
Suggestions: ['inaccessible', 'accessible', 'accessibly']

Also, put "()" after the function name:

"exc_page_fault() first obtains..."

>  control register CR2. If the address is within the virtual address
>  space of the process, the fault probably occurred, because the page
>  was not swapped in, write protected or something similar. However,
> @@ -281,12 +281,12 @@ vma occurs?
>  
>      > c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
>  #. MMU generates exception
> -#. CPU calls do_page_fault
> +#. CPU calls exc_page_fault
>  #. do page fault calls search_exception_table (regs->eip == c017e7a5);

That is not really true anymore - look at the code and see which
function calls fixup_exception() now and try to fix that too pls.

>  #. search_exception_table looks up the address c017e7a5 in the
>     exception table (i.e. the contents of the ELF section __ex_table)
>     and returns the address of the associated fault handle code c0199ff5.
> -#. do_page_fault modifies its own return address to point to the fault
> +#. exc_page_fault modifies its own return address to point to the fault
>     handle code and returns.

Ditto.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

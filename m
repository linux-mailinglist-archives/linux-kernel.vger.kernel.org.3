Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4BB4DB662
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353981AbiCPQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356287AbiCPQob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:44:31 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739715A06
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:43:15 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2db2add4516so30300737b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iT8WAzTqJQWZlBRHChD4jFljyqWvTcdhx0dN/jklVW8=;
        b=OnPazNty4PyG9SDSEhr/YW++Z5+dYLpi7ck+zzRi4Jh1Gcdndd//ofztLag68Hq4ZS
         r/Ue+iGeqw8Tb2agkoqSd7Z5qSZFbETzaw0K3S04ozbFK1r+zCAyWm0DGJVrf2QBWAtz
         U6GnLkg2vNrHCjq7AvgiN0/SMG9sCqIUArrXtW9CULW8ZI5b40ch7PQiVQlDZOqBDFs0
         qT4LnaaLW7VJZvd/SpJLSrDTKJ0ZENx7NKaYliIOOSL2KUyHFnU4o9RYCbnSf/KZvnRa
         ezHnbrIEDI7k7QaRjPptjHL5y/e4rfufkuL/hcUjH7b43TRkbGcaPYerwTLdAX0RrHCO
         LyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iT8WAzTqJQWZlBRHChD4jFljyqWvTcdhx0dN/jklVW8=;
        b=mhwZ0MrBMOuscvmX90kaU/f8d3zThvL9BwbM5zU2JDs/eXeX3AfeMIxVatGdc9kknP
         6cCAQ+iSUuejBWkyAtp9ULf05BmaOxVRGujguBkehzk6CqYJIRybUmWN2sjh6FYOueuD
         litm4FLnLp+/Lu7oeRY/1PvoglAsKxqMvwsxdAS4RfErPJS3p3Owtaxn2Q/jrd1SZDyd
         nLpU1vXUqHSWrHACvysYYYKiUOsaluX9LGiP/3tP34dEz/MNXUMZwyFh4ObioUloZ4RZ
         /JBcfeyYPanICwDmXthYzhmkRhWZxX6EZJf7u19EyhWMvYzg7+VBgyDm30AnBdto1tGX
         GvTw==
X-Gm-Message-State: AOAM532lrvkx6ZdO8gRcvNhR4FTX/DSKJj1vIdBh7EpEmuh4JhLFB6SM
        Pxe7hMZjfRGeAkVIGva8o1EA+e1oV4Ytd6h/CvM=
X-Google-Smtp-Source: ABdhPJx/HsFa8UTBF2cr5iaVHj9rk7NdFCy2A5o9Wr6S1nEdSG/6FCCrVtvbO9ODvBRDioBlllmpeKIut+g5gm72Jmc=
X-Received: by 2002:a0d:eb02:0:b0:2e5:9d37:58ba with SMTP id
 u2-20020a0deb02000000b002e59d3758bamr1059698ywe.231.1647448993655; Wed, 16
 Mar 2022 09:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220315073949.7541-1-jiangshanlai@gmail.com> <20220315073949.7541-4-jiangshanlai@gmail.com>
 <YjH8xJ3MKosyUl7M@hirez.programming.kicks-ass.net>
In-Reply-To: <YjH8xJ3MKosyUl7M@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 17 Mar 2022 00:43:02 +0800
Message-ID: <CAJhGHyBKC4Xe=FTtv=+QRG1b5o=6G+vdMDP+oH83cz+29VXHBg@mail.gmail.com>
Subject: Re: [PATCH V3 3/7] x86/entry: Switch the stack after error_entry() returns
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> >  SYM_CODE_END(error_entry)
>
> So the new Changelog doesn't seem to help me much. But looking at both
> fixup_bad_iret() and sync_regs(), they both have:
>
>   __this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1


For a long time in old days (before KPTI), tss.sp0 does be the kernel
thread stack, but now is not the kernel thread stack, rather it is the
trampoline stack (or entry stack) in the cpu entry area.

And bad IRET can happen when doing IRET to return to userspace and it
is also the trampoline stack. So fixup_bad_iret() is really just moving
the lower partial pt_regs up to concat with user IRET frame head
in the entry stack.

So fixup_bad_iret() will NOT have setup pt_regs on the thread stack.
And sync_regs() is needed after fixup_bad_iret()

The patch
https://lore.kernel.org/lkml/20200817062355.2884-3-jiangshanlai@gmail.com/
tried changing fixup_bad_iret() to copy the pt_regs directly to
the kernel stack.

And in the V1 of the patchset that converting ASM to code also
tried it:
https://lore.kernel.org/lkml/20210831175025.27570-13-jiangshanlai@gmail.com/

And in the current patchset, it focuses on ASM code only. I don't think
we need to change it.  It would be much simpler to change the behavior
of fixup_bad_iret() when error_entry() is converted to C.

>
> as hard-coded destination. Now, fixup_bad_iret() sets up a complete
> ptregs there and then returns a pointer to this stack.
>
> sync_regs otoh, does a straight up pt_regs sized copy from arg0 to this
> new stack.
>
> Therefore it appears to me that doing sync_regs() after fixup_bad_iret()
> is a complete NO-OP and only confuses things further.
>
> Would not something like the below clarify things?
>
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1004,6 +1004,7 @@ SYM_CODE_START_LOCAL(error_entry)
>  .Lerror_entry_from_usermode_after_swapgs:
>         /* Put us onto the real thread stack. */
>         call    sync_regs
> +.Lerror_entry_from_usermode_after_sync_regs:
>         RET
>
>         /*
> @@ -1058,8 +1059,12 @@ SYM_CODE_START_LOCAL(error_entry)
>          */
>         leaq    8(%rsp), %rdi                   /* arg0 = pt_regs pointer */
>         call    fixup_bad_iret
> -       mov     %rax, %rdi
> -       jmp     .Lerror_entry_from_usermode_after_swapgs
> +       /*
> +        * fixup_bad_iret() will have setup pt_regs on the thread stack, and
> +        * returns a pointer to that stack exactly like sync_regs() would've
> +        * done. As such, calling sync_regs again makes no sense.
> +        */
> +       jmp     .Lerror_entry_from_usermode_after_sync_regs
>  SYM_CODE_END(error_entry)
>
>  SYM_CODE_START_LOCAL(error_return)

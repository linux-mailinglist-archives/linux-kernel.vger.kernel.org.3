Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527952E1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242719AbiETBMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiETBMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:12:08 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53465D028F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:12:07 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ff53d86abbso54097387b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5cS25sYVuFEczR5InEOqfq3ordUksWT2DjtGnQiv1I=;
        b=IVOumXMysYuVP3hBEt03ghAv0Y2h3QRTsWbkcmn8YbfeSCIEkha4CCpWv5wIbd3Y4c
         MTwHFRbp4yBOxF+Rzz4V4qiGc0Q6LBK9bxVl3c8FZ+vGrZoP+eOuP7Ak0B04ZE97oPwq
         Xy22eogpvvY2/b0ZPBuxGbbPpzlzFclsGlL6eKxqxFui3JR3nlpVlssqbqoDp3AFmeCI
         2pr38TsZMsX/4rFbwupGtfAO7N98hfnFHYAOEOY32b3CVv9ZOyIyq1rpwhCT99nkWhvj
         jXeCGFVE85MqKZONex5oBLRz4fd4i7Din1llMdqn+jx9MUnrh4wdyLVzRoFFwxKUkyIt
         welQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5cS25sYVuFEczR5InEOqfq3ordUksWT2DjtGnQiv1I=;
        b=rkXIuZJmZIb3EOVrml2n0QmghQaxwZjYZkzEaBJb1iGAD77st7dL63PJd2eNlEWtHo
         Jo/wvTgLtMVbEy8b8NfDMsZwMucRAXWvWCxWwdxaH7yNENx+WDj0yF/+Pg35Nf09Qijt
         wwpvyDRHce61f9On1Vj/JzQHuGiflSD0bhQhXq/qv3Ce1Ypf/4K2Ie5okEhpJ216o4zj
         4PQurMXT4Yw2rUdZm+UhkWn58KPpOYEH5CtRwbYFzomGG86cauzeeLERMLif8LMhJ9ZI
         5wZex6HZ0mJQ+v/e3XHXp7czYWKQ3RB/kT2XZ/hmbaL7Q1h/QdntAAe6eNleFotOPhto
         BCgw==
X-Gm-Message-State: AOAM533z5sgAbfbCHBwdXvy8/6s5KJ7gdFoxGogxRu6PDl30lVFyk7Pp
        W2ax0oFFXPIg66VJOF9LRxzBRPl4oEjRJ6Uf1ULo76hU4zo=
X-Google-Smtp-Source: ABdhPJx7XmMQykZgAGlmnjUSI/OaX0hDVcJ4Bsq84jt3xVdt69P5p0pFvTQakYQIX5y11fCvpms2TSqBR9tF8XoyO0k=
X-Received: by 2002:a0d:d40e:0:b0:2ff:28a0:8d09 with SMTP id
 w14-20020a0dd40e000000b002ff28a08d09mr7780815ywd.256.1653009126594; Thu, 19
 May 2022 18:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220506121431.563656641@infradead.org> <20220506121631.293889636@infradead.org>
 <20220519162411.GA4095576@roeck-us.net> <20220519170009.GL2578@worktop.programming.kicks-ass.net>
 <20220519171129.enw32izjhxsqc2xm@treble> <20220519173538.nywtw2h3y7sqfojn@treble>
In-Reply-To: <20220519173538.nywtw2h3y7sqfojn@treble>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 20 May 2022 09:11:55 +0800
Message-ID: <CAJhGHyC0sztc2_jTT+U1M2+OSNxfNgmaKJyZgySwYqKM06q7hg@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@suse.de>
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

On Fri, May 20, 2022 at 1:35 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index ed2be3615b50..f76e674d22c4 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -200,7 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
>  SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
>         movl    %eax, %eax              /* discard orig_ax high bits */
>         pushq   %rax                    /* pt_regs->orig_ax */
> -       PUSH_AND_CLEAR_REGS rax=$-ENOSYS
> +       PUSH_AND_CLEAR_REGS rcx=%rbp rax=$-ENOSYS

Some comments need to be here to explain why %rcx is stashed in %rbp.

The code doing the stash in userspace may be in
arch/x86/entry/vdso/vdso32/system_call.S (see SYSCALL_SEQUENCE)

Thanks
Lai

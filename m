Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC4581CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiG0BEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiG0BD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:03:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094693191C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:03:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 123so5163368ybv.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1CB8uxEEeVmjEqML3wHULJiqkA1BC56ArX1DExl2h0=;
        b=BowbdoekaMtWgeqq6JQeYxKcmHK+fziGoVioqo96wYk6ogTiHULPf4SFWGSe7wcDHQ
         5B5YGzp/Hoi+EAxUMDZy9RVS8WYYSDvYTBeg+z1mT8LQWxhYNPs8qO1pO4az8spk0vK/
         MWD4BMay3csEszpYfEbpFda2WQfCZBau7qu7Km+U2EtFCucH8A4tXLbmnaDV58OeBZ9L
         aGHCRzJ+ZbIEw3Tgt1ofq3ES8n7CYx9kuT/tSozsqeohGOgctAr88tg7WLpiH14C2DIu
         /EE219agvhkYpwOtk78869F1P6IfDBx0NKG1Lpmbn8VrTU064hZpqHqCHBAYbEId67Tm
         JiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1CB8uxEEeVmjEqML3wHULJiqkA1BC56ArX1DExl2h0=;
        b=XFyLEsKLDN5LGdbC6jwBnM40tYred0NB5CDvrj11hC81WzclK5LeMsVHyOPatgzL6B
         rgoRqT50X6eJmxA4Ti86wopFo6ylcxQOKHH9ZRjaOsr1WKyx/Lx6lY9HeVx9xGqrdaRb
         nantn2VAFHpEfNL1qz0eWg7Vb6DerGg0tYetkqqZEFKc8a5UTdvcVzvX8Oocdb9+6nbi
         gcwhMYTg0cBxRQeAWIMZxshmC5QfnQDaMHHiaSLOEZrqGUXSISAqNWnAj1Y2bivBJVyc
         XK1N1m8eQe4RrwmtInCKQTEIFTewkACMtt+A7ba5R6ThHirijSupXNcQ9mVkEFYnN5VV
         3XiQ==
X-Gm-Message-State: AJIora/FcM+qv4v7Y51GYt5x+WutVaL+Y8ioGo7Xg+lJ8ohS5psDx6zu
        3FM5uNTdYtnLAbNbXn9CoAk3jqVqOW1hJt4ysDDfTA==
X-Google-Smtp-Source: AGRyM1vGwdn/xjVFlR+Q0hjliaGUjO9ApRQRkLN4eTOeu46rx7zNMkYHZz68lQZc/kvDEyyVp6TNc5FmkdLhujzyhNk=
X-Received: by 2002:a25:b9d1:0:b0:671:49f9:4e01 with SMTP id
 y17-20020a25b9d1000000b0067149f94e01mr8795250ybj.398.1658883835983; Tue, 26
 Jul 2022 18:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220722230241.1944655-1-avagin@google.com> <Yts1tUfPxdPH5XGs@google.com>
 <CAEWA0a4hrRb5HYLqa1Q47=guY6TLsWSJ_zxNjOXXV2jCjUekUA@mail.gmail.com>
 <YuAD6qY+F2nuGm62@google.com> <875yjjttiz.ffs@tglx>
In-Reply-To: <875yjjttiz.ffs@tglx>
From:   Andrei Vagin <avagin@google.com>
Date:   Tue, 26 Jul 2022 18:03:44 -0700
Message-ID: <CAEWA0a6hteJsvkd7Fe06P93O0GcE=4izSvJEj3RGpYPta9=s1w@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM/x86: add a new hypercall to execute host system
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jianfeng Tan <henry.tjf@antfin.com>,
        Adin Scannell <ascannell@google.com>,
        Konstantin Bogomolov <bogomolov@google.com>,
        Etienne Perot <eperot@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 3:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Jul 26 2022 at 15:10, Sean Christopherson wrote:
> > On Tue, Jul 26, 2022, Andrei Vagin wrote:
> >> * It doesn't allow to support Confidential Computing (SEV-ES/SGX). The Sentry
> >>   has to be fully enclosed in a VM to be able to support these technologies.
> >
> > Speaking of SGX, this reminds me a lot of Graphene, SCONEs, etc..., which IIRC
> > tackled the "syscalls are crazy expensive" problem by using a message queue and
> > a dedicated task outside of the enclave to handle syscalls.  Would something like
> > that work, or is having to burn a pCPU (or more) to handle syscalls in the host a
> > non-starter?
>
> Let's put VMs aside for a moment. The problem you are trying to solve is
> ptrace overhead because that requires context switching, right?

Yes, you are right.

>
> Did you ever try to solve this with SYSCALL_USER_DISPATCH? That requires
> signals, which are not cheap either, but we certainly could come up with
> a lightweight signal implementation for that particular use case.

We thought about this interface and how it could be used for gVisor needs. I
think the main question is how to manage guest address spaces.  gVisor can run
multiple processes in one sandbox. Each process must have its address space
isolated from other address spaces. The gVisor kernel (Sentry) has to run in a
separate address space that guest processes don't have access to, but the
Sentry has to be able to access all other address spaces.

>
> Thanks,
>
>         tglx
>

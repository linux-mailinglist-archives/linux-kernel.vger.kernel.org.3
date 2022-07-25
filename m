Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB45803B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiGYR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiGYR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:57:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE86ABE13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:57:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w18so2981405lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ojw9pdkYTw1ifMgRzhRrqy5FrGTQNaAVlAywUiE/9Zk=;
        b=gAA7N0NxwvSWM9b4EWkR7vOpThylDYGavF5lzrNOu11hs5K/eInHZuVlNmZQNY/ciC
         reGiEVCFCejAdNCTDRdfCrgdRO+pgKoiLRzwHhgk4qwxbEAn+iZwV4eGXWZgwU0Fmrtv
         e16P2Z5rcR6NiuWkGM5ua8SKYZEpnXThYdxd/Y6HTtwpIEw8oMs8CZlgNgxt7XEIKSPJ
         cP2N/BKqUiZbMDWxkHNJ7Uo+djsqkNvMEoc8LgwsOCmkpLeM63hsxW1HR75ttSwQMmv8
         Gi2ZruPZYQ2JxG8CIc4iJKF5UDB+8bkT6SXz+5So0YWPDJ1Rw3HB+dZ7h5b5erVBvqmE
         dVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ojw9pdkYTw1ifMgRzhRrqy5FrGTQNaAVlAywUiE/9Zk=;
        b=qGcTHZPHGvUsM2CWE/hfbvcs1Rnug71vGDzNhQa2iuY4wjCb8pT4kB1LOaPfIbdyVs
         eGvmb8oUQ6QrAgdUT6NonmAJYnw2DaFrNQH1wfnak2jnd2ypdEONevNljXSqqMClkv4c
         a0E/UgE8ebfqOqSxwjd+rotjk1oU3Q5MiS19jVQBKAgu7ZZ3gKY3O1juhSvbs05JahMe
         yeL6yQKJOsBcXkaGTyso2S9bSenCLpD9fvtKv3dC2oMMC24MzW+2ujnK7JqAa64fMLGk
         q2ggULBcI74MgU5ARsYWKlI12hi13/K297hHWykR+Uj3REeGccO30T1vIV5J0/cuQWyE
         j4Qg==
X-Gm-Message-State: AJIora+BdiyYIfKnKbCyywF30JKS2zLfU1FStJxBTxSWJxjrPyFGMk3T
        qvCOPr00ArW0wDc8GqiVsybQP8uwi21qWKhmx+J5J2UO
X-Google-Smtp-Source: AGRyM1v5fIZAGBuEKxfQljCPXS9X6jwaBkrdrF7KNAto+KjdQCD+fd/8k4/utcZIQb6J+p8sk7HnPTqMfqbgXQWyFzw=
X-Received: by 2002:a2e:9e1a:0:b0:25d:f9db:92f7 with SMTP id
 e26-20020a2e9e1a000000b0025df9db92f7mr4036977ljk.243.1658771867942; Mon, 25
 Jul 2022 10:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210623120127.327154589@linutronix.de> <20210623121452.214903673@linutronix.de>
 <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com> <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com>
In-Reply-To: <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 25 Jul 2022 10:57:36 -0700
Message-ID: <CANaxB-w1+zCupiS5HyofGhVD7TKqZCoRjv9VZiegROiPkMY3NA@mail.gmail.com>
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:47 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/13/22 21:04, Andrei Vagin wrote:
> >> -       /*
> >> -        * mxcsr reserved bits must be masked to zero for security reasons.
> >> -        */
> >> -       xsave->i387.mxcsr &= mxcsr_feature_mask;
> >> -
> >> -       /*
> >> -        * In case of failure, mark all states as init:
> >> -        */
> >> -       if (ret)
> >> -               fpstate_init(&fpu->state);
> >> +       fpu__prepare_write(fpu);
> >> +       ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
> > This change breaks gVisor. Now, when we set a new fpu state without
> > fp,sse and ymm via ptrace, mxcsr isn't reset to the default value.
> > The issue is reproduced only on hosts without xsaves. On hosts with
> > xsaves, it works as expected.
> Is gVisor some out-of-tree kernel code or is it just an proprietary KVM
> user?  In other words, is this an issue with the upstream kernel itself
> or does it require kernel modification?

This is on the upstream kernel without any modifications. And this is the case
when gVisor uses ptrace to trap syscalls. KVM isn't used in this case.

Thanks,
Andrei

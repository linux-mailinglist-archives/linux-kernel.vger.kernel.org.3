Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C904B920B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiBPUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:02:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiBPUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:02:01 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE75EA741
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:01:47 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u16so5053663ljk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hW2pDFteIc4gQMKS0FzR4fHrP7ssO0bJIUo/j6LOQw4=;
        b=YMh744M7SDKa0Wrw7hsPPJv/kOsDGzkF/tKe34isF3+hpPzwq4TF4fUASJ3Ykcm9YY
         3V2dlBXE61N2W+UnD430bOwEuHuomHRbsvAlESi8v+1J9eL8yyd6RXYDhUjU2krZDFS2
         v2TeUPyZhyWH0Pgiy7r0KT9eAqJxIVMnboK2Ezitk5Bd8f4Iujod0y2S3QEi62Pj16VZ
         v+0D4GO4BD9VkhuPmq1ITiZzO1+QNMNNonLMwRWrw8ToyxB4nOFiCwFY5rcyP7JzjUml
         W1N+6ZXDHtQ8fntAy1kAmzSR9dZwdmBdv0SlLiu9OkqnaHx4P5VFJQN9cpFhxM3IAQvr
         xG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hW2pDFteIc4gQMKS0FzR4fHrP7ssO0bJIUo/j6LOQw4=;
        b=YrGV64XQPIAd7DxmuOYbogMPxkOhaUQpazXFRFWgOiXRIoMsU/0v+LtsP+/Dcj94TX
         w62og3yQ1VjjN1IJzXd9U5MpAWj9dnCxo/GrXyRXj2R23CCXa7Br/giQZyPjdk9RH6Wa
         hWkmTQ6fehRakX/1td29TgldWfrkWcFfMLrKmm4F8e1Cq1FCOZMiCws1UQ/eL11PoEJC
         DyTlNJLKT5bY5WiYRpYig2PpSM4szYjFRCznRr5vztcYaC8Oey8HNp0seyc+xM2z/Yg4
         YEyizA0VY3BpXptShYpms6QwkQfdVJx8VdbUNFgl+RpatBx/pG+c4tMK0Ma+G8fk3wlG
         IgnQ==
X-Gm-Message-State: AOAM531nwpOM9PN3WqvKD87hP1HUON/dje/PHC1AnuQOd234UQBjs9SI
        ktQO6oMygKqIvWUXiTIF9UkCcMFdNOAxdr2Iann92g==
X-Google-Smtp-Source: ABdhPJwEBo1EH1FqftO2DluuT2fzFZom+MP66NKbpaTW+1EXirX6GeDIxV2dmpPMLpj+B1br1BaMVkUfxEHGNxAp5ok=
X-Received: by 2002:a2e:a886:0:b0:244:de6f:1bf6 with SMTP id
 m6-20020a2ea886000000b00244de6f1bf6mr3320011ljq.375.1645041705935; Wed, 16
 Feb 2022 12:01:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pO41uwYExSROc5X2+RE=a5tZfE=c=bAxVbhCHfa7=zSA@mail.gmail.com>
 <20220204155142.56419-1-Jason@zx2c4.com> <Yf1M3YGVq71oC9BM@linutronix.de>
In-Reply-To: <Yf1M3YGVq71oC9BM@linutronix.de>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 16 Feb 2022 21:01:19 +0100
Message-ID: <CAG48ez1ucJikx_6GzK2XUfCGoTeL+R418riTn+ECj_ud5BSFow@mail.gmail.com>
Subject: Re: [PATCH v3] random: remove batched entropy locking
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 4:57 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2022-02-04 16:51:42 [+0100], Jason A. Donenfeld wrote:
> > index 455615ac169a..3e54b90a3ff8 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1759,41 +1762,54 @@ u64 get_random_u64(void)
> >       unsigned long flags;
> >       struct batched_entropy *batch;
> >       static void *previous;
> > +     int next_gen;
> >
> >       warn_unseeded_randomness(&previous);
> >
> > -     batch = raw_cpu_ptr(&batched_entropy_u64);
> > -     spin_lock_irqsave(&batch->batch_lock, flags);
> > -     if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
> > +     batch = this_cpu_ptr(&batched_entropy_u64);
> > +     local_lock_irqsave(&batch->lock, flags);
>
> Does this compile and work? From the looks of it, this should be:
>
>         local_lock_irqsave(&batched_entropy_u64.lock, flags);
>         batch = this_cpu_ptr(&batched_entropy_u64);
>
> and we could do s/this_cpu_ptr/raw_cpu_ptr/

Why raw_cpu_ptr? include/linux/percpu-defs.h says about raw_*() operations:

 * Operations for contexts where we do not want to do any checks for
 * preemptions.  Unless strictly necessary, always use [__]this_cpu_*()
 * instead.

So when I see a raw_*() percpu thing, I read it as "it is expected
that we can migrate after this point (or we're in some really weird
context where the normal context check doesn't work)". Is that
incorrect?

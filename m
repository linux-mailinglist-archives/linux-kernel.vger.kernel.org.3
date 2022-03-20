Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859094E1DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiCTVLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbiCTVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:11:08 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EED46145
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:09:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k25so14811487iok.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uu3NPXS3YIK/joqnoO2dCxxZrdruyUVh70Rwb4NqWi8=;
        b=peCpeuakEvX6D9DkWAvoxRIedMD/39lVZWCnWMzXtri03y9r62H6zmrugVSd2V6Hnl
         yNgQlrRrkY5LOSfKIyB0mcQWaLclmNYbtS7Df8eBRfi86fUcUomspIvZeeMvSeYnj0in
         nDF7eZNpiFFCY/pjp6ygoxeX9KEC7hglQY1MN7LvMqX7SUur4xKzkWFvSSHIcgKt5CKK
         v6+ptK9uDU0LA9ECsg46r4NCs/Gxy4hQQtQ3XG5NJvScH196cq0hbQ7SE4TQYIBumZBV
         Vk/MJcmAZlhdSbuXePQoJqG7CWuQiogqYCmhdv574+F3DX+e+JE5bixYQtJtbH/UaKF1
         nvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu3NPXS3YIK/joqnoO2dCxxZrdruyUVh70Rwb4NqWi8=;
        b=cJEvYT1Xe5w5MXl3wVC/c5mT9QKFJMfACwDKuiPEE0wKbN43W8xBSLrEdjXyWALsW8
         MI8g8MflriJomw7MiCuPtd2hzRtcEZagIDr9ekS4cc5K4svRxR2QFH5MP9qfLUH3lapi
         Rcrf5cKBlacy9C+6PBrB84geK3Um963bs6/lEdc3ScreY3cAcwAR9F2gGUHqEL5bG7Ec
         nEjtEvgmRoasq2lV/ytwZLHEl/7bKL1st6EJNhr9OKJdWqmGaZbXoiQFd8EB32Olj2XU
         p3Aj/1LzlVAGcgeQfjz3ChJLAIBCo9FdTO44lQQ8YLyvTj2TpaS2RZSZ1iFwZenskcn0
         FkcA==
X-Gm-Message-State: AOAM533ymKitaalsvqiHczLW2ROLGLx3CH9xkTE2qcN02uWdzFWsch4y
        xzwGWY+XFsFmrCp8UWMqcBz6ddYkB8I/N1NIWWI=
X-Google-Smtp-Source: ABdhPJxtnQc5xK7BNvEj8B3gFxPHw3v/vJyiqBQB12KNZ11hRyLBynaAARBpB1/R7HnY+wIoLY5Ba/RGVkuYmR9jHi8=
X-Received: by 2002:a05:6638:210a:b0:31a:536e:4714 with SMTP id
 n10-20020a056638210a00b0031a536e4714mr10058666jaj.71.1647810583809; Sun, 20
 Mar 2022 14:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
 <CANpmjNNBzVovK=N9b2Lv0VUqpE_4nU+6gqO91_ojVoEbR0C5hA@mail.gmail.com>
In-Reply-To: <CANpmjNNBzVovK=N9b2Lv0VUqpE_4nU+6gqO91_ojVoEbR0C5hA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 20 Mar 2022 22:09:33 +0100
Message-ID: <CA+fCnZfYLZhjijPjp3Wd3ZeBQnKNiQCLNn7uuF=cpQi9wU50xA@mail.gmail.com>
Subject: Re: [PATCH] kasan, scs: collect stack traces from shadow stack
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, Mar 14, 2022 at 8:01 AM Marco Elver <elver@google.com> wrote:
>
> > Instead of invoking the unwinder, collect the stack trace by copying
> > frames from the Shadow Call Stack whenever it is enabled. This reduces
> > boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.
>
> This is impressive.

I was surprised too.

> > We could integrate shadow stack trace collection into kernel/stacktrace.c
> > as e.g. stack_trace_save_shadow(). However, using stack_trace_consume_fn
> > leads to invoking a callback on each saved from, which is undesirable.
> > The plain copy loop is faster.
>
> Why is stack_trace_consume_fn required? This is an internal detail of
> arch_stack_walk(), but to implement stack_trace_save_shadow() that's
> not used at all.
>
> I think having stack_trace_save_shadow() as you have implemented in
> kernel/stacktrace.c or simply in kernel/scs.c itself would be
> appropriate.

The other stack trace routines consistently use on
stack_trace_consume_fn. But I think you're right, we don't need it.
Will do in v2.

> > We could add a command line flag to switch between stack trace collection
> > modes. I noticed that Shadow Call Stack might be missing certain frames
> > in stacks originating from a fault that happens in the middle of a
> > function. I am not sure if this case is important to handle though.
>
> I think SCS should just work - and if it doesn't, can we fix it? It is
> unclear to me what would be a deciding factor to choose between stack
> trace collection modes, since it is hard to quantify when and if SCS
> doesn't work as intended. So I fear it'd just be an option that's
> never used because we don't understand when it's required to be used.

Let's just rely on SCS for now and reconsider in case any significant
limitations are discovered.

> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +
> > +#ifdef CONFIG_ARM64_PTR_AUTH
> > +#define PAC_TAG_RESET(x) (x | GENMASK(63, CONFIG_ARM64_VA_BITS))
>
> This should go into arch/arm64/include/asm/kasan.h, and here it should
> then just do
>
> #ifndef PAC_TAG_RESET
> #define ...
>
>
> > +#else
> > +#define PAC_TAG_RESET(x) (x)
> > +#endif
>
> But perhaps there's a better, more generic location for this macro?

Will move in v2.

Thanks!

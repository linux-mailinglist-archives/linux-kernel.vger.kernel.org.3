Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10EE4E96CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiC1Min (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiC1Mik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:38:40 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69254ECC9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:36:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e612af95e3so146670877b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMEZK2jSyKIkvvjIbH4GT3Fdajafv9KYrdFViGd4yCs=;
        b=E9+QQkZMHaB3kC1jUcU1jKceyPqYXHgBAwrVH0Qoo7sy3RqybcW+gUMd6ILGzB7f+l
         ws3VHba8umN32ny6nvOGE7S0/BDPYbL3CibIFNlYrI+ImbMRn5uBNTtYcvWjpMn70BeQ
         YSZHLatfVPFPqrYmESblO10IJea6qXAQwCHfSeIe/Um9EbObWu/lemX2KJ23uLSz97eH
         g6on/oQ6sD9DD5h9J/mHKHD3CEJ6mjGQwCKzXS6Oo18j1nmsU3d9qcw+HawWBiquerkd
         1uGdCrnf3Y0q0XTNc1w9PPJSTSY6BhV6JhFKAinQ4KUVPbxqYrV3ctxarnAfrHwnZlJo
         D6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMEZK2jSyKIkvvjIbH4GT3Fdajafv9KYrdFViGd4yCs=;
        b=HCmt2dCST3p3r3bPbV0ZLth+J6TKrqy3c0O08LJeHd0CI1Ke5wbQzk8DBPWVmRhOnH
         RF/4TbluuQ9kAknZbfiIqIn/+LifmhZhhcCpoYUy+nbaXwWfp0S4+RSyXIGHC9TaZ5Xl
         hj68bb6W50E2rHxVMTznYxbLhgki5qPpVnRV9DMTSAKux9lJwSyIxu8gnhpefqvOSJAM
         2AjhyN6oageWG09u3KvBqQJz0V8bww9+g9i0NsCK9Luxtrap1ZnKTOt7eVsyTIxd/Yls
         HKPGsjksu6Pl03n+BvF/mdotX8hehgM5CklHCKD5JzZ37bIDl9NWnmYtizCWsdeoLMZW
         FJGA==
X-Gm-Message-State: AOAM531lWyvj1dzs0eI18gSmhxlPstyKdHCEX6ZYdF/UhZMMfZxndH2g
        FKg/f6OUEZf248Bful6AukJNenxQUKO4s08Xvoljx67OXg4=
X-Google-Smtp-Source: ABdhPJzKaHl48iYBzuviShvc/fSc+yX8bEigh83P/lNX0DQQM0lmzYQvFiEjENIrpwu0FVlWRhmYK7v0KTcRTDtdgBE=
X-Received: by 2002:a81:59c4:0:b0:2e5:c7c3:5d29 with SMTP id
 n187-20020a8159c4000000b002e5c7c35d29mr25403537ywb.512.1648471018879; Mon, 28
 Mar 2022 05:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com>
In-Reply-To: <cover.1648049113.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Mar 2022 14:36:22 +0200
Message-ID: <CANpmjNP_bWMzSkW=Q8Lc7yRWw8as_FoBpD-zwcweAiSBVn-Fsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Wed, 23 Mar 2022 at 16:33, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> kasan, arm64, scs, stacktrace: collect stack traces from Shadow Call Stack
>
> Currently, KASAN always uses the normal stack trace collection routines,
> which rely on the unwinder, when saving alloc and free stack traces.
>
> Instead of invoking the unwinder, collect the stack trace by copying
> frames from the Shadow Call Stack whenever it is enabled. This reduces
> boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.
>
> Stack staces are collected from the Shadow Call Stack via a new
> stack_trace_save_shadow() interface.
>
> Note that the frame of the interrupted function is not included into
> the stack trace, as it is not yet saved on the SCS when an interrupt
> happens.
>
> ---
>
> To deal with this last thing, we could save the interrupted frame address
> in another per-CPU variable. I'll look into implementing this for v3.
>
> I decided to postpone the changes to stack depot that avoid copying
> frames twice until a planned upcoming update for stack depot.

That's fair.

> Changes v1->v2:
> - Provide a kernel-wide stack_trace_save_shadow() interface for collecting
>   stack traces from shadow stack.
> - Use ptrauth_strip_insn_pac() and READ_ONCE_NOCHECK, see the comments.
> - Get SCS pointer from x18, as per-task value is meant to save the SCS
>   value on CPU switches.
> - Collect stack frames from SDEI and IRQ contexts.

Do any of these new changes introduce new (noticeable) overhead (in
particular patch 2)?

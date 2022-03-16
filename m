Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AADD4DA8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350600AbiCPDDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiCPDDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:03:35 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B55E144
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:02:22 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2e59939b862so8775217b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q42cB1sXpkleTEE3htTcKFqSRwkO4cfCIMbXo1bHuXA=;
        b=YEScOl+yvs+Q0HQwEqHF7fB2oF5Rk1EScvCGB5efpD7yLRA0nArU8esWedb8Nx/dxJ
         cObfGBkY5RWJrKnyMfR4A18q1XTueH8sYeTiugYP7fVeWICcdDcbkbIEAQEIcxs2SUTq
         2MfCAaFhcVhizy0QncKuQOm4aitlInCdifSFGa1EwNN+AR1kTBerrXlUqzN/UuLUTfpQ
         xXEmjq3648/tBq9M/clJqMKHRB83+A8IzC7oDGvi/rRbS+GmwUxg1w7NGoN+fh6/s+uv
         zqw7YgjSS+7s0umKs8a6r1xnn1jdiDyLRMgFSr6KBwpd01DaK7IpD9E0M/qlm0y7qp3z
         4GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q42cB1sXpkleTEE3htTcKFqSRwkO4cfCIMbXo1bHuXA=;
        b=X5TWTMvJJNv71XUb8I0yHYmziD3NDpAdW/6u91J50GWqwMLWs/oB37urM3SGLMWq/o
         GlMcQWJ+tL0Edhq+OHm4Tf5Ap6lQPw+Juj6OzbeMt6UErtAwk23Ft0UF/1Vwndnm00ri
         R+jkKQwEDYWGepO9P9V9t9T2bN9qeQRktZ9mb8QokyL9QBrf9ionnnScbDgXTcwx8j0y
         dkinFNk2YZhyW5h6/jISUqoKN3d2oQPOHqzaHEuiUOdNv8znA32zIdlVpqadAJi3TUCT
         qseaizJvYu6TlcwARJzsZMGsM1g08Fq3CBYw+wZIPBjltPhi66sX55x1hIIVZY8Q8YBJ
         hU2A==
X-Gm-Message-State: AOAM530jXooYNhHk68ZyJUHfycBgUdgWJ1aI1KOuzg1Bf13Qa8V5NPBB
        C5uc0dCC4KD35uKY15tHdWVM9xr4E91nDmQF+o0=
X-Google-Smtp-Source: ABdhPJyo3PY963IGL1wyKNsEuqFmxY+FkRoibl5Blq1JrX5V0Lk3+pY8xNwOGWC5F/A+4TAgeKG7Mvupg+CsjfNy0Jo=
X-Received: by 2002:a81:7983:0:b0:2e5:9d0a:1c52 with SMTP id
 u125-20020a817983000000b002e59d0a1c52mr2992384ywc.411.1647399741606; Tue, 15
 Mar 2022 20:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220315073949.7541-1-jiangshanlai@gmail.com> <20220315073949.7541-4-jiangshanlai@gmail.com>
 <20220316023710.jqmi666o6cqyoonh@treble>
In-Reply-To: <20220316023710.jqmi666o6cqyoonh@treble>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 16 Mar 2022 11:02:09 +0800
Message-ID: <CAJhGHyDs0O7XdZkc6pZVgRurYxEXmDE+aoipPwE-KLOBW-Scyg@mail.gmail.com>
Subject: Re: [PATCH V3 3/7] x86/entry: Switch the stack after error_entry() returns
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Mar 16, 2022 at 10:37 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Mar 15, 2022 at 03:39:45PM +0800, Lai Jiangshan wrote:
> >  .Lerror_entry_from_usermode_after_swapgs:
> >       /* Put us onto the real thread stack. */
>
> This comment is no longer correct.

Thanks for the review.

I thought "us" is the pt_regs. But it can be everything including
the "running environment" and "running stack".

I will change "us" to "the pt_regs"

>
> --
> Josh
>

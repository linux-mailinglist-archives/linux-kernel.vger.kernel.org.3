Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520AC5258DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359719AbiEMAJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEMAJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:09:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2922854BF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:09:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e24so6640297pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+te11kMiQn1wAaGnvrzw5FU1YDy3n162ybzqTsqCXWw=;
        b=O02+VUPfxLERX+aEvxOOMv58BTXCIigcUQ2GGXQIYGGfH84rhIFoxvB+3DjdKXdNe3
         mla74cDOBOyK50JZVrzFkQSXaBfrmmgwNRX1P3AiIkgOHVGe/zGNlI2Cg4F6mJIhpFot
         fM7vYEUE06CYFzNMu7Vbpwn4X71ZrwbvkgFv6aJlPxEmjeZYYug6VX8ZWyOFJl3FG+oI
         qHd8i1wIyWvK5hQQniAKpC9g9jFqu/sa1ZxaVtgGUzuUtbsoOVr8wykJUmzZiLL46ud8
         sMSvNdeIQEW2nT5LSsWLWrf744oOVEa5yJ1NOxLDiCPPxtT5qlt8PofyyPJ/XbjZdi4W
         Dwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+te11kMiQn1wAaGnvrzw5FU1YDy3n162ybzqTsqCXWw=;
        b=uIaPgFMAd9FMYK8ApEGYepSd2S3oy1QfDZ/Azz6k7ZYmV3+zf/z9C6bF2O2UBI6mv4
         QLIwD45BNrnkurIEWzznjARZIfOKhPrCp2w2ER1Sat4MDYtUcEN6yQh9B4rmz/EivQNV
         hXTo9CUu2WRQSDVQHK8u5fPBJoREN2yPFR3/7nR9P11e23naKH4f/whgJeKmZKVzLj8o
         GdhCfsRe9KY31adksOj9WdjHhWnoU517VEqsejsFoWtcwE4idzIxSwk5hF2V1ZHFNhtJ
         8rVXUnJpSPJQShPxihPyVGrtFRrDjomR1FPcbwVTUnIanB5VhhPXVu82hW9ev5srB/GS
         I+bA==
X-Gm-Message-State: AOAM533fXr01A3/M27xq0AtL9Inwi8/VMX1uySQSJCgRpdWpQyErQTJM
        CGcWW0P73PF15oAiCZdN5mzBU9/bug0h/4aLxvg=
X-Google-Smtp-Source: ABdhPJzWX6qW4/YFCHZ4aZhdqqQLcy0MiIAbU4gjlQfNjhLq+u6RvNYAPiLyqpo6gPxzBS6nQz8EgDTm/O0mViV1P+o=
X-Received: by 2002:a17:902:bcc6:b0:15f:4990:baec with SMTP id
 o6-20020a170902bcc600b0015f4990baecmr1897019pls.102.1652400551692; Thu, 12
 May 2022 17:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com> <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
In-Reply-To: <87o802tjd7.ffs@tglx>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 12 May 2022 17:08:35 -0700
Message-ID: <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, May 12, 2022 at 4:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, May 12 2022 at 15:10, H. J. Lu wrote:
> > On Thu, May 12, 2022 at 2:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >> On 5/12/22 12:39, Thomas Gleixner wrote:
> >> >> It's OK for a debugging build that runs on one kind of hardware.  But,
> >> >> if we want LAM-using binaries to be portable, we have to do something
> >> >> different.
> >> >>
> >> >> One of the stated reasons for adding LAM hardware is that folks want to
> >> >> use sanitizers outside of debugging environments.  To me, that means
> >> >> that LAM is something that the same binary might run with or without.
> >> > On/off yes, but is there an actual use case where such a mechanism would
> >> > at start time dynamically chose the number of bits?
> >>
> >> I'd love to hear from folks doing the userspace side of this.  Will
> >> userspace be saying: "Give me all the bits you can!".  Or, will it
> >> really just be looking for 6 bits only, and it doesn't care whether it
> >> gets 6 or 15, it will use only 6?
> >>
> >> Do the sanitizers have more overhead with more bits?  Or *less* overhead
> >> because they can store more metadata in the pointers?
> >>
> >> Will anyone care about the difference about potentially missing 1/64
> >> issues with U57 versus 1/32768 with U48?
> >
> > The only LAM usage I know so far is LAM_U57 in HWASAN.
>
> That's at least a halfways useful answer.
>
> > An application can ask for LAM_U48 or LAM_U57. But the decision should
> > be made by application.
>
> It can ask for whatever, but the decision whether it's granted is made
> by the kernel for obvious reasons.
>
> > When an application asks for LAM_U57, I expect it will store tags in
> > upper 6 bits, even if the kernel enables LAM_U48.
>
> The kernel does not enable LAM_U48 when the application only wants to
> have LAM_U57, because that would restrict the address space of the
> application to 47 bits on 5-level capable system for no reason.
>
> So what are you trying to tell me?
>

I am expecting applications to ask for LAM_U48 or LAM_U57, not just
LAM.

-- 
H.J.

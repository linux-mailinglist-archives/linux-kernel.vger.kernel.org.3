Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E556B4C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiGHIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiGHIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:52:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FA823BB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:52:44 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mj8iJ-1ndPmI0c45-00fEV0 for <linux-kernel@vger.kernel.org>; Fri, 08 Jul
 2022 10:52:43 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31c89111f23so142151297b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:52:42 -0700 (PDT)
X-Gm-Message-State: AJIora+bBaU/mdFLlL/NA8b9jKvtgieIdnGdQWhadtzUmnhHwdMkMhuX
        eR3z9C2NGCv8tZRvYF7cO/uqrP9fx8UG633AQ38=
X-Google-Smtp-Source: AGRyM1upk5I+00ifCEk1Tch99DP0LP7VCFH7XRhLajb9cqoE8KeCkKRkFYc1m8VJmJngBXWZhScVLmsXrLwH2qlCHUo=
X-Received: by 2002:a81:f82:0:b0:31c:f1ae:1ed6 with SMTP id
 124-20020a810f82000000b0031cf1ae1ed6mr2718775ywp.249.1657270361974; Fri, 08
 Jul 2022 01:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-3-zhengqi.arch@bytedance.com> <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
 <42bfd82c-b3fb-c942-d6f2-ae5adec90a26@bytedance.com> <CAK8P3a17A1t=qkyToQNVnuVfGPp-7VpFx5qJ-gmpyrkJ3yRXTw@mail.gmail.com>
 <33a63e76-fb71-2b9e-3b3c-cc6f7a675cf3@bytedance.com> <CAK8P3a1GgnmhHj+_gRYZ52=TvfBQb_xxYt1Hg-jMJ2gZqCD42w@mail.gmail.com>
 <b53dbf64-b824-89b0-dc00-b894cf9771a9@bytedance.com>
In-Reply-To: <b53dbf64-b824-89b0-dc00-b894cf9771a9@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Jul 2022 10:52:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3DDEkr0D=dLiXN+Xek_OO-HX5xWaQpzdX1GQxTYWnHLw@mail.gmail.com>
Message-ID: <CAK8P3a3DDEkr0D=dLiXN+Xek_OO-HX5xWaQpzdX1GQxTYWnHLw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HhNm72MdRG79NAoQdknnA17thimFp8wXWFPlhnIEt6c6PtJ3w5l
 AJoLz3YVQODAKFji+qnY5uJK8iSBmxI7EZwqEDOjQ8tX3Ql/BK8ogulZY2NL90lKB/SngBB
 I7yDaCl6FZsFqV428pTD4KmVMEL9WCR+9UV6b+zwK94tuKmYQ2iXLWii3CYjbPOqQtUTeJ/
 whF82zQxhGK7vxd95QOQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Azg/2zA8Je8=:h7wDf02orPzYQwXa8pcp+D
 HF9xQV4XQgyCB+aBkmBYVIVMrKK5O2o5/6Acz35InwqQOc6WhDKCxTzJeIywFeZla90XJOds0
 GtoJRhvkdH+TMbkjXkKLCFhV+M8Bm8TfU8llm3SoeVNBhvgqfoqE/EqlpOsR3KzgIcmwm4AQd
 AszxkGXMoI0+L5tndPfE56Obd+SMMhpW1N2h8LvZEaPTx0GuwLQWKedBq9iGSD7RsE8V2AyKy
 +dbGtxFN10UW8w+XBY/I/4ODLHnFDymPYcQdnBWNrTnFABaczq4wOnW2mLr8hdL2d2D+pGtV7
 rwUf7SB5AHBAP5i0+JR0APnLiztiOzuVH6eBLrX/PlP8SJd+1YCnBj7EGTRybauGamqq+lw2G
 oMqbdEyQUN4OFIZIIMbBaceTsJqBPmGq8GQGYD4hDRAtwBxDx+0As9o+YRyBTaQE1aQFHvEKo
 ObprW6+452xZJOUaQ+ddVOoXstGn5s/SCGq/BPI0ZbGVGS7bNhzmiDiPzyUbykzLSKxLut5Z9
 +wOryNKt0A/jqfa5IUsKdz9iijlDb4TodbIVJdYHoq76GIqdFPLWk7m01902ejMFkSQNIHZvd
 TxYwhQwToRhNU/71BJBUkyUqcHNaR7X/unAt8/6EfFexCrDGNskPqM4hLJDluyVJWH+Z4lDHI
 3Eod6dl4bOsD3yHhjoORjGcvq/lQu8HL6CuXGeUR/H+Eyw5am73NLDirwododgIZLBNhFSEfm
 kyLaTTQDrVIcDPXMsvHekB3W7yqx6Rb2W4o1lw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 5:13 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> On 2022/7/8 04:55, Arnd Bergmann wrote:
> > On Thu, Jul 7, 2022 at 5:00 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> >> On 2022/7/7 22:41, Arnd Bergmann wrote:
> >>> On Thu, Jul 7, 2022 at 3:38 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> >>>> On 2022/7/7 20:49, Arnd Bergmann wrote:
> >>>
> >>> -asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
> >>> +asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> >>> +{
> >>> +       if (on_thread_stack())
> >>> +               call_on_irq_stack(regs, el1_irq);
> >>
> >> IMO, this can't work. Because el1_interrupt() will invoke
> >> arm64_preempt_schedule_irq(), which will cause scheduling on the
> >> IRQ stack.
> >
> > Ah, too bad. I spent some more time looking for a simpler approach,
> > but couldn't find one I'm happy with. One idea might be to have
> > callback functions for each combinations of irq/fiq with irq/pnmi
> > to avoid the nested callback pointers. Not sure if that helps.
>
> Maybe nested callback pointers are not always a wild beast. ;)
> This method does not change much, and we can also conveniently stuff
> all kinds of things in do_handler() that we want to run on the IRQ
> stack in addition to the handler().

Right, your approach is probably the one that changes the existing
code the least. I see that x86 handles this by having call_on_irq_stack()
in an inline asm, but this in turn complicates the asm implementation,
which is also worth keeping simple.

         Arnd

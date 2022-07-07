Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C834556AD0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiGGU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiGGU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:56:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D572F014
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:56:06 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M5wgF-1oFLJ93R3D-007Qzt for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022
 22:56:05 +0200
Received: by mail-yb1-f178.google.com with SMTP id l11so34572916ybu.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 13:56:04 -0700 (PDT)
X-Gm-Message-State: AJIora8vunidYv4AKkGEmIgUnkgIWNmrHB/6GIybff1F87bje7zo2OEC
        XWDAONvrSh5PV8/v/Fa6THljheyioqfngV/zpUg=
X-Google-Smtp-Source: AGRyM1upXRF+GGW/UtjAKTTq0g5QSjEbIi2LG6M/I0+ZrKm2rLZ87HfuYOSQnM0bQ6So1BQVXNHbpjulpSMvh7TwuzE=
X-Received: by 2002:a25:3b05:0:b0:66e:c216:4da3 with SMTP id
 i5-20020a253b05000000b0066ec2164da3mr4678373yba.550.1657227363678; Thu, 07
 Jul 2022 13:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-3-zhengqi.arch@bytedance.com> <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
 <42bfd82c-b3fb-c942-d6f2-ae5adec90a26@bytedance.com> <CAK8P3a17A1t=qkyToQNVnuVfGPp-7VpFx5qJ-gmpyrkJ3yRXTw@mail.gmail.com>
 <33a63e76-fb71-2b9e-3b3c-cc6f7a675cf3@bytedance.com>
In-Reply-To: <33a63e76-fb71-2b9e-3b3c-cc6f7a675cf3@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 22:55:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1GgnmhHj+_gRYZ52=TvfBQb_xxYt1Hg-jMJ2gZqCD42w@mail.gmail.com>
Message-ID: <CAK8P3a1GgnmhHj+_gRYZ52=TvfBQb_xxYt1Hg-jMJ2gZqCD42w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YT4YEwI7lADvmugq6duDAJMzi4GD6tZfzCaJpVk+DvagrjhcLIa
 CExsmuqKBjVTNYHO0k3dJpzL9TzasYY3p5BlbWRAys1rjDuPanRTbeVuXHowbO+ALsauNVY
 MJ1/ng/SP/MO10jChtJqE3t/ZulwjPnmVtfi4oRiU7xC0EUWkor5hIn8m7gtWSCIZk0SaOP
 QNsz6+I/018gzL0AXIYQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cdUKPDJOOEI=:q+4GRTCG8w3G0OOFmk6v+T
 hIGGTDobIGX0agvQTLKJnhU46PPodnPm76ya6TPCJdwsh13P5cOZ87MBGJLvLR0hYzHFZSyYb
 DKPVKl78c809hdX/epnULSHiCpuiq7xoMuI9WKnZgeHIg5J6R78uza9ls9cdnooNaMCX3Lyh+
 JlEeSv0k1NaAdvUjuOkH0j/Sejsjt7vUwhYlH9RE2x1RxtV4fSWwGb2UBiwXNQJ0t1wLlMRin
 QcLs+Iacptu5nyQ+Tjzb0MqVH3y4e2N0PPBCoPyq59lohi7dkoJHo3P1KRb/SW0C3mdM/42Kb
 yw0uAIuUuXoiI7yoUgTVkzUWqwvd5n6a2kL6hl036CIL63h8GoZ/ZVjf2dEyVhyphK+Gr8Lf8
 x5uGWNQaLuiWiw85k4zDKKHd2bSp/f4hbaNL4FJI2fV2XsOG94BRTtj5IM2ub7igDlz8KPK/L
 JpV5lUq0VnU9PMw7qRz98TbQo7xDEabrXY5unKsCRZ151hdAf/FRXjvFaYaszVoTDRhUassab
 cbPdlKwCT8dpv5uIT7jZcFYo7md4mDSXQ83RroMtZglERKTvfNJWYGoFQf1wEbxB8NASbiOft
 Sroibk0Vl0njWE3CQcYttg1A+3WyEuroo+el3EBwR3THI8JTmwHom2u5xGUpoGywCvmtiUI04
 vqr68kZj4I9Vxt0ZH7i9xcRNc/P45CKYkZE0olBTRUPph65dekEKCkr3iPmCqQbxaUSJWd1t9
 QrAniEUbBzeTl25e3BxeJFUwN9zNZJ5x3iV7cQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 5:00 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> On 2022/7/7 22:41, Arnd Bergmann wrote:
> > On Thu, Jul 7, 2022 at 3:38 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> >> On 2022/7/7 20:49, Arnd Bergmann wrote:
> >
> > -asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
> > +asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> > +{
> > +       if (on_thread_stack())
> > +               call_on_irq_stack(regs, el1_irq);
>
> IMO, this can't work. Because el1_interrupt() will invoke
> arm64_preempt_schedule_irq(), which will cause scheduling on the
> IRQ stack.

Ah, too bad. I spent some more time looking for a simpler approach,
but couldn't find one I'm happy with. One idea might be to have
callback functions for each combinations of irq/fiq with irq/pnmi
to avoid the nested callback pointers. Not sure if that helps.

       Arnd

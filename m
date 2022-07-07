Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D390256A247
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiGGMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiGGMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:49:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A0227163
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:49:26 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MlfCm-1niNfT15u6-00ijxo for <linux-kernel@vger.kernel.org>; Thu, 07 Jul
 2022 14:49:25 +0200
Received: by mail-yb1-f182.google.com with SMTP id n74so2658060yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:49:25 -0700 (PDT)
X-Gm-Message-State: AJIora+RU13YsAgctoghIi3cvrmRJkkgKEJDabI9WAeffYvt3Q7AOpgF
        5aJPhxcNPrydrM2jQrAtkHuPPMTaL/onFxN/yJA=
X-Google-Smtp-Source: AGRyM1u2Fvu/cpQplBaKR875CUCi5HhHY5imvk/FbdclxT8axZpuC2Bcxj6Lhz50M1EJ72/RmnQY61s4bVTZ6wADIsQ=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr46407217ybc.480.1657198164002; Thu, 07
 Jul 2022 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com> <20220707110511.52129-3-zhengqi.arch@bytedance.com>
In-Reply-To: <20220707110511.52129-3-zhengqi.arch@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 14:49:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
Message-ID: <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DPbMscltPw+zQ0QP1V0y1banuyvzo/5FHaWoAhdNA+yZTJVS2rb
 SUdz6G4lE9yNtUfPDKBBdX3e37RrDrv9YetRTMvXLWriqXJY2LEuZbUvR6i0t+D5x9GTric
 j6ygMY2nJ9Lswu6nEfl60c2pC+u0XsblrcWQY6BIbh6dJh6Q9Pr0gNTVo1MP4/rM4IVBmHS
 PQPMTX5CdX34fqni6AGlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4oS/xf+uwtE=:v0hH5bpQ6erD86xvnayXoO
 50G4rw8xlzl7zAvfRAMmcZyNr9DVdl2b2rLJKApsIKME87Cbbh1NhzxRpXfSlVLLxuNhLQ2TC
 c0VsURk7phSlbViql2LSa3POSHG043Qo9BE6nj1pY/gzhwX0ZnsCVe7TNK7B75fHIFZ8L52UD
 GBvxyMQcj62ag5xlw4qpntH+Y7kj9BU5CS4Er76tcFdNrQyxCcA/QQhbJvTXBojk0VDjxbAu3
 EoCjY10dRaaMgMN1+341Rt2sV/ajxcEbnb9wFeiMS0UwSRsTdeSnPTAA5h1Ei54e8ic8uC2VB
 ed+FHumLxBpwRhxYNW56+UnXwmbJASrGiAGfCss3YBMEkuL/jIy+fmVRCR9I1JLHa119B3nz8
 EWQaqfT0AxslunyyF/klWcaR5wU6ZA2KAa088WB6eptlz93ZQf/sPaPk5mqGYuZj8xPtMbUrH
 DfjrJPlHvaHKrXrJJGts0eQJsjPpRfaPtxWkxThmhyHEixGTmtRVyXfVfBdMUkZa4FcbZ6FaT
 FCk8qI5NloEAQEnd6Zc7WsZbE1wJ+PXQyqrpwN9XbN2pZVDEETYxURBCgVl67Jx2PFekHSzNK
 aYJHVmp3KuV7oQOM7GIE9FeH+7naydxhYI32wIj9NBoA0er4AdnzS93jHYCbC4Ao88OQEqtlM
 59hX2VsUl2y1tyFI2quZFy12LZVC5nC2wXUqpdTDAq2SLKNjnGGcipE1QJQ5GsYOXUFKRBiU/
 MWkIgxooclVwUq32NUpy6VPMcx1MUydj0eFnaYp1ynvi2+q1ApemE4au2s6UKjsaN+dlKFYMf
 d3Qq/SDBuyEJFD2orvRZgLAHapRJyC3WkclqdUnTMYy0w+cI+4CzpWoOsrEk3gacvZCJ240EE
 WWtocZKOOXXrlRyveQZg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> Since softirqs are handled on the per-CPU IRQ stack,
> let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
> the core code to invoke __do_softirq() directly without
> going through do_softirq_own_stack().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

I think the idea is right, but the extra function pointer adds more complexity
than necessary:

>  static __always_inline void __el1_irq(struct pt_regs *regs,
>                                       void (*handler)(struct pt_regs *))
>  {
>         enter_from_kernel_mode(regs);
>
> -       irq_enter_rcu();
> -       do_interrupt_handler(regs, handler);
> -       irq_exit_rcu();
> +       do_interrupt_handler(regs, handler, irq_handler);
>
>         arm64_preempt_schedule_irq();
>
> @@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>         if (regs->pc & BIT(55))
>                 arm64_apply_bp_hardening();
>
> -       irq_enter_rcu();
> -       do_interrupt_handler(regs, handler);
> -       irq_exit_rcu();
> +       do_interrupt_handler(regs, handler, irq_handler);
>
>         exit_to_user_mode(regs);
>  }

Would it be possible to instead pull out the call_on_irq_stack() so these
two functions are instead called on the IRQ stack already?

        Arnd

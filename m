Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9813F57F83E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiGYCax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYCav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:30:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7642703;
        Sun, 24 Jul 2022 19:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CBACB80D96;
        Mon, 25 Jul 2022 02:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A55C341CF;
        Mon, 25 Jul 2022 02:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658716247;
        bh=3Y9WvVFmM0ECeCdNXsmEZ7oye5Th6AVxYZiU45ImmHU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cEuJkFIdcL5eA7zjDyjUv9yKsNHztpEx7BMp/JTYeclXqUbdshF8Z7qyg7afdtOxJ
         cKWnbIwoBAjTtl4ROi0UWFHUDtd6zyI+gPNwwIpIeBgy91cisCCMG958Qyo3rrp4X9
         Lts5FZqB7o7lMb+AMKKAnTENIHyKaOI4pxU0yc1u18J11SI9GqGADYpqRmluqFLIX+
         thUwqBYXhfbe5qQ2Tn4wdQ9/iEs9t3pgRX4mx6F6tHKRG+aiP3PGg5F6Uvvfve1UTw
         HvixzjQZsn0JAB4mP7blWkoTH4wGyj/ZACoaKYbtTsmol1LcNZ3OThCtLRYgw6cnmX
         g2v7wzjNM8YEQ==
Received: by mail-lj1-f171.google.com with SMTP id p22so1754124lji.10;
        Sun, 24 Jul 2022 19:30:47 -0700 (PDT)
X-Gm-Message-State: AJIora+eCi3sNgnnc8qAkpmsAoAgcyJQA1gYKB3rTFMhrtRoH6wClZ7j
        ofwcSuyP15hsVeCDwgMUDlzQ0dVLOh22sPt8Q0Q=
X-Google-Smtp-Source: AGRyM1tXIh5WGwVRcYfmMTXpag8CZiQxI7uiBibR6shkAufg4w1IPkQYQBRcVwNoJ3589Vdgit+RMHCz3mz7y70I8CM=
X-Received: by 2002:a2e:309:0:b0:25e:a57:8337 with SMTP id 9-20020a2e0309000000b0025e0a578337mr371519ljd.50.1658716245827;
 Sun, 24 Jul 2022 19:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220724122517.1019187-1-guoren@kernel.org> <20220724122517.1019187-11-guoren@kernel.org>
 <0ea27d18-6d45-9673-38b7-78d59325f9d5@redhat.com>
In-Reply-To: <0ea27d18-6d45-9673-38b7-78d59325f9d5@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 25 Jul 2022 10:30:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSf4EX_QpbfgKdYtHK-gShsqh5UcLi5xiMcVDRWx1VxHg@mail.gmail.com>
Message-ID: <CAJF2gTSf4EX_QpbfgKdYtHK-gShsqh5UcLi5xiMcVDRWx1VxHg@mail.gmail.com>
Subject: Re: [PATCH V8 10/10] csky: Add qspinlock support
To:     Waiman Long <longman@redhat.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Muellner <cmuellner@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:08 AM Waiman Long <longman@redhat.com> wrote:
>
> On 7/24/22 08:25, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Enable qspinlock by the requirements mentioned in a8ad07e5240c9
> > ("asm-generic: qspinlock: Indicate the use of mixed-size atomics").
> >
> > C-SKY only has "ldex/stex" for all atomic operations. So csky give a
> > strong forward guarantee for "ldex/stex." That means when ldex grabbed
> > the cache line into $L1, it would block other cores from snooping the
> > address with several cycles.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   arch/csky/Kconfig               | 16 ++++++++++++++++
> >   arch/csky/include/asm/Kbuild    |  2 ++
> >   arch/csky/include/asm/cmpxchg.h | 20 ++++++++++++++++++++
> >   3 files changed, 38 insertions(+)
> >
> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index dfdb436b6078..09f7d1f06bca 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -354,6 +354,22 @@ config HAVE_EFFICIENT_UNALIGNED_STRING_OPS
> >         Say Y here to enable EFFICIENT_UNALIGNED_STRING_OPS. Some CPU models could
> >         deal with unaligned access by hardware.
> >
> > +choice
> > +     prompt "C-SKY spinlock type"
> > +     default CSKY_TICKET_SPINLOCKS
> > +
> > +config CSKY_TICKET_SPINLOCKS
> > +     bool "Using ticket spinlock"
> > +
> > +config CSKY_QUEUED_SPINLOCKS
> > +     bool "Using queued spinlock"
> > +     depends on SMP
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     help
> > +       Make sure your micro arch LL/SC has a strong forward progress guarantee.
> > +       Otherwise, stay at ticket-lock/combo-lock.
>
> "combo-lock"? It is a cut-and-paste error. Right?
Yes, it's a typo. No combo-lock for csky.

>
> Cheers,
> Longman
>


-- 
Best Regards
 Guo Ren

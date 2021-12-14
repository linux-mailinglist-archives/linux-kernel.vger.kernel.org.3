Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5365A474120
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhLNLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:08:50 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43220 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233412AbhLNLIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:08:49 -0500
Received: from p5b127e95.dip0.t-ipconnect.de ([91.18.126.149] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mx5fk-0007PU-4y; Tue, 14 Dec 2021 12:08:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph =?ISO-8859-1?Q?M=FCllner?= <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] riscv: provide default implementations for __sbi_set_timer and __sbi_send_ipi
Date:   Tue, 14 Dec 2021 12:08:40 +0100
Message-ID: <1786310.KS0svrzatz@phil>
In-Reply-To: <CAOnJCULdeHn4GmrP8PLsWS43g=HYjUwiA2txisEqgzSmuCoA7w@mail.gmail.com>
References: <20211213112034.2896536-1-heiko@sntech.de> <20211213112034.2896536-2-heiko@sntech.de> <CAOnJCULdeHn4GmrP8PLsWS43g=HYjUwiA2txisEqgzSmuCoA7w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Am Dienstag, 14. Dezember 2021, 03:10:21 CET schrieb Atish Patra:
> On Mon, Dec 13, 2021 at 3:21 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > The mentioned function pointers get called from different sbi functions
> > which may get called from other areas of the kernel without fully
> > checking if the sbi initialization was done.
> 
> SBI initialization happens in sbi_init which is called from setup_arch.
> setup_smp happens after that. Thus, there won't be an IPI issued
> before SMP is set up.
> 
> For __sbi_set_timer, the first time it will be called from this path.
> time_init->timer_probe->riscv_timer_init_dt
> 
> time_init is called from start_kernel after setup_arch. In fact,
> setup_arch is called very early
> in the start_kernel.
> 
> Is there any other scenario where these SBI functions can be invoked
> before SBI is initialized ?

This patch is more of a second thought ;-) .

I.e. I ran into the issue fixed in the first patch, and then tought it
might be nice to also not have these other "dangling pointers" around.
But yeah, it's not that probably that these two will get called
accidentially.

So I guess I'll let you decide on these two functions ;-) .


Heiko


> >
> > So similarly to sbi_remote_fence_i, provide empty functions for them
> > to prevent any null-pointer dereferences in the future.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/riscv/kernel/sbi.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 69d0a96b97d0..6a21345c6712 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -14,6 +14,13 @@
> >  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
> >  EXPORT_SYMBOL(sbi_spec_version);
> >
> > +static void __sbi_set_timer_none(uint64_t stime_value) {}
> > +
> > +static int __sbi_send_ipi_none(const unsigned long *hart_mask)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> >  static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
> >                              unsigned long start, unsigned long size,
> >                              unsigned long arg4, unsigned long arg5)
> > @@ -21,8 +28,9 @@ static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
> >         return -EOPNOTSUPP;
> >  }
> >
> > -static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
> > -static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
> > +static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init = __sbi_set_timer_none;
> > +static int (*__sbi_send_ipi)(const unsigned long *hart_mask)
> > +                           __ro_after_init = __sbi_send_ipi_none;
> >  static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
> >                            unsigned long start, unsigned long size,
> >                            unsigned long arg4, unsigned long arg5)
> > --
> > 2.30.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> 





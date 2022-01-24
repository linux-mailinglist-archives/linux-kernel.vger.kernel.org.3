Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2DA497F92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiAXMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:30:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53154 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241502AbiAXMaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:30:21 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nByU4-0002so-3s; Mon, 24 Jan 2022 13:30:08 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH v5 01/14] riscv: only use IPIs to handle cache-flushes on remote cpus
Date:   Mon, 24 Jan 2022 13:30:06 +0100
Message-ID: <10651919.N8281ZbHTu@diego>
In-Reply-To: <CAOnJCU+NR_hOrvS_+B+OKXeg4s+uh37gYWGVTs_kDd3LQDVEkQ@mail.gmail.com>
References: <20220121163618.351934-1-heiko@sntech.de> <20220121163618.351934-2-heiko@sntech.de> <CAOnJCU+NR_hOrvS_+B+OKXeg4s+uh37gYWGVTs_kDd3LQDVEkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Am Samstag, 22. Januar 2022, 04:45:52 CET schrieb Atish Patra:
> On Fri, Jan 21, 2022 at 8:37 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Right now, the flush_icache functions always use the SBI remote-fence
> > when SBI is available, leaving using IPIs as a fallback mechanism.
> >
> > IPIs on the other hand are more flexible, as the ipi_ops are initially
> > set to go through SBI but later will be overwritten to go through the
> > ACLINT/CLINT.
> >
> > In a discussion we had, Nick was of the opinion that "In general we
> > should prefer doing IPIs on S-mode through CLINT instead of going
> > through SBI/M-mode,
> 
> Yes. Once Anup's ACLINT drivers are merged, that should be the
> preferred approach.
> 
> https://github.com/avpatel/linux/commit/416c667fd77d6f1fc310cbf727ec127aaf96cae2
> 
> >so IMHO we should only be using
> > on_each_cpu_mask(ipi_remote_fence_i) on flush_icache_all()/
> > flush_icache_mm() and remove any explicit calls to sbi_remote_fence_i(),
> 
> That's a bit confusing because we will be using SBI calls for all other fences
> while using IPIs for fence.i
> 
> > because this way we continue using SBI for doing remote fences even after
> > CLINT/ACLINT driver is registered, instead of using direct IPIs through
> > CLINT/ACLINT."
> >
> > So follow this suggestion and just do ipi calls to have the proper kernel
> > parts do them,
> >
> > This also fixes the null-ptr dereference happening when flush_icache_all()
> > is called before sbi_init().
> >
> 
> IMHO, this series should only fix the null-ptr dereference issue.
> The IPI based fence (for all) should only be disabled along with the
> ACLINT driver
> that actually enables S-mode IPIs.

ok, I'll roll this back to simply fixing the null-ptr issue.

Meanwhile I even found a nicer solution without actually touching
the cachflush code.

Without sbi_init() we can assume that we're still before smp bringup,
so the local_flush_icache_all() in flush_icache_all() will do the trick
just fine and sbi_remote_fence_i() simply just needs to be an empty
function until sbi is initialized.


Heiko

> 
> > Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/riscv/mm/cacheflush.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 6cb7d96ad9c7..c35375cd52ec 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -17,11 +17,7 @@ static void ipi_remote_fence_i(void *info)
> >  void flush_icache_all(void)
> >  {
> >         local_flush_icache_all();
> > -
> > -       if (IS_ENABLED(CONFIG_RISCV_SBI))
> > -               sbi_remote_fence_i(NULL);
> > -       else
> > -               on_each_cpu(ipi_remote_fence_i, NULL, 1);
> > +       on_each_cpu(ipi_remote_fence_i, NULL, 1);
> >  }
> >  EXPORT_SYMBOL(flush_icache_all);
> >
> > @@ -66,8 +62,6 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
> >                  * with flush_icache_deferred().
> >                  */
> >                 smp_mb();
> > -       } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> > -               sbi_remote_fence_i(&others);
> >         } else {
> >                 on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> >         }
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





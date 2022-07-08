Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3389756B8BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiGHLkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiGHLkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:40:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E3122BF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:40:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ACE61063;
        Fri,  8 Jul 2022 04:40:32 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAF3D3F70D;
        Fri,  8 Jul 2022 04:40:26 -0700 (PDT)
Date:   Fri, 8 Jul 2022 12:39:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daire.McNamara@microchip.com,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>, hahnjo@hahnjo.de,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>, changbin.du@intel.com,
        Heiko Stuebner <heiko@sntech.de>, philipp.tomsich@vrull.eu,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Brice.Goglin@inria.fr
Subject: Re: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Message-ID: <20220708113915.ui77mgqckjzalwlh@bogus>
References: <20220707220436.4105443-1-mail@conchuod.ie>
 <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus>
 <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
 <20220708092100.c6mgmnt7e2k7u634@bogus>
 <CAMuHMdXUjmG9n3BuRAz_irkmHQbp=7SYxe5VEfOhMdT4D2JfwQ@mail.gmail.com>
 <20220708094710.rxk6flrueegdsggr@bogus>
 <YsgA/eycDF9TgCIT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsgA/eycDF9TgCIT@kroah.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 12:03:41PM +0200, Greg KH wrote:
> On Fri, Jul 08, 2022 at 10:47:10AM +0100, Sudeep Holla wrote:
> > On Fri, Jul 08, 2022 at 11:28:19AM +0200, Geert Uytterhoeven wrote:
> > > Hi Sudeep,
> > > 
> > > On Fri, Jul 8, 2022 at 11:22 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > On Fri, Jul 08, 2022 at 08:35:57AM +0000, Conor.Dooley@microchip.com wrote:
> > > > > On 08/07/2022 09:24, Sudeep Holla wrote:
> > > > > > On Thu, Jul 07, 2022 at 11:04:35PM +0100, Conor Dooley wrote:
> > > > > >> From: Conor Dooley <conor.dooley@microchip.com>
> > > > > >>
> > > > > >> RISC-V & arm64 both use an almost identical method of filling in
> > > > > >> default vales for arch topology. Create a weakly defined default
> > > > > >> implementation with the intent of migrating both archs to use it.
> > > > > >>
> > > > > >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > >> ---
> > > > > >>   drivers/base/arch_topology.c  | 19 +++++++++++++++++++
> > > > > >>   include/linux/arch_topology.h |  1 +
> > > > > >>   2 files changed, 20 insertions(+)
> > > > > >>
> > > > > >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > > > >> index 441e14ac33a4..07e84c6ac5c2 100644
> > > > > >> --- a/drivers/base/arch_topology.c
> > > > > >> +++ b/drivers/base/arch_topology.c
> > > > > >> @@ -765,6 +765,25 @@ void update_siblings_masks(unsigned int cpuid)
> > > > > >>    }
> > > > > >>   }
> > > > > >>
> > > > > >> +void __weak store_cpu_topology(unsigned int cpuid)
> > > > >
> > > > > Does using __weak here make sense to you?
> > > > >
> > > >
> > > > I don't want any weak definition and arch to override as we know only
> > > > arm64 and RISC-V are the only users and they are aligned to have same
> > > > implementation. So weak definition doesn't make sense to me.
> > > >
> > > > > >
> > > > > > I prefer to have this as default implementation. So just get the risc-v
> > > > > > one pushed to upstream first(for v5.20) and get all the backports if required.
> > > > > > Next cycle(i.e. v5.21), you can move both RISC-V and arm64.
> > > > > >
> > > > >
> > > > > Yeah, that was my intention. I meant to label patch 1/4 as "PATCH"
> > > > > and (2,3,4)/4 as RFC but forgot. I talked with Palmer about doing
> > > > > the risc-v impl. and then migrate both on IRC & he seemed happy with
> > > > > it.
> > > > >
> > > >
> > > > Ah OK, good.
> > > >
> > > > > If you're okay with patch 1/4, I'll resubmit it as a standalone v2.
> > > > >
> > > >
> > > > That would be great, thanks. You can most the code to move to generic from
> > > > both arm64 and risc-v once we have this in v5.20-rc1
> > > 
> > > Why not ignore risc-v for now, and move the arm64 implementation to
> > > the generic code for v5.20, so every arch will have it at once?
> > >
> > 
> > We could but,
> > 1. This arch_topology is new and has been going through lot of changes
> >    recently and having code there might make it difficult to backport
> >    changes that are required for RISC-V(my guess)
> 
> Worry about future issues in the future.  Make it simple now as you know
> what you are dealing with at the moment.
>

Sure, I was just suggesting and expecting someone from RISC-V community or
maintainers to make a call. As I said it is based on my understanding.
hence I have mentioned as guess. So I am not against it as such.


-- 
Regards,
Sudeep

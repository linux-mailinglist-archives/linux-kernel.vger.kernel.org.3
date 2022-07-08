Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5C56B63F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiGHKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiGHKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:03:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432717AB9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8372E62333
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC89C341C0;
        Fri,  8 Jul 2022 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657274623;
        bh=vWk5klsWMrK2piIpNQRYEuuIgRWtIJtmTQpPTcJEXOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPJPcWVdKv6Gxu//uPxt+cxRLLa99VE/OiGnIMzWoC17HCaoSswa2QOHPY31aEq1a
         ztS61Tk9jXd2wS3w36q7bwhiuJngvt1YlCiSUYQhdkw4W23yv1cAYLHp733/K8Z+XL
         9D0Gpq/DgQUlvgk9frVOP1PZpg8qwVGOFW2Kc5t8=
Date:   Fri, 8 Jul 2022 12:03:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <Conor.Dooley@microchip.com>,
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
Message-ID: <YsgA/eycDF9TgCIT@kroah.com>
References: <20220707220436.4105443-1-mail@conchuod.ie>
 <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus>
 <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
 <20220708092100.c6mgmnt7e2k7u634@bogus>
 <CAMuHMdXUjmG9n3BuRAz_irkmHQbp=7SYxe5VEfOhMdT4D2JfwQ@mail.gmail.com>
 <20220708094710.rxk6flrueegdsggr@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708094710.rxk6flrueegdsggr@bogus>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 10:47:10AM +0100, Sudeep Holla wrote:
> On Fri, Jul 08, 2022 at 11:28:19AM +0200, Geert Uytterhoeven wrote:
> > Hi Sudeep,
> > 
> > On Fri, Jul 8, 2022 at 11:22 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > On Fri, Jul 08, 2022 at 08:35:57AM +0000, Conor.Dooley@microchip.com wrote:
> > > > On 08/07/2022 09:24, Sudeep Holla wrote:
> > > > > On Thu, Jul 07, 2022 at 11:04:35PM +0100, Conor Dooley wrote:
> > > > >> From: Conor Dooley <conor.dooley@microchip.com>
> > > > >>
> > > > >> RISC-V & arm64 both use an almost identical method of filling in
> > > > >> default vales for arch topology. Create a weakly defined default
> > > > >> implementation with the intent of migrating both archs to use it.
> > > > >>
> > > > >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > >> ---
> > > > >>   drivers/base/arch_topology.c  | 19 +++++++++++++++++++
> > > > >>   include/linux/arch_topology.h |  1 +
> > > > >>   2 files changed, 20 insertions(+)
> > > > >>
> > > > >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > > >> index 441e14ac33a4..07e84c6ac5c2 100644
> > > > >> --- a/drivers/base/arch_topology.c
> > > > >> +++ b/drivers/base/arch_topology.c
> > > > >> @@ -765,6 +765,25 @@ void update_siblings_masks(unsigned int cpuid)
> > > > >>    }
> > > > >>   }
> > > > >>
> > > > >> +void __weak store_cpu_topology(unsigned int cpuid)
> > > >
> > > > Does using __weak here make sense to you?
> > > >
> > >
> > > I don't want any weak definition and arch to override as we know only
> > > arm64 and RISC-V are the only users and they are aligned to have same
> > > implementation. So weak definition doesn't make sense to me.
> > >
> > > > >
> > > > > I prefer to have this as default implementation. So just get the risc-v
> > > > > one pushed to upstream first(for v5.20) and get all the backports if required.
> > > > > Next cycle(i.e. v5.21), you can move both RISC-V and arm64.
> > > > >
> > > >
> > > > Yeah, that was my intention. I meant to label patch 1/4 as "PATCH"
> > > > and (2,3,4)/4 as RFC but forgot. I talked with Palmer about doing
> > > > the risc-v impl. and then migrate both on IRC & he seemed happy with
> > > > it.
> > > >
> > >
> > > Ah OK, good.
> > >
> > > > If you're okay with patch 1/4, I'll resubmit it as a standalone v2.
> > > >
> > >
> > > That would be great, thanks. You can most the code to move to generic from
> > > both arm64 and risc-v once we have this in v5.20-rc1
> > 
> > Why not ignore risc-v for now, and move the arm64 implementation to
> > the generic code for v5.20, so every arch will have it at once?
> >
> 
> We could but,
> 1. This arch_topology is new and has been going through lot of changes
>    recently and having code there might make it difficult to backport
>    changes that are required for RISC-V(my guess)

Worry about future issues in the future.  Make it simple now as you know
what you are dealing with at the moment.

thanks,

greg k-h

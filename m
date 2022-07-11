Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D0C570710
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiGKPZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiGKPZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:25:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53C973C8D1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:25:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F3A91596;
        Mon, 11 Jul 2022 08:25:41 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56F7F3F70D;
        Mon, 11 Jul 2022 08:25:35 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:24:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Conor Dooley <mail@conchuod.ie>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v3 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Message-ID: <20220711152423.djfqk6wbhmrshbkr@bogus>
References: <20220709152354.2856586-1-mail@conchuod.ie>
 <20220709152354.2856586-2-mail@conchuod.ie>
 <20220711143542.nlq6a5nuh4nouomo@bogus>
 <Ysw4voXuz+tcSKhf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysw4voXuz+tcSKhf@kroah.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:50:38PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 11, 2022 at 03:35:42PM +0100, Sudeep Holla wrote:
> > On Sat, Jul 09, 2022 at 04:23:54PM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > arm64's method of defining a default cpu topology requires only minimal
> > > changes to apply to RISC-V also. The current arm64 implementation exits
> > > early in a uniprocessor configuration by reading MPIDR & claiming that
> > > uniprocessor can rely on the default values.
> > > 
> > > This is appears to be a hangover from prior to '3102bc0e6ac7 ("arm64:
> > > topology: Stop using MPIDR for topology information")', because the
> > > current code just assigns default values for multiprocessor systems.
> > > 
> > > With the MPIDR references removed, store_cpu_topolgy() can be moved to
> > > the common arch_topology code.
> > >
> > 
> > Looks good. FWIW,
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > > CC: stable@vger.kernel.org
> > 
> > However, while I understand the reason why this is needed in stable trees
> > for RISC-V, I am not sure if we want this for stable tree at-least on arm64.
> > I leave that part to Greg and Will.
> 
> Why would it be good for one arch but bad for another?

Not really bad as such. Just needs testing and must not change much ideally,
but it really depends on which stable trees we will target and what is the
original state there. As mentioned in the commit, this changed a bit around
v5.8/9 on arm64 and not sure what kernels RISC-V needs this. There could
be some surprises on some Andriod platforms but that is something we can
look at when if and when there are complaints.

I am in general not sure what is the -stable tree rules is such situation and
hence made the noise so that we are aware that we may need more work than just
backporting this patch. Also this is just my opinion. If we decide to backport
esp. to kernels older than the one containing 3102bc0e6ac7, then arm64 may need
more changes or probably we can pull that commit if that makes it easier. Based
on what is decided and what are the targeted -stable trees, we can dig deeper.

-- 
Regards,
Sudeep

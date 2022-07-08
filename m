Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9900956BB66
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiGHOAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGHOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:00:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6775517586
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:00:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CCE0106F;
        Fri,  8 Jul 2022 07:00:47 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1E33F66F;
        Fri,  8 Jul 2022 07:00:42 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:59:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     gregkh@linuxfoundation.org, geert@linux-m68k.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
        rafael@kernel.org, Daire.McNamara@microchip.com,
        niklas.cassel@wdc.com, damien.lemoal@opensource.wdc.com,
        zong.li@sifive.com, kernel@esmil.dk, hahnjo@hahnjo.de,
        guoren@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
        changbin.du@intel.com, heiko@sntech.de, philipp.tomsich@vrull.eu,
        robh@kernel.org, maz@kernel.org, viresh.kumar@linaro.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Brice.Goglin@inria.fr
Subject: Re: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Message-ID: <20220708135932.7srpzia53jbpmitg@bogus>
References: <20220707220436.4105443-1-mail@conchuod.ie>
 <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus>
 <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
 <20220708092100.c6mgmnt7e2k7u634@bogus>
 <CAMuHMdXUjmG9n3BuRAz_irkmHQbp=7SYxe5VEfOhMdT4D2JfwQ@mail.gmail.com>
 <20220708094710.rxk6flrueegdsggr@bogus>
 <YsgA/eycDF9TgCIT@kroah.com>
 <20220708113915.ui77mgqckjzalwlh@bogus>
 <9f8d4e4d-f24b-faf3-687f-90370939c72f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8d4e4d-f24b-faf3-687f-90370939c72f@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:57:05AM +0000, Conor.Dooley@microchip.com wrote:
> 
> I did a little bit of poking in the git history.
> The last code touching the arm implementation was:
> 3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology information")
> on Fri Oct 2 12:01:41 2020 +0100
> 
> The introduction of arch-topology stuff to RISC-V was:
> 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
> on Thu Jun 27 12:53:00 2019 -0700
> 
> Backporting as far as v5.10 should be no real effort and I don't think
> to v5.4 that should be meaninfully harder. If 3102bc0e6ac7 hasn't been
> backported already, maybe it should be since it appears to have been
> fixing a problem too.
>

Thanks for doing the research and sorry for the noise earlier.

> Based on that, I think doing this the straightforward way in the first
> place is a better idea.
> 
> I'll respin the series as:
> patch 1: Move arm64 to the generic implementation

I don't think the mpidr check we have there is of much use IMO. You can
drop that and see if arm64 maintainers and/or others agree. As you have
already figured, since 3102bc0e6ac7 we are not using MPIDR and the one
check we have is optional IMO. So you can either drop it or keep it as
in your RFC and then post updates.

-- 
Regards,
Sudeep

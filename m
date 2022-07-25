Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1857FC19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiGYJN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGYJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:13:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDA13F2A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A77ECB80E07
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EACDC341C6;
        Mon, 25 Jul 2022 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658740435;
        bh=166hHxnqJZuqNRs6jN7i2hnEDOh1yEqMVw809Cf7sao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDqBQGrYAAwdDn6N5k2L/xUP8JKOQxPi/cYsoYQf413L60XLMhh4DfnQ5nJUOzrT9
         1DveHthHyxZl0ePsTGDn7XxpT8b5YzfDfpF9Be/J8Dg7/Fx3KSdHKRqLgCzxf2ZdRh
         pkKmDSdiFsQkm2y3vWJjuHDdgV/tcdLN+OjjqWDNULpQFSEymLcgmUGVvmMdsIt2yP
         COmMqOaOZH/rCMoQgBIpk8KJ25rqk5PiIGhimCKnAFC/V4LzhNBXUniY6PS2hNshYT
         9oohnM0U6prv4gMyO3hfO5CIu2EeuOnhSb6FGKWxtWYTneLa9X7ogrzLtc/NMjosWU
         gJ9S0gRNLOSdg==
Date:   Mon, 25 Jul 2022 10:13:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, Daire.McNamara@microchip.com,
        niklas.cassel@wdc.com, damien.lemoal@opensource.wdc.com,
        geert@linux-m68k.org, zong.li@sifive.com, kernel@esmil.dk,
        hahnjo@hahnjo.de, guoren@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org, heiko@sntech.de, philipp.tomsich@vrull.eu,
        robh@kernel.org, maz@kernel.org, viresh.kumar@linaro.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Brice.Goglin@inria.fr
Subject: Re: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Message-ID: <20220725091346.GA20370@willie-the-truck>
References: <20220715175155.3567243-1-mail@conchuod.ie>
 <96972ad8-d146-3bc2-0e49-ffe88580bbee@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96972ad8-d146-3bc2-0e49-ffe88580bbee@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 11:22:01AM +0000, Conor.Dooley@microchip.com wrote:
> On 15/07/2022 18:51, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Hey all,
> > It's my first time messing around with arch/ code at all, let alone
> > more than one arch, so forgive me if I have screwed up how to do a
> > migration like this.
> > 
> > The goal here is the fix the incorrectly reported arch topology on
> > RISC-V which seems to have been broken since it was added.
> > cpu, package and thread IDs are all currently reported as -1, so tools
> > like lstopo think systems have multiple threads on the same core when
> > this is not true:
> > https://github.com/open-mpi/hwloc/issues/536
> 
> Hey,
> 
> Not got any feedback on the smpboot changes from the RISC-V side.
> I tested it on polarfire, the d1 (with both SMP & !SMP set iirc)
> & on the u540. It all looked good to me.
> 
> I'd like to have this fixed for v5.20, but there isn't too much
> time left before the mw. Not too sure about the cross-tree changes,
> does it need an immutable branch or could it go through driver-core?
> Catalin suggested removing the CC stable from patch 1/2 & adding it
> as a dependency for the 2/2 patch - but obviously that's up to the
> committer to sort out.

I'm finalising the arm64 queue today, so I don't really want to pull in
additional changes beyond critical fixes at this point, I'm afraid. I was
half-expecting a pull request from the riscv side last week but I didn't
see anything.

FWIW, if there's still no movement by -rc1, then I'm happy to queue all
of this on its own branch in the arm64 tree for 5.21.

Let me know.

Will

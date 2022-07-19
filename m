Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B543F5799CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiGSMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiGSMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5893248EA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33A761697
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD9BC341CA;
        Tue, 19 Jul 2022 12:00:48 +0000 (UTC)
Date:   Tue, 19 Jul 2022 13:00:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com, will@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Daire.McNamara@microchip.com, niklas.cassel@wdc.com,
        damien.lemoal@opensource.wdc.com, geert@linux-m68k.org,
        zong.li@sifive.com, kernel@esmil.dk, hahnjo@hahnjo.de,
        guoren@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
        heiko@sntech.de, philipp.tomsich@vrull.eu, robh@kernel.org,
        maz@kernel.org, viresh.kumar@linaro.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Brice.Goglin@inria.fr
Subject: Re: [PATCH v4 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Message-ID: <Ytac7G1zlq6WW4jt@arm.com>
References: <20220715175155.3567243-1-mail@conchuod.ie>
 <20220715175155.3567243-2-mail@conchuod.ie>
 <YtaYTgFDpGSsG+H0@arm.com>
 <198b0486-29e7-9729-d137-0470e93038fa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198b0486-29e7-9729-d137-0470e93038fa@microchip.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:51:04AM +0000, Conor.Dooley@microchip.com wrote:
> On 19/07/2022 12:41, Catalin Marinas wrote:
> > On Fri, Jul 15, 2022 at 06:51:55PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> arm64's method of defining a default cpu topology requires only minimal
> >> changes to apply to RISC-V also. The current arm64 implementation exits
> >> early in a uniprocessor configuration by reading MPIDR & claiming that
> >> uniprocessor can rely on the default values.
> >>
> >> This is appears to be a hangover from prior to '3102bc0e6ac7 ("arm64:
> >> topology: Stop using MPIDR for topology information")', because the
> >> current code just assigns default values for multiprocessor systems.
> >>
> >> With the MPIDR references removed, store_cpu_topolgy() can be moved to
> >> the common arch_topology code.
> >>
> >> CC: stable@vger.kernel.org
> > 
> > I'd quantify how far back you want this to go. IIUC based on the Fixes
> > tag in the other patch, it should stop at 5.4. If you send a pull
> > request instead and have a fixed commit id, you could add it as a
> > prerequisite on the following patch without a cc stable here.
> 
> I guess a PR might be the easiest way for it anyway, so that both
> yourself and Palmer could merge it?

I guess so, a stable branch would do. Note that Will is handling the
upcoming merging window.

-- 
Catalin

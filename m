Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AE507C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358110AbiDSV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiDSV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C614640A26;
        Tue, 19 Apr 2022 14:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01568617A3;
        Tue, 19 Apr 2022 21:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595E2C385A5;
        Tue, 19 Apr 2022 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650405417;
        bh=vK+u19Vo4pPWHW4AOOoegJ23VjuTI5AZJt/iy5wjXnA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NKWXwr1iZiOxaeAeXmhNeNUD8aHdbbrzkY7acDWF9Xn+s950ZoWL4sWSq+Ufd8gHN
         RPnILUgBdL8RXe9MGCNp6L+jHB2u2j0Cg2dmDRBleDX1ULsxLABc1WCFrDGllZxsTh
         WDqnSO3sYDkXRsEPq+nK47JMXRXyoagNtpnvmXRQ0p/OQKLT/UrMaJY8C74vymugrV
         zPWT5jf2O1CFNoti3s4d+U6hxrVG/FrSmP59t/GaEZH1tOcvypQ/lL20uz0PeGZ33Q
         eBqhyM+oq+Ngv1uXsLW/qJOxkTXTpuLc9S7FUBL9C8RDkFguzbT/V8IF+QrEkn1w9I
         ZkgsUPBtZmKPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAB3D5C031F; Tue, 19 Apr 2022 14:56:56 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:56:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
Message-ID: <20220419215656.GT4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415133356.179706384@linutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 09:19:48PM +0200, Thomas Gleixner wrote:
> APERF/MPERF is utilized in two ways:
> 
>   1) Ad hoc readout of CPU frequency which requires IPIs
> 
>   2) Frequency scale calculation for frequency invariant scheduling which
>      reads APERF/MPERF on every tick.
> 
> These are completely independent code parts. Eric observed long latencies
> when reading /proc/cpuinfo which reads out CPU frequency via #1 and
> proposed to replace the per CPU single IPI with a broadcast IPI.
> 
> While this makes the latency smaller, it is not necessary at all because #2
> samples APERF/MPERF periodically, except on idle or isolated NOHZ full CPUs
> which are excluded from IPI already.
> 
> It could be argued that not all APERF/MPERF capable systems have the
> required BIOS information to enable frequency invariance support, but in
> practice most of them do. So the APERF/MPERF sampling can be made
> unconditional and just the frequency scale calculation for the scheduler
> excluded.
> 
> The following series consolidates that.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Thanks,
> 
> 	tglx
> ---
>  arch/x86/include/asm/cpu.h       |    2 
>  arch/x86/include/asm/topology.h  |   17 -
>  arch/x86/kernel/acpi/cppc.c      |   28 --
>  arch/x86/kernel/cpu/aperfmperf.c |  474 +++++++++++++++++++++++++++++++--------
>  arch/x86/kernel/cpu/proc.c       |    2 
>  arch/x86/kernel/smpboot.c        |  358 -----------------------------
>  fs/proc/cpuinfo.c                |    6 
>  include/linux/cpufreq.h          |    1 
>  8 files changed, 405 insertions(+), 483 deletions(-)
> 
> 

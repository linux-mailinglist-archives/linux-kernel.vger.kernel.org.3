Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5D46D9AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhLHRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbhLHRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:33:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095ADC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56499B82204
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20949C341C7;
        Wed,  8 Dec 2021 17:29:43 +0000 (UTC)
Date:   Wed, 8 Dec 2021 17:29:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <YbDrhQLeBdn0wqKT@arm.com>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
 <20211205135103.GA42658@leoy-ThinkPad-X240s>
 <Ya9J8HnMWxBy3MJv@arm.com>
 <20211207123118.GA255238@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207123118.GA255238@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:31:18PM +0800, Leo Yan wrote:
> On Tue, Dec 07, 2021 at 11:48:00AM +0000, Catalin Marinas wrote:
> > On Sun, Dec 05, 2021 at 09:51:03PM +0800, Leo Yan wrote:
> > > On Fri, Dec 03, 2021 at 04:22:42PM +0000, Catalin Marinas wrote:
> > > > What's the cost of always enabling CONFIG_PID_IN_CONTEXTIDR? If it's
> > > > negligible, I'd not bother at all with any of the enabling/disabling.
> > > 
> > > Yes, I compared performance for PID tracing with always enabling and
> > > disabling CONFIG_PID_IN_CONTEXTIDR, and also compared with using
> > > static key for enabling/disabling PID tracing.  The result shows the
> > > cost is negligible based on the benchmark 'perf bench sched'.
> > > 
> > > Please see the detailed data in below link (note the testing results
> > > came from my Juno board):
> > > https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/
> > 
> > The table wasn't entirely clear to me. So the dis/enb benchmarks are
> > without this patchset applied.
> 
> Yes, dis/enb metrics don't apply this patchset.
> 
> > There seems to be a minor drop but it's
> > probably noise. Anyway, do we need this patchset or we just make
> > CONFIG_PID_IN_CONTEXTIDR default to y?
> 
> Good point.  I remembered before we had discussed for making
> CONFIG_PID_IN_CONTEXTIDR to 'y', but this approach is not always valid,
> especially when the profiling process runs in non-root PID namespace,
> in this case, hardware tracing data (e.g. Arm SPE or CoreSight) cannot
> trust the PID values from tracing since the PID conflicts between
> different PID namespaces.
> 
> So this patchset is to add the fundamental mechanism for dynamically
> enabling and disable PID tracing into CONTEXTIDR.  Based on it, we can
> use helpers to dynamically enable PID tracing _only_ when process runs
> in root PID namespace.

I don't think your approach fully works. Let's say you are tracing two
processes, one in the root PID namespace, the other not. Since the
former enables PID in CONTEXTIDR, you automatically get some PID in
CONTEXTIDR for the latter whether you requested it explicitly or not.

I wonder whether it makes more sense to turn this on per thread. You set
some TIF flag and set the PID in contextidr_thread_switch() only if the
flag is set. You could also check there if the PID is in the root
namespace and avoid setting CONTEXTIDR (or write 0).

-- 
Catalin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D346BA5B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhLGLvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbhLGLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:51:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35AC061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 03:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7101CE1A7B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 11:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B2CC341C3;
        Tue,  7 Dec 2021 11:48:03 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:48:00 +0000
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
Message-ID: <Ya9J8HnMWxBy3MJv@arm.com>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
 <20211205135103.GA42658@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205135103.GA42658@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 09:51:03PM +0800, Leo Yan wrote:
> On Fri, Dec 03, 2021 at 04:22:42PM +0000, Catalin Marinas wrote:
> > What's the cost of always enabling CONFIG_PID_IN_CONTEXTIDR? If it's
> > negligible, I'd not bother at all with any of the enabling/disabling.
> 
> Yes, I compared performance for PID tracing with always enabling and
> disabling CONFIG_PID_IN_CONTEXTIDR, and also compared with using
> static key for enabling/disabling PID tracing.  The result shows the
> cost is negligible based on the benchmark 'perf bench sched'.
> 
> Please see the detailed data in below link (note the testing results
> came from my Juno board):
> https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/

The table wasn't entirely clear to me. So the dis/enb benchmarks are
without this patchset applied. There seems to be a minor drop but it's
probably noise. Anyway, do we need this patchset or we just make
CONFIG_PID_IN_CONTEXTIDR default to y?

> > Another question: can you run multiple instances of SPE for different
> > threads on different CPUs? What happens to the global contextidr_in_use
> > key when one of them stops?
> 
> No, I only can launch one instance for Arm SPE event via perf tool; when
> I tried to launch a second instance, perf tool reports failure:
> 
> The sys_perf_event_open() syscall returned with 16 (Device or resource
> busy) for event (arm_spe_0/load_filter=1,store_filter=1/u).
[...]
> Alternatively, I'd like give several examples for contextidr_in_use key
> values when run different perf modes.
[...]
> Hope these three cases can demonstrate the usage for contextidr_in_use
> static key.

OK, so we can have multiple uses of PID in CONTEXTIDR. Since
static_branch_inc() is refcounted, we get away with this but the
downside is that a CPU won't notice until its next thread switch.

-- 
Catalin

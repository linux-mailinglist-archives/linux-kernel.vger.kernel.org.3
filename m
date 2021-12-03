Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B5A467B46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352831AbhLCQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352767AbhLCQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:26:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C371C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:22:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 279B362C3A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF6FC53FAD;
        Fri,  3 Dec 2021 16:22:46 +0000 (UTC)
Date:   Fri, 3 Dec 2021 16:22:42 +0000
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
Message-ID: <YapEUlcyDZ6TuE6n@arm.com>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101152835.GB375622@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 11:28:35PM +0800, Leo Yan wrote:
> On Thu, Oct 21, 2021 at 08:49:46AM -0700, Kees Cook wrote:
> > On Thu, Oct 21, 2021 at 09:45:30PM +0800, Leo Yan wrote:
> > > Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
> > > driver invokes these functions to dynamically enable it during
> > > profiling when the program runs in root PID name space, and disable PID
> > > tracing when the perf event is stopped.
> > > 
> > > Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
> > > tracing, so this patch uses the consistent condition for setting bit
> > > EL1_CX for PMSCR.
> > 
> > My own preference here would be to not bother with the new
> > enable/disable helpers, but just open code it right here. (Save a patch
> > and is the only user.) But I defer to the taste of arm64 maintainers. :)
> 
> Before I send out a new version for this patch set (for support
> dynamic PID tracing on Arm64), I'd like to get your opinions for two
> things:
> 
> - Firstly, as Kees suggested to directly use variable
>   'contextidr_in_use' in drivers, which is exported as GPL symbol,
>   it's not necessarily to add two helpers contextidr_{enable|disable}().
>   What's your preference for this?

My preference would be to keep the helpers.

> - Secondly, now this patch set only support dynamic PID tracing for
>   Arm64; and there would be two customers to use dynamic PID tracing:
>   Arm SPE and Coresight ETMv4.x.  So this patch set doesn't support
>   dynamic PID tracing for Arm32 (under arch/arm).
> 
>   Do you accept this patch set for enabling PID tracing on Arm64 and we
>   can defer to support Arm32 when really need PID tracing on Arm32?
>   Or we should enable PID dynamic tracing for Arm64 and Arm32 in one
>   go?

If it doesn't break arm32, it's fine by me.

What's the cost of always enabling CONFIG_PID_IN_CONTEXTIDR? If it's
negligible, I'd not bother at all with any of the enabling/disabling.

Another question: can you run multiple instances of SPE for different
threads on different CPUs? What happens to the global contextidr_in_use
key when one of them stops?

-- 
Catalin

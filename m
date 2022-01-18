Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3AA49237C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiARKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiARKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:07:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 02:07:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68AA8B812A5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5931C00446;
        Tue, 18 Jan 2022 10:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642500427;
        bh=LtGI7ReI1VAbLJR+tqn3W9qAVWXu25LmWPuXFerZXhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg9Z5PRj0PLyaAfZcZ0nd+RtrzHE3w1vkMa0by9aVLjd6SwARimg+IUMbRee82B2N
         np7ybr4YgzC1p2EpKJY1Wr3ODdXmJHnXLr8BAL6lU3+pJCjSeXGReJ4xztXjn7s060
         spfUotA4H38aFS/1tTrJ4B7JYUbbfI52ofw5hiCrGYTpCWJ2Mn+cHtdkbqBSoWzAvr
         55qljGPlUGFYdWByjOKRoQ7E49jEyjnvUu61E7QPnAw+YcQLh4JtLic25I2/o4BXre
         Db84KAfITczL+QsH6aiqcN0S4B+BWGloJZaqOpmbxbOmNox3SihDkK3EV7XUSfitfQ
         29KDcQrXVSk9A==
Date:   Tue, 18 Jan 2022 10:07:02 +0000
From:   Will Deacon <will@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, james.clark@arm.com, leo.yan@linaro.org
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
Message-ID: <20220118100702.GB16547@willie-the-truck>
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117124432.3119132-2-german.gomez@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:44:31PM +0000, German Gomez wrote:
> The arm_spe_pmu driver will enable the CX bit of the PMSCR register in
> order to add CONTEXT packets into the traces if the owner of the perf
> event runs with capabilities CAP_PERFMON or CAP_SYS_ADMIN.
> 
> The value of the bit is computed in the arm_spe_event_to_pmscr function
> [1], and the check for capabilities happens in [2] in the pmu init
> callback. This suggests that the value of the CX bit should remain
> consistent for the duration of the perf session.
> 
> However, the function arm_spe_event_to_pmscr may be called later during
> the start callback [3] when the "current" process is not the owner of
> the perf session, so the CX bit is currently not consistent. Consider
> the following example:
> 
>   1. Run a process in the background with capability CAP_SYS_ADMIN in CPU0.
> 
>     $ taskset --cpu-list 0 sudo dd if=/dev/random of=/dev/null &
>     [3] 3806
> 
>   2. Begin a perf session _without_ capabilities (we shouldn't see CONTEXT packets).
> 
>     $ perf record -e arm_spe_0// -C0 -- sleep 1
>     $ perf report -D | grep CONTEXT
>     .  0000000e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>     .  0000004e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>     .  0000008e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>     [...]
> 
> As can be seen, the traces begin showing CONTEXT packets when the pid is
> 0xedf (3807).

So to be clear: we shouldn't be reporting these packets because 'perf'
doesn't have the right capabilities, but we evaluate that in the context of
'dd' (running as root) and so incorrectly grant the permission. Correct?

> This happens because the pmu start callback is run when
> the current process is not the owner of the perf session, so the CX
> register bit is set.

This doesn't really seem SPE-specific to me -- the perf_allow_*() helpers
also operate implicitly on the current task. How do other PMU drivers avoid
falling into this trap?

> One way to fix this is by caching the value of the CX bit during the
> initialization of the PMU event, so that it remains consistent for the
> duration of the session.

It doesn't feel right to stash this in 'struct arm_spe_pmu' during event
initialisation -- wouldn't that allow perf to continue creating new events
with CX set, even if the paranoid sysctl was changed dynamically? Instead,
I think it would be better if the capabilities were stash in the event
itself somehow at initialisation time.

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA858C693
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiHHKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiHHKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:38:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB72A1B9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:38:19 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA9F11EC0380;
        Mon,  8 Aug 2022 12:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659955094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ws//62ri8qZO1IOv5O1m08aPTxdUCdaAOH8YuEEjwkI=;
        b=N1t5rTc28OfX4kk8V2CPYnXHczOZaWpeTnScBov7AfPb2HQBoPHSkCBsKHUg4eXD2uFfol
        H6T0HFCgN66AbDpmmLFACvjYB5+OXkND0d5tut0HUWEeEMDnkQDZjCsym7lpxE/1UcEMqx
        T4fdMnXPtqJCASg3WuomQtXXjWWymGc=
Date:   Mon, 8 Aug 2022 12:38:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     ira.weiny@intel.com
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 1/5] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Message-ID: <YvDnkALyHl77R/Ug@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805173009.3128098-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 10:30:05AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Auxiliary pt_regs space needs to be manipulated by the generic
> entry/exit code.
> 
> Ideally irqentry_exit() would take care of handling any auxiliary
> pt_regs on exit.  Unfortunately, irqentry_exit() is not the only exit
> from exception path.  The call to irqentry_exit_cond_resched() from
> xen_pv_evtchn_do_upcall() bypasses irqentry_exit().
> 
> Make irqentry_exit_cond_resched() symmetrical with irqentry_enter() by
> passing pt_regs to it.  This makes irqentry_exit_cond_resched() capable
> of handling auxiliary pt_regs in future patches.
> 
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Forward ported from PKS series:
> 	https://lore.kernel.org/lkml/20220419170649.1022246-19-ira.weiny@intel.com/
> ---
>  arch/arm64/include/asm/preempt.h |  2 +-
>  arch/arm64/kernel/entry-common.c |  4 ++--
>  arch/x86/entry/common.c          |  2 +-
>  include/linux/entry-common.h     | 17 ++++++++------
>  kernel/entry/common.c            | 13 +++++++----
>  kernel/sched/core.c              | 40 ++++++++++++++++----------------
>  6 files changed, 43 insertions(+), 35 deletions(-)

Why all this churn?

Why can't you add a parameter to irqentry_exit():

  noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state, bool cond_resched);

and then have all callers except xen_pv_evtchn_do_upcall() pass in false
and this way have all exit paths end up in irqentry_exit()?

And, ofc, move the true case which is the body of
raw_irqentry_exit_cond_resched() to irqentry_exit() and then get rid of
former.

xen_pv_evtchn_do_upcall() will, ofc, do:

        if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
                irqentry_exit(regs, state, true);
                instrumentation_end();
                restore_inhcall(inhcall);
        } else {
                instrumentation_end();
                irqentry_exit(regs, state, false);

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

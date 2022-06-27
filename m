Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC455B5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiF0Dhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiF0Dhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:37:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23C5593
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04EE2CE1230
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAA1C34114;
        Mon, 27 Jun 2022 03:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656301051;
        bh=gHH9MPfYFwv7OpaRexSVNlKnClQqzBmYkItew9GtzSs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Wf/hqL6OIqVhQM9NYneJOtnsC9H+XcyoriOSJFQC+z9CSTyZ6vwKjy14yVCamuO3Q
         lRKzbCT9wUfZbxjPGwzwUQ7ngGGHx0/hgJPerHpvpT+O6QoTSXm8atm5/p0aqEr/YS
         IDW2tcDXaUXuATGDAJjkSnBCB1yW2ZqaiPnmo4YmDP4UtE7shPASbXMXzSadliP6/J
         OsvWeiOwHcxUdf1JdFeqG/S1OyijDkFPtkJL9xH1HshXM7E5W6GQETvIOgTFnMhA7O
         fqDfM+EXW4u5YmSv7X9Ll4k+wyaOQi9dxf17kqVL7CdJhOYhHuSFIfKbwskD8+m8p9
         Evt3SDdAZCSGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5AD425C098A; Sun, 26 Jun 2022 20:37:30 -0700 (PDT)
Date:   Sun, 26 Jun 2022 20:37:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tick/nohz: unexport __init-annotated
 tick_nohz_full_setup()
Message-ID: <20220627033730.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220627032209.52396-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627032209.52396-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 12:22:09PM +0900, Masahiro Yamada wrote:
> EXPORT_SYMBOL and __init is a bad combination because the .init.text
> section is freed up after the initialization. Hence, modules cannot
> use symbols annotated __init. The access to a freed symbol may end up
> with kernel panic.
> 
> modpost used to detect it, but it had been broken for a decade.
> 
> Commit 28438794aba4 ("modpost: fix section mismatch check for exported
> init/exit sections") fixed it so modpost started to warn it again, then
> this showed up:
> 
>     MODPOST vmlinux.symvers
>   WARNING: modpost: vmlinux.o(___ksymtab_gpl+tick_nohz_full_setup+0x0): Section mismatch in reference from the variable __ksymtab_tick_nohz_full_setup to the function .init.text:tick_nohz_full_setup()
>   The symbol tick_nohz_full_setup is exported and annotated __init
>   Fix this by removing the __init annotation of tick_nohz_full_setup or drop the export.
> 
> Drop the export because tick_nohz_full_setup() is only called from the
> built-in code in kernel/sched/isolation.c.
> 
> Fixes: ae9e557b5be2 ("time: Export tick start/stop functions for rcutorture")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

I went through my email and notes, and cannot find whatever it was that
possessed me to add tick_nohz_full_setup() to ae9e557b5be2.  The other
two symbols have clear motivations.  Apologies for the noise!!!

							Thanx, Paul

> ---
> 
>  kernel/time/tick-sched.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 58a11f859ac7..30049580cd62 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -526,7 +526,6 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
>  	cpumask_copy(tick_nohz_full_mask, cpumask);
>  	tick_nohz_full_running = true;
>  }
> -EXPORT_SYMBOL_GPL(tick_nohz_full_setup);
>  
>  static int tick_nohz_cpu_down(unsigned int cpu)
>  {
> -- 
> 2.32.0
> 

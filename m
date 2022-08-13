Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F415591BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiHMQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbiHMQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:25:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57F13DF0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:25:11 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0A901EC054E;
        Sat, 13 Aug 2022 18:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660407905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KmHM9wqbS6vimAJfJcJUsg6/yM8eOo3986ZAmfKgsaA=;
        b=O3gZUXR8nxRswgEGwn+WmuLv8qgxSmBtTiRnDBAIzkdg0Szx5znSbDffjZIh8u+8VvyjPg
        dhAaZDk6qVN4zTcDhBHK5dD+DO2Zx4hqyQIa9JXOp6m2a+VRE75wMDV7PaBouTUsCx7H0+
        vaZiMHCObmSHaqzXtGk26y0+AZ2Qh6s=
Date:   Sat, 13 Aug 2022 18:25:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <YvfQUGLGY7cfZ9gf@zn.tnic>
References: <Yvd8L0qIbLarxrOQ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yvd8L0qIbLarxrOQ@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might wanna hold off on pulling that:

On Sat, Aug 13, 2022 at 12:25:51PM +0200, Ingo Molnar wrote:
> Linus,
> 
> Please pull the latest timers/urgent git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-08-13
> 
>    # HEAD: e362359ace6f87c201531872486ff295df306d13 posix-cpu-timers: Cleanup CPU timers before freeing them during exec

...

> Thadeu Lima de Souza Cascardo (1):
>       posix-cpu-timers: Cleanup CPU timers before freeing them during exec

...

> diff --git a/fs/exec.c b/fs/exec.c
> index 5fd73915c62c..f793221f4eb6 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1304,6 +1304,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	bprm->mm = NULL;
>  
>  #ifdef CONFIG_POSIX_TIMERS
> +	spin_lock_irq(&me->sighand->siglock);
> +	posix_cpu_timers_exit(me);
> +	spin_unlock_irq(&me->sighand->siglock);

sparse is not happy about this:

https://lore.kernel.org/r/202208140040.MMi4z6Ek-lkp@intel.com

That task_struct.sighand is marked __rcu and thus noderef and sparse
complains:

fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock
+@@     got struct spinlock [noderef] __rcu * @@

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

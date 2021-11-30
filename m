Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657E54631C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhK3LHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbhK3LHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:07:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF54C061574;
        Tue, 30 Nov 2021 03:04:23 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:04:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638270260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42E3Yf17eG7PdQAJ0EhkMdoRgBLf0V9bPk5gtIFAKrs=;
        b=W7EGFP1oIceRJ5lrXCWf/0YlMmWTzMCHHhBfUwsEyjxTRiNpJfOxpNGMEnpfx9j0pEb9ZN
        H26KYBlVmkCDOMlBr8tgSiUYnLLe6Xctcy8Ij4SFkY9TD0vVMeBs56RE03hZv7IBWraBVy
        puHP93MVui/hwhHS/A9eTT2lBCyMcCiNH/F2iJ9g4mhsxf28ExGfyHv1BuZIHl8WBx10Ri
        hGTzao8o0+Yp6fegfCnuRWsM3QKruH9Mkst2kwDIuQBEMYsEPBNLyY95B81CYOFYlvDC2u
        aevZRpxoFgfaLDKNOl5zTPZQTPLTTwppcSrM+u4AQsMufp8AQumo6MDRZAgHJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638270260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42E3Yf17eG7PdQAJ0EhkMdoRgBLf0V9bPk5gtIFAKrs=;
        b=M1LhNaEefSaZOeYf0nPo1WyzYvRWCWKyM+Y7xVG66Xw1I+ATLjVr3WpOhmi5nTQS54p5dR
        dH2bIlCEatkf5YCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Luis Chamberlain <mcgrof@kernel.org>, jeyu@kernel.org
Subject: Re: [PATCH 8/9] module: Switch to kvfree_rcu() API
Message-ID: <20211130110419.hxcexzckbbz77xps@linutronix.de>
References: <20211124110308.2053-1-urezki@gmail.com>
 <20211124110308.2053-9-urezki@gmail.com>
 <alpine.LSU.2.21.2111301132220.3922@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2111301132220.3922@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-30 11:39:09 [+0100], Miroslav Benes wrote:
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -4150,8 +4150,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >   ddebug_cleanup:
> >  	ftrace_release_mod(mod);
> >  	dynamic_debug_remove(mod, info->debug);
> > -	synchronize_rcu();
> > -	kfree(mod->args);
> > +	kvfree_rcu(mod->args);
> >   free_arch_cleanup:
> >  	cfi_cleanup(mod);
> >  	module_arch_cleanup(mod);
> 
> hm, if I am not missing something, synchronize_rcu() is not really 
> connected to kfree(mod->args) there. synchronize_rcu() was added a long 
> time ago when kernel/module.c removed stop_machine() from the code and 
> replaced it with RCU to protect (at least?) mod->list. You can find 
> list_del_rcu(&mod->list) a couple of lines below.

so instead synchronize_rcu() + kfree() you could do
call_rcu(&mod->args->rcu, kfree()) but since you have no RCU-head around
in args you wait for the grace period and then invoke kfree.

kvfree_rcu() is somehow like call_rcu() + kfree() but without the needed
RCU-head. 
So you avoid waiting for the grace period but mod->args is freed later,
after as expected.

> And yes, one could ask how this all works. The error/cleanup sequence in 
> load_module() is a giant mess... well, load_module() is a mess too, but 
> the error path is really not nice.

Well, spring is coming :)

> Miroslav

Sebastian

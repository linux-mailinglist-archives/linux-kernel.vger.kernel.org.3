Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94474463134
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhK3Kmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:42:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhK3Kma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:42:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B8EF1FD58;
        Tue, 30 Nov 2021 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638268750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPvdoK5IW9GFQibe7Cc2ZKRz1yF2+PHOZR5DOIQE6ic=;
        b=BRk729SDr0borlAbqLrDteAIywxAwHjPcrJ7IFeUf8pHhjqzdFNzcvkHBzdgnaUlo5+Oi8
        ZNbcsNqti7svbXT9kPSqJ5uP4kXczmAsopBGog8cFFhGlapkrp7yjSI2+q7QLgwjQgP1tD
        +O6iF+vB/mkTw+l1va2TtzdqnV1/MWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638268750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPvdoK5IW9GFQibe7Cc2ZKRz1yF2+PHOZR5DOIQE6ic=;
        b=7fzATQYqBE66TQUF7zpoKVPqFQBRTXwGfZHI/lvjxnYe1PrGtoDN38zd6/Q80xcBT7IyTe
        0IRjvUnEhFfTVMBw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EDE5BA3B84;
        Tue, 30 Nov 2021 10:39:09 +0000 (UTC)
Date:   Tue, 30 Nov 2021 11:39:09 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Luis Chamberlain <mcgrof@kernel.org>, jeyu@kernel.org
Subject: Re: [PATCH 8/9] module: Switch to kvfree_rcu() API
In-Reply-To: <20211124110308.2053-9-urezki@gmail.com>
Message-ID: <alpine.LSU.2.21.2111301132220.3922@pobox.suse.cz>
References: <20211124110308.2053-1-urezki@gmail.com> <20211124110308.2053-9-urezki@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Nov 2021, Uladzislau Rezki (Sony) wrote:

> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> CC: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/module.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 84a9141a5e15..f404f0c9f385 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4150,8 +4150,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>   ddebug_cleanup:
>  	ftrace_release_mod(mod);
>  	dynamic_debug_remove(mod, info->debug);
> -	synchronize_rcu();
> -	kfree(mod->args);
> +	kvfree_rcu(mod->args);
>   free_arch_cleanup:
>  	cfi_cleanup(mod);
>  	module_arch_cleanup(mod);

hm, if I am not missing something, synchronize_rcu() is not really 
connected to kfree(mod->args) there. synchronize_rcu() was added a long 
time ago when kernel/module.c removed stop_machine() from the code and 
replaced it with RCU to protect (at least?) mod->list. You can find 
list_del_rcu(&mod->list) a couple of lines below.

And yes, one could ask how this all works. The error/cleanup sequence in 
load_module() is a giant mess... well, load_module() is a mess too, but 
the error path is really not nice.

Miroslav

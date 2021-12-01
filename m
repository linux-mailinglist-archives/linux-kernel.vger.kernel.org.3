Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF48465738
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352964AbhLAUis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352927AbhLAUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:38:10 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A10AC061757;
        Wed,  1 Dec 2021 12:34:49 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k23so50656788lje.1;
        Wed, 01 Dec 2021 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gom1kEt+wMKUIemlMo1ibjYlsEUseeku+3vggoGPojw=;
        b=DA9vaPNxjbKJCm8xnt3vywM4Hl+NBamfpfzJhA2nXhofPVjAOVG6vWJxr3pohFFdCy
         W+GaHWWOe0mzZSCxpy6vihp8Ktx1tzyXR/CUmSiK5d8V3uT3Xzxnsvu7qlQTTH4ImMs8
         yR0IG848dF+O0EwxEMi1JJZdBYM69LbCaoGKLCTa7vTy+PNIxl+Z5NxX9MqL8zZ3HrQd
         nZQiJpzJ+0X52T4srw3p59Fw7jLwvgDnSOTrtCJQqGERmUC4Z638hrc0bRI9LdnUwO8r
         YSHtvTtFb3pKwm9lHtWw9u8Bh11IxHGx/PU1Rqp+xMfQo89bH7XxdxNqo30Mb6rRXWSF
         Z0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gom1kEt+wMKUIemlMo1ibjYlsEUseeku+3vggoGPojw=;
        b=ULWkitcLI8Nx2D1XNT9K++pcbL3OblIiPd886XiYDMvlViO44CponaPth5H9LlD74Q
         bVzH9tHQbEICscvmfkgBWvTKsoyo6/ajMnLPhEl/v5N/gT0MWkJ7DSl9qR/2GUDWmuWi
         sUd/gNZ3nL0J0dkrbiJZJPLF33viJODKJ6kmodMOh7mF2Xj7duNSe7CH1ywBVdGJkrk8
         oRHEGGB6iblnRrB3p+n79sp0k52hZTGfl9PpIzNGseQPLcIQRyeL1SxI7OTwOhhN5GlS
         CPdtxX504BcfamirVVGRrsyGHkZKAe8GYw0DAWjIxLU9Rx55RV7sYrnO8KioID6CFqir
         cYtg==
X-Gm-Message-State: AOAM531B6rWA4E1pj9gQmTkShXUeufjoyoyylKaqxqaS1h0kNXdpCvmh
        Z6R98MQzRgo3EFavxWqUwCo=
X-Google-Smtp-Source: ABdhPJyUlTVwsrlEfzMyCTGsOKRXN4nIpQ2w/OuEhVzOaQDamEGEiQVSAe4rTvPm4z60FmdRbRJiXg==
X-Received: by 2002:a2e:a7c6:: with SMTP id x6mr7791434ljp.328.1638390887648;
        Wed, 01 Dec 2021 12:34:47 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t16sm93642lfk.64.2021.12.01.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:34:46 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 1 Dec 2021 21:34:44 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
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
Message-ID: <YafcZIKm9UJqs7c4@pc638.lan>
References: <20211124110308.2053-1-urezki@gmail.com>
 <20211124110308.2053-9-urezki@gmail.com>
 <alpine.LSU.2.21.2111301132220.3922@pobox.suse.cz>
 <20211130110419.hxcexzckbbz77xps@linutronix.de>
 <Yac/PxQ7I70+O0e0@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yac/PxQ7I70+O0e0@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:24:15AM +0100, Uladzislau Rezki wrote:
> On Tue, Nov 30, 2021 at 12:04:19PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-11-30 11:39:09 [+0100], Miroslav Benes wrote:
> > > > --- a/kernel/module.c
> > > > +++ b/kernel/module.c
> > > > @@ -4150,8 +4150,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> > > >   ddebug_cleanup:
> > > >  	ftrace_release_mod(mod);
> > > >  	dynamic_debug_remove(mod, info->debug);
> > > > -	synchronize_rcu();
> > > > -	kfree(mod->args);
> > > > +	kvfree_rcu(mod->args);
> > > >   free_arch_cleanup:
> > > >  	cfi_cleanup(mod);
> > > >  	module_arch_cleanup(mod);
> > > 
> > > hm, if I am not missing something, synchronize_rcu() is not really 
> > > connected to kfree(mod->args) there. synchronize_rcu() was added a long 
> > > time ago when kernel/module.c removed stop_machine() from the code and 
> > > replaced it with RCU to protect (at least?) mod->list. You can find 
> > > list_del_rcu(&mod->list) a couple of lines below.
> > 
> > so instead synchronize_rcu() + kfree() you could do
> > call_rcu(&mod->args->rcu, kfree()) but since you have no RCU-head around
> > in args you wait for the grace period and then invoke kfree.
> > 
> > kvfree_rcu() is somehow like call_rcu() + kfree() but without the needed
> > RCU-head. 
> > So you avoid waiting for the grace period but mod->args is freed later,
> > after as expected.
> > 
> > > And yes, one could ask how this all works. The error/cleanup sequence in 
> > > load_module() is a giant mess... well, load_module() is a mess too, but 
> > > the error path is really not nice.
> > 
> > Well, spring is coming :)
> > 
> Indeed that error path sequence is terrible. I will double check if that
> synchronize_rcu() + kfree() is related to any RCU protection and freeing.
> 
> If it is not i will drop this patch.
> 
> 
OK, that kfree has nothing to do with RCU protection:

<snip>
commit 6526c534b2677ca601b7b92851437feb041d02a1
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Thu Aug 5 12:59:10 2010 -0600

    module: move module args strndup_user to just before use
    
    Instead of copying and allocating the args and storing it in
    load_info, we can just allocate them right before we need them.
    
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
<snip>

so, i will drop my patch, since the intention is not to free a ptr
after a grace period.

Thank you for the review!

--
Vlad Rezki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85B1464A80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348172AbhLAJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbhLAJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:27:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F99C061574;
        Wed,  1 Dec 2021 01:24:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u3so61225489lfl.2;
        Wed, 01 Dec 2021 01:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a3x4/0MUGo+LR2GYmiksIU0qioo0gP+kmMQRKGm3kaw=;
        b=iqDWb7mbcMpG0I1FT2cIe7C1WQMBRpWv4Du8tuBnpxYTsSLIWAaF1zCUsUsrvyt9lx
         tsKDZLNbIxGfIjzmam02Y/E9YebkhBg0D6eur4VjjvSHVYXHVCY6JAUuFgWx4C0O4+1i
         Qkqizub1AJhR5Xs4QgjUFt+lLRd9C8VfXdyVff1kRuaplLO4hB6uMZyQPfSdAgnvoURA
         j5PODLfMrglwUZtVP1shVIeQ1fnnaTGdi92NffPyT0uGtTFuv4a6+t+onROpZ6rzJ5Dy
         ah8ZV5esEqDJBskimKon9nMMDz9Ug3sN9k8zLrtl/GCmX2byFai78Yw5RrbDQ3HjDAgM
         tYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3x4/0MUGo+LR2GYmiksIU0qioo0gP+kmMQRKGm3kaw=;
        b=StlPEa1DfT668Vzrbwd+q7uArsTxBa4pEGAb2LpzzS6FakZ0TIGk21YF8iM+Qe9623
         awNd6Pm4GzqtWDnAJF6IjcANN7ZwLSfXxt53g2S57vYKBkazxu6or/j2cvVRijbmW25X
         muDQLrG3wolNlznXMXXJ9jdRvjwjc/0Bmk12jyPxTYoVffCbSyO7SPaCPogbY6G0L6HS
         ZgqcCLd84zk7TEVySQVPXgsjDHk8dKwa9RBhJWqjiMWrsIg8YF8IsQIkFgPnBADdt117
         0sWqXwTJcSQYuNN+XABmXpNxtJtpYHXUmsTK2kLwcWPUeoNk6fj6H4/MmDPU9G47XKTX
         cgRw==
X-Gm-Message-State: AOAM530d+aTg2TYIunUnS6SgMDNhgF+unymcrFdV1Ac2DE1syXqecYrI
        2O2c2choHnCAfb2MAn2E3Gk=
X-Google-Smtp-Source: ABdhPJwArzeUHSK1dLOJFmcxGC7E2hX2p4Y0MdrZ2DWrwAOdzzI4c7eJ22lxNCTwreJtr7GGpuwhlA==
X-Received: by 2002:a19:7709:: with SMTP id s9mr4908441lfc.682.1638350657986;
        Wed, 01 Dec 2021 01:24:17 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t5sm2283218lfd.80.2021.12.01.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 01:24:17 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 1 Dec 2021 10:24:15 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
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
Message-ID: <Yac/PxQ7I70+O0e0@pc638.lan>
References: <20211124110308.2053-1-urezki@gmail.com>
 <20211124110308.2053-9-urezki@gmail.com>
 <alpine.LSU.2.21.2111301132220.3922@pobox.suse.cz>
 <20211130110419.hxcexzckbbz77xps@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130110419.hxcexzckbbz77xps@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:04:19PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-11-30 11:39:09 [+0100], Miroslav Benes wrote:
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -4150,8 +4150,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> > >   ddebug_cleanup:
> > >  	ftrace_release_mod(mod);
> > >  	dynamic_debug_remove(mod, info->debug);
> > > -	synchronize_rcu();
> > > -	kfree(mod->args);
> > > +	kvfree_rcu(mod->args);
> > >   free_arch_cleanup:
> > >  	cfi_cleanup(mod);
> > >  	module_arch_cleanup(mod);
> > 
> > hm, if I am not missing something, synchronize_rcu() is not really 
> > connected to kfree(mod->args) there. synchronize_rcu() was added a long 
> > time ago when kernel/module.c removed stop_machine() from the code and 
> > replaced it with RCU to protect (at least?) mod->list. You can find 
> > list_del_rcu(&mod->list) a couple of lines below.
> 
> so instead synchronize_rcu() + kfree() you could do
> call_rcu(&mod->args->rcu, kfree()) but since you have no RCU-head around
> in args you wait for the grace period and then invoke kfree.
> 
> kvfree_rcu() is somehow like call_rcu() + kfree() but without the needed
> RCU-head. 
> So you avoid waiting for the grace period but mod->args is freed later,
> after as expected.
> 
> > And yes, one could ask how this all works. The error/cleanup sequence in 
> > load_module() is a giant mess... well, load_module() is a mess too, but 
> > the error path is really not nice.
> 
> Well, spring is coming :)
> 
Indeed that error path sequence is terrible. I will double check if that
synchronize_rcu() + kfree() is related to any RCU protection and freeing.

If it is not i will drop this patch.


Thanks!

--
Vlad Rezki

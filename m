Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB91473506
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhLMTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhLMTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:32:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B8CC061574;
        Mon, 13 Dec 2021 11:32:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 057D2611DF;
        Mon, 13 Dec 2021 19:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AFEC34602;
        Mon, 13 Dec 2021 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639423976;
        bh=ktC2aAE/44G4NlMBVEorHQfPeQA+XESm85W25YiTYrA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uLpU4CnEW6dKPGDv4UpKHR+KUuowBOhpRXHZpUS0ALsA2EaPQwsfUyC8+h33Clkab
         1mcM662BjVdPre/iZSS/O6vikQCwU4TdqbQCASqhYgjX3n482fPVwtsUcwlwZfctaq
         9sL0VpXCeZVJULDTsu+LpvuLMN1+aoptyrZML2KhPzRssVFQG66vGWyv6cYV14kJIt
         tdRNzfDBvT3sXV3j0fRXd9Z1QBmgaf8QJHiQpf9ut8vZCxgomRG16Mp8XaOi+EKaRY
         xK7Kilyu8P5y3Zv/66wJv/MF+fENmXi/20lPwgTnCLGwThmrq1FZMFrV5b5MUezYk4
         Fj5QQvwwaP8yQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2151F5C0B9E; Mon, 13 Dec 2021 11:32:56 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:32:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: Re: [PATCH] rcu: Make rcu_state.n_online_cpus updates atomic
Message-ID: <20211213193256.GR641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211213070059.6381-1-quic_neeraju@quicinc.com>
 <471d6615f245168d4c6c96c7ac1ccabf56b75945.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <471d6615f245168d4c6c96c7ac1ccabf56b75945.camel@amazon.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:09:22AM +0000, Woodhouse, David wrote:
> On Mon, 2021-12-13 at 12:30 +0530, Neeraj Upadhyay wrote:
> > To support onlining multiple CPUs concurrently,
> > change rcu_state.n_online_cpus updates to be atomic.
> > Note, it's ok for rcu_blocking_is_gp() to do a
> > atomic_read(&rcu_state.n_online_cpus), as the
> > value of .n_online_cpus switches from 1->2, in
> > rcutree_prepare_cpu(), which runs before the new
> > CPU comes online. Similarly 2->1 transition happens
> > from rcutree_dead_cpu(), which executes after the
> > CPU is offlined, and runs on the last online CPU.
> > 
> > Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> In my parallel-bringup series, the prepare stages are still being
> executed in series on the BSP, so I don't think this patch is needed
> yet. I'm not sure we'd ever end up with the prepare stages being done
> in parallel — the most I see us doing is onlining a single *batch* of
> CPUs at a time, much like bringup_nonboot_cpus() does.
> 
> But this patch certainly doesn't *hurt*.
> 
> Acked-by: David Woodhouse <dwmw@amazon.co.uk>

Queued for further review and testing.

To Frederic's point, this won't go to mainline unless it is actually
needed, but it will at least be pulled into a branch in -rcu marked with
a tag for future reference.

							Thanx, Paul

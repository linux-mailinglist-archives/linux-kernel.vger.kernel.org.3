Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE75147348A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhLMTAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhLMTAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:00:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8DC061574;
        Mon, 13 Dec 2021 11:00:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF811B81255;
        Mon, 13 Dec 2021 19:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90AAC34600;
        Mon, 13 Dec 2021 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639422005;
        bh=7r2b3zIykqzLviEJZiXs7snpV80iotoqxiNSSC/IIdQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bhWWvKxJqH1GrV3KQJ4HIG943VnstdXGJUBUbcpftai8/XZtnux5qInMFxr9IKiPv
         OP1Y2pbz0wSdlKpfH4I/Hr5aoiHUWO5Rix8Ri0TeEJSJKMCtmqnqFO5/z2PmA1R+u+
         0APpNLLUuKxHfjCiUWPIyuaWMbQDZm+fyveadObECvWL6u4gC2sgjACdy7Q9wmfkC7
         Inyb9witJxd4CLY79U4GeGPJls+Iqj1LJmUczy9+lBkHr6Hqj06sC0He1JYARESX26
         BpSBo3mNQVQqOax1kcg6Q2/lKEMtk3AAqaXzz5G9ArditI9ef8Fu5EjasL9Cfz/35D
         2WSZ95tgmJouQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 680BC5C0B9E; Mon, 13 Dec 2021 11:00:05 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:00:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        boqun.feng@gmail.com
Subject: Re: [PATCH v2] rcu/nocb: Handle concurrent nocb kthreads creation
Message-ID: <20211213190005.GP641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211211170139.27711-1-quic_neeraju@quicinc.com>
 <6c184b9ffc5c641736d53bb7598f814d6b4c3fe0.camel@infradead.org>
 <601ecb12-ae2e-9608-7127-c2cddc8038a6@quicinc.com>
 <20211213112246.GA782195@lothringen>
 <984a63d4c11d04e2ee8a83fc9c61006413bf209e.camel@infradead.org>
 <20211213131407.GD782195@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213131407.GD782195@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:14:07PM +0100, Frederic Weisbecker wrote:
> On Mon, Dec 13, 2021 at 11:28:45AM +0000, David Woodhouse wrote:
> > On Mon, 2021-12-13 at 12:22 +0100, Frederic Weisbecker wrote:
> > > I was about to ack the patch but, should we really add code that isn't going to
> > > be necessary before a long while?
> > 
> > Yeah, I'm torn on that. In this case it's harmless enough and it makes
> > the code reentrant in its own right instead of relying on the fact that
> > the cpuhp code won't invoke it multiple times in parallel. So I think
> > that's reasonable defensive programming.
> 
> The thing is that RCU code is already quite complicated. Are we even at least
> sure that we'll ever make CPU hotplug allow concurrent CPU onlining/offlining?
> 
> This will require much more thoughts and a new hotplug concurrency
> infrastructure that we'll need to base RCU on. IMHO it's a bit early to handle
> that on hotplug individual callbacks.
> 
> But anyway, let's see what Paul thinks about it...

We need to at least think through parallelizing the various RCU
CPU-hotplug notifiers.  For one thing, it might turn out to be necessary
to parallelize those notifiers, perhaps on some non-x86 architecture or
on some non-Amazon .config.  For another thing, doing so might suggest
some simplifications, as has happened in my ongoing rcu_barrier() work.

My thought is to pull in the patches and at the very least leave a
tag recording them for later possible use.

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499105A9578
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiIALL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiIALLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:11:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2F13063B;
        Thu,  1 Sep 2022 04:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CE60B825C9;
        Thu,  1 Sep 2022 11:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A2DC43470;
        Thu,  1 Sep 2022 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662030677;
        bh=isbEsGMAd6l+5tzFGahWL4tHVrV73zrpC+Q4RxEL45k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6p9ZCffk9sWe4cMEyhVqCv0/XRv8BDKZOOf0jx3304smil9IEzCP9LP8kv8Awokp
         PyHFLLq54Km5/ip0GobbIeKTQyFUBLOgdbBPqQ0ztEnZolbTEw+p970c24QH60u8va
         sJPfMz3WZkuTQHHJ8xD73AD2zAJ+egUgbwREJpycKwnLXxsSt8IeGhTKsdb3mrtFS4
         QhzSi1KV/1dbBrVq/lM+9n3op+dgwTRUB5BYkLsn8HRoP0djNZ+tiTXG9HSn+QNhfU
         9xydU+mQ3RnGhnizDv/0Vg7FNFzAiqgZ6C7f+uH9q31qLLHc6b1ciG0HSq3W0NX59V
         pSb6vFv/hrRuw==
Date:   Thu, 1 Sep 2022 13:11:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH rcu 3/3] rcu: Simplify rcu_init_nohz() cpumask handling
Message-ID: <20220901111114.GA103483@lothringen>
References: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
 <20220831181044.2694488-3-paulmck@kernel.org>
 <20220901091557.GA101341@lothringen>
 <20220901102520.GQ6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901102520.GQ6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:25:20AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 01, 2022 at 11:15:57AM +0200, Frederic Weisbecker wrote:
> > > +#elif defined(CONFIG_NO_HZ_FULL)
> > > +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> > > +		cpumask = tick_nohz_full_mask;
> > > +#endif
> > 
> > A subtle behaviour difference here too: CONFIG_RCU_NOCB_CPU_DEFAULT_ALL will
> > now override nohz_full=
> > 
> > I don't mind, it's probably what we want in the end, but the changelog should
> > tell about it, or even better, this should be a separate change.
> 
> Good point.  Perhaps the key point is that if there is nohz_full=,
> rcu_nocbs=, and CONFIG_RCU_NOCB_CPU_DEFAULT_ALL, we still need rcu_nocbs=
> to include at least those bits set by nohz_full=.

Not sure I get what you mean. nohz_full= should in any case always force
rcu_nocbs at least on the nohz_full CPUs.

For example assuming the following combination: rcu_nocbs=6, nohz_full=7 AND
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y, then the result should be:

NOCB CPUs = 6,7
NOHZ_FULL CPUs = 7

(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y is overriden by rcu_nocbs=6).

Now if we have nohz_full=7 AND CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y, then the
result is expected to be either:

NOCB CPUs = 7 (upstream behaviour)
NOHZ_FULL CPUs = 7

or 

NOCB CPUs = all
NOHZ_FULL CPUs = 7

The second makes more sense IMHO but that should be in a separate change.

Thanks.

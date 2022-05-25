Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79325346C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiEYWm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiEYWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC39A3098;
        Wed, 25 May 2022 15:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5876104E;
        Wed, 25 May 2022 22:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B81C385B8;
        Wed, 25 May 2022 22:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653518574;
        bh=Y1+kYhrO5yiZyWR2P6v0Eoi5ETZCFyNeNeSvZUzw6OY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kz1P+f0ND6n7Lx9X5G/TlWlUke8Rv7aKdqnTEmQeq87RpZobKqTKv3/XMQii6ac5U
         2SqyqDAU6sPk+FDzkxfnFZtUyCA5FqqGsCRKGNlMvaplL1Mk/zJrz2mUP++NXWSyut
         toAeWMBLc/tI5eC7QVBkKKx5dkTqwpRMVX56xcmFMdrkdjdaIcoK3zu86A9Ym51oYE
         ZbadWSqLHSobrGOKFgAiemVxHtBG5AWfAkltt3O6Zz0kKMT+Hg0QNKfOHtTrh771Xy
         Z4eXaMnV7myCd1ZK+3MkjBM7t7W6vphcUOnpe2Wyfgq+hYQdC7vqYG8TIHT40p+eJB
         Z4reuuLq3D8DQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 634265C0378; Wed, 25 May 2022 15:42:54 -0700 (PDT)
Date:   Wed, 25 May 2022 15:42:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 1/4] rcu/nocb: Pass a cpumask instead of a single CPU to
 offload/deoffload
Message-ID: <20220525224254.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-2-frederic@kernel.org>
 <20220525221917.GA1151462@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525221917.GA1151462@lothringen>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:19:17AM +0200, Frederic Weisbecker wrote:
> On Thu, May 26, 2022 at 12:10:52AM +0200, Frederic Weisbecker wrote:
> > @@ -1117,12 +1111,6 @@ static long rcu_nocb_rdp_offload(void *arg)
> >  	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
> >  
> >  	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> > -	/*
> > -	 * For now we only support re-offload, ie: the rdp must have been
> > -	 * offloaded on boot first.
> > -	 */
> > -	if (!rdp->nocb_gp_rdp)
> > -		return -EINVAL;
> >  
> >  	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
> >  		return -EINVAL;
> 
> And why did I remove this critical check? I have no answer...

Me, I was going to ask if rcutorture should (de)offload multiple
CPUs in one go...  ;-)

							Thanx, Paul

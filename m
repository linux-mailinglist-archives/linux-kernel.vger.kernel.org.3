Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20950AE60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 05:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443698AbiDVDM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443682AbiDVDMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:12:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064374D62F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 20:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51E37CE26E6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E221C385A5;
        Fri, 22 Apr 2022 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650596987;
        bh=MUjn2eDyj/XfXhTCseYbBBOb69CJ6G25z9lQyp5keeQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c2amM5S0hr0LEeseyj/W2hNLhw5omUH6BRlFKGI1h0AXMwRqo/I5EOw300ReIqJXH
         yO041iG7WLAQTnXfvJbju1twC9HJCmciI29+FOotq+H/p/d9xvT2USG/t5Ua5Wa4uH
         XL/ZrCmKBt9YShfNzYLQFgieMNY2p3xqcwiJQTA7o8Awp7KG7P21zCHlDrZrLmdc+w
         6hZj5bCdxVH/+kT4DJ38L1QzcEyV0Trw9YuSnU+z0rDxUB4D+bHvjuezYlo/5VS/5t
         D+5toAifNYrjSWIiQMNC/DmGJlSkGsUtIvOYidmg2l1c8kpvaygK6ijyLm1WGAiccj
         8nYNt5j0gYkfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B4C25C0513; Thu, 21 Apr 2022 20:09:47 -0700 (PDT)
Date:   Thu, 21 Apr 2022 20:09:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Question] srcu: is it making sense to recursively invoke
 srcu_read_lock?
Message-ID: <20220422030947.GT4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220421042211.2433-1-hdanton@sina.com>
 <20220422005212.2569-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422005212.2569-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:52:12AM +0800, Hillf Danton wrote:
> On Thu, 21 Apr 2022 06:34:14 -0700 Paul E. McKenney wrote:
> > On Thu, Apr 21, 2022 at 12:22:11PM +0800, Hillf Danton wrote:
> > > Given rcu_lock_acquire() in srcu_read_lock(),
> > > 
> > > 	iA = srcu_read_lock(foo);
> > > 	iB = srcu_read_lock(foo); // not bar
> > > 	...
> > > 	srcu_read_unlock(foo, iB);
> > > 	srcu_read_unlock(foo, iA);
> > > 
> > > can the call sequence above trigger warning with CONFIG_DEBUG_LOCK_ALLOC enabled?
> > 
> > I hope not!  After all, nesting SRCU read-side critical sections is
> > perfectly legal.  But why not just try it and see?
> 
> Thanks for shedding light on nested SRCUs - it cures my pain working out
> the reason for how detecting nested SRCUs is added [1]. Now I see why it
> is out of kernel/rcu.

Just to be clear...  If the KVM guys want to impose a design rule that
SRCU read-side critical sections never be nested within their code,
that is a perfectly reasonable thing for them to do.

							Thanx, Paul

> Hillf
> 
> [1] https://lore.kernel.org/lkml/20220415004343.2203171-4-seanjc@google.com/
> 
> > > Does it make sense to add srcu_lock_acquire() in line with rwsem_acquire_read() if
> > > warning is expected but not triggered?
> > 
> > Please understand that while SRCU can often be used where an rwsem
> > might otherwise be used, SRCU is not an rwsem.  For one thing, rwsem
> > readers can deadlock in ways that SRCU reader cannot.
> > 
> > Now, I don't yet know of a non-destructive use case for partially
> > overlapping SRCU read-side critical sections, for example, if you
> > switched the two srcu_read_unlock() calls above.  But at the same
> > time, I cannot prove that there is no valid use case, not yet,
> > anyway.
> > 
> > 						Thanx, Paul
> > 
> > > Thanks
> > > Hillf
> > > 
> > > static inline void rcu_lock_acquire(struct lockdep_map *map)
> > > {
> > > 	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
> > > }
> > > 
> > > static inline void srcu_lock_acquire(struct lockdep_map *map)
> > > {
> > > 	lock_acquire(map, 0, 0, 1, 0, NULL, _THIS_IP_);
> > > }
> > 

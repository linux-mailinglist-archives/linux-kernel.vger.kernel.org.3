Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA65950ABD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441942AbiDUXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376864AbiDUXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:11:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FB4838B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39374CE2669
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF2AC385A7;
        Thu, 21 Apr 2022 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650582528;
        bh=dJ+oCe8hcxTkCxYaCSaUOmqH7FbT8LrdOg6l5AEm8LU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SEMPuSQjGaFClBbFYkbdPChiENBX4oR1NNJWBHR6s2MNkSNGhOaadOtmcWwGkSghj
         I/i/KzCxnWL1VSE1huavhS6Zc9qkd1Dm4cY5NmxL8FDhsv4+VFc6WtkS630z57ym2r
         1Vb/2jX0gkEpCABukXSj5h0H47GERK8xg7DpMdn7coxKbe+KQWuaE6BFSdxQLU7V5w
         GbjjQUf6+Z9AcgXr+c8Y7HFlQGpWw1hWmtzEml/N79izN9+o3MU/uv6LJUQ392pnyJ
         CUpLclT5zRR0gwarV0kHlblDC7Tn2zM3/xLm5uo5NnmVvDxWhOGgA+b9sU4FAFiVEp
         y0iJxDFgNEM1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 21FA15C0510; Thu, 21 Apr 2022 16:08:48 -0700 (PDT)
Date:   Thu, 21 Apr 2022 16:08:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Question] srcu: is it making sense to recursively invoke
 srcu_read_lock?
Message-ID: <20220421230848.GA194034@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220421042211.2433-1-hdanton@sina.com>
 <20220421133414.GP4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421133414.GP4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:34:14AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 21, 2022 at 12:22:11PM +0800, Hillf Danton wrote:
> > Given rcu_lock_acquire() in srcu_read_lock(),
> > 
> > 	iA = srcu_read_lock(foo);
> > 	iB = srcu_read_lock(foo); // not bar
> > 	...
> > 	srcu_read_unlock(foo, iB);
> > 	srcu_read_unlock(foo, iA);
> > 
> > can the call sequence above trigger warning with CONFIG_DEBUG_LOCK_ALLOC enabled?
> 
> I hope not!  After all, nesting SRCU read-side critical sections is
> perfectly legal.  But why not just try it and see?
> 
> > Does it make sense to add srcu_lock_acquire() in line with rwsem_acquire_read() if
> > warning is expected but not triggered?
> 
> Please understand that while SRCU can often be used where an rwsem
> might otherwise be used, SRCU is not an rwsem.  For one thing, rwsem
> readers can deadlock in ways that SRCU reader cannot.
> 
> Now, I don't yet know of a non-destructive use case for partially
> overlapping SRCU read-side critical sections, for example, if you
> switched the two srcu_read_unlock() calls above.  But at the same
> time, I cannot prove that there is no valid use case, not yet,
> anyway.

But I do see one now.

Imagine someone passing a callback to another function, with an SRCU
read-side critical section starting before this other function is invoked
and ending within the callback.  Suppose that this other function also
uses SRCU to protect the invocation of the callback.  The two partially
overlapping SRCU read-side critical sections are independent, so they
are OK.

When the critical sections are not independent, trouble ensues:
https://paulmck.livejournal.com/40593.html

						Thanx, Paul
> 
> > Thanks
> > Hillf
> > 
> > static inline void rcu_lock_acquire(struct lockdep_map *map)
> > {
> > 	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
> > }
> > 
> > static inline void srcu_lock_acquire(struct lockdep_map *map)
> > {
> > 	lock_acquire(map, 0, 0, 1, 0, NULL, _THIS_IP_);
> > }

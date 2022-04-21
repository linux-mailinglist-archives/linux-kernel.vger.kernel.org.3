Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9F50A0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386427AbiDUNhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiDUNhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB782ED69
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93DE161D14
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2628C385A8;
        Thu, 21 Apr 2022 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650548055;
        bh=XhJaTQ5MBxvR+RRnElyRh1/59M5G2XlaZ5GXZhUhBIo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=osEcRBbwr3csqc2gnWy9/uk5f07YOSnU4isnwGtRW5vpw09OOJrIGvyOmJVa2PMnT
         FYkiNRaEY6xuCg7dpK95rCCZdb3VEUQapjnSy6hnqAmjDiy/5q8MN2uWx5+UsSdAe2
         W9PnoQp0w8Ve+U5ru0flt8yclsE+C6ywgclDfDjPQp19qkqrvaBxpoLKoKroI2Drjq
         LbOJxUM/fUN2ma9o+xZdHggWoK750+3ZEK+FubWC+WMF3XX4GQ3bjiEfrcRX1s5uWT
         4o7s57zAlHdtKMvwLbgxdzn4eDKzlncIXlUufu081nc9ezf/mwjaYiAjepFxAUsYFM
         J6bLQtnVDzUfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F6315C0143; Thu, 21 Apr 2022 06:34:14 -0700 (PDT)
Date:   Thu, 21 Apr 2022 06:34:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Question] srcu: is it making sense to recursively invoke
 srcu_read_lock?
Message-ID: <20220421133414.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220421042211.2433-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421042211.2433-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:22:11PM +0800, Hillf Danton wrote:
> Given rcu_lock_acquire() in srcu_read_lock(),
> 
> 	iA = srcu_read_lock(foo);
> 	iB = srcu_read_lock(foo); // not bar
> 	...
> 	srcu_read_unlock(foo, iB);
> 	srcu_read_unlock(foo, iA);
> 
> can the call sequence above trigger warning with CONFIG_DEBUG_LOCK_ALLOC enabled?

I hope not!  After all, nesting SRCU read-side critical sections is
perfectly legal.  But why not just try it and see?

> Does it make sense to add srcu_lock_acquire() in line with rwsem_acquire_read() if
> warning is expected but not triggered?

Please understand that while SRCU can often be used where an rwsem
might otherwise be used, SRCU is not an rwsem.  For one thing, rwsem
readers can deadlock in ways that SRCU reader cannot.

Now, I don't yet know of a non-destructive use case for partially
overlapping SRCU read-side critical sections, for example, if you
switched the two srcu_read_unlock() calls above.  But at the same
time, I cannot prove that there is no valid use case, not yet,
anyway.

						Thanx, Paul

> Thanks
> Hillf
> 
> static inline void rcu_lock_acquire(struct lockdep_map *map)
> {
> 	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
> }
> 
> static inline void srcu_lock_acquire(struct lockdep_map *map)
> {
> 	lock_acquire(map, 0, 0, 1, 0, NULL, _THIS_IP_);
> }

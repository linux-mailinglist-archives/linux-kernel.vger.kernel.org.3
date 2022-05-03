Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA2518A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiECQms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiECQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A86727CEF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C956174C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FB4C385AF;
        Tue,  3 May 2022 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651595951;
        bh=KL8s36Mxf7cX9xP0GXX7OyVZdqJjzw/ipLa9/teybm8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ld62q2Benx4MXZOvgoVjaD1Hyur/pUhd5YJPyjLhI0ia9tuluGrhPHfgm/yuq2Nhd
         DVhVKdhhJXl/EnqN8kycC0qaqy9wvWp8gcE7tctfAhbGFR/bc22I7Y7keg0hDUHQVN
         w7G+faneXSlVrrZOgfPvGfXu0SHUFUS/lmDUmutdut9QYAJ0NmXlcuXgSYwZySWifV
         /ZCQI8vGipp3ve/0pQSqzCn0tsPkYd7dBIYPgQ20rzk1Zf4han7TTfQV5SyZ+7kyin
         tZ74cybFyGA+7a34Q8j8DRnZ6hU4YTgVxsiBVkn0bAp5bmCyKos7N0D8I5S7EuqiBC
         BR/EYfZDUR+5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A45105C0115; Tue,  3 May 2022 09:39:05 -0700 (PDT)
Date:   Tue, 3 May 2022 09:39:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     liam.howlett@oracle.com, willy@infradead.org, walken.cr@gmail.com,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 06:04:13PM +0200, Michal Hocko wrote:
> On Tue 03-05-22 08:59:13, Paul E. McKenney wrote:
> > Hello!
> > 
> > Just following up from off-list discussions yesterday.
> > 
> > The requirements to allocate on an RCU-protected speculative fastpath
> > seem to be as follows:
> > 
> > 1.	Never sleep.
> > 2.	Never reclaim.
> > 3.	Leave emergency pools alone.
> > 
> > Any others?
> > 
> > If those rules suffice, and if my understanding of the GFP flags is
> > correct (ha!!!), then the following GFP flags should cover this:
> > 
> > 	__GFP_NOMEMALLOC | __GFP_NOWARN
> 
> GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN

Ah, good point on GFP_NOWAIT, thank you!

> > Or is this just a fancy way of always returning NULL or some such?  ;-)
> 
> It could fail quite easily. We would also want to guarantee (by
> documenting I guess) that the page allocator never does anything that
> would depend or invoke rcu_synchronize or something like that.

The GPF_NOWAIT should rule out synchronize_rcu() and similar, correct?

> I believe this is the case currently.

Here is hoping!  ;-)

							Thanx, Paul

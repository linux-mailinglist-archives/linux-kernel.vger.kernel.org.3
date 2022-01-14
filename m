Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3265A48EDB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbiANQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbiANQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:11:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34EDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B86161F6A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DD1C36AE5;
        Fri, 14 Jan 2022 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642176698;
        bh=6X9KLOSKKaye1jO+GF6tFE3ksul+CGCuXjokSL1ou+g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JZf0PfXkA3yzq5W767oiXY7hi0mQbDJIFygFh0XJewPYpGqXVpDPAq+F+/Bxk7vcG
         rt3Q4t/Q/YtrrTd689sqOoYnyVW2F4Puk9CHpCwrKM+51junwVJk+9ZDCksEaJgrp3
         sJ+DvpquduGA0sVG7svphatT4qSTSg1z3EzORh6JqmsXQ5RAgPO9ofZi8YsNL86yR5
         PL7tLHvExJ2bgh9SDXuR8Eb3ybH2jeSIuskHi00oVUvf6buYtdTuwHEfdpuW9RmuKa
         VnooqVeq+bk19qdZjoVP4HCxYRuSkfQ6pzH8Dq45ET4ONPUOoRZPQFbhTBFAVR/pH+
         j/EYWnk77DtQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A08315C023F; Fri, 14 Jan 2022 08:11:38 -0800 (PST)
Date:   Fri, 14 Jan 2022 08:11:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        quic_neeraju@quicinc.com, frederic@kernel.org, urezki@gmail.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] KASAN: use-after-free Read in srcu_invoke_callbacks
Message-ID: <20220114161138.GW947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <00000000000081b56205d54c6667@google.com>
 <20220111134324.1727-1-hdanton@sina.com>
 <20220111190500.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <YeGK8gUziDoa/IYL@boqun-archlinux>
 <20220114152752.GU947480@paulmck-ThinkPad-P17-Gen-1>
 <YeGdoAFYGhg3viPZ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeGdoAFYGhg3viPZ@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 11:58:24PM +0800, Ming Lei wrote:
> On Fri, Jan 14, 2022 at 07:27:52AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 14, 2022 at 10:38:42PM +0800, Boqun Feng wrote:
> > > Hi,
> > > 
> > > On Tue, Jan 11, 2022 at 11:05:00AM -0800, Paul E. McKenney wrote:
> > > [...]
> > > > > > The buggy address belongs to the object at ffff8880189b5c70
> > > > > >  which belongs to the cache request_queue_srcu of size 3816
> > > 
> > > This cache name drew my attention when I was trying to look into this,
> > > because I couldn't find it in v5.16, later on I realized the UAF was
> > > found in linux-next and the commit introducing the cache was merged into
> > > mainline if 5.17 merge window:
> > > 
> > > 	704b914f15fb blk-mq: move srcu from blk_mq_hw_ctx to request_queue
> > > 
> > > I think the UAF is actually a bug introduced by the commit, because in
> > > that commit srcu structure was moved from blk_mq_hw_ctx to
> > > request_queue, and therefore the cleanup_srcu_struct() should be moved
> > > from blk_mq_hw_sysfs_release() to blk_release_queue(), however the above
> > > commit only deleted the one in blk_mq_hw_sysfs_release() but didn't add
> > > a new one in blk_release_queue(). As a result when a request queue is
> > > freed, the srcu structure is not fully clean up, therefore the UAF.
> > > 
> > > IOW, something like below (untested) should fix this. Copy the auther
> > > and block maintainers.
> > 
> > One question for the author and block maintainers...  Why not simply have
> > a single srcu_struct for all of the queues?  Or is there some situation
> > where you need one queue's reader to avoid blocking other queues' SRCU
> > grace periods?
> 
> Because srcu_struct is too fat, and only few drivers need it, and
> most block drivers needn't it.

Fair points.

But would it make sense to dynamically allocate a single srcu_struct
when the first need arose, and only remove it when the last need passed?

							Thanx, Paul

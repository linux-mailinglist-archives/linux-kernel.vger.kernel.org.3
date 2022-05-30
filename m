Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DDF537319
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 02:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiE3AlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiE3Ak4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 20:40:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B7167EB;
        Sun, 29 May 2022 17:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4442AB80AE8;
        Mon, 30 May 2022 00:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413E0C385A9;
        Mon, 30 May 2022 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653871252;
        bh=G8k7NnTHdpSZ7VZhi7sLQF0K5yF4s3LK9I+3YZZnCe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzOxdAJIPxYhQdo1qYjaDuITxrBh1CPCLZC4elneIBQ6xFseM1fFb1VdC/XA1zCTL
         VDdQ0A0lnMqZ3/IQ3CUDUn6k5I699taJoaFHu2ycfgVngjx2I2bDeS2gQnCrGzNekd
         EIBQsMyD/rNx33314yE/dS0i3OOC6TB+qCjo70vvJFTB875kfiBXu2SlyAjqJdeCqH
         EUrAvs6yWcfZaNJye+piKDxqcKc1lNjlJHaNdyIH9iMCw0esv7Qj7TkolY83otePEd
         F5wnYi9JQOUXnvTt0n3a0/f4u7PSplk17YC2u/jVtgIDEMDoKUWzXga5wM8rKtFjRY
         A/HXa5J1/T0Sw==
Date:   Mon, 30 May 2022 02:40:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <20220530004049.GA1251147@lothringen>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 04:24:50PM +0200, Peter Zijlstra wrote:
> On Fri, May 27, 2022 at 10:30:18AM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 26/05/22 14:37, Tejun Heo wrote:
> > > On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> > > > I am thinking along the line that it will not be hierarchical. However,
> > > > cpuset can be useful if we want to have multiple isolated partitions
> > > > underneath the top cpuset with different isolation attributes, but no more
> > > > sub-isolated partition with sub-attributes underneath them. IOW, we can only
> > > > set them at the first level under top_cpuset. Will that be useful?
> > > 
> > > At that point, I'd just prefer to have it under /proc or /sys.
> > 
> > FWIW, I was under the impression that this would nicely fit along the
> > side of other feaures towards implenting dynamic isolation of CPUs (say
> > https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
> > for example). Wouldn't be awkward to have to poke different places to
> > achieve isolation at runtime?
> 
> This, that's what I was thinking.
> 
> My main objection to the whole thing is that it's an RCU_NOCB specific
> interface. *That* I think is daft.
> 
> I was thinking a partition would be able to designate a house-keeping
> sub-partition/mask, but who cares about all the various different
> housekeeping parties.

It's time for the isolation users to step up here! I very rarely hear from them
and I just can't figure out by myself all the variants of uses for each of the
isolation features. May be some people are only interested in nocb for some
specific uses, or may be it never makes sense without nohz full and all the rest
of the isolation features. So for now I take the very cautious path to split the
interface.

Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDDA537640
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiE3IMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiE3IL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:11:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0C2DD2;
        Mon, 30 May 2022 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sasIzphq1eZBnQQmU0BcAocyi+BZTjrLXEHfOoMPumM=; b=b+Ks2J8SjZtMjYzBxr684T+0R7
        m9CzQy5jUaP+gkNnLOMe+olKt80v6Icbc6jEHWj6J6PkQm1uN9BwINfM8KzzIv6ep2l5cnRZmm3WV
        JE2d39AZuxqw5sLFWp21EVGz5ajLikXazvDXGkVmRmD7Rt91kW9djSFhE3MPSICZpDAmjh3BOZejI
        QVUjtt8WMukq4B2ykF/0zGz+cnHrvhwiNUCosKlOGfFIze1Es6amOOl+NLFb+P9FlrmPTsEYmzxsX
        aPwm+gq5LvsX//pfF9DICjI23d6KFXTd7PX3CeBZvuKAG63RZ8glYtaL3R27X1os76qQBJdeVzd6F
        Smfc9x/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvaV3-004Ivm-Pe; Mon, 30 May 2022 08:11:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A867980DE7; Mon, 30 May 2022 10:11:41 +0200 (CEST)
Date:   Mon, 30 May 2022 10:11:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <YpR8PUlIraYE2+5L@worktop.programming.kicks-ass.net>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530004049.GA1251147@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 02:40:49AM +0200, Frederic Weisbecker wrote:
> On Sat, May 28, 2022 at 04:24:50PM +0200, Peter Zijlstra wrote:
> > On Fri, May 27, 2022 at 10:30:18AM +0200, Juri Lelli wrote:
> > > Hi,
> > > 
> > > On 26/05/22 14:37, Tejun Heo wrote:
> > > > On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> > > > > I am thinking along the line that it will not be hierarchical. However,
> > > > > cpuset can be useful if we want to have multiple isolated partitions
> > > > > underneath the top cpuset with different isolation attributes, but no more
> > > > > sub-isolated partition with sub-attributes underneath them. IOW, we can only
> > > > > set them at the first level under top_cpuset. Will that be useful?
> > > > 
> > > > At that point, I'd just prefer to have it under /proc or /sys.
> > > 
> > > FWIW, I was under the impression that this would nicely fit along the
> > > side of other feaures towards implenting dynamic isolation of CPUs (say
> > > https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
> > > for example). Wouldn't be awkward to have to poke different places to
> > > achieve isolation at runtime?
> > 
> > This, that's what I was thinking.
> > 
> > My main objection to the whole thing is that it's an RCU_NOCB specific
> > interface. *That* I think is daft.
> > 
> > I was thinking a partition would be able to designate a house-keeping
> > sub-partition/mask, but who cares about all the various different
> > housekeeping parties.
> 
> It's time for the isolation users to step up here! I very rarely hear from them
> and I just can't figure out by myself all the variants of uses for each of the
> isolation features. May be some people are only interested in nocb for some
> specific uses, or may be it never makes sense without nohz full and all the rest
> of the isolation features. So for now I take the very cautious path to split the
> interface.

This is ABI, you can't walk back on it. I would suggest starting with an
'all feature' isolation. Only if there's real demand for something more
fine-grained add that on top. Simple first etc.

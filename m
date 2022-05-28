Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E58536D44
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiE1OZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiE1OZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:25:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E091834B;
        Sat, 28 May 2022 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3n7OczS1PtetK1QFTtWOYHDzv4XhdHqp3jM8IwjXG8U=; b=tTg6UwcV3Su/y3ILUPGeurwJEV
        viPkR2YPdjqbEN100npodPR4sEr6UPd7Oqd+XzBZs+wi0+cPWks3IN222rD02IrC836oczmsLAvVK
        jbpoBXAfTfiRvefseGe6TCmt1PBcl3CJsbTNKaGSh2jOHkDuygAOTIAlbHmanrksO/lgr0xEw/daX
        RafXWo+0rCRYJlegaXDjq0RTRcyGo+z6ATe1RwSuGuFEWHPXXewYsD5f/bkSyErLbQTJTPX/XloSu
        iDubEkqSkkTPzti2NVI3yqst12vbT8lz8W5l+ELn1RURxNI+B+jNTGVyehdvOo1s3HCy9G39fUzMD
        MRxYMlCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuxN7-002uyS-Ak; Sat, 28 May 2022 14:24:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 579DF3002A6;
        Sat, 28 May 2022 16:24:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B598820289D16; Sat, 28 May 2022 16:24:50 +0200 (CEST)
Date:   Sat, 28 May 2022 16:24:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
Message-ID: <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 10:30:18AM +0200, Juri Lelli wrote:
> Hi,
> 
> On 26/05/22 14:37, Tejun Heo wrote:
> > On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> > > I am thinking along the line that it will not be hierarchical. However,
> > > cpuset can be useful if we want to have multiple isolated partitions
> > > underneath the top cpuset with different isolation attributes, but no more
> > > sub-isolated partition with sub-attributes underneath them. IOW, we can only
> > > set them at the first level under top_cpuset. Will that be useful?
> > 
> > At that point, I'd just prefer to have it under /proc or /sys.
> 
> FWIW, I was under the impression that this would nicely fit along the
> side of other feaures towards implenting dynamic isolation of CPUs (say
> https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
> for example). Wouldn't be awkward to have to poke different places to
> achieve isolation at runtime?

This, that's what I was thinking.

My main objection to the whole thing is that it's an RCU_NOCB specific
interface. *That* I think is daft.

I was thinking a partition would be able to designate a house-keeping
sub-partition/mask, but who cares about all the various different
housekeeping parties.

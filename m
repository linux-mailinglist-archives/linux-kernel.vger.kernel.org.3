Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33B4E5110
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbiCWLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiCWLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:13:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80CF78076
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUUeaXeizdEbhTfbv9oM2YEpstZpvlj67k8v1Zerx7I=; b=B2fbnZPOT1h23P2XKSNtHyXWtw
        CSes4QkfbR4mT6NuFszS6Gddq7SeNz2UFZuAIkcgofqiHXvICYEL/wKRDIQBHpHv8j62ne1KOENjc
        DxIo14i3wV0Asb2oxVU/82QTpmuJ7Wf2ZUhfkyqKyfLYZ5cnpvtPr68iwfK5Yzyk6/6gZ0AP4rc/G
        /rvF9GNI3bKG5YQ/yFyugVF65PgckQS/gcT+SCH80aa08ZIhl5zOTdNpnfCgXVs0gtIiCmO4asfHx
        phv35XUB9AMKdhEuQ2GkJf6gWtPzXyXpiwa/BXFIbcZ6K5BQBHZwf7AC0NJ6geZZuiG0JXM3Vj6lT
        3C5SDZKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWyuG-003k7a-5W; Wed, 23 Mar 2022 11:12:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9961D3000E6;
        Wed, 23 Mar 2022 12:11:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54D0F2C870D41; Wed, 23 Mar 2022 12:11:57 +0100 (CET)
Date:   Wed, 23 Mar 2022 12:11:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit
 and the oom_reaper
Message-ID: <YjsAffS5j4Mh/4Rc@hirez.programming.kicks-ass.net>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
 <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
 <87bkxyaufi.ffs@tglx>
 <Yjn7FXoXtgGT977T@dhcp22.suse.cz>
 <87zglha9rt.ffs@tglx>
 <YjrlqAMyJg3GKZVs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjrlqAMyJg3GKZVs@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:17:28AM +0100, Michal Hocko wrote:

> > Neither is it "normal" that a VM is scheduled out long enough to miss a
> > 1 second deadline. That might be considered normal by cloud folks, but
> > that's absolute not normal from an OS POV. Again, that's not a OS
> > problem, that's an operator/admin problem.
> 
> Thanks for this clarification. I would tend to agree. Following a
> previous example that oom victims can leave inconsistent state behind
> which can influence other processes. I am wondering what kind of
> expectations about the lock protected state can we make when the holder
> of the lock has been interrupted at any random place in the critical
> section.

Right, this is why the new owner gets the OWNER_DIED bit so it can see
something really dodgy happened.

Getting that means it needs to validate state consistency or just print
a nice error and fully terminate things.

So robust futexes:

 - rely on userspace to maintain a linked list of held locks,

 - rely on lock acquire to check OWNER_DIED and handle state
   inconsistency.

If userspace manages to screw up either one of those, it's game over.
Nothing we can do about it.

Software really has to be built do deal with this, it doesn't magically
work (IOW, in 99% of the case it just doesn't work right).

> [...]
> > > And just to be clear, this is clearly a bug in the oom_reaper per se.
> > > Originally I thought that relaxing the locking (using trylock and
> > > retry/bail out on failure) would help but as I've learned earlier this
> > > day this is not really possible because of #PF at least. The most self
> > > contained solution would be to skip over vmas which are backing the
> > > robust list which would allow the regular exit path to do the proper
> > > cleanup.
> > 
> > That's not sufficient because you have to guarantee that the relevant
> > shared futex is accessible. See the lock chain example above.
> 
> Yeah, my previous understanding was that the whole linked list lives in
> the single mapping and we can just look at their addresses.

Nope; shared futexes live in shared memory and as such the robust_list
entry must live there too. That is, the robust_list entry is embedded in
the lock itself along the lines of:

struct robust_mutex {
	u32 futex;
	struct robust_list list;
};

and then you register the robust_list_head with:

 .futex_offset = offsetof(struct robust_mutex, futex) -
		 offsetof(struct robust_mutex, list);

or somesuch (glibc does all this). And the locks themselves are spread
all over the place.

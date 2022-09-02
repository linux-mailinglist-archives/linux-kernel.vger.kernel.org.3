Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB05AA655
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiIBD1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIBD1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:27:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C27B7AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:27:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E799E20A75;
        Fri,  2 Sep 2022 03:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662089249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GL6+2GXh/2nFgXmYIP+TgmK2lf7e53/uu6BPJeJrYkk=;
        b=c2i8KzQ8CjCNmeiqeCs2dkxyL0C7tsH9J57mAqVWbpvn6qdyGJtR/dzoQr7P00J0OCRZYZ
        2/x4ovmo8ydfg0Iu2pjVMGKdDM7dBIpdVhJUdtTP83c6MTWZMa6HRO6M2JD6YQNxBz122B
        jXP0U9NzA6LZ3I1IPVOhssxRtUw8ddY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662089249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GL6+2GXh/2nFgXmYIP+TgmK2lf7e53/uu6BPJeJrYkk=;
        b=4SFs+r8yuGPkKxb3Xezd3fRsc8GETcgz1nzpv2C3yPqUYycX0jwFIRKlcrTmYnnZUHb7VU
        eAo5XuVJcmlVC/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D49B13328;
        Fri,  2 Sep 2022 03:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zr8aDCF4EWO9DAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 02 Sep 2022 03:27:29 +0000
Date:   Fri, 2 Sep 2022 05:27:27 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/3] lib/stackdepot: Add a refcount field in stack_record
Message-ID: <YxF4H5tu9cl9ePMD@localhost.localdomain>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-2-osalvador@suse.de>
 <YxBsWu36eqUw03Dy@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBsWu36eqUw03Dy@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:24:58AM +0200, Marco Elver wrote:
> On Thu, Sep 01, 2022 at 06:42AM +0200, Oscar Salvador wrote:
> >  include/linux/stackdepot.h | 13 ++++++-
> >  lib/stackdepot.c           | 79 +++++++++++++++++++++++++++++++-------
> >  mm/kasan/common.c          |  3 +-
> 
> +Cc other kasan maintainers

Yeah, sorry about that, I should have CCed you guys.

> > +typedef enum stack_action {
> > +	STACK_ACTION_NONE,
> > +	STACK_ACTION_INC,
> > +}stack_action_t;
> > +
> 
> missing space after '}'. But please no unnecessary typedef, just 'enum
> stack_action' (and spelling out 'enum stack_action' elsewhere) is just
> fine.

Sure, will re-name it.

> 
> This is in the global namespace, so I'd call this
> stack_depot_action+STACK_DEPOT_ACTION_*.
> 
> However, .._ACTION_INC doesn't really say what's incremented. As an
> analog to stack_depot_dec_count(), perhaps .._ACTION_COUNT?

I guess we can go "STACK_DEPOT_ACTION_COUNT", or "STACK_DEPOT_ACTION_REF_INC",
but the latter seems rather baroque for my taste.

> In general it'd be nicer if there was stack_depot_inc_count() instead of
> this additional argument, but I see that for performance reasons you
> might not like that?

Yes, the first prototypes didn't have this stack_action_t thing,
but that implied that we had to look for the stack twice
in the __set_page_owner() case.

This way we only do that in the __reset_page_owner() case.

So yes, it's a trade-off performance vs LOC.

> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -63,6 +63,7 @@ struct stack_record {
> >  	u32 hash;			/* Hash in the hastable */
> >  	u32 size;			/* Number of frames in the stack */
> >  	union handle_parts handle;
> > +	refcount_t count;		/* Number of the same repeated stacks */
> 
> This will increase stack_record size for every user, even if they don't
> care about the count.
> 
> Is there a way to store this out-of-line somewhere?

That would require having some kind of e.g: dynamic struct and allocating
new links to stacks as they were created and increase the refcount there.

But that would be too much of complexity, I think.

As I read in your other thread, we can probably live with that, but
it is worth spelling out in the changelog.

> > +void stack_depot_dec_count(depot_stack_handle_t handle)
> > +{
> > +	struct stack_record *stack = NULL;
> > +
> > +	stack = stack_depot_getstack(handle);
> > +	if (stack) {
> > +	/*
> > +	 * page_owner creates some stacks via create_dummy_stack().
> > +	 * We are not interested in those, so make sure we only decrement
> > +	 * "valid" stacks.
> > +	 */
> 
> Comment indent is wrong.

Will fix it.

Thanks for taking the time to review the code Marco!


-- 
Oscar Salvador
SUSE Labs

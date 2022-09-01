Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56D5A93C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiIAKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiIAKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:01:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB86134898
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:01:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7512219F1;
        Thu,  1 Sep 2022 10:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662026480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pUkZJWp2nQ4dbOBqWBuaF5RJwLtyXngvDW9UF32VZDE=;
        b=qKa4+SljwPi5zCaniT9NpUQnkosVRVt7giTvOKUpwsXKorMmAxQewzjtYbLbBdGPJ3Isuk
        yqbtgGqvo/AMBanDVSdZICG5/GeuXneHiiibqQ2mgUR60pgTiQM2Ffm7mcCEHJnX6p30rD
        D64G/Oo5iJ6um4ICyQ+S6C4NGOgXzSw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4B7D13A89;
        Thu,  1 Sep 2022 10:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m67wJfCCEGMyXwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 10:01:20 +0000
Date:   Thu, 1 Sep 2022 12:01:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marco Elver <elver@google.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/3] lib/stackdepot: Add a refcount field in stack_record
Message-ID: <YxCC7zoc3wX3ieMR@dhcp22.suse.cz>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-2-osalvador@suse.de>
 <YxBsWu36eqUw03Dy@elver.google.com>
 <YxBvcDFSsLqn3i87@dhcp22.suse.cz>
 <CANpmjNNjkgibnBcp7ZOWGC5CcBJ=acgrRKo0cwZG0xOB5OCpLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNjkgibnBcp7ZOWGC5CcBJ=acgrRKo0cwZG0xOB5OCpLw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-09-22 11:18:19, Marco Elver wrote:
> On Thu, 1 Sept 2022 at 10:38, Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 01-09-22 10:24:58, Marco Elver wrote:
> > > On Thu, Sep 01, 2022 at 06:42AM +0200, Oscar Salvador wrote:
> > [...]
> > > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > > index 5ca0d086ef4a..aeb59d3557e2 100644
> > > > --- a/lib/stackdepot.c
> > > > +++ b/lib/stackdepot.c
> > > > @@ -63,6 +63,7 @@ struct stack_record {
> > > >     u32 hash;                       /* Hash in the hastable */
> > > >     u32 size;                       /* Number of frames in the stack */
> > > >     union handle_parts handle;
> > > > +   refcount_t count;               /* Number of the same repeated stacks */
> > >
> > > This will increase stack_record size for every user, even if they don't
> > > care about the count.
> >
> > Couldn't this be used for garbage collection?
> 
> Only if we can precisely figure out at which point a stack is no
> longer going to be needed.
> 
> But more realistically, stack depot was designed to be simple. Right
> now it can allocate new stacks (from an internal pool), but giving the
> memory back to that pool isn't supported. Doing garbage collection
> would effectively be a redesign of stack depot.

Fair argument. 

> And for the purpose
> for which stack depot was designed (debugging tools), memory has never
> been an issue (note that stack depot also has a fixed upper bound on
> memory usage).

Is the increased size really a blocker then? I see how it sucks to
maintain a counter when it is not used by anything but page_owner but
storing that counte externally would just add more complexity AFAICS
(more allocations, more tracking etc.).

Maybe the counter can be conditional on the page_owner which would add
some complexity as well (variable size structure) but at least the
external allocation stuff could be avoided.
-- 
Michal Hocko
SUSE Labs

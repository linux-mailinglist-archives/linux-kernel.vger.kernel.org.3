Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8766B50AD28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443031AbiDVBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiDVBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF14936B7E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650590353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=70wGqlUOgWCDvNBVd6ZanDDxLxnP4j+Zj98awDX3AtQ=;
        b=bM4WfxEv7SPmjcxe9Tah3eN4iNiSJT0IEsDhcniZSWb9tfR0pT4g6ynP/NzapnNMtoDXu8
        tCN4AP74fEdsoD68TgoWGhhK/EUDQDIxXb8uP1lTqyh/BzqCoCsVEghb9leHSquRwBoKkL
        tp5tkaRyE4l6w3UeUmjXyIs2yDOmigI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-J6j6l2JYOBqHPObQuPBd_Q-1; Thu, 21 Apr 2022 21:19:10 -0400
X-MC-Unique: J6j6l2JYOBqHPObQuPBd_Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36E39299E745;
        Fri, 22 Apr 2022 01:19:10 +0000 (UTC)
Received: from rh (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98324559209;
        Fri, 22 Apr 2022 01:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1nhhww-008TIa-TA; Fri, 22 Apr 2022 11:19:06 +1000
Date:   Fri, 22 Apr 2022 11:19:05 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm: do not call add_nr_deferred() with zero deferred
Message-ID: <YmICiX2DFSveY17Z@rh>
References: <20220416004104.4089743-1-roman.gushchin@linux.dev>
 <59404249-de0c-c569-d04a-9da38ed14b0a@redhat.com>
 <Yl7mdguNR3CabMAN@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl7mdguNR3CabMAN@carbon>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:42:30AM -0700, Roman Gushchin wrote:
> On Tue, Apr 19, 2022 at 02:56:06PM +0200, David Hildenbrand wrote:
> > On 16.04.22 02:41, Roman Gushchin wrote:
> > > add_nr_deferred() is often called with next_deferred equal to 0.
> > > For instance, it's happening under low memory pressure for any
> > > shrinkers with a low number of cached objects. A corresponding trace
> > > looks like:
> > >   <...>-619914 [005] .... 467456.345160: mm_shrink_slab_end: \
> > >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
> > >   unused scan count 0 new scan count 0 total_scan 0	     \
> > >   last shrinker return val 0
> > > 
> > >   <...>-619914 [005] .... 467456.345371: mm_shrink_slab_end: \
> > >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
> > >   unused scan count 0 new scan count 0 total_scan 0	     \
> > >   last shrinker return val 0
> > > 
> > >   <...>-619914 [005] .... 467456.345380: mm_shrink_slab_end: \
> > >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1 unused \
> > >   scan count 0 new scan count 0 total_scan 0	             \
> > >   last shrinker return val 0
> > > 
> > > This lead to unnecessary checks and atomic operations, which can be
> > > avoided by checking next_deferred for not being zero before calling
> > > add_nr_deferred(). In this case the mm_shrink_slab_end trace point
> > > will get a potentially slightly outdated "new scan count" value, but
> > > it's totally fine.
> > 
> > Sufficient improvement to justify added complexity for anybody reading
> > that code?
> 
> I don't have any numbers and really doubt the difference is significant,

Never been able to measure it myself.

HwoeverI'd much prefer the tracepoint output stays accurate - I've had to
post-process and/or graph the shrinker progress as reported by the
start/end tracpoints to find problems in the algorithms in the past.
That's why there is the additional complexity in the code to make
sure the coutners are accurate in the first place.

> however the added complexity is also small: one "if" statement.

Yeah, complexity is not the problem here - it's that accuracy of the
tracepoints has actually mattered to me in the past...

Cheers,

DAve.
-- 
Dave Chinner
dchinner@redhat.com


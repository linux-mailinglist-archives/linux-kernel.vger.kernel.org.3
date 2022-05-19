Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97852D584
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbiESOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiESODy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359D438AB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6AF4618A8;
        Thu, 19 May 2022 14:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A09DC385AA;
        Thu, 19 May 2022 14:03:50 +0000 (UTC)
Date:   Thu, 19 May 2022 10:03:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     YoPOhRctb8wwbmY5@carbon, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <20220519100348.101d027d@gandalf.local.home>
In-Reply-To: <b728f944-e3ae-cdb6-5f02-2fb21466b2fb@openvz.org>
References: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
        <20220518160447.20a7b96f@gandalf.local.home>
        <b728f944-e3ae-cdb6-5f02-2fb21466b2fb@openvz.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 14:35:46 +0300
Vasily Averin <vvs@openvz.org> wrote:

> >> @@ -33,42 +35,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
> >>  		__entry->bytes_req	= bytes_req;
> >>  		__entry->bytes_alloc	= bytes_alloc;
> >>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
> >> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
> >> +					  (s && s->flags & SLAB_ACCOUNT);  
> > 
> > Now you could make this even faster in the fast path and save just the
> > s->flags.
> > 
> > 	__entry->sflags = s ? s->flags : 0;
> >   
> >>  	),
> >>  
> >> -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> >> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
> >>  		(void *)__entry->call_site,
> >>  		__entry->ptr,
> >>  		__entry->bytes_req,
> >>  		__entry->bytes_alloc,
> >> -		show_gfp_flags(__entry->gfp_flags))
> >> +		show_gfp_flags(__entry->gfp_flags),
> >> +		__entry->accounted ? "true" : "false")  
> > 
> > And then have: "accounted=%s":
> > 
> > 		(__entry->gfp_flags & __GFP_ACCOUNT) ||
> > 		(__entry->sflags & SLAB_ACCOUNT) ? "true" : "false"  
> 
> Unfortunately this returns back sparse warnings about bitwise gfp_t and slab_flags_t casts.
> Could you please explain why your variant is faster?

Micro-optimization, grant you, but it is faster because it moves some of
the logic into the slow path (the read side), and takes it out of the fast
path (the write side).

The idea of tracing is to squeeze out every cycle we can to keep the
tracing overhead down.

But it's really up to you if you need that. I'm not going to let this be a
blocker. This is more of an FYI than anything else.

-- Steve

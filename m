Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684975237A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbiEKPrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiEKPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:47:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773546175
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:47:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8A7F121CCD;
        Wed, 11 May 2022 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652284047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WsIKEP1mbw5K0lCm4lLy/bWkBCAiurzAzt71iQfxPDQ=;
        b=Iev1ORle/s9/sJqgo3MPar0Rupc/yOav3+l71U9IZYe9pPoAPTXz+WkmSSQjtnGLJSyPGF
        vbo4CDVr5EoZ9QnWNSf+9g+FYW/lOCj613IF1v0eQ/41q5Uu24bhAYb382for5Rt1iV8Ny
        pVu+ILxkjJT9WdSoSF7hSCsfK9lvOR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652284047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WsIKEP1mbw5K0lCm4lLy/bWkBCAiurzAzt71iQfxPDQ=;
        b=z6CdKNXF5ot/9K/p4qUZP68t5TtSsIgYRzwERBHklbJTzbXaS7wr4ZQsGzOS0L5pj5VTlE
        xO9oXNFyUt5fT3CA==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AE0DE2C141;
        Wed, 11 May 2022 15:47:25 +0000 (UTC)
Date:   Wed, 11 May 2022 16:47:23 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: Fix tracepoint mm_page_alloc_zone_locked()
Message-ID: <20220511154723.GO20579@suse.de>
References: <20220511081207.132034-1-vvghjk1234@gmail.com>
 <20220511142303.GN20579@suse.de>
 <CAEcHRTrq6gGac5zYS24qf59rEjDBYvGHkjdZGyGNnuKzXTKVcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAEcHRTrq6gGac5zYS24qf59rEjDBYvGHkjdZGyGNnuKzXTKVcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:02:30AM +0900, Wonhyuk Yang wrote:
> > The original intent of that tracepoint was to trace when pages were
> > removed from the buddy list. That would suggest this untested patch on
> > top of yours as a simplication;
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0351808322ba..66a70b898130 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2476,6 +2476,8 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
> >                 del_page_from_free_list(page, zone, current_order);
> >                 expand(zone, page, order, current_order, migratetype);
> >                 set_pcppage_migratetype(page, migratetype);
> > +               trace_mm_page_alloc_zone_locked(page, order, migratetype,
> > +                       pcp_allowed_order(order) && migratetype < MIGRATE_PCPTYPES);
> >                 return page;
> >         }
> 
> Interestingly, my first approach was quite similar your suggestion. But I
> noticed that there can be a request whose migration type is MOVABLE
> and alloc_flags doen't have ALLOC_CMA. In that case, page are marked
> as percpu-refill even though it was allocated from buddy-list directly.
> Is there no problem if we just ignore this case?
> 

I assume you are referring to the case where CMA allocations are being
balanced between regular and CMA areas. I think it's relatively harmless
if percpu_refill field is not 100% accurate for that case. There are
also cases like the percpu list is too small to hold a THP and it's not a
percpu_refill either. If 100% accuracy is an issue, I would prefer renaming
it to percpu_eligible or just deleting it instead of adding complexity
for a tracepoint.  The main value of that tracepoint is determining what
percentage of allocations are potentially contending on zone lock at a
particular time.

-- 
Mel Gorman
SUSE Labs

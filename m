Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C9534D29
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbiEZKQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbiEZKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:14:58 -0400
Received: from outbound-smtp52.blacknight.com (outbound-smtp52.blacknight.com [46.22.136.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D7CC148
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:14:53 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id 24C86FAC44
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:14:52 +0100 (IST)
Received: (qmail 9319 invoked from network); 26 May 2022 10:14:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 May 2022 10:14:51 -0000
Date:   Thu, 26 May 2022 11:14:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/6] mm/page_alloc: Add page->buddy_list and
 page->pcp_list
Message-ID: <20220526101450.GE3441@techsingularity.net>
References: <20220509130805.20335-1-mgorman@techsingularity.net>
 <20220509130805.20335-2-mgorman@techsingularity.net>
 <Yn4ZsKEmtnquHhWJ@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yn4ZsKEmtnquHhWJ@FVFYT0MHHV2J.usts.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 04:41:20PM +0800, Muchun Song wrote:
> > @@ -94,6 +95,10 @@ struct page {
> >  					/* Count page's or folio's mlocks */
> >  					unsigned int mlock_count;
> >  				};
> > +
> > +				/* Or, free page */
> > +				struct list_head buddy_list;
> > +				struct list_head pcp_list;
> >  			};
> 
> Since you have clarified "lru" member, should we go further?
> Like union "index" to "pcp_migratetype" and "private" to "order"
> since buddy allocator reuses "index" and "private" as well.
> My initial idea is as follows, it is more clear for me, what
> do you think?
> 

I think it would be more appropriate to split it out as a separate type as
suggested by Matthew Wilcox. While I would not be opposed to your approach
as such, it's outside the context of the series which is modifying how
PCP works.

-- 
Mel Gorman
SUSE Labs

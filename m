Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F327515FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiD3SmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbiD3SmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 14:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53171286F1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 11:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DECD360F9B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 18:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EACC385AA;
        Sat, 30 Apr 2022 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651343924;
        bh=0kM/bEs+g1gOFSB9VF1SRjrnl2Jg+odHTRMiA+YRZbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mgeN3VVmKBNqS5F1fJjP+uFVBus1BjgNrNcklhgB//33m4Njw7MXJgdIUJa1dbzqJ
         bzghRIti9rqpT6dvLHFpwoUm+gQLWw6zY2O/XSV11j8SqP1C0EahIZrbgtVI7sTpnk
         NHGSzOm7di8TftrCHI0S4cGJc3KgAyR2mEB7hWNU=
Date:   Sat, 30 Apr 2022 11:38:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: cache the result of node_dirty_ok()
Message-Id: <20220430113843.7350160cf329e2a732e1cb94@linux-foundation.org>
In-Reply-To: <20220430011032.64071-1-vvghjk1234@gmail.com>
References: <20220430011032.64071-1-vvghjk1234@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 10:10:32 +0900 Wonhyuk Yang <vvghjk1234@gmail.com> wrote:

> To spread dirty page, nodes are checked whether
> it reached the dirty limit using the expensive
> node_dirty_ok(). To reduce the number of calling
> node_dirty_ok(), last node that hit the dirty
> limit is cached.
> 
> Instead of caching the node, caching both node
> and it's result of node_dirty_ok() can reduce
> the number of calling node_dirty_ok() more than
> before.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4068,7 +4068,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  {
>  	struct zoneref *z;
>  	struct zone *zone;
> -	struct pglist_data *last_pgdat_dirty_limit = NULL;
> +	struct pglist_data *last_pgdat = NULL;
> +	bool last_pgdat_dirty_limit = false;
>  	bool no_fallback;
>  
>  retry:
> @@ -4107,13 +4108,13 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  		 * dirty-throttling and the flusher threads.
>  		 */
>  		if (ac->spread_dirty_pages) {
> -			if (last_pgdat_dirty_limit == zone->zone_pgdat)
> -				continue;
> +			if (last_pgdat != zone->zone_pgdat) {
> +				last_pgdat = zone->zone_pgdat;
> +				last_pgdat_dirty_limit = node_dirty_ok(zone->zone_pgdat);
> +			}
>  
> -			if (!node_dirty_ok(zone->zone_pgdat)) {
> -				last_pgdat_dirty_limit = zone->zone_pgdat;
> +			if (!last_pgdat_dirty_limit)
>  				continue;
> -			}
>  		}
>  
>  		if (no_fallback && nr_online_nodes > 1 &&

Looks reasonable to me.  Hopefully Mel and Johannes can review.

I think last_pgdat_dirty_limit isn't a great name.  It records the
dirty_ok state of last_pgdat.  So why not call it last_pgdat_dirty_ok?

--- a/mm/page_alloc.c~mm-page_alloc-cache-the-result-of-node_dirty_ok-fix
+++ a/mm/page_alloc.c
@@ -4022,7 +4022,7 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	struct zoneref *z;
 	struct zone *zone;
 	struct pglist_data *last_pgdat = NULL;
-	bool last_pgdat_dirty_limit = false;
+	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
 
 retry:
@@ -4063,10 +4063,10 @@ retry:
 		if (ac->spread_dirty_pages) {
 			if (last_pgdat != zone->zone_pgdat) {
 				last_pgdat = zone->zone_pgdat;
-				last_pgdat_dirty_limit = node_dirty_ok(zone->zone_pgdat);
+				last_pgdat_dirty_ok = node_dirty_ok(zone->zone_pgdat);
 			}
 
-			if (!last_pgdat_dirty_limit)
+			if (!last_pgdat_dirty_ok)
 				continue;
 		}
 
_


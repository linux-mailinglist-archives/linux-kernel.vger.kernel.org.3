Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7D5334A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbiEYBWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiEYBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:22:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6DE3F898
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20078B81C03
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7583C34100;
        Wed, 25 May 2022 01:22:01 +0000 (UTC)
Date:   Tue, 24 May 2022 21:22:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch v2] [PATCH] mm/page_alloc: Fix tracepoint
 mm_page_alloc_zone_locked()
Message-ID: <20220524212200.207f02a5@gandalf.local.home>
In-Reply-To: <20220512025307.57924-1-vvghjk1234@gmail.com>
References: <20220512025307.57924-1-vvghjk1234@gmail.com>
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

Sorry for the late reply, but I finally have time to catchup on my inbox.

On Thu, 12 May 2022 11:53:07 +0900
Wonhyuk Yang <vvghjk1234@gmail.com> wrote:

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2476,6 +2476,9 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>  		del_page_from_free_list(page, zone, current_order);
>  		expand(zone, page, order, current_order, migratetype);
>  		set_pcppage_migratetype(page, migratetype);
> +		trace_mm_page_alloc_zone_locked(page, order, migratetype, 
> +				pcp_allowed_order(order) &&
> +				migratetype < MIGRATE_PCPTYPES);

It would make more sense to put this logic into the TP_fast_assign() if
possible. This code is added at the location of execution, and even though
it may not run while tracing is disabled, it does affect icache.

Could you pass in the order (you already have migratetype) and then in the
trace event have:


 	TP_fast_assign(
 		__entry->pfn		= page ? page_to_pfn(page) : -1UL;
 		__entry->order		= order;
 		__entry->migratetype	= migratetype;
+		__entry->percpu_refill	= pcp_allowed_order(order) &&
					  migratetype < MIGRATE_PCPTYPES);
 	),

??

-- Steve

>  		return page;
>  	}
>  

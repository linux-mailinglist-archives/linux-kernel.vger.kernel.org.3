Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412A64EA525
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiC2CYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiC2CYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:24:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C92243720
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HNgSyPoGUj80vPzBlsxCechK1rmOwMq8hDhkmhfmcvc=; b=Hi098owmI1hCJhuPxfqhVEymK9
        cTrdD2fZMhd+pD53YJP+q9km4hEBipm1lpf1MTLL/O7QVayJGONlWRJl0SEexALt+ATU5TOUBwFfl
        X0GgSgjTr3cJk0iIMfhZnz36/JNw8w8J9fGEIYTrafLp1tj+owZS4e/vbUEHWnIRBwqnZxEWVVN6P
        qCZ3P3Rli3wngH/U4msBfyWz9QEjkhBOcWZLmSExB5Axrsz7/trM5KBy2oHaGX96c94bBRRedW2dS
        Ag6xV+I558CBRg1FDpfvo2UtHZW7pWj77cmT49Tu216DadfX3/5riUvhT9v4M6BB1kFvm1EYCH75t
        hBgovl5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ1VT-00HTZg-Ct; Tue, 29 Mar 2022 02:22:51 +0000
Date:   Tue, 29 Mar 2022 03:22:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Message-ID: <YkJte/L4jZv47FOO@casper.infradead.org>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <20220327024101.10378-2-richard.weiyang@gmail.com>
 <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20220329004146.2xdswvrm2qu7f47x@master>
 <875ynxh9lg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20220329015230.hneciyfxoxtvfytl@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329015230.hneciyfxoxtvfytl@master>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:52:30AM +0000, Wei Yang wrote:
> @@ -1985,14 +1985,13 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  			continue;
>  
>  		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
> -		if (!zone_watermark_ok(zone, 0,
> +		if (zone_watermark_ok(zone, 0,
>  				       high_wmark_pages(zone) +
>  				       nr_migrate_pages,
>  				       ZONE_MOVABLE, 0))

Someone's done the silly thing of lining up all of these with spaces,
so either all these lines also need to be shrunk by one space, or you
need to break that convention and just go to a reasonable number of
tabs.  I'd do it like this:

		if (zone_watermark_ok(zone, 0,
				high_wmark_pages(zone) + nr_migrate_pages,
				ZONE_MOVABLE, 0))

but not everybody would.

> @@ -2040,16 +2040,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  		return 0;
>  
>  	/* Avoid migrating to a node that is nearly full */
> -	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> -		int z;
> -
> +	if ((zone = migrate_balanced_pgdat(pgdat, nr_pages))) {

Linus had a rant about this style recently.  He much prefers:

	zone = migrate_balanced_pgdat(pgdat, nr_pages);
	if (zone) {

(the exception is for while loops:

	while ((zone = migrate_balanced_pgdat(pgdat, nr_pages)) != NULL)

where he wants to see the comparison against NULL instead of the awkard
double-bracket)


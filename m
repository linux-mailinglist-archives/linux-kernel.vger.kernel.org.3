Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E85B1752
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiIHIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiIHIkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:40:20 -0400
Received: from outbound-smtp44.blacknight.com (outbound-smtp44.blacknight.com [46.22.136.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FC9859A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:40:17 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 5918CF81DB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:40:16 +0100 (IST)
Received: (qmail 21798 invoked from network); 8 Sep 2022 08:40:16 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Sep 2022 08:40:16 -0000
Date:   Thu, 8 Sep 2022 09:40:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH] mm/page_owner.c: remove redudant drain_all_pages
Message-ID: <20220908084008.tmerssqksyrg3knl@techsingularity.net>
References: <1662537673-9392-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1662537673-9392-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 04:01:13PM +0800, Zhenhua Huang wrote:
> Page owner info of pages in pcp list have already been reset:
> 	free_unref_page
> 		-> free_unref_page_prepare
> 			-> free_pcp_prepare
> 				-> free_pages_prepare which do page owner
> 				reset
> 		-> free_unref_page_commit which add pages into pcp list
> It can also be confirmed from dump that page owner info of pcp pages are
> correct. Hence there is no more need to drain when reading.
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>

This is subtle because there is no comment explaining why drain_all_pages
is called and git history does not help. I agree that the page owner
information has already been reset and has been since the very beginning
but I do not think that is *why* drain_all_pages is called here.

After the drain_all_pages, there is a fairly standard PFN walker with this
in it;

        /* Find an allocated page */
        for (; pfn < max_pfn; pfn++) {
	....
                page = pfn_to_page(pfn);
                if (PageBuddy(page)) {
                        unsigned long freepage_order = buddy_order_unsafe(page);

                        if (freepage_order < MAX_ORDER)
                                pfn += (1UL << freepage_order) - 1;
                        continue;
                }	
	....
        }

The PFN walker is trying to skip free pages efficiently and PCP pages
are not buddy pages so the order is unknown. The order *can* be known but
it's risky to try detecting it. I suspect the drain_all_pages is called
to move PCP pages to the buddy list so they can identified as buddy pages
and skipped and has nothing to do with resetting the page owner.

If that is correct then I think it is overkill to drain the PCP lists
to marginally improve the efficiency of the PFN walker and the drain is
subject to a race. Just because the PCP lists are drained does not mean
a new PCP page will be added during the PFN walk. Furthermore, PCP pages
get skipped because PAGE_EXT_OWNER_ALLOCATED is cleared so it's not about
scan safety. The drain is a guaranteed expensive operation that is unlikely
to be offset by a slight increase in efficiently of the PFN walker when
skipping free pages so the drain_all_pages should be dropped. I believe
the patch itself is correct but the changelog needs to be changed.

With a changelog stating that the patch is removing an expensive and
unnecessary operation as PCP pages are safely skipped;

	Acked-by: Mel Gorman <mgorman@techsingularity.net>

But just in case -- Joonsoo, can you clarify why drain_all_pages was
originally called?

-- 
Mel Gorman
SUSE Labs

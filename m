Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030452DF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiESV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiESV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:28:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CD6E8CD
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iLKJL80pdLJpGRira2nJXXVQ3PoLCXZN+D6vBVWk5N8=; b=c87/WFkxD9GWe5V++LDIilAbI9
        cbY0e1u8kgx9DA3mhAoDq6Agf3TdgrgE2ccS5388wym+BPGFJbuDzxWxZ83c05MWDEfKy/G1BnQVI
        PEkHuc8Eq0wg+GlZ1qWPPrTFoioo2WGmpN2WpWTLHGQnxeXDR/s8Wdhj7+CV36eormFEMuo6Zljk9
        aMDwuZFYOkhVIyO8QqvV3flL1cQr8fZ7zPrqdJ2HtaaCrTTh1f/RJ0s6nkaE90BuFEfDdlwMiizhE
        CC7i0buKxIr+W6WFXQJngakRL9vWW9QbvCe9N/KSyoHHc4lOPSAm3J0suZTtO2eTcqce8gitFEEvQ
        Rkkl5IFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrnh2-00D71X-6i; Thu, 19 May 2022 21:28:24 +0000
Date:   Thu, 19 May 2022 22:28:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/page_alloc.c:984:9: warning: iteration 119304648 invokes
 undefined behavior
Message-ID: <Yoa2eJ6+nyvK1EL+@casper.infradead.org>
References: <202205200521.65W2rpLt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205200521.65W2rpLt-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 05:14:52AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>    mm/page_alloc.c: In function 'rmqueue.isra':
> >> mm/page_alloc.c:984:9: warning: iteration 119304648 invokes undefined behavior [-Waggressive-loop-optimizations]
>      984 |         list_add(&page->lru, &area->free_list[migratetype]);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    mm/page_alloc.c:2305:21: note: within this loop
>     2305 |         while (high > low) {
>          |                ~~~~~^~~~~

That's OK.  'high' and 'low' are page orders.  They both lie in the
range [0,63], so this will not iterate 119304648 times (what a funny
number; I wonder why GCC chose it).

Can we make GCC happier by telling it that low and high are unsigned?
It should have figured out that 'high' is <= 63 already, as that's a
consequence of:

        unsigned long size = 1 << high;


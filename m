Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF55B4C83DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiCAGT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiCAGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:19:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE61433AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:18:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 339B61F37D;
        Tue,  1 Mar 2022 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646115522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYJHUH0IgdfnLKYKC3tcsTkSw2HdASrxxZkAzWZIFtM=;
        b=AAxssDfaKg+Vh+dvy85Lm9NNR4J8ET0z2mgaPAnINymAiB3UiSwmszyLlDz8m4mz1qbTF+
        Jaw0VeJixqh0rg8L2VgliVxFCC4dZLfiBoGtBbQZQFZXInwryTKBKmGW3smqWg9H/cuhzy
        9tPShcFvBgQsWBIqMAO+7hv/zMCCwG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646115522;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYJHUH0IgdfnLKYKC3tcsTkSw2HdASrxxZkAzWZIFtM=;
        b=boAWlaocpff9pi8AIuLcWTsCXT+E901Zq6CIQqYaC+hbJYB0BFi2eQCyV19LphSjJGjs84
        +duKdRJk1VaQp2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEF1F139EF;
        Tue,  1 Mar 2022 06:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CuodMsC6HWLvEwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 01 Mar 2022 06:18:40 +0000
Date:   Tue, 1 Mar 2022 07:18:39 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH -V13 2/3] NUMA balancing: optimize page placement for
 memory tiering system
Message-ID: <Yh26v+4LtnvFnWWz@localhost.localdomain>
References: <20220221084529.1052339-1-ying.huang@intel.com>
 <20220221084529.1052339-3-ying.huang@intel.com>
 <YhzwO/lw1xx7EjNb@localhost.localdomain>
 <87czj6321p.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czj6321p.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:16:18AM +0800, Huang, Ying wrote:
> Hi, Oscar,

Hi Huang Ying

>  b. Make kswapd of the fast memory node to reclaim pages until the free
>     pages are a little more than the high watermark (named as promo
>     watermark).  If we want to promote some hot pages from the slow
>     memory to the fast memory, but the free pages of the fast memory
>     node will become lower than the high watermark after promotion, we
>     will wake up kswapd of the fast memory node to demote more cold
>     pages in the fast memory node to the slow memory node firstly.  This
>     will free some extra space in the fast memory node, so the hot pages
>     in the slow memory node can be promoted to the fast memory node.

What about this? Somehow it sounds clear to me.

"b. Define a new watermark called wmark_promo which is higher than wmark_high,
    and have kswapd reclaiming pages until free pages reach such watermark.
    The scenario is as follows: when we want to promote hot-pages from a slow
    memory to a fast memory, but fast memory's free pages would go lower than
    high watermark with such promotion, we wake up kswapd with wmark_promo
    watermark in order to demote cold pages and free us up some space.
    So, next time we want to promote hot-pages we might have a chance of
    doing so."

But I am fine with your updated write up as well, so if you spin a new
version:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

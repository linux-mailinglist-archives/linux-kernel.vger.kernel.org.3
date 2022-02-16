Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3281C4B8353
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiBPItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:49:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiBPItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:49:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2E25A95F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:49:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4ED9F1F383;
        Wed, 16 Feb 2022 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645001345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fz8Fcg3DetJc33zyxaPnbTe2xNfylmTXx0ZDiKry/OI=;
        b=NXSh1XpyU7pEPODc/7T4RBPIq4il7OEqZH2+lAc+NGFH4eR1YdFLOAs0UHaw9Gv6oDGT2K
        lblF2PWUXBasw66aDJUnli6wX8CQO/tQ+HfzWamm0CLZXRqau2tHWUY86Y/hm6+6tRTGw0
        jgiYpTmlAvTFnZqWCLpISMtAwuyEUds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645001345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fz8Fcg3DetJc33zyxaPnbTe2xNfylmTXx0ZDiKry/OI=;
        b=QmkOCE2qEjbi3r8p55Qzv9QCmnF/f6hylmXm6JLXOIkpELVdGQbtEywORsipnAkYiB3gLz
        xknEmHcJgkHMxZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E7CC13A7C;
        Wed, 16 Feb 2022 08:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w+DjCoC6DGKjWgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 16 Feb 2022 08:49:04 +0000
Date:   Wed, 16 Feb 2022 09:49:02 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V12 1/3] NUMA Balancing: add page promotion counter
Message-ID: <Ygy6fg/KOTikCgLW@localhost.localdomain>
References: <20220216073815.2505536-1-ying.huang@intel.com>
 <20220216073815.2505536-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216073815.2505536-2-ying.huang@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 03:38:13PM +0800, Huang Ying wrote:
> In a system with multiple memory types, e.g. DRAM and PMEM, the CPU
> and DRAM in one socket will be put in one NUMA node as before, while
> the PMEM will be put in another NUMA node as described in the
> description of the commit c221c0b0308f ("device-dax: "Hotplug"
> persistent memory for use like normal RAM").  So, the NUMA balancing
> mechanism will identify all PMEM accesses as remote access and try to
> promote the PMEM pages to DRAM.
> 
> To distinguish the number of the inter-type promoted pages from that
> of the inter-socket migrated pages.  A new vmstat count is added.  The
> counter is per-node (count in the target node).  So this can be used
> to identify promotion imbalance among the NUMA nodes.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
...

> @@ -2072,6 +2072,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	pg_data_t *pgdat = NODE_DATA(node);
>  	int isolated;
>  	int nr_remaining;
> +	int nr_succeeded;

I think we should make this consistent and make it "unsigned int".
That is what migrate_pages() expects, and what the other caller using
nr_succeeded (demote_page_list()) already uses.
Unless there is a strong reason not to do so.

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

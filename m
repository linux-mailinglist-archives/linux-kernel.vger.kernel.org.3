Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836094D7866
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 22:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiCMVUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCMVUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 17:20:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11443AD2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FLR7UKfsMlLrrEj/Umb+LOUGT1OJV73SR8LYmmVKGa4=; b=qaGYal9EH35BPnMCN0DJSLwPDd
        cdi3gwfU+VVtHrv61UbTI64l9VOuBzRoqg6nKzR2vodCBMJXzZWp+UvjlrcdDuCA9KGaFP0aArojp
        H48DJfgfpbfsNM3YI+GScSXR4aOJYQBOA4x6PDJUnJF0Q3Pf2dnUD2Ac2/k04tzt7s61c2ydgJFWz
        JEJnQ4hLTOreousQ5MBV/ITdmyqMnMd6S6XtClvmyfRX3vwYnO+TNE54Y57CxaKG1JNROqbKSrDfp
        pAHdEBD6iOGOBzFDYcKS5Gqk5br/UVwn9rDV4wS2WopxRwFOt2bNy7BBpTMpdVdFJzh8YYoX8g5sP
        pveJHDPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTVbw-003UUm-Bf; Sun, 13 Mar 2022 21:18:44 +0000
Date:   Sun, 13 Mar 2022 21:18:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [mm/page_alloc] 8212a964ee: vm-scalability.throughput 30.5%
 improvement
Message-ID: <Yi5ftFbykAZLLCwf@casper.infradead.org>
References: <20220312154321.GC1189@xsang-OptiPlex-9020>
 <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
 <CANn89i+fM0k+=Qw0M0fso1f-Ya8--5+==gtcWqCpo=Gu-ca1Ow@mail.gmail.com>
 <8f499c76-68cb-a2c3-01fd-c8759e2fd317@suse.cz>
 <CANn89iJwBe4+C8KP--c_9O6QE_Tou+1Z0+ugtuniG-06nzxPmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJwBe4+C8KP--c_9O6QE_Tou+1Z0+ugtuniG-06nzxPmg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 02:10:12PM -0700, Eric Dumazet wrote:
> @@ -3065,6 +3062,12 @@ static int rmqueue_bulk(struct zone *zone,
> unsigned int order,
>          */
>         __mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
>         spin_unlock(&zone->lock);
> +       list_for_each_entry_safe(page, tmp, list, lru) {
> +               if (unlikely(check_pcp_refill(page))) {
> +                       list_del(&page->lru);
> +                       allocated--;
> +               }
> +       }

... you'd need to adjust __mod_zone_page_state() too, right?

>         return allocated;
>  }
> 

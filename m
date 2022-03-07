Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032134CF46A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiCGJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiCGJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:16:41 -0500
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D765158
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:15:45 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 6A1291C4C58
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:15:44 +0000 (GMT)
Received: (qmail 17169 invoked from network); 7 Mar 2022 09:15:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Mar 2022 09:15:44 -0000
Date:   Mon, 7 Mar 2022 09:15:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone
 spinlock is not held
Message-ID: <20220307091541.GD15701@techsingularity.net>
References: <20220304170215.1868106-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220304170215.1868106-1-eric.dumazet@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:02:15AM -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> For high order pages not using pcp, rmqueue() is currently calling
> the costly check_new_pages() while zone spinlock is held,
> and hard irqs masked.
> 
> This is not needed, we can release the spinlock sooner to reduce
> zone spinlock contention.
> 
> Note that after this patch, we call __mod_zone_freepage_state()
> before deciding to leak the page because it is in bad state.
> 
> v2: We need to keep interrupts disabled to call __mod_zone_freepage_state()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David Rientjes <rientjes@google.com>

Ok, this is only more expensive in the event pages on the free list have
been corrupted whch is already very unlikely so thanks!

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs

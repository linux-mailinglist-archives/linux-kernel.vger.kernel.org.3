Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4B4EE59B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiDABNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiDABNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:13:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AE1231922
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28410B822B1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71832C340ED;
        Fri,  1 Apr 2022 01:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648775487;
        bh=kPYuo0O3P1pMhQvBEEQcVJ3OAmVbxM9vWnBjNrOncrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hClwJ+lYs+R1QchPXW1nnSVLmD1IB/7eMQy0Bh11A5Kf9sRFBQoeUxLM5Q/BhJ2ga
         D7Q5EQhO2XI9cOw7YQSr46jQc10PrkAL+YSpGN5DW5402FOjYio/zBA5g5Ll+HwrTu
         AUYM3LdN97vcSg4IZ0wzn8HfNWgF5uYllmoKZeEQ=
Date:   Thu, 31 Mar 2022 18:11:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in
 memcg_reparent_list_lru_node()
Message-Id: <20220331181126.815cfe2b05b4281d32b7bf49@linux-foundation.org>
In-Reply-To: <YkVcbElWjomA7ofF@dhcp22.suse.cz>
References: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
        <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev>
        <20220331063956.5uqnab64cqnmcwyr@google.com>
        <YkVcbElWjomA7ofF@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 09:46:52 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Thu 31-03-22 06:39:56, Shakeel Butt wrote:
> > On Wed, Mar 30, 2022 at 07:48:45PM -0700, Roman Gushchin wrote:
> > > 
> > > 
> > [...]
> > > 
> > > 
> > > But honestly, I’d drop the original optimization together with
> > > the fix, if only there is no _real world_ data on the problem and
> > > the improvement. It seems like it has started as a nice simple
> > > improvement, but the race makes it complex and probably not worth
> > > the added complexity and fragility.
> > 
> > I agree with dropping the original optimization as it is not really
> > fixing an observed issue which may justify adding some complexity.
> 
> Completely agreed. The patch as it is proposed is not really acceptable
> IMHO and I have to say I am worried that this is not the first time we
> are in a situation when a follow up fixes or unrelated patches are
> growing in complexity to fit on top of a performance optimizations which
> do not refer to any actual numbers.

Yup.  I did this:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/list_lru.c: revert "mm/list_lru: optimize memcg_reparent_list_lru_node()"

405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
has subtle races which are proving ugly to fix.  Revert the original
optimization.  If quantitative testing indicates that we have a
significant problem here then other implementations can be looked at.

Fixes: 405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
Cc: Waiman Long <longman@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/list_lru.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/mm/list_lru.c~revert-1
+++ a/mm/list_lru.c
@@ -395,12 +395,6 @@ static void memcg_reparent_list_lru_node
 	struct list_lru_one *src, *dst;
 
 	/*
-	 * If there is no lru entry in this nlru, we can skip it immediately.
-	 */
-	if (!READ_ONCE(nlru->nr_items))
-		return;
-
-	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
 	 * we have to use IRQ-safe primitives here to avoid deadlock.
 	 */
_


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044C34ECD77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiC3TsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbiC3Tr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:47:57 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344331344
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:46:09 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648669567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hae66Cb8VIx5SH/Gz0qCBX+AdOg7deV3Pdd2/H0Qa6I=;
        b=k46LoI2EORebN/s8HlnPjBPRRuJ68pY8pb47D5eWAq5uknpgBthhos/yMWK2hKBemqOnYs
        vyj6rOAPs3KYtk2/+Zm32WkEdR/jQ7PgqLsfnL2Iq5qJeNyCql1pG/6L2RPUVBxoIH2Xnv
        UnR+jfplx/WzAbUmnLDTv9D511JRKp8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in
 memcg_reparent_list_lru_node()
Message-ID: <YkSzezKeXVBZJlIA@carbon.dhcp.thefacebook.com>
References: <20220330172646.2687555-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330172646.2687555-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 01:26:46PM -0400, Waiman Long wrote:
> Muchun Song found out there could be a race between list_lru_add()
> and memcg_reparent_list_lru_node() causing the later function to miss
> reparenting of a lru entry as shown below:
> 
> CPU0:                           CPU1:
> list_lru_add()
>     spin_lock(&nlru->lock)
>     l = list_lru_from_kmem(memcg)
>                                 memcg_reparent_objcgs(memcg)
>                                 memcg_reparent_list_lrus(memcg)
>                                     memcg_reparent_list_lru()
>                                         memcg_reparent_list_lru_node()
>                                             if (!READ_ONCE(nlru->nr_items))
>                                                 // Miss reparenting
>                                                 return
>     // Assume 0->1
>     l->nr_items++
>     // Assume 0->1
>     nlru->nr_items++
> 
> Though it is not likely that a list_lru_node that has 0 item suddenly
> has a newly added lru entry at the end of its life. The race is still
> theoretically possible.
> 
> With the lock/unlock pair used within the percpu_ref_kill() which is
> the last function call of memcg_reparent_objcgs(), any read issued
> in memcg_reparent_list_lru_node() will not be reordered before the
> reparenting of objcgs.
> 
> Adding a !spin_is_locked()/smp_rmb()/!READ_ONCE(nlru->nr_items) check
> to ensure that either the reading of nr_items is valid or the racing
> list_lru_add() will see the reparented objcg.
> 
> Fixes: 405cc51fc104 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

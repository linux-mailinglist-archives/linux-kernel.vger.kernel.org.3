Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559EF4E9F94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245528AbiC1TOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245522AbiC1TOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:14:46 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360766CB3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:13:05 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:12:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648494783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSJN++S6R+1y8yPPjj83792q6MSLXlCqzDvFYFEsGEo=;
        b=iOJhwpD/QsCM5J5Q/uDpzEWgOTG5feFqbnxhAGLtKWfIruNdOhuzlQkNh/pem1gs031yI8
        +vvLMbYInGjdd8RBYIrpO9893GbJaVC129NfdOqb0ZGGeroKVPFKD39u7i38g3Y9HA/ZIT
        EFxaSiXnxwddimLH/4mYTuKfyiINRxE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize
 memcg_reparent_list_lru_node()
Message-ID: <YkIIu7fmSKJ9YyLU@carbon.dhcp.thefacebook.com>
References: <20220309144000.1470138-1-longman@redhat.com>
 <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:06:03AM +0800, Muchun Song wrote:
> On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
> >
> > Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> > to be race free"), we are tracking the total number of lru
> > entries in a list_lru_node in its nr_items field.  In the case of
> > memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> > is 0.  We don't even need to take the nlru->lock as no new lru entry
> > could be added by a racing list_lru_add() to the draining src_idx memcg
> > at this point.
> 
> Hi Waiman,
> 
> Sorry for the late reply.  Quick question: what if there is an inflight
> list_lru_add()?  How about the following race?
> 
> CPU0:                               CPU1:
> list_lru_add()
>     spin_lock(&nlru->lock)
>     l = list_lru_from_kmem(memcg)
>                                     memcg_reparent_objcgs(memcg)
>                                     memcg_reparent_list_lrus(memcg)
>                                         memcg_reparent_list_lru()
>                                             memcg_reparent_list_lru_node()
>                                                 if (!READ_ONCE(nlru->nr_items))
>                                                     // Miss reparenting
>                                                     return
>     // Assume 0->1
>     l->nr_items++
>     // Assume 0->1
>     nlru->nr_items++
> 
> IIUC, we use nlru->lock to serialise this scenario.


Thank you for bringing this up, really cool race!

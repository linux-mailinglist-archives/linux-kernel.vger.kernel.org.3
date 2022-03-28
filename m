Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4E44E8B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiC1Bcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiC1Bcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:32:48 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A97186C3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:31:05 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e6650cde1bso132644177b3.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4641r8SZTuedo4C1thTlXbTbbt1bLOvhiOy/cUyPZQ=;
        b=7fJZpc2niPsuAHo3z+x/+07pZCkY8NgfaU303y8cfzGHQoXEpWPSWMoo5ltThQscZY
         /u8iO9FBL1NaWftS6CInv/HFWgfkjoP0AzQrK2AV6kxjwLSu4OLvs6VWGSRyvaQhjNYC
         +6NpZ95VUG5Vu69LG3kMaEeimK4ofB28mWN+oBX8xo8cqFiCRGondL7KWfK6IhGVqqqI
         8gSvyqliUBc9YoFLBqOei2enYDZ5NPR+2sYgaYZeMmWvuOWUOpXeB6CpaMx4yU2KmdMj
         2wNNRPbhx+F4I5VPMqD7GsJ5BmQreVI6mA5oZ1R5Dt4hGI5HknwvSM4N9qScIsaTUVJ3
         7KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4641r8SZTuedo4C1thTlXbTbbt1bLOvhiOy/cUyPZQ=;
        b=YBgpobJuvS/fkR1e2jEsEINp6z/ezi2hxQBATc2YNDop4aoAgA6vYWyU3oTvR5dwjp
         mgDkm5j9pcUOdrW255BaxGCxWyBSikOMFC4N0VDXsDbwAfUVH1BOjH559TP6QqH35ZdS
         U/25nOU9m/+sBgfHa6MkveuvOL7njmjodqeahNh4WtEUFBcXA5/NfwGnVbcuiC0nBu8/
         qbiDMxGmKaMWr1zwqUMPkBsJ79PWdzcezxQYTfheQpRNrAIqvIcYgbi002ONPGB/f2rY
         nJvAYXUe39TdZkHm+GJbGeoSaIEuP/GrdIKXXWxPHoihnNwkcKc26TJAZYMsnqzLeslX
         Tc4g==
X-Gm-Message-State: AOAM533SVEzi3XW2IX4wfyHpqMrzbxJnScqnsq5jR4qP0iPKBsffoVp4
        OhH87Yn2afQUxPNZh6ngBu9tptzslc2geke4obso4g==
X-Google-Smtp-Source: ABdhPJyb8Blm5SfG8iGY1muDDyNFv0UA2d1gLRSWFSCH4tDtt8KDu/lZWJdxw0ZpatQeOuQsk9JC8XIqW5/w8IjIE4k=
X-Received: by 2002:a0d:f685:0:b0:2e2:22e6:52d7 with SMTP id
 g127-20020a0df685000000b002e222e652d7mr22787293ywf.418.1648431064768; Sun, 27
 Mar 2022 18:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220328005736.2513727-1-longman@redhat.com>
In-Reply-To: <20220328005736.2513727-1-longman@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Mar 2022 09:30:28 +0800
Message-ID: <CAMZfGtU4-QCyW2WE5m6hokmFegkGq5DoZgjrnCos_-qY322usw@mail.gmail.com>
Subject: Re: [PATCH] mm/list_lru: Fix possible race in memcg_reparent_list_lru_node()
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 8:58 AM Waiman Long <longman@redhat.com> wrote:
>
> Muchun Song found out there could be a race between list_lru_add()
> and memcg_reparent_list_lru_node() causing the later function to miss
> reparenting of a lru entry as shown below:
>
> CPU0:                               CPU1:
> list_lru_add()
>      spin_lock(&nlru->lock)
>      l = list_lru_from_kmem(memcg)
>                                      memcg_reparent_objcgs(memcg)
>                                      memcg_reparent_list_lrus(memcg)
>                                          memcg_reparent_list_lru()
>                                              memcg_reparent_list_lru_node()
>                                                  if (!READ_ONCE(nlru->nr_items))
>                                                      // Miss reparenting
>                                                      return
>      // Assume 0->1
>      l->nr_items++
>      // Assume 0->1
>      nlru->nr_items++
>
> Though it is not likely that a list_lru_node that has 0 item suddenly
> has a newly added lru entry at the end of its life. The race is still
> theoretically possible.
>
> Adding a spin_is_locked() check will likely be enough for x86, but it
> is less certain for other arches with a more relaxed memory semantics
> like arcm64 and ppc. To avoid race, this patch moves the nr_items check
> to within the lock critical section.
>
> Fixes: 405cc51fc104 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
> Signed-off-by: Waiman Long <longman@redhat.com>

How about the following patch?  It is low overhead on x86_64. Even on
relaxed memory mode, I think it is also lower overhead since it avoid a
store operation to nlru->lock.

We do not need to insert a smp_wmb() into the list_lru_add() since
spin_lock() always implies at least a load acquiring semantics.

Thanks.

diff --git a/mm/list_lru.c b/mm/list_lru.c
index c669d87001a6..0e58374b629b 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -397,8 +397,11 @@ static void memcg_reparent_list_lru_node(struct
list_lru *lru, int nid,
        /*
         * If there is no lru entry in this nlru, we can skip it immediately.
         */
-       if (!READ_ONCE(nlru->nr_items))
-               return;
+       if (!READ_ONCE(nlru->nr_items)) {
+               smp_rmb();
+               if (!spin_is_locked(&nlru->lock))
+                       return;
+       }

        /*
         * Since list_lru_{add,del} may be called under an IRQ-safe lock,

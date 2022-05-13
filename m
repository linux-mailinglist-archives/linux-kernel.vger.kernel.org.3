Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9537B526937
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383074AbiEMS0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383056AbiEMS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:26:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A3BE19
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:26:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z126so7679983qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fyTxG3vRPARLhAf2qwVdCK49by1iieFxjF3cm5H3kbg=;
        b=JN3vj/2/8eGEf9jiKkowI0XVrGpXh8SmRzFgsk3cdXlm6iRbR2zHXSlqm7aVNKj5ip
         zRDvFrQoFa3ZGfJU/v27uSO46gcedrSzWA1QdKNyP+pqmtkiQHzBwrkMDhpHLZ2Q68nP
         eZmv53ao/AgNQl4ZAdnFDcyxN1m11o4n0aR+xe7kSH94tVk0bdh1exS8tTa4PEEUDw5P
         exI6qZJVYSBcNsQdwkmtJkbJN+PL+oWOB+FV+5kvv1zz/Y5spi8/Wesyu+oSFQvk5BmD
         HU2/HgYUYAaOc5eaYt2uzGw26qXin4klfvORGjmaOgcqpzkhKnKwdiz5Ola03AlxvH34
         wIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyTxG3vRPARLhAf2qwVdCK49by1iieFxjF3cm5H3kbg=;
        b=DX+GQdR8JRTKgKMrLF7sfp6m11y/gZTrtp40O5WbwSNBbGU1lsZ8AF5BKqJfRIUd+G
         OPqz8x0Di7+Mz7wCZOd3kzkdPY8QfL2KpqlONi/eMv91ws0ERKqfkwWOr33xAW7ezUMd
         adUikph5wJKa4sjdfQ8j6N1SeRLw7X2qnsaOMX7R2DTyiUa4qUIwnms73w583lM9lxUf
         gsmikrF7AWk8Z7AC0ygwFWIo+Wn9ZDrPKv4uIprXjtzVY2GOfc+W7z6mA6h38sTq1zPi
         UQd1YWsECZVDY7VGfLw7K3PyOsG94DzvhWSZgSTFETOOzDHUr8S054DVA1S+G21v1xeY
         Abkg==
X-Gm-Message-State: AOAM53106VdZlgTCEBf0yE3mK6UDzVfeO+Ss5nD/UPj8Ttjbnd0kqNDR
        PH9OF5zA3kl/be8W1q6WVwvEVw==
X-Google-Smtp-Source: ABdhPJxq9o8J9pvmIH0vD9Ym3AZUF5jrC76xskqWMwzN/dZ47ai4Ztg03RquxNAO2e6adfckee0zLw==
X-Received: by 2002:a05:620a:28cd:b0:69f:b40e:4980 with SMTP id l13-20020a05620a28cd00b0069fb40e4980mr4747496qkp.18.1652466361459;
        Fri, 13 May 2022 11:26:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id c5-20020ac81e85000000b002f39b99f690sm1865743qtm.42.2022.05.13.11.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 11:26:00 -0700 (PDT)
Date:   Fri, 13 May 2022 14:25:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-ID: <Yn6it9mBYFA+/lTb@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
 <CALvZod6kBZZFfD6Y5p_=9TMJr8P-vU_77NTq048wGUDr0wTv0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6kBZZFfD6Y5p_=9TMJr8P-vU_77NTq048wGUDr0wTv0Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shakeel,

On Fri, May 13, 2022 at 10:23:36AM -0700, Shakeel Butt wrote:
> On Tue, May 10, 2022 at 8:29 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> [...]
> > +void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
> > +{
> > +       struct mem_cgroup *memcg;
> > +
> > +       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> > +
> > +       /* PF_MEMALLOC context, charging must succeed */
> )
> Instead of these warnings and comment why not just explicitly use
> memalloc_noreclaim_[save|restore]() ?

Should the function be called from a non-reclaim context, it should
warn rather than quietly turn itself into a reclaimer. That's not a
very likely mistake, but the warning documents the expectations and
context of this function better.

> > +       if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
> 
> Can we please make this specific charging an opt-in feature or at
> least provide a way to opt-out? This will impact users/providers where
> swap is used transparently (in terms of memory usage). Also do you
> want this change for v1 users as well?

Ah, of course, memsw! Let's opt out of v1, since this is clearly in
conflict with that way of accounting. I already hadn't added interface
files for v1, so it's just a matter of bypassing the charging too.

Signed-of-by: Johannes Weiner <hannes@cmpxchg.org>
---

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 350012b93a95..3ab72b8160ee 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7469,6 +7469,9 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 	struct mem_cgroup *memcg, *original_memcg;
 	bool ret = true;
 
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return true;
+
 	original_memcg = get_mem_cgroup_from_objcg(objcg);
 	for (memcg = original_memcg; memcg != root_mem_cgroup;
 	     memcg = parent_mem_cgroup(memcg)) {
@@ -7505,6 +7508,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
 {
 	struct mem_cgroup *memcg;
 
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
 	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
 
 	/* PF_MEMALLOC context, charging must succeed */
@@ -7529,6 +7535,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 {
 	struct mem_cgroup *memcg;
 
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
 	obj_cgroup_uncharge(objcg, size);
 
 	rcu_read_lock();


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6312F58F9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiHKJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:09:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C6F8E9A7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:09:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92D6A20463;
        Thu, 11 Aug 2022 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660208992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogHa+KiM+lP+RnrQji6o/A/7B+pSIENIDsiGRYFdQV4=;
        b=f59bscZHABasVaivpCXZ8mqOezMBwxY7rljoxhkVBaGDH8c5PdZ58buL8oKRvkTtnQ3xvk
        wwLRlH9NXa/k3jKEdxzcQyUNJc4loDtLvc4KPuct77ytp9CMUGzMpeUVBXBu22ouGVfa+q
        3Kp+WjdKDxgD7O1+foB4h1ZrhBCmk4M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 797351342A;
        Thu, 11 Aug 2022 09:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HSjGGmDH9GLYZQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 11 Aug 2022 09:09:52 +0000
Date:   Thu, 11 Aug 2022 11:09:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix lock contention on mems_allowed
Message-ID: <YvTHX2Jijb8Z3LB5@dhcp22.suse.cz>
References: <20220809104927.44366-1-wuyun.abel@bytedance.com>
 <YvJO5uX0pSAh6weA@dhcp22.suse.cz>
 <7ece0714-2646-4f1a-60b6-aaafc1135b1e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ece0714-2646-4f1a-60b6-aaafc1135b1e@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-08-22 16:43:28, Abel Wu wrote:
> On 8/9/22 8:11 PM, Michal Hocko Wrote:
> > On Tue 09-08-22 18:49:27, Abel Wu wrote:
> > > The mems_allowed field can be modified by other tasks, so it
> > > isn't safe to access it with alloc_lock unlocked even in the
> > > current process context.
> > 
> > It would be useful to describe the racing scenario and the effect it
> > would have. 78b132e9bae9 hasn't really explained thinking behind and why
> > it was considered safe to drop the lock. I assume it was based on the
> > fact that the operation happens on the current task but this is hard to
> > tell.
> > 
> 
> Sorry for my poor description. Say there are two tasks: A from cpusetA
> is performing set_mempolicy(2), and B is changing cpusetA's cpuset.mems.
> 
>     A (set_mempolicy)		B (echo xx > cpuset.mems)
> 
>     pol = mpol_new();
> 				update_tasks_nodemask(cpusetA) {
> 				  foreach t in cpusetA {
> 				    cpuset_change_task_nodemask(t) {
> 				      task_lock(t); // t could be A
>     mpol_set_nodemask(pol) {
>       new = f(A->mems_allowed);
> 				      update t->mems_allowed;
>       pol.create(pol, new);
>     }
> 				      task_unlock(t);
>     task_lock(A);
>     A->mempolicy = pol;
>     task_unlock(A);
> 				    }
> 				  }
> 				}
> 
> In this case A's pol->nodes is computed by old mems_allowed, and could
> be inconsistent with A's new mems_allowed.
> 
> While it is different when replacing vmas' policy: the pol->nodes is
> gone wild only when current_cpuset_is_being_rebound():
> 
>     A (mbind)			B (echo xx > cpuset.mems)
> 
> 				cpuset_being_rebound = cpusetA;
> 				update_tasks_nodemask(cpusetA) {
> 				  foreach t in cpusetA {
> 				    cpuset_change_task_nodemask(t) {
> 				      task_lock(t); // t could be A
>     pol = mpol_new();
>     mmap_write_lock(A->mm);
>     mpol_set_nodemask(pol) {
>       mask = f(A->mems_allowed);
> 				      update t->mems_allowed;
>       pol.create(pol, mask);
>     }
> 				      task_unlock(t);
> 				    }
>     foreach v in A->mm {
>       if (current_cpuset_is_being_rebound())
>         pol.rebind(pol, cpuset.mems);
>       v->vma_policy = pol;
>     }
>     mmap_write_unlock(A->mm);
> 				    mmap_write_lock(t->mm);
> 				    mpol_rebind_mm(t->mm);
> 				    mmap_write_unlock(t->mm);
> 				  }
> 				}
> 				cpuset_being_rebound = NULL;
> 
> In this case, the cpuset.mems, which has already done updating, is
> finally used for calculating pol->nodes, rather than A->mems_allowed.
> So it is OK to call mpol_set_nodemask() with alloc_lock unlocked when
> doing mbind(2).

Please add this to the patch changelog.

Thanks!
-- 
Michal Hocko
SUSE Labs

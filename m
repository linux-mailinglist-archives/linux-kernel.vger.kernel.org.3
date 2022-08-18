Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E498597ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiHRG53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbiHRG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:57:27 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694976DF94
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:57:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660805844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9JWaZ+Pf+0lJTRMwBclTF/cLsLmXbQ/pjz4rtVLgyA=;
        b=vmswnGUGMWUucEFmUSB5GO9rLMbcxg45sdkXMf86ZY8aYc+Rqm6/g/qGftkBc3BPiK5tGB
        Jspoz9YhNhWN8BUeUpTS4914fD9jYzQX5Bxc3uZ/U9QL20QdtZsod26edTtCnq4aalb5RT
        t5kNsEQCegx7oVR6AOtOSW8xzdXhHSo=
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: fix lock contention on mems_allowed
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220811124157.74888-1-wuyun.abel@bytedance.com>
Date:   Thu, 18 Aug 2022 14:56:40 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B9112128-B471-4369-8FAF-088635FE5535@linux.dev>
References: <20220811124157.74888-1-wuyun.abel@bytedance.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 11, 2022, at 20:41, Abel Wu <wuyun.abel@bytedance.com> wrote:
> 
> The mems_allowed field can be modified by other tasks, so it isn't
> safe to access it with alloc_lock unlocked even in the current
> process context.
> 
> Say there are two tasks: A from cpusetA is performing set_mempolicy(2),
> and B is changing cpusetA's cpuset.mems:
> 
>  A (set_mempolicy)		B (echo xx > cpuset.mems)
>  -------------------------------------------------------
>  pol = mpol_new();
> 				update_tasks_nodemask(cpusetA) {
> 				  foreach t in cpusetA {
> 				    cpuset_change_task_nodemask(t) {
>  mpol_set_nodemask(pol) {
> 				      task_lock(t); // t could be A
>    new = f(A->mems_allowed);
> 				      update t->mems_allowed;
>    pol.create(pol, new);
> 				      task_unlock(t);
>  }
> 				    }
> 				  }
> 				}
>  task_lock(A);
>  A->mempolicy = pol;
>  task_unlock(A);
> 
> In this case A's pol->nodes is computed by old mems_allowed, and could
> be inconsistent with A's new mems_allowed.
> 
> While it is different when replacing vmas' policy: the pol->nodes is
> gone wild only when current_cpuset_is_being_rebound():
> 
>  A (mbind)			B (echo xx > cpuset.mems)
>  -------------------------------------------------------
>  pol = mpol_new();
>  mmap_write_lock(A->mm);
> 				cpuset_being_rebound = cpusetA;
> 				update_tasks_nodemask(cpusetA) {
> 				  foreach t in cpusetA {
> 				    cpuset_change_task_nodemask(t) {
>  mpol_set_nodemask(pol) {
> 				      task_lock(t); // t could be A
>    mask = f(A->mems_allowed);
> 				      update t->mems_allowed;
>    pol.create(pol, mask);
> 				      task_unlock(t);
>  }
> 				    }
>  foreach v in A->mm {
>    if (cpuset_being_rebound == cpusetA)
>      pol.rebind(pol, cpuset.mems);
>    v->vma_policy = pol;
>  }
>  mmap_write_unlock(A->mm);
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
> 
> Fixes: 78b132e9bae9 ("mm/mempolicy: remove or narrow the lock on current")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


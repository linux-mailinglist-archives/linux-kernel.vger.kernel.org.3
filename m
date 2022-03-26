Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF54E7E26
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiCZAap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 20:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCZAao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A43EA75F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC2ED617B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 00:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C29C2BBE4;
        Sat, 26 Mar 2022 00:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648254548;
        bh=AnJgnpPYiCm5oGyGAtaAtR44bfRlNgR5d1iIOGU/Fh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wluuJcBvB4K5JpO4od1HeDpdOd4INTC11C7xHzJZF7N0ZtWak2j1uXHelhzQC26bR
         Xdp5n+iQBdyeu4Anen+QGCjCF+/IbIgpk1L0yj2yj3YI/2HAKiuS+rUFwPbcvIx+iC
         Dybf4+chRqkGiZRRBrRFatwAP3JU+8vf4mreejYE=
Date:   Fri, 25 Mar 2022 17:29:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <mhocko@suse.com>, <kosaki.motohiro@jp.fujitsu.com>,
        <mgorman@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm/mempolicy: fix mpol_new leak in
 shared_policy_replace
Message-Id: <20220325172907.57dd381b746563be5dc77097@linux-foundation.org>
In-Reply-To: <20220322104345.36379-1-linmiaohe@huawei.com>
References: <20220322104345.36379-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 18:43:45 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> If mpol_new is allocated but not used in restart loop, mpol_new will be
> freed via mpol_put before returning to the caller.  But refcnt is not
> initialized yet, so mpol_put could not do the right things and might leak
> the unused mpol_new. This would happen if mempolicy was updated on the
> shared shmem file while the sp->lock has been dropped during the memory
> allocation.
> 
> This issue could be triggered easily with the below code snippet if there
> are many processes doing the below work at the same time:
> 
>   shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
>   shm = shmat(shmid, 0, 0);
>   loop many times {
>     mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
>     mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
>           maxnode, 0);
>   }
> 
> ...
>
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2733,6 +2733,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>  	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>  	if (!mpol_new)
>  		goto err_out;
> +	refcount_set(&mpol_new->refcnt, 1);
>  	goto restart;
>  }

Two other sites in this file do

	atomic_set(&policy->refcnt, 1);


Could we please instead have a little helper function which does the
kmem_cache_alloc()+refcount_set()?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5365908D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiHKXA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiHKXAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C4CC9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95FFF61559
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A23C433D6;
        Thu, 11 Aug 2022 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660258821;
        bh=zUD6ps9EUrGl2WNrqIea32JkQhG6EuoV7XvAvbJoKrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ON9OXYj/TbX1s1HgqO9bUsiHHWt8rQuxBUipZMXgHT3yXGwV01PTLeOqckMR4BWJv
         U4pLIg31s6mEApPAxBNCj2cfBUAva+zjwmG7Cm36E72SBmy+glSExnwXNzW6MTbuGH
         PLiM8VbItAZVdgxp2luh2gM2QPlclpL+92lD0vS4=
Date:   Thu, 11 Aug 2022 16:00:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@columbia.edu>,
        Gabriel Ryan <gabe@cs.columbia.edu>
Subject: Re: [PATCH] mm: ksm: fix data-race in __ksm_enter / run_store
Message-Id: <20220811160020.1e6823094217e8d6d3aaebdf@linux-foundation.org>
In-Reply-To: <20220802151550.159076-1-wangkefeng.wang@huawei.com>
References: <20220802151550.159076-1-wangkefeng.wang@huawei.com>
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

On Tue, 2 Aug 2022 23:15:50 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Abhishek reported a data-race issue,

OK, but it would be better to perform an analysis of the alleged bug,
describe the potential effects if the race is hit, etc.

> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2507,6 +2507,7 @@ int __ksm_enter(struct mm_struct *mm)
>  {
>  	struct mm_slot *mm_slot;
>  	int needs_wakeup;
> +	bool ksm_run_unmerge;
>  
>  	mm_slot = alloc_mm_slot();
>  	if (!mm_slot)
> @@ -2515,6 +2516,10 @@ int __ksm_enter(struct mm_struct *mm)
>  	/* Check ksm_run too?  Would need tighter locking */
>  	needs_wakeup = list_empty(&ksm_mm_head.mm_list);
>  
> +	mutex_lock(&ksm_thread_mutex);
> +	ksm_run_unmerge = !!(ksm_run & KSM_RUN_UNMERGE);
> +	mutex_unlock(&ksm_thread_mutex);
>
>  	spin_lock(&ksm_mmlist_lock);
>  	insert_to_mm_slots_hash(mm, mm_slot);
>  	/*
> @@ -2527,7 +2532,7 @@ int __ksm_enter(struct mm_struct *mm)
>  	 * scanning cursor, otherwise KSM pages in newly forked mms will be
>  	 * missed: then we might as well insert at the end of the list.
>  	 */
> -	if (ksm_run & KSM_RUN_UNMERGE)
> +	if (ksm_run_unmerge)

run_store() can alter ksm_run right here, so __ksm_enter() is still
acting on the old setting?

>  		list_add_tail(&mm_slot->mm_list, &ksm_mm_head.mm_list);
>  	else
>  		list_add_tail(&mm_slot->mm_list, &ksm_scan.mm_slot->mm_list);


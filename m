Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E5E53D839
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbiFDS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiFDS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 14:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC64F47D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 11:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25BA60F7A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 18:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E46BC385B8;
        Sat,  4 Jun 2022 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654368977;
        bh=cQb6UkaGXt9FYonsLJxY8W4duDAXDhvFNy6evcEDD2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nrww3VMlwpkgWsmsFblPZpuVD5vJl0OksZpNd+fhu0fCnOG9Wgi2ld00UDPt2pDVm
         Py/Vb9WCmzLwSpaG8+38Ku0qXFcMbmOXYtbMDp9gMQl0Ru3LgDgZBcPmm0zPDBgf76
         d2QNDnBZjhYxX0IJ9ip7x5WIb81TNQdpyFMBAlDM=
Date:   Sat, 4 Jun 2022 11:56:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted
 page
Message-Id: <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
In-Reply-To: <20220604103229.3378591-1-pizhenwei@bytedance.com>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jun 2022 18:32:29 +0800 zhenwei pi <pizhenwei@bytedance.com> wrote:

> Currently unpoison_memory(unsigned long pfn) is designed for soft
> poison(hwpoison-inject) only. Unpoisoning a hardware corrupted page
> puts page back buddy only, this leads BUG during accessing on the
> corrupted KPTE.
> 
> Do not allow to unpoison hardware corrupted page in unpoison_memory()
> to avoid BUG like this:
> 
>  Unpoison: Software-unpoisoned page 0x61234
>  BUG: unable to handle page fault for address: ffff888061234000

Thanks.

> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
>  {
>  	struct page *page;
>  	struct page *p;
> +	pte_t *kpte;
>  	int ret = -EBUSY;
>  	int freeit = 0;
>  	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
> @@ -2101,6 +2102,13 @@ int unpoison_memory(unsigned long pfn)
>  	p = pfn_to_page(pfn);
>  	page = compound_head(p);
>  
> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
> +	if (kpte && !pte_present(*kpte)) {
> +		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
> +				 pfn, &unpoison_rs);
> +		return -EPERM;
> +	}
> +
>  	mutex_lock(&mf_mutex);
>  
>  	if (!PageHWPoison(p)) {

I guess we don't want to let fault injection crash the kernel, so a
cc:stable seems appropriate here.

Can we think up a suitable Fixes: commit?  I'm suspecting this bug has
been there for a long time?


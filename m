Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CF51D3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390295AbiEFI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390284AbiEFI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:59:26 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B15DD01
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:55:41 -0700 (PDT)
Date:   Fri, 6 May 2022 17:55:32 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651827340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAUW0vSgJcAftQD8gzfhfsgS87APTTZohbWrvT0aZGc=;
        b=vVcRx4Q1/7tV3fymAg7pwv6CQFfOuPeqMnQmsIIHvuQDmG7uoL/PbuWU0rymoy71tXjBwF
        xasqAW8jXWf/GIaRFr6Bf9I5rTVe3knV+N9GpPxP6JeP9KmDz3nKxKBVBf8l2v6D5OoSvt
        H2z7/mRKiBC4umQOwN+sItNdk+/wNxM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 1/4] mm/memory-failure.c: move clear_hwpoisoned_pages
Message-ID: <20220506085532.GA1356094@u2004>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429142206.294714-2-pizhenwei@bytedance.com>
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

On Fri, Apr 29, 2022 at 10:22:03PM +0800, zhenwei pi wrote:
> clear_hwpoisoned_pages() clears HWPoison flag and decreases the number
> of poisoned pages, this actually works as part of memory failure.
> 
> Move this function from sparse.c to memory-failure.c, finally there
> is no CONFIG_MEMORY_FAILURE in sparse.c.
> 
> Cc: Wu Fengguang <fengguang.wu@intel.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  mm/internal.h       | 11 +++++++++++
>  mm/memory-failure.c | 21 +++++++++++++++++++++
>  mm/sparse.c         | 27 ---------------------------
>  3 files changed, 32 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index cf16280ce132..e8add8df4e0f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -758,4 +758,15 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>  
>  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> +/*
> + * mm/memory-failure.c
> + */
> +#ifdef CONFIG_MEMORY_FAILURE
> +void clear_hwpoisoned_pages(struct page *memmap, int nr_pages);
> +#else
> +static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> +{
> +}
> +#endif

This code may be put near the definitions of hwpoison_filter* in mm/internal.h
because they are also called from mm/memory-failure.

Otherwise, looks good to me.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

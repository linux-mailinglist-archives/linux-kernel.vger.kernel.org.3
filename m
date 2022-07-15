Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F285758F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiGOBE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiGOBEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:04:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6615A34
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C96D62102
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C7BC34114;
        Fri, 15 Jul 2022 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657847059;
        bh=iC+3ZL16iBagFhzCdlpt5bH1iSUd0rocVNjEoKGCV4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fpQp92FOWBykue2b6vHYA0GcjXfSWzoxZ+pN3sSXyvTIKKHyJUhZLn8Fw5p/cXO/y
         E0KCqNVVQ86nM2YvevqL1wYSKOaRVua2VZFSdGoS66HTBC/aJ7IMWy+kofwD9yNUVq
         P8AOaoklubL6trtsj2Gs8ARoz1rF8qROuD+DllU4=
Date:   Thu, 14 Jul 2022 18:04:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <pasha.tatashin@soleen.com>, <sjpark@amazon.de>,
        <sieberf@amazon.com>, <shakeelb@google.com>, <dhowells@redhat.com>,
        <willy@infradead.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <david@redhat.com>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-Id: <20220714180418.6d546650b3e5ae745f09814d@linux-foundation.org>
In-Reply-To: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
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

On Thu, 14 Jul 2022 20:17:43 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.
> 
> ...
>
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -64,6 +64,25 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
>  	return next;
>  }
>  
> +static inline struct page_ext *get_page_ext(struct page *page)
> +{
> +	struct page_ext *page_ext;
> +
> +	rcu_read_lock();

If page_ext.h is to call rcu functions then it will need to include
appropriate header files.

> +	page_ext = lookup_page_ext(page);
> +	if (!page_ext) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +
> +	return page_ext;
> +}
> +
> +static inline void put_page_ext(void)
> +{
> +	rcu_read_unlock();
> +}

Better names would be page_ext_get() and page_ext_put().  The rest of
the page_ext API appears to have got this right, so let's not mess that
up.

Also, these aren't really get and put functions - page_ext doesn't have
a refcount.  But I can't immediately think of a name that better
communicates what we're doing here so I guess get and put will do.

And are we able to add some comments here explaining why these
functions exist and what they do?

>  #else /* !CONFIG_PAGE_EXTENSION */
>  struct page_ext;

Are you sure we didn't need CONFIG_PAGE_EXTENSION=n stubs for these two
functions?



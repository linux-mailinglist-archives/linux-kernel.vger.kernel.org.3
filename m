Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A234F51B4C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiEEAqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiEEAp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:45:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D01D0F1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T7WIlBgKui0D1mjEUcKRlP2dzC8kLdnUcd6Fq6x/GF0=; b=N3kQHbKSAbBc2NOv/bkgKV6Z6d
        JZvcFXiUIyY9tAbssoBagG+2VxnscEZaZ+Ym2LfwqbEMO0FIqO2i5qYQFQczNEB/ukzFoZH0aXiah
        rbABlw4f2SV0ScO9wIYepG7a8PF/BxpnxXOZwEiXUz6EKmSy+XbVBsgTvONTLCqVz3/VU0BSOGMnf
        jXvTY2wUA7ciDsa7RIq80R6gzvFClpf14zwJzBORvdkBeWqRXFovogiZb2oGBaEx/11Oac190dVzV
        LM5yU7/APG4+mkxqqO9HVEnWcH+mdpbFWApQVeqBXfCHjXA+5yJYnVqVap62hL9xRabJIOTmbNGEP
        unamjuYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmPZR-00H83f-Ks; Thu, 05 May 2022 00:42:17 +0000
Date:   Thu, 5 May 2022 01:42:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnMdaW67GEDF0Ynr@casper.infradead.org>
References: <20220503170341.1413961-1-minchan@kernel.org>
 <YnHzvV2Uz2ynENnG@casper.infradead.org>
 <YnIBbjRYACzvuZpp@google.com>
 <YnIYofrw/GGEvc0U@casper.infradead.org>
 <YnKhLX+jzJc+2KwB@google.com>
 <YnKwBeRAWwIlEVqy@casper.infradead.org>
 <YnMQp/zJVHu9Qq/S@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnMQp/zJVHu9Qq/S@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:47:51PM -0700, Minchan Kim wrote:
> Since this patch introduces a new "contended" field as out param
> in rmap_walk_control, it's not immutable any longer so remove
> const keywords on rmap related functions. Since rmap walking
> is already expensive operation, I doubt the const would help sizable
> benefit(And we didn't have it until 5.17).

Um?  If it's now mutable, it surely can't be static as that means it
would be shared by all callers, and you might write to the new fields
in one caller and have them interpreted by the other caller!

Or if it is safe, then the comment needs to not be deleted, but modified
to explain why it's safe to do so in this instance, and that other
instances should not copy the approach unless they are similarly safe.

> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index fc0435abf909..fdff8c6dcd2d 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -86,11 +86,8 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
>  static void page_idle_clear_pte_refs(struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
> -	/*
> -	 * Since rwc.arg is unused, rwc is effectively immutable, so we
> -	 * can make it static const to save some cycles and stack.
> -	 */
> -	static const struct rmap_walk_control rwc = {
> +
> +	static struct rmap_walk_control rwc = {
>  		.rmap_one = page_idle_clear_pte_refs_one,
>  		.anon_lock = folio_lock_anon_vma_read,
>  	};

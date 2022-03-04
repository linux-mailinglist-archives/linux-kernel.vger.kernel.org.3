Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A464CCC95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiCDEgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiCDEf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:35:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8D17CC5F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o8PNL9ZIwccsqEW2LF/MiptJ7ri8E0HFY89rO2s9DaI=; b=cP8Vf0EaQl8V+qJsxxrzil+nbY
        kyyllCQIOP9fXghpU2YnWbNV8R//Gwynqi3tfZC1lwb7JDlNCXh3eQnO3rITMtuC3yIJjug8zQp8/
        hKZhqCXN2Uui3RMoUb/8Me7g7bJibYoggbbiXsap/AYDSsXuhonsjRo4udctqxuJeBo6b8PDnMhLs
        iP4xkmPCfYzmF8FshO5IYlmtHZuY46ib3shUnTznsab0xV5ucRwKuhgftCYyALvGf1aJRITJGROJk
        JCpgNCVEG6o6UBgPVfr/frqNpfaHjsHm6WfOHey7FjNoop3avRdM0mtF0rW/fQnE1wvc8VCN9qqmR
        sGyFWdhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPzei-00CI7B-It; Fri, 04 Mar 2022 04:35:04 +0000
Date:   Fri, 4 Mar 2022 04:35:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: filemap_unaccount_folio() large skip mapcount
 fixup
Message-ID: <YiGW+J4EtjK7KgYn@casper.infradead.org>
References: <879c4426-4122-da9c-1a86-697f2c9a083@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <879c4426-4122-da9c-1a86-697f2c9a083@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 08:21:19PM -0800, Hugh Dickins wrote:
> The page_mapcount_reset() when folio_mapped() while mapping_exiting()
> was devised long before there were huge or compound pages in the cache.
> It is still valid for small pages, but not at all clear what's right to
> check and reset on large pages.  Just don't try when folio_test_large().

Thanks for bringing this up!  I was really unsure about this chunk of code
when converting unaccount_page_cache_page() to filemap_unaccount_folio().

Part of me wants to just delete the whole thing.  I'm unconvinced by
the argument; surely it's better to leak memory than perhaps reuse a
page which should not have been freed yet?

Also, the code doesn't take into account that folio_mapped() is freaking
expensive for THP (512 cache lines, blowing away 32kB of your L1 cache!),
and we may as well calculate folio_mapcount() while we're doing it.

Do you see this report often on machines that don't have
VM_BUG_ON_FOLIO() enabled?

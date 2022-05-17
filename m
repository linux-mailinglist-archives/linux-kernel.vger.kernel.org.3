Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1320952AEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiEQX7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiEQX65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015C3F882
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18875614C3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E77C385B8;
        Tue, 17 May 2022 23:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652831935;
        bh=Hi3SLGJSw+umom2b/a7ZHSBRqMcZS2fHfT6dXxjlDwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SzTmjKne7gDTvPDvUODt/tsTdkLXvjcyvkshYpnsfUmT4zexyQ5Zmpd4iTuAMH/uM
         sNhczWysegNmvcnGVoamaZxTyDFbd5/vv9a2VW5oOU5MSIXajUVtrqqOuGA1oL9uVV
         f1qd9e4JpM3sH3Yihnc44dW8PNRApap0EpjRRj9U=
Date:   Tue, 17 May 2022 16:58:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-Id: <20220517165854.fa6810576db304428b275385@linux-foundation.org>
In-Reply-To: <YnNqeB5tUf6LZ57b@google.com>
References: <20220503170341.1413961-1-minchan@kernel.org>
        <YnHzvV2Uz2ynENnG@casper.infradead.org>
        <YnIBbjRYACzvuZpp@google.com>
        <YnIYofrw/GGEvc0U@casper.infradead.org>
        <YnKhLX+jzJc+2KwB@google.com>
        <YnKwBeRAWwIlEVqy@casper.infradead.org>
        <YnMQp/zJVHu9Qq/S@google.com>
        <YnMdaW67GEDF0Ynr@casper.infradead.org>
        <YnNqeB5tUf6LZ57b@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 23:11:04 -0700 Minchan Kim <minchan@kernel.org> wrote:

> > > +
> > > +	static struct rmap_walk_control rwc = {
> > >  		.rmap_one = page_idle_clear_pte_refs_one,
> > >  		.anon_lock = folio_lock_anon_vma_read,
> > >  	};
> 
> So, delta is

--- a/mm/page_idle.c~mm-dont-be-stuck-to-rmap-lock-on-reclaim-path-fix
+++ a/mm/page_idle.c
@@ -87,6 +87,10 @@ static void page_idle_clear_pte_refs(str
 {
 	struct folio *folio = page_folio(page);
 
+	/*
+	 * Since rwc.try_lock is unused, rwc is effectively immutable, so we
+	 * can make it static to save some cycles and stack.
+	 */
 	static struct rmap_walk_control rwc = {
 		.rmap_one = page_idle_clear_pte_refs_one,
 		.anon_lock = folio_lock_anon_vma_read,
_

and with that, I believe this change is good to be imported into mm-stable
later this week.


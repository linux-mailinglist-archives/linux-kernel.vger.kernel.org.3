Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF02553E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354218AbiFUW3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353136AbiFUW3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4D165AA;
        Tue, 21 Jun 2022 15:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0288F6172C;
        Tue, 21 Jun 2022 22:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07347C3411C;
        Tue, 21 Jun 2022 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655850539;
        bh=v/bPfL+wicBxL4Cwn7dvyPEgySC6Ary5WdDIT4LuuH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7HL8fiSNh2nVOnGhaLT5mzFKGO0bFhfX8xmizxycfuBJD6OReItV2Ye2lESwbFDM
         WQQnyIYKrp6ZHbSfcJVahfARMxD0JhrSDAHbdfdFZj4DKsFBlc7HR8gZf87UtxNVIr
         zH5mlNbi2C1qH/6F7bOQXvXuBm8pgOPeWsesOEq0=
Date:   Tue, 21 Jun 2022 15:28:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: linux-next: build failures after merge of the mm tree
Message-Id: <20220621152845.16c801b4efd747173dc08559@linux-foundation.org>
In-Reply-To: <YrB7Vq/WlGK99fxz@casper.infradead.org>
References: <20220620164246.0d3f7784@canb.auug.org.au>
        <CAMZfGtWmGOr1LRBnKGVeqP8p47xyaA0ny_rotdHmgLx8DOk6xg@mail.gmail.com>
        <YrB7Vq/WlGK99fxz@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 20 Jun 2022 14:51:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Jun 20, 2022 at 03:11:31PM +0800, Muchun Song wrote:
> > Thanks for your report. It is fixed in thread [1].
> > 
> > https://lore.kernel.org/all/20220619133851.68184-3-songmuchun@bytedance.com/ [1]
> 
> No, it's a different problem.  I suggest dropping/reverting
> 
> https://lore.kernel.org/linux-mm/20220617175020.717127-20-willy@infradead.org/

Dropping that creates awkwardness.  How about just uninlining it?

--- a/include/linux/mm.h~mm-convert-destroy_compound_page-to-destroy_large_folio-fix
+++ a/include/linux/mm.h
@@ -923,13 +923,7 @@ static inline void set_compound_page_dto
 	page[1].compound_dtor = compound_dtor;
 }
 
-static inline void destroy_large_folio(struct folio *folio)
-{
-	enum compound_dtor_id dtor = folio_page(folio, 1)->compound_dtor;
-
-	VM_BUG_ON_FOLIO(dtor >= NR_COMPOUND_DTORS, folio);
-	compound_page_dtors[dtor](&folio->page);
-}
+void destroy_large_folio(struct folio *folio);
 
 static inline int head_compound_pincount(struct page *head)
 {
--- a/mm/page_alloc.c~mm-convert-destroy_compound_page-to-destroy_large_folio-fix
+++ a/mm/page_alloc.c
@@ -822,6 +822,14 @@ void prep_compound_page(struct page *pag
 	prep_compound_head(page, order);
 }
 
+void destroy_large_folio(struct folio *folio)
+{
+	enum compound_dtor_id dtor = folio_page(folio, 1)->compound_dtor;
+
+	VM_BUG_ON_FOLIO(dtor >= NR_COMPOUND_DTORS, folio);
+	compound_page_dtors[dtor](&folio->page);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 unsigned int _debug_guardpage_minorder;
 
_


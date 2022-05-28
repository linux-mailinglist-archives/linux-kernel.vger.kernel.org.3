Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98E536A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 05:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiE1DOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 23:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiE1DN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 23:13:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D9F5DBE1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QAV4mbxWazsO8YI+Vd3NhlfoJMrxEgaww3Nl7Ft7sy4=; b=ZpwWawJzT58qGKFSMIk13M/5FC
        9p4UrV/OxAVmLzgYIuRYwdT1bWDnNot5OeYhdm+Bidr0fiKQ4CWpAUqywxsPJL4hpnKnEq4XSl4Rp
        A1qPMJzt5ONRDli75IUUaJ5+UD/EmHRx+l10pLYlD3C5LjTEvAyXZypMh+mEASRLXAO6bNg7y84C1
        g1YCoV+Tgqsfglro7Ukg9ZATC4hWSk3gz9AaDNsxpj4H8NptO6gq264WTDZeC/gOWudy2FIC5LQDy
        BSrL19E88Vvriw39YyroU4Lsta6eqdaSSwC8q6l/O4bUooCm5Kc/Q7aRrdYP6dRI5zdEnYgyVQxeX
        +m8jRzPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1numtc-002Zpk-19; Sat, 28 May 2022 03:13:44 +0000
Date:   Sat, 28 May 2022 04:13:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: don't try to reclaim freed folios
Message-ID: <YpGTaCf+bZGdEdNj@casper.infradead.org>
References: <20220527080451.48549-1-linmiaohe@huawei.com>
 <YpDoAZtQtQf6U8D2@casper.infradead.org>
 <e0502c7c-b71d-5356-fcc3-7c048c25d827@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0502c7c-b71d-5356-fcc3-7c048c25d827@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 10:52:11AM +0800, Miaohe Lin wrote:
> On 2022/5/27 23:02, Matthew Wilcox wrote:
> > What?  No.  This can absolutely happen.  We have a refcount on the folio,
> > which means that any other thread can temporarily raise the refcount,
> 
> IIUC, the folio is only in the isolated page_list now and it's not in the page cache, swap cache, pagetable or
> under any use. So there should be no way that any other thread can temporarily raise the refcount when
> folio_ref_count == 1. Or am I miss something?

Take a look at something like GUP (fast).  If this page _was_ mapped to
userspace, something like this can happen:

Thread A	Thread B
load PTE
		unmap page
		refcount goes to 1
		vmscan sees the page
try_get_ref
		refcount is now 2.  WARN_ON.

Thread A will see that the PTE has changed and will now drop its
reference, but Thread B already spat out the WARN.

A similar thing can happen with the page cache.

If this is a worthwhile optimisation (does it happen often that we find
a refcount == 1 page?), we could do something like ...

		if (folio_ref_freeze(folio, 1)) {
			nr_pages = folio_nr_pages(folio);
			goto free_it;
		}

... or ...

		if (folio_ref_count(folio) == 1 &&
		    folio_ref_freeze(folio, 1)) {

... if we want to test-and-test-and-clear

But this function is far too complicated already.  I really want to
see numbers that proves the extra complexity is worth it.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71FB52AEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiEQXjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiEQXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF76532F3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06BFAB81C08
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B56C34113;
        Tue, 17 May 2022 23:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652830761;
        bh=DYhSZ/O62I4Crb1ZNQ+ZR5YdD+tNOlwAMSsZrQo5gN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DZeoPPF1nzwVDzxfgvPZDVO3laua5IfcOil2yyYQ2JJ1pjuVYW+IFsFJfb53rPHqf
         gCfzsFxqx351DjibuG96lay3Uj4JO1eb60m10BRWi1zIkH7efSBOmyF6mI+v9bQzQx
         fOLMmO2DB5aZ2GcNhNV7dwhXa6EplqpPqyOo6yaQ=
Date:   Tue, 17 May 2022 16:39:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <neilb@suse.de>,
        <apopple@nvidia.com>, <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/15] mm/swap: fix the comment of get_kernel_pages
Message-Id: <20220517163920.f38bca025e9c8cf946815b11@linux-foundation.org>
In-Reply-To: <639dfeab-d81b-3da1-1da4-52447c8a6b95@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
        <20220509131416.17553-15-linmiaohe@huawei.com>
        <3f9e663a-2045-81d1-509e-abbe0e1fa14e@redhat.com>
        <639dfeab-d81b-3da1-1da4-52447c8a6b95@huawei.com>
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

On Fri, 13 May 2022 14:15:38 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/5/12 21:45, David Hildenbrand wrote:
> > On 09.05.22 15:14, Miaohe Lin wrote:
> >> If no pages were pinned, 0 is returned in fact. Fix the corresponding
> >> comment.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/swap.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/swap.c b/mm/swap.c
> >> index 6d2c37f781f8..236b37663a1a 100644
> >> --- a/mm/swap.c
> >> +++ b/mm/swap.c
> >> @@ -168,8 +168,8 @@ EXPORT_SYMBOL(put_pages_list);
> >>   *
> >>   * Returns number of pages pinned. This may be fewer than the number
> >>   * requested. If nr_pages is 0 or negative, returns 0. If no pages
> > 
> > Ehm, there is only "nr_segs", no "nr_pages" :/ Want to fix that up in
> > the same patch?
> 
> Will do.

I also reflowed that comment to use more columns.

--- a/mm/swap.c~mm-swap-fix-the-comment-of-get_kernel_pages-fix
+++ a/mm/swap.c
@@ -166,10 +166,10 @@ EXPORT_SYMBOL(put_pages_list);
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_segs long.
  *
- * Returns number of pages pinned. This may be fewer than the number
- * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns 0. Each page returned must be released with
- * a put_page() call when it is finished with.
+ * Returns number of pages pinned. This may be fewer than the number requested.
+ * If nr_segs is 0 or negative, returns 0.  If no pages were pinned, returns 0.
+ * Each page returned must be released with a put_page() call when it is
+ * finished with.
  */
 int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
 		struct page **pages)
_


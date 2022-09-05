Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BEE5ADAF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiIEVxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiIEVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C765257
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64DFC60CEE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19563C4347C;
        Mon,  5 Sep 2022 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662414803;
        bh=AKN1Agn0Tca6FkpXEwU5FrzZmOkXj0VB4xT45aQM93Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LcbiTqV5sTp3yI0mWjjB7JBMUl2kFdVNwvP1A1eT3jjJ4gJ0jP8Vci9fVxuTWxxSU
         0QANgF+gFm0Vy74tRf1joY9vlUmObLhNyFwo196L6z578gWOhpcm6Z9Xj/tSOX8Jh/
         DaMfYNBogIl9nxju0OgWh7kX5mVt7BKTTYgk16rI=
Date:   Mon, 5 Sep 2022 14:53:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?ISO-8859-1?Q?NAOYA?= (=?UTF-8?Q?=E5=A0=80=E5=8F=A3_?=
        =?UTF-8?Q?=E7=9B=B4=E4=B9=9F?=) <naoya.horiguchi@nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] mm, hwpoison: use __PageMovable() to detect non-lru
 movable pages
Message-Id: <20220905145322.42d218d0d7d32d3c5f515027@linux-foundation.org>
In-Reply-To: <f2a52dd2-5792-0c45-3ae6-c1bcf547762c@huawei.com>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
        <20220830123604.25763-3-linmiaohe@huawei.com>
        <20220905052243.GA1355682@hori.linux.bs1.fc.nec.co.jp>
        <1f7ee86e-7d28-0d8c-e0de-b7a5a94519e8@huawei.com>
        <20220905071542.GA1364147@hori.linux.bs1.fc.nec.co.jp>
        <f2a52dd2-5792-0c45-3ae6-c1bcf547762c@huawei.com>
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

On Mon, 5 Sep 2022 15:29:34 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> The above code change could be applied to the mm-tree directly. Or should I resend
> the v2 series? Which one is more convenient for you? They're all fine to me. ;)

I got it, thanks.

From: Miaohe Lin <linmiaohe@huawei.com>
Subject: mm-hwpoison-use-__pagemovable-to-detect-non-lru-movable-pages-fix
Date: Mon, 5 Sep 2022 14:53:41 +0800

fixes per Naoya Horiguchi

Link: https://lkml.kernel.org/r/1f7ee86e-7d28-0d8c-e0de-b7a5a94519e8@huawei.com
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory-failure.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/mm/memory-failure.c~mm-hwpoison-use-__pagemovable-to-detect-non-lru-movable-pages-fix
+++ a/mm/memory-failure.c
@@ -2404,24 +2404,26 @@ EXPORT_SYMBOL(unpoison_memory);
 static bool isolate_page(struct page *page, struct list_head *pagelist)
 {
 	bool isolated = false;
-	bool lru = !__PageMovable(page);
 
 	if (PageHuge(page)) {
 		isolated = !isolate_hugetlb(page, pagelist);
 	} else {
+		bool lru = !__PageMovable(page);
+
 		if (lru)
 			isolated = !isolate_lru_page(page);
 		else
-			isolated = !isolate_movable_page(page, ISOLATE_UNEVICTABLE);
+			isolated = !isolate_movable_page(page,
+							 ISOLATE_UNEVICTABLE);
 
-		if (isolated)
+		if (isolated) {
 			list_add(&page->lru, pagelist);
+			if (lru)
+				inc_node_page_state(page, NR_ISOLATED_ANON +
+						    page_is_file_lru(page));
+		}
 	}
 
-	if (isolated && lru)
-		inc_node_page_state(page, NR_ISOLATED_ANON +
-				    page_is_file_lru(page));
-
 	/*
 	 * If we succeed to isolate the page, we grabbed another refcount on
 	 * the page, so we can safely drop the one we got from get_any_pages().
_


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2124B53BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355357AbiBNOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:50:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBNOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:50:33 -0500
X-Greylist: delayed 173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 06:50:26 PST
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC94C7A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:50:25 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:50:19 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644850224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6uiMGBxoN7l/Xu87OWN9A7aEPeNg8ZMf78cUU3cM7s=;
        b=gLdV7l4kjK36aWTwPyKcNIfYbY3uFHSKKhhoZBPFv9Mklj6FF76jReocMd79rjSgRevGQV
        Fm0Ps34bkaWTiH3AZ1QVRU7uWrgW9SCfcZ+YeCWECa8iOZpgzXonUi1dCatL4utw2Wo7Wk
        QgyE9QXzJNUdVNWw1IINYGJDZZuLiy8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mm/memory-failure.c: remove unneeded orig_head
Message-ID: <20220214145019.GD2624914@u2004>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210141733.1908-5-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:17:29PM +0800, Miaohe Lin wrote:
> orig_head is used to check whether the page have changed compound pages
> during the locking. But it's always equal to hpage. So we can use hpage
> directly and remove this redundant one.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2dd7f35ee65a..4370c2f407c5 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1691,7 +1691,6 @@ int memory_failure(unsigned long pfn, int flags)
>  {
>  	struct page *p;
>  	struct page *hpage;
> -	struct page *orig_head;
>  	struct dev_pagemap *pgmap;
>  	int res = 0;
>  	unsigned long page_flags;
> @@ -1737,7 +1736,7 @@ int memory_failure(unsigned long pfn, int flags)
>  		goto unlock_mutex;
>  	}
> 
> -	orig_head = hpage = compound_head(p);
> +	hpage = compound_head(p);
>  	num_poisoned_pages_inc();
> 
>  	/*
> @@ -1821,7 +1820,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	 * The page could have changed compound pages during the locking.
>  	 * If this happens just bail out.
>  	 */
> -	if (PageCompound(p) && compound_head(p) != orig_head) {
> +	if (PageCompound(p) && compound_head(p) != hpage) {

I think that this if-check was intended to detect the case that page p
belongs to a thp when memory_failure() is called and belongs to a compound
page in different size (like slab or some driver page) after the thp is
split.  But your suggestion makes me aware that the page p could be embedded
on a thp again after thp split.  I think this might be rare, but if it
happens the current if-check (or suggested one) cannot detect it.
So I feel that simply dropping compound_head() check might be better?

-	if (PageCompound(p) && compound_head(p) != orig_head) {
+	if (PageCompound(p)) {

This should ensure the assumption (mentioned in 8/8 patch) more that
the error page never belongs to compound page after taking page lock.

Thanks,
Naoya Horiguchi

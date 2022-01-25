Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30D449B90A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451470AbiAYQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:44:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584756AbiAYQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:40:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05CB21F38A;
        Tue, 25 Jan 2022 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643128819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaT5yS0WIOg+/sXBG6KxbDZck9FEnOBGOKxMbfVHD7A=;
        b=BwMmViNljIgkYsxMmwoUUOHvsw70vBp1Dat2vAEUCJzUAgvs7G+CJi+6Wh6SCVifZXfuH4
        nq5ycw0Qgyb5y3OUqOzDKqES+ESdGiKmtmo1DpRTEouqk8ajB+WSpSf68yHrkxTnvmPFGt
        y2OBa6iNyFJ6dUuJctbvLitjFs1I/NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643128819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaT5yS0WIOg+/sXBG6KxbDZck9FEnOBGOKxMbfVHD7A=;
        b=5qugXxX3c+kIqj3wrE4G5dEDqiFLrXFYploVMId5Vnw5acH329Vu/kKRcTzg9p2oW1qn+N
        YdYoWxkKLCGO2mCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D29EC13E4B;
        Tue, 25 Jan 2022 16:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fWkkMvIn8GF6OgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 25 Jan 2022 16:40:18 +0000
Message-ID: <b1966d11-e874-c71e-d14f-c0c88ace297e@suse.cz>
Date:   Tue, 25 Jan 2022 17:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        guillaume.tucker@collabora.com
References: <20220117142712.3967624-1-chenwandun@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Cc:     regressions@lists.linux.dev, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] Revert "mm/page_isolation: unset migratetype directly for
 non Buddy page"
In-Reply-To: <20220117142712.3967624-1-chenwandun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 15:27, Chen Wandun wrote:
> This reverts commit 075782149abff45ee22f27315eced44d02b96779.
> 
> commit 075782149abf ("mm/page_isolation: unset migratetype directly for

That's an old -next commit id, it went to mainline as 721fb891ad0b
("mm/page_isolation: unset migratetype directly for non Buddy page")

> non Buddy page") will result memory that should in buddy disappear by
> mistake. move_freepages_block move all pages in pageblock instead of
> pages indicated by input parameter, so if input pages is not in buddy
> but other pages in pageblock is in buddy, it will result in page out of
> control.
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

#regzbot ^introduced: 721fb891ad0b

There should better be also:

Fixes: 721fb891ad0b ("mm/page_isolation: unset migratetype directly for non
Buddy page")

Especially as that commit had a (inadequate, IMHO, for an optimization)
Fixes: tag and could end up being backported somewhere without the followup
fix/revert.

> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6a0ddda6b3c5..f67c4c70f17f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>  	 * onlining - just onlined memory won't immediately be considered for
>  	 * allocation.
>  	 */
> -	if (!isolated_page && PageBuddy(page)) {
> +	if (!isolated_page) {
>  		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>  		__mod_zone_freepage_state(zone, nr_pages, migratetype);
>  	}


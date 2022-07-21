Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797A57CD34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiGUOUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGUOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:20:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7F222BC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dW/bWDwaMVv8Pew/7ulojs7UcuFsvJlVOAqRXlcbyF8=; b=SnzBFuWZSVXpX8nyooM8kLu6MA
        S231XnK+caNMoNrkjm8O9rLodzkwwdxZ1BunZNIMhJ6SEHgJ2RVCuvGrMmObZLlKaiWgpgbqXWalP
        6S+VftT4RKvlxRlXaLTs28GKfGdKye3PZ2xXfj0/oeUf1O8oJrZ6ODiDsx7rkvVs9zeEjVQVxjUq+
        fi21eBzwB8gMbSOX67TIqzQkUBu8qxeK/M5uhykFe3A7jwtoqoSETSYnmnVpyE5hY/CW/SlFIYBXh
        RzSOQEjAqFk2GEvrfVe72LsYezwRSzBJZ9wUEW0igAjp+Z7FV9fZxS0LutEH823+VRMiw10OuihiT
        V7jWElTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEX26-00FQ9u-5W; Thu, 21 Jul 2022 14:20:06 +0000
Date:   Thu, 21 Jul 2022 15:20:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [RFC PATCH] mm: set cache_trim_mode when inactive ratio is
 undesired
Message-ID: <YtlglhbLUfGBsvw6@casper.infradead.org>
References: <1658387208-20065-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658387208-20065-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:06:48PM +0800, zhaoyang.huang wrote:
> @@ -3198,7 +3215,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	 * anonymous pages.
>  	 */
>  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> +	if (file >> sc->priority && (!(sc->may_deactivate & DEACTIVATE_FILE)
> +		|| inactive_is_high(target_lruvec, LRU_INACTIVE_FILE)))

Indentation is weird here.  When splitting a line, put the operator at
the end, and then indent the rest by something *other* than a single
tab, so it doesn't look like it's part of the following statement.  ie
either:

	if (file >> sc->priority && (!(sc->may_deactivate & DEACTIVATE_FILE) ||
	    inactive_is_high(target_lruvec, LRU_INACTIVE_FILE)))

or:

	if (file >> sc->priority && (!(sc->may_deactivate & DEACTIVATE_FILE) ||
			inactive_is_high(target_lruvec, LRU_INACTIVE_FILE)))

Some people like to use the indentation to illustrate the precendence.
That would look like this:

	if (file >> sc->priority &&
	    (!(sc->may_deactivate & DEACTIVATE_FILE) ||
	     inactive_is_high(target_lruvec, LRU_INACTIVE_FILE)))

(I have a mild preference for the third option in this instance)

>  		sc->cache_trim_mode = 1;
>  	else
>  		sc->cache_trim_mode = 0;
> -- 
> 1.9.1
> 
> 

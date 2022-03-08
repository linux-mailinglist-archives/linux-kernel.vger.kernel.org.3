Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26E4D1D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348295AbiCHQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiCHQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:20:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8E75FCE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sASMybBrruIZ7UAl7EnuiTVPbgVunRsSkPublV647Io=; b=QKt6YpZPpbh1aIjSJYBw5RftaP
        rrdz251VjwiOEpgOF15uOaEvvjTOXHmx0IV7zxw5urSVbFPSZxcbyXjIfCTBTvtBYdkKior1aFzzM
        Uljoalk56W3HBwZdfY5HpnrLQ3MAyX1c1lHw8y6woD2nK2K+jTdBLXnZNj/k1LX5CzvEG/2weMCSo
        bjwmWJ1AxTBLBjNacJ32d7ZU/aiYEdyQSBhfQ6K5Czuzxbq/5rNxsgraT8OTYsQ1/YuV0CiJCYKLI
        dXo8wMrbASfixX07Zj+Yn58BSA27t90SXbnt1tArQODXbbHDQJIKQlwd9c7LG3OF5dsRpHhj+KmmH
        CwcWmVvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcYf-00GKUW-1o; Tue, 08 Mar 2022 16:19:33 +0000
Date:   Tue, 8 Mar 2022 16:19:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     wangjianxing <wangjianxing@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
Message-ID: <YieCFVMJOgT7es6E@casper.infradead.org>
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302013825.2290315-1-wangjianxing@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:38:25PM -0500, wangjianxing wrote:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6..1b96421c8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3479,6 +3479,9 @@ void free_unref_page_list(struct list_head *list)
>  		 */
>  		if (++batch_count == SWAP_CLUSTER_MAX) {
>  			local_unlock_irqrestore(&pagesets.lock, flags);
> +
> +			cond_resched();

This isn't safe.  This path can be called from interrupt context
(otherwise we'd be using local_unlock_irq() instead of irqrestore()).


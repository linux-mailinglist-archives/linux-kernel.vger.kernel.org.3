Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D943F4EAEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiC2NsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiC2NsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:48:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17BB15B876
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LVM8/zLJslUWU774mFRXpF4whJP7o7SpdBwBGDgrE1E=; b=NTLQHhm2OFEqgEMEBYH+PcPMYt
        uacVr5+r+x+zIlfd/uh4dKQ+dVufKKe0qCZkeslTfpiJEPpib1GntVGPQ2WJl2IMkI9WHTc0c8bJ2
        WZDdzUHDUi247hYn1tV643r50aOvOOoU+G3w1pBilLTGtiAisv7amrYPbPbaASWQa5wjUVbePH0Tp
        0rs0X+ziqnrScpOkSHH2KpWqPS1h3HekcJOvXACnVgcUsR1Ue4RCFMrCVlXiAiYSbZe1/091v7psK
        JDre4RlMNZTNsFgm1YqcBsfb0WTqgxzuGkQe25OgE0wpM9DlG8e03mqeyMSbcs8H8l62XxqIbrHwS
        dTL0RcKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZCAt-000KG5-Og; Tue, 29 Mar 2022 13:46:19 +0000
Date:   Tue, 29 Mar 2022 14:46:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm/vmscan: remove redundant folio_test_swapbacked
 check when folio is file lru
Message-ID: <YkMNq0531jBomnkv@casper.infradead.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329132619.18689-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:26:12PM +0800, Miaohe Lin wrote:
> When folio is file lru, folio_test_swapbacked is guaranteed to be true. So
> it's unnecessary to check it here again. No functional change intended.

ummm ... is your logic right here?  The condition is:

	if (!a || (b && !c))

I don't see how it follows that a => c means we can do any
simplification at all.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..7c1a9713bfc9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1434,8 +1434,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  	 * Anonymous pages are not handled by flushers and must be written
>  	 * from reclaim context. Do not stall reclaim based on them
>  	 */
> -	if (!folio_is_file_lru(folio) ||
> -	    (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
> +	if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
>  		*dirty = false;
>  		*writeback = false;
>  		return;
> -- 
> 2.23.0
> 
> 

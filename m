Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB34FBEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347179AbiDKOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347280AbiDKOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:20:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E03DA5C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EoFq52mSAifW7hmuVJnEyfr/qKi5kNzEY/xR+93cmVg=; b=ZYGRV0W++ZoliBjPm8B/gRwIu4
        yAha5BgUDGee0KMNCZBqDJOA+BzqF0ms9akjt1wPKXlqpSMGBLVI4icLCVOaijECDLG42o9pwoSXo
        o0hMZnSSZl3f8HP7oXjaF8INUytI/Y7TV/z6CFTuiWgHcnlOOjj9E87a0rNQMqXkpgz3o0MpldTiC
        ZIzDNVxdScS0OqZipt3YNOzaUVI7ItPQdX96u7P7w0w058N3KnvSc9BB3VtrVZVgVn+0zqPTuoUaM
        +EtgkgmNXDrUQ2v3YZbMTJKlgwbSB5U/aWpsktKKjYazh5AsR2WUGg+PIKa6xxIDx50xZrC2pXiRj
        0oyLBqtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduqg-009Lde-5Y; Mon, 11 Apr 2022 14:16:58 +0000
Date:   Mon, 11 Apr 2022 07:16:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] mm/vmscan: add a comment about MADV_FREE pages
 check in folio_check_dirty_writeback
Message-ID: <YlQ4WkQ1CMYNtted@infradead.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409093500.10329-2-linmiaohe@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 05:34:52PM +0800, Miaohe Lin wrote:
> The MADV_FREE pages check in folio_check_dirty_writeback is a bit hard to
> follow. Add a comment to make the code clear.
> 
> Suggested-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c77d5052f230..4a76be47bed1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1436,6 +1436,9 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  	/*
>  	 * Anonymous pages are not handled by flushers and must be written
>  	 * from reclaim context. Do not stall reclaim based on them

While you touch this please add a period at the end of the above
sentence.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

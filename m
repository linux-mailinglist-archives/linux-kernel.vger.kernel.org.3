Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9297F4EAEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiC2OCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiC2OCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:02:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B205257
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9SHlSe69XKJywaUZHcgPzspp3s6hKx2l886wiEn7ES8=; b=jXwe/J1NQBvLXRUmV6pPvMkg53
        bUmqdNjzZLQRbietS4+6DM74R0vLPAOtc+KzY7lrOK5SlHTDuA9Q+h46+vUNjtwGbkJcXgH5FXooJ
        gj5CGaloYcZ8iIBcFkGh2JTkktXhhT51E6cRLFZSKEhXV94BADfStjDYT1B7+9c7jEhNzSYjG6WXL
        SwbLm3bBJodFxVcJUAcmDV7s+S4vjAm9lLLXz0U3Q1MKRPVoPxeDkSZENIBsy56OLf/Gefz3MB3sr
        bM3JyQmgn5mwnIk2YF3l9o+JRnYGq6wnOFHS5YGhpPWHE2LIThyx/xix2rbe0WpBRQSu8NiuUztsL
        k2SnznqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZCOz-00CRPs-BJ; Tue, 29 Mar 2022 14:00:53 +0000
Date:   Tue, 29 Mar 2022 07:00:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mm/vmscan: save a bit of stack space in shrink_lruvec
Message-ID: <YkMRFaRwS6dadsQ0@infradead.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329132619.18689-5-linmiaohe@huawei.com>
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

On Tue, Mar 29, 2022 at 09:26:15PM +0800, Miaohe Lin wrote:
> LRU_UNEVICTABLE is not taken into account when shrink lruvec. So we can
> save a bit of stack space by shrinking the array size of nr and targets
> to NR_LRU_LISTS - 1. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a6e60c78d058..ebd8ffb63673 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2862,8 +2862,9 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
>  
>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  {
> -	unsigned long nr[NR_LRU_LISTS];
> -	unsigned long targets[NR_LRU_LISTS];
> +	/* LRU_UNEVICTABLE is not taken into account. */
> +	unsigned long nr[NR_LRU_LISTS - 1];
> +	unsigned long targets[NR_LRU_LISTS - 1];

This looks like a problem waiting to happen..


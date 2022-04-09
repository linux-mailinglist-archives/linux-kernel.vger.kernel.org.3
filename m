Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11774FA8B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbiDINq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbiDINq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E399EEC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=srYPn372F6elepCTFVfuSgFxbXDDt+SAQwvKiSb9mJQ=; b=a6hsO9I7frzRqkLCgrj8DEeB5a
        /LQNxSpjJaY+CJK9zurcvu3W63oK2WZaisNz0y+27kW3DnRF3JbPq/jB0C/RKJLTk/WokYlR8W+FY
        pXV9NN8qxzx8jiJXBH2dPuIQfAKRUqrVbZfN/dr5w7572xHxreWerELH2cLFbt7qv9on+tuQWxaZC
        BFsr/MV/yLZUbHE0x/aLzUDzexmE6eeWVthRFBHnZomee2bNAhBtlasdVquzxEIb8hWGy6etz3C5O
        /eVHRHWDPTnxnolbzx6zm4k1fiXaCGXjIiyMFAwpL+Q/FLdnQGI7OUd0kNx+rhn8sptkg4ynxFnTr
        s/nKvOnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndBOA-00Ajbn-Sz; Sat, 09 Apr 2022 13:44:31 +0000
Date:   Sat, 9 Apr 2022 14:44:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        songmuchun@bytedance.com, hch@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] mm/vmscan: introduce helper function
 reclaim_page_list()
Message-ID: <YlGNvn3cu2TftNRN@casper.infradead.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409093500.10329-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 05:34:54PM +0800, Miaohe Lin wrote:
> +	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
> +	while (!list_empty(page_list)) {
> +		folio = lru_to_folio(page_list);
> +		list_del(&folio->lru);
> +		putback_lru_page(&folio->page);

folio_putback_lru()


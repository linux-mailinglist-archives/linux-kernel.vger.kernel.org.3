Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FB4FB23C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiDKDUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbiDKDUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:20:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9819036
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zDQnIfuqccyfN2gbdNU5wS381S9cn2QMm9VzwK2eiK0=; b=XIJnU+2REbCnNo37VYNqYr4uMC
        QI+gOWbr9ORxTTOGHy6CyFQyNu7x4zgJACYTDu8xzxBdfR2vcQ9bHAf2L5o0EPTsl4iJOw/KdW3b+
        85Qv/iMHDmSTNCCuhIo0Qos0CgxpA1kdeNlkFzw1zlFspbJHC4grQ0jwRR1BWkBBygYVS7uSUFz8j
        tml0SXnu5HAoby5c9CgkiDnje58za7WD7pJz8dfwjKxfSuWwZrMtIeoHiscowyfvtLRD72tSlXV3m
        WNeeSWw8vz+6F5ssetqIxFzjAQaJftnaDks1997sZ6svd01T9sexygmqLw907Mm/TMynxc9jTxw7z
        hu94XzdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndkYe-00Byas-Co; Mon, 11 Apr 2022 03:17:40 +0000
Date:   Mon, 11 Apr 2022 04:17:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        songmuchun@bytedance.com, hch@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] mm/vmscan: introduce helper function
 reclaim_page_list()
Message-ID: <YlOd1Lvw6ia1vul2@casper.infradead.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-4-linmiaohe@huawei.com>
 <YlGNvn3cu2TftNRN@casper.infradead.org>
 <18ac3908-d162-f1ea-e91f-1da203272b74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18ac3908-d162-f1ea-e91f-1da203272b74@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:53:15AM +0800, Miaohe Lin wrote:
> On 2022/4/9 21:44, Matthew Wilcox wrote:
> > On Sat, Apr 09, 2022 at 05:34:54PM +0800, Miaohe Lin wrote:
> >> +	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
> >> +	while (!list_empty(page_list)) {
> >> +		folio = lru_to_folio(page_list);
> >> +		list_del(&folio->lru);
> >> +		putback_lru_page(&folio->page);
> > 
> > folio_putback_lru()
> 
> I thought folio_putback_lru is deliberately not to use because there is no caller of folio_putback_lru now.
> But it seems I was wrong. Will do it in next version.

Looks like all of the uses of it that I mooted during the last merge
window ended up going away.

https://lore.kernel.org/all/20220204195852.1751729-47-willy@infradead.org/
was obsoleted by commit b109b87050df

https://lore.kernel.org/all/20220204195852.1751729-48-willy@infradead.org/
and
https://lore.kernel.org/all/20220204195852.1751729-50-willy@infradead.org/
were also obsoleted by Hugh's mlock changes

I also sent
https://lore.kernel.org/all/YjJJIrENYb1qFHzl@casper.infradead.org/

but never quite got it up to submittable quality.

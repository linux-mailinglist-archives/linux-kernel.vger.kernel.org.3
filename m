Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B51528448
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbiEPMgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243396AbiEPMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:36:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC10387AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KMBErDmdZZ2SAaqJemuWdeIzHvPIQPmxERMuOxfXp2k=; b=W4vcg992u6Iv9bbE7yBTHa2lS9
        IextbX8YLlAUPwOaJyXj3ibaTNrIIcvq9DS3oGXOaOHMCQeZIjIcnXnIsJMuj+3yirsX79t703CzP
        l/o+f40ErPO6RTz/BXJvGVd4HsXm/EI6eB1WXBU4YvuZ4ofc0PBV9/PQg/2TLJg2TAT1yJC1fiErs
        iBlyJsoQCPo2BWUlbQUQl31CowKmj63efcvPB/6CgZ5mUclMk/IvPRW/r/ftuFIFoMuubw5gU1T3j
        jGqEUu+lIwKj+Fa3JHmBMzuCIZaNxayJjpkU3sYanUTb1Oa7AICfutpeRjCrxurK1Fae7gsQ3lZ6s
        5RgkVNyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqZxK-009sSS-4F; Mon, 16 May 2022 12:36:10 +0000
Date:   Mon, 16 May 2022 13:36:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] squashfs: implement readahead
Message-ID: <YoJFOpbMYSEOGfXy@casper.infradead.org>
References: <20220516105100.1412740-1-hsinyi@chromium.org>
 <20220516105100.1412740-3-hsinyi@chromium.org>
 <CAJMQK-jjNRuZFOJrd2knQHwPERaJ64pyys+14cCVyfdsP1GZSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-jjNRuZFOJrd2knQHwPERaJ64pyys+14cCVyfdsP1GZSQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 07:04:08PM +0800, Hsin-Yi Wang wrote:
> > +       loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
> > +       loff_t start = readahead_pos(ractl) &~ mask;
> > +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> > +       struct squashfs_page_actor *actor;
> > +       unsigned int nr_pages = 0;
> > +       struct page **pages;
> > +       u64 block = 0;
> > +       int bsize, res, i, index;
> > +       int file_end = i_size_read(inode) >> msblk->block_log;
> > +       unsigned int max_pages = 1UL << shift;
> > +
> > +       readahead_expand(ractl, start, (len | mask) + 1);
> > +
> > +       if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
> > +           file_end == 0)
> > +               return;

What's the first half of this condition supposed to be checking for?
It seems to be checking whether readahead_expand() shrunk the range
covered by the ractl, but readahead_expand() never does that, so I'm
confused why you're checking for it.

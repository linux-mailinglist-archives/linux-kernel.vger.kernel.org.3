Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3975284C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbiEPM4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbiEPM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:56:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB8C38BE4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=beBrIscqgy/0uR/o+DxDTi2opTq7h59zNaTA5248BaE=; b=cO6FBmkT8y7IKKung2vpOoIQ5k
        7oOqh/CYnFPlnrU1EfIvPKMMRYCfHUNrp+7WbU3R72a4bEDHzoZlyVdwo8TF+7+VIz/8amLZBTKGV
        QeMJJwfl5Y5/9RDq362odnkReBqFLN8g8Yi4qs7+NBJdR3DbbowtGGj73pAq+hZP6IzTisv/seGF9
        VYEjTKO/fJ6jX9hpEHz6iMwSxpwQ9NdL3QgV27N4fQ4O8BIkeE3Hx7/8EybgwipWcPjrUklCEu86N
        MPPSZz1FSuISFDZYMmi2zwZNQDhzLaImM0nX+2F9auL5AwD3M7Wli7Dyz6RURKO4RR550eZ101FAe
        iFv1tLlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqaFx-009tNO-NU; Mon, 16 May 2022 12:55:25 +0000
Date:   Mon, 16 May 2022 13:55:25 +0100
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
Message-ID: <YoJJvabBCTJHryGm@casper.infradead.org>
References: <20220516105100.1412740-1-hsinyi@chromium.org>
 <20220516105100.1412740-3-hsinyi@chromium.org>
 <CAJMQK-jjNRuZFOJrd2knQHwPERaJ64pyys+14cCVyfdsP1GZSQ@mail.gmail.com>
 <YoJFOpbMYSEOGfXy@casper.infradead.org>
 <CAJMQK-iDFJGHzmJQ0VZRXL-O8MBeqLFS-b0M-6bm3ncZ4TgMJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-iDFJGHzmJQ0VZRXL-O8MBeqLFS-b0M-6bm3ncZ4TgMJQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:47:52PM +0800, Hsin-Yi Wang wrote:
> On Mon, May 16, 2022 at 8:36 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, May 16, 2022 at 07:04:08PM +0800, Hsin-Yi Wang wrote:
> > > > +       loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
> > > > +       loff_t start = readahead_pos(ractl) &~ mask;
> > > > +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> > > > +       struct squashfs_page_actor *actor;
> > > > +       unsigned int nr_pages = 0;
> > > > +       struct page **pages;
> > > > +       u64 block = 0;
> > > > +       int bsize, res, i, index;
> > > > +       int file_end = i_size_read(inode) >> msblk->block_log;
> > > > +       unsigned int max_pages = 1UL << shift;
> > > > +
> > > > +       readahead_expand(ractl, start, (len | mask) + 1);
> > > > +
> > > > +       if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
> > > > +           file_end == 0)
> > > > +               return;
> >
> > What's the first half of this condition supposed to be checking for?
> > It seems to be checking whether readahead_expand() shrunk the range
> > covered by the ractl, but readahead_expand() never does that, so I'm
> > confused why you're checking for it.
> 
> hi Matthew,
> 
> This is to check if readahead_expand() expands as much as it's requested.
> I didn't encounter the mismatch so far in my testing. If this check is
> not necessary, it can be removed.

Then I think req_end is miscalculated?  It should surely be:

	req_end = start + (len | mask) + 1;

But I'm not sure that we should be failing under such circumstances.
For example, we may have been asked to read 1.5MB, attempt to round up
to 2MB, and fail.  But we can still submit a readahead for the first 1MB,
before leaving the second 512kB for readpage to handle.

So maybe we should just remove this check entirely.

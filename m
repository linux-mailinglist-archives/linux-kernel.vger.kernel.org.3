Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4956457B041
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiGTFQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTFQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:16:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD522B3A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Bj5xo3aBWzpgA1wxnI5L2KZvghnmty4TyKyCextdDY=; b=a71tPE5mXeW3OOa6Ki61VNAFN7
        qe6oaQig2z46CEFskkXRR2+vpeKovnxG7d+Zz/ha7q8DpJKBK70GyYUd4bZSZItK+gySP+6C0InhM
        FRV1Re1cCNyUOdMVH5c1ukvZAXbi+VZoMZl1ke8XjCyleZAJDa8j9FO1GrUBOP00V6kdOINqkAwm0
        Ewg5La+ZbRE0MICgJ5S0JvF1Rr9zhjYHFg41vMyAd01Wd9FMGYFR5JLbTzTf1QV8DxhLaXtHPdMe1
        4fQZxhdNitRhc3rtjftVw6Qcn/Kjk15Nj7T4NlmMGEKEHDxLqq2zFxzOsA3GLnqHmv+ck+xDgApYQ
        hz0iVRdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE24l-000Sky-Qv; Wed, 20 Jul 2022 05:16:47 +0000
Date:   Tue, 19 Jul 2022 22:16:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keir Fraser <keirf@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <YtePv+AT+pqD2wHe@infradead.org>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
 <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org>
 <YtbXxl8STUtQkacb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbXxl8STUtQkacb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:11:50PM +0000, Keir Fraser wrote:
> Well here are two possible approaches:
> 
> 1. Revert e41b1355508d outright. I'm not even sure what it would mean
> for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
> is no longer IOMMU-specific anyway.
> 
> 2. Continue to clear the flag during virtio_balloon negotiation, but
> remember that it was offered, and test for that in vring_use_dma_api()
> as well as, or instead of, virtio_has_dma_quirk().
> 
> Do either of those appeal?

I'll have to defer to people that actually understand the virtio_balloon
code, because I haven't evey seriously looked at it.

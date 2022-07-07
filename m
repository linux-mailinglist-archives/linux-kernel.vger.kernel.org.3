Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D156A9B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiGGRdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiGGRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:33:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1301095;
        Thu,  7 Jul 2022 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TMaNklIdIcP+MFN2zwCG5jiftF6l+7/4HlhjYmCCffE=; b=Sn0j+sa3jhLQ0ziIexYmJgHUPF
        ipH5TffoQhAW/RMhlhDR63Y1dQ/gQr6C/IjgyLZut5m8YWccvybkG2lt8sGbx4r8QgBYxATJMrQVq
        9wqoMr8wbfVeht7o45vHjxRhg5cf/jER3KIA96iyL/yKONUDDwhsxgkgZy6lxw2ySmwo5djC8vTEi
        v3W0b/A3Hj/VHwKxiRddE6dgdmyD7hMm94HFh1vu4gMPoDJgEfjlY1pGm0hiR0wwcS7gSxFTd0mDE
        wRxUej3+v58daNyzNsBCv7ZXsNeKePVHHQIveb1MR+LiChvdfC6umxQM2DYVzhicvbsTp+ciiRXrv
        TQNIE1GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9VNU-00HENG-U1; Thu, 07 Jul 2022 17:33:24 +0000
Date:   Thu, 7 Jul 2022 10:33:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/20] block, blksnap: functions and structures for
 performing block I/O operations
Message-ID: <YscY5ImH+1EjgsIF@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-12-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-12-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define SECTORS_IN_PAGE (PAGE_SIZE / SECTOR_SIZE)

This can use PAGE_SECTORS from blk_types.h

> +
> +struct bio_set diff_io_bioset = { 0 };

No need to initialize global variables to 0.

> +	// Allocate both bios
> +	opf = diff_io->is_write ? REQ_OP_WRITE : REQ_OP_READ;
> +	gfp = GFP_NOIO | (is_nowait ? GFP_NOWAIT : 0);
> +
> +	bio = bio_alloc_bioset(diff_region->bdev, nr_iovecs,
> +			       opf | REQ_SYNC | REQ_IDLE | REQ_FUA,

REQ_FUA on reads does not make sense.

> +	submit_bio_noacct(bio);
> +
> +	// Submit flush bio
> +	bio_set_flag(flush_bio, BIO_FILTERED);
> +	flush_bio->bi_end_io = diff_io_endio;
> +	flush_bio->bi_private = diff_io;
> +	flush_bio->bi_iter.bi_sector = 0;
> +	submit_bio_noacct(flush_bio);

And a separate flush for reads seems odd and probably wrong here.
And for writes REQ_FUA already ensuresyour write went to disk.
Do you also need to flush all previous data?  In which case you
probably want a single bio with REQ_PREFLUSH and REQ_FUA instead
of submitting two separate bios here.

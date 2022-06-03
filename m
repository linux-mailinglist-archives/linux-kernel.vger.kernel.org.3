Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7469053C527
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbiFCGpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbiFCGpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:45:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB93338BE8;
        Thu,  2 Jun 2022 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SeFpdnprEi9iCGjGlU63nj2qTA0drgWmyD7FmCG4OE4=; b=3zTgnYuPWnNPExNCabm33MY4J6
        ihpZPheAQy1pCerzKhlX6oLi8qxj3RnRYU9EoghYXmcyHKQ+hWqmgimsFi56e44oedMs/oNVMUGeq
        MaIvr2e58qRnWhXUGK9uX7JHzeaplv1MBZXOAiiAyh+PhA0BpLCEUvgfzpJHU++hqa9N9DHpVTO+n
        5fToyXyXnF8oHJj8QCwiGHFCe0Y+7NsTUohVAh6RkJzbuKQoKLBuZiSzpMkIrmrAHeZFSExYm8avt
        vMv7LOnw10WIOtjRRT+CfdTL98Pp8JvbLYoh3QhlYz4KY2EZ8yp4ZRnxPoo1FNADmlkIay1MpivTc
        UrGtEQRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx13Y-00653h-Ol; Fri, 03 Jun 2022 06:45:12 +0000
Date:   Thu, 2 Jun 2022 23:45:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v3 11/11] md/raid5-ppl: Fix argument order in
 bio_alloc_bioset()
Message-ID: <Ypmt+AGg76+lTeko@infradead.org>
References: <20220602181818.50729-1-logang@deltatee.com>
 <20220602181818.50729-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602181818.50729-12-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 12:18:17PM -0600, Logan Gunthorpe wrote:
> bio_alloc_bioset() takes a block device, number of vectors, the
> OP flags, the GFP mask and the bio set. However when the prototype
> was changed, the callisite in ppl_do_flush() had the OP flags and
> the GFP flags reversed. This introduced some sparse error:
> 
>   drivers/md/raid5-ppl.c:632:57: warning: incorrect type in argument 3
> 				    (different base types)
>   drivers/md/raid5-ppl.c:632:57:    expected unsigned int opf
>   drivers/md/raid5-ppl.c:632:57:    got restricted gfp_t [usertype]
>   drivers/md/raid5-ppl.c:633:61: warning: incorrect type in argument 4
>   				    (different base types)
>   drivers/md/raid5-ppl.c:633:61:    expected restricted gfp_t [usertype]
> 				    gfp_mask
>   drivers/md/raid5-ppl.c:633:61:    got unsigned long long
> 
> The sparse error introduction may not have been reported correctly by
> 0day due to other work that was cleaning up other sparse errors in this
> area.
> 
> Fixes: 609be1066731 ("block: pass a block_device and opf to bio_alloc_bioset")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Ooops.  Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and should probably be first in the series)

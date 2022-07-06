Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E319568919
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiGFNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGFNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:13:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A6E02;
        Wed,  6 Jul 2022 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ceb/IjE3f2UpwLk19hSDj3nYch41eBpR+eFC5bU92FE=; b=YhdEUAZhCJrQBU4y3VtlWZhG9q
        M/NtuJs2tbmvhuK+PEheiK4YG3+5YPcDU5AQKofCzm97vcH7MaR029+b7qVvXRSI8w++dPr+S6SBt
        FDcN2aHb16Ala+sz7hsGphQz29zTgmyOMpd5MDWSuxKXStBiyJme250NtVTFrGd8fyfWNqkva91oC
        w9c+cQiZ4ZLDJ0RDygSh5Rt4w1NYcDud9E2EKS+PZqXM1EVd0CqgWLTT6dXVWGZKmyaGi5zWdJ/3o
        /Un33xFNclg3UvkLx8RCxkTQbH0fqPguDMxOfHF1wo7pVqDjOvS9NQDn4SI82++GPYPgK+uSIxoXV
        j7ipfoMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o94qc-00ACuR-Mb; Wed, 06 Jul 2022 13:13:42 +0000
Date:   Wed, 6 Jul 2022 06:13:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/20] block, blksnap: snapshot image block device
Message-ID: <YsWKhjDV18DeyEZ8@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-16-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-16-git-send-email-sergei.shtepa@veeam.com>
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

> +#include <linux/cdrom.h>

What do you need this for?

> +static int new_minor(int *minor, void *ptr)
> +{
> +	int ret;
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&_minor_lock);
> +
> +	ret = idr_alloc(&_minor_idr, ptr, 0, 1 << MINORBITS, GFP_NOWAIT);
> +
> +	spin_unlock(&_minor_lock);
> +	idr_preload_end();
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*minor = ret;
> +	return 0;
> +}

alloc_disk not automatically allocates minors for you if you don't
set the ->major and ->first_minor fields, which could simply this
a lot.

> +static int snapimage_init_request(struct blk_mq_tag_set *set,
> +				  struct request *rq, unsigned int hctx_idx,
> +				  unsigned int numa_node)
> +{
> +	struct snapimage_cmd *cmd = blk_mq_rq_to_pdu(rq);
> +
> +	kthread_init_work(&cmd->work, snapimage_queue_work);
> +	return 0;
> +}

I'm a little confused on why this both has a blk-mq interface and
the new bio filter interface.  Whow is going to submit I/O to this
blk-mq interface?

> +	//.open = snapimage_open,
> +	//.ioctl = snapimage_ioctl,
> +	//.release = snapimage_close,

Please don't leave commented out code around.

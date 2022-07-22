Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8795957D9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 07:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiGVFdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 01:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 01:33:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B8951EF;
        Thu, 21 Jul 2022 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DtZsf139KOAbMbBJhz2+Jz2bLGfy9yjxTmGvtBExryU=; b=nz/ewjV3YfTAilYoWxcthFxHUO
        X1sckuby9XCEoxLN1lgc/kThLGx8mPYl0S/Ox1Lfeen7MjCe8Mm6SYUSyaEqUc4rJ1dw8+HhnamRq
        QGy8+nDo1oYmPrqb4V7fZ21L3sE/NN9yL//EhFJfYFvMk7z1Xkxk04YfK4t7YC2/iUqqinQe5HXLp
        y56sN1Ybv+mBL2ktYbCjO6VXzkU+ez6NcAZo/5Mk4a4m0RxnpAHecOSqNB8BbSbdRdTIcz4IyffyO
        zo3oZeHZl5Ue0p0j7wGCjuHN47lpoo1eGnqdBpQBU75kiUK7iUZ6fVkV9+aWlrfiGouZAyyw1jqA6
        kc7MOwgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oElI8-0007VT-Lh; Fri, 22 Jul 2022 05:33:36 +0000
Date:   Thu, 21 Jul 2022 22:33:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: avoid potential infinite loop in
 __blk_mq_alloc_request
Message-ID: <Yto2sHfyiJITgYAn@infradead.org>
References: <1658467343-55843-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658467343-55843-1-git-send-email-liusong@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 01:22:23PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> If "blk_mq_get_tag" returns BLK_MQ_NO_TAG because the value of
> "tags->nr_reserved_tags" is 0, it will fall into an infinite loop in
> "__blk_mq_alloc_requests", so borrow BLK_MQ_REQ_NOWAIT to exit the loop.

That means the driver calling blk_mq_alloc_request has a bug, and
we should not work round that in the low level tag allocation path.

If we want to be nice we can add a WARN_ON before going all the way
down into the tag allocator, something like:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 92aae03103b74..d6c7e2ece025f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -520,6 +520,10 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	struct request *rq;
 	int ret;
 
+	if (WARN_ON_ONCE((flags & BLK_MQ_REQ_RESERVED) &&
+			!q->tag_set->reserved_tags))
+		return ERR_PTR(-EINVAL);
+
 	ret = blk_queue_enter(q, flags);
 	if (ret)
 		return ERR_PTR(ret);

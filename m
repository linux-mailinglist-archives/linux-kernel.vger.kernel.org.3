Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355FA49C527
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiAZIVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiAZIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:21:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C7C06161C;
        Wed, 26 Jan 2022 00:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MAdtxuXSV1VHX1OFKJGAFQr/nTMY6TEYJtcKj8HipZ4=; b=0POYNJcO0+eSkFys4Qwl3AROeN
        dGi1PTZ4XEWAKnRRQfWQXWF75hKV4dSuj1Ou/jx9MX/Gs3hxEMkTfcK4zTxw+0+dN7ujRtneqmEU6
        x+DHlIboN4OCSJWii/FLQNHLJhUrkAsNw7JwU+yymdVfX86lqFY2qBWlfp1bzdmRFYG7jt1gltdDZ
        IPNCFBnH8GWWohetE3f2gEbJNNqPm6AX4IpD/Z9oZ/YzOA+t4tAoaX0nrGImEGY8VJXherqNSdcib
        mtVSrWI3nIIANYiICvxLB9CfFAvjQEzN+3oeVO4ZImQe0gijVnrh+nffM4aGMTTLRXkIXCuRg2A/y
        8sXk3ykw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCdYt-00AhVp-Q9; Wed, 26 Jan 2022 08:21:51 +0000
Date:   Wed, 26 Jan 2022 00:21:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, xiyou.wangcong@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH] block: introduce block_rq_error tracepoint
Message-ID: <YfEEn06IEPjdGzHc@infradead.org>
References: <20220125203548.352278-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125203548.352278-1-shy828301@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:35:48PM -0800, Yang Shi wrote:
> Currently, rasdaemon uses the existing tracepoint block_rq_complete
> and filters out non-error cases in order to capture block disk errors.
> 
> But there are a few problems with this approach:
> 
> 1. Even kernel trace filter could do the filtering work, there is
>    still some overhead after we enable this tracepoint.
> 
> 2. The filter is merely based on errno, which does not align with kernel
>    logic to check the errors for print_req_error().
> 
> 3. block_rq_complete only provides dev major and minor to identify
>    the block device, it is not convenient to use in user-space.
> 
> So introduce a new tracepoint block_rq_error just for the error case
> and provides the device name for convenience too. With this patch,
> rasdaemon could switch to block_rq_error.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> The v3 patch was submitted in Feb 2020, and Steven reviewed the patch, but
> it was not merged to upstream. See
> https://lore.kernel.org/lkml/20200203053650.8923-1-xiyou.wangcong@gmail.com/.
> 
> The problems fixed by that patch still exist and we do need it to make
> disk error handling in rasdaemon easier. So this resurrected it and
> continued the version number.
> 
> v3 --> v4:
>  * Rebased to v5.17-rc1.
>  * Collected reviewed-by tag from Steven.
> 
>  block/blk-mq.c               |  4 +++-
>  include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f3bf3358a3bb..bb0593f93675 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -789,8 +789,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  #endif
>  
>  	if (unlikely(error && !blk_rq_is_passthrough(req) &&
> -		     !(req->rq_flags & RQF_QUIET)))
> +		     !(req->rq_flags & RQF_QUIET))) {
> +		trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);

Please report the atual block layer status code instead of the errno
mapping here.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098B5234B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiEKNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbiEKNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:52:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B5D5F;
        Wed, 11 May 2022 06:52:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C5EF31F381;
        Wed, 11 May 2022 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652277150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5EtuSyYuYlsw4axGP9aJGHFXz29o0qgte+7cip7nFw=;
        b=xw+lZ84zZi1EiVgC0K27vK7IIEPWkv7FL1kX0qbRgP6HRH57dcPFfcj37UgW1Pq4S8oLYF
        1wnXrsIaV2DoRewtFUZ3SRNwVVFvLvDh0f9qm9dIlbN7pdQSUxnV294089AE/oY6cLEWSb
        3tp0e3M+OxjM9Ja6f2O1VuNhw3nT/eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652277150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5EtuSyYuYlsw4axGP9aJGHFXz29o0qgte+7cip7nFw=;
        b=0nnKyr/0j3rNtV1cf5l/9yRuH20nOxARYq4+t+qjIgBViXYCzj/Egy7Seb1m46lSTlpuG7
        KO1qpR0zLyrwlGCg==
Received: from quack3.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B2FC92C141;
        Wed, 11 May 2022 13:52:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 02294A062A; Wed, 11 May 2022 15:52:27 +0200 (CEST)
Date:   Wed, 11 May 2022 15:52:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/2] block, bfq: protect 'bfqd->queued' by
 'bfqd->lock'
Message-ID: <20220511135227.lawvrlrajtyszwfb@quack3.lan>
References: <20220510131629.1964415-1-yukuai3@huawei.com>
 <20220510131629.1964415-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510131629.1964415-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-05-22 21:16:28, Yu Kuai wrote:
> If bfq_schedule_dispatch() is called from bfq_idle_slice_timer_body(),
> then 'bfqd->queued' is read without holding 'bfqd->lock'. This is
> wrong since it can be wrote concurrently.
> 
> Fix the problem by holding 'bfqd->lock' for bfq_schedule_dispatch(),
> like everywhere else.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 272d48d8f326..61750696e87f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -456,6 +456,8 @@ static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
>   */
>  void bfq_schedule_dispatch(struct bfq_data *bfqd)
>  {
> +	lockdep_assert_held(&bfqd->lock);
> +
>  	if (bfqd->queued != 0) {
>  		bfq_log(bfqd, "schedule dispatch");
>  		blk_mq_run_hw_queues(bfqd->queue, true);
> @@ -6898,8 +6900,8 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  	bfq_bfqq_expire(bfqd, bfqq, true, reason);
>  
>  schedule_dispatch:
> -	spin_unlock_irqrestore(&bfqd->lock, flags);
>  	bfq_schedule_dispatch(bfqd);
> +	spin_unlock_irqrestore(&bfqd->lock, flags);
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

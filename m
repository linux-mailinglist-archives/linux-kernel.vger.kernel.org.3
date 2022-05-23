Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990785313FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiEWOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiEWOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:12:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91689275C6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:12:47 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i68so11602854qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D9PaxQgh0dgGWTqhmUPSOfrq/Hw+1kY6VaKwgcNAm/M=;
        b=fFXpBoD84sQ7AF2ZfHFijFUDydy/a0AwqnA2dCvm8Mj/8UQianCRe4XVRsoBfQuG2D
         ICxF4JAgz7ViGJ1oKYxAZkstk3z9csDWHCrN7zFaS2fe9Nyge/XTh6UJfs5XmHLA8Ix/
         VyqAeQnm7o5wH93bsuJtKiwbDYH+OfkHSdKBFtS18g3I2W7vHeUt3GKHMAh85K/+gY+t
         O/KB58s6E5wWXEiOCrjIEWgi5j8SBvckaZZmAOx+JsBvzs5EklxxaITJJBn2axzY2cON
         D5V/uKFrC1Cmug3j/8WqLbad+hB3tBNaOlCyKQ+DurNVcTrJLVGhktLtikOuIWgXXn1D
         0Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9PaxQgh0dgGWTqhmUPSOfrq/Hw+1kY6VaKwgcNAm/M=;
        b=7ZPorPZzrGXvBzK7VoeWP+vVRcenjZxsC0zpGoFdv0oJTeguJInKP1aZMLxwpxftd9
         sLUtQ5jc1p2Vk6ko7wSxeoGYC6XX1euvavsAljziD80IGduL9d2jz8VpX5g0xab4tm/I
         c2hlui4bZweQDp7cYWo4E/t8eAwpl/YqqhFTgaz1ElGyLahULjIwbJ95A/eFUzl8WysO
         GdEtZMYmwrrwtwJbUEGkmRvPJY5TQwF7JJrPNT/vs2cwPQXStLsj/4UpZqg8kHzPiJJt
         tDZrCWI17paggwhZgEmScUDhZqz7aiOtCdNRaNaM5cY/lKBp1GWV3E8Gm1k14IBWEXXD
         UX3A==
X-Gm-Message-State: AOAM530d4HMYfJBnAYYGZPQL6mFjjPZhPDh0VlZeBC1hxMIhu6m6rBqc
        InjLlkM8UVb4p4bwuznOTE55S3X82FeBlQ==
X-Google-Smtp-Source: ABdhPJya52lpcsbBSkKIaQkTMnZzwxjA4yWpPSm4Nqk0vkxh0Nl49AOOILI0+gCK/4A+BtBJMJq0hQ==
X-Received: by 2002:a37:d245:0:b0:69b:f153:9c38 with SMTP id f66-20020a37d245000000b0069bf1539c38mr13876045qkj.692.1653315166256;
        Mon, 23 May 2022 07:12:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a120200b0069fc13ce206sm4289849qkj.55.2022.05.23.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:12:45 -0700 (PDT)
Date:   Mon, 23 May 2022 10:12:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 3/6] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if
 request is not completed
Message-ID: <YouWXEcyoBNUXLb7@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-4-yukuai3@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 03:37:46PM +0800, Yu Kuai wrote:
> Otherwise io will hung because request will only be completed if the
> cmd has the flag 'NBD_CMD_INFLIGHT'.
> 
> Fixes: 07175cb1baf4 ("nbd: make sure request completion won't concurrent")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 2ee1e376d5c4..a0d0910dae2a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -403,13 +403,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>  	if (!mutex_trylock(&cmd->lock))
>  		return BLK_EH_RESET_TIMER;
>  
> -	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
> +	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>  		mutex_unlock(&cmd->lock);
>  		return BLK_EH_DONE;
>  	}
>  
>  	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>  		cmd->status = BLK_STS_TIMEOUT;
> +		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>  		mutex_unlock(&cmd->lock);
>  		goto done;
>  	}
> @@ -478,6 +479,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>  	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
>  	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
>  	cmd->status = BLK_STS_IOERR;
> +	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>  	mutex_unlock(&cmd->lock);
>  	sock_shutdown(nbd);
>  	nbd_config_put(nbd);
> @@ -745,7 +747,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
>  	cmd = blk_mq_rq_to_pdu(req);
>  
>  	mutex_lock(&cmd->lock);
> -	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
> +	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>  		dev_err(disk_to_dev(nbd->disk), "Suspicious reply %d (status %u flags %lu)",
>  			tag, cmd->status, cmd->flags);
>  		ret = -ENOENT;
> @@ -854,8 +856,16 @@ static void recv_work(struct work_struct *work)
>  		}
>  
>  		rq = blk_mq_rq_from_pdu(cmd);
> -		if (likely(!blk_should_fake_timeout(rq->q)))
> -			blk_mq_complete_request(rq);
> +		if (likely(!blk_should_fake_timeout(rq->q))) {
> +			bool complete;
> +
> +			mutex_lock(&cmd->lock);
> +			complete = __test_and_clear_bit(NBD_CMD_INFLIGHT,
> +							&cmd->flags);
> +			mutex_unlock(&cmd->lock);
> +			if (complete)
> +				blk_mq_complete_request(rq);
> +		}

I'd rather this be handled in nbd_handle_reply.  We should return with it
cleared if it's ready to be completed.  Thanks,

Josef

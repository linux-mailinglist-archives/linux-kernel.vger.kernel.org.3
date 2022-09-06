Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69385AF6CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIFV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIFV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:28:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20648BADB0;
        Tue,  6 Sep 2022 14:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 759D8B81A65;
        Tue,  6 Sep 2022 21:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8797DC433B5;
        Tue,  6 Sep 2022 21:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662499675;
        bh=dCZeZmBCEnwc86WWX7Ly3DyLI7yhO7+PsPdUpFb40oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqf84Q+gXCZSzgXwZHheeS+21eyn/rsBhdyxH+30/5ZYwAsXM6O4hbRZcA8Ci+0sj
         dk3ZMM5KZMkJXn58MkyXhtOmQRLuBYKk6cQ0lbQlQbvLSR8Z9gcwvaEInubN2HgkvI
         kUQgeK6SmmuUIMQGmr9puVKqlS9Swc54V4EkJUqwdja/hoW2DvoYeOVue3j41MssL8
         l1LHimEc09fOLUKhrDc/unzbcxWYiRrrGAeberAgNswIPKo1VMpg2khdZNUlALEqpO
         gOyMf1YTRVrRmKoJ28W4r8hj4u40SM6/wtjAOHrgvF9MpMmqPi4ryQN1Kh97h+M3Yx
         0qtrlDES7RGOw==
Date:   Tue, 6 Sep 2022 15:27:51 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, axboe@kernel.dk, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Message-ID: <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803121504.212071-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 08:15:04PM +0800, Yu Kuai wrote:
>  	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> -	if (wait_cnt <= 0) {
> -		int ret;
> +	/*
> +	 * For concurrent callers of this, callers should call this function
> +	 * again to wakeup a new batch on a different 'ws'.
> +	 */
> +	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
> +		return true;

If wait_cnt is '0', but the waitqueue_active happens to be false due to racing
with add_wait_queue(), this returns true so the caller will retry. The next
atomic_dec will set the current waitstate wait_cnt < 0, which also forces an
early return true. When does the wake up happen, or wait_cnt and wait_index get
updated in that case?

  
> -		wake_batch = READ_ONCE(sbq->wake_batch);
> +	if (wait_cnt > 0)
> +		return false;
>  
> -		/*
> -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
> -		 * ensure that we see the batch size update before the wait
> -		 * count is reset.
> -		 */
> -		smp_mb__before_atomic();
> +	wake_batch = READ_ONCE(sbq->wake_batch);
>  
> -		/*
> -		 * For concurrent callers of this, the one that failed the
> -		 * atomic_cmpxhcg() race should call this function again
> -		 * to wakeup a new batch on a different 'ws'.
> -		 */
> -		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
> -		if (ret == wait_cnt) {
> -			sbq_index_atomic_inc(&sbq->wake_index);
> -			wake_up_nr(&ws->wait, wake_batch);
> -			return false;
> -		}
> +	/*
> +	 * Wake up first in case that concurrent callers decrease wait_cnt
> +	 * while waitqueue is empty.
> +	 */
> +	wake_up_nr(&ws->wait, wake_batch);
>  
> -		return true;
> -	}
> +	/*
> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> +	 * ensure that we see the batch size update before the wait
> +	 * count is reset.
> +	 *
> +	 * Also pairs with the implicit barrier between decrementing wait_cnt
> +	 * and checking for waitqueue_active() to make sure waitqueue_active()
> +	 * sees result of the wakeup if atomic_dec_return() has seen the result
> +	 * of atomic_set().
> +	 */
> +	smp_mb__before_atomic();
> +
> +	/*
> +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> +	 * callers can see valid wait_cnt in old waitqueue, which can cause
> +	 * invalid wakeup on the old waitqueue.
> +	 */
> +	sbq_index_atomic_inc(&sbq->wake_index);
> +	atomic_set(&ws->wait_cnt, wake_batch);
>  
>  	return false;
>  }
> -- 
> 2.31.1
> 

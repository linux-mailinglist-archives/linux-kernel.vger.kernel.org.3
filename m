Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47E04A8C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353663AbiBCTFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353655AbiBCTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:05:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6979DC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:05:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g18so6543044wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ayc+KckUjHogrth329rI08TVrImsvzuWQkvoQQVorg8=;
        b=su7BwaaLoW/dbPV3DhDrnkjZzLh8b/6lHm9Y8viqivXW5Y797h9vq5hTHNLyru1jZ5
         BrJlFQp5F2rUN/gM6gTzWovi4vTrAFtE3nAGfUA8eElYTaUARNE1Gojm8/KqRv+2bilq
         8yiuy6Kj8aamS5/XKK058PD5l4wO8dXR5Cj0Zuzn/6pXvsQcQA2zNyAL4D8VkXZdy3b2
         vx5JeM+m7LMo3DWy9ZWxmwwb1dLWwi3Ls47ck01CuJi+tkqv4aC84gFHuHbQbmtRwaJZ
         z589SPk0vIdBQ0sQ2tAm7U64LNSKLNkIN2e8unFNhMvGMEk+O5s3avM8nAXElzmownAW
         qt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ayc+KckUjHogrth329rI08TVrImsvzuWQkvoQQVorg8=;
        b=mNRjQdgpyeYCaCOPtb2sZLMwAcb7RoN/alrXF5mgzRJfLgX1TMJ/UfXiRd3i8lmiu9
         /CzXYZskXSp7XCwbymRXQA+0WeIHeGCiORHM5L2IUAxhdZfVpPziS9mOo4GBUbsYlsk2
         SSIeJ8qmEOZEuWowaK9bhG3iNaaqOnyYXQ7DzNSMQI/wkCSAJDPCblHMVgTnG0OYZUgN
         wvAkBNgzi5h5m7uU3xWcOjVmxRpd6cLOGM7Q2x97Z7S9hmQKMCOUnA9/aqc2pqvfG7Tq
         YBSyrO92jiEIYcJTPFYk0U+T9Q5bkaJERo8LZHzESOv9F2Tm5m3UCKe3in3ue2W5BuXw
         hgcA==
X-Gm-Message-State: AOAM533cShtiyUU8/PTh1WGYKhyrZW5il9ZgPKw/FrVg3icEN6oBKC1Q
        H+MTbp0VmHLwjd3qV+W1JK7qpw==
X-Google-Smtp-Source: ABdhPJyrXZArUx3lcTsF9Q6/Aj7bpMcM2ye9IL4/navesPwwS3QKmqJIPTp42tiaQ7hPYW/HKMk0WA==
X-Received: by 2002:a5d:4390:: with SMTP id i16mr21224387wrq.516.1643915144955;
        Thu, 03 Feb 2022 11:05:44 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:28c2:5854:c832:e580? ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id p13sm20170322wrx.86.2022.02.03.11.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:05:44 -0800 (PST)
Subject: Re: [External] Re: [PATCH v4 2/3] io_uring: avoid ring quiesce while
 registering/unregistering eventfd
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com
References: <20220203182441.692354-1-usama.arif@bytedance.com>
 <20220203182441.692354-3-usama.arif@bytedance.com>
 <8369e0be-f922-ba6b-ceed-24886ebcdb78@kernel.dk>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <d390f325-0f5b-a321-841d-36ac873358f9@bytedance.com>
Date:   Thu, 3 Feb 2022 19:05:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8369e0be-f922-ba6b-ceed-24886ebcdb78@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2022 18:49, Jens Axboe wrote:
> On 2/3/22 11:24 AM, Usama Arif wrote:
>> -static inline bool io_should_trigger_evfd(struct io_ring_ctx *ctx)
>> +static void io_eventfd_signal(struct io_ring_ctx *ctx)
>>   {
>> -	if (likely(!ctx->cq_ev_fd))
>> -		return false;
>> +	struct io_ev_fd *ev_fd;
>> +
>> +	rcu_read_lock();
>> +	/* rcu_dereference ctx->io_ev_fd once and use it for both for checking and eventfd_signal */
>> +	ev_fd = rcu_dereference(ctx->io_ev_fd);
>> +
>> +	if (likely(!ev_fd))
>> +		goto out;
>>   	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
>> -		return false;
>> -	return !ctx->eventfd_async || io_wq_current_is_worker();
>> +		goto out;
>> +
>> +	if (!ctx->eventfd_async || io_wq_current_is_worker())
>> +		eventfd_signal(ev_fd->cq_ev_fd, 1);
>> +
>> +out:
>> +	rcu_read_unlock();
>>   }
> 
> This still needs what we discussed in v3, something ala:
> 
> /*
>   * This will potential race with eventfd registration, but that's
>   * always going to be the case if there is IO inflight while an eventfd
>   * descriptor is being registered.
>   */
> if (!rcu_dereference_raw(ctx->io_ev_fd))
> 	return;
> 
> rcu_read_lock();

Hmm, so i am not so worried about the registeration, but actually 
worried about unregisteration.
If after the check and before the rcu_read_lock, the eventfd is 
unregistered won't we get a NULL pointer exception at 
eventfd_signal(ev_fd->cq_ev_fd, 1)?

I guess checking for NULL twice would work, so something like this is ok 
then?

static void io_eventfd_signal(struct io_ring_ctx *ctx)
{
	struct io_ev_fd *ev_fd;

	/* Return quickly if ctx->io_ev_fd doesn't exist */
	if (likely(!rcu_dereference_raw(ctx->io_ev_fd)))
		return;

	rcu_read_lock();
	/* rcu_dereference ctx->io_ev_fd once and use it for both for checking 
and eventfd_signal */
	ev_fd = rcu_dereference(ctx->io_ev_fd);

	/*
	 * Check again if ev_fd exists incase an io_eventfd_unregister call 
completed between
	 * the NULL check of ctx->io_ev_fd at the start of the function and 
rcu_read_lock.
	 */
	if (unlikely(!ev_fd))
		goto out;
	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
		goto out;

	if (!ev_fd->eventfd_async || io_wq_current_is_worker())
		eventfd_signal(ev_fd->cq_ev_fd, 1);

out:
	rcu_read_unlock();
}


> ...
> 
> which I think is cheap enough and won't hit sparse complaints. The
> 
>> @@ -9353,35 +9370,70 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
>>   
>>   static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
>>   {
>> +	struct io_ev_fd *ev_fd;
>>   	__s32 __user *fds = arg;
>> -	int fd;
>> +	int fd, ret;
>>   
>> -	if (ctx->cq_ev_fd)
>> -		return -EBUSY;
>> +	mutex_lock(&ctx->ev_fd_lock);
>> +	ret = -EBUSY;
>> +	if (rcu_dereference_protected(ctx->io_ev_fd, lockdep_is_held(&ctx->ev_fd_lock))) {
>> +		rcu_barrier();
>> +		if(rcu_dereference_protected(ctx->io_ev_fd, lockdep_is_held(&ctx->ev_fd_lock)))
>> +			goto out;
>> +	}
> 
> I wonder if we can get away with assigning ctx->io_ev_fd to NULL when we
> do the call_rcu(). The struct itself will remain valid as long as we're
> under rcu_read_lock() protection, so I think we'd be fine? If we do
> that, then we don't need any rcu_barrier() or synchronize_rcu() calls,
> as we can register a new one while the previous one is still being
> killed.
> 
> Hmm?
> 

We would have to remove the check that ctx->io_ev_fd != NULL. That we 
would also result in 2 successive calls to io_eventfd_register without 
any unregister in between being successful? Which i dont think is the 
right behaviour?

I think the likelihood of hitting the rcu_barrier itself is quite low, 
so probably the cost is low as well.

>>   static int io_eventfd_unregister(struct io_ring_ctx *ctx)
>>   {
>> -	if (ctx->cq_ev_fd) {
>> -		eventfd_ctx_put(ctx->cq_ev_fd);
>> -		ctx->cq_ev_fd = NULL;
>> -		return 0;
>> +	struct io_ev_fd *ev_fd;
>> +	int ret;
>> +
>> +	mutex_lock(&ctx->ev_fd_lock);
>> +	ev_fd = rcu_dereference_protected(ctx->io_ev_fd, lockdep_is_held(&ctx->ev_fd_lock));
>> +	if (ev_fd) {
>> +		call_rcu(&ev_fd->rcu, io_eventfd_put);
>> +		ret = 0;
>> +		goto out;
>>   	}
>> +	ret = -ENXIO;
>>   
>> -	return -ENXIO;
>> +out:
>> +	mutex_unlock(&ctx->ev_fd_lock);
>> +	return ret;
>>   }
> 
> I also think that'd be cleaner without the goto:
> 
> {
> 	struct io_ev_fd *ev_fd;
> 	int ret;
> 
> 	mutex_lock(&ctx->ev_fd_lock);
> 	ev_fd = rcu_dereference_protected(ctx->io_ev_fd,
> 					lockdep_is_held(&ctx->ev_fd_lock));
> 	if (ev_fd) {
> 		call_rcu(&ev_fd->rcu, io_eventfd_put);
> 		mutex_unlock(&ctx->ev_fd_lock);
> 		return 0;
> 	}
> 
> 	mutex_unlock(&ctx->ev_fd_lock);
> 	return -ENXIO;
> }
> 
Thanks, will do that this in the next patchset with the above 
io_eventfd_signal changes if those look ok as well?

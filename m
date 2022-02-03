Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5007A4A890B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348791AbiBCQte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiBCQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:49:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E6C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:49:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l129-20020a1c2587000000b0035394fedf14so7502122wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXXFQjpMpuedbS9DUvm9MfSLQqXiSQQHHNcYNioPk/8=;
        b=ssCpeS/A5G/kp3LBXIJ/I/WPDqxBp9I+ZTaZG/keldG7sNMgp8YTsoaFmBLTLREhXX
         OsiNSVhBYRqAnTa3zTbfWnbTL2Q9fcJDc9AkKm2RMSIbuOi7W3eNujU/TA0Xk6sxqKCH
         LCxH6OzBOV/x6nJCM4aRV8cETChYev5LGkQsOQZhvILU8qTcWaw0D2cS/UU5yo/5wrxa
         hmVLKndenG1qWD5aVHd4jJC2gzduhUmd/DyrP5IHX4XPeDetHmuD5SZKG096o/K44GQ+
         Sp+l5z5J1vjO043pKvvkN9c4NXf3QqB8PIf8T6S8iJmkU4mugN5FOcf8YjkpcB1/+u1M
         KGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXXFQjpMpuedbS9DUvm9MfSLQqXiSQQHHNcYNioPk/8=;
        b=WJd0WS5AmKY3CqoS0Jupfw9UBUeR3+PGx7R6shKqRSeloUFLYLp8VjqxoZkMBykgcy
         KrDVQgZxVNUIL6TmuBD716KcN/V/Ir6spSDGqj3XkkOgyMMeL8y2OhPqoznj4wkcYd7i
         IULM5hAlfliAGqPNarURB6KVOsM8FvPHQDdhaxRcMJ4++7s5u75csMOJHYz1t0EMpqlj
         PUgqp3cCmREkw0h1QbgxDdz9/FwfNawhwuyA0FceSNlHk+L4DLuwz+TL50RDbpRjEs2E
         Xz+i1k5x1Q7btFkYqHlCVSlQ8GFGWgWCbPB91xfhVnQQliNGQeLgzYmijPOe2kYF2+Ix
         u/iw==
X-Gm-Message-State: AOAM533PqEB0PyiH1g6oDj3mNKZSF/L10Cqo2WWSt+RXC9h5Vudio5St
        0dENgi3fEIEhhIfY8W2nw14gxQ==
X-Google-Smtp-Source: ABdhPJx3pxUmTXC/Fs+xKe6mgsOZwLlgmSGhtfoQNiZCfYPknjaur27qa46/1raIXxjDOniDPZ706Q==
X-Received: by 2002:a05:600c:34c6:: with SMTP id d6mr11334945wmq.103.1643906970836;
        Thu, 03 Feb 2022 08:49:30 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:28c2:5854:c832:e580? ([2a02:6b6d:f804:0:28c2:5854:c832:e580])
        by smtp.gmail.com with ESMTPSA id 16sm7595469wmj.12.2022.02.03.08.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:49:30 -0800 (PST)
Subject: Re: [PATCH 1/2] io_uring: avoid ring quiesce while
 registering/unregistering eventfd
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com
References: <20220203151153.574032-1-usama.arif@bytedance.com>
 <20220203151153.574032-2-usama.arif@bytedance.com>
 <87fca94e-3378-edbb-a545-a6ed8319a118@kernel.dk>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <62f59304-1a0e-1047-f474-94097cb8b13e@bytedance.com>
Date:   Thu, 3 Feb 2022 16:49:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87fca94e-3378-edbb-a545-a6ed8319a118@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2022 15:55, Jens Axboe wrote:
> On 2/3/22 8:11 AM, Usama Arif wrote:
>> +static void io_eventfd_signal(struct io_ring_ctx *ctx)
>> +{
>> +	struct io_ev_fd *ev_fd;
>> +
>> +	rcu_read_lock();
>> +	ev_fd = rcu_dereference(ctx->io_ev_fd);
>> +
>> +	if (!io_should_trigger_evfd(ctx, ev_fd))
>> +		goto out;
>> +
>> +	eventfd_signal(ev_fd->cq_ev_fd, 1);
>> +out:
>> +	rcu_read_unlock();
>> +}
> 
> Would be cleaner as:
> 
> static void io_eventfd_signal(struct io_ring_ctx *ctx)
> {
> 	struct io_ev_fd *ev_fd;
> 
> 	rcu_read_lock();
> 	ev_fd = rcu_dereference(ctx->io_ev_fd);
> 
> 	if (io_should_trigger_evfd(ctx, ev_fd))
> 		eventfd_signal(ev_fd->cq_ev_fd, 1);
> 
> 	rcu_read_unlock();
> }
> 
> and might be worth considering pulling in the io_should_trigger_evfd()
> code rather than have it be a separate helper now with just the one
> caller.

Hi,
Thanks for the review. Have pulled in the code for 
io_should_trigger_evfd into io_eventfd_signal.
> 
>> @@ -9353,35 +9374,67 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
>> +	if (rcu_dereference_protected(ctx->io_ev_fd, lockdep_is_held(&ctx->ev_fd_lock)))
>> +		goto out;
>>   
>> +	ret = -EFAULT;
>>   	if (copy_from_user(&fd, fds, sizeof(*fds)))
>> -		return -EFAULT;
>> +		goto out;
>>   
>> -	ctx->cq_ev_fd = eventfd_ctx_fdget(fd);
>> -	if (IS_ERR(ctx->cq_ev_fd)) {
>> -		int ret = PTR_ERR(ctx->cq_ev_fd);
>> +	ret = -ENOMEM;
>> +	ev_fd = kmalloc(sizeof(*ev_fd), GFP_KERNEL);
>> +	if (!ev_fd)
>> +		goto out;
>>   
>> -		ctx->cq_ev_fd = NULL;
>> -		return ret;
>> +	ev_fd->cq_ev_fd = eventfd_ctx_fdget(fd);
>> +	if (IS_ERR(ev_fd->cq_ev_fd)) {
>> +		ret = PTR_ERR(ev_fd->cq_ev_fd);
>> +		kfree(ev_fd);
>> +		goto out;
>>   	}
>> +	ev_fd->ctx = ctx;
>>   
>> -	return 0;
>> +	rcu_assign_pointer(ctx->io_ev_fd, ev_fd);
>> +	ret = 0;
>> +
>> +out:
>> +	mutex_unlock(&ctx->ev_fd_lock);
>> +	return ret;
>> +}
> 
> One thing that both mine and your version suffers from is if someone
> does an eventfd unregister, and then immediately does an eventfd
> register. If the rcu grace period hasn't passed, we'll get -EBUSY on
> trying to do that, when I think the right behavior there would be to
> wait for the grace period to pass.
> 
> I do think we need to handle that gracefully, spurious -EBUSY is
> impossible for an application to deal with.

I don't think my version would suffer from this as its protected by 
locks? The mutex_unlock on ev_fd_lock in unregister happens only after 
the call_rcu. And the mutex is locked in io_eventfd_register at the 
start, so wouldnt get the -EBUSY if there is a register immediately 
after unregister?
> 
>> @@ -11171,8 +11226,10 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
>>   	mutex_lock(&ctx->uring_lock);
>>   	ret = __io_uring_register(ctx, opcode, arg, nr_args);
>>   	mutex_unlock(&ctx->uring_lock);
>> +	rcu_read_lock();
>>   	trace_io_uring_register(ctx, opcode, ctx->nr_user_files, ctx->nr_user_bufs,
>> -							ctx->cq_ev_fd != NULL, ret);
>> +				rcu_dereference(ctx->io_ev_fd) != NULL, ret);
>> +	rcu_read_unlock();
>>   out_fput:
>>   	fdput(f);
>>   	return ret;
> 
> We should probably just modify that tracepoint, kill that ev_fd argument
> (it makes very little sense).
> 

Thanks! have added that in patch 1 in v2.

Regards,
Usama

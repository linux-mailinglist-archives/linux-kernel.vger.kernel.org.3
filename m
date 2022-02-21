Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD7E4BE4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbiBUQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:33:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiBUQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:32:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F31DA6E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:32:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t4-20020a17090a3b4400b001bc40b548f9so2831577pjf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9p9UW1ztCFicl4wOWM1XmJ1UIygmRbUNF3ZrGCMsB54=;
        b=RvGVcJIpDoAbqeo+wRu4a9HBSsA6WfZNvT54dKmZTS5kHfraG6Ovauc5/MVe0+IGko
         Rlw4Nl+GtgY/amZ2tKmNyePOAOQbSr/9YiOiXMiVIEgRd2Yxjx7X0Q0X4LqPI6SXgnVM
         GfIVkld6jJ07wMROX8rskmHCQOycRP6kLZjCnNv8iRV13lyyhq8Y9RBhNxlVBjxLmjk/
         FNz7DSxW8zns76NCZCUvmAaZwTi5wclz/Vj3/OHcjA158M78lU+HcRUue4j8ZO7JOs1q
         Fjt/6Uhl0JWDGN350Da0BFXj+v3EulC0rwRkIQUiSYM+THlyZgvNBJLCKgkRBsuh4PdJ
         bW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9p9UW1ztCFicl4wOWM1XmJ1UIygmRbUNF3ZrGCMsB54=;
        b=Vk98XWQaqmJg7YZb7A2b3sBuu/eZ8J3ULUmWDlUDIRij/jGLenT9fUzbE7nLsNsWvm
         6BM9McldzIypShYd5IT+V1dV67U3JBinrk2FdmYguy1tUvXFQWBTAwwGYUDOB3lW2pbM
         bTAN17jyQnriLpXt9Nh04I87Ju8heE7icdZLVHtLaMk4EHuBHJ6uD8Iqfnu1Irszrbfp
         +x7EQ7nBLkkw50bmyUSDc7GHIGm9MjJ1PX8KlGWKQaQ7k8YnXw9CxqI3z/aa9TmeQqe8
         pyRIcUK7tKiZ5aGWt5/JzMWtIum5R7ybtd97Cw0KWz715GNmLj2Rwdc3bmmQ60NB/KFR
         P3IQ==
X-Gm-Message-State: AOAM5307u2YxklfBS9uUlbqnEAo0/rGCgRDLYKbzULrCU0w/LAQeyIce
        9XOcYM/ijBcYAxwP6yP3CLwmiu25vKbP/g==
X-Google-Smtp-Source: ABdhPJwlTU+2aKKFbkkqE+oFyktV5D+caaKuDnY7RVSBS9lqdTYgr6jLTDq4s2e55uoX2ugaLsg5eg==
X-Received: by 2002:a17:902:ccc1:b0:14f:b686:e6ff with SMTP id z1-20020a170902ccc100b0014fb686e6ffmr5876342ple.45.1645461154640;
        Mon, 21 Feb 2022 08:32:34 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o14sm8297884pfw.121.2022.02.21.08.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:32:34 -0800 (PST)
Message-ID: <50f407fd-d4e3-7c3f-5e8b-1f7fc366216d@kernel.dk>
Date:   Mon, 21 Feb 2022 09:32:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/4] io_uring: update kiocb->ki_pos at execution time
Content-Language: en-US
To:     Dylan Yudaken <dylany@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20220221141649.624233-1-dylany@fb.com>
 <20220221141649.624233-3-dylany@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220221141649.624233-3-dylany@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 7:16 AM, Dylan Yudaken wrote:
> Update kiocb->ki_pos at execution time rather than in io_prep_rw().
> io_prep_rw() happens before the job is enqueued to a worker and so the
> offset might be read multiple times before being executed once.
> 
> Ensures that the file position in a set of _linked_ SQEs will be only
> obtained after earlier SQEs have completed, and so will include their
> incremented file position.
> 
> Signed-off-by: Dylan Yudaken <dylany@fb.com>
> ---
>  fs/io_uring.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 1f9b4466c269..50b93ff2ee12 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3000,14 +3000,6 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  		req->flags |= io_file_get_flags(file) << REQ_F_SUPPORT_NOWAIT_BIT;
>  
>  	kiocb->ki_pos = READ_ONCE(sqe->off);
> -	if (kiocb->ki_pos == -1) {
> -		if (!(file->f_mode & FMODE_STREAM)) {
> -			req->flags |= REQ_F_CUR_POS;
> -			kiocb->ki_pos = file->f_pos;
> -		} else {
> -			kiocb->ki_pos = 0;
> -		}
> -	}
>  	kiocb->ki_flags = iocb_flags(file);
>  	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
>  	if (unlikely(ret))
> @@ -3074,6 +3066,19 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
>  	}
>  }
>  
> +static inline void
> +io_kiocb_update_pos(struct io_kiocb *req, struct kiocb *kiocb)
> +{
> +	if (kiocb->ki_pos == -1) {
> +		if (!(req->file->f_mode & FMODE_STREAM)) {
> +			req->flags |= REQ_F_CUR_POS;
> +			kiocb->ki_pos = req->file->f_pos;
> +		} else {
> +			kiocb->ki_pos = 0;
> +		}
> +	}
> +}


static inline void io_kiocb_update_pos(struct io_kiocb *req,
				       struct kiocb *kiocb)
{
}

Can we just drop the kiocb argument? It'll always be req->rw.kiocb.
Should generate the same code if you do:

static inline void io_kiocb_update_pos(struct io_kiocb *req)
{
	struct kiocb *kiocb = &req->rw.kiocb;

	...
}

Apart from that minor thing, looks good to me.

-- 
Jens Axboe


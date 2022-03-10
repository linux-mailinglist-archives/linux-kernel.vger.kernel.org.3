Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D54D472D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbiCJMoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiCJMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:44:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7EDE1B73
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:43:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lj8-20020a17090b344800b001bfaa46bca3so5008995pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CDsxJMVFbsC0bGMCU12bgzonHWoDLo8dW6cJfUvfyBA=;
        b=VZu6gBhdnEnHTaDCB7eCjxcMW0c4fggLeOg3Fmu4FvMkB3XOX2cSWe1gfohisVNiz3
         fZSRy+8LO+UdZSiTxJKdKR9Q3HGFgNhWbu33Z474khBHPB0osIXq0CaKBQkctbTp0eiR
         kHD3ckPGXR32xytERC1WDh1/+2ZCqiV4iV4+zDORLZTkW0GBWYtj7IaUqaEAvRm+WfFz
         c+YkB4CLKPUESCk1Vrpd+Jm3I5lr/Bjqqx1dhDNheT0vFIIxKNTSUi9CW4/1ZLWnkxbC
         IYZqOG0H5NR8xSPkcm3VTCbqbI11LRprlUfK62DYluTUmSJV01Zg6/FI3hjPvL45bJ32
         9Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CDsxJMVFbsC0bGMCU12bgzonHWoDLo8dW6cJfUvfyBA=;
        b=r61m//ZWNqzWfs1AxER9S6xX5YvQpbduyqZ6AyYIX5sgq3yN9zBC4x072UJyYeNgqs
         9mqVnlLg8JzOCvuua5LsMCk+hgbSICUByaEyygyuiDJXHQGfylND7QTpJkepOLazD3RQ
         v6Bsn/wvklJj/OiUqDQGEB9Wt0IBYgv4bs3EAKFi6iM3QVMboNVxLWV83K5jUw47bh62
         vtYYDjiKaf4LtsYdm/GXtrOd6Rr0r4VlXvrKf/Et6ZK+Lt2I1Ale3Z98xi+w0Y6bjtf8
         7GWcKSdh4SUS7FlitVgUQ+F6rVN0qWYmurTHJpal4FiWriZ81Sic/1x+06OgmQBGSBEn
         muNg==
X-Gm-Message-State: AOAM533c9oSf38wlp8g2fsFPOAWRp2w66yitOaNdul1PystRJo2uOfzh
        fZdO3QLDvmYoSTmT/X1NJlxSh6yZVm1/J9CB
X-Google-Smtp-Source: ABdhPJydyISgKH/MalsigQ3ZJ0uUGLNxwRJpkmlchxAh1MZ1J9N6uebwdgZn4Y0Wc09hUgJ5DCO0WQ==
X-Received: by 2002:a17:902:b113:b0:153:1d99:9cc7 with SMTP id q19-20020a170902b11300b001531d999cc7mr3041930plr.6.1646916207465;
        Thu, 10 Mar 2022 04:43:27 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j11-20020a63230b000000b00372a08b584asm5579949pgj.47.2022.03.10.04.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:43:26 -0800 (PST)
Message-ID: <58c5f828-df7d-6698-e2d6-2a869e134dd4@kernel.dk>
Date:   Thu, 10 Mar 2022 05:43:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] task_work: simplify the task_work_add() interface
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
References: <20220223072754.616027-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220223072754.616027-1-hch@lst.de>
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

On 2/23/22 12:27 AM, Christoph Hellwig wrote:
> Provide a low-level task_work_add_nonotify interface that just adds
> the work to the list and open code the TWA_SIGNAL and TWA_NONE callers
> using it.  task_work_add() itself now only handles the common TWA_RESUME
> case and can drop the notify argument.

Not sure this is much of a cleanup, and a potential fast case of
TWA_NONE will now still still set TIF_NOTIFY_RESUME. Also:

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 77b9c7e4793bf..94116a102dc61 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -9606,7 +9606,7 @@ static __cold void io_ring_exit_work(struct work_struct *work)
>  					ctx_node);
>  		/* don't spin on a single task if cancellation failed */
>  		list_rotate_left(&ctx->tctx_list);
> -		ret = task_work_add(node->task, &exit.task_work, TWA_SIGNAL);
> +		ret = task_work_add_nonotify(node->task, &exit.task_work);
>  		if (WARN_ON_ONCE(ret))
>  			continue;

This one is now no longer setting TIF_NOTIFY_SIGNAL.

If you want to get rid of the argument, why not just have separate
helpers? task_work_add_signal(), task_work_add_resume(),
task_work_add(). Setting TWA_RESUME unconditionally because it's the
common use case doesn't seem ideal.

-- 
Jens Axboe


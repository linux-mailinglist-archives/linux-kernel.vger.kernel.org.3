Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9686A48CAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiALSK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356094AbiALSJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:09:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C69C029828;
        Wed, 12 Jan 2022 10:08:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j11so11050853lfg.3;
        Wed, 12 Jan 2022 10:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fbQ4MfMPQ01c4yNnE9/3ElS8nA8KssfGISIkQPEdFsY=;
        b=ObdGosYwJtK5OzDLqayzPD3/LnC1M9Fs8nnT4OJc+qYHHhCOprhDhARWt30UeY3xTW
         s9MEwc0HRT46OenG6uONG9oyMWCbpTMr3Jewfnfcqt21XpnyYtRLdvEyJhXvINBaKone
         05r449M4Yf8EauPzkmqujmJaHpcRP1uJEI8rynH6Qinna3YwY474XFjZ8//bGL0lO+Jm
         eM8B3qAFBtol8VqiYaPu+0SLy5qlei0R4Jc8z8gHvu95Xc23jt0wM5pJH0qPfYJ47gBp
         gWd1zcPRo7jKhnHkcCvrisbigMP3nuRl2jOFGFVUvKuqEnZoBQVF0lj0MxhbH2ZeddfR
         1FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fbQ4MfMPQ01c4yNnE9/3ElS8nA8KssfGISIkQPEdFsY=;
        b=bOh8DGl0H8UWpJXlKqeZLq9TJVgm/Mmf9U/ww2tu4b5q6T6lCujHvitTxMSotqHTVA
         yMd7mAvSCbml9HFAV7Z9TAnMsVwZHzf3z7luN7rA4kWgIdwAkO8Nt/act/SRT+vrL9vT
         Vg7zRfdN71vlROw/b/mK6QQfzOuBc/THwi9yOB86aQNJVsYG/ylNNWSwLhs/Iet5B/Ui
         DkxDIwaBpdCbjPpQ+wdUNeZpue5yXBY/y3yHCZ0rMICCCM2dm9wfcx+AXWvgt4IAR6Uk
         SQOfmyI2EALE6JAUkV8KRtzAO4MnD/s98ZKQseVhgOZgYBuuK6GHby8A8tjhJr+cpd3v
         YMqg==
X-Gm-Message-State: AOAM531q/9s/j4z8DYlPUA0ra5p7E/TNQBtTq9BkRLQJ8XA4kOt1V2xM
        YAyBpJAx38AvY74Ej5LWcfY=
X-Google-Smtp-Source: ABdhPJwWHoWpLtRiuzfDkCm8Un7F1KU6ZGRTRVKv7RiEHbBNH2URTuRSDL07MZF7+km6mW6qppQ6ag==
X-Received: by 2002:a05:6512:3f16:: with SMTP id y22mr621580lfa.61.1642010928255;
        Wed, 12 Jan 2022 10:08:48 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.67])
        by smtp.gmail.com with ESMTPSA id k29sm35460ljc.44.2022.01.12.10.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:08:47 -0800 (PST)
Message-ID: <c5ae2a68-070f-884c-c82a-2d3f4b8e06b1@gmail.com>
Date:   Wed, 12 Jan 2022 21:08:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] udmabuf: validate ubuf->pagecount
Content-Language: en-US
To:     kraxel@redhat.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        syzbot+2c56b725ec547fa9cb29@syzkaller.appspotmail.com
References: <20211230142649.23022-1-paskripkin@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211230142649.23022-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 17:26, Pavel Skripkin wrote:
> Syzbot has reported GPF in sg_alloc_append_table_from_pages(). The
> problem was in ubuf->pages == ZERO_PTR.
> 
> ubuf->pagecount is calculated from arguments passed from user-space. If
> user creates udmabuf with list.size == 0 then ubuf->pagecount will be
> also equal to zero; it causes kmalloc_array() to return ZERO_PTR.
> 
> Fix it by validating ubuf->pagecount before passing it to
> kmalloc_array().
> 
> Fixes: fbb0de795078 ("Add udmabuf misc device")
> Reported-and-tested-by: syzbot+2c56b725ec547fa9cb29@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> 

Gentle ping :)

> 
> ---
>   drivers/dma-buf/udmabuf.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index c57a609db75b..e7330684d3b8 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -190,6 +190,10 @@ static long udmabuf_create(struct miscdevice *device,
>   		if (ubuf->pagecount > pglimit)
>   			goto err;
>   	}
> +
> +	if (!ubuf->pagecount)
> +		goto err;
> +
>   	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(*ubuf->pages),
>   				    GFP_KERNEL);
>   	if (!ubuf->pages) {

With regards,
Pavel Skripkin

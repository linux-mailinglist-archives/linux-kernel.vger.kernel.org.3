Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7447D34C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbhLVOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbhLVOBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:01:14 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C2AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:01:14 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id de30so2402055qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rM9meUmwsTLv02DYjATChDUD/xIxIH7rXuAdVzXkVQ=;
        b=ZK1VUuUyucIpu8u9DV3J65pXa2kY+QyC37UC64055wMMJCbldOjQ/atdnhCk/EoK4U
         P9+1g9RVGzS2FboZ3pqJbGazUrSKCbN6Jp/xWqvWv++PnAu41/wcsHR5yvH/gTxTGwX7
         3SUZVR8y/Y3BnhgoARyv73PUnK005HbIk/R+o7k0tMFpLquVDDXA+BGQC42096XulVtA
         zctrxaTQcOhC29WH3u/iE7K5+cxQxwt+g6fLehOz6WfRjdw57L2c4sVYxWK7Z2p3I5oQ
         rWQv1IXC6hDbu0wAIoJDA/J0XRMGDzwEUEoaAPoh/kMPAXobMbVD7czdveai5S3MG5DT
         v/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=6rM9meUmwsTLv02DYjATChDUD/xIxIH7rXuAdVzXkVQ=;
        b=iR27SfDM1aioUBlGRnK5y+8TnY8309LCLzGvfpwEi2TTV00zRddJxR2pS5i/pkYPD2
         w2CosPomKEylD/KFTJ65EZnQIeQNpBcjFyBay17kbpgaDF5wNMjmOrty5ziUMANVmAwi
         L3AcEH2XAI8IuHc5gNgpjn7mHHnz5sNFd4lSmsifI0MWmDyZeXDUS3CZBFcorO7Wf4oN
         jyIHQmLQJxKTiFOfQv2BCWALMhiftHQjCjubk11WpT4d7KtN0+TNs3a7By3vDJjAfzxa
         6yC3BYIyiQf4qqxeiAa2pfVRrqvgzWZ5287cIcowRp4uEwxMFBTCMxlPCX+v7mj8qtlA
         o6NQ==
X-Gm-Message-State: AOAM532WiySP6bWbLQRW6COaaFZ9Xa95XNPZwEgp9ihubeOV0r0wMn8G
        ZhzC7ezURURBn+heE/GhjQ==
X-Google-Smtp-Source: ABdhPJyNCbwMopsKyrWFHxgddpA3Tw2geZc5/MuJZKyKJP2iOzjmlvFcqfFwdPxc9JPqdepGh6mLEw==
X-Received: by 2002:a05:620a:103a:: with SMTP id a26mr1955567qkk.785.1640181673021;
        Wed, 22 Dec 2021 06:01:13 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id r187sm1759536qke.11.2021.12.22.06.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:01:12 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:a994:7eee:8e73:4087])
        by serve.minyard.net (Postfix) with ESMTPSA id 77FE1180013;
        Wed, 22 Dec 2021 14:01:11 +0000 (UTC)
Date:   Wed, 22 Dec 2021 08:01:10 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: ssif: replace strlcpy with strscpy
Message-ID: <20211222140110.GU14936@minyard.net>
Reply-To: minyard@acm.org
References: <20211222032707.1912186-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222032707.1912186-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:27:07AM +0800, Jason Wang wrote:
> The strlcpy should not be used because it doesn't limit the source
> length. So that it will lead some potential bugs.
> 
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
> 
> Thus, replace strlcpy with strscpy.

Ok, thanks for the patch.

-corey

> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 48aab77abebf..ba779f1abb5b 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1354,7 +1354,7 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	if (rv)
>  		rv = -ENODEV;
>  	else
> -		strlcpy(info->type, DEVICE_NAME, I2C_NAME_SIZE);
> +		strscpy(info->type, DEVICE_NAME, I2C_NAME_SIZE);
>  	kfree(resp);
>  	return rv;
>  }
> -- 
> 2.34.1
> 

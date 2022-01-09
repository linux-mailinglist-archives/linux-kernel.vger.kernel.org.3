Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC248896E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiAIMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:53:24 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41830 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiAIMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:53:23 -0500
Received: by mail-wr1-f41.google.com with SMTP id v6so21418542wra.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 04:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grA0cdw5lnO9WkWK/DwhFMP5UY39CgS8WhXA1sFFVq8=;
        b=VnFdHjtBkpGtnDGlNJugLvoXijtIRsGZXQhEmdQb1iYUSJpLqAoJnzqWFpTTI8M5ZP
         mG+TVWgDZNbMnmTrG6r0vjrVOsgVHtzE0dsy22QoDeKOJokEEDNWDz+SFB6MBoWXWEDU
         wIhq+JrT9ZlkIJtbXmYmYwULl2OdEahCHaQNZdP6jOQI+LbKAELl0uJfTNgGM4cYF6Xu
         NOA3c/I9QlUG7UFfuT7SMCFIBjxKp4gFZ4L3H0AAIWY9nzQWCzMWvr7N7rLLEcM7yio8
         kzjjhpBCSJ1Fiol/4BOCNbywc38l0hNKPa1sRyvJ+FK3+rcMXQPtg5VU9cB+QzTDS6PT
         WAEA==
X-Gm-Message-State: AOAM5317VdKXaw760u2HfMWXE7v7Gz5d0HbUdzNbHKaCNaEoGrSO2cut
        2shRwX9gLMAiiP/7Ieij5sE=
X-Google-Smtp-Source: ABdhPJxJ/93rgdQgBGTs+tjFxGX8oyPr9mzIhPM28zbabY5uED4+tJmShtT+/RBKYe4teDOpUbzu9Q==
X-Received: by 2002:a05:6000:1684:: with SMTP id y4mr59128621wrd.26.1641732802695;
        Sun, 09 Jan 2022 04:53:22 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l14sm4177198wrr.53.2022.01.09.04.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 04:53:22 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: remove unneeded variable
To:     cgel.zte@gmail.com, kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5212915e-5e1f-7a77-f05e-248de382fcfb@grimberg.me>
Date:   Sun, 9 Jan 2022 14:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Remove unneeded variable used to store return value.

I actually think that ret is missing an assignment in the error
case (e.g ret = -ENODEV)...

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   drivers/nvme/host/fabrics.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 7ae041e2b3fb..f79a66d4e22c 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1092,7 +1092,6 @@ static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
>   static int nvmf_dev_show(struct seq_file *seq_file, void *private)
>   {
>   	struct nvme_ctrl *ctrl;
> -	int ret = 0;
>   
>   	mutex_lock(&nvmf_dev_mutex);
>   	ctrl = seq_file->private;
> @@ -1106,7 +1105,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
>   
>   out_unlock:
>   	mutex_unlock(&nvmf_dev_mutex);
> -	return ret;
> +	return 0;
>   }
>   
>   static int nvmf_dev_open(struct inode *inode, struct file *file)
> 

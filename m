Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33324953A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiATR4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiATR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:56:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E454C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:56:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so6519489pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQK5zVzqLI6klwHyZj/+smdOpWkvGx4b96oH7k78DVI=;
        b=h3qF4O7gvq4Ngmvx2/kjn9H6OS8Lau1YuC4M8nMdC4/En8aXI85M6NX9I4dtxPuOvR
         LNGI3s0xYtWiTsLZfVyvPffs9SGIdhwwhB08iHTgIbwdEKrOpN6nExX/Zskqq4UoQy3k
         0f03014Xr2C6BvgmptvCARFJ9pal8Hm7K/4ilIj5aKBePIr+EzC6iQgAxhA9rthj6zmc
         YxyrQhJYlnF+K8UUOOi49dbDeQhGLo1Sw/G6XAhjUCofgEfj4fFt6xPZdx0LmQtijzzL
         +lcuDM95hzIzn4gLZ244o+UN20aYeZLYV5Vq0FHitFwHP7OmtX2iiCe/0wb5VIKGjXe+
         6J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQK5zVzqLI6klwHyZj/+smdOpWkvGx4b96oH7k78DVI=;
        b=jVUS9yMu4NTOkkBjfTXNRAW/Zt7kqwHov8Z/TFpVM0Hf0V2vY8XLmer4MwVy5P9C/G
         E3Dmt2w4sJLJSOz1FbtsZZAt1Lq8aZP3L281gDi5uI65Ri3ptzoCyNBerXFMXImzlmvi
         aNQO+DgYyMY+gb7pihHbP/KoL4ylp40ey9aJMcgoY8SD0L7d03eCaW6APFG1s6sZesep
         DyexWvms/EnzJu+3JUHbZ1ofO8syBXx7f+c4LQUYwAVm+iT1VZWLB9rklfPvhS2XruU3
         mfwk3XTk9BCwZVetPRGshLH+wzg5uEMoIdUqKlA3eMM4YXiafiG5Sxnn/MZHXS7Sjpm1
         5TpQ==
X-Gm-Message-State: AOAM532PjVN3jSDjKwqjkpNiaNcBAAOAHlUjoEiivFtZO3ii7Z1Gqr6W
        WKOyA6/4fzpgNjfUPZZcMy/MQA==
X-Google-Smtp-Source: ABdhPJwUKxMCYglR9XOpdXVnTtB/k9OqpDZEl+oS4hqc6RRWe0ciZkXLEvosyCk8upOLgBMKD0Y5YA==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr2479838pjs.204.1642701405601;
        Thu, 20 Jan 2022 09:56:45 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id rj2sm9860364pjb.54.2022.01.20.09.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:56:44 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:56:42 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: syscfg: Fix memleak on registration failure
 in cscfg_create_device
Message-ID: <20220120175642.GB1338735@p14s>
References: <20220110073100.15497-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110073100.15497-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Mon, Jan 10, 2022 at 07:31:00AM +0000, Miaoqian Lin wrote:
> device_register() calls device_initialize(),
> according to doc of device_initialize:
> 
>     Use put_device() to give up your reference instead of freeing
>     * @dev directly once you have called this function.

That is _if_ device_initialize() is called manually.  In this instance
@dev is registered with device_register() and unregistered with
device_unregister().  The latter conforms to the comment you pointed out and
calls put_device() as expected.

Thanks,
Mathieu

> 
> To prevent potential memleak, use put_device() instead call kfree
> directly.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-syscfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index 43054568430f..007fa1c761a7 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -764,7 +764,7 @@ struct device *cscfg_device(void)
>  /* Must have a release function or the kernel will complain on module unload */
>  static void cscfg_dev_release(struct device *dev)
>  {
> -	kfree(cscfg_mgr);
> +	put_device(dev);
>  	cscfg_mgr = NULL;
>  }
>  
> -- 
> 2.17.1
> 

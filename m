Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2074488C2E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiAIUFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiAIUFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:05:30 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9513C06173F;
        Sun,  9 Jan 2022 12:05:29 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 45-20020a9d0a30000000b0058f1a6df088so13128145otg.4;
        Sun, 09 Jan 2022 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z/CHwmtPKS9YFQVceEU95L1dygwbhvLKGuEbY6OKojw=;
        b=IHd5MFLNDrqtGXbxIRYdAMF6VuHEEgWIHaubTyC3bxHwpEm/a4O6aZDlDgPv98IAcF
         zCqNbQqHdki2UyU0+VWoL9x1xQQm0UfnjLIPq+yagCnur9E2LeZt2vuGM0uZ8Ao4rcQ7
         LIqIjlp0jDc5gEmiiqBklfNdUVTt0wCIQ4jCwMLXibEhnv1BlatIM+K0+wiEEpGvEjte
         QjXJRGLHLx/6ANL43WG4iaA7G+f5WhN0l9TZdICklewsdqGuabEPOPhjZwmyH5T4QSPn
         5df73ZZJbEnxmULQhsAvVLd61d9Fc/W9AwuYWOEyP0uD40xf/td0jCGpbEF+9EVKgMNx
         v+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/CHwmtPKS9YFQVceEU95L1dygwbhvLKGuEbY6OKojw=;
        b=EJQyj3MCPSrRvTeCYSRxHzuR4UBEjRx7CV6PdTNgz0fZdMtIE1a9NO9VpZ7AIb+OOu
         yYF/8+VNtvxI+SBO7MZ0akG5c7PDETtAdeKrfIPOR4onAErkuY34EhNG+At5dzBN8X6d
         7F0Po+A85gOfvkDonba10ag47SdW1TjxGoS0B0qFk7CUqNTZhkPi9jzGnR/DddmixBwq
         EjAk2eK07MMUWknxto+E3Y569bhmUDIX5t5cZA3DDZwNLjD8Xm9UB+d42eh+sQYq6ypC
         beAbTD2Mxc2sxWhC9KbVsKGNSWWM6Zupxg+Sa1FZF8hhyG4EF4pYjnms0e1StPGxYIOG
         OooQ==
X-Gm-Message-State: AOAM533I0DQegdyYo7yi059I1Z/pSAFpmZAuJgLIQF7a6B2rUoifkguK
        ujIWxfRJb+JVvreD+mzMyJM39Nk2p/s=
X-Google-Smtp-Source: ABdhPJxrW6dSPmq+6bBqrHhbGEkt++JXBn2/b6USAeH0BnRFnTJW52SXHZXOimNZzUI1sZ5hZpT4Sg==
X-Received: by 2002:a9d:75d5:: with SMTP id c21mr50145659otl.201.1641758729265;
        Sun, 09 Jan 2022 12:05:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i27sm1070319ots.49.2022.01.09.12.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 12:05:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <3b5c9b693749a956b525c54bed0eeac9f958b8e8.1641734402.git.christophe.jaillet@wanadoo.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] fsi: Aspeed: Fix a potential double free
Message-ID: <5ecd3555-092c-e11d-deb4-98da7c0e3e01@roeck-us.net>
Date:   Sun, 9 Jan 2022 12:05:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3b5c9b693749a956b525c54bed0eeac9f958b8e8.1641734402.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 5:20 AM, Christophe JAILLET wrote:
> A struct device can never be devm_alloc()'ed.
> Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
> embedded in "struct fsi_master_aspeed".
> 
> Since "struct device" is embedded, the data structure embedding it must be
> released with the release function, as is already done here.
> 
> So use kzalloc() instead of devm_kzalloc() when allocating "aspeed".
> This prevent a potential double free().
> 
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Keep the release function which is correct
>      s/devm_kzalloc()/kzalloc()/ instead
> ---
>   drivers/fsi/fsi-master-aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 8606e55c1721..ae6319818b14 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -542,7 +542,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   		return rc;
>   	}
>   
> -	aspeed = devm_kzalloc(&pdev->dev, sizeof(*aspeed), GFP_KERNEL);
> +	aspeed = kzalloc(sizeof(*aspeed), GFP_KERNEL);

Unfortunately it isn't that easy. error handling in the probe function must take this
into account and free the memory. Looking at that exposes another bug: The
failure in opb_readl() should not result in a direct return but disable and
unprepare the clock.

Guenter

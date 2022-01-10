Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B975489DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbiAJRBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiAJRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:01:52 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2FBC06173F;
        Mon, 10 Jan 2022 09:01:52 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id z4-20020a4a6544000000b002dcc183d269so595623oog.0;
        Mon, 10 Jan 2022 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VTsNFD8ufMgqU79bIUrjECxCclPEWbm2hm+vnChWZXM=;
        b=plQ/CWUJrpfSgHU6Atj50/gxRuCGAyCboQDIlgROE7Of8AX7yc41PSYXggsF7er3Bx
         vE4cvQEeOeeSDucLt3cTCJ4WA6ajw1CmtQvqnnqpj25LQ6qbUBh1UAxzaNIhk2AlfNt2
         EdYCh2WZRKbh7wzYOec/zBQb/TfvHbx/tCkRgEKJFdCrNSDTVtQuRyFfH1OiB8nCHGg6
         y3293TMBS3bK6d0wZRnKS1P99py7UU20tj+Y+jFvqel0y8/gKh91fKC6yJtdB/xSlY8y
         f0LWyghGWdGARPE2i2Ua/8DTP3xSQxB6wfX8FEWcSIWfh1dWCo9a8yEpAsd1DWm2J2Cg
         azCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTsNFD8ufMgqU79bIUrjECxCclPEWbm2hm+vnChWZXM=;
        b=qfT2R6Fs8tPJPK7XlDEVn6kNgm/W0/mGC7caXc2237JUhNH9RwKj5O5HbEtogMDHWM
         NXG8MGgijB+2JIoSfGHTXtDKRqPHFFVmxs0Ddgv5zfMS63fx8QZmDFQrGtVF6w7k2mCq
         XTx2fH39Ox6/ojztuM/9Rc3T+wxqwuAlvDcKBdNfqSQ5kw/vRxT4rRb2yf8fAFCXhfcy
         LyM7FHwZp2NdUtesrUXuaHI5+7gAgs8gfKUDxcgaXAFbqiz6opKFC1CeYul8W4E6HZ/q
         FmeOAur3QWApG7A8TvHGh3C0wBkXp3X8yG5DFPvu7XGFBr5Sy/tzxOLtN0KTGx/a3V+Q
         p38A==
X-Gm-Message-State: AOAM532KAaSjt7DLWdPpzu+kmw1n5TaTzC3pYDr3jNGUi8L5M4xH7UVC
        P7zfPlv6tMWBz8mDfyNzsbg=
X-Google-Smtp-Source: ABdhPJxgJOizK1UP1nsBC3SEo0XlONewAe7hjDBNaJcVmVFQs3lLJvUDPyoWNN1+CIGUxjwojhUJDQ==
X-Received: by 2002:a4a:d98c:: with SMTP id k12mr458360oou.82.1641834111057;
        Mon, 10 Jan 2022 09:01:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 97sm1551572otc.10.2022.01.10.09.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:01:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3] fsi: Aspeed: Fix a potential double free
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3c4ff68f-3686-bcc6-c370-0732860b4d80@roeck-us.net>
Date:   Mon, 10 Jan 2022 09:01:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 1:56 PM, Christophe JAILLET wrote:
> A struct device can never be devm_alloc()'ed.
> Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
> embedded in "struct fsi_master_aspeed".
> 
> Since "struct device" is embedded, the data structure embedding it must be
> released with the release function, as is already done here.
> 
> So use kzalloc() instead of devm_kzalloc() when allocating "aspeed" and
> update all error handling branches accordingly.
> 
> This prevent a potential double free().
> 
> This also fix another issue if opb_readl() fails. Instead of a direct
> return, it now jumps in the error handling path.
> 
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: Keep the release function which is correct
>      s/devm_kzalloc()/kzalloc()/ instead
> 
> v3: Update the error handling path to free "aspeed" [Guenter Roeck]
>      Fix another issue when opb_readl() fails [Guenter Roeck]
> 
> I hope that fixing both issues in the same patch is ok. It makes no sense
> to me not to update the goto to the correct label if opb_readl() fails.
> ---
>   drivers/fsi/fsi-master-aspeed.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 8606e55c1721..0bed2fab8055 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -542,25 +542,28 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   		return rc;
>   	}
>   
> -	aspeed = devm_kzalloc(&pdev->dev, sizeof(*aspeed), GFP_KERNEL);
> +	aspeed = kzalloc(sizeof(*aspeed), GFP_KERNEL);
>   	if (!aspeed)
>   		return -ENOMEM;
>   
>   	aspeed->dev = &pdev->dev;
>   
>   	aspeed->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(aspeed->base))
> -		return PTR_ERR(aspeed->base);
> +	if (IS_ERR(aspeed->base)) {
> +		rc = PTR_ERR(aspeed->base);
> +		goto err_free_aspeed;
> +	}
>   
>   	aspeed->clk = devm_clk_get(aspeed->dev, NULL);
>   	if (IS_ERR(aspeed->clk)) {
>   		dev_err(aspeed->dev, "couldn't get clock\n");
> -		return PTR_ERR(aspeed->clk);
> +		rc = PTR_ERR(aspeed->clk);
> +		goto err_free_aspeed;
>   	}
>   	rc = clk_prepare_enable(aspeed->clk);
>   	if (rc) {
>   		dev_err(aspeed->dev, "couldn't enable clock\n");
> -		return rc;
> +		goto err_free_aspeed;
>   	}
>   
>   	rc = setup_cfam_reset(aspeed);
> @@ -595,7 +598,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   	rc = opb_readl(aspeed, ctrl_base + FSI_MVER, &raw);
>   	if (rc) {
>   		dev_err(&pdev->dev, "failed to read hub version\n");
> -		return rc;
> +		goto err_release;
>   	}
>   
>   	reg = be32_to_cpu(raw);
> @@ -634,6 +637,8 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   
>   err_release:
>   	clk_disable_unprepare(aspeed->clk);
> +err_free_aspeed:
> +	kfree(aspeed);
>   	return rc;
>   }
>   
> 


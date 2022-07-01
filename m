Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5868356396A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiGASxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGASxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460412AED;
        Fri,  1 Jul 2022 11:53:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so3170145plx.3;
        Fri, 01 Jul 2022 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ALIXnT5ACOz0FPfyJRx1dS7PXpKa9vFRkd+lw6KGeVg=;
        b=nVeyzp2zvKASw7rCldxvQDx34Bg0xlYf39xQkc4Q9QTOobfCr7QT7AaWB2s6RhM30v
         LnyU/CaIlUOwM2hT3Qw55Bn0c3zJKPjRtlpc/XtEHz7UbFRQgxii3pp+ND0B48MLR6Wr
         va8+BpmLzHv02tzoktFRKak/LFqvn/WfiKlyolfCMysd4WD2G8AiYTsrZXS+fVKRwdzX
         SKhtim1Sm6XdYBA+9ycEqbBl10mPQ8nj0/5cn+OXWWjwJdkWcvB5UIhC+GJ1W51R/vaQ
         iSUPYaxFFs5L4kYbZkPiUmjvrB52+i1bIwr1HaMqRRwpTa2R2v8up1iEcJaQK3DlPy5A
         5WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ALIXnT5ACOz0FPfyJRx1dS7PXpKa9vFRkd+lw6KGeVg=;
        b=qErDd+Y457n+BVVrYmSpPmKLTt/tr5/f+yPe6KvTHz9wcvooG1ojLilcscAtf8frMa
         pXyZtTu3IdS62tXscEaXgvcmQBtcy/uDYvwP62iao9aVVFyo7gnSUqNSVH2g/qEc/Bkl
         oap+6Sit2ZK08hF9rNMnrDNxAtbnqhgnhKE24v3JSA2EIz7Cc3MX+Rm97KX0ovGF9TVm
         exghWCOMWexPtQ9bFv4f4ScgUVAineZhDIkKMPJYgsKWGEdY0r1b9tuo0LN+WBlN6xcK
         T/j1pZiIn/cljeGYtgozcrRxDJQB0GlP1sGSrQIiuyNlFengiIbqh9s0Ia/qp6bEQhmh
         0cUQ==
X-Gm-Message-State: AJIora/xGoHcealcfvwn2lcZohKaamjCeEwsddwoL0kh2lMDPhwFYt4H
        BePAWTwuaxc6lJWTsX4bQi8=
X-Google-Smtp-Source: AGRyM1sHIHJ7C1oo7K5ZfTr6dk0bsuhDqW3WQyFWuDql7yoTwBfA6BNW59rfnLgdtxtESQk3Qs5spQ==
X-Received: by 2002:a17:90a:7c05:b0:1ee:e40c:589b with SMTP id v5-20020a17090a7c0500b001eee40c589bmr18405296pjf.78.1656701625920;
        Fri, 01 Jul 2022 11:53:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cp9-20020a056a00348900b005184d1e838dsm16244011pfb.12.2022.07.01.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Jul 2022 11:53:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH] hwmon: (ibmaem) don't call platform_device_del() if
 platform_device_add() fails
Message-ID: <20220701185343.GA2981066@roeck-us.net>
References: <20220701074153.4021556-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701074153.4021556-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:41:53PM +0800, Yang Yingliang wrote:
> If platform_device_add() fails, it no need to call platform_device_del(), split
> platform_device_unregister() into platform_device_del/put(), so platform_device_put()
> can be called separately.
> 
> Fixes: 8808a793f052 ("ibmaem: new driver for power/energy/temp meters in IBM System X hardware")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ibmaem.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
> index 5c4cf742f5ae..157e232aace0 100644
> --- a/drivers/hwmon/ibmaem.c
> +++ b/drivers/hwmon/ibmaem.c
> @@ -550,7 +550,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
>  
>  	res = platform_device_add(data->pdev);
>  	if (res)
> -		goto ipmi_err;
> +		goto dev_add_err;
>  
>  	platform_set_drvdata(data->pdev, data);
>  
> @@ -598,7 +598,9 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
>  	ipmi_destroy_user(data->ipmi.user);
>  ipmi_err:
>  	platform_set_drvdata(data->pdev, NULL);
> -	platform_device_unregister(data->pdev);
> +	platform_device_del(data->pdev);
> +dev_add_err:
> +	platform_device_put(data->pdev);
>  dev_err:
>  	ida_free(&aem_ida, data->id);
>  id_err:
> @@ -690,7 +692,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
>  
>  	res = platform_device_add(data->pdev);
>  	if (res)
> -		goto ipmi_err;
> +		goto dev_add_err;
>  
>  	platform_set_drvdata(data->pdev, data);
>  
> @@ -738,7 +740,9 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
>  	ipmi_destroy_user(data->ipmi.user);
>  ipmi_err:
>  	platform_set_drvdata(data->pdev, NULL);
> -	platform_device_unregister(data->pdev);
> +	platform_device_del(data->pdev);
> +dev_add_err:
> +	platform_device_put(data->pdev);
>  dev_err:
>  	ida_free(&aem_ida, data->id);
>  id_err:

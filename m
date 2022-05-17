Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F14C52A1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbiEQMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbiEQMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:50:52 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD322BD8;
        Tue, 17 May 2022 05:50:51 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so23999427fac.7;
        Tue, 17 May 2022 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GysULI/ZfZDq/ifdK02cU3IT0z2WzCFl4Ysj82w0CZc=;
        b=iZsrBbCas+XJD6+nJaJpieDcMF16GM0aHjZBjAa2oM8Vsfc06zUIkK+Ner+bskKUo/
         Mlm4ArfdVZwBhOlP2Vk3Md6plAS3sTYWEHcJIgt9r2AYs9liKUV04daeJUTEBkQuKewk
         H5qtc22tfUPdbAWErW5qNZ3HDxeX57p5F2QWWg1PWury8c9n3yr5ucrDA3pwheN7PehK
         5p8NFHY8/PBIgYmWROyngSmq3Cfu/nQ5XKB3KSZbIFeVMHvxXR/+My9sYvGNy7tMSslW
         ZiDn76RPxP4Kbj2PJD5abUhTUZ+sfXiGZxPaZF97lFwy5eJ7g27472dZ+iQLLsn1J98Z
         AH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GysULI/ZfZDq/ifdK02cU3IT0z2WzCFl4Ysj82w0CZc=;
        b=FxZ3WtnNc9zgcrwPnwl/7ebWIDdhjFPyltRFQVaPHFagoLgcpzfI+5dRJpQd7QbKav
         FJ4H/K3+u4MsKLLVadupobGHvCtpeMUVtiq1PRD15Kp5w70spntP7v8k9+7MHTUYlRoc
         +8FFN1d9y3BRGzs8Ki5EnJUFqEvL4/1o282L+wWSIkuuR8pbHNKlW3s5EcFYdVzNTEVR
         5JxsK9oQMeA+v3vo9VSi3vMeqyG9bYiCJFxzB3oKFw1vgxHSSXXiMExpr+IqKhQ8LZ2m
         bOwKTUcY/gjeoVSGKIbIpA1a8le+dp06TtkH+50BmB7KXjVlt2+W89VlSbrkjUSEfqv0
         +YZQ==
X-Gm-Message-State: AOAM530dOkKcvvMZiHGf2A4DFpZa5z4HlU2ppgj1TSxk+MbiU2lRs2eh
        v6d8WREsfRbs/UdN4Ft4zH2+P8WHn0EOKQ==
X-Google-Smtp-Source: ABdhPJzreh3KBieNutd7OK8er9g6pj2PFaeO7uFVsgfU9iy3fXyZh8bCuur0K9hRaLFP5at8Vb7Q8w==
X-Received: by 2002:a05:6870:796:b0:da:3d6a:101d with SMTP id en22-20020a056870079600b000da3d6a101dmr12384297oab.20.1652791850764;
        Tue, 17 May 2022 05:50:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21-20020a4ad5d5000000b0035eb4e5a6c9sm5146019oot.31.2022.05.17.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:50:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 17 May 2022 05:50:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     keliu <liuke94@huawei.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Directly use ida_alloc()/free()
Message-ID: <20220517125049.GA3500570@roeck-us.net>
References: <20220517063126.2142637-1-liuke94@huawei.com>
 <20220517063126.2142637-2-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517063126.2142637-2-liuke94@huawei.com>
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

On Tue, May 17, 2022 at 06:31:26AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Applied, after updating subject to include the driver name.

Guenter

> ---
>  drivers/hwmon/ibmaem.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
> index de6baf6ca3d1..5c4cf742f5ae 100644
> --- a/drivers/hwmon/ibmaem.c
> +++ b/drivers/hwmon/ibmaem.c
> @@ -482,7 +482,7 @@ static void aem_delete(struct aem_data *data)
>  	ipmi_destroy_user(data->ipmi.user);
>  	platform_set_drvdata(data->pdev, NULL);
>  	platform_device_unregister(data->pdev);
> -	ida_simple_remove(&aem_ida, data->id);
> +	ida_free(&aem_ida, data->id);
>  	kfree(data);
>  }
>  
> @@ -539,7 +539,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
>  		data->power_period[i] = AEM_DEFAULT_POWER_INTERVAL;
>  
>  	/* Create sub-device for this fw instance */
> -	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
> +	data->id = ida_alloc(&aem_ida, GFP_KERNEL);
>  	if (data->id < 0)
>  		goto id_err;
>  
> @@ -600,7 +600,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
>  	platform_set_drvdata(data->pdev, NULL);
>  	platform_device_unregister(data->pdev);
>  dev_err:
> -	ida_simple_remove(&aem_ida, data->id);
> +	ida_free(&aem_ida, data->id);
>  id_err:
>  	kfree(data);
>  
> @@ -679,7 +679,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
>  		data->power_period[i] = AEM_DEFAULT_POWER_INTERVAL;
>  
>  	/* Create sub-device for this fw instance */
> -	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
> +	data->id = ida_alloc(&aem_ida, GFP_KERNEL);
>  	if (data->id < 0)
>  		goto id_err;
>  
> @@ -740,7 +740,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
>  	platform_set_drvdata(data->pdev, NULL);
>  	platform_device_unregister(data->pdev);
>  dev_err:
> -	ida_simple_remove(&aem_ida, data->id);
> +	ida_free(&aem_ida, data->id);
>  id_err:
>  	kfree(data);
>  

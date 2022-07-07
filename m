Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA6569D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiGGIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiGGIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4C1D4F18D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657183075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgjCMYYYYbD+7nzC3JNyNoJAUPo1OhUBmzurjGPS2hA=;
        b=GhPO+/FpYTfr1trb+0kQy1gN10vnPxSy4Tk5HDbZMmYbNs9y1+kL5ma1ulqox5UOS/y290
        0zdCeNVk/mQNlRFuVhnFT8jRwp2Xp/MtoQUUDpMXtM9DYIahHI7AyI7aoyU6UOAIFnqpqS
        9fLKHCu/kF7eg85qca/7+Ap09mvW5eg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-ihXiGNwSP5OIYoUryPRazQ-1; Thu, 07 Jul 2022 04:37:46 -0400
X-MC-Unique: ihXiGNwSP5OIYoUryPRazQ-1
Received: by mail-wr1-f71.google.com with SMTP id h6-20020adfa4c6000000b0021d6a5ac938so2284564wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JgjCMYYYYbD+7nzC3JNyNoJAUPo1OhUBmzurjGPS2hA=;
        b=hcJA6AHzJ4jFWL0q9uhhoHbCEqFJgqdUUfBmZkheZRjG88/83KuGTaIxYSFgv2zuc1
         cZkXBYI5yIt1Uack0vqBGM2egHpUSeiuv//uslVPKkJ9yavtX3USyfM7RJwfDS1unMm5
         BjYFZqUwL1OvsGr88DsvESx3HzlhBCpF0aA/O9v7gvyYmhvBRKddt0cDWyBpTtOJLMaj
         BonNTAyUkxDxpr4JJdd4UGKaROT9l9pbkLNKP/iT/CUVBLkRNQeyrFXVrVTAwyvEs4UE
         i/76fsh1JvQAOSxKf+BEij3bmgS+cE/r072euReh7a4su3bmZIjPYRmOm5TlKz3X8FjH
         r20Q==
X-Gm-Message-State: AJIora+i2EKnppjbYffFLMediqmiutFrZJvycmRZZa4hIm6wmLSL3TzM
        XmY6/XgPmbzdgOpGrBSuL9Qu1sR6iPNbPT6l/8E4YAdu1R+/a3i+Qonu10dn70T7k+wP7DvG7rV
        GkPGocSWVIhSxn2FFxEA1hFyj
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id e5-20020adff345000000b0021d6a266d8fmr20062524wrp.538.1657183065410;
        Thu, 07 Jul 2022 01:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vGDFTJizoTec2RmWMWm7DPKvwwJtfgBlSf/7G51X5GmjZNAHupXyU1auc5WNVNR/wUiRxmyA==
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id e5-20020adff345000000b0021d6a266d8fmr20062507wrp.538.1657183065164;
        Thu, 07 Jul 2022 01:37:45 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm28347968wmh.39.2022.07.07.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:37:44 -0700 (PDT)
Message-ID: <2ae24b07-92ae-8bdb-8b2d-f90a4a9557a9@redhat.com>
Date:   Thu, 7 Jul 2022 10:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/ssd130x: Fix pre-charge period setting
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>
References: <20220706184133.210888-1-ezequiel@vanguardiasur.com.ar>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220706184133.210888-1-ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ezequiel,

Thanks a lot for your patch.

On 7/6/22 20:41, Ezequiel Garcia wrote:
> Fix small typo which causes the mask for the 'precharge1' setting
> to be used with the 'precharge2' value.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index 08394444dd6e..f4886e66ff34 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -350,7 +350,7 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
>  
>  	/* Set precharge period in number of ticks from the internal clock */
>  	precharge = (SSD130X_SET_PRECHARGE_PERIOD1_SET(ssd130x->prechargep1) |
> -		     SSD130X_SET_PRECHARGE_PERIOD1_SET(ssd130x->prechargep2));
> +		     SSD130X_SET_PRECHARGE_PERIOD2_SET(ssd130x->prechargep2));

It's a typo indeed. Nice catch!

I wonder how did you notice this. Or was it just looking at the code ?

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

I'll push it to drm-misc (drm-misc-fixes).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


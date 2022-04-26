Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2350ED1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiDZAHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiDZAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:07:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D20F120119
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:04:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z21so6990005pgj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z9QTfPEdNt7JQOIWUONiQTqO8yM80epu2UVE3WUl/gA=;
        b=QVTDqW7TKujYmgayHDbv6/fzCFgt27b3Vh9LK/YCh30dTYvrir3aM3gH78rtiItMe/
         U916AySKAFtvUvtqj0M0TIcxkVWEn0X6CEVU5ad9N3l2SC9EiXlygUrR6L+Vol3VpVcL
         qGcvO4oWHQ1joufWbwAx7GT7NY/gSiQ16W8y45zTQ8pr6CFH+zszleXbzNcKB6SQl6Cy
         arnFXWURGDgQ2dGrBw6ZgLg7a2fRm+ZKt8GG2Tw3yAh8r2felQiCwdZRYMPNbwokykjt
         tx44TDE+yC7YZqWybGZoYBHm+gd3kYEOFXzGpMUsJHKfz54IC8rFm4ROj0wLYE99lC4+
         Wenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z9QTfPEdNt7JQOIWUONiQTqO8yM80epu2UVE3WUl/gA=;
        b=N+9r37YIxFjXYVIxNp1T46SLRHk7eqGf8usqSu3EMCgFvhcEC5yVjO6xNsxrf/gs9o
         rK4O9W34oKUQ5Vv1GGjVmims6Tmg36BXXrdoFZEa18Siax9wx2E1Iw1qRuNbIlNQ57Jg
         OfqIGeoDLb4lWSuOprTKgeFNbT06Uyh8n8KPrG3ue7zeqrNcS++X7oycc5BFgF5etSQw
         O/nEwdMxhAyMGR/giTpEWnYv2wOhoxcMu2VG7sp3bQRXQE26PdfdYfXg1zoscB2R+lIl
         UzZUGb+l5tHbUIRbjucE6WqAaATG4TkDC2QVnk3LcLSU4HhpAS8XpHIaPtYb8tIn88Yt
         vsKg==
X-Gm-Message-State: AOAM532Pt+0G8UdI72Yg2C9FhzS/3B7LXhXbhtfEv72KpaNviO5dj+bk
        x5tuQjrbxvgyVCh70Uw6XAQ=
X-Google-Smtp-Source: ABdhPJwutB/SDQnrCRjd6WN6AYa+S1O8tVU8JiUVHbSPM5/1z6dGrlaybKhKtXjOwTUR+6OIZmjAtg==
X-Received: by 2002:a63:c52:0:b0:3aa:2c45:67ba with SMTP id 18-20020a630c52000000b003aa2c4567bamr17662438pgm.102.1650931462805;
        Mon, 25 Apr 2022 17:04:22 -0700 (PDT)
Received: from [172.30.1.9] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm10527313pgp.15.2022.04.25.17.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 17:04:22 -0700 (PDT)
Message-ID: <974e0c5e-7929-80fa-e3b5-e9394a5e55b0@gmail.com>
Date:   Tue, 26 Apr 2022 09:04:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] extcon: ptn5150: add queue work sync before driver
 release
Content-Language: en-US
To:     Li Jun <jun.li@nxp.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
References: <1650372249-10787-1-git-send-email-jun.li@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <1650372249-10787-1-git-send-email-jun.li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 4. 19. 21:44, Li Jun wrote:
> Add device managed action to sync pending queue work, otherwise
> the queued work may run after the work is destroyed.
> 
> Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Li Jun <jun.li@nxp.com>
> ---
> change for v3:
> - Add Fixes and R-b tag.
> 
>   drivers/extcon/extcon-ptn5150.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 5b9a3cf8df26..2a7874108df8 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -194,6 +194,13 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
>   	return 0;
>   }
>   
> +static void ptn5150_work_sync_and_put(void *data)
> +{
> +	struct ptn5150_info *info = data;
> +
> +	cancel_work_sync(&info->irq_work);
> +}
> +
>   static int ptn5150_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct device *dev = &i2c->dev;
> @@ -284,6 +291,10 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>   	if (ret)
>   		return -EINVAL;
>   
> +	ret = devm_add_action_or_reset(dev, ptn5150_work_sync_and_put, info);
> +	if (ret)
> +		return ret;
> +
>   	/*
>   	 * Update current extcon state if for example OTG connection was there
>   	 * before the probe

Applied them. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

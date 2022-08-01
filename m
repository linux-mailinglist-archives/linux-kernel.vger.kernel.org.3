Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2A586683
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHAInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiHAIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A28A92F67B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659343406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3i6pwGdNM6VDz01s67215+TlpW84N+K//9kro6Oejc=;
        b=PvVYnmqFj1H2jgzH3csnaU/Vjy6sSrXdCqoq4vTxekXIxBOPkzS2lwgiICXUh/Hr6da7Zv
        4+d58UOfVx6n3CVKEo8wQhUFOfGzYFouAwdZSTu4XL0+WCJrX5TBwfkrMQ8JKExqUVlR0s
        fasDM7MqvOs2M6Q/Wz7gxN3SdNM94Kc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-Hy-wilORMg-nBbVjlpXJkQ-1; Mon, 01 Aug 2022 04:43:25 -0400
X-MC-Unique: Hy-wilORMg-nBbVjlpXJkQ-1
Received: by mail-ed1-f70.google.com with SMTP id z14-20020a05640240ce00b0043c25c21e94so6716814edb.14
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J3i6pwGdNM6VDz01s67215+TlpW84N+K//9kro6Oejc=;
        b=eQ/9hTFjURyzJNIR/CKNMWn3GRdzBlLOoDOmTorJbTn8tHNHaIHKNzbzrz8WgxADBw
         ewCTwHMCDtzuTYdP7hrDqWyWDOQCwi9XjZyv5H4KZt3p+dWgBqI3FvkTq05J0kvHh07c
         LCoEUO+NwIqTJb5tDx6pex2H3EvUJgwhFtvci9lNWH21sg/xFKgPv5mmHjEqFXxTSHgD
         kqlIPegoTMC08tHhi2p7Cfo+cR6ycvIL2zCfSXKKyvb7+NaXmDQsgS2Fjsygtunet/hU
         qOCSpHhmc0QcUhomMueq8Ve5Z3xtfDADLqZy5pX+76lpVEOhdrt6uBIbHfUyuG6IVv4F
         qggg==
X-Gm-Message-State: ACgBeo2RFVZkjRc9DaOdPwaMXipIjkjCWFdcZbKL/WiEaZUvDcJu73JG
        Tvb1HocMFHL4DAyjwIlv/uE0WTRK8AGa44yQ4Kqhg9Gjf9ezhVJ2G/+tMbP9kZESM6oi5Iq8Bxb
        ggkQaTIX3VnZgAfazU6RZ+WEo
X-Received: by 2002:a05:6402:5192:b0:43d:cc0d:6ea4 with SMTP id q18-20020a056402519200b0043dcc0d6ea4mr1013190edd.111.1659343404183;
        Mon, 01 Aug 2022 01:43:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6IUPlZvCMIqJII3dXp/+0eBLBAz+Jftd/jLe5BORSnP938CcG0NY9DMu5NNXLY1sef44akqQ==
X-Received: by 2002:a05:6402:5192:b0:43d:cc0d:6ea4 with SMTP id q18-20020a056402519200b0043dcc0d6ea4mr1013184edd.111.1659343404039;
        Mon, 01 Aug 2022 01:43:24 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm6477350edy.20.2022.08.01.01.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 01:43:23 -0700 (PDT)
Message-ID: <9b9abdf0-7cd5-df51-adbf-2225291f0dd2@redhat.com>
Date:   Mon, 1 Aug 2022 10:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 01/10] mfd: intel_soc_pmic: Fix an error handling path
 in intel_soc_pmic_i2c_probe()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/31/22 22:12, Andy Shevchenko wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> The commit in Fixes: has added a pwm_add_table() call in the probe() and
> a pwm_remove_table() call in the remove(), but forget to update the error
> handling path of the probe.
> 
> Add the missing pwm_remove_table() call.
> 
> Fixes: a3aa9a93df9f ("mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC PMIC based PWM")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch
> 
>  drivers/mfd/intel_soc_pmic_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
> index 5e8c94e008ed..85d070bce0e2 100644
> --- a/drivers/mfd/intel_soc_pmic_core.c
> +++ b/drivers/mfd/intel_soc_pmic_core.c
> @@ -77,6 +77,7 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
>  	return 0;
>  
>  err_del_irq_chip:
> +	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
>  	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
>  	return ret;
>  }


Note alternatively we could just move the pwm_add_table() to just before the "return 0",
there is no strict ordering between adding the mfd devices and the pwm_add_table()
(the pwm device only becomes available after the pwm-driver has bound to the mfd
instantiated platform device which happens later).

IMHO that would be a bit cleaner.

Regards,

Hans


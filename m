Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2388595A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiHPLpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiHPLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:44:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C30895D3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:16:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x10so10185514ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=vxhUXo1uEQJMnS2dZ0psgwOJl8jAChRYRa0xNGSk+nE=;
        b=jADfo7N+5CWzn+QQpHnZrdsZNzFLWzAhD8S8cqugx6QriISxUPkfuk8nlE1fI0P1ep
         6v5haewQD2r6YZFnmTzjOKvD+R4ijmGNb31x00BKIqQAKeLRn+Zg6OC4Onf9IaBM0UNw
         vieBweV8bCQ5HaMa4IA+qiRjJTYqNk7jtdFg6LI05uewzd18TThzQFEJ3CcYQ8SKUlcP
         R7y5t2zI4+A6M3pBsEz4kq/I5LAZC9NEF5yzqUJGlTGdIP3Z8fABJZtAS4orYLIZ8283
         zTK0/S4/skJ5nZFV6fmbo8y98fCfnV552cKnVdydclCc7xAAl7fE1dB+xB46WA6qCkCA
         la8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vxhUXo1uEQJMnS2dZ0psgwOJl8jAChRYRa0xNGSk+nE=;
        b=VF4JizUAovw1XYeK5VvMu9720ZkKpoiBXApLfMKMQ7iQ79IDRu5Lt2YXGInpOjCnon
         n2HjEBIY5W8fWyGJo2DC5geZmg2wrHmO9b3bfQOfLqMU8AWIh5Tf6DsVwtHl/VHS15Mt
         8yTV7CV7vu3qfAFnOKIBfOxeeG6/KLaZova3fTWpa8IR/IqiI2+uFYDI0BhZluNatndN
         nXtePtzuL8+GqShGsqUDratuyzGZub9etHNVwAVp/9nEg9sSlM6JbGLxET1O/o6QMv+p
         zjUc7uoS7xVKp6kjc3ODoljgnBlE50hfss2EPpOtHTAQK/u/bzfhXy23b7wR281bvuGJ
         AH7w==
X-Gm-Message-State: ACgBeo0MImLVKW6cklcH/IOhX7b8S6hwquQsbG6elBo3T8R8MSkkwd7q
        xW8Bl9dQ63jCYj+f6npzCmbzKA==
X-Google-Smtp-Source: AA6agR5uHRjZuOPTilLXcUIIBtaqcmsgT5CliKeRdvVBEEXgR6NVMyVbDgl4VvLQ1QopbxeRTY9XAg==
X-Received: by 2002:a05:651c:2003:b0:25e:5c53:8915 with SMTP id s3-20020a05651c200300b0025e5c538915mr6768030ljo.88.1660648575280;
        Tue, 16 Aug 2022 04:16:15 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id z8-20020ac24188000000b0048dacaa8c32sm1352391lfh.254.2022.08.16.04.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 04:16:14 -0700 (PDT)
Message-ID: <8cf4ea9e-89a4-1ab0-334b-9ecc5b1e6f25@linaro.org>
Date:   Tue, 16 Aug 2022 14:16:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] drivers: iio: accel adxl312 and adxl314 support
Content-Language: en-US
To:     George Mois <george.mois@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lucas.p.stankus@gmail.com
References: <20220816102828.182345-1-george.mois@analog.com>
 <20220816102828.182345-3-george.mois@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816102828.182345-3-george.mois@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 13:28, George Mois wrote:
> ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
> with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
> respectively.
> 

Thank you for your patch. There is something to discuss/improve.

>  
>  static const struct spi_device_id adxl313_spi_id[] = {
> -	{ "adxl313" },
> +	{ "adxl312", ADXL312 },
> +	{ "adxl313", ADXL313 },
> +	{ "adxl314", ADXL314 },
>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
>  
>  static const struct of_device_id adxl313_of_match[] = {
> +	{ .compatible = "adi,adxl312" },
>  	{ .compatible = "adi,adxl313" },
> +	{ .compatible = "adi,adxl314" },

You miss here driver data. I don't remember which driver matching takes
precedence (especially in various cases like DT platforms with device
instantiated by MFD), but for consistency I think both device id tables
should have same driver data.


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA6595D78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiHPNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiHPNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:35:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E95FF54
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:35:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x10so10545077ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=l6nDADBjMLXXabAdXHL54a9YsxELBvhvNG69Fueawt8=;
        b=AypiaX9GE9ohiT5OplXec0g1QK9jSNWYVLMfSfzoO1QMdQz4qEepnq7ZP031DF2RWW
         UT86RkjDnQ+Y4SElJShDf/UTrdmfNJxXcZHhDbRVP81Z7MHqaKya0xRZ6nKb0fHfhNdA
         rCRu8pIYDGYXeDcbrO3l6HdmgFw4yEjiVembQ+XVvBt+GkrxvqrajEmwlgmaB1WeKj/S
         KrHvpIL4JhEywXcRxi25qjhSzNxbBLxlq1Yue6CUN3p8H2zWc0XO1PSP2+FvXe7tO4SZ
         PQbRMbkD1TETYOtDAM7kgmjlekvD9aVRyGVee56X//cfOYNl/9uflZPKgigXfkbTOdWt
         c4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=l6nDADBjMLXXabAdXHL54a9YsxELBvhvNG69Fueawt8=;
        b=m/Qbtpt9BitwXW8R1BHX11HqSR5FwE936OVcKW/wAZM8lQ5Afu7JueCkomlLqI6G2e
         /+wPeA2VZYaBydgd0IoS1tEqUOpvFcdRzvUyniVMSOR+n/EfrSLCmupkAtfcuw06H/VC
         oGzz3Xc3wuXnNAJVdU9FESVmFbxCBlNG9PyK+npG4GKD3+JZUNgpoZcJ+FjvF4WzVWSH
         MNpzcIp64EGjSKRY/iBNQo+Qqaiqwk1WXHLFDKGdcwTQsPbz+yRFZkVBpUXL1AWDXDit
         ixQByWu8YXlU6VyGBxZU7Z4u3c68t7gibcp+XdGPh6qk4AgR2IWmIhorMrnxxixHAqc/
         NNAg==
X-Gm-Message-State: ACgBeo0K6IHoJTMbZ3RTmDbBCpXH0EVO+IQNUO3fLRWoltLqIZb/n8Xy
        LZ20NCv1L7Dk96EmqlnedIQdnA==
X-Google-Smtp-Source: AA6agR5v3ygrD6/3SSaGTzld9LcL/B2gC0AlXy9+Q9CchsMPWhsbA4kz9kvM3fSXJdORJtUDVYmXkA==
X-Received: by 2002:a2e:9797:0:b0:25e:4cfe:6c3d with SMTP id y23-20020a2e9797000000b0025e4cfe6c3dmr6541106lji.280.1660656901029;
        Tue, 16 Aug 2022 06:35:01 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id z5-20020a056512370500b0048afa1464c0sm1395969lfr.66.2022.08.16.06.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:35:00 -0700 (PDT)
Message-ID: <a882c594-564c-7e0c-0ede-aa27fcf8c79d@linaro.org>
Date:   Tue, 16 Aug 2022 16:34:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] drivers: iio: accel adxl312 and adxl314 support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     George Mois <george.mois@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lucas.p.stankus@gmail.com
References: <20220816102828.182345-1-george.mois@analog.com>
 <20220816102828.182345-3-george.mois@analog.com>
 <8cf4ea9e-89a4-1ab0-334b-9ecc5b1e6f25@linaro.org>
 <20220816134433.00002900@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816134433.00002900@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 15:44, Jonathan Cameron wrote:
>>>  
>>>  MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
>>>  
>>>  static const struct of_device_id adxl313_of_match[] = {
>>> +	{ .compatible = "adi,adxl312" },
>>>  	{ .compatible = "adi,adxl313" },
>>> +	{ .compatible = "adi,adxl314" },  
>>
>> You miss here driver data. I don't remember which driver matching takes
>> precedence (especially in various cases like DT platforms with device
>> instantiated by MFD), but for consistency I think both device id tables
>> should have same driver data.
> 
> You can set it up to try device_get_match_data() first then fallback
> to the adxl313_spi_id[] table but there isn't a nice 'standard' way to
> do it.
> 
> If that isn't done, then IIRC the match is against the compatible with
> the vendor ID dropped and the table used is the spi_device_id one.
> Which is just annoyingly complex and relies on the strings matching.
> 
> In the ideal world the spi_device_id table would go away but there are
> still a few users (greybus - I think + remaining board files).
> So for now something like
> 
> a = device_get_match_data(dev);
> if (!a)
> 	a = &adxl31x_spi_regmap_config[id->data];
> 
> Provides a good way of ensuring the id tables don't need to remain
> in sync.
> 

I guess the only minor issue is that first driver data - ADXL312 - is
equal to 0, so above code would make consider ADXL312 as missing data.

Best regards,
Krzysztof

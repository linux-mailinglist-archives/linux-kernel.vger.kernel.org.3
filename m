Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96853AFB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiFAWi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiFAWi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D75705521E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654123104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceGgR5cdPBLP1zNOzwY1AoGqwuSAXgokhvZyfTTzqKM=;
        b=hGQCymQyn127JCFNdXWXVlq4huWwE/5oBZtYNEJbgQ+JRirkDBU5qNi6FSgyQYsoEXniaE
        kXfXyF22NxmOhe/qRmkoQxroj/b5OSmtSnN2d0SnhQ/09jHUd3suU1Ff0IctSa9AN23juQ
        M9ZZ+XzFnQpR8ER3vDiNZf6JtKMGEXk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-xXeussbfO1mlJb-Iom_raQ-1; Wed, 01 Jun 2022 18:38:21 -0400
X-MC-Unique: xXeussbfO1mlJb-Iom_raQ-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1843821wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 15:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ceGgR5cdPBLP1zNOzwY1AoGqwuSAXgokhvZyfTTzqKM=;
        b=Sl7/Ai5G5xOk3WRX4ZOmW0HOEcKabhbSm0lHZBRYZwyjU394KCZMzGM0AnH4eojUpl
         M2B9CvPWr71qiQDe4f23ZGcB2YwSItYrRLI5djwQLplbLGIgpeTSzGZpz5W4zSFviadv
         TiJ3SFRPLqjPWw69IAKhrrNJ1iI0ijdQtzpyIlsrPYrQeCltrsOfRwMBug+ybfZFbqap
         begCde7Qbto/DEy+uOucNQz+N8SStnUaDTzrzF6V+DG8lYOJc5ibgIX34LZmySV7ElS4
         cB6fUUO2eXFWGemxVhK/5yM8AvHvFL4wEpCv+PFT2oCtbZWiHzHlUBM+L45DpIFY0AaE
         FP5Q==
X-Gm-Message-State: AOAM530wDaMArMlA6GWi9sLpFChQzdDPd2Z8dw9ZvXVyFqXJL5O4uZ7k
        LL5gaXxk4JzGwB4Qw3+l+Erbt0itmUy1WPuZSIowczijk3GqSpFKcHhNFn/81wYbPyG1LAIuMl6
        zxysjrcRLNKhLGoah7WSKCQbU
X-Received: by 2002:a5d:4e86:0:b0:210:1f1d:978e with SMTP id e6-20020a5d4e86000000b002101f1d978emr1275356wru.172.1654123100321;
        Wed, 01 Jun 2022 15:38:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybB2S2p1Gb9EF9Cn2Pz8DdIgk8Ji4oxYM9kOIXJbYDoOLRWYoYt21HP+1xDltDqbRQf1deZQ==
X-Received: by 2002:a5d:4e86:0:b0:210:1f1d:978e with SMTP id e6-20020a5d4e86000000b002101f1d978emr1275340wru.172.1654123100032;
        Wed, 01 Jun 2022 15:38:20 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003958af7d0c8sm3166647wmq.45.2022.06.01.15.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 15:38:19 -0700 (PDT)
Message-ID: <a4cf5b0f-40df-467a-e606-9a7d7eafba11@redhat.com>
Date:   Thu, 2 Jun 2022 00:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/ssd130x: Only define a SPI device ID table when built
 as a module
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220530140246.742469-1-javierm@redhat.com>
 <YpYv8islaEySOEtg@dev-arch.thelio-3990X>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YpYv8islaEySOEtg@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 17:10, Nathan Chancellor wrote:
> On Mon, May 30, 2022 at 04:02:46PM +0200, Javier Martinez Canillas wrote:
>> The kernel test robot reports a compile warning due the ssd130x_spi_table
>> variable being defined but not used. This happen when ssd130x-spi driver
>> is built-in instead of being built as a module, i.e:
>>
>>   CC      drivers/gpu/drm/solomon/ssd130x-spi.o
>>   AR      drivers/base/firmware_loader/built-in.a
>>   AR      drivers/base/built-in.a
>>   CC      kernel/trace/trace.o
>> drivers/gpu/drm/solomon/ssd130x-spi.c:155:35: warning: ‘ssd130x_spi_table’ defined but not used [-Wunused-const-variable=]
>>   155 | static const struct spi_device_id ssd130x_spi_table[] = {
>>       |                                   ^~~~~~~~~~~~~~~~~
>>
>> The driver shouldn't need a SPI device ID table and only have an OF device
>> ID table, but the former is needed to workaround an issue in the SPI core.
>> This always reports a MODALIAS of the form "spi:<device>" even for devices
>> registered through Device Trees.
>>
>> But the table is only needed when the driver built as a module to populate
>> the .ko alias info. It's not needed when the driver is built-in the kernel.
>>
>> Fixes: 74373977d2ca ("drm/solomon: Add SSD130x OLED displays SPI support")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
Thanks! Pushed this to drm-misc (drm-misc-next).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


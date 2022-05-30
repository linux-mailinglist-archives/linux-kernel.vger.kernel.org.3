Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644BD538484
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiE3POs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiE3PO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26A1CE64E5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653920032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=My0d94IHmiGuBzUrJl4GrT8CrvGcL1Llk9nU8K4G0dk=;
        b=b2lLh9IKZBceztfNg2d1MSRgY6Pdggo0GCXT81dewcZObkax/8r7lB2riECDJRCIuGTTVf
        2Gj3iLp7ckDrLzh3saulAguiWSwwIXEIYRgUAwOtIMbi1Nw+eJNmu6OuFuWXBLwyI9pOFO
        CDFkJgJc5U0fAO77NHdh9Rvi/6awaeI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-5JWjYnWeP8GMzGYEnGp9bQ-1; Mon, 30 May 2022 10:13:51 -0400
X-MC-Unique: 5JWjYnWeP8GMzGYEnGp9bQ-1
Received: by mail-wm1-f70.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so4648087wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=My0d94IHmiGuBzUrJl4GrT8CrvGcL1Llk9nU8K4G0dk=;
        b=M+4HfqU2iRuMTx4JrfF0GWfMvD99SuWBKYDItZZ28zjoRZpRxuRvAXsIrkp5civme5
         PhtDaogjCLH72kngVcmz/VH63mFEedf902hIWeGKa6j7hwsqmXn+reA/Fru/GMATfeiv
         xzQrmneimPf79pRbi/uV7J025PcKxriWwrDTTDIAaV9cUshtj396IvJX0clk+oCHPKP/
         cz6IiWOvbXljlGp1cK4vZhN/gAEK1NpgzNimp7Km1nFG2067pQPmXf18cXNvnKf1FMuf
         exKW0j3zAV2jspBnlAX+sZEoT8477Mo41NDrh4kjl0etyEVfwiRLPIXG+0hWuBDeMuYr
         QR4Q==
X-Gm-Message-State: AOAM533BJjM90jB5QrF6TL3CPPRVl6eP7YVSrlzhTKkuaN3s7A2uHiS9
        YitvjLp0XY4D32mDI+XZF5yw5DjME3HXtNOkIM/fA84snnVZ7o/wtdpvjM5f7BY1WOPrPKhGif4
        nI8KwIdtsy4lQxm+pWzMrUbr2
X-Received: by 2002:adf:ee8d:0:b0:210:1873:c3d9 with SMTP id b13-20020adfee8d000000b002101873c3d9mr13911813wro.696.1653920029914;
        Mon, 30 May 2022 07:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/iCgo4uwGn5S2awMlXSuPR6ifvyuA9XqWpTCehNJrPlLvJl/TJOPFU8LtmrJ9Vif/v+TC3A==
X-Received: by 2002:adf:ee8d:0:b0:210:1873:c3d9 with SMTP id b13-20020adfee8d000000b002101873c3d9mr13911785wro.696.1653920029576;
        Mon, 30 May 2022 07:13:49 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003973d0a78casm11460061wmq.38.2022.05.30.07.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 07:13:49 -0700 (PDT)
Message-ID: <a806fe1c-0e48-7936-26a4-fb3fd8270300@redhat.com>
Date:   Mon, 30 May 2022 16:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: warning: unused
 variable 'ssd130x_spi_table'
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <202205290422.eoxGqDMR-lkp@intel.com>
 <607265eb-bfbf-4134-f2fe-d66cacd7bfbb@redhat.com>
 <YpLF9jdqiub98Nl/@dev-arch.thelio-3990X>
 <0a3c11c7-2669-ca85-69d1-3b3faa2f7a3c@redhat.com>
In-Reply-To: <0a3c11c7-2669-ca85-69d1-3b3faa2f7a3c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/22 09:34, Javier Martinez Canillas wrote:
> Hello Nathan,

[snip]

>>
>> You'll see the same warning with GCC and a similar configuration:
>>
> 
> Yes, I'm not saying that the compiler warning is a false positive but
> that the reported error for this driver is. Since the correct fix on
> a driver that support SPI platform devices would be to use the table
> and set it to the struct spi_driver .id field.
>  
>> drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: error: ‘ssd130x_spi_table’ defined but not used [-Werror=unused-const-variable=]
>>   154 | static const struct spi_device_id ssd130x_spi_table[] = {
>>       |                                   ^~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> At the end of the day, this warning only shows up under W=1, so take it
>> as you will. The kernel test robot is a sign, not a cop :)
>>
> 
> I guess something that could be done is to guard the definition of the
> ssd130x_spi_table with a `if IS_MODULE(CONFIG_DRM_SSD130X_SPI)`, since
> if the symbol is 'y' and the driver built-in, then won't be used indeed.
>  

I posted https://lists.freedesktop.org/archives/dri-devel/2022-May/357088.html
to fix this compile warning. Thanks folks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


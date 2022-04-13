Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407E04FFC32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiDMROg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiDMROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DB206A061
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649869930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJ72N2/GrlRUJ/thxMpQZyE2ELbmhrFrZFQ/W3EawNk=;
        b=bHW/msb7GNBVwc09bWTw7btjaJHx57Qfbtg0V8FyUC0/mQ8/QjavIHV381Vd/poWRWIh7s
        y8s62NRxi/2hbj8Cjew3/xhR4ePw7K/L9s3sBdsrV+KL7vGQPmVP9hj1vS8Ny5SRviRCBo
        QaxGpbq9ahou+A153PIeFgCAnqmelOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216--YUaceZzOZ299qZ6nKrEzw-1; Wed, 13 Apr 2022 13:12:08 -0400
X-MC-Unique: -YUaceZzOZ299qZ6nKrEzw-1
Received: by mail-wr1-f72.google.com with SMTP id 65-20020adf8147000000b00207982c3692so533969wrm.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YJ72N2/GrlRUJ/thxMpQZyE2ELbmhrFrZFQ/W3EawNk=;
        b=P/0ao8cn7TaI7anYwstUQ6sN636uiPrzsvTBvh8YXfgIyiMm97oXlgJyE3sIA/Ixzk
         A0kXRBa0XQTYTBrtqci8Q+AxFSjfuOfkbDtLRog2CJX+e0Vs1mkbONYV+ByadsE3AOhp
         CyPQea/PyvbSdrmJBRFdoVaKMQCp5wf1IXhv1zIrNLfZOqSTFPNqbQl3XfSP0hHYaAl5
         TjusxqE4gYgF3aBaqUnXfHvr1ye3somWyVNZHc+JnA2CAsef9aB5xqac4t83Xq2Wxwmf
         J1n4CUwrGefAR+84+bl1pmCQod0KVmhwIIwrinduMiH/tMYqf8yovethhJvTDf9tQKx+
         Te0A==
X-Gm-Message-State: AOAM531FsyMPTfd7WuHUayjoJHy+J8g/H8Zm1a4DVWXpHYdG6u5GQO1r
        VVMSFipwnYZ9kQtqsTSQ1r80eJ1lX9+CLwGUSQCLiaY86zksrJsTdotkqm/XZ8MBLUvfukO5WQV
        G+H+T1IVz+DpuUey1ODK21knN
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr32488637wrc.294.1649869927674;
        Wed, 13 Apr 2022 10:12:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzarKNWqHMOXtjJXHfCHXYpL7/O0TZGX0CRZAp0JslWTZbGjWFUGAPY0CcHHwuyyFWpDVNUHA==
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr32488619wrc.294.1649869927436;
        Wed, 13 Apr 2022 10:12:07 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm31623645wrv.10.2022.04.13.10.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 10:12:07 -0700 (PDT)
Message-ID: <e81c5902-e401-c6d5-0e03-6984e7d4a547@redhat.com>
Date:   Wed, 13 Apr 2022 19:12:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220413162359.325021-1-javierm@redhat.com>
 <20220413162359.325021-5-javierm@redhat.com>
 <YlcCEP8ADyJNxd/Z@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YlcCEP8ADyJNxd/Z@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 19:02, Andy Shevchenko wrote:
> On Wed, Apr 13, 2022 at 06:23:57PM +0200, Javier Martinez Canillas wrote:
>> These are declared in the ssd130x-i2c transport driver but the information
>> is not I2C specific, and could be used by other SSD130x transport drivers.
>>
>> Move them to the ssd130x core driver and just set the OF device entries to
>> an ID that could be used to lookup the correct device info from an array.
>>
>> While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
>> bytes. Since even though they are used by the I2C interface, they could
>> also be useful for other transport protocols such as SPI.
> 
> Thanks!
> 
> ...
> 
>> @@ -139,6 +106,8 @@ static struct i2c_driver ssd130x_i2c_driver = {
>>  };
>>  module_i2c_driver(ssd130x_i2c_driver);
>>  
>> +
> 
> Seems stray change. Dunno if maintainers can fix this when applying.
>

Ups, indeed. I can fix it when applying.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


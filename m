Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69806577E69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiGRJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiGRJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23B605F59
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658135617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4YHQhKuUA0qrCJAM8mGzKA3vSJV63FUpFph/DNHn0yI=;
        b=OlNWX8jDvNZcDMyEdyByJ+X/kWiSSORvqyyTn3iSZSUgI2GPZ21155EcF81/IXhhssMlD5
        k1v1zC0StlYosqQQQI3U2t3tAMbiEE3T/uIcvCxDK1+E1XF2E7/Y+oUVEE3BZ46tyfEGzZ
        L5wpzIYR/uHl+6ZbW2sTLEaTdrE93+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-lkiALlK2Ph6HWy4GpZUZ3w-1; Mon, 18 Jul 2022 05:13:35 -0400
X-MC-Unique: lkiALlK2Ph6HWy4GpZUZ3w-1
Received: by mail-wm1-f72.google.com with SMTP id m10-20020a7bcb8a000000b003a2d979099cso4011341wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4YHQhKuUA0qrCJAM8mGzKA3vSJV63FUpFph/DNHn0yI=;
        b=57Rclnwg+9LnSlOPzWsGoarV+o1c75hWsr4qyd93QG1AScw28DaRtc7TsQDTstqbM4
         BUuLISpVn76T+856KOvTfurLhWMtdyd8OVqeDfsCFPA89IIwnTeDJiFX1EcIMaNEhROw
         FEP1VZS1qQutP6RdrtuwNUuZjrw1UcZ3cysQwok+fBikw9h7gOHF7ttqQkkIHkRrqkP1
         6j8JGSbA1lq8YSZCCb7IUFQUjV+llcSYEDIFLTs8OBkfg/PtktX7XFOMACuUcrkSbZU8
         7pNw/Pktol17CxqUjFGoMJB7Enx8eE9hOZD/1bX5E0GsZQ7XVHhFP35AJslsjHisTErc
         9uug==
X-Gm-Message-State: AJIora9gb4PNN+66WdAfnxTunJcTQB+zfSElysnmlPUcEIUyjeMLfzOU
        4TWaAlouH7Z8t+cKhzyG7si7gMz5bm9faes9xLOrTSyeVaQ6Gy9nS+LzxNAZrfxhyGZYmO9VBVY
        8P8Zo4+NJbrG8tJRAoXEsQYHm
X-Received: by 2002:a5d:4608:0:b0:21d:a5b4:20a2 with SMTP id t8-20020a5d4608000000b0021da5b420a2mr22836798wrq.276.1658135614606;
        Mon, 18 Jul 2022 02:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sY83c0sHrS2e/KcEsqINyTA830XmFnkM/jxp3KNTu3FfpHmVEOdL2BvxlQ9J3l/YdhyW/QNQ==
X-Received: by 2002:a5d:4608:0:b0:21d:a5b4:20a2 with SMTP id t8-20020a5d4608000000b0021da5b420a2mr22836776wrq.276.1658135614382;
        Mon, 18 Jul 2022 02:13:34 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b003a319bd3278sm4261037wmq.40.2022.07.18.02.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 02:13:33 -0700 (PDT)
Message-ID: <51214426-a893-cac3-b984-97688838c896@redhat.com>
Date:   Mon, 18 Jul 2022 11:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/ssd130x: Use new regmap bulk write support to drop
 custom bus
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Marek Vasut <marex@denx.de>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220618174338.2253021-1-javierm@redhat.com>
 <YrYSd5x1JKJJeklJ@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YrYSd5x1JKJJeklJ@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On 6/24/22 21:37, Sam Ravnborg wrote:
> Hi Javier,
> 
> On Sat, Jun 18, 2022 at 07:43:38PM +0200, Javier Martinez Canillas wrote:
>> Data writes for the ssd130x 4-wire SPI protocol need special handling, due
>> the Data/Command control (D/C) pin having to be toggled prior to the write.
>>
>> The regmap API only allowed drivers to provide .reg_{read,write} callbacks
>> to do per register read/write, but didn't provide a way for drivers to do
>> the same for bulk read/writes.
>>
>> For this reason, a custom regmap bus was used by the driver just to define
>> a bulk write callback that implements the D/C pin toggling. But the regmap
>> API has been extended to support defining bulk read/write handlers, so the
>> custom regmap bus is not needed anymore and could just be dropped.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Patch looks good, but obviously needs the dependencies sorted out.
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>

Thanks. The regmap fixes that were the dependencies landed in v5.19-rc4
and drm-misc-next is already at v5.19-rc6, so I'll push this patch now.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


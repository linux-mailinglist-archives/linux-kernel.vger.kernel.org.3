Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101B57EA5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 01:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiGVXlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 19:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 877F22E681
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658533265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97bI5QgLIfV0Wdh5TUgNrSdu9yYHB/M82pkoGIrwijE=;
        b=CeUQHDqpnskclmqcRpf48Sym2miLx3Kq0F/3j2CW//3Mstuon84uODoYi1ySZdLdUTdTBV
        aMoL7oGq+L6YGXhmtX4DPlCykd0VZwAnIBNvUcNcFao4aVQgnygsbGDtpsaxVtTPXfp9W4
        sNw/S8WsPbhg6CRmW56PpYglqHiCARQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-NGjStmuSOoeskmoxzp3mDg-1; Fri, 22 Jul 2022 19:41:04 -0400
X-MC-Unique: NGjStmuSOoeskmoxzp3mDg-1
Received: by mail-wm1-f72.google.com with SMTP id c126-20020a1c3584000000b003a02fa133ceso3078612wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 16:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=97bI5QgLIfV0Wdh5TUgNrSdu9yYHB/M82pkoGIrwijE=;
        b=TOTSHKtggni6h66aa0q+ePhEw5BtaDitghpsEbDdsPJwdQJkgHm8hoKg1KkeLB3ooa
         nGOw2VM4Fbo9kfxH3FFpJe6NArR8fP+AFFZdzVxrCj8YpvEghufIpQRMXN4ew/ipGrfv
         PlZW1C59ED9J6TcHrtFAmG/Cei6PynPBi2fzQ4fqDukMUXCFgmUkqLQJ35dLe72KMWOl
         Sn8Vmt3SqPTyEhnye9EL1L8X4iv4XX2YdlhM6s2tXQCBjtXEvBZJZuqPAICTcNaUpWsU
         Pge5ZIKcPBmNeKtJiRP3CX1lMqF0q/iPQI/4QyUlqfz513F/0+XpdzWOrVzdwEs4ZMIZ
         FvGg==
X-Gm-Message-State: AJIora9gTH3dZtYal4a8VfxFw8YWbc+K0bm23r9BUEGBP8Lbo4xZDHsI
        UkrqPqrR+w0DviRhqLVgFUt1ZTmQbEs9q0e6/lA5VhxFW+Fr+QFHPYa7uJ6L7Fq8kz+s3uDe7Jy
        vtQV5eF6ZQYcHX52EcBAkkhit
X-Received: by 2002:a05:600c:1914:b0:3a3:4476:36f1 with SMTP id j20-20020a05600c191400b003a3447636f1mr2498468wmq.205.1658533263238;
        Fri, 22 Jul 2022 16:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vZl5vBvV9oaQlXAWarpxnm0CK2ceKfdcr+DpcSHyKu4xh9ne3vQ7GxzdPJaOTMkBhI81Ta7g==
X-Received: by 2002:a05:600c:1914:b0:3a3:4476:36f1 with SMTP id j20-20020a05600c191400b003a3447636f1mr2498461wmq.205.1658533262948;
        Fri, 22 Jul 2022 16:41:02 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r67-20020a1c2b46000000b003a308e9a192sm10205489wmr.30.2022.07.22.16.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 16:41:02 -0700 (PDT)
Message-ID: <6f5f6fbb-5a6c-3bc3-20f7-1a97854434b0@redhat.com>
Date:   Sat, 23 Jul 2022 01:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Use dev_err_probe() to avoid
 polluting the log
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Erico Nunes <ernunes@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <20220722074755.660258-1-javierm@redhat.com>
 <CAD=FV=WR3UP4XMch5z8Hz8GzWRg5cCsK6FVwgoo=HHDnpTwz+g@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAD=FV=WR3UP4XMch5z8Hz8GzWRg5cCsK6FVwgoo=HHDnpTwz+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 15:35, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jul 22, 2022 at 12:48 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> If devm_drm_of_get_bridge() can't find the connected bridge, it returns an
>> ERR_PTR(-EPROBE_DEFER) to indicate that the probe should be deferred.
>>
>> But this path also prints an error message, which pollutes the kernel log
>> since is printed on every probe deferral, i.e:
>>
>>   $ dmesg | grep "failed to create panel bridge" | wc -l
>>   38
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> If someone else doesn't beat me to it, I'll apply next week sometime.
> 

I've pushed this to drm-misc (drm-misc-next). Thanks all!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51852524B77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351198AbiELLU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353240AbiELLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:18:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C41D369DB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:17:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso7527518pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6WezROkLudrlqv8GY4bLrfI4SSzTy6BukYeueDgyVAo=;
        b=ZG4L8aWgWUMIdLTyMqlfwkAvbyFWFtdzShi8yQzpV4ha+8gdXHZZbgGM494CmV8pHZ
         KUM31+rCVQ+f+rjslddzbgtjw3rn2C95dgsbihhOPl5X/XaYuU7/xuS7HEoVPL+MIk5u
         2dGxoWbTHtMbwHgMC1tIngmH3I9TG8Ii0cpcFNvtmK1pBuJwOdRj5ivaKn72u2n//pOl
         oslhRY2fn1Kt39pV7ZEAnqs6g27CqHEPGBSBrFvSVn2KaWTNymdXDZ/zeIJDVKHfydiw
         kY/GrcdP6EysrjF/PAdFREfVaKlF+p9Bs81hJBKQDUh+Kftl4QmhGyooqZcSnMdtPjw7
         skeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6WezROkLudrlqv8GY4bLrfI4SSzTy6BukYeueDgyVAo=;
        b=H6wfPnMVrwT92P5WDml7DSyP71IjBqHHKVW957gGEhJRc+EsCkFcmpZ+uW9I+Py8Rg
         1X3AsR+mwjzUsCePEgvFnVHNix8LWEzYezR/PY6bJMLHsnKm+rdThrclkIevD5sJFKK3
         4bQh7XIUVbQKtLDSVJ0V6bI1kkgS8gf79693p4QBuhot5UjSbuxTmb704ikI++NR3vj7
         jQU8F0itJDB7jjZ7OMXZPD5Z2JH84dgEmxAnxhmlKLSpYZ2DhSyDey979tSBgQM7sdTn
         qjdTvF5+k6EYzlCOnMQBkTmnX3G9PUFjBPo28c50XJCw8Xx65U0SCxKdN0QgBRn8qqYI
         giJw==
X-Gm-Message-State: AOAM530VurABsQYELrhQOLcfEm5tY2EKcdFFgTmiQyjNZvggydOY60ZJ
        XlV90uDvYcKBGKIycbWog0E=
X-Google-Smtp-Source: ABdhPJxOk00NN95KoR0NkGvXDc/PUUEbhiITRueHgKA7v2vPBSykitNg4nZw/ehY2YRTSOAYec1gmg==
X-Received: by 2002:a17:902:ea46:b0:15d:dbc:34f2 with SMTP id r6-20020a170902ea4600b0015d0dbc34f2mr29455881plg.60.1652354230773;
        Thu, 12 May 2022 04:17:10 -0700 (PDT)
Received: from [172.16.10.243] ([219.142.146.170])
        by smtp.gmail.com with ESMTPSA id w15-20020a63474f000000b003c14af5060asm1663230pgk.34.2022.05.12.04.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 04:17:10 -0700 (PDT)
Message-ID: <e778d50a-81c6-6dfa-a58b-73cda452f4e3@gmail.com>
Date:   Thu, 12 May 2022 19:17:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220512092114.38426-1-linmq006@gmail.com>
 <a811a26e-ec34-f9ce-589f-82e96a975594@baylibre.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <a811a26e-ec34-f9ce-589f-82e96a975594@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/5/12 17:32, Neil Armstrong wrote:
> Hi,
>
> On 12/05/2022 11:21, Miaoqian Lin wrote:
>> of_find_device_by_node() takes a reference to the embedded struct device,
>> we should use put_device() to release it when not need anymore.
>> Add missing put_device() in error path to avoid refcount leak.
>>
>> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>
> You already sent the same patch yesterday, please avoid this.
>
Sorry for the mistake, I realized this after I sent it. I will be more careful.


> Neil
>
>> ---
>>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>> index 5e306de6f485..de87f02cd388 100644
>> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>> @@ -435,8 +435,10 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
>>           cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
>>             notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
>> -        if (!notifier)
>> +        if (!notifier) {
>> +            put_device(&pdev->dev);
>>               return -ENOMEM;
>> +        }
>>             meson_encoder_hdmi->cec_notifier = notifier;
>>       }
>

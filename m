Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E94D30AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiCIOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiCIOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A619D6D1BF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646834370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOZK+oC6WCadh4bBlqKBl3sP0Pq7K/G3eW+KWW9PmYo=;
        b=FWBmSmXG7X+Z/IZWXqEfpfnSgWRccBV+0nYqTBu9XaC/nHm7YngPjXRPg5yVKMvwVbiHl1
        dLC1yqxmbhSVKJHgkR56LCuwzQ4+V469OxGueSWyj+2d3x94N8ZBKZrYWSolJjw6p4KQXg
        SAWIVWpzFzgLC8EYFPEbkhyyxcANfiY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-bpbOB41WPCmSsAa3mX5SUw-1; Wed, 09 Mar 2022 08:59:27 -0500
X-MC-Unique: bpbOB41WPCmSsAa3mX5SUw-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso2626018wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sOZK+oC6WCadh4bBlqKBl3sP0Pq7K/G3eW+KWW9PmYo=;
        b=8E0cVVWu06nwi4arymAqS87zvFNHycWp95kqOvYXC3HvkKJmHUipQS95ito22Fmj2k
         XT9ZmuWUbOMtZom1zkP6m5htMgHuZY3x6v/900gBRIe0U9YGxvFkMNDEePh0XAcMI53d
         jFWMEBgNNj59Ab2xdEQEGWnA26zSUq3HWnbbnyQlLxybURbvnKfyczXuUcd4YcyDMKpt
         5mUdsSVr8nTJ4gvFh8IwT6+0aWUeEMYEqXvC1mSYMpuCNjdTAV7rVZP4tZt45/Mok3/G
         Oq6qve6OvkP6h2YOffOhsVAsUAyOMP9fm7UvzFsYfm7YCOGI3cM5wVd2YUkLZ92/21v5
         2yPg==
X-Gm-Message-State: AOAM531gtNhm0Jq3/xSA5O+iLZU/0grSoe+QExN06+/Q7PrV8H/uNpKW
        91pmY0JNhCaOzFMDKG2HAGeNo2Iyk3kIGkVx9Pbsb44jkEP27Ov8xxyoQ1mKt1Ww0Txh058CL2m
        iDYeVSdGZ5J8dMYCBKDr9AIbu
X-Received: by 2002:a05:600c:3391:b0:389:9c6e:c248 with SMTP id o17-20020a05600c339100b003899c6ec248mr7791294wmp.97.1646834366542;
        Wed, 09 Mar 2022 05:59:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIdcMORve4/7HEvkFPRK5YEwQuKdbb64jr1wA7wea0uD2fdT12WWdq9cokqRMc8K/PF2dnmw==
X-Received: by 2002:a05:600c:3391:b0:389:9c6e:c248 with SMTP id o17-20020a05600c339100b003899c6ec248mr7791281wmp.97.1646834366329;
        Wed, 09 Mar 2022 05:59:26 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003899d50f01csm1702307wms.6.2022.03.09.05.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:59:25 -0800 (PST)
Message-ID: <cc1e4343-8a76-c42b-e7d6-e606afcef359@redhat.com>
Date:   Wed, 9 Mar 2022 14:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: ssd130x: Fix COM scan direction register mask
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220308160758.26060-1-wens@kernel.org>
 <CAMuHMdWuWFhs5-ezh_UriPzWsZt02A2AJOTJMiszGpu_3hoqfw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWuWFhs5-ezh_UriPzWsZt02A2AJOTJMiszGpu_3hoqfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 13:56, Geert Uytterhoeven wrote:
> On Wed, Mar 9, 2022 at 2:57 AM Chen-Yu Tsai <wens@kernel.org> wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> The SSD130x's command to toggle COM scan direction uses bit 3 and only
>> bit 3 to set the direction of the scanout. The driver has an incorrect
>> GENMASK(3, 2), causing the setting to be set on bit 2, rendering it
>> ineffective.
>>
>> Fix the mask to only bit 3, so that the requested setting is applied
>> correctly.
>>
>> Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Thanks, this fixes the vertically-mirrored display on my Adafruit
> FeatherWing 128x32 OLED.
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

Thanks for the testing and review. I've pushed both patches to drm-misc-next.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


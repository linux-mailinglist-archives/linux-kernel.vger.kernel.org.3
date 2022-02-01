Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FAF4A5DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiBANzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbiBANzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643723752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fiDgurBW1NwAiqY2GLiQR5aJEIehzQmgOw53j3Z2hSA=;
        b=EKGUZtDSrQ5uDy7Ds7FTLb9ZRY5FpT9aBjk1yygwYkROtI8n2iATiKY9p5EFY2rKBCbhtH
        4eLsRhBJVQU3cGMHLT7HQHG97/obydURx1rUvDa+9JgdQ5r08dst020ttoponhjSQCbfaQ
        +Iow6dN3/VeDGBPtpwWE7yUGlOPu7m4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-RHJd-T42N-uw0S_Aza4aSA-1; Tue, 01 Feb 2022 08:55:51 -0500
X-MC-Unique: RHJd-T42N-uw0S_Aza4aSA-1
Received: by mail-wr1-f71.google.com with SMTP id m17-20020adfa3d1000000b001dd66c10c0cso6034031wrb.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 05:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fiDgurBW1NwAiqY2GLiQR5aJEIehzQmgOw53j3Z2hSA=;
        b=O7O2VPR4VXKL0RrkWa05qymW5j6Zl7rVwESsJWrNwNj1hp0P0DClYci7xexi0a9Syr
         swE0ujzxJQJ6X5NmCKybVmgh0osYrjBLzjomXcDCZi8aYV6B8uRPSEEhCi+rLW7gkl0R
         GjmhkfpaphpQK/cZgHChMbGWT2Tk0Jh2O0C4TIwRgIs8q/Om+cXZRHzt+n5nYLBWHCZs
         ZH8ernPLSPGohAN8fUufVv+oUFG6hM8kaBlp96dJWyOO22npyOU+MITHq95DZ7FQroO8
         kIqDAucvQ2nLqxY9LU79c9FWyIUqRj9IPRt5y9O8Grly7MDCFohIMTdyZWSoxAHQBlJ7
         ryxg==
X-Gm-Message-State: AOAM531s3kyUn9BGReTbZGIlc1AcsltKlYzyNUnUqBqmrFU/gjIVJOCs
        jwRJmaadib8VCVyJPsid0/QFwJRF0HKn66HiRJjQOg5cFvclXck+b5l4bSJbhxOI5Oa6W8WD/Xi
        Rdc+PYAMBC1FC6s0MRNZQuIFu
X-Received: by 2002:a05:600c:308:: with SMTP id q8mr1920545wmd.118.1643723750414;
        Tue, 01 Feb 2022 05:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiMcaMwXhPvSvseRwur0kl1vzm4WxKS+ITQZ4fi35QJL+D2oLFM2CJItTZMN0+Csgh1HP6Iw==
X-Received: by 2002:a05:600c:308:: with SMTP id q8mr1920525wmd.118.1643723750213;
        Tue, 01 Feb 2022 05:55:50 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14sm16638445wrd.91.2022.02.01.05.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 05:55:49 -0800 (PST)
Message-ID: <f1c3557a-a24b-9764-ff3f-9df352e37188@redhat.com>
Date:   Tue, 1 Feb 2022 14:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Content-Language: en-US
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
 <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
 <4322f58b-dbeb-b90f-2770-d6881f8005b4@redhat.com>
 <a6f267ea-7617-7d0e-06cd-7ec9c88576c3@tronnes.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a6f267ea-7617-7d0e-06cd-7ec9c88576c3@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 14:20, Noralf Trønnes wrote:
> 
> 
> Den 01.02.2022 14.06, skrev Javier Martinez Canillas:
>> Hello Noralf,
>>
>> On 2/1/22 13:58, Noralf Trønnes wrote:
>>>
>>>
>>> Den 31.01.2022 21.52, skrev Sam Ravnborg:
>>>> On Mon, Jan 31, 2022 at 09:12:21PM +0100, Javier Martinez Canillas wrote:
>>>>> There isn't a connector type for display controllers accesed through I2C,
>>>>> most drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.
>>>>>
>>>>> Add an I2C connector type to match the actual connector.
>>>>>
>>>>> As Noralf Trønnes mentions in commit fc06bf1d76d6 ("drm: Add SPI connector
>>>>> type"), user-space should be able to cope with a connector type that does
>>>>> not yet understand.
>>>>>
>>>
>>> It turned out that I wasn't entirely correct here, mpv didn't cope with
>>> unknown types. In the PR to add support Emil Velikov wondered if libdrm
>>> should handle these connector names:
>>> https://github.com/mpv-player/mpv/pull/8989#issuecomment-879187711
>>>
>>
>> I see, thanks for the information. What should we do then, just use the type
>> DRM_MODE_CONNECTOR_Unknown then ?
>>
> 
> Not really, I just wanted to point out that it could be that not all
> userspace will handle an unknown connector type (I just checked the DE's
> at the time). I haven't seen any issues after adding the SPI type so it
> can't be that many apps that has problems. Adding to that a tiny
> monochrome display is limited in which applications it will encounter I
> guess :) It was after adding the USB type that I discovered that mpv
> didn't work.
> 

Anything we do for this rather obscure hardware certainly won't be an
issue for most applications :)

But I wasn't sure if your previous comment meant that you were nacking
$subject. Glad that we can go ahead and describe the correct type then.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


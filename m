Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51412475521
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhLOJZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:25:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233708AbhLOJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639560340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWH+xxBIXK7uXDC+5XTD46Bbs2W0QAgr8qSLmMPvMB4=;
        b=VKD0BlgUazgRSEbwTovj3jPqmR/H0atJuBLheOoMpIOkwWm0NgY1sc/JBpD3fIuA1T+etp
        v078cgLlrA7ffzKDTMnkXYQXg6Ai+eK9mTQGLp0W166PHmYbRp2yKyL7D2yR+Shq+g1m9g
        5jCoMpF4nyihN7Vy5uB/YvEAG4YRiW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-G8q8D5FaMA-xakIW8exevQ-1; Wed, 15 Dec 2021 04:25:39 -0500
X-MC-Unique: G8q8D5FaMA-xakIW8exevQ-1
Received: by mail-wr1-f69.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so5706528wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 01:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GWH+xxBIXK7uXDC+5XTD46Bbs2W0QAgr8qSLmMPvMB4=;
        b=CuoZEL+FoaFeeC10HUI3ryDO/tscuuHcEUeGk8qbygjNJj7l/Ae5pCQWeMFHgUq0is
         GI2mKHxpdrz7fMoDJMIyxy2uCeBXTUEgoCYHycu1swzVN1OZo8PlCxiOgwRFePCet+9C
         JMm2rlAa/yQ/8Fa6DDusQogTw9BTGDDxIg1F24sq8bvbWKkndPAAOJygo6+YvqO4xA0U
         DAlHbn1HW1XkrIyCNt0QyZxQOfOhIJmgQQW2e7Rouc4E8DrkqgiYVXn63S0hFf4kq/Wt
         59Dh12YCkVx8POrsBkRQzr7ki0PlWKAvDHyK08hn8WQhycv6B8HhGwnsJIdsev1Wlh8v
         t9xw==
X-Gm-Message-State: AOAM533lzwr5GPZuSsqIx75RRi3ssRnQlmWXzsw9XOeectYvl3Vpgg8s
        t/fGbyN4GFJFi3u2Y1Z+A9hJup4taBVQ/O5RcbJuLvLZsV7rCF9zlwpU5SmMap//FIgjE3wdwh/
        MPl20xMVTAn1o4hnxgntlgXk6
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr3741059wmm.142.1639560338401;
        Wed, 15 Dec 2021 01:25:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm3KgsNdogzi/34h6/tWCF6TMRJ5gF1EudlIDOAGP99J594NcdLVqRr6tP8liP1XSytzZKhw==
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr3741046wmm.142.1639560338121;
        Wed, 15 Dec 2021 01:25:38 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c8sm1418362wmq.34.2021.12.15.01.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 01:25:37 -0800 (PST)
Message-ID: <612eadcf-7b12-6609-9397-5c3cb7064f6b@redhat.com>
Date:   Wed, 15 Dec 2021 10:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/60] drm: Make all drivers to honour the nomodeset
 parameter
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20211215010008.2545520-1-javierm@redhat.com>
 <58d00cac-dbf1-9704-3c0b-16fd837a5b6b@suse.de>
 <2e76bd93-a65e-094c-15a4-77375906a1b0@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2e76bd93-a65e-094c-15a4-77375906a1b0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 12/15/21 10:12, Thomas Zimmermann wrote:

[snip]

>>
>> In each of the USB-based DRM drivers, replace module_usb_driver with 
>> drm_module_usb_driver.
>>
>> And then there's PCI [3] and platform drivers, [4] which can be handled 
>> similarly. Many PCI drivers open-code the module init and device 
>> registering with the driver-specific enable parameter. Maybe adding a 
>> driver-specific register function would make sense.
> 
> Just want to point out that the next time we add a new driver, it will 
> call drm_firmware_drivers_only() automatically if it uses such a macro.
> 

Yes, and it could also be used as an extension point in case we need more
logic like the drm_firmware_drivers_only() check for all drivers in the
future. So your suggestion is certainly the way to go.

I'll post a v2 when I get some time to work on this again.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


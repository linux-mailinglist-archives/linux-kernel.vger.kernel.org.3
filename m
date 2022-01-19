Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4436C4936DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352494AbiASJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352845AbiASJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642583396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCH0AjI3eFPY2q8NUP5gdOrSh0DwHQxcSUH1oIghDG8=;
        b=ivQ1ixBInev1Vr72a7lTSKrpFuLVejpKHewy2mqBX3psV4VclHoj+xHMjsGIGsFC66Ef2p
        H/vlmjZInhGNrJZeLl0ayHSd7IxjolRoSWKuR4nR1Q+uD6vmzLx0dy0a9CFMQZOHivKoD7
        C4tZX29IFIpTgNX22Idwvxl5Oa0n84Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-Fogz1eo2M3CNqBYtWwsjCA-1; Wed, 19 Jan 2022 04:09:55 -0500
X-MC-Unique: Fogz1eo2M3CNqBYtWwsjCA-1
Received: by mail-wm1-f70.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so3852938wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kCH0AjI3eFPY2q8NUP5gdOrSh0DwHQxcSUH1oIghDG8=;
        b=BLb/SWRBvUNcZFJ5SnhVkG7kVv5sbVtmkLYPU1lLRjXLWiaV3hTA+61ve1d0LRF1Lj
         CrYtzHmS785Vhysz3mXhKbBhZh75x/R7YWAs3x92Vw0ROqyoS7tjjsuSnmvP5uvebCLg
         qmLBj0PiqfIsKgPsuQI2FMSwTUIjEz+I3+wXeB2LwgkqA+kNuWnyrS3/9xa8nDkmCAE2
         H2ipciPw422XT8ECI+mtIW/OaGbjqH8XlGCKhgYFKySp3y1Q86zmLuta7+QGPMBNlO5q
         chwRUiY40Rbq6Nx5TWlwwCboVtitpssniqVg72NFBIsNA+T2HjtKJtrdJ/YkecWbJhIQ
         LfbQ==
X-Gm-Message-State: AOAM533KJvD3sIO19ZdFur0K6Hdh7dVzpi/wQD1EsLHj9UetxSNx45wI
        4TH5WMGUVQtGVyrmeGY2KoQgfzAcCgKHG7NOI3NEfi5Joxb3ZvHUx0EsugBNuzuxM03eRT7j3dw
        yungd0+0Y29VNE3X725+q92GJ0JFq+vQu5DqMujvRm0oKKpqD364IZFKPho/JoCPwRK5/bNG82F
        M=
X-Received: by 2002:a5d:64a3:: with SMTP id m3mr27550866wrp.36.1642583394036;
        Wed, 19 Jan 2022 01:09:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4mSSy7TajapoJ7PW82ft7hU8P4SXnM3bPyypID6clEBCjm4UngytWsRKI1DJf9NWdr4q8Mw==
X-Received: by 2002:a5d:64a3:: with SMTP id m3mr27550816wrp.36.1642583393706;
        Wed, 19 Jan 2022 01:09:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p9sm5550805wmb.32.2022.01.19.01.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 01:09:53 -0800 (PST)
Message-ID: <e956363f-d62a-3c73-6dae-6c691c63dedc@redhat.com>
Date:   Wed, 19 Jan 2022 10:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 00/10] drm: Make drivers to honour the nomodeset
 parameter
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211222082831.196562-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 09:28, Javier Martinez Canillas wrote:
> The nomodeset kernel command line parameter is used to prevent the KMS/DRM
> drivers to be registered/probed. But only a few drivers implement support
> for this and most DRM drivers just ignore it.
> 
> This patch series is a v3 to make DRM drivers to honour nomodeset. It is
> posted as separate patches to make easier for drivers maintainers to ack
> or pick them independently at their own pace.
> 

[snip]

> 
> Thomas Zimmermann (5):
>   drm: Provide PCI module-init macros
>   drm/ast: Replace module-init boiler-plate code with DRM helpers
>   drm/bochs: Replace module-init boiler-plate code with DRM helpers
>   drm/cirrus: Replace module-init boiler-plate code with DRM helpers
>   drm/hisilicon/hibmc: Replace module initialization with DRM helpers
>

For Thomas' patches (1-5)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


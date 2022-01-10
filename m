Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944AD489719
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbiAJLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244610AbiAJLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641813138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TAZo2E9BDT4gIbrVjaTOuTZ8dwBHWfcjiFPuUrSfFo=;
        b=eZcJuPSUOJkrfdY4xadjSc9H8Tg7/nJk50OQ4tOOFf/uG/b9PwohEEoaYvM41dA7/z9Rna
        cnKFQ8jhhck8r3KsvwcGjBxBwHFjP2+6uGOALJqHin+8jfH0ftKIQdLv8u+1anV2cwNRB8
        p37NFe5rdNv8TSwrKJuMKteJZG3z8sc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-2a2bNwArMQSB8Q3kyNskCg-1; Mon, 10 Jan 2022 06:12:17 -0500
X-MC-Unique: 2a2bNwArMQSB8Q3kyNskCg-1
Received: by mail-wm1-f71.google.com with SMTP id ay41-20020a05600c1e2900b00345a568e6b2so4795679wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6TAZo2E9BDT4gIbrVjaTOuTZ8dwBHWfcjiFPuUrSfFo=;
        b=jw5LKorP3Nz8owiP/LproyC6J1vkJq4/3YUfGXCS9UgqCvFUYauccjpzKByq8nI9p7
         X/n+IO7el2n7MVYEMeFb956wVUJL7+AfvuNqgyDEO1Ii1Y9AsowSLxcOoQHK4Zf6wPYw
         gCdKeQJSZOLrpggSmGpLG9k8QAiUSbCwMTr5vAz80xy98cujSH9Y83wSDn90olK4fUlg
         UFtHhtidcX58oWbmxfku3UUSr1h57XQeLVBOQ8Z1NRirnWzJhnLqGCKXWoleuzr75n9u
         05FpESTXK1dCsPCtl5OuURY9p7rnPzIalAp4KbaCB3/KB7i3UsM4IzeranjwH9UULrET
         Oo2g==
X-Gm-Message-State: AOAM531R/5uOcS2vf94057eWf1PB9l3e4XnXMu1OoqshVtKj3wjO5ZFG
        BX9CyEygO+FM1gYOPpAFH962ze+vWgwG9R28uJsH+GURqMixGwqsImckQbx7Y1xtHXAozfNa189
        Sh6NohGFDxqpaE6ued1UCmW3H+SrsESkRSWKaVB2JX8cyeCroTkuh6V1kR17Sa+5wxHhXVS2CNq
        Y=
X-Received: by 2002:a05:600c:a06:: with SMTP id z6mr21576915wmp.9.1641813136187;
        Mon, 10 Jan 2022 03:12:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDpQTVUV4tpwlSja9IAszzocXj8Nhc1NG2G5FikesBhEyz8Rtp3Jf6shzre9dTBOV/pRhwDg==
X-Received: by 2002:a05:600c:a06:: with SMTP id z6mr21576887wmp.9.1641813135870;
        Mon, 10 Jan 2022 03:12:15 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r19sm5516936wmh.42.2022.01.10.03.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 03:12:15 -0800 (PST)
Message-ID: <9604b80d-c7bf-2a80-125d-70c6175acb5a@redhat.com>
Date:   Mon, 10 Jan 2022 12:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is
 enabled
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        John Stultz <john.stultz@linaro.org>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>
References: <20211216210936.3329977-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211216210936.3329977-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 22:09, Javier Martinez Canillas wrote:
> The commit feeb07d0ca5a ("drm/hisilicon/hibmc: Make CONFIG_DRM_HISI_HIBMC
> depend on ARM64") made the driver Kconfig symbol to depend on ARM64 since
> it only supports that architecture and loading the module on others would
> lead to incorrect video modes being used.
> 
> But it also prevented the driver to be built on other architectures which
> is useful to have compile test coverage when doing subsystem wide changes.
> 
> Make the dependency instead to be (ARM64 || COMPILE_TEST), so the driver
> is buildable when the CONFIG_COMPILE_TEST option is enabled.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/gpu/drm/hisilicon/hibmc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> index 43943e980203..073adfe438dd 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DRM_HISI_HIBMC
>  	tristate "DRM Support for Hisilicon Hibmc"
> -	depends on DRM && PCI && ARM64
> +	depends on DRM && PCI && (ARM64 || COMPILE_TEST)
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
>  	select DRM_TTM

Any comments on this patch?

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


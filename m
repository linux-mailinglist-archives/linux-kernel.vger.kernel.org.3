Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10CC489757
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiAJLYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239652AbiAJLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641813857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBE0ggFKcl6guyW93VUOpb5auuAFCSHgSAnkBD22A74=;
        b=ENJCFjxXHJVgXZ26ffA8y9akFCiypf8Y+oRrkbnLql1sxHuYrZHDZ30kSM//J+rV9diEfW
        dj4OThvmI9dQ4ikQdUqxayqMc4qldgNEAeFgP2sDrGJfBSstWVEjY/Lo+3Irz6OBcUDSzo
        OO6XKPyzO6AXQTl4cRmJdLmGr5Y2ueg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-ifoM8bW3PiGdB5m635b5WQ-1; Mon, 10 Jan 2022 06:24:16 -0500
X-MC-Unique: ifoM8bW3PiGdB5m635b5WQ-1
Received: by mail-ed1-f69.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so9893137edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pBE0ggFKcl6guyW93VUOpb5auuAFCSHgSAnkBD22A74=;
        b=SGyHXSVrLRhq1xSkJZVFJkALyP3M3ZBsQtM5uce8/S5WlXQS/QRJXMYV0jBvdP2Nqa
         fkTe82u7loedekemLZKcOB74uCAY3WPaZFEHvXnahgR326Oyr64IhVMpmvT53cPSf6Zr
         9Rl4sFfdc6nM2Urj4PZnucw2gX4xbxJLOBm69GFFPUCORwaoyinNCiChW2aTshTQeEWt
         rbXlts2v5YkmeYTy1qDEpiPhTh0EyOgm7S4yWB0i4nfYjxnY4D50UITRbd1NH6X38Fal
         nuVVWYvbdwTfS6+cc3YN1Ouz88jXECeoDPOoMaNBF/bHP93e4o5HDQRsRDS/K3XZRnXv
         ghmA==
X-Gm-Message-State: AOAM533EBwpR7higNfN+TXJuqx/SHDNAMUYcV3l9h/1Cb7FOn+mAYyeP
        V6kqw7FFZGs8am9Con610w5rXRE8spnD8G0zLpn0hboyZEx65ivQqbwsv+urNwUxaTRBgkdnwSS
        OkQo3RSg+as8l6Aj+/06eFd/g
X-Received: by 2002:a17:907:7fab:: with SMTP id qk43mr5393032ejc.624.1641813855595;
        Mon, 10 Jan 2022 03:24:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyt9E0WS2MJysm3Twf1UdddP8U5gDgxMfL43JZ+JDuzamz/VprUYj4+VfxHHKVcF8DCP/SVOg==
X-Received: by 2002:a17:907:7fab:: with SMTP id qk43mr5392997ejc.624.1641813855367;
        Mon, 10 Jan 2022 03:24:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id i22sm2339975ejw.75.2022.01.10.03.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 03:24:15 -0800 (PST)
Message-ID: <4ef79dee-b9d5-ee0c-56c5-0b3058b49ad5@redhat.com>
Date:   Mon, 10 Jan 2022 12:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 1/3] drm/privacy_screen: Add drvdata in
 drm_privacy_screen
Content-Language: en-US
To:     Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, gwendal@google.com,
        seanpaul@google.com, marcheu@google.com, dtor@google.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@google.com>
Cc:     rajatxjain@gmail.com
References: <20220107190208.95479-1-rajatja@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220107190208.95479-1-rajatja@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 1/7/22 20:02, Rajat Jain wrote:
> Allow a privacy screen provider to stash its private data pointer in the
> drm_privacy_screen, and update the drm_privacy_screen_register() call to
> accept that. Also introduce a *_get_drvdata() so that it can retrieved
> back when needed.
> 
> This also touches the IBM Thinkpad platform driver, the only user of
> privacy screen today, to pass NULL for now to the updated API.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I've pushed this series to drm-misc-next now.

Regards,

Hans



> ---
> v5: Same as v4
> v4: Added "Reviewed-by" from Hans
> v3: Initial version. Came up due to review comments on v2 of other patches.
> v2: No v2
> v1: No v1
> 
>  drivers/gpu/drm/drm_privacy_screen.c    |  5 ++++-
>  drivers/platform/x86/thinkpad_acpi.c    |  2 +-
>  include/drm/drm_privacy_screen_driver.h | 13 ++++++++++++-
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
> index beaf99e9120a..03b149cc455b 100644
> --- a/drivers/gpu/drm/drm_privacy_screen.c
> +++ b/drivers/gpu/drm/drm_privacy_screen.c
> @@ -387,7 +387,8 @@ static void drm_privacy_screen_device_release(struct device *dev)
>   * * An ERR_PTR(errno) on failure.
>   */
>  struct drm_privacy_screen *drm_privacy_screen_register(
> -	struct device *parent, const struct drm_privacy_screen_ops *ops)
> +	struct device *parent, const struct drm_privacy_screen_ops *ops,
> +	void *data)
>  {
>  	struct drm_privacy_screen *priv;
>  	int ret;
> @@ -404,6 +405,7 @@ struct drm_privacy_screen *drm_privacy_screen_register(
>  	priv->dev.parent = parent;
>  	priv->dev.release = drm_privacy_screen_device_release;
>  	dev_set_name(&priv->dev, "privacy_screen-%s", dev_name(parent));
> +	priv->drvdata = data;
>  	priv->ops = ops;
>  
>  	priv->ops->get_hw_state(priv);
> @@ -439,6 +441,7 @@ void drm_privacy_screen_unregister(struct drm_privacy_screen *priv)
>  	mutex_unlock(&drm_privacy_screen_devs_lock);
>  
>  	mutex_lock(&priv->lock);
> +	priv->drvdata = NULL;
>  	priv->ops = NULL;
>  	mutex_unlock(&priv->lock);
>  
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 341655d711ce..ccbfda2b0095 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9782,7 +9782,7 @@ static int tpacpi_lcdshadow_init(struct ibm_init_struct *iibm)
>  		return 0;
>  
>  	lcdshadow_dev = drm_privacy_screen_register(&tpacpi_pdev->dev,
> -						    &lcdshadow_ops);
> +						    &lcdshadow_ops, NULL);
>  	if (IS_ERR(lcdshadow_dev))
>  		return PTR_ERR(lcdshadow_dev);
>  
> diff --git a/include/drm/drm_privacy_screen_driver.h b/include/drm/drm_privacy_screen_driver.h
> index 24591b607675..4ef246d5706f 100644
> --- a/include/drm/drm_privacy_screen_driver.h
> +++ b/include/drm/drm_privacy_screen_driver.h
> @@ -73,10 +73,21 @@ struct drm_privacy_screen {
>  	 * for more info.
>  	 */
>  	enum drm_privacy_screen_status hw_state;
> +	/**
> +	 * @drvdata: Private data owned by the privacy screen provider
> +	 */
> +	void *drvdata;
>  };
>  
> +static inline
> +void *drm_privacy_screen_get_drvdata(struct drm_privacy_screen *priv)
> +{
> +	return priv->drvdata;
> +}
> +
>  struct drm_privacy_screen *drm_privacy_screen_register(
> -	struct device *parent, const struct drm_privacy_screen_ops *ops);
> +	struct device *parent, const struct drm_privacy_screen_ops *ops,
> +	void *data);
>  void drm_privacy_screen_unregister(struct drm_privacy_screen *priv);
>  
>  void drm_privacy_screen_call_notifier_chain(struct drm_privacy_screen *priv);
> 


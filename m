Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E44D71CA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiCMAUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiCMAUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7E3524082
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647130736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aU12aXI0nEauDVlqXZUcV1/rWNx8riFMg5QnGWUSeY8=;
        b=avC/y0665Wx36JYC8DrhqNBdSKx0ySM5D0Oe3jsWuVsOaOfL5a4WR1a8YKYUEhfz5u5f/C
        EKKIQSa9pOkurvp6LoFp+nHKz/6YMSs/bD+cm2/OG/esc0COWEn5BJDwBq9kuFwXHbWJP1
        h56Gs/HRjYgC24UuwEQO/BkrPlT/zE8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-gZzBVurcNUOGVuptJCn2Tw-1; Sat, 12 Mar 2022 19:18:55 -0500
X-MC-Unique: gZzBVurcNUOGVuptJCn2Tw-1
Received: by mail-ej1-f69.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so6695897ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 16:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aU12aXI0nEauDVlqXZUcV1/rWNx8riFMg5QnGWUSeY8=;
        b=jFYc8y3h1pfMMrdZRj5NSlloOtoHZEkNTy0jZNf3KsEPLv6WHn/81PDN5Yc0VPltga
         ovIi15sYFSzCf1yMAa11bFI7uKP9HY+mUFy8+CzgSUZIeNFceb5bwrt4ncc0Elf01H+X
         KrQnQv8W+GKvgSnkqEPK5w7SUAB6jXo0pWNJmiiNNXfIzyQVXo77E5kI6QNQEzi6vOHC
         3Jl3TnOy3vd0O9oXuQHCvsoLfCi/DoFPj6W2Y6W+pOpCwZ4vTNOD1lk866wFMzk3PYPY
         Rtj7B+zsx9h4Nw8rxyUxr5EtzxUC379zLNzfcYLc5ni6Orj6zGx3oRzi51Sz662U8kxh
         guAg==
X-Gm-Message-State: AOAM531PDGb2ADNuX2lR97L20eK/Vw5pNmMIV90nabBJsBq6nk9slvm1
        LH0uSDcY10rqdyP+ThPN1ES2EAM6ugYcvOxb9EGTb7ir8tXk6dg7rhXKRo+NAdBiUjYPYQ0AypX
        mh4nmVRdVD0bW7brk46vVDqXN
X-Received: by 2002:a17:906:7953:b0:6da:951c:1173 with SMTP id l19-20020a170906795300b006da951c1173mr14006408ejo.465.1647130734306;
        Sat, 12 Mar 2022 16:18:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTW7jukeffXPd44IwM8ULWjAAjUUSeFWDf/jK+F/hKS8czFPnDNsmp7ccs5WfZmNdxPvzdXQ==
X-Received: by 2002:a17:906:7953:b0:6da:951c:1173 with SMTP id l19-20020a170906795300b006da951c1173mr14006363ejo.465.1647130734008;
        Sat, 12 Mar 2022 16:18:54 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:97fa:8a98:fc0d:1935:f619])
        by smtp.gmail.com with ESMTPSA id j11-20020a05640211cb00b00418572a3638sm2097646edw.38.2022.03.12.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 16:18:52 -0800 (PST)
Date:   Sat, 12 Mar 2022 19:18:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 08/11] vdpa: Use helper for safer setting of
 driver_override
Message-ID: <20220312191834-mutt-send-email-mst@kernel.org>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
 <20220312132856.65163-9-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312132856.65163-9-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 02:28:53PM +0100, Krzysztof Kozlowski wrote:
> Use a helper to set driver_override to reduce amount of duplicated code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vdpa/vdpa.c  | 29 ++++-------------------------
>  include/linux/vdpa.h |  4 +++-
>  2 files changed, 7 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1ea525433a5c..2dabed1df35c 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -77,32 +77,11 @@ static ssize_t driver_override_store(struct device *dev,
>  				     const char *buf, size_t count)
>  {
>  	struct vdpa_device *vdev = dev_to_vdpa(dev);
> -	const char *driver_override, *old;
> -	char *cp;
> +	int ret;
>  
> -	/* We need to keep extra room for a newline */
> -	if (count >= (PAGE_SIZE - 1))
> -		return -EINVAL;
> -
> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
> -	if (!driver_override)
> -		return -ENOMEM;
> -
> -	cp = strchr(driver_override, '\n');
> -	if (cp)
> -		*cp = '\0';
> -
> -	device_lock(dev);
> -	old = vdev->driver_override;
> -	if (strlen(driver_override)) {
> -		vdev->driver_override = driver_override;
> -	} else {
> -		kfree(driver_override);
> -		vdev->driver_override = NULL;
> -	}
> -	device_unlock(dev);
> -
> -	kfree(old);
> +	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
> +	if (ret)
> +		return ret;
>  
>  	return count;
>  }
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 721089bb4c84..37117404660e 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -64,7 +64,9 @@ struct vdpa_mgmt_dev;
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
>   * @dma_dev: the actual device that is performing DMA
> - * @driver_override: driver name to force a match
> + * @driver_override: driver name to force a match; do not set directly,
> + *                   because core frees it; use driver_set_override() to
> + *                   set or clear it.
>   * @config: the configuration ops for this device.
>   * @cf_mutex: Protects get and set access to configuration layout.
>   * @index: device index
> -- 
> 2.32.0


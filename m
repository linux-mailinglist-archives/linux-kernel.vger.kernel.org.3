Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A754DC89C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiCQOU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiCQOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:20:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EAB168093
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:19:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h16so2637284wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vOnzxJlH628gKK791oOxGy9dmx+tXiUp5rK1D8p/Qyc=;
        b=kDa19YjHt8tRsYBiCBRfz6pxQ6UQoy4iCEQZlW16D9UkkNnJ5lJWdzG5326YcKXBbe
         wXqwKuhekffzEpU/DSQxmw8BngtaGdfZqJb+dcnZFsBEvsulNkyI+Ewh6bkGRNbnsNL3
         iTsuRvUa5JouyV37vWooKUnnwgTmoilWrVXbPZqGYIkHky8DmZ7n4SzCUBsggTqvfvRK
         5JwbkPO2e5PRQCviaoDuQaaHS8QpAIMPmrOTTm6DFGb55TOkSyDDwA6xan0PlhGk4R26
         FPZPX7kc3a+Taa39eA1Ls/isLKM7mMxkqlekhijkOVXc2WWIowYHwAPx9xa+rzaDIC3u
         7YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vOnzxJlH628gKK791oOxGy9dmx+tXiUp5rK1D8p/Qyc=;
        b=U0aar+zJMLfsARqQNv2Q37fluxI7rgdm5LQi4Z5Lpg2HurW+3EWatOk+GbFS00OoGE
         V6ufruKSs8d2GUU0Eqxdm0SctvEBspcbIWcFYsOfqF/fV3PDhK9/7pTMbWP3BQvNCSmv
         7EEqvhm5Xg7HQNZK6ULeLBl0wP7r3ghr7aGnuRGZLeysrVUGY3wI0ZIJJhXqqWQJc12Y
         n2R7MN2ESKAIWUgr3dpvh/5wRWGPDOApoIi5nKgWCBZCxSywigea88qgVzZJzzbSY00c
         REFjjr86lQxYcdeMNZb1E8uPBZxTkKDP4W0k7khcmL6ZV8MN1TtaZT38ZOVwpWK7DZYY
         ca9g==
X-Gm-Message-State: AOAM533DKw7z/2i2gNuUucuWCoz6Mkxilq4+ihry2XjKPHWAFvMMAAPd
        9FJlpjR0MMhi2Xhem5u2N9BUdIGEzdR+FQ==
X-Google-Smtp-Source: ABdhPJxHZZo33eVHgCXtOwWiAcwRItKQpqcB0Hn2WCbkLjhRmwjh4xDZTHa0HI9wyEJ/oy2JZF1G3w==
X-Received: by 2002:a05:600c:3c9f:b0:38c:6dc6:6de2 with SMTP id bg31-20020a05600c3c9f00b0038c6dc66de2mr6739347wmb.132.1647526776607;
        Thu, 17 Mar 2022 07:19:36 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm7975546wmj.5.2022.03.17.07.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:19:35 -0700 (PDT)
Date:   Thu, 17 Mar 2022 14:19:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/1] drm/amdkfd: Protect the Client whilst it is being
 operated on
Message-ID: <YjNDdXXOMYNuHJcV@google.com>
References: <20220317131610.554347-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317131610.554347-1-lee.jones@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022, Lee Jones wrote:

> Presently the Client can be freed whilst still in use.
> 
> Use the already provided lock to prevent this.
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

I should have clarified here, that:

This patch has only been *build* tested.

Since I have no way to run this on real H/W.

Please ensure this is tested on real H/W before it gets applied, since
it *may* have some undesired side-effects.  For instance, I have no
idea if client->lock plays nicely with dev->smi_lock or whether this
may well end up in deadlock.

TIA.

>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index e4beebb1c80a2..3b9ac1e87231f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -145,8 +145,11 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>  	spin_unlock(&dev->smi_lock);
>  
>  	synchronize_rcu();
> +
> +	spin_lock(&client->lock);
>  	kfifo_free(&client->fifo);
>  	kfree(client);
> +	spin_unlock(&client->lock);
>  
>  	return 0;
>  }
> @@ -247,11 +250,13 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>  		return ret;
>  	}
>  
> +	spin_lock(&client->lock);
>  	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
>  			       O_RDWR);
>  	if (ret < 0) {
>  		kfifo_free(&client->fifo);
>  		kfree(client);
> +		spin_unlock(&client->lock);
>  		return ret;
>  	}
>  	*fd = ret;
> @@ -264,6 +269,7 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>  	spin_lock(&dev->smi_lock);
>  	list_add_rcu(&client->list, &dev->smi_clients);
>  	spin_unlock(&dev->smi_lock);
> +	spin_unlock(&client->lock);
>  
>  	return 0;
>  }

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

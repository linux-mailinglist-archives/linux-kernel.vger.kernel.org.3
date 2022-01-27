Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8225649E2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiA0MmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241436AbiA0Mlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643287310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNXpPtb2OXqXG9hmJBWkzD608J4s2s8/JsJidLVyecU=;
        b=FMwClazeMY+BoRJaNbrSAcjtc2N9v3Ac57Z5m5eR01q6CTeb+iZF+3wuaMszcwPtujKz53
        8sXzsUnvTXPedzD7qgA5p9nPebAfCSQZkzZcBfL5E7OVjv+uEwJMka05m3Y27oiKzWDOMb
        uYNnI9ZSZUMOF+T2IJt+TIOCTnJx9Bs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-qdcE29NHMPWx48p0LTZ0YQ-1; Thu, 27 Jan 2022 07:41:49 -0500
X-MC-Unique: qdcE29NHMPWx48p0LTZ0YQ-1
Received: by mail-ed1-f69.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so1351583edt.15
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNXpPtb2OXqXG9hmJBWkzD608J4s2s8/JsJidLVyecU=;
        b=mlxpTXQIKrbz57ADQ9JfGyN7FY8ea+6NbaGSZFzPLoDhZBwiJwPewYeLM+kT6Usmzc
         3sJh+OdhqYS19iXu6IVnsmUJZzpZ69sumt0278Ns+SX88V9c45Im9jPSUUIlc8MoZ/CE
         yq3n/QDRopPb/iIUshevu/WAurK0/jXn46uaZW+pCzg/UvdBfnSp4gunK8Pwu25WdZ2m
         LWkHLg4vjdUw6maTLtG9/zFAgRG3CHR+yP3ygSzQJcgWW6YGCNDMZZJv8BT7fjZs3e/p
         QHaTgDKQinMUjMm+3GVLjkj5jxQkbHNaCmffnxQADOhOryUu+D9t1HtnNOQTscla4F9j
         WBQA==
X-Gm-Message-State: AOAM530ULmW64rklI79iDWCUmQ4RqyQEZLuLWGy0VMx1SMUWl79Bqqg5
        XqddU9MvZvOdxO+ymJT0P1b1X26hvQWVHQmDAyTYPKT+3S5nZIgoNITrcy4mixoOrjZf7PF97/2
        k56WSygg8UfvLvSZ72JOCiRCd
X-Received: by 2002:a17:907:7d89:: with SMTP id oz9mr2684962ejc.400.1643287308392;
        Thu, 27 Jan 2022 04:41:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyotloQ/8jLEyYVrL4x9QKTye3cSBEx1XpJh+giSQrDeyBAnixpRAjtIqNHOtrp8KFRexubOA==
X-Received: by 2002:a17:907:7d89:: with SMTP id oz9mr2684950ejc.400.1643287308220;
        Thu, 27 Jan 2022 04:41:48 -0800 (PST)
Received: from redhat.com ([2.55.140.126])
        by smtp.gmail.com with ESMTPSA id g9sm8674052ejf.98.2022.01.27.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:41:47 -0800 (PST)
Date:   Thu, 27 Jan 2022 07:41:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: Make use of the helper macro kthread_run()
Message-ID: <20220127074050-mutt-send-email-mst@kernel.org>
References: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 10:08:07AM +0800, Yin Xiujiang wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..19e9eda9fc71 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -595,7 +595,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  
>  	dev->kcov_handle = kcov_common_handle();
>  	if (dev->use_worker) {
> -		worker = kthread_create(vhost_worker, dev,
> +		worker = kthread_run(vhost_worker, dev,
>  					"vhost-%d", current->pid);
>  		if (IS_ERR(worker)) {
>  			err = PTR_ERR(worker);
> @@ -603,7 +603,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  		}
>  
>  		dev->worker = worker;
> -		wake_up_process(worker); /* avoid contributing to loadavg */
>  
>  		err = vhost_attach_cgroups(dev);
>  		if (err)

I think if you do this, you need to set dev->worker earlier.

> -- 
> 2.30.0


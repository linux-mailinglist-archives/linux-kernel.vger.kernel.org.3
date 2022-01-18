Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0048C491CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357213AbiARDUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:20:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344909AbiARDHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642475268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CQmErdVbSRr9mtW1+GyxSplP9tubMADIUUmh9Y+ayg=;
        b=RRs87RMkYCJl+mUZsopuZkbmBCLWShGxMcq3HiFwVU3BbaoXLrXpVHmWY09WUOXYY+W0cw
        wtsopjdvkYnRnzJRWHv2k54tW6JDDFT3kQPKc1GO1eUg7zc2hOUwMgAn0lYWClXTsDw8Nf
        /jYQBjHw0Z0fxtq8eBUPM87CY8UEvvg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-jAzbXKuuO5e0qbI83MfkKQ-1; Mon, 17 Jan 2022 22:07:47 -0500
X-MC-Unique: jAzbXKuuO5e0qbI83MfkKQ-1
Received: by mail-pf1-f199.google.com with SMTP id o189-20020a625ac6000000b004be3e78847dso7289153pfb.14
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 19:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9CQmErdVbSRr9mtW1+GyxSplP9tubMADIUUmh9Y+ayg=;
        b=LRR7/TCAYPFFn5ijZgHEIBKa1TEYOO719toC/r4mDAV7ld3oBmVMr87Z54c3AM3MwA
         3VIJS1uT2U8iGkWgxOOzcAgI6F3UI1ERC3//Ow8sieDrTTnVsvvA8hq5yBuXSe4EWjX/
         +LZC95XNQcMiouPd4WQJ77lc8ohoiwnJbXrJYN+uCa841QptFAsx66kNNGphHsnOhdzF
         y2t1V4qihwd3n89Ifikl/XJSKLvWHutbYq5DU9Dfbw02DJ/iX7Tj6K9hpz9Lcas+pVYn
         v0YpK7ARz1gElJI94Us1npmIlrhYCq8WRD3JJznr9piPCcQMycPlSYORsE3+Se0UpMFA
         4HHQ==
X-Gm-Message-State: AOAM530VKi13lmXkqlEj7N+KjJr66a10dA0FgIQnWJariSnIC6/VnoQY
        y1QD/WUzvCBJ/EBoOp2j7cunxYS78N5fih/1HUjH6Mp995aIpL+cDsZSPhmfGJvdMJ7s6EsVsFY
        lEnAkWM1Nesl07jj6qwh+Ww3e
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr21688276pgd.601.1642475265999;
        Mon, 17 Jan 2022 19:07:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGn88ixeCz13kpjGb4SysE+JIuenybALI9UvqarO/71VSQGXiBlHPncz3hIYzN/LcoVqqxiA==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr21688268pgd.601.1642475265770;
        Mon, 17 Jan 2022 19:07:45 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a19sm4801961pfh.198.2022.01.17.19.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 19:07:45 -0800 (PST)
Message-ID: <1a26d7b3-1020-50c5-f0a3-ebc645cdcddf@redhat.com>
Date:   Tue, 18 Jan 2022 11:07:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC 2/3] vdpa: support exposing the count of vqs to userspace
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com
References: <20220117092921.1573-1-longpeng2@huawei.com>
 <20220117092921.1573-3-longpeng2@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220117092921.1573-3-longpeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/17 下午5:29, Longpeng(Mike) 写道:
> From: Longpeng <longpeng2@huawei.com>
>
> - GET_VQS_COUNT: the count of virtqueues that exposed
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
>   drivers/vhost/vdpa.c       | 13 +++++++++++++
>   include/uapi/linux/vhost.h |  3 +++
>   2 files changed, 16 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 1eea14a4ea56..c1074278fc6b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -369,6 +369,16 @@ static long vhost_vdpa_get_config_size(struct vhost_vdpa *v, u32 __user *argp)
>   	return 0;
>   }
>   
> +static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __user *argp)
> +{
> +	struct vdpa_device *vdpa = v->vdpa;


While at it, I think it's better to change vdpa->nvqs to use u32?

Thanks


> +
> +	if (copy_to_user(argp, &vdpa->nvqs, sizeof(vdpa->nvqs)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>   				   void __user *argp)
>   {
> @@ -509,6 +519,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>   	case VHOST_VDPA_GET_CONFIG_SIZE:
>   		r = vhost_vdpa_get_config_size(v, argp);
>   		break;
> +	case VHOST_VDPA_GET_VQS_COUNT:
> +		r = vhost_vdpa_get_vqs_count(v, argp);
> +		break;
>   	default:
>   		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>   		if (r == -ENOIOCTLCMD)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index bc74e95a273a..5d99e7c242a2 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -154,4 +154,7 @@
>   /* Get the config size */
>   #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
>   
> +/* Get the count of all virtqueues */
> +#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
> +
>   #endif


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA146D07F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhLHKI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhLHKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638957893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seZrGQmXeEuKGQyGFf5JkGZu8lxesI1wCr3AFLFyMKw=;
        b=TYa2T/bbHF/lI+8zVur+wjj2rjwatTQ6n9wkp9tOZW9GmOog4Y77I+6JFcZ6r3qH6CnDRX
        b2iC+wxYQOkLxAVRyJTn2MhIE1ydGEX/1DJI7wJp71mdV4wiQ7pcO+euoezjJOiMHK5QCg
        MkILVhFIBwhw/jH0RaSE3B9qfv+qBGQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-560-bvmFUxAJPVae_hOMxryo5w-1; Wed, 08 Dec 2021 05:04:52 -0500
X-MC-Unique: bvmFUxAJPVae_hOMxryo5w-1
Received: by mail-wm1-f71.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso2750060wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 02:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=seZrGQmXeEuKGQyGFf5JkGZu8lxesI1wCr3AFLFyMKw=;
        b=1ey9MtHwPJEszwXkg6AHtBbmpVsWKV2OFCpuuUV0EAGZ/nbkVZKlz4W8x+3o6SowP8
         9bmXkDcnWQsM/DKqnBxzAaDsVc9HlrZntQxFSEj32iGv7zFQjYX/OXQG3SlWYYVe/XMz
         V630/iA7o9n0WaG5vkRtxhtKXWrKvgzqhQMS994+8uuFIo1Xqo/aLOiXhRJRVm/1VhpE
         c5r7jSMkeXjIBfXyqLq1olD58zOfR6T6QqJ5BwoBqeSqbgl4DjahD29tCUYyrwQnmcQl
         aHO8NzZC+jaccPPB9yjV9HuxvGbiKPxntFy3u7o7tlWjFH8D/qiCmNR6UQcS/fxQ+jWM
         KIHw==
X-Gm-Message-State: AOAM532RQ2LqX8wCIVysStbLxSlZOoV5AivlEJjXfTeAMG7dJF6OonvT
        WhScfUyDppd3DqrvypmOx1LDsf/jh671QJBdS/e6MFWYzho14OynfQdmpllcs8JiEQoMXC6WpNr
        PpnX5q0RVsxMjBuaG/emLJge1
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr14777947wmr.55.1638957891476;
        Wed, 08 Dec 2021 02:04:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdcNwEWa7rgCxr52WTfkeLsyMwjlEgzt5mtjl0IAuWFdeXWYYn1Ccg/hLEM3PH/NUR+dqiDQ==
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr14777914wmr.55.1638957891267;
        Wed, 08 Dec 2021 02:04:51 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id y12sm2277928wrn.73.2021.12.08.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 02:04:50 -0800 (PST)
Message-ID: <804a914d-3e1d-1439-f8b5-3b514cda0f6e@redhat.com>
Date:   Wed, 8 Dec 2021 11:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 06/32] s390/airq: allow for airq structure that uses an
 input vector
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211207205743.150299-1-mjrosato@linux.ibm.com>
 <20211207205743.150299-7-mjrosato@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20211207205743.150299-7-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 21.57, Matthew Rosato wrote:
> When doing device passthrough where interrupts are being forwarded
> from host to guest, we wish to use a pinned section of guest memory
> as the vector (the same memory used by the guest as the vector).
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
[...]
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 880bcd73f11a..dfd4f3276a6d 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
[...]
> @@ -443,7 +443,7 @@ static int __init zpci_directed_irq_init(void)
>   		zpci_ibv[cpu] = airq_iv_create(cache_line_size() * BITS_PER_BYTE,
>   					       AIRQ_IV_DATA |
>   					       AIRQ_IV_CACHELINE |
> -					       (!cpu ? AIRQ_IV_ALLOC : 0));
> +					(!cpu ? AIRQ_IV_ALLOC : 0), 0);

Nit: Indentation changed

> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 52c376d15978..ff84f45587be 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -241,7 +241,7 @@ static struct airq_info *new_airq_info(int index)
>   		return NULL;
>   	rwlock_init(&info->lock);
>   	info->aiv = airq_iv_create(VIRTIO_IV_BITS, AIRQ_IV_ALLOC | AIRQ_IV_PTR
> -				   | AIRQ_IV_CACHELINE);
> +				| AIRQ_IV_CACHELINE, 0);

dito

>   	if (!info->aiv) {
>   		kfree(info);
>   		return NULL;
> 

  Thomas


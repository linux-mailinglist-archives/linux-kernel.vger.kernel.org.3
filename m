Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A910549DC97
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiA0IcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230518AbiA0IcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643272333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hzsSfEt812B+qp8pLaEKXZY4iqaixHPcS2PC/AJjRY=;
        b=MurpCxLX4MVfpLh+nEA96tThpLOhga6z7gnKh/XUDxLL+ELwWmcZzeRtvf6tuyONCxq+Ou
        Azycl2Am14mXf/34nNrDFznt6XCwMW9zbLOPAv8rRrbN+Hemlq/9WHN1Lr/xaygnPKnGmq
        IqhnfIrWIrNtvqavcD8pp2yEwxrqj9I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-_8HDbyYwNZWxExkx_HiHZg-1; Thu, 27 Jan 2022 03:32:11 -0500
X-MC-Unique: _8HDbyYwNZWxExkx_HiHZg-1
Received: by mail-lf1-f71.google.com with SMTP id c7-20020ac24147000000b0042ac92336d1so794985lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hzsSfEt812B+qp8pLaEKXZY4iqaixHPcS2PC/AJjRY=;
        b=YkriN4y+eGSXYYOxjO2v9fAer+6sFLoM54F+72+WloPu6hbalW1ekmck8mZHMmIOYO
         jSI58b7iR+R3LuDLjEqjzU/H8MYCAE7tYGdQ43b9RC5HxJpmA255KiWX0zFjbOyB7qTE
         z531K/V25t2XA/i+hc6AL+a7ej0EWEJFprKF14VKmtOQPU66zNRB4Ap0UOLthr27Lser
         /9ZwIdtZBZoacBBKkTpOMVlofO3gC8DHLf5Z61nuk8x93YfXogXdutXRHb8kJrU7A/3G
         mcTouuOmPl33WUmreRtRSByVkwGxRDMKCWhSGjlrCJlRcD9TDO6BRt0GZnBn035RVTKj
         BnBw==
X-Gm-Message-State: AOAM530LuzsZ5s7sOG7EX9K0u3eWiXSYbd6Glxo0jJdbbdbmyfnUEzYb
        6oVtKVJHdZcCHwP9AStSqv7pqwPqhhZH2uKMLgvYArUVUjhLDXMjIPV85fKzdc0FcH0wnDy/DVN
        8KpKvOiX9sgNbCnIC5hvTMxDvVqX88+wfbhCydBlT
X-Received: by 2002:a19:6a12:: with SMTP id u18mr2163156lfu.348.1643272330234;
        Thu, 27 Jan 2022 00:32:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn9eSiGGfhLO0zjsI1+u0gJevThcq9mgdnntxuPkuBy9qCRRpx6z8S1fE44dsCdfLi8ZxWyEDp9ctCVdi+w8s=
X-Received: by 2002:a19:6a12:: with SMTP id u18mr2163143lfu.348.1643272329966;
 Thu, 27 Jan 2022 00:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
In-Reply-To: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 27 Jan 2022 16:31:58 +0800
Message-ID: <CACGkMEtEYmVNWqaaEhLZgiv9HZGUAP6zwqXfpdDA_CM2_tav0Q@mail.gmail.com>
Subject: Re: [PATCH] vhost: Make use of the helper macro kthread_run()
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>
Cc:     mst <mst@redhat.com>, kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 10:08 AM Yin Xiujiang <yinxiujiang@kylinos.cn> wrote:
>
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
>         dev->kcov_handle = kcov_common_handle();
>         if (dev->use_worker) {
> -               worker = kthread_create(vhost_worker, dev,
> +               worker = kthread_run(vhost_worker, dev,
>                                         "vhost-%d", current->pid);

Mike plans to introduce user_worker_create() to allow rlimit check[1].
So this is probably not needed.

Thanks

[1] https://www.spinics.net/lists/kernel/msg4161030.html (I'm not sure
this is the recent version, please check the list)


>                 if (IS_ERR(worker)) {
>                         err = PTR_ERR(worker);
> @@ -603,7 +603,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>                 }
>
>                 dev->worker = worker;
> -               wake_up_process(worker); /* avoid contributing to loadavg */
>
>                 err = vhost_attach_cgroups(dev);
>                 if (err)
> --
> 2.30.0
>


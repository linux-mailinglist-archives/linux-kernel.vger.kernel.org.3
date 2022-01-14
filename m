Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2512748E427
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiANGSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229717AbiANGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642141095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YawaJX8lTftoOW61Y7U6IA50jMGmbdQaYnSxlW1+tHw=;
        b=iYMZJ06Ov2MIwtjGo2PkdfMaiiH6PXBVB7rHMu+VFtchAv02b1AYAU7Pil/cgNyKjyn5dy
        nVRYx7NTiESJRK3UfWGYu8KuJmqT42gxNAm7xbq4UJ/N4E+FIjQWY+mmA7SfH2uyrTbGvb
        iz+jG1HNv4OjybxNEqufpEOOfubsnwQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-jd7chlQgPbKom_wRYui7Gw-1; Fri, 14 Jan 2022 01:18:13 -0500
X-MC-Unique: jd7chlQgPbKom_wRYui7Gw-1
Received: by mail-lf1-f71.google.com with SMTP id z23-20020a0565120c1700b004258a35caf2so5525895lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YawaJX8lTftoOW61Y7U6IA50jMGmbdQaYnSxlW1+tHw=;
        b=Q6PNCtrx7wL84wePhJAd7IVYX3gkVYlgu9fh+1AtUBMubYHcBQjcOSvm1ijIxSssoU
         suaGFZh826NzwPmb0Xy4isVesocmWOaf0o4b6m6yFb9zOX12QcKHc9MMUGaQbdyhoul5
         TM+j5dy8sstsSneSvHNeUXTj9SOlm1qTTrA5EU+agBWNTWvFPsZhtBKsfUJKJ1e8s9PC
         SJcwlT7JDET0gN9OzqIotk6z4SzsU6iKJPkZHe3HwAua1OE1brUlFgaWX99e0a82032o
         Ltc1eZG0de/NdgtA7HbmGBvCJxa4x2ICZs5mpKaW2gszbkw08ZBFlgtNTOP1wcs2zK9G
         ClVQ==
X-Gm-Message-State: AOAM530He7gdxGaenxj1FYmxfLMEh0foCRqRKbSepEqd6vOGz3ouAqKr
        4CI+x1e3Q+ochtmqFrGP/czzkeX7y/U5kkJeJb4Fx6/jgJUAmQDyvHbKbZO1GyNR2lzVoLY9zFx
        ZuFhjrPqXxRtNW3g+6vF6N4NcNOqaDLXnd5qc52dk
X-Received: by 2002:a2e:8645:: with SMTP id i5mr2054347ljj.420.1642141092220;
        Thu, 13 Jan 2022 22:18:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6Nfbams2KnY3qknpeMJm2YPphc5XVQuPf+9aKqnItDdPeixnxkwbf4f/KJ8Znvhi0j4XtHNEKy5oo568WAt4=
X-Received: by 2002:a2e:8645:: with SMTP id i5mr2054339ljj.420.1642141092040;
 Thu, 13 Jan 2022 22:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20220113145642.205388-1-sgarzare@redhat.com>
In-Reply-To: <20220113145642.205388-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Jan 2022 14:18:01 +0800
Message-ID: <CACGkMEsqY5RHL=9=iny6xRVs_=EdACUCfX-Rmpq+itpdoT_rrg@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:57 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> In vhost_enable_notify() we enable the notifications and we read
> the avail index to check if new buffers have become available in
> the meantime. In this case, the device would go to re-read avail
> index to access the descriptor.
>
> As we already do in other place, we can cache the value in `avail_idx`
> and compare it with `last_avail_idx` to check if there are new
> buffers available.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Patch looks fine but I guess we won't get performance improvement
since it doesn't save any userspace/VM memory access?

Thanks

> ---
>  drivers/vhost/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..07363dff559e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                        &vq->avail->idx, r);
>                 return false;
>         }
> +       vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>
> -       return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
> +       return vq->avail_idx != vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>
> --
> 2.31.1
>


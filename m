Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287124E1F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbiCUC5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbiCUC5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0CF659A4D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647831356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NO2jMNKPbBxPcOjWsAxlUEBqWe3bFA7aWl8mJ0qi/hQ=;
        b=XDCpPIBkkLeSMiLhRaC/kCeoPFNEB1pPyw/I6xPdylSfV7bQ5TRIGMXLSrlivXCTCDsgHD
        l5nLeu+RJPnUXiuPv9YiLNGQUYX6TjkOOHyaOJUrmFhpvQfZIM4w/950Gsj3BYIvsfaXQI
        VGyLVGfcDrjJ8OV0FBcy06xYoG/1a3I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-joRzUJRKMl6DG4zSygLokw-1; Sun, 20 Mar 2022 22:55:55 -0400
X-MC-Unique: joRzUJRKMl6DG4zSygLokw-1
Received: by mail-lf1-f70.google.com with SMTP id bt40-20020a056512262800b004481fbe2d29so3406938lfb.16
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO2jMNKPbBxPcOjWsAxlUEBqWe3bFA7aWl8mJ0qi/hQ=;
        b=6iqXpoFNCygdakeexzyK9LPwNQzLA7FjmsiQAdO2y0M2/EHRP5Yd+BtmuKr3hyQqTt
         3qVmhrcs7l9KvGMPm5OEmC8UsrMfBMXgHi/y3fM9HXXJ+jiO+Lp95D3bggFUWVXU/CVa
         uk2l3S3PCcrKw8beW7QdGEYThwLq1IPn61eWJfv3ehb7M5negBFYdac3C9pNJvfmQtOh
         AnNqPPUlsphWJIFAcruq6rXOwtXJawJmSFN+3CjLIzpOBV8xEtT2GpyowqsmdGbHV4aR
         uBt6v6+1teXR0B2P/A6xahVT06sBGMmN1jAmBdmA7FOvo7SWKRpr4RdlZBmTyGxEvQTZ
         fnHw==
X-Gm-Message-State: AOAM531AtKKO/L7LRH4iy/fhDMihe7JMl0ARYf83uZOAWvti0f3p8X2+
        9RnzFyAEpTqKUGk1PgDZ9zVm6AFxMZ9LVasgslTYZ7qw4Ao8f0AD6F+eaG7oF218j8m1H+yODqa
        97+E6diYFltFAGVMsetOejj0rrMV8WbM89jJbR715
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id j14-20020a2e824e000000b002497e3dc862mr4913443ljh.97.1647831354089;
        Sun, 20 Mar 2022 19:55:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn4DYJfL7k43PA+Q+9rNfsf0PxiZcBUxbi0IZnQ1UxD/sDF7hmUd0d6p8+yDx5iXE6+RNwYtqAi0iA6OLkqTs=
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id
 j14-20020a2e824e000000b002497e3dc862mr4913431ljh.97.1647831353900; Sun, 20
 Mar 2022 19:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220320074449.4909-1-mail@anirudhrb.com>
In-Reply-To: <20220320074449.4909-1-mail@anirudhrb.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 21 Mar 2022 10:55:42 +0800
Message-ID: <CACGkMEtRrmXP-xjggRRSeoJT=9JTAXktPnZdvK-KYbKr4Zxc8g@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: handle error while adding split ranges to iotlb
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 3:45 PM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
>
> vhost_iotlb_add_range_ctx() handles the range [0, ULONG_MAX] by
> splitting it into two ranges and adding them separately. The return
> value of adding the first range to the iotlb is currently ignored.
> Check the return value and bail out in case of an error.
>
> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>
> v2:
> - Add "Fixes:" tag and "Reviewed-by:".
>
> v1:
> https://lore.kernel.org/kvm/20220312141121.4981-1-mail@anirudhrb.com/
>
> ---
>  drivers/vhost/iotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 40b098320b2a..5829cf2d0552 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -62,8 +62,12 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
>          */
>         if (start == 0 && last == ULONG_MAX) {
>                 u64 mid = last / 2;
> +               int err = vhost_iotlb_add_range_ctx(iotlb, start, mid, addr,
> +                               perm, opaque);
> +
> +               if (err)
> +                       return err;
>
> -               vhost_iotlb_add_range_ctx(iotlb, start, mid, addr, perm, opaque);
>                 addr += mid + 1;
>                 start = mid + 1;
>         }
> --
> 2.35.1
>


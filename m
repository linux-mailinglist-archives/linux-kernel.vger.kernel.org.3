Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FF55F4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiF2EKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiF2EKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F11E3631A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656475847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bg6heNJXq50eL6WsFIMxRV6MiBd1t5LqWZMr8mmOcec=;
        b=TCpZHVJ3ivj+IeKzkj7z6dLwyDYdKVZlzNdadB+WYozqswSUtzFHJ/F03HwVh2G70l776L
        noCUqHaTWHPev4GirHSFxeyMO100ViHkNuYZ+9hla9Vj9iIhavilwu8uqBXYylNPCQGtyQ
        O1i2RdeHqyDhaa5ykdvvzn033UfCVl8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-sgAEGjAlMMORqk1g9Nzraw-1; Wed, 29 Jun 2022 00:10:45 -0400
X-MC-Unique: sgAEGjAlMMORqk1g9Nzraw-1
Received: by mail-lf1-f70.google.com with SMTP id o7-20020a056512230700b004810a865709so4832209lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bg6heNJXq50eL6WsFIMxRV6MiBd1t5LqWZMr8mmOcec=;
        b=kvf5LqQJzgD+F4I/XhphJv5kcGB8OAQUTLAITNUv60L5z9ZYApv32nEh4m4RgNNdzP
         xWPo32lyhOCXxZl2S5thIRQloap4tChlzAJSSVjftrVHcEvBFUGpEtes1s8RvXHZeGo8
         8c6qvgagePwXDKxucDsG5RSH9NPzXCcYZz5Q/C4kW9fEDXoHJLezHGzpLKAuFgfrr2N8
         xKpsF+YRGyjjqpnca5yqGmmesE7G8ZNsa/gO2mEk4Rdk+W5siq27IaMavHIT/SIYW6D+
         +8Rvudp5PXgF/daDUXbfLeruI2V+76vEuBG0vyN9krNKnHTsHp55GKKwslP/Y6jDsOce
         6JGg==
X-Gm-Message-State: AJIora9/Qdq+wgAQQIOqjUlSSuNcE0KLizTcyMYwIqxwiQhjvpP4usJ3
        yieJYfr/gQWUlDNu/O5ClbYpt//3wxM0oFiI8tN6t9YkZvRXURght/o6zyU8odXu7nXN+p+Joa+
        s1Gdd0RutVVHng5k2zwzNWOvkc2+7lJS+7KH7sR5C
X-Received: by 2002:a05:651c:1610:b0:25a:75fa:f9cc with SMTP id f16-20020a05651c161000b0025a75faf9ccmr615145ljq.243.1656475843851;
        Tue, 28 Jun 2022 21:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tsRfqKSJ5WREAe866tYR2Av6sXWiFQwf7Na0t+bQDdXFNQBHVv7PWUm2aQHXPC9OFidZUGp5C/19n3ZUbyfXY=
X-Received: by 2002:a05:651c:1610:b0:25a:75fa:f9cc with SMTP id
 f16-20020a05651c161000b0025a75faf9ccmr615131ljq.243.1656475843670; Tue, 28
 Jun 2022 21:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com> <20220623160738.632852-2-eperezma@redhat.com>
In-Reply-To: <20220623160738.632852-2-eperezma@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 29 Jun 2022 12:10:32 +0800
Message-ID: <CACGkMEv+yFLCzo-K7eSaVPJqLCa5SxfVCmB=piQ3+6R3=oDz-w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] vdpa: Add suspend operation
To:     =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Cindy Lu <lulu@redhat.com>,
        "Kamde, Tanuj" <tanuj.kamde@amd.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        "Uminski, Piotr" <Piotr.Uminski@intel.com>,
        habetsm.xilinx@gmail.com, "Dawar, Gautam" <gautam.dawar@amd.com>,
        Pablo Cascon Katchadourian <pabloc@xilinx.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Longpeng <longpeng2@huawei.com>,
        Dinan Gunawardena <dinang@xilinx.com>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Martin Porter <martinpo@xilinx.com>,
        Eli Cohen <elic@nvidia.com>, ecree.xilinx@gmail.com,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Harpreet Singh Anand <hanand@xilinx.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Zhang Min <zhang.min9@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:07 AM Eugenio P=C3=A9rez <eperezma@redhat.com> w=
rote:
>
> This operation is optional: It it's not implemented, backend feature bit
> will not be exposed.

A question, do we allow suspending a device without DRIVER_OK?

Thanks

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  include/linux/vdpa.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7b4a13d3bd91..d282f464d2f1 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -218,6 +218,9 @@ struct vdpa_map_file {
>   * @reset:                     Reset device
>   *                             @vdev: vdpa device
>   *                             Returns integer: success (0) or error (< =
0)
> + * @suspend:                   Suspend or resume the device (optional)
> + *                             @vdev: vdpa device
> + *                             Returns integer: success (0) or error (< =
0)
>   * @get_config_size:           Get the size of the configuration space i=
ncludes
>   *                             fields that are conditional on feature bi=
ts.
>   *                             @vdev: vdpa device
> @@ -319,6 +322,7 @@ struct vdpa_config_ops {
>         u8 (*get_status)(struct vdpa_device *vdev);
>         void (*set_status)(struct vdpa_device *vdev, u8 status);
>         int (*reset)(struct vdpa_device *vdev);
> +       int (*suspend)(struct vdpa_device *vdev);
>         size_t (*get_config_size)(struct vdpa_device *vdev);
>         void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
>                            void *buf, unsigned int len);
> --
> 2.31.1
>


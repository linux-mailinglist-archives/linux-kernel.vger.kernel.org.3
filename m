Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16094CD1BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiCDJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiCDJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:56:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 379ADBDE7B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646387712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/28R4qLiomcMPqm8kqlF7h66zN6UfIf8KZF8W80+TY=;
        b=ECYJTjII5tkGSnTyyKdn/t1kZFO/JiMzrBSNPEM/k4zyvME1bNYTNgSextzzNZ2B/cfiGn
        goamefYS5KUGaLKddN5TkW01iRc1xFyqiSvsUkL1+aalfxOQLJzTd6PM3uMsPpIxBIGTp7
        NxH7nGQR90kztw0biGduivednArKBSI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-Rj538yniM_a147m0Uuszgg-1; Fri, 04 Mar 2022 04:55:11 -0500
X-MC-Unique: Rj538yniM_a147m0Uuszgg-1
Received: by mail-lf1-f70.google.com with SMTP id m13-20020a19520d000000b00443423ff116so2523169lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 01:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/28R4qLiomcMPqm8kqlF7h66zN6UfIf8KZF8W80+TY=;
        b=TAYkD6WmJTgp/S6OCfEAOTBG6it8n8AgHlJlTNOnvevX3OqFu7Z9a9lckafIIy0IYK
         fbwqFWym17z4fgHi0ygqIydH4bjTS6xs0h/qlk+fzAIKmKeDYfWBogs1NZUqavOkqBLB
         2tK94gRya/soD7YILzPERmX5XP2xZXasW4DUMdq57eB+GbnivvdvIvrE7eQWPbq9gtFe
         IHvO35G1Vc3LmS3zNO0OQgKabhsLBo04CH2DMEKI2BNlLySrKBszfyt3EfNKszqAcgHx
         2CCfVEbAzCMUU+QeNR7/1a2wJo7Kl5hPnLOA7yJUK4yKU8KaCGHWAuFpl+arw2b07Vv/
         obqQ==
X-Gm-Message-State: AOAM5315Xn6eVQz0iT7FJe82yf0iRSS0YXWUNWCb8b9exbM/MK8QnuJw
        11N6KQbWsyY9erEHo9CcsBcLi75+K2Z/YAdXQRS3vw8fL9UtXgAdImtDVt6lWjJUq5XP2Ue9mY2
        HnSPZHx/RfnQ1zvWiLUjZvOpGpDdZb/2oxayF39YD
X-Received: by 2002:a2e:9dcf:0:b0:246:3ff1:d770 with SMTP id x15-20020a2e9dcf000000b002463ff1d770mr25533594ljj.330.1646387709937;
        Fri, 04 Mar 2022 01:55:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIVUvPTZQTrJF/DAKSScLnIn2uD7l2XJ7Qf89pRTkwDeCrip5XsA/bOwodD7WRlPRyWFKePlZrlUJRKdMeuwk=
X-Received: by 2002:a2e:9dcf:0:b0:246:3ff1:d770 with SMTP id
 x15-20020a2e9dcf000000b002463ff1d770mr25533577ljj.330.1646387709718; Fri, 04
 Mar 2022 01:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20201216064818.48239-1-jasowang@redhat.com> <20220224212314.1326-1-gdawar@xilinx.com>
 <20220224212314.1326-8-gdawar@xilinx.com>
In-Reply-To: <20220224212314.1326-8-gdawar@xilinx.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 4 Mar 2022 10:54:33 +0100
Message-ID: <CAJaqyWcAT05-MtOZkyiyNezSzEEmyyDdps0aWm7PMuyS4jqNdA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/19] vdpa: introduce config operations for
 associating ASID to a virtqueue group
To:     Gautam Dawar <gautam.dawar@xilinx.com>
Cc:     Gautam Dawar <gdawar@xilinx.com>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Harpreet Singh Anand <hanand@xilinx.com>, tanujk@xilinx.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        Longpeng <longpeng2@huawei.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 10:25 PM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>
> This patch introduces a new bus operation to allow the vDPA bus driver
> to associate an ASID to a virtqueue group.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
> ---
>  include/linux/vdpa.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index de22ca1a8ef3..7386860c3995 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -239,6 +239,12 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             Returns the iova range supported by
>   *                             the device.
> + * @set_group_asid:            Set address space identifier for a
> + *                             virtqueue group
> + *                             @vdev: vdpa device
> + *                             @group: virtqueue group
> + *                             @asid: address space id for this group
> + *                             Returns integer: success (0) or error (< 0)
>   * @set_map:                   Set device memory mapping (optional)
>   *                             Needed for device that using device
>   *                             specific DMA translation (on-chip IOMMU)
> @@ -321,6 +327,10 @@ struct vdpa_config_ops {
>                        u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
>         int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
>                          u64 iova, u64 size);
> +       int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
> +                             unsigned int asid);
> +
> +

Nit again, and Jason's patch already contained these, but I think
these two blank lines are introduced unintentionally.

>
>         /* Free device resources */
>         void (*free)(struct vdpa_device *vdev);
> --
> 2.25.0
>


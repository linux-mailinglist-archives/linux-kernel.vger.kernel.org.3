Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCE05535C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352625AbiFUPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352464AbiFUPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 140F61F2CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655824808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1aTQGCdCd/WCCg+CdRK2dqhWGiAOwiqqFPLYHWnZ4I=;
        b=gRxB6WDhbl+5LsBxxDdZmpCXqzr9RyN+nkmdg4in3Cc9AOZnREh/kdZ80+g6W5kQOgL8Yb
        m9PitzdL64PO9xfavzon8Xgj/ghI9ne7dTnGl+XE9fHVSxLCp76ve95+dznX2OsG6o7bJi
        23J5dyTX0ONoVTsuTiKQPoz/0UDzeYg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418--UDbsASrPQWR2rkwQyHfrA-1; Tue, 21 Jun 2022 11:20:06 -0400
X-MC-Unique: -UDbsASrPQWR2rkwQyHfrA-1
Received: by mail-qk1-f199.google.com with SMTP id k188-20020a37a1c5000000b006a6c4ce2623so16763021qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1aTQGCdCd/WCCg+CdRK2dqhWGiAOwiqqFPLYHWnZ4I=;
        b=4MjyddfbT9O2h52sbiVdugJACVkMFbbSEFVYrx23+LGoK2FixTP2sgnNAcrBu5/aKL
         ULQOnjkfE/pN88spa/QVD227UhP7OfBfuJ/wv4EYCOoFVlYUroo20SaaJsMrW0zcg30E
         Oty6hmLpZgtmPpZbuIiNLdDXJuO8bLu9DgqPDuvSRFjzeEodaoUtlvIX/6jt5fXINfl4
         Km4cl28doZWO+RMOI62OWaFlvXNw5JbVg+s0sZCa3XNufJ4F5FFrZoE2XxB3wY84ABsL
         ORZgIC2iVuIWh7CAEMa8e3Mi1QtrbalsbSde42Lr9TjcnROB8z7mL7iKOz07Bqoeg+xV
         Rbpg==
X-Gm-Message-State: AJIora+VL6yZDKRhJhgeDPpRkPPpk/N1Ip/pGjRVzHjmyL7tzSWBISr7
        feuTjEe64/A2BJfhdfgpSNGAMcUQWRlz6DVXlhGN91eTTLjbI4GXEHau+T+7V+6fhgKpH1sStxR
        scmZJv7TzRBNgil08bkuUQn3w
X-Received: by 2002:a05:622a:f:b0:304:ea08:4227 with SMTP id x15-20020a05622a000f00b00304ea084227mr24100691qtw.620.1655824806128;
        Tue, 21 Jun 2022 08:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ugXnBnBHfSF1q+MNVy/kX/HyG2xqvUeAd8GBefFNsnB10JRRI6pctEPRk+wurKNpL2uMxC1Q==
X-Received: by 2002:a05:622a:f:b0:304:ea08:4227 with SMTP id x15-20020a05622a000f00b00304ea084227mr24100667qtw.620.1655824805766;
        Tue, 21 Jun 2022 08:20:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id bl38-20020a05620a1aa600b006a6bbc2725esm14686589qkb.118.2022.06.21.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:20:05 -0700 (PDT)
Date:   Tue, 21 Jun 2022 17:19:53 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Gautam Dawar <gautam.dawar@xilinx.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gdawar@xilinx.com>,
        Longpeng <longpeng2@huawei.com>, Eli Cohen <elic@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Harpreet Singh Anand <hanand@xilinx.com>,
        martinpo@xilinx.com, pabloc@xilinx.com, dinang@xilinx.com,
        "Kamde, Tanuj" <tanuj.kamde@amd.com>, habetsm.xilinx@gmail.com,
        ecree.xilinx@gmail.com, Eugenio Perez Martin <eperezma@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Min <zhang.min9@zte.com.cn>
Subject: Re: [PATCH v2 19/19] vdpasim: control virtqueue support
Message-ID: <CAGxU2F6OO108oHsrLBWJnYRG2yRU8QnRxAdjJhUUcp8AqaAP-g@mail.gmail.com>
References: <20220330180436.24644-1-gdawar@xilinx.com>
 <20220330180436.24644-20-gdawar@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330180436.24644-20-gdawar@xilinx.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gautam,

On Wed, Mar 30, 2022 at 8:21 PM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>
> This patch introduces the control virtqueue support for vDPA
> simulator. This is a requirement for supporting advanced features like
> multiqueue.
>
> A requirement for control virtqueue is to isolate its memory access
> from the rx/tx virtqueues. This is because when using vDPA device
> for VM, the control virqueue is not directly assigned to VM. Userspace
> (Qemu) will present a shadow control virtqueue to control for
> recording the device states.
>
> The isolation is done via the virtqueue groups and ASID support in
> vDPA through vhost-vdpa. The simulator is extended to have:
>
> 1) three virtqueues: RXVQ, TXVQ and CVQ (control virtqueue)
> 2) two virtqueue groups: group 0 contains RXVQ and TXVQ; group 1
>    contains CVQ
> 3) two address spaces and the simulator simply implements the address
>    spaces by mapping it 1:1 to IOTLB.
>
> For the VM use cases, userspace(Qemu) may set AS 0 to group 0 and AS 1
> to group 1. So we have:
>
> 1) The IOTLB for virtqueue group 0 contains the mappings of guest, so
>    RX and TX can be assigned to guest directly.
> 2) The IOTLB for virtqueue group 1 contains the mappings of CVQ which
>    is the buffers that allocated and managed by VMM only. So CVQ of
>    vhost-vdpa is visible to VMM only. And Guest can not access the CVQ
>    of vhost-vdpa.
>
> For the other use cases, since AS 0 is associated to all virtqueue
> groups by default. All virtqueues share the same mapping by default.
>
> To demonstrate the function, VIRITO_NET_F_CTRL_MACADDR is
> implemented in the simulator for the driver to set mac address.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 91 ++++++++++++++++++++++------
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  2 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 88 ++++++++++++++++++++++++++-
>  3 files changed, 161 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 659e2e2e4b0c..51bd0bafce06 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -96,11 +96,17 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
>  {
>         int i;
>
> -       for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
> +       spin_lock(&vdpasim->iommu_lock);
> +
> +       for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
>                 vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
> +               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
> +                                &vdpasim->iommu_lock);
> +       }
> +
> +       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> +               vhost_iotlb_reset(&vdpasim->iommu[i]);
>
> -       spin_lock(&vdpasim->iommu_lock);
> -       vhost_iotlb_reset(vdpasim->iommu);
>         spin_unlock(&vdpasim->iommu_lock);
>
>         vdpasim->features = 0;
> @@ -145,7 +151,7 @@ static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
>         dma_addr = iova_dma_addr(&vdpasim->iova, iova);
>
>         spin_lock(&vdpasim->iommu_lock);
> -       ret = vhost_iotlb_add_range(vdpasim->iommu, (u64)dma_addr,
> +       ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
>                                     (u64)dma_addr + size - 1, (u64)paddr, perm);
>         spin_unlock(&vdpasim->iommu_lock);
>
> @@ -161,7 +167,7 @@ static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
>                                 size_t size)
>  {
>         spin_lock(&vdpasim->iommu_lock);
> -       vhost_iotlb_del_range(vdpasim->iommu, (u64)dma_addr,
> +       vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
>                               (u64)dma_addr + size - 1);
>         spin_unlock(&vdpasim->iommu_lock);
>
> @@ -250,8 +256,9 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>         else
>                 ops = &vdpasim_config_ops;
>
> -       vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, 1,
> -                                   1, dev_attr->name, false);
> +       vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
> +                                   dev_attr->ngroups, dev_attr->nas,
> +                                   dev_attr->name, false);
>         if (IS_ERR(vdpasim)) {
>                 ret = PTR_ERR(vdpasim);
>                 goto err_alloc;
> @@ -278,16 +285,20 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>         if (!vdpasim->vqs)
>                 goto err_iommu;
>
> -       vdpasim->iommu = vhost_iotlb_alloc(max_iotlb_entries, 0);
> +       vdpasim->iommu = kmalloc_array(vdpasim->dev_attr.nas,
> +                                      sizeof(*vdpasim->iommu), GFP_KERNEL);
>         if (!vdpasim->iommu)
>                 goto err_iommu;
>
> +       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> +               vhost_iotlb_init(&vdpasim->iommu[i], 0, 0);
> +
>         vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
>         if (!vdpasim->buffer)
>                 goto err_iommu;
>
>         for (i = 0; i < dev_attr->nvqs; i++)
> -               vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu,
> +               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
>                                  &vdpasim->iommu_lock);
>
>         ret = iova_cache_get();
> @@ -401,7 +412,11 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>
>  static u32 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
>  {
> -       return 0;
> +       /* RX and TX belongs to group 0, CVQ belongs to group 1 */
> +       if (idx == 2)
> +               return 1;
> +       else
> +               return 0;

This code only works for the vDPA-net simulator, since 
vdpasim_get_vq_group() is also shared with other simulators (e.g.  
vdpa_sim_blk), should we move this net-specific code into 
vdpa_sim_net.c, maybe adding a callback implemented by the different 
simulators?

Thanks,
Stefano


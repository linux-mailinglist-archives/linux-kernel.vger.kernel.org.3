Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85F4C7CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiB1WHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiB1WHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 742F7131119
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646085980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g76Q1f7wfMD5s0Iq9NnNAaHx7TEHAaZl0n65azkoF4=;
        b=hGPIKQdiAJyEKaay8eOW4IXBTEuoiYkRPq0hEk9YOrlTz2PeuMIam7bSyaOeLxeFdyntha
        0VVgkL/n9yBxm9xk2irKq47LQmiDMKyqRaSc3nl+AI2Y5gI4Z5geuPQQVRpR1pOGTvBLyV
        5bpotWMxNlQvVChVfVyo1qpTtlYM+4g=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-GJfC8sXzNKeu_VtDNUvZcQ-1; Mon, 28 Feb 2022 17:06:19 -0500
X-MC-Unique: GJfC8sXzNKeu_VtDNUvZcQ-1
Received: by mail-oi1-f198.google.com with SMTP id bh17-20020a056808181100b002d4f3396ec3so6279478oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6g76Q1f7wfMD5s0Iq9NnNAaHx7TEHAaZl0n65azkoF4=;
        b=M4+APjiv9NIGSsTBuajrVFvAnu/YMvZbDDFunM1hLKKu7bfjS8s0/TTE5Qk52MwKNi
         WYjvSQOTToOJZ0rmS4YDR3buRpeXxI1FO2DThK6cCKLA7mMdZb1vtVjmcVdbUKty0HEy
         7sOgwTqS6HRLd6UgfhW/qCn0hqEgxTrPGnXMUWMHnvHWbms8ySsO7kwQ2Dc9lfSnmT03
         78bK78h/WfTlocdPDWZ+kRKDd9ielvtezQe8cLjdJy1h065KxywmhLBygG08ahZs+MVx
         VEekptzN3mFkfK7vWb0vowOO9nuqPqX3tdhHnaaubcnojOgU59hTs2Np5RfF2dRzobb3
         KOzA==
X-Gm-Message-State: AOAM533Ads4nGtoMy9dIZ/ulTEXR4NW5FoU5he9n7KoVa8OUjgELa9i2
        75qHrCgpmn1+9k7zup6znZ55TnMGP8A96qTPJvQFEMWiN1PUwqvvs2UCq7OQFhqsipFUizR/Gtw
        QZ7DnUgn0fklbXjkiiDCxM107
X-Received: by 2002:a05:6808:1a28:b0:2d7:3c61:e0d6 with SMTP id bk40-20020a0568081a2800b002d73c61e0d6mr12441286oib.32.1646085978567;
        Mon, 28 Feb 2022 14:06:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqktaI7nRschXFm6WIqpt/NJToJOLyZXiuWVFpjpKCqY9bZVPBmjxyvo/DJelsgeXDszQizg==
X-Received: by 2002:a05:6808:1a28:b0:2d7:3c61:e0d6 with SMTP id bk40-20020a0568081a2800b002d73c61e0d6mr12441258oib.32.1646085978346;
        Mon, 28 Feb 2022 14:06:18 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y2-20020a056808130200b002d542a72882sm7034767oiv.3.2022.02.28.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:06:17 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:06:15 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/11] vfio: Set DMA ownership for VFIO devices
Message-ID: <20220228150615.7026b3ae.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-8-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
        <20220228005056.599595-8-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 08:50:52 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Claim group dma ownership when an IOMMU group is set to a container,
> and release the dma ownership once the iommu group is unset from the
> container.
> 
> This change disallows some unsafe bridge drivers to bind to non-ACS
> bridges while devices under them are assigned to user space. This is an
> intentional enhancement and possibly breaks some existing
> configurations. The recommendation to such an affected user would be
> that the previously allowed host bridge driver was unsafe for this use
> case and to continue to enable assignment of devices within that group,
> the driver should be unbound from the bridge device or replaced with the
> pci-stub driver.
> 
> For any bridge driver, we consider it unsafe if it satisfies any of the
> following conditions:
> 
>   1) The bridge driver uses DMA. Calling pci_set_master() or calling any
>      kernel DMA API (dma_map_*() and etc.) is an indicate that the
>      driver is doing DMA.
> 
>   2) If the bridge driver uses MMIO, it should be tolerant to hostile
>      userspace also touching the same MMIO registers via P2P DMA
>      attacks.
> 
> If the bridge driver turns out to be a safe one, it could be used as
> before by setting the driver's .driver_managed_dma field, just like what
> we have done in the pcieport driver.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c     |  1 +
>  drivers/vfio/pci/vfio_pci.c           |  1 +
>  drivers/vfio/platform/vfio_amba.c     |  1 +
>  drivers/vfio/platform/vfio_platform.c |  1 +
>  drivers/vfio/vfio.c                   | 10 +++++++++-
>  5 files changed, 13 insertions(+), 1 deletion(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>


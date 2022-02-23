Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59324C1E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbiBWVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiBWVyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:54:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D73753E5F1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645653224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHc4p6P496hz/XkslW9zde1DsEfB8iSDkjx5qIKJc48=;
        b=L7gzNj9StIEUcC5xQmVVb7HRsLT5sLhhcaIhW9mJYoxtkxTnPxnn9jUZngwhqyxyO1b4/q
        Dux5YbnbShPYmAYm9nAjhXL4fQLqVlxjG/5oklcogr/gdk19Y9+IqD7vG73pJtTr1HRKEu
        re0RjXwzql23zYF7RCeTKdJIC3Zx6/g=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-hKNCrCOIO1mkBhg4Lt_6Lg-1; Wed, 23 Feb 2022 16:53:42 -0500
X-MC-Unique: hKNCrCOIO1mkBhg4Lt_6Lg-1
Received: by mail-ot1-f71.google.com with SMTP id q8-20020a056830232800b005ab75f5e906so12351343otg.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QHc4p6P496hz/XkslW9zde1DsEfB8iSDkjx5qIKJc48=;
        b=UOS7INAM4OU8RU5AICjkPslGCVUfZUObV/b6SpnroCjQ+4b29voN3QDmBymix/fTFp
         FGZ06lBW/g98ATndzEP+HiyDTH5c+nWVK6Dz1PgsDh9Ej2Or+lgDayyDW7GNB2WGGllg
         lIuHAYsVNQacWWw2TDdI6+dJEK0JIsTfdFUkOXZdB5LN+M3nAQdgGTtV7B5I2vq0KjcO
         ytCGcrkRejqqqMopER43pjCQdIkYdNzbkyIiGD/hJ1+ZlQsCM16Tjx9hGdkCoMHqKCcs
         s/jHBKNi8tGIwTN5O2OfhUzhOxQZDj38xqSVRX+EmVRV/RTTsn6tTh9HBAI0YfiyWHZm
         /1AQ==
X-Gm-Message-State: AOAM5321Vg5bT8nUiFZlKHyZrpWgDOjtte9tzoen2f0sihfJUjDbbZjL
        0kXBYPSLglQrXONWL9VVIGlJNdMABDb0aNnE9tIma70l3yvtnRHufAolUTCD82U0gsT0xX/cTyD
        Jpp1DqmPTj1eTVkzGeCnwzLd/
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id lk13-20020a0568703e0d00b000d3fe6d57c3mr780572oab.225.1645653222083;
        Wed, 23 Feb 2022 13:53:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVZWjYYf1lHUEZ749G1CD7yMY7PoElR7MtLZJgwYZu5lf142+Ut2Mxb4MgP1wHkjXeQTJkxQ==
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id lk13-20020a0568703e0d00b000d3fe6d57c3mr780550oab.225.1645653221851;
        Wed, 23 Feb 2022 13:53:41 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 128sm369711oor.15.2022.02.23.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 13:53:41 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:53:39 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
        rafael@kernel.org, David Airlie <airlied@linux.ie>,
        linux-pci@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 10/11] vfio: Remove iommu group notifier
Message-ID: <20220223145339.57ed632e.alex.williamson@redhat.com>
In-Reply-To: <20220218005521.172832-11-baolu.lu@linux.intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
        <20220218005521.172832-11-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 08:55:20 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The iommu core and driver core have been enhanced to avoid unsafe driver
> binding to a live group after iommu_group_set_dma_owner(PRIVATE_USER)
> has been called. There's no need to register iommu group notifier. This
> removes the iommu group notifer which contains BUG_ON() and WARN().
> 
> The commit 5f096b14d421b ("vfio: Whitelist PCI bridges") allowed all
> pcieport drivers to be bound with devices while the group is assigned to
> user space. This is not always safe. For example, The shpchp_core driver
> relies on the PCI MMIO access for the controller functionality. With its
> downstream devices assigned to the userspace, the MMIO might be changed
> through user initiated P2P accesses without any notification. This might
> break the kernel driver integrity and lead to some unpredictable
> consequences. As the result, currently we only allow the portdrv driver.
> 
> For any bridge driver, in order to avoiding default kernel DMA ownership
> claiming, we should consider:
> 
>  1) Does the bridge driver use DMA? Calling pci_set_master() or
>     a dma_map_* API is a sure indicate the driver is doing DMA
> 
>  2) If the bridge driver uses MMIO, is it tolerant to hostile
>     userspace also touching the same MMIO registers via P2P DMA
>     attacks?
> 
> Conservatively if the driver maps an MMIO region at all, we can say that
> it fails the test.

IIUC, there's a chance we're going to break user configurations if
they're assigning devices from a group containing a bridge that uses a
driver other than pcieport.  The recommendation to such an affected user
would be that the previously allowed host bridge driver was unsafe for
this use case and to continue to enable assignment of devices within
that group, the driver should be unbound from the bridge device or
replaced with the pci-stub driver.  Is that right?

Unfortunately I also think a bisect of such a breakage wouldn't land
here, I think it was actually broken in "vfio: Set DMA ownership for
VFIO" since that's where vfio starts to make use of
iommu_group_claim_dma_owner() which should fail due to
pci_dma_configure() calling iommu_device_use_default_domain() for
any driver not identifying itself as driver_managed_dma.

If that's correct, can we leave a breadcrumb in the correct commit log
indicating why this potential breakage is intentional and how the
bridge driver might be reconfigured to continue to allow assignment from
within the group more safely?  Thanks,

Alex


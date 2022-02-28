Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586294C7CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiB1WHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiB1WHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05EDA14CCB1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646085987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSd2olf1jnjo/HsSgbCsJs5j16VEb70bfQ7PmeMY2VY=;
        b=GUELIsv7eLkF6c8DNHomRjBJV7k7MidZBhPXOvc5BLK9LalYdAaziwiV0PmbGh6z/N4tqe
        IZR9HM1BiPmSvR0Fjg5qyj4JoWbUp+z7dYbfSr33Pl5rVJn5phc88Xx2K4lzwA0ZXNRpiL
        MZWLC3dovLIs3i44KZ8yiWX5pBTauRA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-9RUOAEtnMr2J3ko_0l2oRg-1; Mon, 28 Feb 2022 17:06:25 -0500
X-MC-Unique: 9RUOAEtnMr2J3ko_0l2oRg-1
Received: by mail-oo1-f72.google.com with SMTP id r18-20020a056820039200b0031d6f9170eeso3054279ooj.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSd2olf1jnjo/HsSgbCsJs5j16VEb70bfQ7PmeMY2VY=;
        b=uJhmzt9AnN4RltMhLi4e7MrSYdGsY9lxJdneQesE6sfOlY5tw0+8+BkuaVC3wXfWg5
         bkpqqL19fu3Pqct2JIy5/2Z3O8XXjj2ZQnY6WtGa7u/i/jsC0251XviR0mgI2nWJJATJ
         VaAQ22kVrS63DNm6dGuz8vnp2J5+bmI3YddiRdbhayzl8C/TYOjNedAjx5S9asTGmVzG
         J3zXLmtZcoyLfrZSYRzUin/UGymgou/Aq7EjBQxGU9d0rj3MBYJteiH7UFPZb92VF7el
         AxIbWWIr2uRaOMlUMvOsdcngy4qyf8sLu1a8D3Ud8V4kINHsJY9HbKGaX85A3HoVJ5Lv
         UR0w==
X-Gm-Message-State: AOAM530mxGeAzpies0Vhq72HxDBSxHK1R/AECalYtibW6o/Qa8i5mYAB
        awGlHXDg4Pe8+NyQPiXNZ9gFoBgstYcGyN7EL34OttCX9gYfZU2H0PLuwlF1xmCBbayQbE4TDDl
        4LbqJQyXcqhF6ohcsaMiJEcNR
X-Received: by 2002:a05:6808:1148:b0:2d5:2333:bbb1 with SMTP id u8-20020a056808114800b002d52333bbb1mr10736852oiu.130.1646085984662;
        Mon, 28 Feb 2022 14:06:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXyd5cLZVXv21R215ahGVE59QoOxgoKUS9B2IAT3b2Nrgqe4ENaiagVjBUsTuHIIBNYSayzQ==
X-Received: by 2002:a05:6808:1148:b0:2d5:2333:bbb1 with SMTP id u8-20020a056808114800b002d52333bbb1mr10736822oiu.130.1646085984239;
        Mon, 28 Feb 2022 14:06:24 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i47-20020a9d172f000000b005aed7ea7b44sm5393010ota.73.2022.02.28.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:06:23 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:06:21 -0700
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
Subject: Re: [PATCH v7 08/11] vfio: Remove use of vfio_group_viable()
Message-ID: <20220228150621.5984595b.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-9-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
        <20220228005056.599595-9-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 28 Feb 2022 08:50:53 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> As DMA ownership is claimed for the iommu group when a VFIO group is
> added to a VFIO container, the VFIO group viability is guaranteed as long
> as group->container_users > 0. Remove those unnecessary group viability
> checks which are only hit when group->container_users is not zero.
> 
> The only remaining reference is in GROUP_GET_STATUS, which could be called
> at any time when group fd is valid. Here we just replace the
> vfio_group_viable() by directly calling IOMMU core to get viability status.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>


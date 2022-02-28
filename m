Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3044C7CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiB1WH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiB1WHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0891DC4E34
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646085998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d94j7lxxX5y02+A6WG5OxYm+EuL2bPwYE+feweTMi6I=;
        b=J0ohMJ9U4ZN2kRr3Weze39lKaA2qodgnMc2U8kKg2jj2hagwo7Z89eTVrnJTmbp9kN8iQp
        h6WAvdENA2NstwlRqY7ftZc5uM+XFeiHJEt+qmcrDz8x3bA8qd0uSU9A6L6rBA9ZutRL1g
        jHofp/lyat83++zOLirrqDWEJrhor9o=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-mbGijGnzP4CP04m35ZhBug-1; Mon, 28 Feb 2022 17:06:36 -0500
X-MC-Unique: mbGijGnzP4CP04m35ZhBug-1
Received: by mail-oo1-f71.google.com with SMTP id z9-20020a4a9849000000b0031a574e3571so9380427ooi.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d94j7lxxX5y02+A6WG5OxYm+EuL2bPwYE+feweTMi6I=;
        b=dcZ7C0l7KltIQqFOL4hPuvU/twJntWHPJ0u/2vURW5BvbJWsfVg9cFwfkfp13OG/j2
         Cpz7P1YKT6VwMvbMEHo9gbDxOMTHTuwkPIAqxJsNkwCLz2qCXmza4G3Kdnqvn1f1KEP2
         uwmRZcdnpUWV2cgAX7RSgZ+qWmL+Zx2S/jPxq7YkQ5mQYg6iKFylyF1CCe6rg5tIvZoh
         N9A95kylhUhgwRJdRbnv1SXPQPtjM970p80JjmeWNlHZC2gOT54TYJdD0N2/RLYgn0WM
         he3olyE6zeAuTcFXxwduS+BgoFQUlBrcsj4hBCLsWdvgcuOg1U3BrroTWDV2OL5K2wMf
         uiXg==
X-Gm-Message-State: AOAM532bMTassYYxp6A/lRrW12JdOXS3aTs1ly5Q5bXJ2DFcjumerzFz
        rzsDrCP1trUVeG2tFm/QySJTQY4pEGkLiTqYA2PCH5csVLk0AGzKCidVEll6DWe7yG+CI14ArVt
        4s/hLLo/TgkN1BhvonG6cLAgl
X-Received: by 2002:a05:6808:1586:b0:2d5:1211:5785 with SMTP id t6-20020a056808158600b002d512115785mr10690611oiw.0.1646085995964;
        Mon, 28 Feb 2022 14:06:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLGQUBEm26I4XhzS9O0hC1lMHUwWYT/sXCYb5vTAfKM0mj7adVygonLblatFgJDlUF3+gebg==
X-Received: by 2002:a05:6808:1586:b0:2d5:1211:5785 with SMTP id t6-20020a056808158600b002d512115785mr10690580oiw.0.1646085995791;
        Mon, 28 Feb 2022 14:06:35 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m21-20020a056820051500b0031d0841b87esm5371712ooj.34.2022.02.28.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:06:35 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:06:33 -0700
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
Subject: Re: [PATCH v7 10/11] vfio: Remove iommu group notifier
Message-ID: <20220228150633.3438200c.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-11-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
        <20220228005056.599595-11-baolu.lu@linux.intel.com>
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

On Mon, 28 Feb 2022 08:50:55 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The iommu core and driver core have been enhanced to avoid unsafe driver
> binding to a live group after iommu_group_set_dma_owner(PRIVATE_USER)
> has been called. There's no need to register iommu group notifier. This
> removes the iommu group notifer which contains BUG_ON() and WARN().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 147 --------------------------------------------
>  1 file changed, 147 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>


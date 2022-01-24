Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489D497CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiAXKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiAXKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:16:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144DFC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:16:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i67so1577849wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ojZJfUHtm9ovOFBOfA3TS4i8XJuJzbk79ufS2uBVn1k=;
        b=avLmskQetnZLKS5POUDQ2emSgSxJP5gcaKobddCdXaX5XQR+TWhvS/hzwwNKCwC8rn
         oFFjf9l4z1YaETQpoK/vV9EvVjFQzb257aXYGPS7bVURv2toU4x9sZHaqJvfNC16FVuL
         Xo9e/lqUTA7XhuPdWxVSqljH4zcKUV3HGD6OGX18wzRBdWbMeI5KwKsSFPcqt6WM5tfC
         ti8vt1E9MNPepWL0kyFg2l9zFBDatbyVdYsMScFR9iM/NUBttzZ4tlaPVtvXkGIoG+IT
         wbXClwtS/a5uZ+Aq0lzabLrQdz2BPA+nSjem+g9wZZBfnDsLB8447OhCSx9OLu+8pIfP
         +euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ojZJfUHtm9ovOFBOfA3TS4i8XJuJzbk79ufS2uBVn1k=;
        b=RXqGXZuVJ9N1tp7uxxOjeE1akaadFuBBVyrZB3u4vFFq9HxWga8QJ3Xk5eTcXluLQl
         QBPZwshP1PMoamjHWFTooK7WgkiW1781F38rt9jp91DGS9m5M0YWsJoPuntlMH95Ia6O
         GsMGR4K8QzBjjdADpYrzW0ijmlTZQLPXzGQs6tSPptWzheD1bvnw4T4YDG+ajcP+fLa2
         Az4RPEJotzutzOY/Xhp6x6NY3EapqHbfi8xKRE9AI9QMpywa7IoCqZoEzJUDfkrqYPQy
         g0+nVowdazjFs/zoQMvxWN2vg8YG7r5PpMF/bbrO0lsUl11wEWnl9X8p9EeJJiCjf8yu
         4Dbw==
X-Gm-Message-State: AOAM532+tBTLQzcXB5eqBcWh2LhE5bBgHVVDhnvzrzxohWtg/o3NVShI
        JFYMJ6zExEBbxxohLM3loqLU1Q==
X-Google-Smtp-Source: ABdhPJzTyJ37K64BBQ+VM4xpU821ze6oPztog2El56Hbio1gSm89H/59lEo4Gs8K2NJwJCfoSu3rEw==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr1171835wmb.130.1643019389594;
        Mon, 24 Jan 2022 02:16:29 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r7sm17548515wma.39.2022.01.24.02.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 02:16:29 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:16:07 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <Ye58Zxi+F9TQszgQ@myrica>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 09:58:18AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, January 24, 2022 3:11 PM
> > +/**
> > + * struct domain_ops - per-domain ops
> > + * @attach_dev: attach an iommu domain to a device
> > + * @detach_dev: detach an iommu domain from a device
> 
> What is the criteria about whether an op should be iommu_ops or domain_ops
> when it requires both domain and device pointers like above two (and future
> PASID-based attach)?
> 
> Other examples include:
> 	@apply_resv_region
> 	@is_attach_deferred

Could attach_dev() be an IOMMU op?  So a driver could set the domain ops
in attach_dev() rather than domain_alloc(). That would allow to install
map()/unmap() ops that are tailored for the device's IOMMU, which we don't
know at domain_alloc() time. I'm thinking about a guest that has both
physical and virtual endpoints, which would ideally use different kinds of
domain ops to support both efficiently (caching mode vs page tables)

Thanks,
Jean

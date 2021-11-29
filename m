Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585F1462032
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380281AbhK2TUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379169AbhK2TSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:18:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95FC08EC74
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:37:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so16842446wrw.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QNaHQe0sEt+Xz04cYV/MIlXb8cf/E2M9X4MAcvVxnPY=;
        b=jZT480wxvUl1wAeMTBT1goDqfM/CUNl3b3WLq0yuxBBxM9hmwt7jYsKrDnHVlAYgCq
         9taCx7GjoIFFKh6wPGbIm7V6djMjeHgD+ecYpG/ghbLjNU5D+scLE0lFxAjlTKRqTWe+
         RCBO6c7funI7wNn1LyWz/P5Cj+g3wRH3XFK+Zzy409Xl7LRxsPJEENGMHXTnWqEXEvlk
         dBiBniZ55PYJM/8ytfSKwaxWLJovM+yp5gCjdQPDKhX4nLegcXfTBGqOTUcoA8thRiww
         Ep9ARVrZ46+60YzrFq6BrXMX9/RUADTqo46rN3ll4ga7YP6/39VZKl+NcnZd3MT8GbJk
         xSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QNaHQe0sEt+Xz04cYV/MIlXb8cf/E2M9X4MAcvVxnPY=;
        b=KwT19i2kP8avFgjpKW/C7dS13nyCNKfpw6ot7qsVJ9KZJZdiW/UKoTy2RCQhdz2txQ
         LOAhx6Ppw29LyNgD+7sxK276+k2m3SBIh+4+BUwg8OWfyfxLKgG9JJDk1t2j8B1CvZfb
         ap2Dx0D6NdeuEFlSC6g7bPceUogB1kFcz3p1aMVvETXPvk59FlDKybmVV4/auP3RUscO
         NoWfsENozu/yxLhCueH8yCqpDWz3H4On90e/MTLzst82ypGbZXE7m4mB1xo4Rbjadb0I
         gnb1cOzGFUkDHOwoblO1Et3kHetPJLIfJz1brN1VE3QPmtIsEJBiwMAEYqhO3rRaq/C2
         XszA==
X-Gm-Message-State: AOAM532kMm+sZ+QaX2N1cbsL6IYKcaWDkETm2EQEM/1rWY9/tjaYIhxz
        9y4qdfLwtT4eykh9QIfKDkgUcw==
X-Google-Smtp-Source: ABdhPJydH8DkXqyeN9Ia758m64cpVXoMOUT0emD3QhRO3MqqbhLn7G/GysWuevCbIseRjFknYEcsbg==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr35495829wrw.138.1638200230316;
        Mon, 29 Nov 2021 07:37:10 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id z5sm25105381wmp.26.2021.11.29.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:37:09 -0800 (PST)
Date:   Mon, 29 Nov 2021 15:36:47 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v2 2/5] iommu/virtio: Support bypass domains
Message-ID: <YaTzj6x0nIYoL1WD@myrica>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-3-jean-philippe@linaro.org>
 <fd03ac99-9bd4-197b-26c8-dcc5de1b3057@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd03ac99-9bd4-197b-26c8-dcc5de1b3057@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 05:18:28PM +0100, Eric Auger wrote:
> Hi Jean,
> 
> On 11/23/21 4:52 PM, Jean-Philippe Brucker wrote:
> > The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the ATTACH
> > request, that creates a bypass domain. Use it to enable identity
> > domains.
> >
> > When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device, we
> > currently fail attaching to an identity domain. Future patches will
> > instead create identity mappings in this case.
> >
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 80930ce04a16..ee8a7afd667b 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -71,6 +71,7 @@ struct viommu_domain {
> >  	struct rb_root_cached		mappings;
> >  
> >  	unsigned long			nr_endpoints;
> > +	bool				bypass;
> >  };
> >  
> >  struct viommu_endpoint {
> > @@ -587,7 +588,9 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
> >  {
> >  	struct viommu_domain *vdomain;
> >  
> > -	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> > +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> > +	    type != IOMMU_DOMAIN_DMA &&
> > +	    type != IOMMU_DOMAIN_IDENTITY)
> >  		return NULL;
> >  
> >  	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
> > @@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  	vdomain->map_flags	= viommu->map_flags;
> >  	vdomain->viommu		= viommu;
> >  
> > +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +		if (!virtio_has_feature(viommu->vdev,
> nit: couldn't the check be done before the ida_alloc_range(),
> simplifying the failure cleanup?

It could, but patch 5 falls back to identity mappings, which is better
left at the end of the function to keep the error path simple. I put this
at the end already here, so patch 5 doesn't need to move things around.

Thanks,
Jean

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE049C6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiAZJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiAZJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:41:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35962C061749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:41:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso3806345wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DgC3fBf+JMernk9UtJYHLs3WXUQ4WF2uVpf9z50+mN4=;
        b=KSl6lTYmsVi33WHBN3QnElkvHgGznKo+f/d/ZSM8+9YhM6kZn6ta1q4C0eEBpR7H7H
         q2pHOPd4qHOfapjgox1untAEzse5dCyt6yyT3CefQZZRFK8z0sNVUWu4xyM9qaQ/lCmz
         +UfOOiLYGJw99mue93gUeV/HldhzX3TQrtN5o5o/ka41LY2jN0+yuckYPwxVyrDXvIKN
         D7y6CqTsUwSdza5+t0tNt8p0zDQi9zhZNVyhiANXZjPp2NifE/JOmirFKQeBVO8hTTiq
         2PmDXc+706mQQ+8M4xyBRdTU9kB6hy0N6wsGZXqd3kgdyQb7qUDcIchacnRsxDTVOvjt
         Faog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgC3fBf+JMernk9UtJYHLs3WXUQ4WF2uVpf9z50+mN4=;
        b=gKQt/nEHR7owe7wMcGGSmHZH+TFDl+ck4lNewnvgZkG8FOvaCiE+dkkcQSRjkMO/aU
         E10AZGG/DmzAbpCWmokECvBjszL7HE6v3J9WjxTt6SwAZgzAKfkTE0ZKd8R2qNfvtU56
         B/0HEY3FDboarwa9naAcjbtWYKKTvdrvlX7lPSDWHhe2W3BdIHHlH+DuSdXiyaBZ+KCo
         q7Ek7lblL73aBYMScWvXXV/lLvr+Tocenutw+KxAQgR6a1eSyEBQAyrbeFYxd51dj38U
         HVP5X+bBrZHp6z4nIqHFkn8fEf1qjHP99y6fGXlfI24lGsATkpQquq+Jyvdvp8EXi1Aj
         oVug==
X-Gm-Message-State: AOAM533EHTskJ4pSBQVeHGuB2Q9+5kdeRnAFPsHxwd84xVZH9HmNx19m
        amo0Fowq+gKO0Nyfsp9gIjiTXg==
X-Google-Smtp-Source: ABdhPJyX5OAK0KhXelGAEpKETNqy81bEQDZkxHDK+f3lOrdKefGHj06CmnX/XERSYPKAu/YjnUtCJg==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr6475785wmp.83.1643190097727;
        Wed, 26 Jan 2022 01:41:37 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id m4sm2710543wmc.1.2022.01.26.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 01:41:36 -0800 (PST)
Date:   Wed, 26 Jan 2022 09:41:13 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <YfEXOegPuG846NEb@myrica>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Ye58Zxi+F9TQszgQ@myrica>
 <20220124163302.GC966497@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124163302.GC966497@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:33:02PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 10:16:07AM +0000, Jean-Philippe Brucker wrote:
> > On Mon, Jan 24, 2022 at 09:58:18AM +0000, Tian, Kevin wrote:
> > > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Sent: Monday, January 24, 2022 3:11 PM
> > > > +/**
> > > > + * struct domain_ops - per-domain ops
> > > > + * @attach_dev: attach an iommu domain to a device
> > > > + * @detach_dev: detach an iommu domain from a device
> > > 
> > > What is the criteria about whether an op should be iommu_ops or domain_ops
> > > when it requires both domain and device pointers like above two (and future
> > > PASID-based attach)?
> > > 
> > > Other examples include:
> > > 	@apply_resv_region
> > > 	@is_attach_deferred
> > 
> > Could attach_dev() be an IOMMU op?  So a driver could set the domain ops
> > in attach_dev() rather than domain_alloc(). That would allow to install
> > map()/unmap() ops that are tailored for the device's IOMMU, which we don't
> > know at domain_alloc() time. 
> 
> I think we should be moving toward 'domain_alloc' returning the
> correct domain and the way the driver implements the domain shouldn't
> change after that.
> 
> > I'm thinking about a guest that has both physical and virtual
> > endpoints, which would ideally use different kinds of domain ops to
> > support both efficiently (caching mode vs page tables)
> 
> In this case shouldn't domain_alloc() reached from the struct device
> already do the correct thing?

Sure, if we can finalise the domains before attach that could also clean
up the drivers a bit.

Thanks,
Jean

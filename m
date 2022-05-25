Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031753375D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbiEYHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbiEYHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:30:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A94377F1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:30:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ck4so35605713ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fka4U6j+4zi9FbIDyA05x8GB1WOLwNpWSqnnKjoitMg=;
        b=oHhiDqqjJeC/j21AryPAJw+WSqZB6TeRWYeIE7HKoSC+q9ja0g9HSBtnvBHMYu/4qK
         GzhRInTPX2MGtp94iRzu8dw3QhI5MhKJQTalAlQ6dviuvCCuubtzBaO6QX1IKKbSNbcd
         4Xbl3bMgqUoRswyFyuY+SGAzfrlG8dOOQqN62WA0cEhXzpohiCk/47gqpCEVxQwEEcmy
         hwYBLsRsF48EpqUqYVAooTr+CVUgZ68Xngs+fIZAodyUh68Bak1MYSTwbwQk9lesQzFG
         BUyXQpf8bEre+tzSh8SxbBN8eCpcT4xtFd2Ueyz+oaZbXvk6evEIWxJ5qJgI/PkSyR4N
         tPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fka4U6j+4zi9FbIDyA05x8GB1WOLwNpWSqnnKjoitMg=;
        b=Pqx4P0WdBPjtqMvMWKJYKk+vOxamZAgy8L5ekkBh6uVRn0bnG2AkcvMmfGwHCDPzMV
         CphjltJUm6olJK0dd/kvtQ0IsJSCXPjPiEMGCJPvmMDOEY5QIxe9uiuSMdMuzBpbT339
         0hoSW1XUanYPETq36ar4buwdowSymGICxf+plvavPvIk84DvBQ/q+IAdAnMaM23X380e
         zcu4MvvMRqIcWtkNH14bex2GgbrBEokx5DmNhUBVz8C1u7FqaJDMFGLauDsQV6w9U8Xc
         zuT1TTXsJWIk+d/OcltGvq9OMqSSNgv7xZBrx4VTJ2PRBq6g538F5NXcilY4kDcBhpmp
         QNmA==
X-Gm-Message-State: AOAM533FExVR1z5CO5XCsOwvPsK6FcmuTJ/vVoTVTZka1lrNTFSKOQoX
        lPcRx5G2rCTvRbsRuM4bLs2clA==
X-Google-Smtp-Source: ABdhPJwerQ5UGQoKT85YJagGsyI2jp+UwkrVV45C7cSVfQ1QlsOOd4R9jUTNP0VovEJ5Sp184Cn4/Q==
X-Received: by 2002:a17:907:d86:b0:6ff:1557:a080 with SMTP id go6-20020a1709070d8600b006ff1557a080mr770913ejc.678.1653463814422;
        Wed, 25 May 2022 00:30:14 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q14-20020a50c34e000000b0042ba8658d1csm1095864edb.73.2022.05.25.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:30:14 -0700 (PDT)
Date:   Wed, 25 May 2022 08:29:49 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yo3a7U9kSaSzagkX@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yoy6NxroLLZup0sE@myrica>
 <BN9PR11MB5276FF0D52CF82942CB84D608CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FF0D52CF82942CB84D608CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:04:49AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Tuesday, May 24, 2022 6:58 PM
> > 
> > On Tue, May 24, 2022 at 10:22:28AM +0000, Tian, Kevin wrote:
> > > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Sent: Thursday, May 19, 2022 3:21 PM
> > > >
> > > > The existing iommu SVA interfaces are implemented by calling the SVA
> > > > specific iommu ops provided by the IOMMU drivers. There's no need for
> > > > any SVA specific ops in iommu_ops vector anymore as we can achieve
> > > > this through the generic attach/detach_dev_pasid domain ops.
> > >
> > > set/block_pasid_dev, to be consistent.
> > >
> > > > +
> > > > +	mutex_lock(&iommu_sva_lock);
> > > > +	/* Search for an existing domain. */
> > > > +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> > > > +	if (domain) {
> > > > +		sva_domain = to_sva_domain(domain);
> > > > +		refcount_inc(&sva_domain->bond.users);
> > > > +		goto out_success;
> > > > +	}
> > > > +
> > >
> > > why would one device/pasid be bound to a mm more than once?
> > 
> > Device drivers can call bind() multiple times for the same device and mm,
> > for example if one process wants to open multiple accelerator queues.
> > 
> 
> Is it clearer to have a sva_bond_get/put() pair instead of calling
> bind() multiple times here? 

I don't think it's clearer, and it would force device drivers to keep
track of {dev, mm} pairs, when the IOMMU subsystem already does that.
At the moment a device driver calls

	bond = iommu_sva_bind_device(dev, mm)

for each ADI that it wants to assign to userspace. If a process happens to
want multiple ADIs on one device, then the {dev, mm} parameters are the
same and bind() returns the same bond. Since the IOMMU driver needs to
track these anyway, it might as well refcount them.

Thanks,
Jean



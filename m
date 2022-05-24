Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9583C53286E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiEXK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiEXK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:58:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E68BD00
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:58:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o9so2681539wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCjI61TxF/VhR4kH8WebLIwDAZqQH5lWWY5eksn1pk4=;
        b=vv0TNhcIJ4S4bv7c//57PxGJKqkVJwPgBpjuTOpLp+J5+358caS7gCJhwUY2f80H4Z
         Jgrh6OAVm1iAgDWdWVCBmf8NS9N7XjpDJ6LyhL3rzY3YxKDb44cHx8KemQcVBPkmexP6
         9w5aUBbryD0GbFuSEpJEysh3VHFFpD4S1pKgJ4DkOaPQ5qigvL5UMaT2urRAxdsXUS5e
         FDpv5zmJ64vnO5oSkS9A5eO+xAvBWaSMvk5BwkPSfPrM8dzNi6LkjvMSn8+d2yjSpGlY
         3XFx9G9TUqrsUeO/Fo1kcCoR108PWVQtJiYIH+d4lw3m7XUPjJxJVOl0qMIgwDtrsI/l
         VQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCjI61TxF/VhR4kH8WebLIwDAZqQH5lWWY5eksn1pk4=;
        b=6L9GmGZPkKww6mQDs46odWhpXcrUcKNK/++IZEQjJCBmCimFixuGQTShT1gDkhRtrM
         1oW0GD/+vzT5V43JnYJcAxvTThaxDQKVxAHmmrIcdhjTSL8js17y2r/erZQAR5NnswVi
         UbLN5sxnbZrzkSJnGBQUMb0FHwRYx0smP7tyyxiUCiPzpObv6/py1XNW30sh9J5mYTf5
         3D0dP57NkzmVw5+g25gC+7zI/Mfrta6vcCSvAZEhlPiiHdHKu6rUU7QPdq6bHPH4Qhmt
         hLvabGFmAb9+d7AY+lqkCZNsUh0WXCk50mFh3g+Edy6J7wNZM5SfHwEPJ2TQAWVYpQqa
         URTA==
X-Gm-Message-State: AOAM530kCb9YH+53toOVPN0k0Ls+kvLML0M8WQN4OMKSPwH34wMFfBXP
        /JTNMMfPl5/NQpsHih8ggs9BIQ==
X-Google-Smtp-Source: ABdhPJxFTJkFYuZB+CyKxNj/VjuwuSt9WMAzvZj8TN9N3ciewWRevYgqK0102jXTQ5oECXV7bU5aGQ==
X-Received: by 2002:a05:600c:29d3:b0:397:4730:ee75 with SMTP id s19-20020a05600c29d300b003974730ee75mr3185384wmd.149.1653389904595;
        Tue, 24 May 2022 03:58:24 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id o16-20020adf8b90000000b0020fc3e24041sm10338214wra.106.2022.05.24.03.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 03:58:24 -0700 (PDT)
Date:   Tue, 24 May 2022 11:57:59 +0100
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
Message-ID: <Yoy6NxroLLZup0sE@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:22:28AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Thursday, May 19, 2022 3:21 PM
> > 
> > The existing iommu SVA interfaces are implemented by calling the SVA
> > specific iommu ops provided by the IOMMU drivers. There's no need for
> > any SVA specific ops in iommu_ops vector anymore as we can achieve
> > this through the generic attach/detach_dev_pasid domain ops.
> 
> set/block_pasid_dev, to be consistent.
> 
> > +
> > +	mutex_lock(&iommu_sva_lock);
> > +	/* Search for an existing domain. */
> > +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> > +	if (domain) {
> > +		sva_domain = to_sva_domain(domain);
> > +		refcount_inc(&sva_domain->bond.users);
> > +		goto out_success;
> > +	}
> > +
> 
> why would one device/pasid be bound to a mm more than once?

Device drivers can call bind() multiple times for the same device and mm,
for example if one process wants to open multiple accelerator queues.

Thanks,
Jean

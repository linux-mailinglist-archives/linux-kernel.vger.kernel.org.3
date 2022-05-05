Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780C451C0FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379711AbiEENmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiEENmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:42:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA0E56C32
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:39:07 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so4216425fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kb8f4M/l5z6uxpDp6qlCrIRzZnhYZpwv4r1elaJ2Id0=;
        b=bxZRCmDQan2xGXp3qqVXNGx862ETbFFt31nV6CLZpdPipaMEq/oLSslZtPA08TKTgM
         QQLXHg6zP65ezFnRj2snvB65jWMXnqQR0oxAxiZiJVr5ucUPgtCpVnA5B1U1ydXnNV4O
         aW6bYQFeLUMU6/nPEXiWn7k1KcvHW+CLGoXfBQ/RB4Rho/9oF1VvJoPL7XoEQumg+g1H
         X1k5ys3IoDR0ZxusVW9AVeheT6/Cb7mECpjzufoOQqIcOUqnr4CrKvC+xb3LYoHgSMcl
         Wz6oGBXdFkHgYShZC1cPEJYkl4+qK8Fwy/BAfMi9dQyj8mhyXrwMLTmlrRmpMlkAa9/E
         Ha4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kb8f4M/l5z6uxpDp6qlCrIRzZnhYZpwv4r1elaJ2Id0=;
        b=MVj3xDMhfXOybzRmoQH44A6vZdnnNQu/u1nMa6wgBxXZVMZ7VSDIgmEQPLcqSe6Cy+
         FxRtSwraLE0B09gE/2qDBWOzSL6/4PDxnlHKaR8I7rgThe7/C4qx1YAkaXdNe8Fccq1+
         nzXUzj+I/lXYoqUTlFp9jG1b5dzRswC0put5KnYmVph1MgP9gSRJvdq0xYdpHqx1CgrE
         xEojZEr9AJCkuxj6mN0PX17QX6feJzBQUbfSBy2lse+xO8D6kE79+vhdgeTbNycyMcE9
         Gys8UnuLGNYBCBIZpV0deqALofK2mIGnj7UXGbYd3ptJVCb0MSfPZMiTxfcev6PAXWdx
         pCdQ==
X-Gm-Message-State: AOAM532xxRF3Z5uWXfCGCI3teVIxrt/wdusA/GKhE3g6GI6CIPkowb5a
        YxUoz2IAWnToX6s4ve1jeQjMDDHy9Dgt75aX
X-Google-Smtp-Source: ABdhPJxKxShZt5CyviRanuZSq/psWkLAX+SqxyYKbLeRsW4giB0nlJOn6dDxwjLecNkjKg8yKQLqUg==
X-Received: by 2002:a05:6870:d78d:b0:d4:4b29:7ccc with SMTP id bd13-20020a056870d78d00b000d44b297cccmr2253927oab.69.1651757947172;
        Thu, 05 May 2022 06:39:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id x6-20020a4a8d46000000b0035eb4e5a6c3sm774557ook.25.2022.05.05.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:39:06 -0700 (PDT)
Date:   Thu, 5 May 2022 14:38:39 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/12] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YnPTXwjpHnnGp4j2@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-11-baolu.lu@linux.intel.com>
 <YnFydE8j8l7Q4m+b@myrica>
 <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thu, May 05, 2022 at 04:31:38PM +0800, Baolu Lu wrote:
> On 2022/5/4 02:20, Jean-Philippe Brucker wrote:
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 7cae631c1baa..33449523afbe 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -3174,3 +3174,24 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
> > >   	iommu_group_put(group);
> > >   }
> > > +
> > > +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
> > > +						    ioasid_t pasid)
> > > +{
> > > +	struct iommu_domain *domain;
> > > +	struct iommu_group *group;
> > > +
> > > +	if (!pasid_valid(pasid))
> > > +		return NULL;
> > > +
> > > +	group = iommu_group_get(dev);
> > > +	if (!group)
> > > +		return NULL;
> > > +
> > > +	mutex_lock(&group->mutex);
> > Unfortunately this still causes the deadlock when unbind() flushes the
> > IOPF queue while holding the group mutex.
> 
> Sorry, I didn't get your point here.
> 
> Do you mean unbind() could hold group mutex before calling this helper?
> The group mutex is only available in iommu.c. The unbind() has no means
> to hold this lock. Or, I missed anything?

I wasn't clear, it's iommu_detach_device_pasid() that holds the
group->mutex:

 iommu_sva_unbind_device()          |
  iommu_detach_device_pasid()       |
   mutex_lock(&group->mutex)        |
   domain->ops->detach_dev_pasid()  | iopf_handle_group()
    iopf_queue_flush_dev()          |  iommu_get_domain_for_dev_pasid()
     ... wait for IOPF work         |   mutex_lock(&group->mutex)
                                    |    ... deadlock

Thanks,
Jean

> 
> Best regards,
> baolu
> 
> > 
> > If we make this function private to IOPF, then we can get rid of this
> > mutex_lock(). It's OK because:
> > 
> > * xarray protects its internal state with RCU, so we can call
> >    xa_load() outside the lock.
> > 
> > * The domain obtained from xa_load is finalized. Its content is valid
> >    because xarray stores the domain using rcu_assign_pointer(), which has a
> >    release memory barrier, which pairs with data dependencies in IOPF
> >    (domain->sva_ioas etc).
> > 
> >    We'll need to be careful about this when allowing other users to install
> >    a fault handler. Should be fine as long as the handler and data are
> >    installed before the domain is added to pasid_array.
> > 
> > * We know the domain is valid the whole time IOPF is using it, because
> >    unbind() waits for pending faults.
> > 
> > We just need a comment explaining the last point, something like:
> > 
> >         /*
> > 	* Safe to fetch outside the group mutex because:
> >          * - xarray protects its internal state with RCU
> >          * - the domain obtained is either NULL or fully formed
> > 	* - the IOPF work is the only caller and is flushed before the
> > 	*   domain is freed.
> >          */
> > 
> > Thanks,
> > Jean
> > 
> > > +	domain = xa_load(&group->pasid_array, pasid);
> > > +	mutex_unlock(&group->mutex);
> > > +	iommu_group_put(group);
> > > +
> > > +	return domain;
> > > +}
> 

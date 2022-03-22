Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6514E3C27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiCVKIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiCVKIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:08:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF24131C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:06:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so1285176wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1PPlSdu6SJbMd88ecCAMnsK5O5gk90YXV6AjFTf/9W4=;
        b=e3hHzf4ibX5io970YXLoJEDxZJW3LESP/5JVdX3m1Pu+MDi/bX0fgd0HO/4CNqbniz
         XplxXB10KhO0jPOpj2MSFM0S+HZYQ4qiwyTC6Je8dKZLFk4wPnJhwNZQHXDw+FrLL+4X
         1+p5m8/o8FxxQXy56I4VDrr8cgPSnVucID2A5Uc8JQfEijGyxsGS6uMde5u/5Hulf0oO
         wo7LzFPhb8DNYT8P/dOl1DNGKoBYHFhrVO/bZAfV6DFpGSVQmc09bpFYdcIo6XW3yPNm
         m7ZrSy18qz7Mi/RJMVyIMBFN8MHOzmTV1s7DvmOTQcRSVhQW6gnYtK8ZIWY5NOnEogg8
         fQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1PPlSdu6SJbMd88ecCAMnsK5O5gk90YXV6AjFTf/9W4=;
        b=PCRUl8XeomZar0mlcTGGmSpdPEFBoGNt6yIJ1xQuRdfX+9r91g0QBP7jts9rU0l5oI
         XqhujKHcW5EUP43qzVyh+kPeYxRljj20RrgjxcImL/q2pJtOa5UayPqtE/4dkCK7uBOn
         gjiGVYrgzpYDfCfWtIITbNFkOjRx7gFC9Hdp/Sp8U/GpV9KehNk+IM9ZgmjRKmrEyuVN
         chYCBO5PA+SIW04WPvQH3LPocY7ncWG0eYFzW0xo5cV+wgf0KUs9Y8SNZQWXvY0Pifvo
         fGNQVNwAik3eUcHmSw5Tq60k0f5Gvchny7K8t0BokHUeg/D7QExYyQx7+n3iPzit6TsQ
         JUsQ==
X-Gm-Message-State: AOAM5330baUZGP/5LQLgQ5/2oBZNUkBX6nZlSZ0iotS/+FXb7UaFzpcd
        7K4qs169syqnZzxx3dlO3GM08g==
X-Google-Smtp-Source: ABdhPJyLXu0xHdHXUhFQd0plssBfQL6O0HwMPeQyS6jDpo5e99ED+JqNH/XUFEbehtDo1kcC4q+7+Q==
X-Received: by 2002:a5d:6e0c:0:b0:1ef:7cbb:a5aa with SMTP id h12-20020a5d6e0c000000b001ef7cbba5aamr21752063wrz.5.1647943599593;
        Tue, 22 Mar 2022 03:06:39 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id v124-20020a1cac82000000b0037c3d08e0e7sm1502463wme.29.2022.03.22.03.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:06:39 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:06:14 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <YjmflimaXyM/IZhk@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
 <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:00:08AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Monday, March 21, 2022 7:42 PM
> > 
> > Hi Kevin,
> > 
> > On Mon, Mar 21, 2022 at 08:09:36AM +0000, Tian, Kevin wrote:
> > > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Sent: Sunday, March 20, 2022 2:40 PM
> > > >
> > > > The existing IOPF handling framework only handles the I/O page faults for
> > > > SVA. Ginven that we are able to link iommu domain with each I/O page
> > fault,
> > > > we can now make the I/O page fault handling framework more general
> > for
> > > > more types of page faults.
> > >
> > > "make ... generic" in subject line is kind of confusing. Reading this patch I
> > > think you really meant changing from per-device fault handling to per-
> > domain
> > > fault handling. This is more accurate in concept since the fault is caused by
> > > the domain page table. 😊
> > 
> > I tend to disagree with that last part. The fault is caused by a specific
> > device accessing shared page tables. We should keep that device
> > information throughout the fault handling, so that we can report it to the
> > driver when things go wrong. A process can have multiple threads bound to
> > different devices, they share the same mm so if the driver wanted to
> > signal a misbehaving thread, similarly to a SEGV on the CPU side, it would
> > need the device information to precisely report it to userspace.
> > 
> 
> iommu driver can include the device information in the fault data. But
> in concept the IOPF should be reported per domain.

So I don't remember where we left off on that topic, what about fault
injection into guests?  In that case device info is more than just
diagnostic, fault injection can't work without it. I think we talked about
passing a device cookie to userspace, just want to make sure.

> and I agree with Jason that at most we can send SEGV to the entire thread
> group since there is no way to associate a DMA back to a thread which 
> initiates the DMA.

The point is providing the most accurate information to the device driver
for diagnostics and debugging. A process opens multiple queues to
different devices, then if one of the queues issues invalid DMA, the
driver won't even know which queue is broken if you only report the target
mm and not the source dev. I don't think we gain anything from discarding
the device information from the fault path.

Thanks,
Jean

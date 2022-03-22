Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E274E3CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiCVKwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiCVKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:52:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16D82334
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:51:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so1552156wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vHkckXRpWc29S4mUGAnBlHY1gMOmn1QpysKGSLTVZOM=;
        b=G1ZCn+YSaj8zyaI+u1xPH1mi587zvpCnLwH5rRfC26JQqNKMj7DtrEjzY/vbHSwTI6
         3EzyE2rQgTWSYc3H5VPJQbTC7p+UUoPasa8O1ZwqsWILevv3Odeebn3RMCn9KNS5UWMk
         Yrvn5iQ1f6WC4N+Tav7ZhK1z+/AHba5crj8+hnEhV+leYFoXgGttVGbTH54Q/gkAo5uR
         iK9I4vsIhbXg3A8BSqMVCogTTK+8O9pChYlCUz3e/5Ofqo1Cf/1W4WodFlI2aB/OV4hw
         Y4UPjxmzHA898W21Z/zGKujnzDkAjcQkiPyD69s0l85XMDW9NkR0HzlM+9u00tbMBWBT
         qONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vHkckXRpWc29S4mUGAnBlHY1gMOmn1QpysKGSLTVZOM=;
        b=TcJCINH820GJwZhxFi2P3qBsF+WxwSCN0la5aHAWTdLJxOpBkDSKw3P7eluHVKLnMa
         jHolwtrJR7yvY5LMK4nWh1OU6GXwcpKMtROjKMoKzwRRVxV2FXhiCRGPHKzhjkZQZlNR
         doIXPCbO7RLab72pq0BzdAyuZB6q20+sz5DprBZUWIFiN9bV44aO5uv8OKhcdebbgwSs
         dIM0jRmIj7UY33qiYjONd0k1PDzKtXGL00dHqOoHZu4UMii6UCIPssT8ll6b+8Rf+lU9
         aczQF8UZd3vQcvNrY7o+vfQrbxu+bleW9C2ycPZ1UxE8ptbnoIrf90jhJisuAl+pAhkX
         W4kw==
X-Gm-Message-State: AOAM530ykcfEETJYq2pZ91zSpAhoDMjdvXZrpgTv3Cw236chY93nLuiT
        iOoQexRVuWI8LZyCwZlddjrvxA==
X-Google-Smtp-Source: ABdhPJzFrwjVWwLqEgzwoKcTnyZeIa+AGuSx9Q9xf17eM30WNx66e6DW7dCcNcgfVjGrF921B9u+YQ==
X-Received: by 2002:a05:600c:1f0b:b0:38c:b121:c65f with SMTP id bd11-20020a05600c1f0b00b0038cb121c65fmr3095603wmb.124.1647946268316;
        Tue, 22 Mar 2022 03:51:08 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b00203e3ca2701sm19727486wrr.45.2022.03.22.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:51:07 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:50:43 +0000
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
Message-ID: <YjmqA+zJUC+aPh8r@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
 <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YjmflimaXyM/IZhk@myrica>
 <BN9PR11MB5276642FF0D53AE7773B5B718C179@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276642FF0D53AE7773B5B718C179@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:24:26AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Tuesday, March 22, 2022 6:06 PM
> > 
> > On Tue, Mar 22, 2022 at 01:00:08AM +0000, Tian, Kevin wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Sent: Monday, March 21, 2022 7:42 PM
> > > >
> > > > Hi Kevin,
> > > >
> > > > On Mon, Mar 21, 2022 at 08:09:36AM +0000, Tian, Kevin wrote:
> > > > > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > > > > Sent: Sunday, March 20, 2022 2:40 PM
> > > > > >
> > > > > > The existing IOPF handling framework only handles the I/O page faults
> > for
> > > > > > SVA. Ginven that we are able to link iommu domain with each I/O
> > page
> > > > fault,
> > > > > > we can now make the I/O page fault handling framework more
> > general
> > > > for
> > > > > > more types of page faults.
> > > > >
> > > > > "make ... generic" in subject line is kind of confusing. Reading this patch
> > I
> > > > > think you really meant changing from per-device fault handling to per-
> > > > domain
> > > > > fault handling. This is more accurate in concept since the fault is caused
> > by
> > > > > the domain page table. 😊
> > > >
> > > > I tend to disagree with that last part. The fault is caused by a specific
> > > > device accessing shared page tables. We should keep that device
> > > > information throughout the fault handling, so that we can report it to the
> > > > driver when things go wrong. A process can have multiple threads bound
> > to
> > > > different devices, they share the same mm so if the driver wanted to
> > > > signal a misbehaving thread, similarly to a SEGV on the CPU side, it would
> > > > need the device information to precisely report it to userspace.
> > > >
> > >
> > > iommu driver can include the device information in the fault data. But
> > > in concept the IOPF should be reported per domain.
> > 
> > So I don't remember where we left off on that topic, what about fault
> > injection into guests?  In that case device info is more than just
> > diagnostic, fault injection can't work without it. I think we talked about
> > passing a device cookie to userspace, just want to make sure.
> > 
> > > and I agree with Jason that at most we can send SEGV to the entire thread
> > > group since there is no way to associate a DMA back to a thread which
> > > initiates the DMA.
> > 
> > The point is providing the most accurate information to the device driver
> > for diagnostics and debugging. A process opens multiple queues to
> > different devices, then if one of the queues issues invalid DMA, the
> > driver won't even know which queue is broken if you only report the target
> > mm and not the source dev. I don't think we gain anything from discarding
> > the device information from the fault path.
> > 
> 
> In case I didn't make it clear, what I talked about is just about having iommu
> core to report IOPF per domain handler vs. per device handler while this
> design choice doesn't change what the fault data should include (device,
> pasid, addr, etc.). i.e. it always includes all the information provided by the
> iommu driver no matter how the fault is reported upwards.

Right thanks, I misunderstood.

Thanks,
Jean

> 
> e.g. with iommufd it is iommufd to register a IOPF handler per managed
> domain and receive IOPF on those domains. If necessary, iommufd further
> forwards to userspace including device cookie according to the fault data.
> 
> Thanks
> Kevin

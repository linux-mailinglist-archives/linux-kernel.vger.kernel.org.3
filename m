Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C024F6472
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiDFQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiDFQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:06:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60A6D24D985
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:37:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D871F12FC;
        Wed,  6 Apr 2022 06:37:47 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE9363F73B;
        Wed,  6 Apr 2022 06:37:45 -0700 (PDT)
Message-ID: <b7639218-2d10-fd71-0f4b-3af3f8fa224b@arm.com>
Date:   Wed, 6 Apr 2022 14:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
 <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
 <20220406130614.GC2120790@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220406130614.GC2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-06 14:06, Jason Gunthorpe wrote:
> On Wed, Apr 06, 2022 at 01:32:07PM +0100, Robin Murphy wrote:
>> a particular IOMMU instance, and potentially allocate separate domains for
>> separate devices to represent the same address space, much like
>> vfio_iommu_type1_attach_group() does.
> 
> I think this VFIO code also needs some more work, it currently assumes
> that if the domain ops are the same then the domains are compatible,
> and that is not true for ARM SMMU drivers.

Well, strictly it uses the ops as a "negative" heuristic that the 
domains are not definitely incompatible, and only then consolidates 
domains if cross-attaching actually succeeds. So I don't think it's 
really so bad.

> I've been thinking of adding a domain callback 'can device attach' and
> replacing the ops compare with that instead.

Previous comment notwithstanding, much as I do tend to prefer "just try 
the operation and see what happens" APIs, that might be more reliable in 
the long run than trying to encode specific "sorry, you'll need to 
allocate a separate domain for this device" vs. "this should have worked 
but something went wrong" semantics in the return value from attach.

>> It's not really worth IOMMU drivers trying to support a domain spanning
>> potentially-heterogeneous instances internally, since they can't reasonably
>> know what matters in any particular situation.
> 
> In the long run I think it will be worth optimizing. If the SMMU
> instances can share IOPTE memory then we get two wins - memory
> reduction and reduced work to read dirty bits.
> 
> The dirty read in particular is very performance sensitive so if real
> work loads have many SMMUs per VM it will become a pain point.

In the ideal case though, the SVA domains are only there to logically 
bridge between an existing process pagetable and IOMMU instances at the 
API level, right? Surely if we're shadowing physical pagetables for SVA 
we've basically already lost the performance game?

Robin.

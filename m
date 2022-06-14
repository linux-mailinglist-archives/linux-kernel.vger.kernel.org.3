Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5854AA74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiFNHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352191AbiFNHV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:21:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6007F2C644
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655191288; x=1686727288;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aT/jlo7bPBLI1E41rFd9cS9uKHWKQcFzJa6LdgUzabY=;
  b=SYhDVbbKtNpx+0PSNWFN4PG8s51AKDVMVDTZrdtIgapm8LF6vXlQEvHu
   R7DDgHtnUhjLrUnk5p9DG3ieOnQH2xxEbtADg5qvfQCU72U7TBfzBSH7+
   zZNwnBBcK+UpWJrDGBoD3Lp1DDwZggd/sad+J5zvIUV/Y3ZgYiVruQeY/
   DJ9yztF19hv6ya4FVRsrQTwvdoI6EW6xAO+Hq306hgZTFsIO/ZZMPOLIu
   o86M10F5VDuMNo5yh3QRHhO4/xq4wacjUuSorMFA8GWZUtDGIr1FbPcuo
   FPkVeJF4R9ls10q6jQqHCUiVyqiX7YutGnw+ZEJYLbort9gjn663pY7U3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278571591"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="278571591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:21:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910836980"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:21:25 -0700
Message-ID: <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
Date:   Tue, 14 Jun 2022 15:21:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 14:49, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:51 AM
>>
>> The disable_dmar_iommu() is called when IOMMU initialization fails or
>> the IOMMU is hot-removed from the system. In both cases, there is no
>> need to clear the IOMMU translation data structures for devices.
>>
>> On the initialization path, the device probing only happens after the
>> IOMMU is initialized successfully, hence there're no translation data
>> structures.
> Out of curiosity. With kexec the IOMMU may contain stale mappings
> from the old kernel. Then is it meaningful to disable IOMMU after the
> new kernel fails to initialize it properly?

For kexec kernel, if the IOMMU is detected to be pre-enabled, the IOMMU
driver will try to copy tables from the old kernel. If copying table
fails, the IOMMU driver will disable IOMMU and do the normal
initialization.

Best regards,
baolu

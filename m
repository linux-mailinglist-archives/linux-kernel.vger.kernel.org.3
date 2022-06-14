Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8844154AA77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354123AbiFNHW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352454AbiFNHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:22:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7EB2A400
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655191370; x=1686727370;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CzvGOqm3s1ZUzeSM0+qcKhIjvYujoS+oprriCQFDToU=;
  b=VciUY2lwZxMFqUwB9MhOSdfbR/oa+vfuiza3Goc+Fn37NxLiPs7wHXE+
   a+Ww4a5jtnMwJW7TdMgwTWhjZtu9WC7PMHux3Gbi5WWFekyGYCRW+Vewo
   ux9yGLLdMLkjlRF0HnzmFJSWIEuYiPeiT4lnKvWXNfetbVXe72LfjySpP
   X8qk4n80W+Rk6XvQZMJzzcVy2Jkwgy8GJok0jSImI/scu/sW92ksAQbEU
   P3y66BR/8jh69/BjM3NDUXrvR8drMMrQdFMVRtJTURRl7hr2pBdOLjBm1
   HdIIWR27YQgW7DOnMjChubP8W76h/tS3OwjqG4nPhJitRPxXptM6ye2GS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279253521"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279253521"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:22:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910837669"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:22:47 -0700
Message-ID: <c1b8cd0b-6f25-993e-5b96-ce90d855ef26@linux.intel.com>
Date:   Tue, 14 Jun 2022 15:22:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Acquiring lock in domain ID
 allocation helpers
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 14:52, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:52 AM
>>
>> The iommu->lock is used to protect the per-IOMMU domain ID resource.
>> Moving the lock into the ID alloc/free helpers makes the code more
>> compact. At the same time, the device_domain_lock is irrelevant to
>> the domain ID resource, remove its assertion as well.
>>
>> On the other hand, the iommu->lock is never used in interrupt context,
>> there's no need to use the irqsave variant of the spinlock calls.
> 
> I still prefer to separating reduction of lock ranges from changing irqsave.
> Locking is tricky. From bisect p.o.v. it will be a lot easier if we just change
> one logic in one patch.
> 

Fair enough. I will do this in the next version.

Best regards,
baolu

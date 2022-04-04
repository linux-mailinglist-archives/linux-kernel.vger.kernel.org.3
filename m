Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA54F0F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377371AbiDDF5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiDDF52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:57:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB03299B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 22:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649051731; x=1680587731;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VRzHUmWn6xSVl9VxnZQQsCjifYYpTLqDX0N+7W19r24=;
  b=dxlgT20QbBZrsOtwgshOPhhSvrsh+oc8xWUVzKpZOYggbdc+2CiwdwuZ
   NhK7JUpcO6MOev1YU01BojrtHMk1+2FnVxnmtolYW/FG8OkrcuhwyTgkV
   ywr9RA/xggYJzZTO8wz0TYdeLBhz/+DTKG9d0FJ55H/NJWYNHQhw3Wfbh
   cXx3ORRNcI1GCAN0UH/qS9wEi4Uj3/FcQZ0dE1MH19nfAvjebOsPDJBxI
   GREJdaUPZ6f1Fk6RjKL5is0klsCD1f3qpDFd2Uy7acfC9YGtI27kAPVrj
   jcQdnXFcp3PUnFgU4A0yik47zyMhkEgzFVYHWU41IbyuuNOjGeJhm0lb5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260622957"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="260622957"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 22:55:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="548533670"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 22:55:28 -0700
Message-ID: <9be015a3-c436-5829-b117-e0a70bc29954@linux.intel.com>
Date:   Mon, 4 Apr 2022 13:55:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 08/11] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-9-baolu.lu@linux.intel.com>
 <20220331135922.6c677117@jacob-builder> <20220331222630.GI2120790@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220331222630.GI2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/1 6:26, Jason Gunthorpe wrote:
> On Thu, Mar 31, 2022 at 01:59:22PM -0700, Jacob Pan wrote:
> 
>>> +	handle->dev = dev;
>>> +	handle->domain = domain;
>>> +	handle->pasid = mm->pasid;
>> why do we need to store pasid here? Conceptually, pasid is per sva domain
>> not per bind. You can get it from handle->domain->sva_cookie.
> That is a mistake - SVA needs to follow the general PASID design - the
> domain does not encode the PASID, the PASID comes from the device

You are right. We should not store any pasid information in the domain.

Best regards,
baolu

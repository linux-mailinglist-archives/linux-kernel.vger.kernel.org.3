Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CF5229DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiEKCcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbiEKCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:32:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19B645C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236341; x=1683772341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GD5SNKppixG33DS3SuVjSEMLGzo8y1WE3tk191fvhtc=;
  b=alOC50RR4mD98r0zJdAibwsQcayOGH30NnrSqHa/wJdQZXXsLRqT5+Di
   FXwGZ/1bpvHPRSPkLy0z9FIfbHMIeIYLROGFV0ZoiRVckj9JQanMEawgV
   knMNH1SQRzU4jeLjZo11+44hOxSLa0mUsFmE+SSKVb6JeH1TQthicKYZJ
   UAmXjpKIg3rlzRbT5+N97311Rfr/lALP6XHksYuJ7lpIsCYOleK+LlX7K
   P95+4aCei0JB4xnmEth0tA3RQl7R248KLaPGcvtnR45uiYb2NrONCuw/P
   Xg313bJwUsVrGRakYXNWNheV3zNlCkMgHfxcHscCZ+TlfTTHIpCghyrB5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332596964"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="332596964"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:32:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="542093731"
Received: from chenji3x-mobl1.ccr.corp.intel.com (HELO [10.255.30.10]) ([10.255.30.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:32:16 -0700
Message-ID: <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
Date:   Wed, 11 May 2022 10:32:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220510140238.GD49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 22:02, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 02:17:29PM +0800, Lu Baolu wrote:
> 
>> This adds a pair of common domain ops for this purpose and adds helpers
>> to attach/detach a domain to/from a {device, PASID}.
> 
> I wonder if this should not have a detach op - after discussing with
> Robin we can see that detach_dev is not used in updated
> drivers. Instead attach_dev acts as 'set_domain'
> 
> So, it would be more symmetrical if attaching a blocking_domain to the
> PASID was the way to 'detach'.
> 
> This could be made straightforward by following the sketch I showed to
> have a static, global blocing_domain and providing a pointer to it in
> struct iommu_ops
> 
> Then 'detach pasid' is:
> 
> iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev, pasid);
> 
> And we move away from the notion of 'detach' and in the direction that
> everything continuously has a domain set. PASID would logically
> default to blocking_domain, though we wouldn't track this anywhere.

I am not sure whether we still need to keep the blocking domain concept
when we are entering the new PASID world. Please allow me to wait and
listen to more opinions.

Best regards,
baolu


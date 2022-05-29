Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7E6536FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 07:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiE2FW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiE2FWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:22:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17DFA5007
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653801772; x=1685337772;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vqd0ws84Ku7p1KlSODDOxug1zK8S6g53o9MNKaqUrrs=;
  b=VuEGaZGzOKPz+3NoPqWnn6uqLdq0wuVV1lX4qPB/nmwuV6852eyjYJfZ
   +kiHUt41n8mqroZOJMrAj/c2OBiMUF9TZTohIFl/4dceIxMkc6Mai0mXq
   RSfg1SCBTQf8X8vKk4CVcHzcPVwEgz4bhxLtcL/00B4TSEeqt5CBnB1SU
   cJW9bu/wifcAK9CsKTdZRxwkjJBzdkJLgTnOHsW6QaJBrZ0HZIuSl0eJm
   SEpVIUShjROVHQeBNCx3idwMSv6B+65bBbdCO1If9sPANLUy0k/tSsW4e
   OvATxC6gyGR1d2bWOmh6YqMs6UuoXKET4u8hLZ9HAE2Fo1y6TbPWM2X5+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="335403856"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="335403856"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 22:22:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="575465088"
Received: from unknown (HELO [10.255.28.211]) ([10.255.28.211])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 22:22:49 -0700
Message-ID: <a1e27717-3761-a521-79fa-6f74b6f88ffd@linux.intel.com>
Date:   Sun, 29 May 2022 13:22:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-4-baolu.lu@linux.intel.com>
 <20220527150108.GS1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220527150108.GS1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/27 23:01, Jason Gunthorpe wrote:
> On Fri, May 27, 2022 at 02:30:10PM +0800, Lu Baolu wrote:
>> The disable_dmar_iommu() is called when IOMMU initialzation fails or
>> the IOMMU is hot-removed from the system. In both cases, there is no
>> need to clear the IOMMU translation data structures for devices.
>>
>> On the initialization path, the device probing only happens after the
>> IOMMU is initialized successfully, hence there're no translation data
>> structures.
>>
>> On the hot-remove path, there is no real use case where the IOMMU is
>> hot-removed, but the devices that it manages are still alive in the
>> system. The translation data structures were torn down during device
>> release, hence there's no need to repeat it in IOMMU hot-remove path
>> either.
> 
> Can you leave behind a 1 statement WARN_ON of some kind to check this?

Sure. As the default domain is the first domain allocated for a device
and the last one freed. We can WARN_ON the case where there's still
domain IDs in use. How do you like this?

+       /*
+        * All iommu domains must have been detached from the devices,
+        * hence there should be no domain IDs in use.
+        */
+       if (WARN_ON(bitmap_weight(iommu->domain_ids, cap_ndoms(iommu->cap))
+                   != NUM_RESERVED_DID))
+               return;

Best regards,
baolu


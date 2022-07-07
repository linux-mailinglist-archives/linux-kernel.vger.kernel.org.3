Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAA5697E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiGGCWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGGCWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:22:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACAC2F390
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657160557; x=1688696557;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ma0fFXFw3M8lIkxpmBs0YMy6P2ngSlPcwZQt0WJ6T3A=;
  b=J5VgCn6scDc+YsrUa7jCztYYPkHpHGfKtXSZN2xbY8jXgZ2+oNOQS7Bc
   gS+F01H2rYRWN+i79NaLybuBPEsSmdfvW7QM2TNAbxcVwSiu9rrXUvhGT
   Ez0MiqFu+kFPD8lDyKE1rmuNWSSc4tmRuO98RDG6rUjok15gF+BCaIlpG
   cO3LuvuXbrhaqGm+0Kc4ho+pokjZHjoeUPvt9LyeQy2VOpjsAbK0H2Rip
   csnZTMNpDzGksxDyx12kzZo6koqyjQrTRVfBJOFBLNz7V6kaX6b1Q75c6
   Hpsv32DWSeos1xqS0swzxxZFPe1GwpfaeSth7fe9yeXrH1j7J+Rnz2M5Y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347896517"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="347896517"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:22:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650925601"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:22:34 -0700
Message-ID: <c2a378eb-0107-ea10-1b9a-a8bdfd7ec71a@linux.intel.com>
Date:   Thu, 7 Jul 2022 10:22:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Refactor iommu information of each
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
 <20220702015610.2849494-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D1132C2AB21B0A2A1B48C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D1132C2AB21B0A2A1B48C839@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 09:01, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, July 2, 2022 9:56 AM
>>
>> -out_unlock:
>> +	set_bit(num, iommu->domain_ids);
>> +	info->refcnt	= 1;
>> +	info->did	= num;
>> +	info->iommu	= iommu;
>> +	domain->nid	= iommu->node;
> 
> One nit. this line should be removed as it's incorrect to blindly update
> domain->nid and we should just leave to domain_update_iommu_cap()
> to decide the right node. Otherwise this causes a policy conflict as
> here it is the last attached device deciding the node which is different
> from domain_update_iommu_cap() which picks the node of the first
> attached device.

Agreed and updated. Thank you!

> 
> Otherwise,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Best regards,
baolu

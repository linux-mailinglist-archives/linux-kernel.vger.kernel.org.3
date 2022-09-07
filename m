Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE65B0121
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIGKAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiIGJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:59:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BB3B7ECB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662544738; x=1694080738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AmXRtUcPhtGSJn82WbSwjJEaSVshhgm7nZCuj/pPR/k=;
  b=Hbct1vhv6Cs8PWe2o4OOJox73CPXVnuGq1K/lxv7QAL4ob7xxiNlXEQC
   j+u/fMmOA8MaPWLpHqNwSCV1DiGkyoIgOVSZZtdv5GLjlR4KXBjz//FbK
   Bwniv3Wb3fylC4F4JUqbNIFmHuWqP24ea1xdY7BJbAQidhLDBkh9n2hqT
   ORKYxxrvjDqYz3EwMffY9jGeWIgRvrP+dwzglgu6fFG+m3cr6Exd+PUfr
   ayJccyTIziiOCp+DAMEqc/1CTmS+hZzE1yG+dZsl6AICaeX8UJf0EQ1l8
   CtSejV2rIxPDBW38mTHBZ+bsCc7nzVAJo/CBpziXHGblEDOvYfAbhde24
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="295566403"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="295566403"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:58:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="644553059"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.212.12]) ([10.254.212.12])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:58:55 -0700
Message-ID: <a9f959ed-b528-681d-f941-d615360c0be3@linux.intel.com>
Date:   Wed, 7 Sep 2022 17:58:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
 <cc950d77-2a97-ac75-4a1d-19aaf864a3be@huawei.com>
 <ad67a859-dc57-e30f-e422-3f9a0cb5239b@arm.com>
 <ef7622de-c1f3-c6cd-a50e-bbcbf8288b64@huawei.com>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <ef7622de-c1f3-c6cd-a50e-bbcbf8288b64@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

在 2022/9/7 16:46, John Garry 写道:
> On 06/09/2022 19:25, Robin Murphy wrote:
>>>
>>> Caveat: on the chance that the IOVA domain init fails due to the 
>>> rcache init failing, then, if there were another device in the group 
>>> which probes later, its probe would be ok as the start_pfn is set. 
>>> Not Good.
>>
>> Yeah, there's a lot not to like about iommu_dma_init_domain() - I've 
>> been banking on it all getting cleaned up when I get to refactoring 
>> that area of probing (remember the issue you reported years ago with 
>> PCI groups being built in the wrong order? All related...), but in 
>> fact since the cookie management got pulled into core code, we can 
>> probably tie the IOVA domain setup to that right now without much 
>> other involvement. That could be a cheap win, so I'll give it a go soon.
>
> ok, great.
>
> On a related topic, another thing to consider is that errors in IOVA 
> domain init are not handled gracefully in terms of how we deal with 
> the device probe and setting dma mapping ops, ref 
> iommu_setup_dma_ops(). I assume you know all this.
>
>>
>>> - vdpa just fails to create the domain in vduse_domain_create()
>>>
>>>> That makes a fair amount of sense, but does mean that we're missing 
>>>> the equivalent in iova_rcache_insert() for it to actually work. Or 
>>>> we just remove it and tighten up the documentation to say that's 
>>>> not valid 
>>>
>>> I'd be more inclined to remove it. I would rather remove fathpath 
>>> checks as much as possible and have robust error handling in the 
>>> domain init.
>>>
>>> Afterall I do have the "remove check" craze going.
>>
>> Sure, like I say I'm happy to be consistent either way. If I do end 
>> up reinstating such a check I think I'd prefer to have it explicit in 
>> {alloc,free}_iova_fast() anyway, rather than buried in internal 
>> implementation details.
>
> I'm not sure what you would like to see now, if anything.
>
> I could just remove the iovad->rcache check in iova_rcache_get().  
> It's pretty useless (on its own) since we don't have the same check on 
> the "insert" path.
>
> Or also add this:
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0d6d8edf782d..e8f0b8f47f45 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -578,6 +578,12 @@ static int iommu_dma_init_domain(struct 
> iommu_domain *domain, dma_addr_t base,
>              goto done_unlock;
>          }
>
> +        if (!iovad->rcaches) {
> +            pr_warn("IOVA domain rcache not properly initialised\n");
> +            ret = -EFAULT;
> +            goto done_unlock;
> +        }
> +
>          ret = 0;
>          goto done_unlock;
>
If the iovad->rcaches allocation failed, will skip iommu domain dma ops, 
so no need *any* iovad,->rcaches check, right ?

and there is already warning about the fallback.

Thanks,

Ethan

>
> But I figure that you don't want more crud there now, considering the 
> work you mention above.
>
> Thanks,
> John
>
>
>
-- 
"firm, enduring, strong, and long-lived"


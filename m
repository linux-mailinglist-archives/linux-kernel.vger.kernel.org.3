Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B752B392
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiERHiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiERHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:38:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71590D80A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652859498; x=1684395498;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rK9Kd22X5mr1Q7KtU0cqXcihhnCmtCTuqikltUyWYO8=;
  b=TNhrGK5f1905/Yc7+y1rwSE2vtTxfM/BsUfHxNrbS5Nhcc9jL11Zt7r0
   SVB8D/2AZfXkaIRSspFf+qxq+XE7VTwi2y7o2aNGQGE5XhL34JLti2rky
   WrSe1c31MEcadQh8EgS4gke71sR37EsvJ7KIvtqd7HsCYe0+wk0ss3HzN
   cIcvESq9k/gBIYSzSDW+xzHfAI0UFwSmhxK4S44r19qNaF+D3yfyErXWL
   Mnp3cSAorzINtwlewh37GMaT2mAvkFccz6sEOKTpTTdNHt57esaXG1beP
   /xitwULBDiukE8VjrflulpYlSsuptgNx9z4+ZedmWkJHBxQe3ciZZAoEe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271227629"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271227629"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:38:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="545307262"
Received: from lenawanx-mobl.ccr.corp.intel.com (HELO [10.255.28.87]) ([10.255.28.87])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:38:10 -0700
Message-ID: <efab101f-14e2-ab5c-810d-c355aebaad52@linux.intel.com>
Date:   Wed, 18 May 2022 15:38:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-7-baolu.lu@linux.intel.com>
 <20220516180628.GL1343366@nvidia.com>
 <6cdc43a3-72ba-5360-0827-6915ef563d64@linux.intel.com>
 <20220517111350.GR1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220517111350.GR1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/17 19:13, Jason Gunthorpe wrote:
> On Tue, May 17, 2022 at 10:05:43AM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 2022/5/17 02:06, Jason Gunthorpe wrote:
>>>> +static __init int tboot_force_iommu(void)
>>>> +{
>>>> +	if (!tboot_enabled())
>>>> +		return 0;
>>>> +
>>>> +	if (no_iommu || dmar_disabled)
>>>> +		pr_warn("Forcing Intel-IOMMU to enabled\n");
>>> Unrelated, but when we are in the special secure IOMMU modes, do we
>>> force ATS off? Specifically does the IOMMU reject TLPs that are marked
>>> as translated?
>>
>> Good question. From IOMMU point of view, I don't see a point to force
>> ATS off, but trust boot involves lots of other things that I am not
>> familiar with. Anybody else could help to answer?
> 
> ATS is inherently not secure, if a rouge device can issue a TLP with
> the translated bit set then it has unlimited access to host memory.

Agreed. The current logic is that the platform lets the OS know such
devices through firmware (ACPI/DT) and OS sets the untrusted flag in
their device structures. The IOMMU subsystem will disable ATS on devices
with the untrusted flag set.

There is some discussion about allowing the supervisor users to set the
trust policy through the sysfs ABI, but I don't think this has happened
in upstream kernel.

> Many of these trusted iommu scenarios rely on the idea that a rouge
> device cannot DMA to arbitary system memory.

I am not sure whether tboot has the same requirement.

Best regards,
baolu

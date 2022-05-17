Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB2252971A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiEQCF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiEQCFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:05:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05873201AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652753153; x=1684289153;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H26s11c+cWCKcz0F/X26CeSP8+ctLNYb+8KZJ7Yj2sw=;
  b=cDq9ed9OsJ2NRiBvWYto4VGd4LmM62BCaAfQVjumg7MfOOMx7tMRSi9V
   BWTRmNDo/FfsvZXh63kH/dEFAx5DZgFHIzWEr4a9uug6Bm24GmR2+F9SP
   eSgC9atwREPabRYwOZEINaKy7Yg2DIMdojIFV5MtkcUZbBJy+U/g7xanN
   r70j1RrjFkzG4ywe/5zOyG3/FOHiS+jNiNJ9JvAcoIQEi84KG8Ef7+8Lh
   T6NfN616agsYxn4AA0KmelMm6qwC/mzb4GdQ/lle91rL1/kyo99uyM3Bj
   pEDvfaZZSz+gqag2+pwbOcK3lZ1gaAbhR8qzJ8mEL26k/AtAWC6FoTrK8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="334067223"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="334067223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 19:05:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="596846285"
Received: from ctang1-mobl.ccr.corp.intel.com (HELO [10.249.192.251]) ([10.249.192.251])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 19:05:45 -0700
Message-ID: <6cdc43a3-72ba-5360-0827-6915ef563d64@linux.intel.com>
Date:   Tue, 17 May 2022 10:05:43 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220516180628.GL1343366@nvidia.com>
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

Hi Jason,

On 2022/5/17 02:06, Jason Gunthorpe wrote:
>> +static __init int tboot_force_iommu(void)
>> +{
>> +	if (!tboot_enabled())
>> +		return 0;
>> +
>> +	if (no_iommu || dmar_disabled)
>> +		pr_warn("Forcing Intel-IOMMU to enabled\n");
> Unrelated, but when we are in the special secure IOMMU modes, do we
> force ATS off? Specifically does the IOMMU reject TLPs that are marked
> as translated?

Good question. From IOMMU point of view, I don't see a point to force
ATS off, but trust boot involves lots of other things that I am not
familiar with. Anybody else could help to answer?

Best regards,
baolu

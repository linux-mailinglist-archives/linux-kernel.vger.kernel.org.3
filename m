Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C426C519160
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiECW1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiECW1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:27:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F542484
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651616626; x=1683152626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9zdbw4LKyv8n+MHXZDAhivyjG4ISyB+mlaJTfVNezJw=;
  b=VDV20spyUSiqTOcfk+LdJ7CfAGRwe6m123wtCg0PvlILaAJyvTfJaQb0
   hCNzH/iX4zE8DhagIaL4QSNIA3oAADxQ2vqtsVACG7AJu+xVmeClceVIL
   Jjj+6NjlihORox6S2YynaejrE2nGnSChygbwhZBvqa39G+bqL6EitZBAl
   RySuHX83WoMpNNCnrjo8RPBV4Zkb10knLebXbtd7iGZa+clYJ1we3yE8f
   GfAzn8W9SNRruaLPiMS9XiTYeZJAkxVJyecmEgsrllKkD8hhM91K0ZONz
   HFK8d1AzuCagfB+CmnEt91GvaEWKvflBJaUrpOpQPaCrA9z5ApyxXZEFP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247512028"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="247512028"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:23:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="664175189"
Received: from dbandax-mobl2.amr.corp.intel.com (HELO [10.209.188.251]) ([10.209.188.251])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:23:45 -0700
Message-ID: <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
Date:   Tue, 3 May 2022 15:24:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 18:27, Kirill A. Shutemov wrote:
>> Again, Dave and Andi already commented you should use vmap() to avoid breaking
>> up the direct-mapping.  Please use vmap() instead.
>>
>> https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
>>
>> Will review the rest later.
> I would rather convert it to use DMA API for memory allocation. It will
> tap into swiotlb buffer that already converted and there's no need to
> touch direct mapping. Both allocation and freeing such memory is cheaper
> because of that.

Sathya, I don't quite understand why you are so forcefully declining to
incorporate review feedback on this point.  I gave very specific
feedback about the kind of mapping you need and that you should avoid
fragmenting the direct map if at all possible.

Why is this code still fragmenting the direct map?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D1525998
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376456AbiEMCKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiEMCJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:09:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C101E5EE0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652407791; x=1683943791;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z65torRcig/enwY4e/08U9dWxV9t8BfziP29ghWb42o=;
  b=NLj+wKe78OwVKEWe9UMh6XU4chQUAT4pPpA4t6ftM1xNWmcau9DF/o8b
   L7dqhUNRDKzGeVBZZiOfbkGvg433JZ/4Fe+65jIGAjyzFUHL+65ys/8Jl
   9XHlDdbbZoTlKC2GwXUYAakR4Hukaawh4Kmzu2Q35iPOuCN/t5h6dyv07
   snXaOwy6oKMc6jNKAiGXPM5BKRePVFV+c8SUKeNzuiAdqka9/BA6gPL1o
   9aHWOqQnNKQTZiQrQNhhCv7CJ9X1bvKGZUK0AuhfeTEbOSbGVMmmxb2oB
   y/btd+BslA7Ub2jHSbnl6MB59zwWhMkyNVI+ZITFPLIHvH58X5UBOfZ1L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330791609"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="330791609"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 19:09:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="739965747"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.249.175.174]) ([10.249.175.174])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 19:09:48 -0700
Message-ID: <2c65b8cf-3813-3ddf-3f5b-c374cc842678@linux.intel.com>
Date:   Fri, 13 May 2022 10:09:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/13 07:12, Steve Wahl wrote:
> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>> To support up to 64 sockets with 10 DMAR units each (640), make the
>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>> set.
>>
>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>> fails to boot properly.
>>
>> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> 
> I've received a report from the kernel test robot <lkp@intel.com>,
> that this patch causes an error (shown below) when
> CONFIG_IOMMU_SUPPORT is not set.
> 
> In my opinion, this is because include/linux/dmar.h and
> include/linux/intel-iommu are being #included when they are not really
> being used.
> 
> I've tried placing the contents of intel-iommu.h within an #ifdef
> CONFIG_INTEL_IOMMU, and that fixes the problem.
> 
> Two questions:
> 
> A) Is this the desired approach to to the fix?

Most part of include/linux/intel-iommu.h is private to Intel IOMMU
driver. They should be put in a header like drivers/iommu/intel
/iommu.h. Eventually, we should remove include/linux/intel-iommu.h
and device drivers interact with iommu subsystem through the IOMMU
kAPIs.

Best regards,
baolu

> 
> B) Should it be a separate patch, or added onto this patch as a v3?
> 
> Error message:  ------------------------------
> 
>     In file included from include/linux/intel-iommu.h:21,
>                      from arch/x86/kvm/x86.c:44:
>>> include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED' undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
>        21 | #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
>           |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/intel-iommu.h:531:35: note: in expansion of macro 'DMAR_UNITS_SUPPORTED'
>       531 |         unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
>           |                                   ^~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +21 include/linux/dmar.h
> 
>      20
>    > 21  #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
>      22
> 
> Initial stab at fixing it: ------------------------------
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d00..916fd7b5bcb5 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -10,6 +10,8 @@
>   #ifndef _INTEL_IOMMU_H_
>   #define _INTEL_IOMMU_H_
>   
> +#ifdef CONFIG_INTEL_IOMMU
> +
>   #include <linux/types.h>
>   #include <linux/iova.h>
>   #include <linux/io.h>
> @@ -831,4 +833,6 @@ static inline const char *decode_prq_descriptor(char *str, size_t size,
>   	return str;
>   }
>   
> +#endif /* CONFIG_IOMMU_SUPPORT */
> +
>   #endif
> 
> 
> Thanks.
> 
> --> Steve Wahl
> 
> 


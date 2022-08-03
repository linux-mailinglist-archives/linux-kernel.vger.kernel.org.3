Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7622F5888D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiHCIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHCIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:48:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0A13F9C;
        Wed,  3 Aug 2022 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659516485; x=1691052485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+qvKUwqmQKAYYrLXg2GV2+q+xTQp35oEGWNYLkPBXjQ=;
  b=eVXxiXVRBlghl14uriO3/0A7OYAP5mP7CBJ2hFSj3E/+xdRcc3X1hXt8
   RkZnMkIU5IXJGfJCyw4wcOkZJCsBqULshqJAz11KIO+o0ZPWwpqvhKr2D
   tBUC+8X6eUfmIftBqpR/Q2jDntBw4Kuh7Sx0cprtHm5WndMxdipVFNr3j
   MQv1JD9TuIG0pwTalFwwJ1gu75OAxVZZHaLrJFfChHdKRqbqarhL2prDC
   lvgQHuO4lng56KimDexgqzZPEGfrGZmkmByz7sRPEuZkzn+vh4iF9Oxv7
   TNmjERU5Y+vjQxickkmhNGym6i9iHAmEmhvcoEpInInMABzBw4dtzKP3P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="289632904"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="289632904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 01:48:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="661991747"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.118]) ([10.99.241.118])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 01:48:03 -0700
Message-ID: <2d4fac14-eaf8-c899-dba2-b2ffb484358d@linux.intel.com>
Date:   Wed, 3 Aug 2022 10:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] sparc64: bitops: Change __fls to return unsigned
 long
Content-Language: en-US
To:     Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <20220527115345.2588775-1-amadeuszx.slawinski@linux.intel.com>
 <20220527115345.2588775-4-amadeuszx.slawinski@linux.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220527115345.2588775-4-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/2022 1:53 PM, Amadeusz Sławiński wrote:
> As per asm-generic definition and other architectures __fls should
> return unsigned long.
> 
> No functional change is expected as return value should fit in unsigned
> long.
> 
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>   arch/sparc/include/asm/bitops_64.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
> index 005a8ae858f1..cdac39bd7b32 100644
> --- a/arch/sparc/include/asm/bitops_64.h
> +++ b/arch/sparc/include/asm/bitops_64.h
> @@ -24,7 +24,7 @@ void clear_bit(unsigned long nr, volatile unsigned long *addr);
>   void change_bit(unsigned long nr, volatile unsigned long *addr);
>   
>   int fls(unsigned int word);
> -int __fls(unsigned long word);
> +unsigned long __fls(unsigned long word);
>   
>   #include <asm-generic/bitops/non-atomic.h>
>   

Hi,

any chance this one could also get merged? Other two patches are already 
in linux-next and I would like to remove it from list of things I have 
to remember ;)

Amadeusz

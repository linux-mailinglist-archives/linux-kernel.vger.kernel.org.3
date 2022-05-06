Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D0F51D0F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389288AbiEFGAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389281AbiEFGAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:00:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FE13D6A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651816626; x=1683352626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OL2oJRFDVdmovflg5mLwCF3EJPwhcMaRX4sx8VlaeHk=;
  b=X52JVryAMvnvRfaWeMNi1zUiqVBv+uiKD+qrAlrlqxw04XNdMWD+R5Ys
   3swrniKZN9OFyT1PrdBm7MYzUWYGd/b2Uapm01GQypcCy8DH7CapErYX3
   StsetQABdczgTl64qQwK03Z9AnfOimCqHOrKduqqC1TfSLeMJKi7nVmx1
   gI/h/W6/E+B145lYN2Argm7uNvlGV1swVia24My4Yr35iaTBSBLf8Mv28
   /gUKLLE8YzQmoxVdogLt3pfxMbnderPzrU2TtCc3kz2ExeWf2a8hSeMaf
   p35saZAm+CNmfVGD4LqAUhSeA1Y24OWAXBYh/BpGahT0PREY+f6Vg+zj3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255843240"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255843240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:57:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735415841"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183]) ([10.255.31.183])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:57:02 -0700
Message-ID: <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
Date:   Fri, 6 May 2022 13:57:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
References: <20220505194658.246121-1-steve.wahl@hpe.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220505194658.246121-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/6 03:46, Steve Wahl wrote:
> Increase DMAR_UNITS_SUPPORTED to support 64 sockets with 10 DMAR units
> each, for a total of 640.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Reviewed-by: Mike Travis <mike.travis@hpe.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.

+Kevin

This maximum value was introduced by below commit. And I don't see any
hardware/software restrictions that we can't enlarge it after ten years.

commit 1b198bb04ad72669d4bd6575fc9945ed595bfee0
Author: Mike Travis <travis@sgi.com>
Date:   Mon Mar 5 15:05:16 2012 -0800

     x86/iommu/intel: Increase the number of iommus supported to 
MAX_IO_APICS

     The number of IOMMUs supported should be the same as the number
     of IO APICS.  This limit comes into play when the IOMMUs are
     identity mapped, thus the number of possible IOMMUs in the
     "static identity" (si) domain should be this same number.
[...]

> 
>   include/linux/dmar.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 45e903d84733..9d4867b8f42e 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -19,7 +19,7 @@
>   struct acpi_dmar_header;
>   
>   #ifdef	CONFIG_X86
> -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> +# define	DMAR_UNITS_SUPPORTED	640
>   #else
>   # define	DMAR_UNITS_SUPPORTED	64
>   #endif

Best regards,
baolu

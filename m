Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D74D9781
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbiCOJUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbiCOJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:20:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865653C49D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647335973; x=1678871973;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=46zrfiN9MIVTyj5zc/5rHeZmNQw0cmaObFmdxkGALgs=;
  b=hxO1jfcBTGpAq3pxpO6YuVPo56KNSNV5q6kJLk30DEgi4TpRge0AAdO9
   G8RWla8uazJPfWjTXJhFrHehBC9VHq69ZCbRBJPx3gh/pPCP5E3f5ksJw
   Xl4E/3G/SNxFiS4G2yO7hbcUWN4SzftBhULr/cG9b7fmuN+NcdebgPT85
   z6qRPXjnR8v7uRWM4FYp0D+/QU0VHnST6o90oS3WGnsUdQRy1hXtVO+0q
   oUmzt+Kp1b+TCEZzgOxsdq16martUcvEnstW5XDfQ5yPb/pmKuR0flhmK
   gVsP9OENGEEqaDFaBVkN3a3DanDtN6xNrqWl/NPZtRHUHVljfVgp+Imjs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319474632"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="319474632"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 02:19:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="540356304"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 02:19:30 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
References: <20220314150945.12694-1-osalvador@suse.de>
        <87pmmn3eh6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YjBPKmIpPNoJU/67@localhost.localdomain>
Date:   Tue, 15 Mar 2022 17:19:28 +0800
In-Reply-To: <YjBPKmIpPNoJU/67@localhost.localdomain> (Oscar Salvador's
        message of "Tue, 15 Mar 2022 09:32:42 +0100")
Message-ID: <87lexb1skf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, Mar 15, 2022 at 02:40:53PM +0800, Huang, Ying wrote:
>> Oscar Salvador <osalvador@suse.de> writes:
>> CPUHP_MM_DEMOTION_DEAD and CPUHP_AP_MM_DEMOTION_ONLINE needs to be
>> deleted from include/linux/cpuhotplug.h too.
>
> Hi Huang Ying,
>
> Right.
>
> Andrew, can you apply this on top? Thanks
>
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 411a428ace4d..8a9a2d01b7c6 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -72,8 +72,6 @@ enum cpuhp_state {
>  	CPUHP_SLUB_DEAD,
>  	CPUHP_DEBUG_OBJ_DEAD,
>  	CPUHP_MM_WRITEBACK_DEAD,
> -	/* Must be after CPUHP_MM_VMSTAT_DEAD */
> -	CPUHP_MM_DEMOTION_DEAD,
>  	CPUHP_MM_VMSTAT_DEAD,
>  	CPUHP_SOFTIRQ_DEAD,
>  	CPUHP_NET_MVNETA_DEAD,
> @@ -244,8 +242,6 @@ enum cpuhp_state {
>  	CPUHP_AP_BASE_CACHEINFO_ONLINE,
>  	CPUHP_AP_ONLINE_DYN,
>  	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
> -	/* Must be after CPUHP_AP_ONLINE_DYN for node_states[N_CPU] update */
> -	CPUHP_AP_MM_DEMOTION_ONLINE,
>  	CPUHP_AP_X86_HPET_ONLINE,
>  	CPUHP_AP_X86_KVM_CLK_ONLINE,
>  	CPUHP_AP_ACTIVE,
>
> Huang Ying, it would be great to have your Reviewed-by/Acked-by if you
> are ok with the outome.

Sure.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

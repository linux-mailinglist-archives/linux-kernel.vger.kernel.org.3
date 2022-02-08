Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377084ACF10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbiBHClj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbiBHCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:41:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D8C06109E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644288089; x=1675824089;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=clZCN2d5mdaipuHu+jawY18XiyXmctriiRxBVPXsw70=;
  b=fUSAfbPoP5kjbaJB/OngNGt4AkRK8w6/NbIfZ+HWnY7eveOmh0pzzMUg
   NBI1/QXKkS9480H+4aIpiDu1fF8qvLf8FlTTnKxAseXfFbBAnMh/8b+vR
   KN8WuYAeJxn3CE1cCu+ewdX+AtX06kPpoG9AXpUx92X8BW2VTipnsBM/N
   ylC2t4SBblV+YtsHZX6ANhGX+q9zJArnJNJvEsaHxXZSHh9R8kSyc6jt4
   H89ntspAPzCGIanPHW7RgyxSsmO7Ay8DL18Mfg9ZbaSZbqjLyMT0gPw/8
   DURqOgcaDX6zs1mPh5k6xZvWu2p7jrDwj7sY73fyHGZ3tNuErUIE9V0Xv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="312155588"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="312155588"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 18:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677965770"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 18:41:25 -0800
Message-ID: <d8e4a38a-a7e2-1915-0b95-ac4dadf5c3dc@linux.intel.com>
Date:   Tue, 8 Feb 2022 10:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] mm: Change CONFIG option for mm->pasid field
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-3-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207230254.3342514-3-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 7:02 AM, Fenghua Yu wrote:
> This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
> needed when CONFIG_IOMMU_SVA option is enabled.
> 
> Change the CONFIG guards around definition and initialization
> of mm->pasid field.
> 
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> v4:
> - Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).
> 
> v2:
> - Change condition to more accurate CONFIG_IOMMU_SVA (Jacob and Tony)
> 
>   include/linux/mm_types.h | 2 +-
>   kernel/fork.c            | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5140e5feb486..c5cbfd7915ad 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -631,7 +631,7 @@ struct mm_struct {
>   #endif
>   		struct work_struct async_put_work;
>   
> -#ifdef CONFIG_IOMMU_SUPPORT
> +#ifdef CONFIG_IOMMU_SVA
>   		u32 pasid;
>   #endif
>   	} __randomize_layout;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d75a528f7b21..6ee7551d3bd2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1021,7 +1021,7 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
>   
>   static void mm_init_pasid(struct mm_struct *mm)
>   {
> -#ifdef CONFIG_IOMMU_SUPPORT
> +#ifdef CONFIG_IOMMU_SVA
>   	mm->pasid = INIT_PASID;
>   #endif
>   }

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

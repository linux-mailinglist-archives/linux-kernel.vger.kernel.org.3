Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EBC51D0CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389233AbiEFFk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiEFFkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:40:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243AF5E76E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651815404; x=1683351404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7WUabhyWEk0L7SRCIeRBJvTnaBGJT01I1lM5YJHnXF8=;
  b=I1+oMP8uW81gtiV+Cja77FEA063QVbPXr+81v1ktL8HloNXxz4iL4GBQ
   Wb8H64tr7gAd+f+BloX2xpv0UmtFBE/NyO5wY+yQ+xuhX3ZzpwJGN5OWQ
   B2rUreI6uJq5ebmu7lUt1z8iWhSU7qNNZX2iD5DQzrnY5PGFE/ePsvFvz
   jjy43P7OmmGtCh/3bkq9KZWT3l1PikCihw3IrZ/lBYAxFdrACug0lzGWI
   iGo8gI55rRAvi7k+a0J+tqMJ1+gBjF6FTyz7smhy9mw9nMg32gxV830fK
   zezjxzLsK97/xhYInhmEdNulFvUzuVAhNZGC4+z0eLmvZr0SMYOFcEa+1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267198191"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267198191"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:36:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735407780"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183]) ([10.255.31.183])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:36:39 -0700
Message-ID: <a7778e67-bcc7-03b0-0b58-fc311d542baa@linux.intel.com>
Date:   Fri, 6 May 2022 13:36:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
References: <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com> <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com> <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com> <Ymv3fC4xXqe+oMRK@myrica>
 <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
 <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
 <YnDeoGjv/dZnu+YQ@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnDeoGjv/dZnu+YQ@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/3 15:49, Jean-Philippe Brucker wrote:
> On Sat, Apr 30, 2022 at 03:33:17PM +0800, Baolu Lu wrote:
>> Jean, another quick question about the iommu_sva_bind_device()
>>
>> /**
>>   * iommu_sva_bind_device() - Bind a process address space to a device
>>   * @dev: the device
>>   * @mm: the mm to bind, caller must hold a reference to it
>>   * @drvdata: opaque data pointer to pass to bind callback
>>
>> This interface requires the caller to take a reference to mm. Which
>> reference should it take, mm->mm_count or mm->mm_users? It's better to
>> make it explicit in this comment.
> 
> Agreed, it's mm_users as required by mmu_notifier_register()

Thanks! I will add this in my refactoring patch.

Best regards,
baolu


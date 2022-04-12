Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AA4FE3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356696AbiDLOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354554AbiDLOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:41:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7467E51
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649774345; x=1681310345;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=GZj64pjcWXoZ+UWhUertM7DeZpkX/WIgVteyu9EF33A=;
  b=IDSUsTAlQ9zt0b59jP0LV/+kgzTpNpUVrcv4R4vwjuWWqkLvIUWN6qWP
   0X9Xst9cA+3JzUBxiV7xW+e8YTSz/je7YsVi3RE/KvcGa8dDLZ3M+jGip
   GxfuQqAp49x+N/L0iASjUVLK+OIynSP3cvmCJ6kbiJzbV+qk0RK8IhdTr
   FCsgRq221UNAaspkkLundKvDYQ7GCx9UO7424jbX28NRNrb3+CPBUDuP3
   yuNJmtmESZU2UmE0hUd3tA51ty1e31xnJGkN7qhZOGlMVyz1LuWqiiWk5
   S45mql+/HkpC5q6YIlTZIFJBtY4EyAtt5lWDtgccpkdpPlhYg9Hn1NtYJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="348826558"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="348826558"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:39:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="551735814"
Received: from vtelkarx-mobl.amr.corp.intel.com (HELO [10.209.191.73]) ([10.209.191.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:39:04 -0700
Message-ID: <2cd3132b-2c24-610e-1a96-591f2803404c@intel.com>
Date:   Tue, 12 Apr 2022 07:39:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 06:41, Fenghua Yu wrote:
>> master process quit, mmput ->  mm_pasid_drop->ioasid_free
>> But this ignore driver's iommu_sva_unbind_device function,
>> iommu_sva_bind_device and iommu_sva_unbind_device are not pair,  So driver
>> does not know ioasid is freed.
>>
>> Any suggestion?
> ioasid is per process or per mm. A daemon process shouldn't share the same 
> ioasid with any other process with even its parent process. Its parent gets
> an ioasid and frees it on exit. The ioasid is gone and shouldn't be used
> by its child process.
> 
> Each daemon process should call driver -> iommu_sva_bind_device -> ioasid_alloc
> to get its own ioasid/PASID. On daemon quit, the ioasid is freed.
> 
> That means nqnix needs to be changed.

Fenghua, please step back for a second and look at what you are saying.
 Your patch caused userspace to break.  Now, you're telling someone that
they need to go change that userspace to work around something that your
patch.  How, exactly, are you suggesting that nginx could change to fix
this?  What, specifically, was it doing with *fork()* that was wrong?

It sounds to me like you're saying that it's OK to break userspace.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125C4FBFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbiDKOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbiDKOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:55:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0371319C28
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649688774; x=1681224774;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=mB8NNTw44eMZUF35h4h29n6vL38O8wnd1LwLHFK4xHE=;
  b=ds8Fxd4t4VU9DhRM3P/TaXNSPd0EfUWJUBbQ/yz17x044xPYIaqYOwr7
   MHpht+QkzWbjuubFwzj8f0y/XQxu8vCqFPHPwu/NsgAh4Yv/m37qShndH
   fypoO6Qdld6HH2LVWtVEOCqhw7D8Cae+Cgj+2gKAekPMZ2PrH6HagW7sX
   brtcXNskZXJtZkc2ZuUELhJNOw2cP78M2BvAoRus61ot2ycvjd5VmKcgL
   uhsXapDvBNogHU2pQ8WV+iOM2oa1FT4VGVJR4GA1gZvJlHtU8/77VH4a6
   TbnQ7FqaGeM6LHV4d6o4aQqoCNwEh7F9ShW0oQC5NZg+iBuvkUQFvgp3s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325045641"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="325045641"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:52:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="525561650"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6]) ([10.212.113.6])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:52:51 -0700
Message-ID: <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
Date:   Mon, 11 Apr 2022 07:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        jean-philippe <jean-philippe@linaro.org>
Cc:     Ravi V Shankar <ravi.v.shankar@intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/22 07:44, zhangfei.gao@foxmail.com wrote:
> On 2022/4/11 下午10:36, Dave Hansen wrote:
>> On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
>>>> Is there nothing before this call trace?  Usually there will be at least
>>>> some warning text.
>>> I added dump_stack() in ioasid_free.
>> Hold on a sec, though...
>>
>> What's the *problem* here?  Did something break or are you just saying
>> that something looks weird to _you_?
> 
> After this, nginx is not working at all, and hardware reports error.
> Suppose the the master use the ioasid for init, but got freed.
> 
> hardware reports:
> [  152.731869] hisi_sec2 0000:76:00.0: qm_acc_do_task_timeout [error status=0x20] found
> [  152.739657] hisi_sec2 0000:76:00.0: qm_acc_wb_not_ready_timeout [error status=0x40] found
> [  152.747877] hisi_sec2 0000:76:00.0: sec_fsm_hbeat_rint [error status=0x20] found
> [  152.755340] hisi_sec2 0000:76:00.0: Controller resetting...
> [  152.762044] hisi_sec2 0000:76:00.0: QM mailbox operation timeout!
> [  152.768198] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> [  152.773490] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
> [  152.781426] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
> [  152.787468] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> [  152.792753] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
> [  152.800685] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
> [  152.806730] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> [  152.812017] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
> [  152.819946] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
> [  152.825992] hisi_sec2 0000:76:00.0: Failed to dump sqc!

That would have been awfully handy information to have in an initial bug report. :)
Is there a chance you could dump out that ioasid alloc *and* free information in ioasid_alloc/free()?  This could be some kind of problem with the allocator, or with copying the ioasid at fork.

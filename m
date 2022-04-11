Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFF4FBE67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbiDKONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346980AbiDKONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:13:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4464431DFE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649686276; x=1681222276;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=frC20TMIzMSN3lrgDTo+z6mOXOf30jMlelae8Bj8uAA=;
  b=AUZdiQbQ9VmmfdnUZ3RQ/bZl5+R7elk0NuzxznXNgmLAwl7v64BqFS4E
   +BYiWcFRKl8PcZZWy+5n9OplUV3It5Lfr6f/H51RHAitPyGEq5A/N+lJt
   fCVWdH78S55JgQQCsDfoZylq3swn9qllLwVI06DqP52fDEhgIiem82TUP
   VUFvCKX6cNR4CVZffSsWOt/nJGsqfyh4kHyF/UJ1IjDjhnmjeJkVddBIy
   8lormWn5uxS29YA35rQko+ZSwUk7Md6qayCYCjrK+PWvgKSA9kKBgbquJ
   J/CqDHZ6pWQQ7aXezGuA4zGBv0HLgWRth8UqpVC1nqzt0CflxrT/q6syF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242063272"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="242063272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:10:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="525550119"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6]) ([10.212.113.6])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:10:38 -0700
Message-ID: <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
Date:   Mon, 11 Apr 2022 07:10:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Zhangfei Gao <zhangfei.gao@foxmail.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 07:00, Zhangfei Gao wrote:
> with this patchset, each time after  sbin/nginx, ioasid is freed
> immediately. lynx test will alloc the same ioasid=1.

That doesn't seem right.  Isn't 'sbin/nginx' still running when lynx
runs?  How can they get the same ioasid?

This sounds like a refcounting problem, like that the ioasid wasn't
properly refcounted as nginx forked into the background.

> To verify, hack comment mm_pasid_drop in __mmput will make the issue
> disappear.
> 
> log: after sbin/nginx.
> [   96.526730] Call trace:
> [   96.526732]  dump_backtrace+0xe4/0xf0
> [   96.526741]  show_stack+0x20/0x70
> [   96.526744]  dump_stack_lvl+0x8c/0xb8
> [   96.526751]  dump_stack+0x18/0x34
> [   96.526754]  ioasid_free+0xdc/0xfc
> [   96.526757]  mmput+0x138/0x160
> [   96.526760]  do_exit+0x284/0x9d0
> [   96.526765]  do_group_exit+0x3c/0xa8
> [   96.526767]  __wake_up_parent+0x0/0x38
> [   96.526770]  invoke_syscall+0x4c/0x110
> [   96.526775]  el0_svc_common.constprop.0+0x68/0x128
> [   96.526778]  do_el0_svc+0x2c/0x90
> [   96.526781]  el0_svc+0x30/0x98
> [   96.526783]  el0t_64_sync_handler+0xb0/0xb8
> [   96.526785]  el0t_64_sync+0x18c/0x190

Is there nothing before this call trace?  Usually there will be at least
some warning text.

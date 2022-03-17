Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60004DBBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiCQAdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiCQAdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:33:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C891CB08
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647477157; x=1679013157;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6yZKxtvtQUWp4Q0WLbYvXwoc4gQZxar2yGPNuMkMlao=;
  b=fPUw7CodIiQ4AMZmrFInDZKFUNUhCDTqPwGcbvkC6L5BamtPWE1g+JXf
   33YY3lnJ+GJ3z0dkuiqa4oeGKTpAzy7Tw+LiQbJAUh9i1HJzu+rTgVRe6
   oChNkZWoOgSt3/JTlSmQ7WB/RaByh3I4Hg9137BRbesO+X5uy35PaYq5C
   GkKxx7HYDGKfAtru0rHfFIMrQj29Nqg1fk6PAshE3Tv5KfLk6fZFLyi6n
   DaVDU5CfT15I1yIuD1zOMh9huXCQ2zAy6yv+GmJmd2G0wD3QKjy79eNta
   08GX8wFywPXtAwMzQAtmZfup8ILjFAN0nzy8349Zv3+Q/fsCCQPI1Og3f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236693529"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="236693529"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:32:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="541156499"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.248]) ([10.255.28.248])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:32:35 -0700
Subject: Re: [kbuild-all] Re: [tip:locking/core 4/5] vmlinux.o: warning:
 objtool: do_machine_check()+0x419: call to mca_msr_reg() leaves .noinstr.text
 section
To:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <202203141947.9KhIyyR7-lkp@intel.com> <Yi8ur4I5RJ2CT0Rx@zn.tnic>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <c3c5e7fd-eae8-bfc8-6a30-ca6d01a933bc@intel.com>
Date:   Thu, 17 Mar 2022 08:32:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Yi8ur4I5RJ2CT0Rx@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/2022 8:01 PM, Borislav Petkov wrote:
> On Mon, Mar 14, 2022 at 07:40:08PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
>> head:   cd27ccfc727e99352321c0c75012ab9c5a90321e
>> commit: acb13ea0baf8db8d05a3910c06e997c90825faad [4/5] asm-generic/bitops: Always inline all bit manipulation helpers
>> config: x86_64-randconfig-a005-20220314 (https://download.01.org/0day-ci/archive/20220314/202203141947.9KhIyyR7-lkp@intel.com/config)
>> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=acb13ea0baf8db8d05a3910c06e997c90825faad
>>          git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>>          git fetch --no-tags tip locking/core
>>          git checkout acb13ea0baf8db8d05a3910c06e997c90825faad
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     vmlinux.o: warning: objtool: mce_read_aux()+0x42: call to mca_msr_reg() leaves .noinstr.text section
>>>> vmlinux.o: warning: objtool: do_machine_check()+0x419: call to mca_msr_reg() leaves .noinstr.text section
>>     vmlinux.o: warning: objtool: enter_from_user_mode()+0x4a: call to on_thread_stack() leaves .noinstr.text section
>>     vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x53: call to on_thread_stack() leaves .noinstr.text section
>>     vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4a: call to on_thread_stack() leaves .noinstr.text section
>>     vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4a: call to on_thread_stack() leaves .noinstr.text section
> 
> You need to test tip/ras/core with that .config - not some random
> patches inside of locking/core. Fixing the noinstr issues is split into
> a couple of patches in locking/core and ras/core.
> 
> Thx.
> 

Hi Borislav,

Thanks for the explanation, should we skip testing the locking/core 
branch next time?

Best Regards,
Rong Chen

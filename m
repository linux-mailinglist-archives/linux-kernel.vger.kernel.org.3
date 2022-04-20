Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ECE508174
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357527AbiDTGvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357501AbiDTGvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:51:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6D11A00
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650437303; x=1681973303;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mTGwZSM92pTyL2ctMbSS0zhlVkv6R4jcFFbuY+lt9Ug=;
  b=K5/xubxf06VgGM6MjJJIKfvu+3gzahJrk5v0rMh/AfeQkBDIqoZbnKoh
   Shw9ctOBusS+AZtMxNkv1SCFVMl7LoKhNNg+JuA50vPjC4OypfQSbV5Ce
   wVVGfAhvwayIhK9njunjseWpPgu8ErjH6Li1NM+oHj4svz45PK2Pg0b/B
   ZeDDHQTiZkctebGIWIaHxka3hg/5Sen95nPdxuPSuae3yUz460i8e6CZB
   NJw7I14xI9oPo28AKwxIMCySOaMhwU5P6QcYYg6yvnA0g1C+DeyqURn+7
   y6BR1kczy+jF8di/8jQe2bMi50MOYcmR9P9EM5uGytT4ZaDu2MUrgx8gH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="264126842"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="264126842"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:48:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="727366893"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.199]) ([10.255.31.199])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:48:18 -0700
Subject: Re: [kbuild-all] Re: [PATCH] mm/swap: Fix lost swap bits in
 unuse_pte()
To:     Miaohe Lin <linmiaohe@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        apopple@nvidia.com, surenb@google.com, minchan@kernel.org,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <Yl8rZkhU/B0iE2ob@xz-m1.local>
 <202204201313.QYiDBRbL-lkp@intel.com>
 <c14c0865-867c-ca14-8b2c-7e6e94ee7c85@huawei.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <52536319-962a-864c-d5a7-5b959aa91f22@intel.com>
Date:   Wed, 20 Apr 2022 14:48:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c14c0865-867c-ca14-8b2c-7e6e94ee7c85@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2022 2:23 PM, Miaohe Lin wrote:
> On 2022/4/20 13:56, kernel test robot wrote:
>> Hi Peter,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on hnaz-mm/master]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-swap-Fix-lost-swap-bits-in-unuse_pte/20220420-053845
>> base:   https://github.com/hnaz/linux-mm master
>> config: s390-randconfig-r023-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201313.QYiDBRbL-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install s390 cross compiling tool for clang build
>>          # apt-get install binutils-s390x-linux-gnu
>>          # https://github.com/intel-lab-lkp/linux/commit/355ac3eb45402f7aab25b76af029d4390af05238
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Peter-Xu/mm-swap-Fix-lost-swap-bits-in-unuse_pte/20220420-053845
>>          git checkout 355ac3eb45402f7aab25b76af029d4390af05238
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
> 
> The variable name is newpte. But it's written as new_pte latter. Many thanks for report!
> 
> BTW: Since this is not a formal patch (no compile tested). Is Reported-by tag still needed?

Hi Miaohe,

Please ignore the tag, it's only a suggestion, the bot doesn't
know the entire picture.

Best Regards,
Rong Chen

> 
> Thanks!
> 
>> All errors (new ones prefixed by >>):
>>
>>>> mm/swapfile.c:1824:2: error: use of undeclared identifier 'new_pte'; did you mean 'newpte'?
>>             new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
>>             ^~~~~~~
>>             newpte
>>     mm/swapfile.c:1786:14: note: 'newpte' declared here
>>             pte_t *pte, newpte;
>>                         ^
>>     mm/swapfile.c:1826:26: error: use of undeclared identifier 'new_pte'
>>                     pte = pte_mksoft_dirty(new_pte);
>>                                            ^
>>     mm/swapfile.c:1828:23: error: use of undeclared identifier 'new_pte'
>>                     pte = pte_mkuffd_wp(new_pte);
>>                                         ^
>>     mm/swapfile.c:1829:36: error: use of undeclared identifier 'new_pte'; did you mean 'newpte'?
>>             set_pte_at(vma->vm_mm, addr, pte, new_pte);
>>                                               ^~~~~~~
>>                                               newpte
>>     mm/swapfile.c:1786:14: note: 'newpte' declared here
>>             pte_t *pte, newpte;
>>                         ^
>>     4 errors generated.
> ...
>>    1839	
>>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 

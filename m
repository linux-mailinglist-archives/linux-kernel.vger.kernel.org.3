Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6F4E61DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiCXKmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCXKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:42:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4368BE08;
        Thu, 24 Mar 2022 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648118449; x=1679654449;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NfLzqS0dQ7BYanFIKknfOLxjWK1epR1PMzWFpmr71Ic=;
  b=NRgIK0LJ/5eu/KDg577qX8gUIWtI8AOL/WxE7s61QVZDSH8p8Mk81SGj
   zGG7REKq1wQ7Xggp0RLZwSjuU7pLy970bkMtyfENYH3SsrxhjMc4na8it
   u6kYxAAZt/Ab68sfAKuaP7bxA/palnqhauiMaVjtFtgeHgD85hWwUbr4M
   TbUYxffURgU6WvyYtaPbHuIGOtZxhNoFBofEKyFHYwJtZnlGGb8GG8Ajp
   StNiXAwDKfBoaaommwBYCFMU+CUakKFfB48G2AB28CZsyxyjBGtDdWB3J
   uFZmE7U6I7gew4c/3rR7AFLBfg2u36SZtQLOd6fhle3GOdl0gwglPRbB7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="245820739"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="245820739"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 03:40:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="561320061"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.249]) ([10.249.174.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 03:40:44 -0700
Subject: Re: [PATCH v5 1/4] mm: hugetlb_vmemmap: introduce
 STRUCT_PAGE_SIZE_IS_POWER_OF_2
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, kbuild-all@lists.01.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
References: <20220323125523.79254-2-songmuchun@bytedance.com>
 <202203240546.MHJzsBaO-lkp@intel.com>
 <20220323151311.289dd405440932e1d6d80f30@linux-foundation.org>
 <7872f093-e26d-3403-d6cf-c6c1a782242b@intel.com>
 <CAMZfGtXqETxQPqPLebu=0b2P8RBfKiPymraJZCSK1UGAFGo=dw@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <4bf80e3a-ada7-942b-5bc1-2a1d2fee17c8@intel.com>
Date:   Thu, 24 Mar 2022 18:40:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXqETxQPqPLebu=0b2P8RBfKiPymraJZCSK1UGAFGo=dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 6:20 PM, Muchun Song wrote:
> On Thu, Mar 24, 2022 at 5:40 PM Chen, Rong A <rong.a.chen@intel.com> wrote:
>>
>>
>>
>> On 3/24/2022 6:13 AM, Andrew Morton wrote:
>>> On Thu, 24 Mar 2022 06:06:41 +0800 kernel test robot <lkp@intel.com> wrote:
>>>
>>>> Hi Muchun,
>>>>
>>>> Thank you for the patch! Yet something to improve:
>>>>
>>>> [auto build test ERROR on hnaz-mm/master]
>>>> [also build test ERROR on linus/master next-20220323]
>>>> [cannot apply to mcgrof/sysctl-next v5.17]
>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>> https://git-scm.com/docs/git-format-patch]
>>>>
>>>> url:    https://github.com/0day-ci/linux/commits/Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220323-205902
>>>> base:   https://github.com/hnaz/linux-mm master
>>>> config: arc-randconfig-r043-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240546.MHJzsBaO-lkp@intel.com/config)
>>>> compiler: arc-elf-gcc (GCC) 11.2.0
>>>> reproduce (this is a W=1 build):
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # https://github.com/0day-ci/linux/commit/64211be650af117819368a26d7b86c33df5deea4
>>>>           git remote add linux-review https://github.com/0day-ci/linux
>>>>           git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220323-205902
>>>>           git checkout 64211be650af117819368a26d7b86c33df5deea4
>>>>           # save the config file to linux build tree
>>>>           mkdir build_dir
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc prepare
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> cc1: fatal error: cannot open 'kernel/bounds.s' for writing: No such file or directory
>>>
>>> It would take a lot of talent for Munchun to have caused this!
>>>
>>> Methinks you just ran out of disk space?
>>
>> Hi Andrew,
>>
>> Thanks for the reply, I tried to apply this patch to the head of
>> mainline and I still can reproduce the error in my local machine:
>>
>> $ wget -q -O -
>> https://lore.kernel.org/lkml/20220323125523.79254-2-songmuchun@bytedance.com/raw
>> | git apply -v
>> $ mkdir build_dir && wget
>> https://download.01.org/0day-ci/archive/20220324/202203240546.MHJzsBaO-lkp@intel.com/config
>> -O build_dir/.config
>> $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross
>> O=build_dir ARCH=arc olddefconfig prepare
>> make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y
>> CROSS_COMPILE=/home/nfs/0day/gcc-11.2.0-nolibc/arc-elf/bin/arc-elf-
>> --jobs=72 O=build_dir ARCH=arc olddefconfig prepare
>> ...
>> cc1: fatal error: cannot open 'kernel/bounds.s' for writing: No such
>> file or directory
>> compilation terminated.
>> make[3]: *** [../scripts/Makefile.build:121: kernel/bounds.s] Error 1
>> make[3]: Target '__build' not remade because of errors.
>> make[2]: *** [../Makefile:1191: prepare0] Error 2
>> make[2]: Target 'prepare' not remade because of errors.
>>
> 
> Would you help me to test the following patch?  Thanks.

I have confirmed the patch can fix the issue.

Best Regards,
Rong Chen

> 
> diff --git a/Kbuild b/Kbuild
> index 21415c3b2728..a8477c011b1d 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -42,7 +42,7 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>   struct_page_size-file := include/generated/struct_page_size.h
> 
>   always-y := $(struct_page_size-file)
> -targets := mm/struct_page_size.s
> +targets += mm/struct_page_size.s
> 
>   mm/struct_page_size.s: $(timeconst-file) $(bounds-file)
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2D4E6138
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349306AbiCXJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242613AbiCXJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:42:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F1F716C2;
        Thu, 24 Mar 2022 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648114846; x=1679650846;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tk9YwSe+ArM3f53bt8qufBp0P5faZOJowbXboPuqcWs=;
  b=jaLmxJWQZSOskCfTFEgHsJjCzBFNQvdeuFnjPFE2g9Pd4wzOyVQvDwtN
   dJ//oJ5TGte9+h+7kZd/qoMjuotKTq2sMoYhrEuMqDYl8IhAMC+GSdqVH
   E8evPuC6Pyv6XJmDgpYvRguI4XwD47DN/PuqMqhXNY3JT8rs8vAmTojuz
   BrnprBLQK47s2KAuMyV5dQg+bwrmlHmvePk7vJCYf6mvFAVRX9yN8Yr+O
   NZ1mj/mIegEz7QpiGEAF1UekzlUa2/ual2o3zbW8yJ/9lFrj4vxXAPIct
   bgmdDccvgQ9bNW4BjfdwSstwfgUaYjtTTZlc/Cts4q3KerY9/o0eiR+un
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="255896950"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="255896950"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:40:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="561301454"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.249]) ([10.249.174.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:40:41 -0700
Subject: Re: [kbuild-all] Re: [PATCH v5 1/4] mm: hugetlb_vmemmap: introduce
 STRUCT_PAGE_SIZE_IS_POWER_OF_2
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, osalvador@suse.de, david@redhat.com,
        kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220323125523.79254-2-songmuchun@bytedance.com>
 <202203240546.MHJzsBaO-lkp@intel.com>
 <20220323151311.289dd405440932e1d6d80f30@linux-foundation.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <7872f093-e26d-3403-d6cf-c6c1a782242b@intel.com>
Date:   Thu, 24 Mar 2022 17:40:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220323151311.289dd405440932e1d6d80f30@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 6:13 AM, Andrew Morton wrote:
> On Thu, 24 Mar 2022 06:06:41 +0800 kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Muchun,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on hnaz-mm/master]
>> [also build test ERROR on linus/master next-20220323]
>> [cannot apply to mcgrof/sysctl-next v5.17]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220323-205902
>> base:   https://github.com/hnaz/linux-mm master
>> config: arc-randconfig-r043-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240546.MHJzsBaO-lkp@intel.com/config)
>> compiler: arc-elf-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/0day-ci/linux/commit/64211be650af117819368a26d7b86c33df5deea4
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220323-205902
>>          git checkout 64211be650af117819368a26d7b86c33df5deea4
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc prepare
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> cc1: fatal error: cannot open 'kernel/bounds.s' for writing: No such file or directory
> 
> It would take a lot of talent for Munchun to have caused this!
> 
> Methinks you just ran out of disk space?

Hi Andrew,

Thanks for the reply, I tried to apply this patch to the head of
mainline and I still can reproduce the error in my local machine:

$ wget -q -O - 
https://lore.kernel.org/lkml/20220323125523.79254-2-songmuchun@bytedance.com/raw 
| git apply -v
$ mkdir build_dir && wget 
https://download.01.org/0day-ci/archive/20220324/202203240546.MHJzsBaO-lkp@intel.com/config 
-O build_dir/.config
$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross 
O=build_dir ARCH=arc olddefconfig prepare
make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y 
CROSS_COMPILE=/home/nfs/0day/gcc-11.2.0-nolibc/arc-elf/bin/arc-elf- 
--jobs=72 O=build_dir ARCH=arc olddefconfig prepare
...
cc1: fatal error: cannot open 'kernel/bounds.s' for writing: No such 
file or directory
compilation terminated.
make[3]: *** [../scripts/Makefile.build:121: kernel/bounds.s] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../Makefile:1191: prepare0] Error 2
make[2]: Target 'prepare' not remade because of errors.

Best Regards,
Rong Chen

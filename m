Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8451D334
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390042AbiEFIWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiEFIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:22:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB51164BD4
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651825103; x=1683361103;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Y9zLQtTXy0kZKf6yRCTG3Y8geAb6dG1MDrIKHxcp2nA=;
  b=KYD67PJP4VZD525EC3z7cSBo5+HaKUisSBV34SHBDMKWM1ebWzJaIYLJ
   iD4a3JcUE9YJTEBiiIIlnvbHk2ysWyKH3fgwzbsxXXdv4oYfuqe9h+90g
   f5rgVTWHq9xEmsvfO/kY9pRSgaWqM+dHIlo5QRKWPdHFi9BbmzbLRb/GD
   h2OTeLrFccvr49q5EGG9big4RgjVlgZ61DeFT7lQDkbmSDYQAACWGez+e
   JMdvxA14WoFa9QAmmfsi97iEwltZhv5yFn7qBHKGa+tPZSjzwAwsmGLwt
   MWUsqb3fLqavs8hmhgtph8f0jtfqPGk5/4wqj2Een9U8+tZujACu2gkfn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293598294"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293598294"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:18:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585850283"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.170.35]) ([10.249.170.35])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:18:21 -0700
Subject: Re: [kbuild-all] Re: ld.lld: error: inline assembly requires more
 registers than available at line 523
To:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     Leonardo Bras <leobras@redhat.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <202205020637.JVJo3blw-lkp@intel.com>
 <YnK8f7cqMoHxSi0C@dev-arch.thelio-3990X>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <01ecf3b7-570f-f36a-9555-25071ab5f336@intel.com>
Date:   Fri, 6 May 2022 16:18:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YnK8f7cqMoHxSi0C@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2022 1:48 AM, Nathan Chancellor wrote:
> On Mon, May 02, 2022 at 06:29:38AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
>> commit: ba1f77c546966c12d86220d078e5838dcaeab348 x86/kvm: Fix compilation warning in non-x86_64 builds
>> date:   2 months ago
>> config: i386-randconfig-a012-20220502 (https://download.01.org/0day-ci/archive/20220502/202205020637.JVJo3blw-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba1f77c546966c12d86220d078e5838dcaeab348
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout ba1f77c546966c12d86220d078e5838dcaeab348
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ld.lld: error: inline assembly requires more registers than available at line 523
>>>> ld.lld: error: inline assembly requires more registers than available at line 523
>>
> 
> I don't think this bisection result is correct; this error is visible at
> v5.17-rc3, which this commit is based on. This is likely the same root
> cause as https://github.com/ClangBuiltLinux/linux/issues/1589, just with
> LTO. I'll reduce something down and comment there if it turns out to be
> different.
> 
> Cheers,
> Nathan

Hi Nathan,

Thanks for your detailed explanation, we have added the error to the
ignore list.

Best Regards,
Rong Chen

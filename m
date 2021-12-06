Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30C2468F17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhLFC1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:27:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:64362 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhLFC1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:27:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="235969278"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="235969278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 18:24:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="656847120"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 18:24:08 -0800
Message-ID: <73788650-0c4d-f971-4c79-b048e500ea0b@intel.com>
Date:   Mon, 6 Dec 2021 10:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [kbuild-all] Re: lib/atomic64.c:82:5: warning: no previous
 prototype for 'generic_atomic64_and_return'
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <202111120712.RtQHZohY-lkp@intel.com>
 <YaDJWgwqdzNeCFLW@FVFF77S0Q05N>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <YaDJWgwqdzNeCFLW@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/21 19:47, Mark Rutland wrote:
> On Fri, Nov 12, 2021 at 07:08:19AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   debe436e77c72fcee804fb867f275e6d31aa999c
>> commit: 1bdadf46eff6804ace5fa46b6856da4799f12b5c locking/atomic: atomic64: support ARCH_ATOMIC
>> date:   6 months ago
>> config: arc-randconfig-r032-20211109 (attached as .config)
>> compiler: arc-elf-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bdadf46eff6804ace5fa46b6856da4799f12b5c
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 1bdadf46eff6804ace5fa46b6856da4799f12b5c
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>>> lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_and_return' [-Wmissing-prototypes]
>>>> lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_or_return' [-Wmissing-prototypes]
>>>> lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_xor_return' [-Wmissing-prototypes]
> Ah, there are not meant to be return forms of the and/or/xor operations, so
> we're pointlessly building code that cannot be used (but this is not otherwise
> harmful).
>
> That said, I think this is nothing to do with commit:
>
>    1bdadf46eff6804a ("locking/atomic: atomic64: support ARCH_ATOMIC")
>
> ... and is in fact a latent issue introduced by commit:
>
>    28aa2bda2211f432 ("locking/atomic: Implement atomic{,64,_long}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()")
>
> ... where we accidentally left the:
>
>     ATOMIC64_OP_RETURN(op, c_op)
>
> ... line for the and/or/xor atomics, even though that wasn't necessary.
>
> This is trivial to avoid, so I'll send a patch shortly.
>
> Thanks,
> Mark.

Hi Mark,

Thanks for the fix, the bot can't always find the first introduced 
commit with the bisection method.

Best Regards,
Rong Chen

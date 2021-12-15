Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863CF475089
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbhLOBfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:35:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:41751 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235037AbhLOBfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639532147; x=1671068147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+QA9nZoVKK9tU86uaXROVk8EVAkQF8qesT4jhASgX9c=;
  b=GwIpHNFCRmXkzdI0z8/St1oyIUTSJojermcKMrt0mc0IpXRlwU/Lzwjf
   s3GgKKqfZUp4zKgIMTesOo6ucswwbqqEKQcvAX1N0OplKWd4ElMZYqnFU
   /+rqcJFt8l53aei4H1clLDBtwUORsmxN/IGXw2gIWfCu782tB9uuVwYsY
   oukYhz7uqDvUrlV6gdJStT9kWNyYtdMtriXJrJBePeIbcfpJGM5uwPme1
   3MUUuAbt5rx8PiH+A/0Loa6yAu3I+2N7f0cfIOK0j1mCdHYbfZ9xh1ksW
   yBczeQeSYUmacgMrHYvvheDQP1CdWaSIkr8MK/caBJxEiZbJqNyZ+jZAO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="238933783"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="238933783"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:35:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518534384"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:35:45 -0800
Message-ID: <2af5f2f0-b2db-35e3-2d7a-7fa512db19af@intel.com>
Date:   Wed, 15 Dec 2021 09:35:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [kbuild-all] Re: [ebiederm-user-namespace:signal-for-v5.17 4/12]
 arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to
 next function show_opcodes()
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202112140949.Uq5sFKR1-lkp@intel.com>
 <87k0g7t7ry.fsf@email.froward.int.ebiederm.org>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <87k0g7t7ry.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 01:29, Eric W. Biederman wrote:
> kernel test robot <lkp@intel.com> writes:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
>> head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
>> commit: 0e25498f8cd43c1b5aa327f373dd094e9a006da7 [4/12] exit: Add and use make_task_dead.
>> config: x86_64-randconfig-a011-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140949.Uq5sFKR1-lkp@intel.com/config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>          git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
>>          git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
>>          git checkout 0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ kernel/ lib/kunit/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> lib/kunit/kunit-example-test.o: warning: objtool: .text.unlikely: unexpected end of section
>> --
>>>> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()
> I am confused.  This change patches objtool to rename
> rewind_stack_and_do_exit to rewind_stack_and_make_dead in the list
> global_noreturns in tools/objtool/check.c
>
> There is no other change to oops_end other than that renaming.
>
> Did the robot somehow mange to run an old version of objtool while
> building and this get this error?
>
> I tried and I am not currently able to reproduce this error.  Do you
> have any additional pointers on how I might reproduce this?

Hi Eric,

The reproduce step in report based on a full build, I can reproduce the 
warnings with the below command:

   make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

Best Regards,
Rong Chen

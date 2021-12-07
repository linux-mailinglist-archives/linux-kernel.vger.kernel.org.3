Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D546AF30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354303AbhLGAgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:36:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:2270 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350868AbhLGAf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:35:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298239394"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298239394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 16:32:30 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="657485608"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 16:32:28 -0800
Message-ID: <78e4a2b0-af5c-d13c-ef33-878f84555b36@intel.com>
Date:   Tue, 7 Dec 2021 08:32:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [kbuild-all] Re: [paulmck-rcu:dev.2021.12.02a 31/43]
 include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used
 in inline function 'pte_offset_kernel' which is not static
Content-Language: en-US
To:     Marco Elver <elver@google.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <202112041334.X44uWZXf-lkp@intel.com>
 <CANpmjNOpoYrgk85hsOroh67TqUPtawWCnbk1GwqdUnGEKrOP+w@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <CANpmjNOpoYrgk85hsOroh67TqUPtawWCnbk1GwqdUnGEKrOP+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/21 21:02, Marco Elver wrote:
> On Sat, 4 Dec 2021 at 06:33, kernel test robot <lkp@intel.com> wrote:
> [...]
>>>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
>>        70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
>>           |                              ^~~~~~~~~
>>     arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
>>       303 |         smp_rmb(); /* see above */
>>           |         ^~~~~~~
>>>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
>>        70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
>>           |                              ^~~~~~~~~
>>     arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
>>       293 |         smp_rmb(); /* see above */
>>           |         ^~~~~~~
> I had been wondering if barriers could be static __always_inline, like
> we do for atomic_t operations. Apparently this answers that questions.
>
> This should fix it:
> https://lkml.kernel.org/r/20211204125703.3344454-1-elver@google.com
>
> Unrelatedly, I wonder if I can get the test robot to also check some
> of my branches:

Hi Marco,

We have added it into our monitor list.

Best Regards,
Rong Chen

> https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/
> That'd be very useful, to catch things like this early, and avoid
> disturbing Paul too much. :-)
>
> Thanks,
> -- Marco


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832FC465AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344693AbhLBA3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:29:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:4072 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234755AbhLBA3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:29:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="217281586"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="217281586"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:26:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="512941021"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:26:23 -0800
Message-ID: <35c655d9-8a29-8141-69a7-1dab0f974a98@intel.com>
Date:   Thu, 2 Dec 2021 08:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format
 specifies type 'unsigned short' but the argument has type 'int'
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <202111261447.lxHTeAhi-lkp@intel.com>
 <CAD=FV=XZv1LuGm59vJDQKuwqO0zdFZQQthfct7Z_bPcdkm4UUQ@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <CAD=FV=XZv1LuGm59vJDQKuwqO0zdFZQQthfct7Z_bPcdkm4UUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/21 08:19, Doug Anderson wrote:
> <Beep> <Boop> <Bop> (translates as "Hello Mr. Robot"),
>
> On Thu, Nov 25, 2021 at 10:44 PM kernel test robot <lkp@intel.com> wrote:
>> Hi Douglas,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   a4849f6000e29235a2707f22e39da6b897bb9543
>> commit: c1ed18c11bdb80eced208a61d40b1988f36a014f HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core
>> date:   10 months ago
>> config: arm64-randconfig-r034-20211116 (https://download.01.org/0day-ci/archive/20211126/202111261447.lxHTeAhi-lkp@intel.com/config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm64 cross compiling tool for clang build
>>          # apt-get install binutils-aarch64-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1ed18c11bdb80eced208a61d40b1988f36a014f
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout c1ed18c11bdb80eced208a61d40b1988f36a014f
>>          # save the config file to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
>>                             le16_to_cpu(hdesc->bcdVersion));
>>                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
>>             _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>                                   ~~~     ^~~~~~~~~~~
>>     include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
>>     #define le16_to_cpu __le16_to_cpu
>>                         ^
>>     include/uapi/linux/byteorder/big_endian.h:36:26: note: expanded from macro '__le16_to_cpu'
>>     #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>>                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
>>             (__builtin_constant_p((__u16)(x)) ?     \
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> May I kindly point to the reply I gave to the same error last month
> when you mailed it out?
>
> https://lore.kernel.org/r/CAD=FV=WkUEkkkfGa+6QJSBvj8EgVrnGYYbd6RrC_5HdTue=mDw@mail.gmail.com/
>

Hi Doug,

Thanks for the feedback, we have added the warnings to our ignore list.

Best Regards,

Rong Chen


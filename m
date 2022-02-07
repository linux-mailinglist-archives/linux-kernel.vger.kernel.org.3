Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215144AC52B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385424AbiBGQPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443304AbiBGQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:07:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0BC0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=c66i+fvb+BntxE0hmNeI91Z4XSAdHTegp/Zffxoq4F0=; b=YEBZjURnVf7zB/KbNxXSxg5TVs
        Gzcj3upFPfG5fgcYA0eNQxffQtndfcH/4BC90yHdXNUFuhc78tyYvnW+ogKIivBs+ZcWHX7OJpqRI
        OBoqcAPmTCe69cNlC6TDbT+ioG4DyEktqu/MMiZviiSGazQZmN5fNzOMy3jX2085ASocaFdcHcifP
        9QnanEl5UksMG30Bof79L6cLZzjgxnbRxtyecOKLQfemw9Do0MC+3bxUp3TiVzKWM9ca7+anDa48y
        CI20WCcAPdr+snfSSXp1HfQp5PDVkNExCzRgbaNE9l4Nt6QSpj2vjE+3tS/hghrR0UsSBmSd8dBso
        fl+2MMeQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH6Xf-001QzH-Vb; Mon, 07 Feb 2022 16:07:04 +0000
Message-ID: <a141e090-7049-d693-1dc2-7c0a593b9682@infradead.org>
Date:   Mon, 7 Feb 2022 08:06:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ld.lld: error: undefined symbol: socfpga_reset_init
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
References: <202202050539.Mtk9I4Ef-lkp@intel.com>
 <67f432e2-1bfd-29dc-f2ed-051b47ef0844@kernel.org>
 <YgBtAdhl8dZVTAV+@dev-arch.archlinux-ax161>
 <8c315714-ea7b-d3ec-f131-6beded67b479@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8c315714-ea7b-d3ec-f131-6beded67b479@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/22 23:55, Krzysztof Kozlowski wrote:
> On 07/02/2022 01:51, Nathan Chancellor wrote:
>> Hi Krzysztof,
>>
>> On Sun, Feb 06, 2022 at 12:55:57PM +0100, Krzysztof Kozlowski wrote:
>>> On 04/02/2022 22:12, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   dcb85f85fa6f142aae1fe86f399d4503d49f2b60
>>>> commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
>>>> date:   11 months ago
>>>> config: arm-socfpga_defconfig (https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config)
>>>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
>>>> reproduce (this is a W=1 build):
>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         # install arm cross compiling tool for clang build
>>>>         # apt-get install binutils-arm-linux-gnueabi
>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4483397b03536506535d611b0cb28a81a69e8edf
>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>         git fetch --no-tags linus master
>>>>         git checkout 4483397b03536506535d611b0cb28a81a69e8edf
>>>>         # save the config file to linux build tree
>>>>         mkdir build_dir
>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> ld.lld: error: undefined symbol: socfpga_reset_init
>>>>    >>> referenced by socfpga.c
>>>>    >>>               socfpga.o:(socfpga_init_irq) in archive arch/arm/mach-socfpga/built-in.a
>>>>    >>> referenced by socfpga.c
>>>>    >>>               socfpga.o:(socfpga_arria10_init_irq) in archive arch/arm/mach-socfpga/built-in.a
>>>>
>>>
>>> This looks like a false positive. On the socfpga defconfig arm build,
>>> the socfpga_reset_init() (drivers/reset/reset-socfpga.c) is built.
>>>
>>> I also could not reproduce it with GCC.
>>
>> I can reproduce this error with the configuration that the bot provides
>> at both 4483397b03536506535d611b0cb28a81a69e8edf and v5.17-rc3, even
>> with GCC:
>>
>> $ curl -LSso .config https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config
>>
>> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- olddefconfig all
>> ...
>> arm-linux-gnueabi-ld: arch/arm/mach-socfpga/socfpga.o: in function `socfpga_init_irq':
>> socfpga.c:(.init.text+0x104): undefined reference to `socfpga_reset_init'
>> ...
>>
>> Whether or not this reproduces with the in-tree socfpga_defconfig, I am
>> not sure.
> 
> Thanks for checking - it seems I misread (and find it confusing...) the
> report - that it is socfpga defconfig. It clearly says "config:
> arm-socfpga_defconfig"...

Aha, I did the same thing and could not reproduce it. :(

> I can reproduce it with the config from the URL. I'll work on fix.

Thanks.

-- 
~Randy

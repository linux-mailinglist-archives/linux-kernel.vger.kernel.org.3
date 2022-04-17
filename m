Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496225049A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiDQVjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiDQVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:38:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E211A1901C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=rPTmCZvcSQL+3vYCd36QLzQTiYFQAiItxsUtQqNbrEc=; b=KcZ3HYLTJjS2uVK13+NOtjb1q2
        eMKZ5VEyktIvfZtYTgtZ+RnCIt+0mgLvHpx+ff1g0GXgtMTBBYqjk87qiN86Hl4mQhhlIRQhaB7ib
        5eKR22v288mt9EIRYRmZFojqsWjcsmFDMJS+AxdvTXZdzwbSahS7jhCdXMZr04/ld5Mg19TXvlrQ8
        JTgRYjVb0KizzOTLUPddaDBFGV4AHVl5Bwj1bMzwu+F0m6911+77jEgsaORKVZyW1sJ0Ys8lQOVxP
        oXz+F7tgHZE1UCtqi5l0apg+BVMhFTbpHenlngFsrln1IDfUAMBREnLPx7aG0uIN96+HD8wnoJA0K
        ITzirYEA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngCZ0-001bKq-2c; Sun, 17 Apr 2022 21:36:10 +0000
Message-ID: <b5223400-c27e-166a-54a7-f01516dbf68b@infradead.org>
Date:   Sun, 17 Apr 2022 14:36:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: drivers/cpuidle/cpuidle-riscv-sbi.c:350:5: warning: format
 specifies type 'long' but the argument has type 'int'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
References: <202204161152.YXsVu0jD-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202204161152.YXsVu0jD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/22 20:09, kernel test robot wrote:
> Hi Anup,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   59250f8a7f3a60a2661b84cbafc1e0eb5d05ec9b
> commit: 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b cpuidle: Add RISC-V SBI CPU idle driver
> date:   5 weeks ago
> config: riscv-randconfig-r026-20220416 (https://download.01.org/0day-ci/archive/20220416/202204161152.YXsVu0jD-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8e43cbab33765c476337571e5ed11b005199dd0d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6abf32f1d9c5009dcccded2c1e7ca899a4ab587b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/cpuidle/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Fixed here:

https://lore.kernel.org/linux-riscv/20220403031355.20894-1-rdunlap@infradead.org/

-- 
~Randy

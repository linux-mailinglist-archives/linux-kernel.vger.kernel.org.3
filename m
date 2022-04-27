Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6778510DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbiD0BOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351803AbiD0BOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:14:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA83B2AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uOT+x2iY2ocfNZPc9XusRQ7gNDx3Tqqo9Rlq06ataN0=; b=PkFW6C9U8NFA74klcG26w/r83Q
        xLQCTsHE16K6NKPC1qxOqB4D/OxhaK/WY2exdYRRF609sQGpWI8R0uypsm32eFsK2VxrgxMcY5kTH
        5iq+/BpwsrZ7/zeh1OnVavpzW3SRKoayQ91C9X5Im96DhGiBNUERd7ckdgCiCag92nIOtq68Ukh1m
        uLxN+f3+wJVFREmxogtxqWcPBcXl5cPvmXTYdw5IYXXuBWXU26WqqE6tLrKrT4zZZmBiZ2M9+qpM+
        Jnnzi1WaaOdw6q8wvHMP1IWTV5pwE4AFDEhr07mlVPvTmFiFeujqLLSPsfhEygEjgplRRlmxxnj2j
        edOb82fg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njWCa-00AAS5-0Z; Wed, 27 Apr 2022 01:10:44 +0000
Message-ID: <b35349a2-67c4-804a-7cff-5f0e55032e7c@infradead.org>
Date:   Tue, 26 Apr 2022 18:10:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: ERROR: start_text address is c000000000000200, should be
 c000000000000100
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202202061401.2RjuoIUu-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202202061401.2RjuoIUu-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/22 22:25, kernel test robot wrote:
> Hi Randy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
> commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
> date:   6 months ago
> config: powerpc64-randconfig-r004-20220206 (https://download.01.org/0day-ci/archive/20220206/202202061401.2RjuoIUu-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47c258d71ebfc832a760a1dc6540cf3c33968023
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 47c258d71ebfc832a760a1dc6540cf3c33968023
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: start_text address is c000000000000200, should be c000000000000100
>>> ERROR: try to enable LD_HEAD_STUB_CATCH config option
>>> ERROR: see comments in arch/powerpc/tools/head_check.sh

Hi bot,

Following those instructions (well, add enable CONFIG_EXPERT before
enable LD_HEAD_STUB_CATCH) fixes this build issue for me.

-- 
~Randy

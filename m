Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD23C510DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353119AbiD0BOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356659AbiD0BOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:14:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F22CCBB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=T6wG+w5R6bW6j7GpL3cmclafbSu6RK+Ar329Cui1A34=; b=ONlD4zDpaQ/nVe6lJIn4fKctVi
        O1ZlYTErjZsnXmNb3HUSpk4UsEi6z/V69hyqi/FtQ2ozfmgzRutRyqPiZ3Bqr7iDKabQSd/7U/GP5
        i0Eiu7EHy9vCygeWJlqqWueAtCoUF0S3MSe2rKAmYMo0y04kI0+wgQ5OcexQ8//K6dNqdrzLyoOEd
        L3hfLerJ4SwlMJLAIRxvgkgZ/ukH+FRn0dtS5DxaaHCBb7e0w2lFia8a/G12YpVge4Qyl2Hd9Tew3
        +O1cTDJeuAcRYjNQuPoPEvRbvQO0CsDmbv0iBw5Tlz8Jo27cmlP1xgNt1qdK/rbs9NAGxy07Tsigr
        A6+gxwmQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njWCs-00AASq-0D; Wed, 27 Apr 2022 01:11:02 +0000
Message-ID: <8d9c58af-b55c-8913-5758-347bcfe404e1@infradead.org>
Date:   Tue, 26 Apr 2022 18:10:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: ERROR: start_text address is c000000000000600, should be
 c000000000000100
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202202161525.m2QCBrwR-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202202161525.m2QCBrwR-lkp@intel.com>
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

Hi bot,

On 2/15/22 23:03, kernel test robot wrote:
> Hi Randy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c5d9ae265b105d9a67575fb67bd4650a6fc08e25
> commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
> date:   6 months ago
> config: powerpc64-randconfig-c004-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161525.m2QCBrwR-lkp@intel.com/config)
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
>>> ERROR: start_text address is c000000000000600, should be c000000000000100
>    ERROR: try to enable LD_HEAD_STUB_CATCH config option
>    ERROR: see comments in arch/powerpc/tools/head_check.sh

The .config file that is provided has
# CONFIG_MODULES is not set

FYI/FTR:

That seems to cause whatever goes before 'start_text' to be too large.
By converting lots of drivers & filesystems to be loadable modules (=m)
[with CONFIG_MODULES=y], this build error can be averted.

-- 
~Randy

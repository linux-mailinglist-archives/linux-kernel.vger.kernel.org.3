Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5A50D588
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiDXWJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiDXWJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:09:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01D5D1A1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 15:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5122B80E14
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FF6C385A7;
        Sun, 24 Apr 2022 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650837973;
        bh=QM2gPpFhJMCw8SzHnaGDe9e/YubdMcUEfk/0Dsh1MUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWqe6TXYTGEcuyVkpJpgLVerPLsZSOIWG3kwtsnmtRW5advkYeKQBIEiymO6bAbIg
         mNoqik26VUorYfwzG4XpQTQ9nNbHEmFHj4NZNgTm5fvAAw5u3U6ZTq/aSS6KSNyQm9
         9Qu4zO51AjeJLmQa8RwYqQViFaOBKlx9ACioFEwMNbuAFSReA61DQnKyHsKqXCY7l5
         31hNf7QOFE9wm7i4+iQ6ffQp4NLk6aOcxVm4p0ZrDv0tF4wKR+bm3yxZXeQFWmO4Q9
         F65DCU0T2q2DvcGrEF61EKMU9HI2WKB/fLPjvyCPyMPrfWIE6cDLnTGszSA34IvGV5
         32tTs07X5Q/Ww==
Date:   Sun, 24 Apr 2022 15:06:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, peterz@infradead.org,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] smp: replace smp_call_function_single_async()
 with  smp_call_private()
Message-ID: <YmXJ0q24kaxtG1R5@dev-arch.thelio-3990X>
References: <20220422200040.93813-6-dqiao@redhat.com>
 <202204231532.nXbSK9Tk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204231532.nXbSK9Tk-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 03:30:18PM +0800, kernel test robot wrote:
> Hi Donghai,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on rafael-pm/linux-next linus/master v5.18-rc3 next-20220422]
> [cannot apply to tip/x86/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220423/202204231532.nXbSK9Tk-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/3b8a90029bebdb77e2d5c0cd16f371e83d8ed2e8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
>         git checkout 3b8a90029bebdb77e2d5c0cd16f371e83d8ed2e8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> block/blk-mq.c:1065:39: warning: passing 4-byte aligned argument to 16-byte aligned parameter 2 of 'smp_call_private' may result in an unaligned pointer access [-Walign-mismatch]
>                    smp_call_function_single_async(cpu, &rq->csd);
>                                                        ^
>    1 warning generated.

This warning was fixed by commit 1139aeb1c521 ("smp: Fix
smp_call_function_single_async prototype"), which is undone by this
proposed change, hence the warning.

Cheers,
Nathan

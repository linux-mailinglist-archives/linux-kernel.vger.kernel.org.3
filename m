Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3E579784
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiGSKTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiGSKTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:19:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BB2A977
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:19:46 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26JAJSAs096748;
        Tue, 19 Jul 2022 19:19:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Tue, 19 Jul 2022 19:19:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26JAJS5D096744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jul 2022 19:19:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b7512db9-e3bc-7a88-d7e3-86110e63215c@I-love.SAKURA.ne.jp>
Date:   Tue, 19 Jul 2022 19:19:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: arch/arm/include/asm/system_misc.h:29:9: error: implicit
 declaration of function 'preempt_enable_no_resched_notrace'; did you mean
 'preempt_enable_notrace'?
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <202207170947.p1AZIs0b-lkp@intel.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202207170947.p1AZIs0b-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 502825282e6f79c9 ("ftrace: add preempt_enable/disable notrace macros")
introduced preempt_enable_no_resched_notrace(), but kernel test robot says that
preempt_enable_no_resched_notrace() is conditionally defined. Why conditionally?

On 2022/07/17 11:04, kernel test robot wrote:
> tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220717-000210/Tetsuo-Handa/ARM-spectre-v2-fix-smp_processor_id-warning/20220622-145116
> head:   7c8920bd674d371b04dc1ee0e0c6b8af89e55987
> commit: 7c8920bd674d371b04dc1ee0e0c6b8af89e55987 ARM: spectre-v2: fix smp_processor_id() warning
> date:   10 hours ago
> config: arm-omap2plus_defconfig (https://download.01.org/0day-ci/archive/20220717/202207170947.p1AZIs0b-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/7c8920bd674d371b04dc1ee0e0c6b8af89e55987
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review UPDATE-20220717-000210/Tetsuo-Handa/ARM-spectre-v2-fix-smp_processor_id-warning/20220622-145116
>         git checkout 7c8920bd674d371b04dc1ee0e0c6b8af89e55987
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/ti/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/soc/ti/pm33xx.c:33:
>    arch/arm/include/asm/system_misc.h: In function 'harden_branch_predictor':
>>> arch/arm/include/asm/system_misc.h:29:9: error: implicit declaration of function 'preempt_enable_no_resched_notrace'; did you mean 'preempt_enable_notrace'? [-Werror=implicit-function-declaration]
>       29 |         preempt_enable_no_resched_notrace();
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |         preempt_enable_notrace
>    cc1: some warnings being treated as errors
> 
> 
> vim +29 arch/arm/include/asm/system_misc.h
> 
>     17	
>     18	#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>     19	typedef void (*harden_branch_predictor_fn_t)(void);
>     20	DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
>     21	static inline void harden_branch_predictor(void)
>     22	{
>     23		harden_branch_predictor_fn_t fn;
>     24	
>     25		preempt_disable_notrace();
>     26		fn = per_cpu(harden_branch_predictor_fn, raw_smp_processor_id());
>     27		if (fn)
>     28			fn();
>   > 29		preempt_enable_no_resched_notrace();
>     30	}
>     31	#else
>     32	#define harden_branch_predictor() do { } while (0)
>     33	#endif
>     34	
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE85B2CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIIDOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiIIDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:13:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41B7B12168D;
        Thu,  8 Sep 2022 20:11:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAA24153B;
        Thu,  8 Sep 2022 20:11:43 -0700 (PDT)
Received: from [10.162.41.8] (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298F03F71A;
        Thu,  8 Sep 2022 20:11:32 -0700 (PDT)
Message-ID: <d964d645-479c-4e71-75eb-7b88f18d45c8@arm.com>
Date:   Fri, 9 Sep 2022 08:41:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     kbuild-all@lists.01.org, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220908051046.465307-4-anshuman.khandual@arm.com>
 <202209082022.6BPdyQn8-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202209082022.6BPdyQn8-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/22 18:02, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on acme/perf/core]
> [also build test WARNING on tip/perf/core arm64/for-next/core linus/master v6.0-rc4 next-20220908]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> config: arm-defconfig
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/d3c4ba711027d312a2f4e16cdbdbec5fcbf2913b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
>         git checkout d3c4ba711027d312a2f4e16cdbdbec5fcbf2913b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/perf/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/perf/arm_pmu.c: In function 'validate_group':
>>> drivers/perf/arm_pmu.c:415:1: warning: the frame size of 1744 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      415 | }
>          | ^

Guess this might just be complaining because of the local variable 'fake_pmu'
as 'struct pmu_hw_events' now has been expanded to accommodate BRBE related
elements. But these are essential elements for BRBE branch record processing.

static int
validate_group(struct perf_event *event)
{
        struct perf_event *sibling, *leader = event->group_leader;
        struct pmu_hw_events fake_pmu;
....

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1B54A3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbiFNBgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiFNBgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:36:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4682D33A25;
        Mon, 13 Jun 2022 18:36:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7AD323A;
        Mon, 13 Jun 2022 18:36:43 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFDAD3F792;
        Mon, 13 Jun 2022 18:36:38 -0700 (PDT)
Message-ID: <7df0ca46-1ece-2f51-a7a7-a0129724e6bc@arm.com>
Date:   Tue, 14 Jun 2022 07:06:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/8] perf: Consolidate branch sample filter helpers
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <20220613100119.684673-2-anshuman.khandual@arm.com>
 <202206140422.ttLxMHtq-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202206140422.ttLxMHtq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/22 02:02, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on acme/perf/core]
> [cannot apply to arm64/for-next/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220613-180501
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git f0fe9f3c7abcc946a676dfb295478c50312523c2
> config: x86_64-randconfig-a002-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140422.ttLxMHtq-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/1bd23b8ca1fc92f2f5b28a94ebd95432febfe96c
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220613-180501
>         git checkout 1bd23b8ca1fc92f2f5b28a94ebd95432febfe96c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/acpi/acpi_pad.c:20:
>>> include/linux/perf_event.h:1708:42: error: use of undeclared identifier 'PERF_SAMPLE_BRANCH_PRIV_SAVE'; did you mean 'PERF_SAMPLE_BRANCH_TYPE_SAVE'?
>            return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
>                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                    PERF_SAMPLE_BRANCH_TYPE_SAVE
>    include/uapi/linux/perf_event.h:231:2: note: 'PERF_SAMPLE_BRANCH_TYPE_SAVE' declared here
>            PERF_SAMPLE_BRANCH_TYPE_SAVE    =
>            ^
>    1 error generated.

This series is dependent on another one which adds symbol PERF_SAMPLE_BRANCH_TYPE_SAVE
as mentioned in the cover letter. I understand the '--base' argument for git format-patch
output, but how to mention another prerequisite series before this can be built tested ?

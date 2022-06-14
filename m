Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2B54AF20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354090AbiFNLNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiFNLNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:13:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6355D1EC4F;
        Tue, 14 Jun 2022 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655205198; x=1686741198;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PkAwYlIH+LhC0yR/XXtEdoYqPZCdO4H6sUEzr+OM2pM=;
  b=dwil8hW0o5C5StvUZV/q5/uEXxxzNm5KM5csMZ/MMQ5NYoT1i3azP/Ew
   L7FUsqqpZ0BqVpSWSfOrTudBoBR0RvOtFYAoNn0VPnRoZinUVKaNp8K9g
   T2OEgCfuEKBIuvIb7FyFm08hFyZsi6Wnj1JQyNLD/pYNItNGkiZtw+pjr
   vOBRV839FrXa7jgndv/CJ48aAePgRGxT72zt6y4PniPozRX1+VTdpZmUc
   xHWFL4AVq+gYtCmcIviOlQBxPLjPOUIR7qkIhLmvHPbffYAGAOtUXsd5+
   /WwCHO7sG1kRyuiDD4mLWHbMrvYwDG+tOro7RB56Y/g0Hfv+2/qIPpRrY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258421930"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="258421930"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 04:13:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830358971"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.34]) ([10.255.28.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 04:13:12 -0700
Subject: Re: [kbuild-all] Re: [PATCH 1/8] perf: Consolidate branch sample
 filter helpers
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <20220613100119.684673-2-anshuman.khandual@arm.com>
 <202206140422.ttLxMHtq-lkp@intel.com>
 <7df0ca46-1ece-2f51-a7a7-a0129724e6bc@arm.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <e4cadb9a-2363-f446-0fce-1242e84396bc@intel.com>
Date:   Tue, 14 Jun 2022 19:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7df0ca46-1ece-2f51-a7a7-a0129724e6bc@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2022 9:36 AM, Anshuman Khandual wrote:
> 
> On 6/14/22 02:02, kernel test robot wrote:
>> Hi Anshuman,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on tip/perf/core]
>> [also build test ERROR on acme/perf/core]
>> [cannot apply to arm64/for-next/core]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220613-180501
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git f0fe9f3c7abcc946a676dfb295478c50312523c2
>> config: x86_64-randconfig-a002-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140422.ttLxMHtq-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/intel-lab-lkp/linux/commit/1bd23b8ca1fc92f2f5b28a94ebd95432febfe96c
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220613-180501
>>          git checkout 1bd23b8ca1fc92f2f5b28a94ebd95432febfe96c
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from drivers/acpi/acpi_pad.c:20:
>>>> include/linux/perf_event.h:1708:42: error: use of undeclared identifier 'PERF_SAMPLE_BRANCH_PRIV_SAVE'; did you mean 'PERF_SAMPLE_BRANCH_TYPE_SAVE'?
>>             return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
>>                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                                                     PERF_SAMPLE_BRANCH_TYPE_SAVE
>>     include/uapi/linux/perf_event.h:231:2: note: 'PERF_SAMPLE_BRANCH_TYPE_SAVE' declared here
>>             PERF_SAMPLE_BRANCH_TYPE_SAVE    =
>>             ^
>>     1 error generated.
> 
> This series is dependent on another one which adds symbol PERF_SAMPLE_BRANCH_TYPE_SAVE
> as mentioned in the cover letter. I understand the '--base' argument for git format-patch
> output, but how to mention another prerequisite series before this can be built tested ?

Hi Anshuman,

git format-patch supports to set prerequisite-patch-id, kernel test robot
can parse the information and apply patch to a proper branch to test.

    https://git-scm.com/docs/git-format-patch#_base_tree_information

Best Regards,
Rong Chen

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1843154A0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351543AbiFMVAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351504AbiFMU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:57:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A8BCB9;
        Mon, 13 Jun 2022 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655152384; x=1686688384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V8qgBoWN/fG+xJHX0cluoEtpiNIPFeWPspFIuQ5rZO0=;
  b=QPZq7L5/0ekDKRX7DohsY0SRSrtkdsOtRgxVOrkZxvyjIv3zthgA4ioW
   HJebky0MEudVtYCRAgteWMpm558rV75+fwQZFFJR3vR5Br1yxwwMlyf/A
   n2Fpnd1Cxsp6Br1PDg45nTgKLshK16RhybJxlA+O4hGeMU6GlQA7G3szk
   ZAa1xQlgg+JEZp7U+VFtOqAg6tjI0A4OLbR2Chku1jDAK7AjXEN3N5L/c
   QzloV6oIl8WAZeQDMbh4GJrbic+1ERCAveuWX29w0/IEgz21F6B5Nj37D
   OmUoOiBYV9rVvNBa5XY0DPoPN1pBkdfz+aQNlekuIIjV97CoNVPpmPw+I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364734057"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="364734057"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 13:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="569223227"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2022 13:33:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0qk7-000L7P-EQ;
        Mon, 13 Jun 2022 20:32:59 +0000
Date:   Tue, 14 Jun 2022 04:32:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/8] perf: Consolidate branch sample filter helpers
Message-ID: <202206140422.ttLxMHtq-lkp@intel.com>
References: <20220613100119.684673-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613100119.684673-2-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on acme/perf/core]
[cannot apply to arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220613-180501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git f0fe9f3c7abcc946a676dfb295478c50312523c2
config: x86_64-randconfig-a002-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140422.ttLxMHtq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1bd23b8ca1fc92f2f5b28a94ebd95432febfe96c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220613-180501
        git checkout 1bd23b8ca1fc92f2f5b28a94ebd95432febfe96c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/acpi/acpi_pad.c:20:
>> include/linux/perf_event.h:1708:42: error: use of undeclared identifier 'PERF_SAMPLE_BRANCH_PRIV_SAVE'; did you mean 'PERF_SAMPLE_BRANCH_TYPE_SAVE'?
           return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                   PERF_SAMPLE_BRANCH_TYPE_SAVE
   include/uapi/linux/perf_event.h:231:2: note: 'PERF_SAMPLE_BRANCH_TYPE_SAVE' declared here
           PERF_SAMPLE_BRANCH_TYPE_SAVE    =
           ^
   1 error generated.
--
   In file included from drivers/acpi/processor_idle.c:24:
>> include/linux/perf_event.h:1708:42: error: use of undeclared identifier 'PERF_SAMPLE_BRANCH_PRIV_SAVE'; did you mean 'PERF_SAMPLE_BRANCH_TYPE_SAVE'?
           return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                   PERF_SAMPLE_BRANCH_TYPE_SAVE
   include/uapi/linux/perf_event.h:231:2: note: 'PERF_SAMPLE_BRANCH_TYPE_SAVE' declared here
           PERF_SAMPLE_BRANCH_TYPE_SAVE    =
           ^
   drivers/acpi/processor_idle.c:1083:12: warning: no previous prototype for function 'acpi_processor_ffh_lpi_probe' [-Wmissing-prototypes]
   int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
              ^
   drivers/acpi/processor_idle.c:1083:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
   ^
   static 
   drivers/acpi/processor_idle.c:1152:12: warning: no previous prototype for function 'acpi_processor_ffh_lpi_enter' [-Wmissing-prototypes]
   int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
              ^
   drivers/acpi/processor_idle.c:1152:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
   ^
   static 
   2 warnings and 1 error generated.


vim +1708 include/linux/perf_event.h

  1705	
  1706	static inline bool branch_sample_priv(const struct perf_event *event)
  1707	{
> 1708		return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223C58A444
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 02:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiHEAl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 20:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiHEAl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 20:41:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636196FA20;
        Thu,  4 Aug 2022 17:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659660115; x=1691196115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/VEyLkxeq77TQnF1fntRymq2bZdRxvN59tAQlnS5Qdg=;
  b=fh+3hx0sPvwJMqK4qBnA1SssG8GqmdFFanDeJXXRt3D/fm4gNQTdQAAA
   g46iXw89gz5RDqsoVKzHln8pJb4f5rrzQ+mh3k0vMGnDb1m0oU5bKW6Hs
   3rOF7drNcUVm5hBqzMHg8ldYFPOVnFG6jKQ99RyiIGSWA5DQn1NjckU3j
   AmEjq2A5M87TZM3dsNIgjJbS4e3yLqBES6w7pxEak0H8jtctSO6+AivAF
   Mc+z0WgdKJAcov6CZhRTaKfk/crRm2otqbDTWSWpORLRiiWHdp5D9BOK8
   AOVD3pOOdu4bIZ27qR9Z4RECa1Heq05e/a9tU4rmpWzlI91g3bLdFrg3q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287650913"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287650913"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 17:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636308499"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2022 17:41:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJlPT-000IzX-0I;
        Fri, 05 Aug 2022 00:41:51 +0000
Date:   Fri, 5 Aug 2022 08:41:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        yangjihong1@huawei.com
Subject: Re: [PATCH] perf/core: Fix syzkaller reported issue "Internal error
 in read_pmevcntrn"
Message-ID: <202208050845.V2B12mSf-lkp@intel.com>
References: <20220804105918.113833-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804105918.113833-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on linus/master v5.19 next-20220804]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Jihong/perf-core-Fix-syzkaller-reported-issue-Internal-error-in-read_pmevcntrn/20220804-190347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5
config: arm-randconfig-r004-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050845.V2B12mSf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/9c758a8d3d13d1ac89f651850b79d91b23b41b02
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yang-Jihong/perf-core-Fix-syzkaller-reported-issue-Internal-error-in-read_pmevcntrn/20220804-190347
        git checkout 9c758a8d3d13d1ac89f651850b79d91b23b41b02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/events/core.c:6942:20: error: use of undeclared identifier 'flags'
           local_irq_restore(flags);
                             ^
>> kernel/events/core.c:6942:20: error: use of undeclared identifier 'flags'
   2 errors generated.


vim +/flags +6942 kernel/events/core.c

  6896	
  6897	static void perf_output_read_group(struct perf_output_handle *handle,
  6898				    struct perf_event *event,
  6899				    u64 enabled, u64 running)
  6900	{
  6901		struct perf_event *leader = event->group_leader, *sub;
  6902		u64 read_format = event->attr.read_format;
  6903		u64 values[6];
  6904		int n = 0;
  6905	
  6906		values[n++] = 1 + leader->nr_siblings;
  6907	
  6908		if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
  6909			values[n++] = enabled;
  6910	
  6911		if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
  6912			values[n++] = running;
  6913	
  6914		if ((leader != event) &&
  6915		    (leader->state == PERF_EVENT_STATE_ACTIVE))
  6916			leader->pmu->read(leader);
  6917	
  6918		values[n++] = perf_event_count(leader);
  6919		if (read_format & PERF_FORMAT_ID)
  6920			values[n++] = primary_event_id(leader);
  6921		if (read_format & PERF_FORMAT_LOST)
  6922			values[n++] = atomic64_read(&leader->lost_samples);
  6923	
  6924		__output_copy(handle, values, n * sizeof(u64));
  6925	
  6926		for_each_sibling_event(sub, leader) {
  6927			n = 0;
  6928	
  6929			if ((sub != event) &&
  6930			    (sub->state == PERF_EVENT_STATE_ACTIVE))
  6931				sub->pmu->read(sub);
  6932	
  6933			values[n++] = perf_event_count(sub);
  6934			if (read_format & PERF_FORMAT_ID)
  6935				values[n++] = primary_event_id(sub);
  6936			if (read_format & PERF_FORMAT_LOST)
  6937				values[n++] = atomic64_read(&sub->lost_samples);
  6938	
  6939			__output_copy(handle, values, n * sizeof(u64));
  6940		}
  6941	
> 6942		local_irq_restore(flags);
  6943	}
  6944	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

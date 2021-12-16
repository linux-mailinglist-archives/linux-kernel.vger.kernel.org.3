Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4C476C42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhLPIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:55:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:55284 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhLPIzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639644904; x=1671180904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wzwBpV7OlQLWz0V1iQuNEaldUK64ztj7NgFIJWRBpug=;
  b=mCpIBpDAHL2SEp0kDitFbNcw0HszhV9t8ta4EoMWI8OMXiuVvE+du0vR
   z9thh3xxGNef8NNmMifoTWZJ95jmAQFdEfFulFoD685l9IZDq2ezAqFtw
   iAsfOPbgXQvdiXYFeelnpJn46/jYachkA3jE+sAADexTG4po60Rtg/3tE
   We8L7IxX/IU1ofjk2rn6bk8AAncmceL8AIYd/OjQWFqMmQxnPilHkZ4pI
   hCtXejclstpZnVF4S/grLz5iBwRzDzQVkuBYmsmASl2ZbzwywVfmI8IVq
   rlCCNND8avI/+blzSAfT5oECKXyrrv7jiqGiuxY22hg6qNEuT05eiaovo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236980364"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="236980364"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 00:54:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="755799681"
Received: from unknown (HELO [10.239.159.175]) ([10.239.159.175])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 00:54:56 -0800
Message-ID: <bb691703-5f88-081e-9ac5-edd969343ead@intel.com>
Date:   Thu, 16 Dec 2021 16:54:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 4/4] coresight: etm3x: Don't trace PID for non-root PID
 namespace
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, kernel test robot <lkp@intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org
References: <20211213121323.1887180-5-leo.yan@linaro.org>
 <202112140344.viPmOWp6-lkp@intel.com>
 <20211214044628.GB1884193@leoy-ThinkPad-X240s>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <20211214044628.GB1884193@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/21 12:46, Leo Yan wrote:
> Hi,
>
> On Tue, Dec 14, 2021 at 03:16:42AM +0800, kernel test robot wrote:
>> Hi Leo,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v5.16-rc5]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2585cf9dfaaddf00b069673f27bb3f8530e2039c
>> config: arm-buildonly-randconfig-r003-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140344.viPmOWp6-lkp@intel.com/config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm cross compiling tool for clang build
>>          # apt-get install binutils-arm-linux-gnueabi
>>          # https://github.com/0day-ci/linux/commit/81d5f47788c40d34c8159d64d4505eb485254e8f
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
>>          git checkout 81d5f47788c40d34c8159d64d4505eb485254e8f
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/hwtracing/coresight/coresight-etm3x-core.c:344:7: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
>>             if (!task_is_in_init_pid_ns(current))
>>                  ^
>>     1 error generated.
>>
>>
>> vim +/task_is_in_init_pid_ns +344 drivers/hwtracing/coresight/coresight-etm3x-core.c
>>
>>     301	
>>     302	#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | \
>>     303					 ETMCR_TIMESTAMP_EN | \
>>     304					 ETMCR_RETURN_STACK)
>>     305	
>>     306	static int etm_parse_event_config(struct etm_drvdata *drvdata,
>>     307					  struct perf_event *event)
>>     308	{
>>     309		struct etm_config *config = &drvdata->config;
>>     310		struct perf_event_attr *attr = &event->attr;
>>     311	
>>     312		if (!attr)
>>     313			return -EINVAL;
>>     314	
>>     315		/* Clear configuration from previous run */
>>     316		memset(config, 0, sizeof(struct etm_config));
>>     317	
>>     318		if (attr->exclude_kernel)
>>     319			config->mode = ETM_MODE_EXCL_KERN;
>>     320	
>>     321		if (attr->exclude_user)
>>     322			config->mode = ETM_MODE_EXCL_USER;
>>     323	
>>     324		/* Always start from the default config */
>>     325		etm_set_default(config);
>>     326	
>>     327		/*
>>     328		 * By default the tracers are configured to trace the whole address
>>     329		 * range.  Narrow the field only if requested by user space.
>>     330		 */
>>     331		if (config->mode)
>>     332			etm_config_trace_mode(config);
>>     333	
>>     334		/*
>>     335		 * At this time only cycle accurate, return stack  and timestamp
>>     336		 * options are available.
>>     337		 */
>>     338		if (attr->config & ~ETM3X_SUPPORTED_OPTIONS)
>>     339			return -EINVAL;
>>     340	
>>     341		config->ctrl = attr->config;
>>     342	
>>     343		/* Don't trace contextID when runs in non-root PID namespace */
>>   > 344		if (!task_is_in_init_pid_ns(current))
> This patchset is based on another patchset [1], as described on the
> cover letter patch.  This is why here reports for building failure.
>
> To avoid the false positive reporting, if any better practice I can
> follow up to resolve the dependency between two patchsets, please let
> me know and I will do in next time.

Hi Leo,

Sorry for the inconvenience, the bot doesn't support to parse the link 
in cover letter yet,
we suggest to use '--base' as documented 
inhttps://git-scm.com/docs/git-format-patch

Best Regards,
Rong CHen

>
> Thanks,
> Leo
>
> [1] https://lore.kernel.org/lkml/20211208083320.472503-1-leo.yan@linaro.org/
>
>>     345			config->ctrl &= ~ETMCR_CTXID_SIZE;
>>     346	
>>     347		/*
>>     348		 * Possible to have cores with PTM (supports ret stack) and ETM
>>     349		 * (never has ret stack) on the same SoC. So if we have a request
>>     350		 * for return stack that can't be honoured on this core then
>>     351		 * clear the bit - trace will still continue normally
>>     352		 */
>>     353		if ((config->ctrl & ETMCR_RETURN_STACK) &&
>>     354		    !(drvdata->etmccer & ETMCCER_RETSTACK))
>>     355			config->ctrl &= ~ETMCR_RETURN_STACK;
>>     356	
>>     357		return 0;
>>     358	}
>>     359	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


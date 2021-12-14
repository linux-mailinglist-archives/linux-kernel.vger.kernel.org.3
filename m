Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAC473C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhLNEqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLNEqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:46:36 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37277C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 20:46:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so12719967plx.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 20:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eDWxnzvCmzrzAprZHasD1ozU4OVidLGPGD2BiUAz8d8=;
        b=YqGcQJz6CqIDBwpk4gkCtmXJDoi9i7ZQ0vcyjJfLVvkA8MOQky4ap5Tcly/VW2+sqy
         a5BhEAxfxjG0QoYeMKcORdQkjnMg7IifmA/3xKVce+SsfVmNTAAQr7G1UkRrnpd6yoqd
         FiadgYej94k+RaBd5vt/t5eT4DMZacLRXtEfID+7mlZp71AwYjuPDX8q4/pcRCd9d3fR
         K3tQrei+J1/YZGqH6jcF+quE86vmUxtEnTQgNkXQZYIto8o06lc9dCAqKuCzWbP0MldS
         1wzRUcgmIFudZ8P6p7BApdvvWbzMpQXVo1gdAJVOc4HpBhg9geCpgmnmJiTIPYbt7MNf
         O1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDWxnzvCmzrzAprZHasD1ozU4OVidLGPGD2BiUAz8d8=;
        b=tqsxY65nzuNUIZJoiC4D+sNpsW9i0fWQ5rpkruH+aSnZdlQHS8UgiBjsB1PEkWEOG4
         YGfajnh874UH7a+pP8kbnymN10p2Vo0HfeJzvvWSSN2mQKmzD1aheWT/aJqxDO5diTy/
         sU6eIudVViagLCXepb1PCgDb7DPgsoXsQXtxLQ0JPnwagPASvd0cTCD2AfD2ZhUHJ/mH
         f0BmpCq3l6Iiqi4DFeFZII0LHpH+xj+hb05cgtfmmM7cph0CdQvmDnoIC6mOF0bq5oNs
         X7Ss2/uvsWb+OE0++9ShLk6hI7qlmO94l7VMviCkiKYvQ7mtFIw3Dxn7qobcjAyuAcsn
         I3uQ==
X-Gm-Message-State: AOAM5306fnIxjkm57MFnIJyLXsU70omwGQoftBNrCIp8yT+cVQDCuu/R
        ofzx0hZTDhNQhzHOAlZ6NCXlkg==
X-Google-Smtp-Source: ABdhPJzk5JAJM+Hd05z4l0QSn+h8QuOsiGk7Zrck5Jvj2mk0n0Z3WfnW01eDSjbRA8yoAe3pqclASw==
X-Received: by 2002:a17:90b:4b48:: with SMTP id mi8mr3063403pjb.214.1639457195457;
        Mon, 13 Dec 2021 20:46:35 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id a9sm7972769pgl.26.2021.12.13.20.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:46:35 -0800 (PST)
Date:   Tue, 14 Dec 2021 12:46:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org
Subject: Re: [PATCH v2 4/4] coresight: etm3x: Don't trace PID for non-root
 PID namespace
Message-ID: <20211214044628.GB1884193@leoy-ThinkPad-X240s>
References: <20211213121323.1887180-5-leo.yan@linaro.org>
 <202112140344.viPmOWp6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112140344.viPmOWp6-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 14, 2021 at 03:16:42AM +0800, kernel test robot wrote:
> Hi Leo,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.16-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2585cf9dfaaddf00b069673f27bb3f8530e2039c
> config: arm-buildonly-randconfig-r003-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140344.viPmOWp6-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/0day-ci/linux/commit/81d5f47788c40d34c8159d64d4505eb485254e8f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
>         git checkout 81d5f47788c40d34c8159d64d4505eb485254e8f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/hwtracing/coresight/coresight-etm3x-core.c:344:7: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
>            if (!task_is_in_init_pid_ns(current))
>                 ^
>    1 error generated.
> 
> 
> vim +/task_is_in_init_pid_ns +344 drivers/hwtracing/coresight/coresight-etm3x-core.c
> 
>    301	
>    302	#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | \
>    303					 ETMCR_TIMESTAMP_EN | \
>    304					 ETMCR_RETURN_STACK)
>    305	
>    306	static int etm_parse_event_config(struct etm_drvdata *drvdata,
>    307					  struct perf_event *event)
>    308	{
>    309		struct etm_config *config = &drvdata->config;
>    310		struct perf_event_attr *attr = &event->attr;
>    311	
>    312		if (!attr)
>    313			return -EINVAL;
>    314	
>    315		/* Clear configuration from previous run */
>    316		memset(config, 0, sizeof(struct etm_config));
>    317	
>    318		if (attr->exclude_kernel)
>    319			config->mode = ETM_MODE_EXCL_KERN;
>    320	
>    321		if (attr->exclude_user)
>    322			config->mode = ETM_MODE_EXCL_USER;
>    323	
>    324		/* Always start from the default config */
>    325		etm_set_default(config);
>    326	
>    327		/*
>    328		 * By default the tracers are configured to trace the whole address
>    329		 * range.  Narrow the field only if requested by user space.
>    330		 */
>    331		if (config->mode)
>    332			etm_config_trace_mode(config);
>    333	
>    334		/*
>    335		 * At this time only cycle accurate, return stack  and timestamp
>    336		 * options are available.
>    337		 */
>    338		if (attr->config & ~ETM3X_SUPPORTED_OPTIONS)
>    339			return -EINVAL;
>    340	
>    341		config->ctrl = attr->config;
>    342	
>    343		/* Don't trace contextID when runs in non-root PID namespace */
>  > 344		if (!task_is_in_init_pid_ns(current))

This patchset is based on another patchset [1], as described on the
cover letter patch.  This is why here reports for building failure.

To avoid the false positive reporting, if any better practice I can
follow up to resolve the dependency between two patchsets, please let
me know and I will do in next time.

Thanks,
Leo

[1] https://lore.kernel.org/lkml/20211208083320.472503-1-leo.yan@linaro.org/

>    345			config->ctrl &= ~ETMCR_CTXID_SIZE;
>    346	
>    347		/*
>    348		 * Possible to have cores with PTM (supports ret stack) and ETM
>    349		 * (never has ret stack) on the same SoC. So if we have a request
>    350		 * for return stack that can't be honoured on this core then
>    351		 * clear the bit - trace will still continue normally
>    352		 */
>    353		if ((config->ctrl & ETMCR_RETURN_STACK) &&
>    354		    !(drvdata->etmccer & ETMCCER_RETSTACK))
>    355			config->ctrl &= ~ETMCR_RETURN_STACK;
>    356	
>    357		return 0;
>    358	}
>    359	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4F48D03F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiAMBtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:49:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:9581 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231452AbiAMBta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642038570; x=1673574570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IGcBXmDavEDF4tJbBG6LgESiku0mGLX28XESGtQ8168=;
  b=kPmWbtH1ZfcXoJd+djTF5pjXFdiFdhmmvVtqWCO3SKu+C1w+HqyZaS2G
   fDp4cBdDldE7sYQWscyEfZQeGk+2/XVnNNErxLYeYxLdSa6HXpUk6KMfi
   83n6/nihZeihjKMILP+BniCaJqppD3/UajDy+XCksgQzWEJkUfSAbjNQD
   UuW2LzQEpjAsEZ+Inu4caG3Y849M9PEPPJkewbwyCCghO6tc4M5lcX3AW
   PvonNNHKTukepmqnNNELBkLwy3f6YgbQuE4t0QcjnYlxeiXe4hGoxXiUs
   F3KAQ+6sAv1C9ta+LHcDYdmF/XWPfZa5Hj74MYJ2HJMosXdPr7dqMYY9t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330253500"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="330253500"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="593201335"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2022 17:49:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7pF1-0006hE-Be; Thu, 13 Jan 2022 01:49:27 +0000
Date:   Thu, 13 Jan 2022 09:49:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Jianchao <jianchao.wan9@gmail.com>, axboe@kernel.dk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jbacik@fb.com,
        tj@kernel.org, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] blk: make blk-rq-qos support pluggable and modular
 policy
Message-ID: <202201130903.7ZvBIOs4-lkp@intel.com>
References: <20220110091046.17010-2-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110091046.17010-2-jianchao.wan9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on v5.16]
[cannot apply to axboe-block/for-next next-20220112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wang-Jianchao/blk-make-blk-rq-qos-policies-pluggable-and-modular/20220110-171347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
config: arm-randconfig-r006-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130903.7ZvBIOs4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/8bef9fba59d8d47ecaebbeff3e62ee550d89b017
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wang-Jianchao/blk-make-blk-rq-qos-policies-pluggable-and-modular/20220110-171347
        git checkout 8bef9fba59d8d47ecaebbeff3e62ee550d89b017
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/blk-iocost.c:1244:6: warning: variable 'last_period' set but not used [-Wunused-but-set-variable]
           u64 last_period, cur_period;
               ^
>> block/blk-iocost.c:3348:7: warning: variable 'ioc' is uninitialized when used here [-Wuninitialized]
           if (!ioc) {
                ^~~
   block/blk-iocost.c:3337:17: note: initialize the variable 'ioc' to silence this warning
           struct ioc *ioc;
                          ^
                           = NULL
   2 warnings generated.


vim +/ioc +3348 block/blk-iocost.c

7caa47151ab2e64 Tejun Heo         2019-08-28  3331  
7caa47151ab2e64 Tejun Heo         2019-08-28  3332  static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
7caa47151ab2e64 Tejun Heo         2019-08-28  3333  				    size_t nbytes, loff_t off)
7caa47151ab2e64 Tejun Heo         2019-08-28  3334  {
22ae8ce8b89241c Christoph Hellwig 2020-11-26  3335  	struct block_device *bdev;
8bef9fba59d8d47 Wang Jianchao     2022-01-10  3336  	struct rq_qos *rqos;
7caa47151ab2e64 Tejun Heo         2019-08-28  3337  	struct ioc *ioc;
7caa47151ab2e64 Tejun Heo         2019-08-28  3338  	u64 u[NR_I_LCOEFS];
7caa47151ab2e64 Tejun Heo         2019-08-28  3339  	bool user;
7caa47151ab2e64 Tejun Heo         2019-08-28  3340  	char *p;
7caa47151ab2e64 Tejun Heo         2019-08-28  3341  	int ret;
7caa47151ab2e64 Tejun Heo         2019-08-28  3342  
22ae8ce8b89241c Christoph Hellwig 2020-11-26  3343  	bdev = blkcg_conf_open_bdev(&input);
22ae8ce8b89241c Christoph Hellwig 2020-11-26  3344  	if (IS_ERR(bdev))
22ae8ce8b89241c Christoph Hellwig 2020-11-26  3345  		return PTR_ERR(bdev);
7caa47151ab2e64 Tejun Heo         2019-08-28  3346  
8bef9fba59d8d47 Wang Jianchao     2022-01-10  3347  	rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
7caa47151ab2e64 Tejun Heo         2019-08-28 @3348  	if (!ioc) {
ed6cddefdfd361a Pavel Begunkov    2021-10-14  3349  		ret = blk_iocost_init(bdev_get_queue(bdev));
7caa47151ab2e64 Tejun Heo         2019-08-28  3350  		if (ret)
7caa47151ab2e64 Tejun Heo         2019-08-28  3351  			goto err;
8bef9fba59d8d47 Wang Jianchao     2022-01-10  3352  		rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
7caa47151ab2e64 Tejun Heo         2019-08-28  3353  	}
7caa47151ab2e64 Tejun Heo         2019-08-28  3354  
8bef9fba59d8d47 Wang Jianchao     2022-01-10  3355  	ioc = rqos_to_ioc(rqos);
7caa47151ab2e64 Tejun Heo         2019-08-28  3356  	spin_lock_irq(&ioc->lock);
7caa47151ab2e64 Tejun Heo         2019-08-28  3357  	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
7caa47151ab2e64 Tejun Heo         2019-08-28  3358  	user = ioc->user_cost_model;
7caa47151ab2e64 Tejun Heo         2019-08-28  3359  	spin_unlock_irq(&ioc->lock);
7caa47151ab2e64 Tejun Heo         2019-08-28  3360  
7caa47151ab2e64 Tejun Heo         2019-08-28  3361  	while ((p = strsep(&input, " \t\n"))) {
7caa47151ab2e64 Tejun Heo         2019-08-28  3362  		substring_t args[MAX_OPT_ARGS];
7caa47151ab2e64 Tejun Heo         2019-08-28  3363  		char buf[32];
7caa47151ab2e64 Tejun Heo         2019-08-28  3364  		int tok;
7caa47151ab2e64 Tejun Heo         2019-08-28  3365  		u64 v;
7caa47151ab2e64 Tejun Heo         2019-08-28  3366  
7caa47151ab2e64 Tejun Heo         2019-08-28  3367  		if (!*p)
7caa47151ab2e64 Tejun Heo         2019-08-28  3368  			continue;
7caa47151ab2e64 Tejun Heo         2019-08-28  3369  
7caa47151ab2e64 Tejun Heo         2019-08-28  3370  		switch (match_token(p, cost_ctrl_tokens, args)) {
7caa47151ab2e64 Tejun Heo         2019-08-28  3371  		case COST_CTRL:
7caa47151ab2e64 Tejun Heo         2019-08-28  3372  			match_strlcpy(buf, &args[0], sizeof(buf));
7caa47151ab2e64 Tejun Heo         2019-08-28  3373  			if (!strcmp(buf, "auto"))
7caa47151ab2e64 Tejun Heo         2019-08-28  3374  				user = false;
7caa47151ab2e64 Tejun Heo         2019-08-28  3375  			else if (!strcmp(buf, "user"))
7caa47151ab2e64 Tejun Heo         2019-08-28  3376  				user = true;
7caa47151ab2e64 Tejun Heo         2019-08-28  3377  			else
7caa47151ab2e64 Tejun Heo         2019-08-28  3378  				goto einval;
7caa47151ab2e64 Tejun Heo         2019-08-28  3379  			continue;
7caa47151ab2e64 Tejun Heo         2019-08-28  3380  		case COST_MODEL:
7caa47151ab2e64 Tejun Heo         2019-08-28  3381  			match_strlcpy(buf, &args[0], sizeof(buf));
7caa47151ab2e64 Tejun Heo         2019-08-28  3382  			if (strcmp(buf, "linear"))
7caa47151ab2e64 Tejun Heo         2019-08-28  3383  				goto einval;
7caa47151ab2e64 Tejun Heo         2019-08-28  3384  			continue;
7caa47151ab2e64 Tejun Heo         2019-08-28  3385  		}
7caa47151ab2e64 Tejun Heo         2019-08-28  3386  
7caa47151ab2e64 Tejun Heo         2019-08-28  3387  		tok = match_token(p, i_lcoef_tokens, args);
7caa47151ab2e64 Tejun Heo         2019-08-28  3388  		if (tok == NR_I_LCOEFS)
7caa47151ab2e64 Tejun Heo         2019-08-28  3389  			goto einval;
7caa47151ab2e64 Tejun Heo         2019-08-28  3390  		if (match_u64(&args[0], &v))
7caa47151ab2e64 Tejun Heo         2019-08-28  3391  			goto einval;
7caa47151ab2e64 Tejun Heo         2019-08-28  3392  		u[tok] = v;
7caa47151ab2e64 Tejun Heo         2019-08-28  3393  		user = true;
7caa47151ab2e64 Tejun Heo         2019-08-28  3394  	}
7caa47151ab2e64 Tejun Heo         2019-08-28  3395  
7caa47151ab2e64 Tejun Heo         2019-08-28  3396  	spin_lock_irq(&ioc->lock);
7caa47151ab2e64 Tejun Heo         2019-08-28  3397  	if (user) {
7caa47151ab2e64 Tejun Heo         2019-08-28  3398  		memcpy(ioc->params.i_lcoefs, u, sizeof(u));
7caa47151ab2e64 Tejun Heo         2019-08-28  3399  		ioc->user_cost_model = true;
7caa47151ab2e64 Tejun Heo         2019-08-28  3400  	} else {
7caa47151ab2e64 Tejun Heo         2019-08-28  3401  		ioc->user_cost_model = false;
7caa47151ab2e64 Tejun Heo         2019-08-28  3402  	}
7caa47151ab2e64 Tejun Heo         2019-08-28  3403  	ioc_refresh_params(ioc, true);
7caa47151ab2e64 Tejun Heo         2019-08-28  3404  	spin_unlock_irq(&ioc->lock);
7caa47151ab2e64 Tejun Heo         2019-08-28  3405  
8bef9fba59d8d47 Wang Jianchao     2022-01-10  3406  	rq_qos_put(rqos);
22ae8ce8b89241c Christoph Hellwig 2020-11-26  3407  	blkdev_put_no_open(bdev);
7caa47151ab2e64 Tejun Heo         2019-08-28  3408  	return nbytes;
7caa47151ab2e64 Tejun Heo         2019-08-28  3409  
7caa47151ab2e64 Tejun Heo         2019-08-28  3410  einval:
7caa47151ab2e64 Tejun Heo         2019-08-28  3411  	ret = -EINVAL;
8bef9fba59d8d47 Wang Jianchao     2022-01-10  3412  	rq_qos_put(rqos);
7caa47151ab2e64 Tejun Heo         2019-08-28  3413  err:
22ae8ce8b89241c Christoph Hellwig 2020-11-26  3414  	blkdev_put_no_open(bdev);
7caa47151ab2e64 Tejun Heo         2019-08-28  3415  	return ret;
7caa47151ab2e64 Tejun Heo         2019-08-28  3416  }
7caa47151ab2e64 Tejun Heo         2019-08-28  3417  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

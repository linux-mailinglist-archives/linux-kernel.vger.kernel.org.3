Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71215525B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiFTUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbiFTUTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:19:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2844A11A07;
        Mon, 20 Jun 2022 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655756341; x=1687292341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QUGWdwtiY/barQJg8YWgoUlcx2pD9S6eocsUfc3YoZs=;
  b=L2uW6kf7X2J6a5y0W+D3VqiL2MSoOEvTxuMPHvS9nBg2pIaPo+MOoY2m
   0nxIIkdY5EUaOpGT+ZQ3IPgt0deUGbFrbuJqeFT2CCtF7WK5YD9cM3RUD
   0i9ylt+By6RazwCeNUih/my3tAUBduPK1426gLzRq7ZWhAApzBHRZQ3DO
   cEbNoju2v9VMk+BN7SI5ZOlwjDEbUUYX1tSxv9lXKoiCYSQxsAhNLAadh
   HC1ImpmW6+zDz3eH6RMNH/WQ188QT/4VTY+redMcTBJneTcWV75IusPHY
   qS5iFxOqvTNyNFFmdq7AiA5Y9j1ZyO2sTeTq2xZuOng7jwiZn68dtZUCr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280699305"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="280699305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 13:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="714728052"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2022 13:18:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3NrN-000Vwx-2R;
        Mon, 20 Jun 2022 20:18:57 +0000
Date:   Tue, 21 Jun 2022 04:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Yang Shen <shenyang39@huawei.com>
Subject: Re: [PATCH] uacce: Tidy up locking
Message-ID: <202206210432.WVkOxVu5-lkp@intel.com>
References: <YrB1D9rv9G4h/BYU@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrB1D9rv9G4h/BYU@myrica>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on soc/for-next linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Philippe-Brucker/uacce-Tidy-up-locking/20220620-220634
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220621/202206210432.WVkOxVu5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/intel-lab-lkp/linux/commit/3589b5391f54bea3dc85ed65fe0f036757a4f21c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jean-Philippe-Brucker/uacce-Tidy-up-locking/20220620-220634
        git checkout 3589b5391f54bea3dc85ed65fe0f036757a4f21c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/uacce/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/uacce/uacce.c:291:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted __poll_t @@
   drivers/misc/uacce/uacce.c:291:21: sparse:     expected int ret
   drivers/misc/uacce/uacce.c:291:21: sparse:     got restricted __poll_t
>> drivers/misc/uacce/uacce.c:295:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int ret @@
   drivers/misc/uacce/uacce.c:295:16: sparse:     expected restricted __poll_t
   drivers/misc/uacce/uacce.c:295:16: sparse:     got int ret

vim +291 drivers/misc/uacce/uacce.c

   277	
   278	static __poll_t uacce_fops_poll(struct file *file, poll_table *wait)
   279	{
   280		struct uacce_queue *q = file->private_data;
   281		struct uacce_device *uacce = q->uacce;
   282		int ret = 0;
   283	
   284		poll_wait(file, &q->wait, wait);
   285	
   286		mutex_lock(&q->mutex);
   287		if (!uacce_queue_is_valid(q))
   288			goto out_unlock;
   289	
   290		if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q))
 > 291			ret = EPOLLIN | EPOLLRDNORM;
   292	
   293	out_unlock:
   294		mutex_unlock(&q->mutex);
 > 295		return ret;
   296	}
   297	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

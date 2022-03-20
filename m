Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F34E198B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 04:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiCTDcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 23:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiCTDcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 23:32:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AAA3D4B4;
        Sat, 19 Mar 2022 20:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647747057; x=1679283057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h1aRh4JEaVV6XjY9nMDTKMmS36IDjBZFJm+89+Hc6nU=;
  b=h78V8YhoQiLynBzGlgHuyQl6F3hUPKq7xzgqHqpq+Ws6N+FBseidR5qe
   GonL0yzGIrpyD1EgIq0r+F4wdxY7dbdOZQzBzieuLos50IW7FCPtyRxti
   gbHAQ5NwkJWZAgNDtJn2v6kEK/vs65AIXnBv1+q1ndpsay95qck/AsvJV
   1erdCcuhTLl5jhVvcQbAJwhB2MEe4KiDb6sztxTMDsJHZQtu5y8DVoV4T
   n+AgXR3yCFUQyk6g4U6ciGeF/5Bjk2nky5iRMJ68hru80ExraXGcGCkjc
   DCcEAW5SRQARMEEMq37rddrl+WIMjZT95NHzLU6xvGvqes98YdmHiWT+z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="257539876"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="257539876"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 20:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="517985806"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2022 20:30:54 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVmHN-000GWN-Np; Sun, 20 Mar 2022 03:30:53 +0000
Date:   Sun, 20 Mar 2022 11:30:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>, dan@dlrobertson.com,
        jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
Message-ID: <202203201124.OLMstZaW-lkp@intel.com>
References: <20220319181023.8090-4-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319181023.8090-4-jagathjog1996@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagath,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.17-rc8]
[cannot apply to jic23-iio/togreg next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jagath-Jog-J/iio-accel-bma400-Add-support-for-buffer-and-step/20220320-021114
base:    09688c0166e76ce2fb85e86b9d99be8b0084cdf9
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220320/202203201124.OLMstZaW-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/8dc9a46d5af9a53917108ce2b103b3d9a50986a5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jagath-Jog-J/iio-accel-bma400-Add-support-for-buffer-and-step/20220320-021114
        git checkout 8dc9a46d5af9a53917108ce2b103b3d9a50986a5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/iio/accel/bma400_core.c:906:13: sparse: sparse: restricted __le16 degrades to integer

vim +906 drivers/iio/accel/bma400_core.c

   891	
   892	static irqreturn_t bma400_interrupt(int irq, void *private)
   893	{
   894		struct iio_dev *indio_dev = private;
   895		struct bma400_data *data = iio_priv(indio_dev);
   896		int ret;
   897		__le16 status;
   898	
   899		mutex_lock(&data->mutex);
   900		ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
   901				       sizeof(status));
   902		mutex_unlock(&data->mutex);
   903		if (ret)
   904			goto out;
   905	
 > 906		if (status & BMA400_INT_DRDY_MSK)
   907			iio_trigger_poll_chained(data->trig);
   908	
   909	out:
   910		return IRQ_HANDLED;
   911	}
   912	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

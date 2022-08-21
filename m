Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553759B638
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiHUUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHUUHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:07:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20212AA8;
        Sun, 21 Aug 2022 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661112425; x=1692648425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=elkD6lNBNO2nvsj5wXiKvhjqqWRzvqsgpv7fFNj1mGM=;
  b=WuCA5LI4edpYJWDj898VR/XKkpd+x2+l+0tzVFsc3yj1m8X6OqvNifNi
   XIdhwmLlMg/9HqkB9z7RtNzTlfoG7lov+GBXZCWhv/RXVoC+72oVGSioD
   xmx/QDBrhVmnN6IsN89Q0tCOAosxnX3p2zfQGt/dNHZLF6Oll4nk80yeB
   Z4SYRlnqFGXiVe1WB14LRG9LhglaMJEihMKJ91muHWAcmsj/Pf0eyodk4
   KOue7gzjdDMvFsoD21EU8EylDRWslHj3tlDXVscY4nrt0IzkWbTuWvE1g
   HXc0bFcyjln8SgH4bUGPN8+JJIxKv2L3XwhIo7Q+KrBbmm7zIWSgWTxV7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="280245195"
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="280245195"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 13:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="585252407"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2022 13:07:02 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPrDp-0004RL-1M;
        Sun, 21 Aug 2022 20:07:01 +0000
Date:   Mon, 22 Aug 2022 04:06:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vimal Kumar <vimal.kumar32@gmail.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, chinmoyghosh2001@gmail.com,
        Vimal Kumar <vimal.kumar32@gmail.com>,
        Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: runtime: Add support to disable wakeup sources
Message-ID: <202208220446.3Qzss7sC-lkp@intel.com>
References: <20220821134533.22901-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821134533.22901-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vimal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-runtime-Add-support-to-disable-wakeup-sources/20220821-214614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20220822/202208220446.3Qzss7sC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/dee2f4d4c4b79cbfc7b2c792294b5137872d7c0c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vimal-Kumar/PM-runtime-Add-support-to-disable-wakeup-sources/20220821-214614
        git checkout dee2f4d4c4b79cbfc7b2c792294b5137872d7c0c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/base/power/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/base/power/wakeup_stats.c:225:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char const *buf @@
   drivers/base/power/wakeup_stats.c:225:37: sparse:     expected void const [noderef] __user *from
   drivers/base/power/wakeup_stats.c:225:37: sparse:     got char const *buf

vim +225 drivers/base/power/wakeup_stats.c

   211	
   212	static ssize_t disable_ws_store(struct class *class,
   213					struct class_attribute *attr,
   214					const char *buf, size_t len)
   215	{
   216		struct device		*dev;
   217		struct wakeup_source	*ws;
   218		char                    *ws_name;
   219		int                     status;
   220	
   221		ws_name = kzalloc(sizeof(*(buf)), GFP_KERNEL);
   222		if (!ws_name)
   223			return -ENOMEM;
   224	
 > 225		if (copy_from_user(ws_name, buf, sizeof(*(buf))))
   226			return -EFAULT;
   227	
   228		dev = class_find_device_by_name(wakeup_class, ws_name);
   229		if (!dev)
   230			pr_err("%s : %s dev not found\n", __func__, ws_name);
   231	
   232		ws = dev_get_drvdata(dev);
   233		if (ws->dev->parent != NULL) {
   234	
   235			status = device_wakeup_disable(ws->dev->parent);
   236			if (status < 0) {
   237				/* In case of virtual device, return code will be -EINVAL
   238				 * then unregister the wakeup source associated with it
   239				 */
   240				wakeup_source_unregister(ws);
   241			}
   242		} else
   243			/* If the parent device is NULL, just unregister the wakeup source */
   244			wakeup_source_unregister(ws);
   245	
   246		return len;
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

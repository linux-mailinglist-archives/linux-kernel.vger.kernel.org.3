Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF34B5BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiBNVCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:02:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBNVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:02:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27039B65FB;
        Mon, 14 Feb 2022 13:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644872530; x=1676408530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPsg9/jpppi/LY2t/Fw9MvKZpBWLmJurE/YRhV48e5M=;
  b=kTVSOK0ZxUkFKfCvwjGZVyYcQm++sQzlB4CeQAow52Sm3gnloHZLsZ6V
   Q3ya5Z8fr0aKAzdcI8wKfSaGEvQeBNnbJ8QwMiDbW9icQvVmDI7oqNeqq
   8afj/vxRFSh1oVLDXatO5Kd3sfGtxQfeKgDod3TjTQ2HGJVzbZ4RT6+Ap
   B/EDp2acHTDB4N5CcnNOOV3vBScGLg1fbvYA4gw1jvzAZBMQe8pK2pACg
   5Wk+RgdMTvEn/rgTqji8ZOZLhiAO11GfEhOSishFI2dz7tloyAX7aZ7bt
   0ykCMPMekSgBsGJOmX2YpQvfbY/BEb2OwNyiXAYZtNu3r9e9HaBNEN4Bu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230128955"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230128955"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 11:13:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="485651771"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 11:13:16 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJgmh-0008qn-Mw; Mon, 14 Feb 2022 19:13:15 +0000
Date:   Tue, 15 Feb 2022 03:12:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] serial: sh-sci: Switch to use dev_err_probe_ptr()
Message-ID: <202202150314.3Ybl4jns-lkp@intel.com>
References: <20220214143248.502-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214143248.502-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on usb/usb-testing linux/master linus/master v5.17-rc4 next-20220214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/driver-core-add-a-wrapper-to-device-probe-log-helper-to-return-pointer/20220214-223425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: hexagon-buildonly-randconfig-r001-20220214 (https://download.01.org/0day-ci/archive/20220215/202202150314.3Ybl4jns-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/810910d324cc80b092207d043651de696d293cbd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/driver-core-add-a-wrapper-to-device-probe-log-helper-to-return-pointer/20220214-223425
        git checkout 810910d324cc80b092207d043651de696d293cbd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/sh-sci.c:3205:83: error: too few arguments to function call, expected 4, have 3
                   return dev_err_probe_ptr(&pdev->dev, PTR_ERR(rstc), "failed to get reset ctrl\n");
                          ~~~~~~~~~~~~~~~~~                                                        ^
   include/linux/device.h:988:7: note: 'dev_err_probe_ptr' declared here
   void *dev_err_probe_ptr(const struct device *dev, int err, const char *fmt, va_list args)
         ^
   1 error generated.


vim +3205 drivers/tty/serial/sh-sci.c

  3187	
  3188	static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
  3189						  unsigned int *dev_id)
  3190	{
  3191		struct device_node *np = pdev->dev.of_node;
  3192		struct reset_control *rstc;
  3193		struct plat_sci_port *p;
  3194		struct sci_port *sp;
  3195		const void *data;
  3196		int id, ret;
  3197	
  3198		if (!IS_ENABLED(CONFIG_OF) || !np)
  3199			return ERR_PTR(-EINVAL);
  3200	
  3201		data = of_device_get_match_data(&pdev->dev);
  3202	
  3203		rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
  3204		if (IS_ERR(rstc))
> 3205			return dev_err_probe_ptr(&pdev->dev, PTR_ERR(rstc), "failed to get reset ctrl\n");
  3206	
  3207		ret = reset_control_deassert(rstc);
  3208		if (ret) {
  3209			dev_err(&pdev->dev, "failed to deassert reset %d\n", ret);
  3210			return ERR_PTR(ret);
  3211		}
  3212	
  3213		ret = devm_add_action_or_reset(&pdev->dev, sci_reset_control_assert, rstc);
  3214		if (ret) {
  3215			dev_err(&pdev->dev, "failed to register assert devm action, %d\n",
  3216				ret);
  3217			return ERR_PTR(ret);
  3218		}
  3219	
  3220		p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
  3221		if (!p)
  3222			return ERR_PTR(-ENOMEM);
  3223	
  3224		/* Get the line number from the aliases node. */
  3225		id = of_alias_get_id(np, "serial");
  3226		if (id < 0 && ~sci_ports_in_use)
  3227			id = ffz(sci_ports_in_use);
  3228		if (id < 0) {
  3229			dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
  3230			return ERR_PTR(-EINVAL);
  3231		}
  3232		if (id >= ARRAY_SIZE(sci_ports)) {
  3233			dev_err(&pdev->dev, "serial%d out of range\n", id);
  3234			return ERR_PTR(-EINVAL);
  3235		}
  3236	
  3237		sp = &sci_ports[id];
  3238		*dev_id = id;
  3239	
  3240		p->type = SCI_OF_TYPE(data);
  3241		p->regtype = SCI_OF_REGTYPE(data);
  3242	
  3243		sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
  3244	
  3245		return p;
  3246	}
  3247	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

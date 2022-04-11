Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374CD4FC7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiDKXKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiDKXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:10:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6911C18;
        Mon, 11 Apr 2022 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649718505; x=1681254505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z5H/rq03nkgQAfI8+PdRAbFO8Il2m/4sGggc2QYRUUE=;
  b=DXPMRnfvtAKQK0kUOMbdVDe82oYxQPcKPKxPCVMdXs+xfSTGLq4CYTM2
   K/nPvm9AXWZCAg0y+WEPMVXy9WWQ7ES/R9M2GkMQJyl0k5ntYiD6QDL1V
   SSxyzSo6zAI+pm9tc/k+l9l9DVIcc/7Oo/RBTOF7gGokspjX1TZcs3UbF
   t+SuI/RYKPEGqZPLjI3oIwcdhiCQ0F1mO7VOAXqqdSgoSM3phekUDkS/n
   sZAR/3r+PSdfwYYeLFxLlZ0U4fl+e6Knke46U50ritHQzh/uu8/rT1ec1
   OCfMrMwoFpnssKhTWq5uJa5N08M28nBtDtQDsSmm7QsEBeDltuUH81X/q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325146697"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="325146697"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 16:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="644468203"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2022 16:08:21 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne38u-0002IQ-M6;
        Mon, 11 Apr 2022 23:08:20 +0000
Date:   Tue, 12 Apr 2022 07:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: Re: [PATCH v4 3/3] clocksource: Ingenic: Add SMP/SMT support for
 sysost driver.
Message-ID: <202204120622.OSuTgle5-lkp@intel.com>
References: <1649687597-74219-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1649687597-74219-4-git-send-email-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "周琰杰,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on robh/for-next v5.18-rc2 next-20220411]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-Yanjie/Add-SMP-SMT-support-for-Ingenic-sysost-driver/20220411-223537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8afbcaf8690dac19ebf570a4e4fef9c59c75bf8e
config: openrisc-randconfig-s032-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120622.OSuTgle5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/facdbd1eb8f72863d589c575577f6130d8cf6ed1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhou-Yanjie/Add-SMP-SMT-support-for-Ingenic-sysost-driver/20220411-223537
        git checkout facdbd1eb8f72863d589c575577f6130d8cf6ed1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/clocksource/ingenic-sysost.c:703:65: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *dev @@     got struct ingenic_ost_timer [noderef] __percpu *timers @@
   drivers/clocksource/ingenic-sysost.c:703:65: sparse:     expected void *dev
   drivers/clocksource/ingenic-sysost.c:703:65: sparse:     got struct ingenic_ost_timer [noderef] __percpu *timers

vim +703 drivers/clocksource/ingenic-sysost.c

   678	
   679	static int __init ingenic_ost_init(struct device_node *np)
   680	{
   681		struct ingenic_ost *ost;
   682		unsigned long rate;
   683		int ret;
   684	
   685		ret = ingenic_ost_probe(np);
   686		if (ret) {
   687			pr_crit("%s: Failed to initialize OST clocks: %d\n", __func__, ret);
   688			return ret;
   689		}
   690	
   691		of_node_clear_flag(np, OF_POPULATED);
   692	
   693		ost = ingenic_ost;
   694		if (IS_ERR(ost))
   695			return PTR_ERR(ost);
   696	
   697		if (ost->soc_info->has_event_timer) {
   698			if (ost->soc_info->version >= ID_X2000)
   699				ret = request_percpu_irq(ost->irq, ingenic_ost_cevt_cb,
   700						  "OST event timer", ost->timers);
   701			else
   702				ret = request_irq(ost->irq, ingenic_ost_cevt_cb, IRQF_TIMER,
 > 703						  "OST event timer", ost->timers);
   704	
   705			if (ret) {
   706				pr_crit("%s: Unable to request IRQ: %d\n", __func__, ret);
   707				goto err_free_ingenic_ost;
   708			}
   709	
   710			/* Setup clock events on each CPU core */
   711			ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "Ingenic XBurst: online",
   712						ingenic_ost_setup_cevt, NULL);
   713			if (ret < 0) {
   714				pr_crit("%s: Unable to init event timers: %d\n", __func__, ret);
   715				goto err_free_ingenic_ost;
   716			}
   717		}
   718	
   719		if (ost->soc_info->has_global_timer) {
   720			ret = ingenic_ost_global_timer_init(np, ost);
   721			if (ret) {
   722				pr_crit("%s: Unable to init global timer: %d\n", __func__, ret);
   723	
   724				if (!ost->soc_info->has_event_timer)
   725					goto err_free_ingenic_ost;
   726			}
   727	
   728			/* Register the sched_clock at the end as there's no way to undo it */
   729			rate = clk_get_rate(ost->global_timer_clk);
   730			sched_clock_register(ingenic_ost_global_timer_read_cntl, 32, rate);
   731		}
   732	
   733		return 0;
   734	
   735	err_free_ingenic_ost:
   736		kfree(ost);
   737		return ret;
   738	}
   739	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

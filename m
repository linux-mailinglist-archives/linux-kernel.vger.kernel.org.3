Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A5454ACC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbiFNJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242592AbiFNJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:02:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079A01013;
        Tue, 14 Jun 2022 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655197346; x=1686733346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1KfA+Z4zkxUy52TB32Y60QTCmoY7zwc4D2LPQ88A3oM=;
  b=D1IoUAreOqP48B4KEsajoxFQi+AGoJ2jDkyD6vpqTUDmn6alEOoF3hyt
   OiamX9fnWtmyCV/m2LXYk8KVMffk9IUe+OuIKEvS9G8OLQWcfShT2tBzl
   9NllQ3XntgUJ4iHj1QCzVX9OdVj3uHSOj0sHo6yhxB9uNqlZlNI1ZrH7m
   QGKHhF8g9Bcu19njTHI5YrsMajCFn1sBojQbqTJ7Ddtap8ZZv55RyRDDx
   6TMq5bN7iajGUp4XvLsoWQbNSl+KRzgYaGOqEknl4YEXtEIhAglc4rDKO
   69ZpC8OC44EEtB3x59Fh3OkcYx/fdINheOgkV4D42zOZbcnIW/FFVqn6h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258391749"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258391749"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="569832678"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2022 02:02:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o12RK-000LhX-9J;
        Tue, 14 Jun 2022 09:02:22 +0000
Date:   Tue, 14 Jun 2022 17:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/5] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
Message-ID: <202206141647.zyZy1pSw-lkp@intel.com>
References: <20220613134213.8904-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613134213.8904-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on chanwoo/devfreq-testing]
[also build test ERROR on linus/master v5.19-rc2 next-20220614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Ansuel-Marangi/PM-devfreq-Various-Fixes-to-cpufreq-based-passive-governor/20220614-020616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
config: arc-randconfig-r043-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141647.zyZy1pSw-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/378807dd7da24162524c0ba84e996157b3e289c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-Ansuel-Marangi/PM-devfreq-Various-Fixes-to-cpufreq-based-passive-governor/20220614-020616
        git checkout 378807dd7da24162524c0ba84e996157b3e289c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/devfreq/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_unregister_notifier':
>> drivers/devfreq/governor_passive.c:235:79: error: macro "list_for_each_entry_safe" requires 4 arguments, but only 3 given
     235 |         list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
         |                                                                               ^
   In file included from include/linux/module.h:12,
                    from drivers/devfreq/governor_passive.c:10:
   include/linux/list.h:760: note: macro "list_for_each_entry_safe" defined here
     760 | #define list_for_each_entry_safe(pos, n, head, member)                  \
         | 
>> drivers/devfreq/governor_passive.c:235:9: error: 'list_for_each_entry_safe' undeclared (first use in this function)
     235 |         list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/devfreq/governor_passive.c:235:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/devfreq/governor_passive.c:235:33: error: expected ';' before '{' token
     235 |         list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
         |                                 ^                                               ~
         |                                 ;
   drivers/devfreq/governor_passive.c:225:34: warning: unused variable 'parent_cpu_data' [-Wunused-variable]
     225 |         struct devfreq_cpu_data *parent_cpu_data;
         |                                  ^~~~~~~~~~~~~~~
   drivers/devfreq/governor_passive.c:245:1: error: control reaches end of non-void function [-Werror=return-type]
     245 | }
         | ^
   cc1: some warnings being treated as errors


vim +/list_for_each_entry_safe +235 drivers/devfreq/governor_passive.c

   220	
   221	static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
   222	{
   223		struct devfreq_passive_data *p_data
   224				= (struct devfreq_passive_data *)devfreq->data;
   225		struct devfreq_cpu_data *parent_cpu_data;
   226		int ret;
   227	
   228		if (p_data->nb.notifier_call) {
   229			ret = cpufreq_unregister_notifier(&p_data->nb,
   230						CPUFREQ_TRANSITION_NOTIFIER);
   231			if (ret < 0)
   232				return ret;
   233		}
   234	
 > 235		list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
   236			list_del(&parent_cpu_data->node);
   237	
   238			if (parent_cpu_data->opp_table)
   239				dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
   240	
   241			kfree(parent_cpu_data);
   242		}
   243	
   244		return 0;
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

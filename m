Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74B56A9F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiGGRqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiGGRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:45:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D95C970
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657215958; x=1688751958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWJOUy1nIQhBbWGNLoGxZAU40Vqt24Kx+Nx/iFznGTU=;
  b=awXUWInlLa08Myloa9XO1sDewJKwgimjD31hJjw8lVId/MAT6sdGreS7
   HtTX/rZY6Htw1Y3t3pTRhoYHqoAPASM5vG9mlEeVe/E0BEwH1Xoyv0C59
   SKjNIAuRKjH7e6sK6FRCiBrKv2cmpd/Vuhgfx4gXYQHe8qOgYglrExrMC
   Kx0IZnbA4S8OYbGeawUS1hc3KwMtYv8QzWNT23OkiMrK2tEEj6Qzgu34f
   AzKEHc5Hf/qxmn2TaZ8I6bA2R5L5CwFq08a9g6+TS7FeZ5gFBsA/V1Squ
   QGyrCaeYt2/S8UvXaTbFoe6mwX2mNoSzUl7vFGFlE1yS2akXmV6DuQqCf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284108548"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="284108548"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 10:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="568611280"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2022 10:45:54 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9VZa-000MGw-8F;
        Thu, 07 Jul 2022 17:45:54 +0000
Date:   Fri, 8 Jul 2022 01:45:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karthik Alapati <mail@karthek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Shuah Khan <skhan@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: don't use index pointer after iter
Message-ID: <202207080123.R3ePp3SE-lkp@intel.com>
References: <Ysa1oopf0ELw+OfB@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysa1oopf0ELw+OfB@karthik-strix-linux.karthek.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karthik,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.19-rc5]
[also build test WARNING on linus/master]
[cannot apply to staging/staging-testing next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Karthik-Alapati/staging-greybus-don-t-use-index-pointer-after-iter/20220707-183311
base:    88084a3df1672e131ddc1b4e39eeacfd39864acf
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207080123.R3ePp3SE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/bc295082ef055003c6018b57d3c56c5aefcb65c5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Karthik-Alapati/staging-greybus-don-t-use-index-pointer-after-iter/20220707-183311
        git checkout bc295082ef055003c6018b57d3c56c5aefcb65c5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/greybus/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/greybus/audio_helper.c: In function 'gbaudio_dapm_free_controls':
   drivers/staging/greybus/audio_helper.c:128:32: error: expected ';' before 'for'
     128 |                 w_found = false
         |                                ^
         |                                ;
>> drivers/staging/greybus/audio_helper.c:119:14: warning: variable 'w_found' set but not used [-Wunused-but-set-variable]
     119 |         bool w_found = false;
         |              ^~~~~~~
>> drivers/staging/greybus/audio_helper.c:118:41: warning: unused variable 'next_w' [-Wunused-variable]
     118 |         struct snd_soc_dapm_widget *w, *next_w;
         |                                         ^~~~~~


vim +/w_found +119 drivers/staging/greybus/audio_helper.c

   112	
   113	int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
   114				       const struct snd_soc_dapm_widget *widget,
   115				       int num)
   116	{
   117		int i;
 > 118		struct snd_soc_dapm_widget *w, *next_w;
 > 119		bool w_found = false;
   120	#ifdef CONFIG_DEBUG_FS
   121		struct dentry *parent = dapm->debugfs_dapm;
   122		struct dentry *debugfs_w = NULL;
   123	#endif
   124	
   125		mutex_lock(&dapm->card->dapm_mutex);
   126		for (i = 0; i < num; i++) {
   127			/* below logic can be optimized to identify widget pointer */
   128			w_found = false
   129			list_for_each_entry_safe(w, next_w, &dapm->card->widgets,
   130						 list) {
   131				if (w->dapm != dapm)
   132					continue;
   133				if (!strcmp(w->name, widget->name)) {
   134					w_found = true;
   135					break;
   136				}
   137				w = NULL;
   138			}
   139			if (!w_found) {
   140				dev_err(dapm->dev, "%s: widget not found\n",
   141					widget->name);
   142				widget++;
   143				continue;
   144			}
   145			widget++;
   146	#ifdef CONFIG_DEBUG_FS
   147			if (!parent)
   148				debugfs_w = debugfs_lookup(w->name, parent);
   149			debugfs_remove(debugfs_w);
   150			debugfs_w = NULL;
   151	#endif
   152			gbaudio_dapm_free_widget(w);
   153		}
   154		mutex_unlock(&dapm->card->dapm_mutex);
   155		return 0;
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

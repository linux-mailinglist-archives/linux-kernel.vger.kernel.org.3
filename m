Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762FB599A06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347276AbiHSKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347745AbiHSKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:35:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E0AF23FC;
        Fri, 19 Aug 2022 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660905355; x=1692441355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9tIOJO8iIZTfgTPmf7d8mdH6aJrcZ7JVSdLiYDFz5dE=;
  b=f/KEn0fpkJXnt7ufpN5My7CvD7GcJykWiKeyemp/rWuLMFp9ruS+SV1p
   uGQmAKw4CVGSEqIiT8YKXIUujnu13TvMQ2u9FCTfRn3oURztddpYkRCnx
   fjwJNPrL1lJvtBRttBiyjda71gD0Chr9+YSyfDT6Yn3hGBVrQyBY0heTY
   1sO3cllB3CW9DyfyWQmcpUUs8dusa4ytPspSH3S/f8CO9Xga7MTwtCLLr
   S+7axlS+nEeZQ7iZjAaVdnJrNIZR2aK3OUSBMk1+kVBzSu+j1uVhznXz+
   2WdfUFKN8Wi/0gSJodlORoj7xW0jepgFdAzOU/Pjt7lAhuT3sYElL0aRT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="292983803"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="292983803"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 03:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="711301794"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2022 03:35:51 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOzLy-0001MH-1w;
        Fri, 19 Aug 2022 10:35:50 +0000
Date:   Fri, 19 Aug 2022 18:35:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com
Cc:     kbuild-all@lists.01.org, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 2/3] driver: input: matric-keypad: add reduced matrix
 support
Message-ID: <202208191853.knYsDJyu-lkp@intel.com>
References: <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gireesh-Hiremath-in-bosch-com/driver-input-matric-keypad-switch-to-gpiod/20220819-151155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220819/202208191853.knYsDJyu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a0b420e08e3b8775a3dbc4857f6ef4831db1c2b3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gireesh-Hiremath-in-bosch-com/driver-input-matric-keypad-switch-to-gpiod/20220819-151155
        git checkout a0b420e08e3b8775a3dbc4857f6ef4831db1c2b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/input/keyboard/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/keyboard/matrix_keypad.c:65:33: warning: 'keypad_infos' defined but not used [-Wunused-const-variable=]
      65 | static const struct keypad_info keypad_infos[] = {
         |                                 ^~~~~~~~~~~~


vim +/keypad_infos +65 drivers/input/keyboard/matrix_keypad.c

    64	
  > 65	static const struct keypad_info keypad_infos[] = {
    66		{
    67			.mode = GENERIC,
    68		},
    69		{
    70			.mode = REDUCED,
    71		},
    72	};
    73	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

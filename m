Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101CD4BAA30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245524AbiBQTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:48:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245508AbiBQTsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:48:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF9827FE9;
        Thu, 17 Feb 2022 11:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127286; x=1676663286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aaxSkQVousgo9mD1lX3qPH2hJ2uGtvOppUNnRDzJDOM=;
  b=jIknxxW5ePocxq2VEF6kn6pfyrM56e2Meqwtl4+2RPzy5gZhStQ4vAri
   Bs7DfsFMUzaCDSFYAxUF+f5d1McMr/neeWh6fnGXLtLGJHg1V5sTDcda2
   Bop+5P9azD4mVD1ZGWJTmxkLvJC+W0Cb9JUU/esb296XaGLQmLXQIvgRU
   arY+XCB6coYJwU05G1Ttq+6Ae4y4qUH9x6H3mkXQsE+UImyIOEpSZ9oBI
   +wy+m/yRVQWkl4dGuAaNz0J3FJex3VyUhD4/ynEzvT7yAWSsVK2sUjUsS
   rWWWZdgBfldsH1oIWaJrLLB25YWLneOc9JRNMKrBMkRTHEr8q0GyaF9qO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="275553322"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="275553322"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="503216448"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2022 11:48:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmkz-0000XK-9r; Thu, 17 Feb 2022 19:48:01 +0000
Date:   Fri, 18 Feb 2022 03:47:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH] ASoC: codecs: Add power domains support in digital macro
 codecs
Message-ID: <202202180220.7Z94ouak-lkp@intel.com>
References: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on next-20220217]
[cannot apply to v5.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivasa-Rao-Mandadapu/ASoC-codecs-Add-power-domains-support-in-digital-macro-codecs/20220217-224032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: csky-buildonly-randconfig-r001-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180220.7Z94ouak-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/ASoC-codecs-Add-power-domains-support-in-digital-macro-codecs/20220217-224032
        git checkout a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "lpass_macro_pds_exit" [sound/soc/codecs/snd-soc-lpass-rx-macro.ko] undefined!
>> ERROR: modpost: "lpass_macro_pds_init" [sound/soc/codecs/snd-soc-lpass-rx-macro.ko] undefined!
>> ERROR: modpost: "lpass_macro_pds_exit" [sound/soc/codecs/snd-soc-lpass-va-macro.ko] undefined!
>> ERROR: modpost: "lpass_macro_pds_init" [sound/soc/codecs/snd-soc-lpass-va-macro.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

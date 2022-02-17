Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD44BAA32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiBQTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:48:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbiBQTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:48:38 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8F27141;
        Thu, 17 Feb 2022 11:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127298; x=1676663298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=46Ao89wMcgm6jN7Eq+CdMeAAf93pn4JVEULNHnEFEMY=;
  b=RNfvLN9HHOmMFNJd8zoe75azhYolL5YDMrdv3HrlnIx4y5ue2/7AbOzg
   IZwLNMYemYZSQmZNn2NXQd+LzqRv2oWUNDDXdtkXmMAMi3X00i8NcC+mR
   sn0iB9owU7JB8soJ1OJm+aCmwmeAlfA/C+yfX5buHhaBD2sCHjJJ4/ee6
   ZAeIrY/VBe3ObWIw11WFwrNb10unlIUE7n/rFtCJecTkTCPj0oOSx2hIp
   jT0rlnksMFnTIJdSd2GSV0eGMpBBgJxKMMf9ml6DO3jPscPbpcbDAqPmr
   5wuJgw1NsMFWpe1oC+WME//8ko+rzYs3eoZkiMraZMqoNBxQ4ZEwBG8xx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311703355"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="311703355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="774877289"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Feb 2022 11:48:07 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmkz-0000Xa-E7; Thu, 17 Feb 2022 19:48:01 +0000
Date:   Fri, 18 Feb 2022 03:47:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH] ASoC: codecs: Add power domains support in digital macro
 codecs
Message-ID: <202202180153.WSEbQejW-lkp@intel.com>
References: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-r045-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180153.WSEbQejW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/ASoC-codecs-Add-power-domains-support-in-digital-macro-codecs/20220217-224032
        git checkout a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: lpass_macro_pds_init
   >>> referenced by lpass-rx-macro.c
   >>> soc/codecs/lpass-rx-macro.o:(rx_macro_probe) in archive sound/built-in.a
   >>> referenced by lpass-rx-macro.c
   >>> soc/codecs/lpass-rx-macro.o:(rx_macro_probe) in archive sound/built-in.a
   >>> referenced by lpass-tx-macro.c
   >>> soc/codecs/lpass-tx-macro.o:(tx_macro_probe) in archive sound/built-in.a
   >>> referenced 1 more times
--
>> ld.lld: error: undefined symbol: lpass_macro_pds_exit
   >>> referenced by lpass-rx-macro.c
   >>> soc/codecs/lpass-rx-macro.o:(rx_macro_remove) in archive sound/built-in.a
   >>> referenced by lpass-rx-macro.c
   >>> soc/codecs/lpass-rx-macro.o:(rx_macro_remove) in archive sound/built-in.a
   >>> referenced by lpass-tx-macro.c
   >>> soc/codecs/lpass-tx-macro.o:(tx_macro_remove) in archive sound/built-in.a
   >>> referenced 1 more times

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

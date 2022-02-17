Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B54BAAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiBQUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:19:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiBQUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:19:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5615D189;
        Thu, 17 Feb 2022 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645129148; x=1676665148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yh8fUoXh79fS9tMsEOb8wgZoSRTMtMmtTdQN/QJbHJA=;
  b=G2wOtGc/yDDNsBnNq96FTXOCZpP/zfbI5iOFJ6LIHbhTTgz1CEOQSi37
   2gSpqcVz9CdEjcs37ww8p6K415QeMnfox2D6xw1td7QMlMUlhXHbwqSC9
   SDRMwDLS/RKuyzjopJa0qCz4/UAC4K4zm/sIG0XGc1aahrPbGtfAizNny
   EoxHiSObeYndx+T/vcDcnwUsfhWDuiU4m1yL/xP/uIleXDgdvGzxvaiF/
   pzSEtnueAxqnU5jx65JFA1pphepgc2v/hXGi8vrq7MctlEcKRbTm5cLkb
   iHr8NTEMwJS9Y775lhom4RT+u9Zqnvgyv1joBrumB8Y6JLCDUOLh9Nm8U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234497386"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="234497386"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 12:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="589718320"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2022 12:19:03 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKnF0-0000bi-KF; Thu, 17 Feb 2022 20:19:02 +0000
Date:   Fri, 18 Feb 2022 04:18:43 +0800
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
Message-ID: <202202180450.f9HRZqEk-lkp@intel.com>
References: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: nios2-randconfig-r014-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180450.f9HRZqEk-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/ASoC-codecs-Add-power-domains-support-in-digital-macro-codecs/20220217-224032
        git checkout a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: sound/soc/codecs/lpass-va-macro.o: in function `va_macro_probe':
>> lpass-va-macro.c:(.text+0x918): undefined reference to `lpass_macro_pds_init'
   lpass-va-macro.c:(.text+0x918): relocation truncated to fit: R_NIOS2_CALL26 against `lpass_macro_pds_init'
   nios2-linux-ld: sound/soc/codecs/lpass-va-macro.o: in function `va_macro_remove':
>> lpass-va-macro.c:(.text+0xec0): undefined reference to `lpass_macro_pds_exit'
   lpass-va-macro.c:(.text+0xec0): relocation truncated to fit: R_NIOS2_CALL26 against `lpass_macro_pds_exit'
   nios2-linux-ld: sound/soc/codecs/lpass-rx-macro.o: in function `rx_macro_probe':
>> lpass-rx-macro.c:(.text+0x1cb8): undefined reference to `lpass_macro_pds_init'
   lpass-rx-macro.c:(.text+0x1cb8): relocation truncated to fit: R_NIOS2_CALL26 against `lpass_macro_pds_init'
   nios2-linux-ld: sound/soc/codecs/lpass-rx-macro.o: in function `rx_macro_remove':
>> lpass-rx-macro.c:(.text+0x2188): undefined reference to `lpass_macro_pds_exit'
   lpass-rx-macro.c:(.text+0x2188): relocation truncated to fit: R_NIOS2_CALL26 against `lpass_macro_pds_exit'
   nios2-linux-ld: net/core/sock.o: in function `sk_destruct':
   sock.c:(.text+0x23bc): undefined reference to `__sk_defer_free_flush'
   sock.c:(.text+0x23bc): relocation truncated to fit: R_NIOS2_CALL26 against `__sk_defer_free_flush'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

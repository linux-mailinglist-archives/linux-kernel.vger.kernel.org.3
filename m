Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C24B80D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiBPGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:55:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBPGzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:55:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0128BF5D;
        Tue, 15 Feb 2022 22:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644994476; x=1676530476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lM1SEU0VwVmIPrNwAlzATA/OOqDndWKV5hV1fkHz7+w=;
  b=FeXDaC+ah1o+kWko/ojzfu3deBnt0FfDBmJ5OedFCypW0FiD+FOvLQrk
   i4VS1/xpdjs71LblirNG3Hyvg9cgkl5nmqeKi2w5UFeNhODpA5Eh4Oo5x
   jaTLUl8wojBfyhrCG8L1oTrVd87BApqso8dXoDx+uCIcFcMseORRshuB7
   4/StY7i1cHxkjTvoNA1cQS9EcKhxCqhb0esIyyk174JP8XDwMaAlKvswC
   LvpcoEMtIkl1z/POGESdd8/tXI0nbezWNyB7J/fH0MtBIZaV70ZWSCUxX
   2qLNCo63P7/HdpnNhBtZpKQMSN7/E5oHe3pGUOkug7COCiEzGqcCiio02
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250274364"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250274364"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="773887453"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Feb 2022 22:43:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKE2B-000AWi-MV; Wed, 16 Feb 2022 06:43:27 +0000
Date:   Wed, 16 Feb 2022 14:42:35 +0800
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
Subject: Re: [RESEND v13 07/10] ASoC: qcom: Add support for codec dma driver
Message-ID: <202202161407.5MOObZwm-lkp@intel.com>
References: <1644850708-11099-8-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644850708-11099-8-git-send-email-quic_srivasam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on v5.17-rc4 next-20220215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivasa-Rao-Mandadapu/Add-support-for-audio-on-SC7280-based-targets/20220214-230256
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: csky-randconfig-s032-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161407.5MOObZwm-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e81c7e5d842d2b8039700a71557683e88ce0162d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/Add-support-for-audio-on-SC7280-based-targets/20220214-230256
        git checkout e81c7e5d842d2b8039700a71557683e88ce0162d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash sound/soc/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/qcom/lpass-platform.c:1218:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *dma_buf @@     got unsigned char * @@
   sound/soc/qcom/lpass-platform.c:1218:52: sparse:     expected void [noderef] __iomem *dma_buf
   sound/soc/qcom/lpass-platform.c:1218:52: sparse:     got unsigned char *

vim +1218 sound/soc/qcom/lpass-platform.c

  1209	
  1210	static int lpass_platform_copy(struct snd_soc_component *component,
  1211				       struct snd_pcm_substream *substream, int channel,
  1212				       unsigned long pos, void __user *buf, unsigned long bytes)
  1213	{
  1214		struct snd_pcm_runtime *rt = substream->runtime;
  1215		unsigned int dai_id = component->id;
  1216		int ret = 0;
  1217	
> 1218		void __iomem *dma_buf = rt->dma_area + pos +
  1219					channel * (rt->dma_bytes / rt->channels);
  1220	
  1221		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
  1222			if (is_cdc_dma_port(dai_id))
  1223				ret = copy_from_user_toio(dma_buf, buf, bytes);
  1224			else
  1225				ret = copy_from_user((void __force *)dma_buf, buf, bytes);
  1226		} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
  1227			if (is_cdc_dma_port(dai_id))
  1228				ret = copy_to_user_fromio(buf, dma_buf, bytes);
  1229			else
  1230				ret = copy_to_user(buf, (void __force *)dma_buf, bytes);
  1231		}
  1232	
  1233		return ret;
  1234	}
  1235	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

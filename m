Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839FD59AE8B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiHTNxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHTNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:52:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8430FB491;
        Sat, 20 Aug 2022 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661003572; x=1692539572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6j6S57MxAxhQy8w9ImFEE7IDPq5AbCwpk7d9siINMo=;
  b=Cy1VSWEMHlYvUgj9G+mGb3ExvYWc1EtPshnk0yiFOmSZb2OV+lA4rKje
   QTRBg4nLcaH4GsraiSOKE9C2r8FDC6CztnNJ/B8LMvIA0tA0RpLL+QtSi
   Y/2MNQJsCHlQjaShqgDonHxibHrmChuQ8jii684It8kfCdFK1Jv5Ltbh3
   K10Zikrk9O+Ir5/t+00IG/6byXO1mmjU1DLFaqb03J6iWbt3W5LsGRl+1
   Upo/Yl0GXX1n5e/PVmdTW8+KydxQFniLksC/dTsjfypMdoFdgJeAl7HD+
   qV71krFhpG/BqzMdddHMSRlX66fKNfuXHoRdm/hiDT59ne+trpNsSkjTu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="280141012"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="280141012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 06:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="750806715"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2022 06:52:46 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPOu5-0002kd-2r;
        Sat, 20 Aug 2022 13:52:45 +0000
Date:   Sat, 20 Aug 2022 21:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v5 6/7] remoteproc: qcom: Add support for memory sandbox
Message-ID: <202208202105.f6q5X3x5-lkp@intel.com>
References: <1660649034-4303-7-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660649034-4303-7-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivasa-Rao-Mandadapu/Update-ADSP-pil-loader-for-SC7280-platform/20220816-195318
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220820/202208202105.f6q5X3x5-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c9a41fe60ab62f7a40049c100adcc8087a47669b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/04dc00863cb7b62aa7e5356f81cad5e7720e17ad
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/Update-ADSP-pil-loader-for-SC7280-platform/20220816-195318
        git checkout 04dc00863cb7b62aa7e5356f81cad5e7720e17ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/interconnect/imx/ drivers/remoteproc/ drivers/thunderbolt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/qcom_q6v5_adsp.c:442:54: warning: format specifies type 'void *' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
                           pr_err("failed to map addr = %p mem_size = %x\n", rsc_fw->pa, rsc_fw->len);
                                                        ~~                   ^~~~~~~~~~
                                                        %u
   include/linux/printk.h:518:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:475:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:447:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +442 drivers/remoteproc/qcom_q6v5_adsp.c

   422	
   423	static int adsp_rproc_map_smmu(struct rproc *rproc, int len)
   424	{
   425		struct fw_rsc_devmem *rsc_fw;
   426		struct fw_rsc_hdr *hdr;
   427		int offset;
   428		int ret;
   429		int i;
   430	
   431		if (!rproc->table_ptr)
   432			return 0;
   433	
   434		for (i = 0; i < rproc->table_ptr->num; i++) {
   435			offset = rproc->table_ptr->offset[i];
   436			hdr = (void *)rproc->table_ptr + offset;
   437			rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
   438	
   439			ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
   440						rsc_fw->len, rsc_fw->flags);
   441			if (ret) {
 > 442				pr_err("failed to map addr = %p mem_size = %x\n", rsc_fw->pa, rsc_fw->len);
   443				goto  rproc_smmu_unmap;
   444			}
   445		}
   446	
   447		return 0;
   448	
   449	rproc_smmu_unmap:
   450		adsp_rproc_unmap_smmu(rproc, i);
   451		return ret;
   452	}
   453	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

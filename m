Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20E5919BE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiHMKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiHMKET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:04:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18696B1C8;
        Sat, 13 Aug 2022 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660385059; x=1691921059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sx0SSML7cg2bVL2w/xbWJw6733DiD1Fcno0ewbF4vbI=;
  b=HxHW4T15KDruGk11FntwhvcI9X6tu8+T5C7BmLcQA3KUs7E5ooS4yyAb
   ei6L1hVDf8le7IwPp9tvioWeIj1DYMVU/zgfhsLiLv3Wis0dQ0YIowmWJ
   1cfexE5C6STIyGSo65JrqpAKs85zyv3qFeMWAK9TpHSs0SeI4NbXeUWlu
   +iTMs1ftEKgSs3urUzLb+omtJWsBdOneeGHzWl5HOIZxkbbtCqOgMHmNy
   x/vKzXDBhjW/mbUrI/gEoHY6+zHlsdJYBol1rg90dO//ni9V44sxXmLfa
   /e7TImLDG302MybA9ahnM75/ULi3uy5Kk1XUVen9kvXw91XFPELxIkREg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289312154"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="289312154"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 03:04:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="851807988"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 03:04:14 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMo06-0001YP-0p;
        Sat, 13 Aug 2022 10:04:14 +0000
Date:   Sat, 13 Aug 2022 18:03:23 +0800
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
Cc:     kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v4 6/7] remoteproc: qcom: Add support for memory sandbox
Message-ID: <202208131734.HEn8peGd-lkp@intel.com>
References: <1660308466-410-7-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660308466-410-7-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivasa-Rao-Mandadapu/Update-ADSP-pil-loader-for-SC7280-platform/20220812-205239
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220813/202208131734.HEn8peGd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1d330f9a7446932416d55d93ebba00e3d16bbef9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/Update-ADSP-pil-loader-for-SC7280-platform/20220812-205239
        git checkout 1d330f9a7446932416d55d93ebba00e3d16bbef9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/remoteproc/qcom_q6v5_adsp.c: In function 'adsp_of_unmap_smmu':
>> drivers/remoteproc/qcom_q6v5_adsp.c:343:13: warning: variable 'access_level' set but not used [-Wunused-but-set-variable]
     343 |         int access_level;
         |             ^~~~~~~~~~~~
>> drivers/remoteproc/qcom_q6v5_adsp.c:340:23: warning: variable 'mem_phys' set but not used [-Wunused-but-set-variable]
     340 |         unsigned long mem_phys;
         |                       ^~~~~~~~


vim +/access_level +343 drivers/remoteproc/qcom_q6v5_adsp.c

   337	
   338	static void adsp_of_unmap_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
   339	{
 > 340		unsigned long mem_phys;
   341		unsigned long iova;
   342		unsigned int mem_size;
 > 343		int access_level;
   344		int i;
   345	
   346		for (i = 0; i < len; i++) {
   347			iova = be32_to_cpu(prop[i++]);
   348			mem_phys = be32_to_cpu(prop[i++]);
   349			mem_size = be32_to_cpu(prop[i++]);
   350			access_level = be32_to_cpu(prop[i]);
   351			iommu_unmap(iommu_dom, iova, mem_size);
   352		}
   353	}
   354	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

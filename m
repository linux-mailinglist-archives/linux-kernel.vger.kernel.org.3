Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA938577188
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiGPV2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiGPV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:28:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36186655F;
        Sat, 16 Jul 2022 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658006927; x=1689542927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NgZ4seBUGAZrP1z2/pQzfp6BeM2VbnyWXo2RxyFi9hk=;
  b=JuMziDH0v5fe//Bw0ah3NpOuveUIczpJmDkjkKDfCl8pyXbrIB0EtkbE
   RoQRizYjymDS8k5ErAcRYMJZIwDvqNlk5vkpD3ArCSb1u0tqlqQiH7dqJ
   DCFqwkh0Sh+maPp9kQgLqACPMKIffUFMdQuH9uKuW69skCtjK3z3GPiQj
   nhCqksKLKo72XPD2K4pjGU+EMDtGUAxesT8II2EiQJ0/Hn/35Ok0T9a4M
   ldGgGkbUc/rTVJTzFFtxjjLprtPYf/coY9dFMrEMMuN+4fmckzzrl6fPn
   qsz5Yk0/MK+w7y8s3PlTmQ8vGeLk6Mr12pGzKhKS74+g2z3AyTen/PMf4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="265792647"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="265792647"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 14:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="654782025"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jul 2022 14:28:42 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCpL3-0002AS-92;
        Sat, 16 Jul 2022 21:28:37 +0000
Date:   Sun, 17 Jul 2022 05:27:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/5] media: mediatek: vcodec: Add encoder driver support
 for 34-bit iova
Message-ID: <202207170508.vBteKVVR-lkp@intel.com>
References: <20220716093808.29894-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716093808.29894-2-irui.wang@mediatek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Irui-Wang/support-mt8188-h264-encoder/20220716-235804
base:   git://linuxtv.org/media_tree.git master
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220717/202207170508.vBteKVVR-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cfa5713276c701af0193ab5371d6678515cea42f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Irui-Wang/support-mt8188-h264-encoder/20220716-235804
        git checkout cfa5713276c701af0193ab5371d6678515cea42f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/media/platform/mediatek/vcodec/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c:194: warning: expecting prototype for struct venc_h264_vsi_64. Prototype was for struct venc_h264_vsi_34 instead


vim +194 drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c

   184	
   185	/**
   186	 * struct venc_h264_vsi_64 - Structure for VPU driver control and info share
   187	 *                           Used for 64 bit iova sharing
   188	 * @config: h264 encoder configuration
   189	 * @work_bufs: working buffer information in VPU side
   190	 */
   191	struct venc_h264_vsi_34 {
   192		struct venc_h264_vpu_config_ext config;
   193		struct venc_h264_vpu_buf_34 work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
 > 194	};
   195	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

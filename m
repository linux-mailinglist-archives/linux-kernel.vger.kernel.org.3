Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A24FA82F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbiDINXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbiDINXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:23:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F011C1D;
        Sat,  9 Apr 2022 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649510470; x=1681046470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vfC+nRqScmWArguoYMf/e1ASOBmxDV4xlBHdGwcPDiE=;
  b=i08DAC8o8GBUOoKhGtcLNxJQe5PEcssKB3VuNCkuScbkRmqaiaAmXLRc
   KGCjn49LOGezsBn6HT6y+uX/vU7Kr4sU9Xtvt3L9i9mn4tvEwM8OO4+Jz
   hScWrgVGyEcRd563g8LA9pVFfVCLcq+0qU4KBoq1LgnXGKxekoAYGYWAp
   HMMDRdmcdr0NOdswNhhoCYlOK4De1TPJ94sSUM8aZ4Y86R4dTumwdpg7t
   IdCLiEye7MSMwfLWig38HlGtd8qOA+LQaKm1T9dQ4dIIJ/a8rGyiJSuyf
   MoFFKr7zCF49w5in/O0wanabeodcsybq7m5bhHulRHWkKEZyEGQf9+bf2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259398775"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="259398775"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 06:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="622153364"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 06:21:04 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndB1T-00002H-Ef;
        Sat, 09 Apr 2022 13:21:03 +0000
Date:   Sat, 9 Apr 2022 21:19:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        Irui Wang <irui.wang@mediatek.com>,
        George Sun <george.sun@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9, 16/17] media: mediatek: vcodec: support stateless VP9
 decoding
Message-ID: <202204092137.3RrpN4Hr-lkp@intel.com>
References: <20220408120240.29571-17-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408120240.29571-17-yunfei.dong@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on v5.18-rc1 next-20220408]
[cannot apply to remoteproc/rproc-next drm-tip/drm-tip]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunfei-Dong/media-mediatek-vcodec-Add-vdec-enable-disable-hardware-helpers/20220408-210244
base:   git://linuxtv.org/media_tree.git master
config: arm64-randconfig-r015-20220408 (https://download.01.org/0day-ci/archive/20220409/202204092137.3RrpN4Hr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/251c7c77f6690881357df39867a32a03eb7db3b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yunfei-Dong/media-mediatek-vcodec-Add-vdec-enable-disable-hardware-helpers/20220408-210244
        git checkout 251c7c77f6690881357df39867a32a03eb7db3b7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.o: in function `vdec_vp9_slice_update_prob.isra.0':
>> vdec_vp9_req_lat_if.c:(.text+0x2654): undefined reference to `v4l2_vp9_adapt_noncoef_probs'
   vdec_vp9_req_lat_if.c:(.text+0x2654): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `v4l2_vp9_adapt_noncoef_probs'
>> aarch64-linux-ld: vdec_vp9_req_lat_if.c:(.text+0x26c0): undefined reference to `v4l2_vp9_adapt_coef_probs'
   vdec_vp9_req_lat_if.c:(.text+0x26c0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `v4l2_vp9_adapt_coef_probs'
   aarch64-linux-ld: vdec_vp9_req_lat_if.c:(.text+0x26d8): undefined reference to `v4l2_vp9_adapt_coef_probs'
   vdec_vp9_req_lat_if.c:(.text+0x26d8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `v4l2_vp9_adapt_coef_probs'
   aarch64-linux-ld: vdec_vp9_req_lat_if.c:(.text+0x26f0): undefined reference to `v4l2_vp9_adapt_coef_probs'
   vdec_vp9_req_lat_if.c:(.text+0x26f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `v4l2_vp9_adapt_coef_probs'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

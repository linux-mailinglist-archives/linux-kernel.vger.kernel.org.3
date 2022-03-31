Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0264ED526
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiCaIFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiCaIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:05:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37F5FE1;
        Thu, 31 Mar 2022 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648713833; x=1680249833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hsAJrheBoayi+K8mxNtCKJECO7Ufn3EWs6stfrLZWoE=;
  b=HtuxN5EuQyeyKtO1j/OyIFzyVqqyysfZhEehVYp1KD9fGDAAVyxgxLgh
   hy1CmJXmdVYenbdOjmxhwoV7Z3X7rLSIuAiApbZrrP+6P3mbINRK4aVIG
   27wM/29uzDMCsVfYwfyrBj/seZEmKzlk8wn5sUYYkdPy2tURIMl4wCo0H
   xLPWTuC00VUfoNZ3vJ2IErUE2q12o7cIkR/FwWs5dP2B0X2tSgoMpp+1E
   pe1MVQMXKz/tbWTYvAW9BT6UcaV/ElITB5+lR2GyTVpkcghKFq+KlTKJX
   1h+xOVQXS0TcXODrvUwaA6gAEd5C09PXgPjix3YZ6pb8xmXUUAr60JtqG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259462311"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="259462311"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="520319736"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Mar 2022 01:03:45 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZpmS-00004g-Pi;
        Thu, 31 Mar 2022 08:03:44 +0000
Date:   Thu, 31 Mar 2022 16:02:59 +0800
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
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Steve Cho <stevecho@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8, 16/17] media: mediatek: vcodec: support stateless VP9
 decoding
Message-ID: <202203311506.19PAVLDA-lkp@intel.com>
References: <20220331024801.29229-17-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331024801.29229-17-yunfei.dong@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master next-20220331]
[cannot apply to remoteproc/rproc-next linux/master v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunfei-Dong/media-mediatek-vcodec-Add-vdec-enable-disable-hardware-helpers/20220331-114806
base:   git://linuxtv.org/media_tree.git master
config: parisc-buildonly-randconfig-r002-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311506.19PAVLDA-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7b396103061b487d6e9bc84be29de59e7eccc4c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yunfei-Dong/media-mediatek-vcodec-Add-vdec-enable-disable-hardware-helpers/20220331-114806
        git checkout 7b396103061b487d6e9bc84be29de59e7eccc4c6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/media/platform/mediatek/vcodec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c: In function 'vdec_vp9_slice_map_counts_eob_coef':
>> drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1235:69: error: assignment to 'u32 (*)[3]' {aka 'unsigned int (*)[3]'} from incompatible pointer type 'u32 (*)[4]' {aka 'unsigned int (*)[4]'} [-Werror=incompatible-pointer-types]
    1235 |                                 counts_helper->coeff[i][j][k][l][m] =
         |                                                                     ^
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1242:69: error: assignment to 'u32 (*)[3]' {aka 'unsigned int (*)[3]'} from incompatible pointer type 'u32 (*)[4]' {aka 'unsigned int (*)[4]'} [-Werror=incompatible-pointer-types]
    1242 |                                 counts_helper->coeff[i][j][k][l][m] =
         |                                                                     ^
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c: In function 'vdec_vp9_slice_counts_map_helper':
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1257:25: warning: unused variable 'm' [-Wunused-variable]
    1257 |         int i, j, k, l, m;
         |                         ^
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1257:22: warning: unused variable 'l' [-Wunused-variable]
    1257 |         int i, j, k, l, m;
         |                      ^
   In file included from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:7:
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c: In function 'vdec_vp9_slice_lat_decode':
>> include/linux/kern_levels.h:5:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:576:19: note: in expansion of macro 'KERN_DEBUG'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/../mtk_vcodec_util.h:45:9: note: in expansion of macro 'pr_debug'
      45 |         pr_debug("[MTK_VCODEC][%d]: " fmt "\n",                 \
         |         ^~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1981:9: note: in expansion of macro 'mtk_vcodec_debug'
    1981 |         mtk_vcodec_debug(instance, "lat dma 1 0x%llx 0x%llx\n",
         |         ^~~~~~~~~~~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:576:19: note: in expansion of macro 'KERN_DEBUG'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/../mtk_vcodec_util.h:45:9: note: in expansion of macro 'pr_debug'
      45 |         pr_debug("[MTK_VCODEC][%d]: " fmt "\n",                 \
         |         ^~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1981:9: note: in expansion of macro 'mtk_vcodec_debug'
    1981 |         mtk_vcodec_debug(instance, "lat dma 1 0x%llx 0x%llx\n",
         |         ^~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c: In function 'vdec_vp9_slice_core_decode':
>> include/linux/kern_levels.h:5:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:576:19: note: in expansion of macro 'KERN_DEBUG'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/../mtk_vcodec_util.h:45:9: note: in expansion of macro 'pr_debug'
      45 |         pr_debug("[MTK_VCODEC][%d]: " fmt "\n",                 \
         |         ^~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:2050:9: note: in expansion of macro 'mtk_vcodec_debug'
    2050 |         mtk_vcodec_debug(instance, "core dma_addr_end 0x%llx\n", pfc->vsi.trans.dma_addr_end);
         |         ^~~~~~~~~~~~~~~~
   At top level:
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:534:26: warning: 'vdec_vp9_slice_mv_fp_tree' defined but not used [-Wunused-const-variable=]
     534 | static const signed char vdec_vp9_slice_mv_fp_tree[6] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:529:26: warning: 'vdec_vp9_slice_mv_class0_tree' defined but not used [-Wunused-const-variable=]
     529 | static const signed char vdec_vp9_slice_mv_class0_tree[2] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:523:26: warning: 'vdec_vp9_slice_mv_class_tree' defined but not used [-Wunused-const-variable=]
     523 | static const signed char vdec_vp9_slice_mv_class_tree[20] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:518:26: warning: 'vdec_vp9_slice_mv_joint_tree' defined but not used [-Wunused-const-variable=]
     518 | static const signed char vdec_vp9_slice_mv_joint_tree[6] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:513:26: warning: 'vdec_vp9_slice_switchable_interp_tree' defined but not used [-Wunused-const-variable=]
     513 | static const signed char vdec_vp9_slice_switchable_interp_tree[4] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:508:26: warning: 'vdec_vp9_slice_partition_tree' defined but not used [-Wunused-const-variable=]
     508 | static const signed char vdec_vp9_slice_partition_tree[6] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:503:26: warning: 'vdec_vp9_slice_intra_mode_tree' defined but not used [-Wunused-const-variable=]
     503 | static const signed char vdec_vp9_slice_intra_mode_tree[18] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:498:26: warning: 'vdec_vp9_slice_inter_mode_tree' defined but not used [-Wunused-const-variable=]
     498 | static const signed char vdec_vp9_slice_inter_mode_tree[6] = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1235 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c

  1217	
  1218	static
  1219	void vdec_vp9_slice_map_counts_eob_coef(unsigned int i, unsigned int j, unsigned int k,
  1220						struct vdec_vp9_slice_frame_counts *counts,
  1221						struct v4l2_vp9_frame_symbol_counts *counts_helper)
  1222	{
  1223		u32 l, m;
  1224	
  1225		/*
  1226		 * helper eo -> mtk eo
  1227		 * helpre e1 -> mtk c3
  1228		 * helper c0 -> c0
  1229		 * helper c1 -> c1
  1230		 * helper c2 -> c2
  1231		 */
  1232		for (l = 0; l < 6; l++) {
  1233			for (m = 0; m < VP9_BAND_6(l); m++) {
  1234				if (l == 0) {
> 1235					counts_helper->coeff[i][j][k][l][m] =
  1236						&counts->coef_probs[i][j][k].band_0[m];
  1237					counts_helper->eob[i][j][k][l][m][0] =
  1238						&counts->eob_branch[i][j][k].band_0[m];
  1239					counts_helper->eob[i][j][k][l][m][1] =
  1240						&counts->coef_probs[i][j][k].band_0[m][3];
  1241				} else {
  1242					counts_helper->coeff[i][j][k][l][m] =
  1243						&counts->coef_probs[i][j][k].band_1_5[l - 1][m];
  1244					counts_helper->eob[i][j][k][l][m][0] =
  1245						&counts->eob_branch[i][j][k].band_1_5[l - 1][m];
  1246					counts_helper->eob[i][j][k][l][m][1] =
  1247						&counts->coef_probs[i][j][k].band_1_5[l - 1][m][3];
  1248				}
  1249			}
  1250		}
  1251	}
  1252	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

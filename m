Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEB5B13BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIHEd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHEd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:33:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EF87F24E;
        Wed,  7 Sep 2022 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662611634; x=1694147634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVmuOHmwKB+Z7hUiALcHgJEc00AqO5+3NsAVP48bca8=;
  b=DeLAyw4IZGkJJwrs6929DxDLynirRIVle3sYMd0ZbPZGANChWEh8Jgcf
   ZLdN7cgYpcO8bnslbWgRoGPxM8dPnprx0PXJk116cqe8ztpmWqnQSbmo3
   E2tWMkFSMxVZtbAPdWCW4cSMt3OKiyChhtB2dD1BgbM026rUqg4qORAOG
   B9qZcjWy5h5gByTPbbNfTxSGtCoQmwW6HqjPpUM59dPnhQbqZyWlpBTiq
   fOi3uuNZbk2tQ1BReaG+ZqhNRucd6pR+zICRqZkp5ZkUrALT7MYzao3hk
   FY7m88KYIBgsjao20HFnO+tnizft/i7CgYQmti9VLzPHPKGF+NT/G2wGH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="284083429"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="284083429"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 21:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="757044311"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 21:33:51 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW9Ec-0007MZ-2G;
        Thu, 08 Sep 2022 04:33:50 +0000
Date:   Thu, 8 Sep 2022 12:33:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, davem@davemloft.net,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: kprobes: Free instructions in arch_remove_kprobe()
Message-ID: <202209081219.MDryXDEc-lkp@intel.com>
References: <1662604440-30524-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662604440-30524-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.0-rc4]
[also build test WARNING on linus/master next-20220907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/sparc-kprobes-Free-instructions-in-arch_remove_kprobe/20220908-103454
base:    7e18e42e4b280c85b76967a9106a13ca61c16179
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220908/202209081219.MDryXDEc-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/13d8569b8b252a60b519215d42f438582f00a37f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tiezhu-Yang/sparc-kprobes-Free-instructions-in-arch_remove_kprobe/20220908-103454
        git checkout 13d8569b8b252a60b519215d42f438582f00a37f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash arch/sparc/ drivers/gpu/ kernel//

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from include/drm/drm_connector.h:32,
                    from include/drm/drm_modes.h:33,
                    from include/drm/drm_crtc.h:32,
                    from include/drm/drm_atomic.h:31,
                    from drivers/gpu/drm/drm_self_refresh_helper.c:13:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:29:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:26:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c: In function 'bios_get_board_layout_info':
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:3319:29: warning: variable 'bp' set but not used [-Wunused-but-set-variable]
    3319 |         struct bios_parser *bp;
         |                             ^~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:26:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:30:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:31:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:28:
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: warning: initialized field overwritten [-Woverride-init]
     568 | #define mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL 0x1B7F
         |                                           ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro 'mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL'
     157 |         .reg_name = mm ## block ## id ## _ ## reg_name
         |                     ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro 'SRI'
     170 |         SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro 'XFM_COMMON_REG_LIST_DCE60'
     183 |                 XFM_COMMON_REG_LIST_DCE60(id)\
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:17: note: in expansion of macro 'transform_regs'
     187 |                 transform_regs(0),
         |                 ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: note: (near initialization for 'xfm_regs[0].DCFE_MEM_LIGHT_SLEEP_CNTL')
     568 | #define mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL 0x1B7F
         |                                           ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro 'mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL'
     157 |         .reg_name = mm ## block ## id ## _ ## reg_name
         |                     ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro 'SRI'
     170 |         SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro 'XFM_COMMON_REG_LIST_DCE60'
     183 |                 XFM_COMMON_REG_LIST_DCE60(id)\
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:17: note: in expansion of macro 'transform_regs'
     187 |                 transform_regs(0),
         |                 ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:645:43: warning: initialized field overwritten [-Woverride-init]
     645 | #define mmCRTC1_DCFE_MEM_LIGHT_SLEEP_CNTL 0x1E7F
         |                                           ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro 'mmCRTC1_DCFE_MEM_LIGHT_SLEEP_CNTL'
     157 |         .reg_name = mm ## block ## id ## _ ## reg_name
         |                     ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro 'SRI'
     170 |         SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro 'XFM_COMMON_REG_LIST_DCE60'
     183 |                 XFM_COMMON_REG_LIST_DCE60(id)\
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:188:17: note: in expansion of macro 'transform_regs'
     188 |                 transform_regs(1),
         |                 ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:645:43: note: (near initialization for 'xfm_regs[1].DCFE_MEM_LIGHT_SLEEP_CNTL')
     645 | #define mmCRTC1_DCFE_MEM_LIGHT_SLEEP_CNTL 0x1E7F
         |                                           ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro 'mmCRTC1_DCFE_MEM_LIGHT_SLEEP_CNTL'
     157 |         .reg_name = mm ## block ## id ## _ ## reg_name
         |                     ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro 'SRI'
     170 |         SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro 'XFM_COMMON_REG_LIST_DCE60'
     183 |                 XFM_COMMON_REG_LIST_DCE60(id)\
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:188:17: note: in expansion of macro 'transform_regs'
     188 |                 transform_regs(1),
         |                 ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:722:43: warning: initialized field overwritten [-Woverride-init]
     722 | #define mmCRTC2_DCFE_MEM_LIGHT_SLEEP_CNTL 0x417F
         |                                           ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro 'mmCRTC2_DCFE_MEM_LIGHT_SLEEP_CNTL'
     157 |         .reg_name = mm ## block ## id ## _ ## reg_name
         |                     ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro 'SRI'
     170 |         SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro 'XFM_COMMON_REG_LIST_DCE60'
     183 |                 XFM_COMMON_REG_LIST_DCE60(id)\
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:189:17: note: in expansion of macro 'transform_regs'
     189 |                 transform_regs(2),
         |                 ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:722:43: note: (near initialization for 'xfm_regs[2].DCFE_MEM_LIGHT_SLEEP_CNTL')
     722 | #define mmCRTC2_DCFE_MEM_LIGHT_SLEEP_CNTL 0x417F
         |                                           ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro 'mmCRTC2_DCFE_MEM_LIGHT_SLEEP_CNTL'
     157 |         .reg_name = mm ## block ## id ## _ ## reg_name
         |                     ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro 'SRI'
     170 |         SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:17: note: in expansion of macro 'XFM_COMMON_REG_LIST_DCE60'
     183 |                 XFM_COMMON_REG_LIST_DCE60(id)\
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:189:17: note: in expansion of macro 'transform_regs'
     189 |                 transform_regs(2),
         |                 ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:799:43: warning: initialized field overwritten [-Woverride-init]
     799 | #define mmCRTC3_DCFE_MEM_LIGHT_SLEEP_CNTL 0x447F
         |                                           ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:21: note: in expansion of macro 'mmCRTC3_DCFE_MEM_LIGHT_SLEEP_CNTL'
     157 |         .reg_name = mm ## block ## id ## _ ## reg_name
         |                     ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:9: note: in expansion of macro 'SRI'
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:25:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2845:6: warning: no previous prototype for 'dc_reset_state' [-Wmissing-prototypes]
    2845 | void dc_reset_state(struct dc *dc, struct dc_state *context)
         |      ^~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:30:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:28:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/dc_link_ddc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:37:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:26:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1848:6: warning: no previous prototype for 'is_timing_changed' [-Wmissing-prototypes]
    1848 | bool is_timing_changed(struct dc_stream_state *cur_stream,
         |      ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:28:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:24:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function 'dp_retrieve_lttpr_cap':
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:5062:24: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    5062 |         enum dc_status status = DC_ERROR_UNEXPECTED;
         |                        ^~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:31:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:26:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c: In function 'apply_degamma_for_user_regamma':
   drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1691:36: warning: implicit conversion from 'enum <anonymous>' to 'enum dc_transfer_func_predefined' [-Wenum-conversion]
    1691 |         build_coefficients(&coeff, true);
         |                                    ^~~~
--
   In file included from include/linux/kprobes.h:32,
                    from include/linux/kgdb.h:19,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:28:
>> arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:129:6: warning: no previous prototype for 'amdgpu_ucode_print_imu_hdr' [-Wmissing-prototypes]
     129 | void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
..


vim +20 arch/sparc/include/asm/kprobes.h

    19	
  > 20	void arch_remove_kprobe(struct kprobe *p);
    21	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

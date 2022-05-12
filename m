Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB6452545C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357432AbiELSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357427AbiELSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:00:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F457CCE
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652378448; x=1683914448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VewaPEwaCqxkzJdzVuz5aaMaBQ/3r6PmPj/lLlQP8DE=;
  b=lFYV0T6GLn8bJjCGANzHiOuMtSIEcHc/1yu18Yvz5jFf7ns4NQG5uST5
   1dxJJ2NewZuWLSHeyTadmkKHb5qsvbpm2K9Ot8HhzOOeypJgERXYB4sMC
   GFYpOWHYLhaYZqlMW1qJonSUa9DrBiG64caDfFJzvLAGZwq2KY+n+RUS6
   fjeoFnSE3CbVbJ2DXjaUrjGFBdPEEUgD17Q4uJgJ2LJkkhxGS8Arc7Gv+
   r48OTRA607vfZ49+K0dbBR4ByoPzK9lu2OseFpYpmrWMYSCSqGuPCIiLP
   p/6oUM+X0yRuLHgPzIE1ykZP2S8xDd2UHMLheSqqcQkTostl2ADTLCUes
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="268931168"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="268931168"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="670961673"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2022 11:00:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npD7C-000KmS-US;
        Thu, 12 May 2022 18:00:42 +0000
Date:   Fri, 13 May 2022 01:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     pengfuyuan <pengfuyuan@kylinos.cn>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     kbuild-all@lists.01.org, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pengfuyuan <pengfuyuan@kylinos.cn>
Subject: Re: [PATCH] drm/amd/display: Remove macro DC_DEFAULT_LOG_MASK
Message-ID: <202205130102.UP3I0Eb0-lkp@intel.com>
References: <20220512084851.104099-1-pengfuyuan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512084851.104099-1-pengfuyuan@kylinos.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi pengfuyuan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/pengfuyuan/drm-amd-display-Remove-macro-DC_DEFAULT_LOG_MASK/20220512-185320
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: powerpc64-randconfig-s032-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130102.UP3I0Eb0-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/94b3092ea272cf77105cc7b19fcffc44b49e1a71
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review pengfuyuan/drm-amd-display-Remove-macro-DC_DEFAULT_LOG_MASK/20220512-185320
        git checkout 94b3092ea272cf77105cc7b19fcffc44b49e1a71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:30:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/include/bios_parser_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/clock_source.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw_sequencer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:30:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/include/bios_parser_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/clock_source.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw_sequencer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_trace.h:24,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/include/bios_parser_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/clock_source.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw_sequencer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_trace.h:24,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_begin':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:97:25: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_vsx'? [-Werror=implicit-function-declaration]
      97 |                         enable_kernel_altivec();
         |                         ^~~~~~~~~~~~~~~~~~~~~
         |                         enable_kernel_vsx
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_end':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:133:25: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_vsx'? [-Werror=implicit-function-declaration]
     133 |                         disable_kernel_altivec();
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         disable_kernel_vsx
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_trace.h:24,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:27:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:34:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:36:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:42:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:29:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../display_mode_lib.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:26:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c: In function 'dml20_ModeSupportAndSystemConfigurationFull':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3900:72: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3900 |                                 locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3904:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3904 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3907:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3907 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3960:80: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3960 |                                         locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                                ^
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../display_mode_lib.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:26:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c: In function 'dml20v2_ModeSupportAndSystemConfigurationFull':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4011:72: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4011 |                                 locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4015:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4015 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4018:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4018 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4021:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4021 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4074:80: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4074 |                                         locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                                ^
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/../display_mode_lib.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c: In function 'dml21_ModeSupportAndSystemConfigurationFull':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4103:72: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4103 |                                 locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4107:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4107 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4110:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4110 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4113:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4113 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4166:80: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4166 |                                         locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                                ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:5231:60: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    5231 |                         mode_lib->vba.ODMCombineEnabled[k] = false;
         |                                                            ^
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/include/bios_parser_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/clock_source.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw_sequencer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3055:24: warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable]
    3055 |                 double MaxUsedBW = 0;
         |                        ^~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/include/bios_parser_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/clock_source.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw_sequencer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c:41:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/include/logger_interface.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:28:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:31,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:32:
>> drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:26: error: unterminated #ifndef
      26 | #ifndef __DAL_LOGGER_TYPES_H__
         | 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c: In function 'dcn3_get_pix_clk_dividers':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1258:32: warning: variable 'clk_src' set but not used [-Wunused-but-set-variable]
    1258 |         struct dce110_clk_src *clk_src;
         |                                ^~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:32:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
..


vim +26 drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h

4562236b3bc0a2 Harry Wentland 2017-09-12 @26  #ifndef __DAL_LOGGER_TYPES_H__
4562236b3bc0a2 Harry Wentland 2017-09-12  27  #define __DAL_LOGGER_TYPES_H__
4562236b3bc0a2 Harry Wentland 2017-09-12  28  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

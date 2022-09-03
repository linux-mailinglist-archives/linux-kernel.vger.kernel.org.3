Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D75ABED2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiICLsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiICLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:48:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8403341F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662205713; x=1693741713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PTRpdYTZVjkzB9A3G/dP9KDaNGEagJf1u6l6G72lnkM=;
  b=NgLkUcrTz18V1daZMQJ7yTvISc0vSRQRmB6IobPxav9YNgulj1iaHSph
   xfP1Ul0BVqxDFdOmCYHOwR3GTWfAaEgf9xzozgomKjloIsz4fkBE4v8CZ
   9Bg+W40zmCIEvDGhE+aY3Q4Tv0CBtZ3kkzYGjM8GTZ8rPtpElGNWTYmU7
   l6BoyLI8YVJfqbWlGw8RtemUnKT22JNZehEmiuH5NLR+mXGf8AyCngWyg
   xoIWLsR3rUa9GAMTzg9ghHItQgg3gT9UneeYNehPjQ+NtsC4mDijMcuk/
   AtK0rdRhnoTipA7TyrcEb06589bBuN+J4OToJ1QrQXsUKZhlDK8dNe9g1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="360108051"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="360108051"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 04:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="702412172"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2022 04:48:28 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oURdT-0001ad-1q;
        Sat, 03 Sep 2022 11:48:27 +0000
Date:   Sat, 3 Sep 2022 19:47:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     kbuild-all@lists.01.org, kunit-dev@googlegroups.com,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Subject: Re: [PATCH v2 7/8] drm/amd/display: Introduce KUnit tests to
 dc_dmub_srv library
Message-ID: <202209031904.Q8eJt6X4-lkp@intel.com>
References: <20220831172239.344446-8-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220831172239.344446-8-mairacanal@riseup.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Maíra,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-intel/for-linux-next drm-tip/drm-tip linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-ra-Canal/drm-amd-display-Introduce-KUnit-to-Display-Mode-Library/20220901-012715
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209031904.Q8eJt6X4-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/510f486251586c33675dc1e1639f1b5fa2bd0da7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ma-ra-Canal/drm-amd-display-Introduce-KUnit-to-Display-Mode-Library/20220901-012715
        git checkout 510f486251586c33675dc1e1639f1b5fa2bd0da7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:814:
   drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c: In function 'populate_subvp_cmd_drr_info_test':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c:260:9: error: implicit declaration of function 'populate_subvp_cmd_drr_info'; did you mean 'populate_subvp_cmd_drr_info_test'? [-Werror=implicit-function-declaration]
     260 |         populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_pipe,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         populate_subvp_cmd_drr_info_test
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:31:
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
   cc1: some warnings being treated as errors


vim +260 drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c

   246	
   247	KUNIT_ARRAY_PARAM(populate_subvp_cmd_drr_info, populate_subvp_cmd_drr_info_cases,
   248			  populate_subvp_cmd_drr_info_test_to_desc);
   249	
   250	static void populate_subvp_cmd_drr_info_test(struct kunit *test)
   251	{
   252		const struct populate_subvp_cmd_drr_info_test_case *test_param =
   253			test->param_value;
   254		struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data;
   255	
   256		pipe_data = kunit_kzalloc(test,
   257					  sizeof(struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2),
   258					  GFP_KERNEL);
   259	
 > 260		populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_pipe,
   261					    test_param->vblank_pipe, pipe_data);
   262	
   263		KUNIT_EXPECT_EQ(test, test_param->drr_in_use,
   264				pipe_data->pipe_config.vblank_data.drr_info.drr_in_use);
   265		KUNIT_EXPECT_EQ(test, test_param->drr_window_size_ms,
   266				pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms);
   267		KUNIT_EXPECT_EQ(test, test_param->use_ramping,
   268				pipe_data->pipe_config.vblank_data.drr_info.use_ramping);
   269		KUNIT_EXPECT_EQ(test, test_param->min_vtotal_supported,
   270				pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported);
   271		KUNIT_EXPECT_EQ(test, test_param->max_vtotal_supported,
   272				pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported);
   273	}
   274	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

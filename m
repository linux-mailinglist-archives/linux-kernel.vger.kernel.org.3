Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E20517B68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiECBNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiECBNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:13:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD759976
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651540164; x=1683076164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xcX7ZSUlfJN5lM63F+DM0r69oVAMDHJEKRwiRlW4Bp8=;
  b=mAz0Eg0JK6kPg5FnqUXIcnvCK6Q71FflojB1XM0u5CPaqgVHbovSL7oG
   cGImK5csttMbBSszOycgeCvQyYQ4l54mA3qzToCVW2UEV03Jp7jakO0K8
   LdhkxTX/R1YlOYaU2Gx3XrIi/Gl2M8UjB6IXPb2Rk0QFLv0kbPpsqRX4z
   XBMvltifxg0laXIWq9ujXnWs7pThuJA5uzJcFvktb0mFssTGfwDeZIQxa
   waq2KU0rbjL3NEVzha65gZ+Sb2a7qW2tKQeh1Oaviieh7CMbw52R1mnBl
   ad1JNlZuPwpu6jHUSoKDfgqFe1WWVMmOThXdVbXtj8/MxTd2ZbUWbgxy5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267246251"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="267246251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 18:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="546827160"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2022 18:06:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlgzQ-000A1r-JU;
        Tue, 03 May 2022 01:06:08 +0000
Date:   Tue, 3 May 2022 09:05:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Message-ID: <202205030810.VwAEOAqj-lkp@intel.com>
References: <20220502153900.408522-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502153900.408522-4-javierm@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

I love your patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on shawnguo/for-next linus/master linux/master v5.18-rc5 next-20220502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Martinez-Canillas/drm-Allow-simpledrm-to-setup-its-emulated-FB-as-firmware-provided/20220502-234145
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220503/202205030810.VwAEOAqj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/28ef46724e385165777a21d9f661188fa2577a1e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Javier-Martinez-Canillas/drm-Allow-simpledrm-to-setup-its-emulated-FB-as-firmware-provided/20220502-234145
        git checkout 28ef46724e385165777a21d9f661188fa2577a1e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tiny/simpledrm.c: In function 'simpledrm_probe':
>> drivers/gpu/drm/tiny/simpledrm.c:904:38: error: implicit declaration of function 'DRM_FB_SET_OPTION'; did you mean 'DRM_FB_GET_OPTION'? [-Werror=implicit-function-declaration]
     904 |         drm_fbdev_generic_setup(dev, DRM_FB_SET_OPTION(DRM_FB_FW, 1));
         |                                      ^~~~~~~~~~~~~~~~~
         |                                      DRM_FB_GET_OPTION
>> drivers/gpu/drm/tiny/simpledrm.c:904:56: error: 'DRM_FB_FW' undeclared (first use in this function)
     904 |         drm_fbdev_generic_setup(dev, DRM_FB_SET_OPTION(DRM_FB_FW, 1));
         |                                                        ^~~~~~~~~
   drivers/gpu/drm/tiny/simpledrm.c:904:56: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +904 drivers/gpu/drm/tiny/simpledrm.c

   884	
   885	/*
   886	 * Platform driver
   887	 */
   888	
   889	static int simpledrm_probe(struct platform_device *pdev)
   890	{
   891		struct simpledrm_device *sdev;
   892		struct drm_device *dev;
   893		int ret;
   894	
   895		sdev = simpledrm_device_create(&simpledrm_driver, pdev);
   896		if (IS_ERR(sdev))
   897			return PTR_ERR(sdev);
   898		dev = &sdev->dev;
   899	
   900		ret = drm_dev_register(dev, 0);
   901		if (ret)
   902			return ret;
   903	
 > 904		drm_fbdev_generic_setup(dev, DRM_FB_SET_OPTION(DRM_FB_FW, 1));
   905	
   906		return 0;
   907	}
   908	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

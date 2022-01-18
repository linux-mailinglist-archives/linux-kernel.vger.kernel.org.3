Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90F64929DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbiARPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:49:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:39701 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345834AbiARPs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642520939; x=1674056939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n2HdvlkezkO7MNNO0epANEP8x/sWSiaZABc03KE2VuQ=;
  b=mC3AfNMRImOOLVpVRKqF5GTZuFauoPWY2pbXLTi5m8azD63K9WpUIfgB
   7GvhB7HtFX2y3OXUS6j1FBle50FStlLgUk1OtakO8SOg83i3seTtIAcz8
   TrO/9EUzjGo+iL6sK/sUDXmGN4cAnkEKA3OxVLgf6AmhqaB4NE9P6IcC3
   D7ikgy0Qta/lCMTXbSCd1G++ALeMSvH0K63xs1igL1iwYG5CRUeXkQZ6h
   e1Woux8OxSFBKGVTSXHAto+fKlcqjZLpz2ogBAAvcEnDQRWMTuYGc6CHw
   dr84VJi064OsLDCB6K3/Uc+7WRDWv+dcfL+r3A1mpoCKanwGd6jyvZNX7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="331194297"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="331194297"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 07:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="625547181"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 07:48:57 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9qjA-000Cig-O3; Tue, 18 Jan 2022 15:48:56 +0000
Date:   Tue, 18 Jan 2022 23:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: drivers/media/i2c/ov8865.c:2799 ov8865_get_selection() warn:
 inconsistent indenting
Message-ID: <202201182306.qGenOYaU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe81ba137ebcc7f236780996a0b375732c07e85c
commit: acd25e220921de232b027c677668c93aa6ba5d15 media: i2c: Add .get_selection() support to ov8865
date:   7 weeks ago
config: x86_64-randconfig-m001-20220117 (https://download.01.org/0day-ci/archive/20220118/202201182306.qGenOYaU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/media/i2c/ov8865.c:2799 ov8865_get_selection() warn: inconsistent indenting

vim +2799 drivers/media/i2c/ov8865.c

  2787	
  2788	static int ov8865_get_selection(struct v4l2_subdev *subdev,
  2789					struct v4l2_subdev_state *state,
  2790					struct v4l2_subdev_selection *sel)
  2791	{
  2792		struct ov8865_sensor *sensor = ov8865_subdev_sensor(subdev);
  2793	
  2794		switch (sel->target) {
  2795		case V4L2_SEL_TGT_CROP:
  2796			mutex_lock(&sensor->mutex);
  2797				__ov8865_get_pad_crop(sensor, state, sel->pad,
  2798						      sel->which, &sel->r);
> 2799			mutex_unlock(&sensor->mutex);
  2800			break;
  2801		case V4L2_SEL_TGT_NATIVE_SIZE:
  2802			sel->r.top = 0;
  2803			sel->r.left = 0;
  2804			sel->r.width = OV8865_NATIVE_WIDTH;
  2805			sel->r.height = OV8865_NATIVE_HEIGHT;
  2806			break;
  2807		case V4L2_SEL_TGT_CROP_BOUNDS:
  2808		case V4L2_SEL_TGT_CROP_DEFAULT:
  2809			sel->r.top = OV8865_ACTIVE_START_TOP;
  2810			sel->r.left = OV8865_ACTIVE_START_LEFT;
  2811			sel->r.width = OV8865_ACTIVE_WIDTH;
  2812			sel->r.height = OV8865_ACTIVE_HEIGHT;
  2813			break;
  2814		default:
  2815			return -EINVAL;
  2816		}
  2817	
  2818		return 0;
  2819	}
  2820	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

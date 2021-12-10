Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C904F46FFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbhLJL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:29:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:55233 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234694AbhLJL3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639135564; x=1670671564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fl1v1NReSXeZzc0ak70fqcBYA6DzW+LJpXVRza0dBKo=;
  b=ERiS/sHYlHsCiGzBzMlg/XTBuTd32BrQAz9lq77JwY2bDDj8n33FSkeJ
   Ecrot/rnpIPPTjSUXqmKGDKFkb46zo55SZ0yzVnQdgHK5XkR5PeTcM/ES
   m1P49eaNyRyvjmDyDVdBcY6+fbWtt+mnv97IpaJT66zwzOHhJfiXh5ByR
   15mN1PQIp/GLDKWi9A2fZJaXKozsarc7KADQdK8Hp2OqBs01ZEb3qSnzP
   BNoRF71VNlFeSM6tDy0gPJJgdFOxLli8YIrhVlqMhf6IqKon1SK3jop6v
   C5xbh0KTtRb54hc7e1Uj2Hn08R0dcE8HpunigZ0vJR/ztqEdxxFOZnDmG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301712989"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="301712989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:26:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="680713165"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2021 03:26:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mve2L-00037V-OQ; Fri, 10 Dec 2021 11:26:01 +0000
Date:   Fri, 10 Dec 2021 19:25:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [drm-msm:msm-next-plus-fixes 69/72]
 drivers/gpu/drm/msm/dp/dp_drm.c:246:2-7: WARNING: invalid free of devm_
 allocated data
Message-ID: <202112101918.adnak8vR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/drm/msm.git msm-next-plus-fixes
head:   1c1dcb9d8883f42ea116d99f78e42a7c399f8278
commit: 8a3b4c17f863cde8e8743edd8faffe916c49b960 [69/72] drm/msm/dp: employ bridge mechanism for display enable and disable
config: nds32-randconfig-c004-20211208 (https://download.01.org/0day-ci/archive/20211210/202112101918.adnak8vR-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/msm/dp/dp_drm.c:246:2-7: WARNING: invalid free of devm_ allocated data

vim +246 drivers/gpu/drm/msm/dp/dp_drm.c

   225	
   226	struct drm_bridge *msm_dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
   227				struct drm_encoder *encoder)
   228	{
   229		int rc;
   230		struct msm_dp_bridge *dp_bridge;
   231		struct drm_bridge *bridge;
   232	
   233		dp_bridge = devm_kzalloc(dev->dev, sizeof(*dp_bridge), GFP_KERNEL);
   234		if (!dp_bridge)
   235			return ERR_PTR(-ENOMEM);
   236	
   237		dp_bridge->dp_display = dp_display;
   238	
   239		bridge = &dp_bridge->bridge;
   240		bridge->funcs = &dp_bridge_ops;
   241		bridge->encoder = encoder;
   242	
   243		rc = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
   244		if (rc) {
   245			DRM_ERROR("failed to attach bridge, rc=%d\n", rc);
 > 246			kfree(dp_bridge);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

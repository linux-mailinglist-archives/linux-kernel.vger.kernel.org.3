Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1717846B68B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhLGJHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:07:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:29417 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhLGJHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:07:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224791978"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224791978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 00:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="515194978"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2021 00:59:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muWKE-000MNH-E3; Tue, 07 Dec 2021 08:59:50 +0000
Date:   Tue, 7 Dec 2021 16:58:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211118 48/48]
 drivers/usb/typec/altmodes/displayport.c:147:4: error: too few arguments to
 function 'drm_connector_oob_hotplug_event'
Message-ID: <202112071602.WIq3FYDB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sm8350-next-20211118
head:   801a35a569988584ffd5f6028a992f636c2a6634
commit: 801a35a569988584ffd5f6028a992f636c2a6634 [48/48] drm: Add hpd state to drm_connector_oob_hotplug_event()
config: x86_64-randconfig-r032-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071602.WIq3FYDB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/andersson/kernel/commit/801a35a569988584ffd5f6028a992f636c2a6634
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211118
        git checkout 801a35a569988584ffd5f6028a992f636c2a6634
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/typec/altmodes/displayport.c: In function 'dp_altmode_status_update':
>> drivers/usb/typec/altmodes/displayport.c:147:4: error: too few arguments to function 'drm_connector_oob_hotplug_event'
     147 |    drm_connector_oob_hotplug_event(dp->connector_fwnode);
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/usb/typec/altmodes/displayport.c:17:
   include/drm/drm_connector.h:1739:6: note: declared here
    1739 | void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode, bool hpd_state);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/typec/altmodes/displayport.c: In function 'dp_altmode_remove':
   drivers/usb/typec/altmodes/displayport.c:577:4: error: too few arguments to function 'drm_connector_oob_hotplug_event'
     577 |    drm_connector_oob_hotplug_event(dp->connector_fwnode);
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/usb/typec/altmodes/displayport.c:17:
   include/drm/drm_connector.h:1739:6: note: declared here
    1739 | void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode, bool hpd_state);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_connector_oob_hotplug_event +147 drivers/usb/typec/altmodes/displayport.c

0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  128  
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  129  static int dp_altmode_status_update(struct dp_altmode *dp)
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  130  {
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  131  	bool configured = !!DP_CONF_GET_PIN_ASSIGN(dp->data.conf);
7f811394878535e Hans de Goede   2021-08-17  132  	bool hpd = !!(dp->data.status & DP_STATUS_HPD_STATE);
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  133  	u8 con = DP_STATUS_CONNECTION(dp->data.status);
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  134  	int ret = 0;
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  135  
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  136  	if (configured && (dp->data.status & DP_STATUS_SWITCH_TO_USB)) {
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  137  		dp->data.conf = 0;
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  138  		dp->state = DP_STATE_CONFIGURE;
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  139  	} else if (dp->data.status & DP_STATUS_EXIT_DP_MODE) {
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  140  		dp->state = DP_STATE_EXIT;
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  141  	} else if (!(con & DP_CONF_CURRENTLY(dp->data.conf))) {
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  142  		ret = dp_altmode_configure(dp, con);
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  143  		if (!ret)
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  144  			dp->state = DP_STATE_CONFIGURE;
7f811394878535e Hans de Goede   2021-08-17  145  	} else {
7f811394878535e Hans de Goede   2021-08-17  146  		if (dp->hpd != hpd) {
7f811394878535e Hans de Goede   2021-08-17 @147  			drm_connector_oob_hotplug_event(dp->connector_fwnode);
7f811394878535e Hans de Goede   2021-08-17  148  			dp->hpd = hpd;
7f811394878535e Hans de Goede   2021-08-17  149  		}
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  150  	}
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  151  
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  152  	return ret;
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  153  }
0e3bb7d6894d9b6 Heikki Krogerus 2018-06-27  154  

:::::: The code at line 147 was first introduced by commit
:::::: 7f811394878535ed9a6849717de8c2959ae38899 usb: typec: altmodes/displayport: Notify drm subsys of hotplug events

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Hans de Goede <hdegoede@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45A0569947
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 06:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiGGE0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 00:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiGGE01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:26:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976EE2FFEF;
        Wed,  6 Jul 2022 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657167986; x=1688703986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mUwoibGeugF+/wW/Tc5Uyi0nUEtbEwOV+QQCFB3AJ90=;
  b=flAewpisXAin/uNlltTMdvMGpFc70ewdBzHGgn3kB6Yek4UN8pHlJIJa
   +GNTSSJJkn0CWun/4M/4aZWQWI7kpnQhIvSFY+Wobv15vkFypv5kYto0R
   wHEM0u4WdYsRaDe9L8zZWNeoHT6+mdbNOuO5OsiGmkWUmQ/5LpOUuYDaS
   tkDgkwP5se2tl8wj9DEf9nO75Lhv6H5xTOt1QPUcUG233oX8WK5+XCo9w
   G647y2xDrzzw5zC7WU+C1eIf3uroASVKtHYPFGpcZ2RFMiPZ3tCBF18Sa
   kgl4uq9lSPXSIs5/WqVBxM7ZJqt73JJYHaRdjtToBQQAfstRtmaJ/3mlF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284667315"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="284667315"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 21:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="661227632"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 21:26:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9J5p-000LXW-R8;
        Thu, 07 Jul 2022 04:26:21 +0000
Date:   Thu, 7 Jul 2022 12:25:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     kbuild-all@lists.01.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v2 6/9] platform/chrome: cros_typec_switch: Add event
 check
Message-ID: <202207071256.63ElDHIG-lkp@intel.com>
References: <20220706171601.807042-7-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706171601.807042-7-pmalani@chromium.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[cannot apply to chrome-platform/for-next linus/master balbi-usb/testing/next peter-chen-usb/for-usb-next v5.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prashant-Malani/platform-chrome-Type-C-switch-driver-and-Type-C-framework-updates/20220707-012614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220707/202207071256.63ElDHIG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/60e03c1b36c0e3533e481b44152faab38448be5b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Prashant-Malani/platform-chrome-Type-C-switch-driver-and-Type-C-framework-updates/20220707-012614
        git checkout 60e03c1b36c0e3533e481b44152faab38448be5b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/chrome/ kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/cros_typec_switch.c:81:6: warning: no previous prototype for 'cros_typec_check_event' [-Wmissing-prototypes]
      81 | bool cros_typec_check_event(struct cros_typec_switch_data *sdata, int port_num, u32 mask)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/cros_typec_switch.c:159:6: warning: no previous prototype for 'cros_typec_unregister_switches' [-Wmissing-prototypes]
     159 | void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/cros_typec_switch.c:170:5: warning: no previous prototype for 'cros_typec_register_retimer' [-Wmissing-prototypes]
     170 | int cros_typec_register_retimer(struct cros_typec_port *port, struct fwnode_handle *fwnode)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cros_typec_check_event +81 drivers/platform/chrome/cros_typec_switch.c

    80	
  > 81	bool cros_typec_check_event(struct cros_typec_switch_data *sdata, int port_num, u32 mask)
    82	{
    83		struct ec_response_typec_status resp;
    84		struct ec_params_typec_status req = {
    85			.port = port_num,
    86		};
    87		int ret;
    88	
    89		ret = cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
    90				      &resp, sizeof(resp));
    91		if (ret < 0) {
    92			dev_warn(sdata->dev, "EC_CMD_TYPEC_STATUS failed for port: %d\n", port_num);
    93			return false;
    94		}
    95	
    96		if (resp.events & mask)
    97			return true;
    98	
    99		return false;
   100	}
   101	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

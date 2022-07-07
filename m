Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD89D5696E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiGGA3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGGA3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:29:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250921F625;
        Wed,  6 Jul 2022 17:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657153770; x=1688689770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/wuMRpi/YaEhOxvugOenqe7PKLGIkfSrr02ZOvYLTtc=;
  b=Px9QHepbxnCZAzvY/1WLUyUDNO8E5olFlLc+ZpF4aJbSSuSMWCrfe98R
   7q1nlyYN09rRKrr1dSBrOa4+J1JXviLcK9wLEzTjxNpQbe0+0cO+WMUT1
   SsooQTIJxcO/ZzGA2gATNArWYBFV+OHswtc/WJ2gc0zwf+yCxdd6FgZ86
   wsrzQ0eOMamxNMQSN3Ft86Zi4DSTewdQNGiCEP5OsdeMSV8VdiMb9g+3e
   1XMp9lsXg0+omPOoQT6A5ExVJnQUn54pIkYKft94XpHmfTVDAqCd8F6is
   8ORC3sbkTOs7o1LpfkMyBL0FLZe+bg28IE+IhroUkAp2GKSM5yAUS2ahT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285021644"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="285021644"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 17:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="661173745"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 17:29:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9FOX-000LJC-2b;
        Thu, 07 Jul 2022 00:29:25 +0000
Date:   Thu, 7 Jul 2022 08:29:11 +0800
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
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v2 4/9] platform/chrome: cros_typec_switch: Add switch
 driver
Message-ID: <202207070816.tREVcI4a-lkp@intel.com>
References: <20220706171601.807042-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706171601.807042-5-pmalani@chromium.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220707/202207070816.tREVcI4a-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6d9c4808fd780ebdf18235d615764c504b95a03d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Prashant-Malani/platform-chrome-Type-C-switch-driver-and-Type-C-framework-updates/20220707-012614
        git checkout 6d9c4808fd780ebdf18235d615764c504b95a03d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/chrome/ kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/cros_typec_switch.c:37:6: warning: no previous prototype for 'cros_typec_unregister_switches' [-Wmissing-prototypes]
      37 | void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/chrome/cros_typec_switch.c:48:5: warning: no previous prototype for 'cros_typec_register_retimer' [-Wmissing-prototypes]
      48 | int cros_typec_register_retimer(struct cros_typec_port *port, struct fwnode_handle *fwnode)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cros_typec_unregister_switches +37 drivers/platform/chrome/cros_typec_switch.c

    36	
  > 37	void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
    38	{
    39		int i;
    40	
    41		for (i = 0; i < EC_USB_PD_MAX_PORTS; i++) {
    42			if (!sdata->ports[i])
    43				continue;
    44			typec_retimer_unregister(sdata->ports[i]->retimer);
    45		}
    46	}
    47	
  > 48	int cros_typec_register_retimer(struct cros_typec_port *port, struct fwnode_handle *fwnode)
    49	{
    50		struct typec_retimer_desc retimer_desc = {
    51			.fwnode = fwnode,
    52			.drvdata = port,
    53			.name = fwnode_get_name(fwnode),
    54			.set = cros_typec_retimer_set,
    55		};
    56	
    57		port->retimer = typec_retimer_register(port->sdata->dev, &retimer_desc);
    58		if (IS_ERR(port->retimer))
    59			return PTR_ERR(port->retimer);
    60	
    61		return 0;
    62	}
    63	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

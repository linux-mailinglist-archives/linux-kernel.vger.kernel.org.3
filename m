Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025754FE4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357114AbiDLPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357131AbiDLPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:38:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BB5839A;
        Tue, 12 Apr 2022 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649777763; x=1681313763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Spu/bhtmnuIg6Wi9yv/iXZ31D/WFe0Ipz3ysdwlpdic=;
  b=Gf7yrMiUcjZagdYHr0dr5SPReg/aWFoxBc4ZIewVTjd8PLkibxfMbAoZ
   Ou+q1Xf1osezsJCjn1rOkNUFfJV2WiC3eb7KUJJ3XeqS4eWXvSVPO9OeI
   sqo9e5kfLWZjTJpJvoTe6Pw3ohWS3bcJCYT6UlZIMaZt6I3hxEZvz3lYL
   3iS1TnnvOkob/aAwgURbbSpzF33t1nxhQORqIM27rQEwsdjZZ4b6DfcK8
   WNc7DueuLlKrJxrPA1Z++L8uHULeI2NFlKG/d47m1m0llxPZ3skCyKVKd
   SiJe8PZL0fVL5dkME0DqAqgrtqYRkuA0NXTbInbk8y3JoUgKKM7z3n/iw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="322847250"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="322847250"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 08:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="611492406"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2022 08:35:59 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neIYh-0002wW-94;
        Tue, 12 Apr 2022 15:35:59 +0000
Date:   Tue, 12 Apr 2022 23:35:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: USB Power Deliver helpers for ports
 and partners
Message-ID: <202204122323.iqiRhgAI-lkp@intel.com>
References: <20220412130023.83927-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412130023.83927-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on chrome-platform/for-next v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Heikki-Krogerus/usb-typec-Separate-sysfs-directory-for-all-USB-PD-objects/20220412-211628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220412/202204122323.iqiRhgAI-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/98fece77872792e49f1005617761a533089f319d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Heikki-Krogerus/usb-typec-Separate-sysfs-directory-for-all-USB-PD-objects/20220412-211628
        git checkout 98fece77872792e49f1005617761a533089f319d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/usb/typec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/pd.c:669: warning: expecting prototype for pd_register(). Prototype was for pd_unregister() instead
>> drivers/usb/typec/pd.c:717: warning: expecting prototype for pd_link_device(). Prototype was for pd_unlink_device() instead
--
>> drivers/usb/typec/class.c:1222: warning: expecting prototype for typec_port_set_pd_capabilities(). Prototype was for typec_port_set_pd() instead


vim +717 drivers/usb/typec/pd.c

c99df888db9e4c Heikki Krogerus 2022-04-12  663  
c99df888db9e4c Heikki Krogerus 2022-04-12  664  /**
c99df888db9e4c Heikki Krogerus 2022-04-12  665   * pd_register - Unregister USB Power Delivery Support.
c99df888db9e4c Heikki Krogerus 2022-04-12  666   * @pd: The USB PD contract.
c99df888db9e4c Heikki Krogerus 2022-04-12  667   */
c99df888db9e4c Heikki Krogerus 2022-04-12  668  void pd_unregister(struct pd *pd)
c99df888db9e4c Heikki Krogerus 2022-04-12 @669  {
c99df888db9e4c Heikki Krogerus 2022-04-12  670  	if (IS_ERR_OR_NULL(pd))
c99df888db9e4c Heikki Krogerus 2022-04-12  671  		return;
c99df888db9e4c Heikki Krogerus 2022-04-12  672  
c99df888db9e4c Heikki Krogerus 2022-04-12  673  	kobject_put(&pd->kobj);
c99df888db9e4c Heikki Krogerus 2022-04-12  674  }
c99df888db9e4c Heikki Krogerus 2022-04-12  675  EXPORT_SYMBOL_GPL(pd_unregister);
c99df888db9e4c Heikki Krogerus 2022-04-12  676  
c99df888db9e4c Heikki Krogerus 2022-04-12  677  /**
c99df888db9e4c Heikki Krogerus 2022-04-12  678   * pd_link_device - Link device to its USB PD object.
c99df888db9e4c Heikki Krogerus 2022-04-12  679   * @pd: The USB PD instance.
c99df888db9e4c Heikki Krogerus 2022-04-12  680   * @dev: The device.
c99df888db9e4c Heikki Krogerus 2022-04-12  681   *
c99df888db9e4c Heikki Krogerus 2022-04-12  682   * This function can be used to create a symlink named "usb_power_delivery" for
c99df888db9e4c Heikki Krogerus 2022-04-12  683   * @dev that points to @pd.
c99df888db9e4c Heikki Krogerus 2022-04-12  684   */
c99df888db9e4c Heikki Krogerus 2022-04-12  685  int pd_link_device(struct pd *pd, struct device *dev)
c99df888db9e4c Heikki Krogerus 2022-04-12  686  {
c99df888db9e4c Heikki Krogerus 2022-04-12  687  	int ret;
c99df888db9e4c Heikki Krogerus 2022-04-12  688  
c99df888db9e4c Heikki Krogerus 2022-04-12  689  	if (IS_ERR_OR_NULL(pd) || !dev)
c99df888db9e4c Heikki Krogerus 2022-04-12  690  		return 0;
c99df888db9e4c Heikki Krogerus 2022-04-12  691  
c99df888db9e4c Heikki Krogerus 2022-04-12  692  	ret = sysfs_create_link(&dev->kobj, &pd->kobj, "usb_power_delivery");
c99df888db9e4c Heikki Krogerus 2022-04-12  693  	if (ret)
c99df888db9e4c Heikki Krogerus 2022-04-12  694  		return ret;
c99df888db9e4c Heikki Krogerus 2022-04-12  695  
c99df888db9e4c Heikki Krogerus 2022-04-12  696  	ret = sysfs_create_link(&pd->kobj, &dev->kobj, dev_name(dev));
c99df888db9e4c Heikki Krogerus 2022-04-12  697  	if (ret) {
c99df888db9e4c Heikki Krogerus 2022-04-12  698  		sysfs_remove_link(&dev->kobj, "usb_power_delivery");
c99df888db9e4c Heikki Krogerus 2022-04-12  699  		return ret;
c99df888db9e4c Heikki Krogerus 2022-04-12  700  	}
c99df888db9e4c Heikki Krogerus 2022-04-12  701  
c99df888db9e4c Heikki Krogerus 2022-04-12  702  	kobject_get(&pd->kobj);
c99df888db9e4c Heikki Krogerus 2022-04-12  703  	get_device(dev);
c99df888db9e4c Heikki Krogerus 2022-04-12  704  
c99df888db9e4c Heikki Krogerus 2022-04-12  705  	return 0;
c99df888db9e4c Heikki Krogerus 2022-04-12  706  }
c99df888db9e4c Heikki Krogerus 2022-04-12  707  EXPORT_SYMBOL_GPL(pd_link_device);
c99df888db9e4c Heikki Krogerus 2022-04-12  708  
c99df888db9e4c Heikki Krogerus 2022-04-12  709  /**
c99df888db9e4c Heikki Krogerus 2022-04-12  710   * pd_link_device - Unlink device from its USB PD object.
c99df888db9e4c Heikki Krogerus 2022-04-12  711   * @pd: The USB PD instance.
c99df888db9e4c Heikki Krogerus 2022-04-12  712   * @dev: The device.
c99df888db9e4c Heikki Krogerus 2022-04-12  713   *
c99df888db9e4c Heikki Krogerus 2022-04-12  714   * Remove the symlink that was previously created with pd_link_device().
c99df888db9e4c Heikki Krogerus 2022-04-12  715   */
c99df888db9e4c Heikki Krogerus 2022-04-12  716  void pd_unlink_device(struct pd *pd, struct device *dev)
c99df888db9e4c Heikki Krogerus 2022-04-12 @717  {
c99df888db9e4c Heikki Krogerus 2022-04-12  718  	if (IS_ERR_OR_NULL(pd) || !dev)
c99df888db9e4c Heikki Krogerus 2022-04-12  719  		return;
c99df888db9e4c Heikki Krogerus 2022-04-12  720  
c99df888db9e4c Heikki Krogerus 2022-04-12  721  	sysfs_remove_link(&dev->kobj, "usb_power_delivery");
c99df888db9e4c Heikki Krogerus 2022-04-12  722  	sysfs_remove_link(&pd->kobj, dev_name(dev));
c99df888db9e4c Heikki Krogerus 2022-04-12  723  	kobject_put(&pd->kobj);
c99df888db9e4c Heikki Krogerus 2022-04-12  724  	put_device(dev);
c99df888db9e4c Heikki Krogerus 2022-04-12  725  }
c99df888db9e4c Heikki Krogerus 2022-04-12  726  EXPORT_SYMBOL_GPL(pd_unlink_device);
c99df888db9e4c Heikki Krogerus 2022-04-12  727  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

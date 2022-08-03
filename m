Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F73058880A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiHCHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiHCHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:37:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A61EED4;
        Wed,  3 Aug 2022 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659512220; x=1691048220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDol4quIHyCkUUQN0yS9RT26ovaTXTi4u51IGycUZO4=;
  b=XR+/IVPs5DUHmwh+btacUt+0sBjZdqlUDnZ1N+PoMY0DQPgz/LEB3t6x
   cO8xRqQTjsIF0zcvOpQ3KrFCP6J31EWvQc5AR57P2u7DdcBYfHJWHSwYd
   JuN1A07pNc564UQMwQb58+9qabEGnsGHrvPtOFZABFbKHni61c/2Saqz3
   O978sL3+h2GlMGHr6JYtPoiKfhx/iiWYH8Y2KFu788l1IJ/Cgf7Seo42x
   Ai2Eu3gs0B4gdI+5oZvNnDkegVOo2bh87gtz+ioPVMA+2mh/tA05HH4Id
   oL4UT9k8zcBnx5tOHQX3mL27ZUavKpBZ4qNOYbDAfn7S4dGraBP7kyMu8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290826652"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="290826652"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="553225929"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 00:36:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ8w1-000GzL-2r;
        Wed, 03 Aug 2022 07:36:53 +0000
Date:   Wed, 3 Aug 2022 15:36:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair@alistair23.me>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shawnguo@kernel.org, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        s.hauer@pengutronix.de, andreas@kemnade.info,
        krzysztof.kozlowski+dt@linaro.org, rydberg@bitmath.org,
        dmitry.torokhov@gmail.com,
        Alistair Francis <alistair@alistair23.me>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v8 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <202208031503.3PE5bw9a-lkp@intel.com>
References: <20220802125827.34509-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802125827.34509-2-alistair@alistair23.me>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on hid/for-next shawnguo/for-next linus/master v5.19 next-20220802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/Add-support-for-the-Cypress-cyttsp5/20220802-210032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: nios2-randconfig-s031-20220803 (https://download.01.org/0day-ci/archive/20220803/202208031503.3PE5bw9a-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9c372983ef0b8eb7ad48c025a156f80943269af7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alistair-Francis/Add-support-for-the-Cypress-cyttsp5/20220802-210032
        git checkout 9c372983ef0b8eb7ad48c025a156f80943269af7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/cyttsp5.c:602:36: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] hid_desc_register @@     got int @@
   drivers/input/touchscreen/cyttsp5.c:602:36: sparse:     expected restricted __le16 [usertype] hid_desc_register
   drivers/input/touchscreen/cyttsp5.c:602:36: sparse:     got int

vim +602 drivers/input/touchscreen/cyttsp5.c

   597	
   598	static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
   599					      struct cyttsp5_hid_desc *desc)
   600	{
   601		struct device *dev = ts->dev;
 > 602		__le16 hid_desc_register = HID_DESC_REG;
   603		int rc;
   604		u8 cmd[2];
   605	
   606		/* Set HID descriptor register */
   607		memcpy(cmd, &hid_desc_register, sizeof(hid_desc_register));
   608	
   609		rc = cyttsp5_write(ts, HID_DESC_REG, NULL, 0);
   610		if (rc) {
   611			dev_err(dev, "Failed to get HID descriptor, rc=%d\n", rc);
   612			return rc;
   613		}
   614	
   615		rc = wait_for_completion_interruptible_timeout(&ts->cmd_done,
   616							msecs_to_jiffies(CY_HID_GET_HID_DESCRIPTOR_TIMEOUT_MS));
   617		if (rc <= 0) {
   618			dev_err(ts->dev, "HID get descriptor timed out\n");
   619			rc = -ETIMEDOUT;
   620			return rc;
   621		}
   622	
   623		memcpy(desc, ts->response_buf, sizeof(*desc));
   624	
   625		/* Check HID descriptor length and version */
   626		if (le16_to_cpu(desc->hid_desc_len) != sizeof(*desc) ||
   627		    le16_to_cpu(desc->bcd_version) != HID_VERSION) {
   628			dev_err(dev, "Unsupported HID version\n");
   629			return -ENODEV;
   630		}
   631	
   632		return 0;
   633	}
   634	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

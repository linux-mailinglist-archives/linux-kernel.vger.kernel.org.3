Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F018552F773
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 03:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354330AbiEUB6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 21:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiEUB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 21:58:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFCF15F6C0;
        Fri, 20 May 2022 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653098310; x=1684634310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DrWDg9joVp2dABARq0RhykWRXTcxvZJXfd8ePCmsTW0=;
  b=KlwufDRPyR7kImVQBqWLXX6PFnzV/3OPbDzM7YP88cfOvxiRxAjRopsg
   KTE6v0XCQyQ4PTMfEHvI3SBPT/zRMph/0pGmzYTLsQk427ivkBT8+ukKv
   F8rvsn/vrF9Qhx1zdGS51u6WzV98i9di3OQNLXdtikvpqjFNl1aSVJpGP
   7xp3czWnGcq+aAvQ15eHh/IqgzuPs2jBjC/CpLnL/olxqd6qWm3y1Lv2R
   NgRVGeJrEc9u21PyCCKbKkQEphQlbOqU92JYRsXgPOo2uv9unax8g1q/A
   S7tdoWs/0Jfg8hbTT/ePeyRT2Cv5OgcXKAXNlIJXHsRRIfvQb6TZx2HLg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="298102845"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="298102845"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 18:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="546969294"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2022 18:58:23 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsENq-0005lm-Q8;
        Sat, 21 May 2022 01:58:22 +0000
Date:   Sat, 21 May 2022 09:57:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Neal Liu <neal_liu@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 1/3] usb: gadget: add Aspeed ast2600 udc driver
Message-ID: <202205210945.hUK3CONa-lkp@intel.com>
References: <20220520090617.2225080-2-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520090617.2225080-2-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neal,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next v5.18-rc7 next-20220520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220520-170904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220521/202205210945.hUK3CONa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/19f3e863ea1b55f570db57febb96c6e8cb39c145
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220520-170904
        git checkout 19f3e863ea1b55f570db57febb96c6e8cb39c145
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/ drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/udc/aspeed_udc.c:310:11: warning: comparison of address of 'ep->queue' equal to a null pointer is always false [-Wtautological-pointer-compare]
           if (&ep->queue == NULL)
                ~~~~^~~~~    ~~~~
>> drivers/usb/gadget/udc/aspeed_udc.c:967:7: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
                   if (len < ep->ep.maxpacket) {
                       ^~~
   drivers/usb/gadget/udc/aspeed_udc.c:908:9: note: initialize the variable 'len' to silence this warning
           u16 len;
                  ^
                   = 0
>> drivers/usb/gadget/udc/aspeed_udc.c:1011:7: warning: variable 'epnum' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case USB_RECIP_INTERFACE:
                ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/usb/ch9.h:67:30: note: expanded from macro 'USB_RECIP_INTERFACE'
   #define USB_RECIP_INTERFACE             0x01
                                           ^~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1021:16: note: uninitialized use occurs here
           ep = &udc->ep[epnum];
                         ^~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1007:7: warning: variable 'epnum' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case USB_RECIP_DEVICE:
                ^~~~~~~~~~~~~~~~
   include/uapi/linux/usb/ch9.h:66:27: note: expanded from macro 'USB_RECIP_DEVICE'
   #define USB_RECIP_DEVICE                0x00
                                           ^~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1021:16: note: uninitialized use occurs here
           ep = &udc->ep[epnum];
                         ^~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1002:11: note: initialize the variable 'epnum' to silence this warning
           u16 epnum;
                    ^
                     = 0
>> drivers/usb/gadget/udc/aspeed_udc.c:1096:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (udc->driver) {
               ^~~~~~~~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1108:6: note: uninitialized use occurs here
           if (rc >= 0)
               ^~
   drivers/usb/gadget/udc/aspeed_udc.c:1096:2: note: remove the 'if' if its condition is always true
           if (udc->driver) {
           ^~~~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1039:8: note: initialize the variable 'rc' to silence this warning
           int rc;
                 ^
                  = 0
   5 warnings generated.


vim +310 drivers/usb/gadget/udc/aspeed_udc.c

   304	
   305	static void ast_udc_nuke(struct ast_udc_ep *ep, int status)
   306	{
   307		int count = 0;
   308	
   309		/* Sanity check */
 > 310		if (&ep->queue == NULL)
   311			return;
   312	
   313		while (!list_empty(&ep->queue)) {
   314			struct ast_udc_request *req;
   315	
   316			req = list_entry(ep->queue.next, struct ast_udc_request,
   317					 queue);
   318			ast_udc_done(ep, req, status);
   319			count++;
   320		}
   321	
   322		if (count)
   323			EP_DBG(ep, "Nuked %d request(s)\n", count);
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

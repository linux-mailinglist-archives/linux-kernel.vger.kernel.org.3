Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6681152609D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379713AbiEMLDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379714AbiEMLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:03:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682462A2F4A;
        Fri, 13 May 2022 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652439824; x=1683975824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TLKqQ2wymwAEhGiToADns1nYw8QR22hogOXokBFX7Cc=;
  b=kms9Ifd2mp/sXw2B2Tz8jGDXUSKHu/1lcHqIXUpkOK5Ioxvi/stf2t48
   VFNtmbp6Wza75nzRYuZKVkHlRh1qkv+qZO8lDyGxcIQ3c0YB6V02Qw0ys
   G/1+E6sKzwN9tcczv2pxiMVtxFPaV9wBZhh3mikF1qHZWsnVV/YdfN/BR
   F0/s+f7/F8fv+tFZTotGXdjQHE5ebUQzM9od45WEH3ZxQxquRJ0ShdKxi
   +Momb0oBJjMCKdQxbFjenFLJ8a7JpoyuiHTItJFHKri7B9HgKlXzC9ZUP
   RXmH+MaDLbShwGaTz8mPwOxjAs812gRz9bxwk24bJO0KuNFHCwvIMxl20
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269950743"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269950743"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 04:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="815340352"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2022 04:03:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npT55-000LfU-DL;
        Fri, 13 May 2022 11:03:35 +0000
Date:   Fri, 13 May 2022 19:03:22 +0800
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
Cc:     kbuild-all@lists.01.org, Neal Liu <neal_liu@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH 1/3] usb: gadget: add Aspeed ast2600 udc driver
Message-ID: <202205131836.QEUySDoN-lkp@intel.com>
References: <20220513065728.857722-2-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513065728.857722-2-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test WARNING on robh/for-next v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220513-150314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220513/202205131836.QEUySDoN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/272ae26f9fe89f60d584cf445431d0fa566eb24b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220513-150314
        git checkout 272ae26f9fe89f60d584cf445431d0fa566eb24b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/gadget/udc/aspeed_udc.c: In function 'ast_udc_ep0_out':
>> drivers/usb/gadget/udc/aspeed_udc.c:790:13: warning: variable 'buf' set but not used [-Wunused-but-set-variable]
     790 |         u8 *buf;
         |             ^~~
   drivers/usb/gadget/udc/aspeed_udc.c: In function 'ast_udc_ep0_handle_setup':
>> drivers/usb/gadget/udc/aspeed_udc.c:1099:60: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    1099 |                 SETUP_DBG(udc, "No gadget for request !\n");
         |                                                            ^
>> drivers/usb/gadget/udc/aspeed_udc.c:1034:13: warning: variable 'ep_num' set but not used [-Wunused-but-set-variable]
    1034 |         u16 ep_num = 0;
         |             ^~~~~~


vim +/buf +790 drivers/usb/gadget/udc/aspeed_udc.c

   783	
   784	static void ast_udc_ep0_out(struct ast_udc_dev *udc)
   785	{
   786		struct device *dev = &udc->pdev->dev;
   787		struct ast_udc_ep *ep = &udc->ep[0];
   788		struct ast_udc_request *req;
   789		u16 rx_len;
 > 790		u8 *buf;
   791	
   792		if (list_empty(&ep->queue))
   793			return;
   794	
   795		req = list_entry(ep->queue.next, struct ast_udc_request, queue);
   796	
   797		buf = req->req.buf;
   798		rx_len = EP0_GET_RX_LEN(ast_udc_read(udc, AST_UDC_EP0_CTRL));
   799		req->req.actual += rx_len;
   800	
   801		SETUP_DBG(udc, "req %p (%d/%d)\n", req,
   802			  req->req.actual, req->req.length);
   803	
   804		if ((rx_len < ep->ep.maxpacket) ||
   805		    (req->req.actual == req->req.length)) {
   806			ast_udc_ep0_tx(udc);
   807			if (!ep->dir_in)
   808				ast_udc_done(ep, req, 0);
   809	
   810		} else {
   811			if (rx_len > req->req.length) {
   812				// Issue Fix
   813				dev_warn(dev, "Something wrong (%d/%d)\n",
   814					 req->req.actual, req->req.length);
   815				ast_udc_ep0_tx(udc);
   816				ast_udc_done(ep, req, 0);
   817				return;
   818			}
   819	
   820			ep->dir_in = 0;
   821	
   822			/* More works */
   823			ast_udc_ep0_queue(ep, req);
   824		}
   825	}
   826	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

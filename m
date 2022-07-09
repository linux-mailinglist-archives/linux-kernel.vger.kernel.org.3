Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87C56C6F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGIEs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 00:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGIEs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:48:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914CC7CB5A;
        Fri,  8 Jul 2022 21:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657342106; x=1688878106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FJdgpVWJJ2BRz+OsQTAFxbmAAiWjXd3WhDQtcsVTGE=;
  b=d+fCZk5qZzSSphujpqN04GLMcei/U8LQ4xpTy3pixNdGpHreRj3tKijy
   SfO0StPW1y8vx7nBqLJbNRLWUKOKCl9cuvP2/NmCzguRqkS6TkxoXbl9c
   eEMe58I+AOOGzUs1lfV2Uw6X/h6cM/fAacMc1NE502E+7KG+2mf1sroiY
   Fc3/d96q10Wj3GP/RNCEswJUHq7+N3iyQvu4m/pT+50zbMwz56Xd6jVC7
   SihXM5G3s4eSjTy/mBxSTUKj3pyV1+kBbxoyFLdvO72u2N/osBBkxA0pk
   2w6Eg1Gia8NWZHQDXKX0zKOndAPFmBC8OPVpxaWu6tRrT1GM/EBVpsuRL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264186562"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264186562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 21:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736553000"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 21:48:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA2OF-000OJo-4G;
        Sat, 09 Jul 2022 04:48:23 +0000
Date:   Sat, 9 Jul 2022 12:47:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Thinh.Nguyen@synopsys.com, quic_jackp@quicinc.com,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH 3/5] usb: dwc3: gadget: Adjust IRQ management during soft
 disconnect/connect
Message-ID: <202207091200.uLedVxl7-lkp@intel.com>
References: <20220708185007.21743-4-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708185007.21743-4-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on linus/master v5.19-rc5 next-20220708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wesley-Cheng/Fix-controller-halt-and-endxfer-timeout-issues/20220709-025241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220709/202207091200.uLedVxl7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 562c3467a6738aa89203f72fc1d1343e5baadf3c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/457fe4752b0f6dcc5c1b329f91003b7ffc518b44
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wesley-Cheng/Fix-controller-halt-and-endxfer-timeout-issues/20220709-025241
        git checkout 457fe4752b0f6dcc5c1b329f91003b7ffc518b44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/usb/dwc3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/dwc3/gadget.c:2032:18: warning: unused variable 'flags' [-Wunused-variable]
           unsigned long                   flags;
                                           ^
   1 warning generated.


vim +/flags +2032 drivers/usb/dwc3/gadget.c

d4f1afe5e896c1 Felipe Balbi 2018-08-01  2022  
72246da40f3719 Felipe Balbi 2011-08-19  2023  static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
72246da40f3719 Felipe Balbi 2011-08-19  2024  		struct usb_request *request)
72246da40f3719 Felipe Balbi 2011-08-19  2025  {
72246da40f3719 Felipe Balbi 2011-08-19  2026  	struct dwc3_request		*req = to_dwc3_request(request);
72246da40f3719 Felipe Balbi 2011-08-19  2027  	struct dwc3_request		*r = NULL;
72246da40f3719 Felipe Balbi 2011-08-19  2028  
72246da40f3719 Felipe Balbi 2011-08-19  2029  	struct dwc3_ep			*dep = to_dwc3_ep(ep);
72246da40f3719 Felipe Balbi 2011-08-19  2030  	struct dwc3			*dwc = dep->dwc;
72246da40f3719 Felipe Balbi 2011-08-19  2031  
72246da40f3719 Felipe Balbi 2011-08-19 @2032  	unsigned long			flags;
72246da40f3719 Felipe Balbi 2011-08-19  2033  	int				ret = 0;
72246da40f3719 Felipe Balbi 2011-08-19  2034  
2c4cbe6e5a9c71 Felipe Balbi 2014-04-30  2035  	trace_dwc3_ep_dequeue(req);
2c4cbe6e5a9c71 Felipe Balbi 2014-04-30  2036  
457fe4752b0f6d Wesley Cheng 2022-07-08  2037  	spin_lock(&dwc->lock);
72246da40f3719 Felipe Balbi 2011-08-19  2038  
a7027ca69d82ae Thinh Nguyen 2020-03-05  2039  	list_for_each_entry(r, &dep->cancelled_list, list) {
72246da40f3719 Felipe Balbi 2011-08-19  2040  		if (r == req)
fcd2def6639293 Thinh Nguyen 2020-03-05  2041  			goto out;
72246da40f3719 Felipe Balbi 2011-08-19  2042  	}
72246da40f3719 Felipe Balbi 2011-08-19  2043  
aa3342c8bb618a Felipe Balbi 2016-03-14  2044  	list_for_each_entry(r, &dep->pending_list, list) {
fcd2def6639293 Thinh Nguyen 2020-03-05  2045  		if (r == req) {
fcd2def6639293 Thinh Nguyen 2020-03-05  2046  			dwc3_gadget_giveback(dep, req, -ECONNRESET);
fcd2def6639293 Thinh Nguyen 2020-03-05  2047  			goto out;
fcd2def6639293 Thinh Nguyen 2020-03-05  2048  		}
72246da40f3719 Felipe Balbi 2011-08-19  2049  	}
72246da40f3719 Felipe Balbi 2011-08-19  2050  
aa3342c8bb618a Felipe Balbi 2016-03-14  2051  	list_for_each_entry(r, &dep->started_list, list) {
72246da40f3719 Felipe Balbi 2011-08-19  2052  		if (r == req) {
a7027ca69d82ae Thinh Nguyen 2020-03-05  2053  			struct dwc3_request *t;
a7027ca69d82ae Thinh Nguyen 2020-03-05  2054  
72246da40f3719 Felipe Balbi 2011-08-19  2055  			/* wait until it is processed */
c5353b225df9b2 Felipe Balbi 2019-02-13  2056  			dwc3_stop_active_transfer(dep, true, true);
cf3113d893d442 Felipe Balbi 2017-02-17  2057  
a7027ca69d82ae Thinh Nguyen 2020-03-05  2058  			/*
a7027ca69d82ae Thinh Nguyen 2020-03-05  2059  			 * Remove any started request if the transfer is
a7027ca69d82ae Thinh Nguyen 2020-03-05  2060  			 * cancelled.
a7027ca69d82ae Thinh Nguyen 2020-03-05  2061  			 */
a7027ca69d82ae Thinh Nguyen 2020-03-05  2062  			list_for_each_entry_safe(r, t, &dep->started_list, list)
04dd6e76b22889 Ray Chi      2021-03-28  2063  				dwc3_gadget_move_cancelled_request(r,
04dd6e76b22889 Ray Chi      2021-03-28  2064  						DWC3_REQUEST_STATUS_DEQUEUED);
cf3113d893d442 Felipe Balbi 2017-02-17  2065  
a5c7682aaaa10e Thinh Nguyen 2021-01-04  2066  			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
a5c7682aaaa10e Thinh Nguyen 2021-01-04  2067  
fcd2def6639293 Thinh Nguyen 2020-03-05  2068  			goto out;
72246da40f3719 Felipe Balbi 2011-08-19  2069  		}
72246da40f3719 Felipe Balbi 2011-08-19  2070  	}
fcd2def6639293 Thinh Nguyen 2020-03-05  2071  
04fb365c453e14 Felipe Balbi 2017-05-17  2072  	dev_err(dwc->dev, "request %pK was not queued to %s\n",
72246da40f3719 Felipe Balbi 2011-08-19  2073  		request, ep->name);
72246da40f3719 Felipe Balbi 2011-08-19  2074  	ret = -EINVAL;
fcd2def6639293 Thinh Nguyen 2020-03-05  2075  out:
457fe4752b0f6d Wesley Cheng 2022-07-08  2076  	spin_unlock(&dwc->lock);
72246da40f3719 Felipe Balbi 2011-08-19  2077  
72246da40f3719 Felipe Balbi 2011-08-19  2078  	return ret;
72246da40f3719 Felipe Balbi 2011-08-19  2079  }
72246da40f3719 Felipe Balbi 2011-08-19  2080  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

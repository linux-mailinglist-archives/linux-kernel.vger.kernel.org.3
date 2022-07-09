Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3756C5F9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiGIC0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIC0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:26:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289EC79EDE;
        Fri,  8 Jul 2022 19:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657333580; x=1688869580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFZVAj+FkFGpC1g8eGOjw6NUO0iZIB6Us6j0cDgGUKU=;
  b=EJWH8H40Uw2kaEUrAyGpENWaEKGUI5l22TvroLefmXNcAVj8VWAd8W5O
   rhruf8ycFjlw4duzyVP5B5oygmWKfJ8auUHqfl5p75TSIfYnY33P02KLm
   RRiH/rG06F8eW/q6pwvm9KgfJ6EQ63yv6dtY5nQl6dCuM8FWXh+3vtylY
   zFHXstH4EhkdxjlJSkK86X54REMNHYXbDtoyPowiGwE0uj9JCoOwNShxc
   lMYg7OsOWgWQwSHsWGVF6XPwDSoFVnC5nG0MMMjb0IufsBN7S8LnP9y34
   o5lmDLx0bUqAvfdeOcqRG+RI1FPB1ZVL5c41Ez760qbMH7xOfXwNCP4F1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348386967"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="348386967"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 19:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="770962947"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2022 19:26:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA0Aj-000OCS-3n;
        Sat, 09 Jul 2022 02:26:17 +0000
Date:   Sat, 9 Jul 2022 10:26:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Thinh.Nguyen@synopsys.com,
        quic_jackp@quicinc.com, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH 3/5] usb: dwc3: gadget: Adjust IRQ management during soft
 disconnect/connect
Message-ID: <202207091054.eGEUvBXn-lkp@intel.com>
References: <20220708185007.21743-4-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708185007.21743-4-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220709/202207091054.eGEUvBXn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/457fe4752b0f6dcc5c1b329f91003b7ffc518b44
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wesley-Cheng/Fix-controller-halt-and-endxfer-timeout-issues/20220709-025241
        git checkout 457fe4752b0f6dcc5c1b329f91003b7ffc518b44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/usb/dwc3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/dwc3/gadget.c: In function 'dwc3_gadget_ep_dequeue':
>> drivers/usb/dwc3/gadget.c:2032:41: warning: unused variable 'flags' [-Wunused-variable]
    2032 |         unsigned long                   flags;
         |                                         ^~~~~


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

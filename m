Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8888D5A8BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiIADaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIADal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:30:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC2B6560;
        Wed, 31 Aug 2022 20:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662003040; x=1693539040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H01PCuiyd40E2Sn4rLATH1b3gLoeYNHhf+08oRoJQcM=;
  b=Ws7LMzvtqHd98K/CrkhJfGL1GlQR75RUVYiwXRBbwV89VGvKAizIHMuq
   iNlnMzPq4oFwHMippnRX+LP3rofAzl2aIxNoU+xJZMwdTHAW3zMea9zTU
   pt46IcZGPbMbuVLvAGqpP7K+kUCgJLYw4jNL6DpC1eNKWrEiitCHqL3oV
   NkkodlZrvPexJqAVJM5N7Ho9mD0diGwIoTxCLZQdhiw+4gUuIhyPZU+Oq
   yUyWe7WpJTfZn17C6kUTCIRnYpsfgYTZXS8C7M/eTiIgXuNtJADI1hSCN
   cHWhwnr5QvSSBe/GmSETAPmYKW8YRdHoNkhfqk5KlEKq3WLsm7vpzMQX2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="381902004"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="381902004"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 20:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="563280845"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 20:30:37 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTaua-00013C-2v;
        Thu, 01 Sep 2022 03:30:36 +0000
Date:   Thu, 1 Sep 2022 11:30:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH v5 1/5] usb: dwc3: Avoid unmapping USB requests if
 endxfer is not complete
Message-ID: <202209011138.FP2kL0sl-lkp@intel.com>
References: <20220831183242.27826-2-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831183242.27826-2-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on next-20220831]
[cannot apply to linus/master v6.0-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wesley-Cheng/Fix-controller-halt-and-endxfer-timeout-issues/20220901-023750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220901/202209011138.FP2kL0sl-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/18bece9b81c07fbd2dbcec20ef8cc7e56d1ebf35
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wesley-Cheng/Fix-controller-halt-and-endxfer-timeout-issues/20220901-023750
        git checkout 18bece9b81c07fbd2dbcec20ef8cc7e56d1ebf35
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/usb/dwc3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/usb/dwc3/gadget.c:968:6: error: conflicting types for 'dwc3_remove_requests'
   void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
        ^
   drivers/usb/dwc3/core.h:1563:6: note: previous declaration is here
   void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep);
        ^
>> drivers/usb/dwc3/gadget.c:1029:33: error: too many arguments to function call, expected 2, have 3
           dwc3_remove_requests(dwc, dep, -ECONNRESET);
           ~~~~~~~~~~~~~~~~~~~~           ^~~~~~~~~~~
   drivers/usb/dwc3/core.h:1563:6: note: 'dwc3_remove_requests' declared here
   void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep);
        ^
   drivers/usb/dwc3/gadget.c:2347:34: error: too many arguments to function call, expected 2, have 3
                   dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
                   ~~~~~~~~~~~~~~~~~~~~           ^~~~~~~~~~
   drivers/usb/dwc3/core.h:1563:6: note: 'dwc3_remove_requests' declared here
   void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep);
        ^
   3 errors generated.


vim +/dwc3_remove_requests +968 drivers/usb/dwc3/gadget.c

   967	
 > 968	void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
   969	{
   970		struct dwc3_request		*req;
   971	
   972		dwc3_stop_active_transfer(dep, true, false);
   973	
   974		/* If endxfer is delayed, avoid unmapping requests */
   975		if (dep->flags & DWC3_EP_DELAY_STOP)
   976			return;
   977	
   978		/* - giveback all requests to gadget driver */
   979		while (!list_empty(&dep->started_list)) {
   980			req = next_request(&dep->started_list);
   981	
   982			dwc3_gadget_giveback(dep, req, status);
   983		}
   984	
   985		while (!list_empty(&dep->pending_list)) {
   986			req = next_request(&dep->pending_list);
   987	
   988			dwc3_gadget_giveback(dep, req, status);
   989		}
   990	
   991		while (!list_empty(&dep->cancelled_list)) {
   992			req = next_request(&dep->cancelled_list);
   993	
   994			dwc3_gadget_giveback(dep, req, status);
   995		}
   996	}
   997	
   998	/**
   999	 * __dwc3_gadget_ep_disable - disables a hw endpoint
  1000	 * @dep: the endpoint to disable
  1001	 *
  1002	 * This function undoes what __dwc3_gadget_ep_enable did and also removes
  1003	 * requests which are currently being processed by the hardware and those which
  1004	 * are not yet scheduled.
  1005	 *
  1006	 * Caller should take care of locking.
  1007	 */
  1008	static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
  1009	{
  1010		struct dwc3		*dwc = dep->dwc;
  1011		u32			reg;
  1012	
  1013		trace_dwc3_gadget_ep_disable(dep);
  1014	
  1015		/* make sure HW endpoint isn't stalled */
  1016		if (dep->flags & DWC3_EP_STALL)
  1017			__dwc3_gadget_ep_set_halt(dep, 0, false);
  1018	
  1019		reg = dwc3_readl(dwc->regs, DWC3_DALEPENA);
  1020		reg &= ~DWC3_DALEPENA_EP(dep->number);
  1021		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
  1022	
  1023		/* Clear out the ep descriptors for non-ep0 */
  1024		if (dep->number > 1) {
  1025			dep->endpoint.comp_desc = NULL;
  1026			dep->endpoint.desc = NULL;
  1027		}
  1028	
> 1029		dwc3_remove_requests(dwc, dep, -ECONNRESET);
  1030	
  1031		dep->stream_capable = false;
  1032		dep->type = 0;
  1033		dep->flags &= DWC3_EP_TXFIFO_RESIZED;
  1034	
  1035		return 0;
  1036	}
  1037	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A958A2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiHDVis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiHDVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:38:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B56E891;
        Thu,  4 Aug 2022 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659649121; x=1691185121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7V7nahT9XjNpAFfGKFhNDUbQQAH1G6z336pao7dnqlM=;
  b=ZZ7FUJ5XVQGAbp6SzaZDrtwUxunSYus8PbNB0GqiTMiwv0kDyU9srbc7
   pTTds5DCE0gzVRMJfWAMwhmrUrUEr0aVQhFBdGtYFqwUPoHWFQV6a/qU8
   7rqTgquS9nxRfQOK2Dg+T4n3IpJaAbI+bprTOJ3WHe5eV9sbBrO9xW5Lk
   De5GaBW4LhwHxdLtFsQ/ieYkWLrsj35SB5tuN3nVAHXUREb1UNJLLrgHm
   QZbYlMLhheSBVsPXHBMIaNv4wHygg/uWX7b+dsB4gOW6hRFpLnCCwcKp2
   J07ZVXlcVyc3X/sB3QnMEXYiQX1z6Nl4EBymyxiLWYyWuMsAGDDG3qmxE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="288810594"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="288810594"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="692782608"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2022 14:38:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJiY7-000IsJ-2b;
        Thu, 04 Aug 2022 21:38:35 +0000
Date:   Fri, 5 Aug 2022 05:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 6/9] usb: dwc3: qcom: fix peripheral and OTG suspend
Message-ID: <202208050544.ijUhoUyB-lkp@intel.com>
References: <20220804151001.23612-7-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804151001.23612-7-johan+linaro@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on linus/master next-20220804]
[cannot apply to robh/for-next v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johan-Hovold/usb-dwc3-qcom-fix-wakeup-implementation/20220804-231122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arc-randconfig-r002-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050544.ijUhoUyB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f3778ca026b16474e49c5e0188a0eb91d73eef2f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Johan-Hovold/usb-dwc3-qcom-fix-wakeup-implementation/20220804-231122
        git checkout f3778ca026b16474e49c5e0188a0eb91d73eef2f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/usb/dwc3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/dwc3/dwc3-qcom.c: In function 'dwc3_qcom_read_usb2_speed':
>> drivers/usb/dwc3/dwc3-qcom.c:313:25: warning: variable 'hcd' set but not used [-Wunused-but-set-variable]
     313 |         struct usb_hcd *hcd;
         |                         ^~~


vim +/hcd +313 drivers/usb/dwc3/dwc3-qcom.c

   308	
   309	static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
   310	{
   311		struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
   312		struct usb_device *udev;
 > 313		struct usb_hcd *hcd;
   314	
   315		/*
   316		 * FIXME: Fix this layering violation.
   317		 */
   318		hcd = platform_get_drvdata(dwc->xhci);
   319	
   320		/*
   321		 * It is possible to query the speed of all children of
   322		 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
   323		 * currently supports only 1 port per controller. So
   324		 * this is sufficient.
   325		 */
   326	#ifdef CONFIG_USB
   327		udev = usb_hub_find_child(hcd->self.root_hub, 1);
   328	#else
   329		udev = NULL;
   330	#endif
   331		if (!udev)
   332			return USB_SPEED_UNKNOWN;
   333	
   334		return udev->speed;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

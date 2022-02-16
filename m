Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04A4B901F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiBPSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:24:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiBPSYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:24:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E21F4675;
        Wed, 16 Feb 2022 10:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645035830; x=1676571830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ihSLN9mFszCQxNpqXLpE2iJlvxCxngLICSSjcAirB4=;
  b=VWYC1AKm1Qwa0HHp1/eKTS4bMFjXJ9hrAvcJLDrhrJpWxw5hWueTsOkE
   iPp4jFJzjewT/5ALSu7UEnJPRB/okGMiXfUSNYneOlAGGoMz3mkkqx1F7
   KjlwswbsdNC2+cfCJB4zexA32oR8Tz03P2SZ/uTNFazN4bd91b1vYY/Kx
   +nsajdnlkTHV7cFLxPpSO+BkTLu4o+j/ycRE0WI3FLAXTPLt4wAWbiMn8
   /h/kV6GzGaEP9cffXSDIsofZxvJhmyKeQONoj8hHffX1JO/aEezTQPRWe
   9V5vpo8Nn3rQsYbJ0RFZpD9qDpQ3qhOxD0YO1O7ehRs7EkV+HBaUOQJWF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234227415"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="234227415"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 10:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="540255419"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2022 10:23:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKOxu-000B1p-Ad; Wed, 16 Feb 2022 18:23:46 +0000
Date:   Thu, 17 Feb 2022 02:22:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     3090101217@zju.edu.cn, laurent.pinchart@ideasonboard.com,
        balbi@kernel.org, gregkh@linuxfoundation.org, corbet@lwn.net,
        mchehab+huawei@kernel.org, rdunlap@infradead.org, bilbao@vt.edu,
        pawell@cadence.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH] usb: gadget: uvc: add framebased stream support
Message-ID: <202202170211.van9U4Ha-lkp@intel.com>
References: <20220216081651.9089-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216081651.9089-1-3090101217@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on linus/master v5.17-rc4 next-20220216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/3090101217-zju-edu-cn/usb-gadget-uvc-add-framebased-stream-support/20220216-162037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arm-randconfig-r023-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170211.van9U4Ha-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/475fba6b60329d9270b699550907a5e077cd84b6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review 3090101217-zju-edu-cn/usb-gadget-uvc-add-framebased-stream-support/20220216-162037
        git checkout 475fba6b60329d9270b699550907a5e077cd84b6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash block// drivers/usb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/function/uvc_configfs.c:1091:3: warning: field  within 'struct uvcg_frame::(unnamed at drivers/usb/gadget/function/uvc_configfs.c:1068:2)' is less aligned than 'union uvcg_frame::(anonymous at drivers/usb/gadget/function/uvc_configfs.c:1091:3)' and is usually due to 'struct uvcg_frame::(unnamed at drivers/usb/gadget/function/uvc_configfs.c:1068:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   union {
                   ^
   1 warning generated.


vim +1091 drivers/usb/gadget/function/uvc_configfs.c

  1060	
  1061	/* -----------------------------------------------------------------------------
  1062	 * streaming/<mode>/<format>/<NAME>
  1063	 */
  1064	
  1065	struct uvcg_frame {
  1066		struct config_item	item;
  1067		enum uvcg_format_type	fmt_type;
  1068		struct {
  1069			u8	b_length;
  1070			u8	b_descriptor_type;
  1071			u8	b_descriptor_subtype;
  1072			u8	b_frame_index;
  1073			u8	bm_capabilities;
  1074			u16	w_width;
  1075			u16	w_height;
  1076			u32	dw_min_bit_rate;
  1077			u32	dw_max_bit_rate;
  1078	
  1079			/*
  1080			 * The layout of last three members of framebased frame
  1081			 * is different from uncompressed frame.
  1082			 *   Last three members of uncompressed frame are:
  1083			 *     u32	dw_max_video_frame_buffer_size;
  1084			 *     u32	dw_default_frame_interval;
  1085			 *     u8	b_frame_interval_type;
  1086			 *   Last three members of framebased frame are:
  1087			 *     u32	dw_default_frame_interval;
  1088			 *     u8	b_frame_interval_type;
  1089			 *     u32	dw_bytes_perline;
  1090			 */
> 1091			union {
  1092				u32	dw_max_video_frame_buffer_size;
  1093				u32	dw_bytes_perline;
  1094			};
  1095			u32	dw_default_frame_interval;
  1096			u8	b_frame_interval_type;
  1097		} __attribute__((packed)) frame;
  1098		u32 *dw_frame_interval;
  1099	};
  1100	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

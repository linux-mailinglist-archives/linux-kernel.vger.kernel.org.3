Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6A504A36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiDRAlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiDRAlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:41:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A46F13CE9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650242347; x=1681778347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W/FOGbfBO1uzsedtaXhnrQ7XRiDUUeWu0fO23cE8nbg=;
  b=JnxFnNvygYUZN3yxKHfiXKMnf0yqzEBKOPupm9b4ry0qcDXZ7UiUV2kb
   I7Gu8zedtot23zjAHxueeSKglunvq9C9136wrAeQNb9A7GQ5EYlKSU6Ep
   H6RRfP+NdqklcxditeD3G1CIsAXA8fqTwxbCQLwdx+AN9T5J0kHN5pHC8
   wC/QvAmblgszQr54XgZAtQyGExjSNeNg5mzrjaRbDD8uRb0tmB59sywZJ
   YDl30q9EZL/lVHFpbEqAVgyA328TsPpydJrOjq0srUfNjAz1slpwhmFyJ
   /7UDUIptVyHeFN7DvhOBiysUc2hDwFDbfi48UByTukwZHZKinhcMIuW/z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="349875288"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="349875288"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="664869489"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2022 17:39:05 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngFQ0-0004El-ND;
        Mon, 18 Apr 2022 00:39:04 +0000
Date:   Mon, 18 Apr 2022 08:38:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.17 1407/1567]
 net/openvswitch/flow_netlink.o: warning: objtool:
 ovs_nla_free_nested_actions()+0x59: unreachable instruction
Message-ID: <202204180805.B20PtvEM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.17
head:   a0cf6ca05464247e59c4fa08d60effea9b1d3a5b
commit: 53bce9d19b0a9d245b25cd050b81652ed974a509 [1407/1567] net: openvswitch: fix leak of nested actions
config: x86_64-randconfig-a001-20220418 (https://download.01.org/0day-ci/archive/20220418/202204180805.B20PtvEM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=53bce9d19b0a9d245b25cd050b81652ed974a509
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.17
        git checkout 53bce9d19b0a9d245b25cd050b81652ed974a509
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/openvswitch/flow_netlink.o: warning: objtool: ovs_nla_free_nested_actions()+0x59: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

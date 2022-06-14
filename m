Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD054AE16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbiFNKPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbiFNKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:15:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC846C94
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655201730; x=1686737730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ID2M6Sj0qrd5VHGCZ92H3g3eMnoHwccj90vfEFpb3VE=;
  b=OlWh3ragsbhYCf/0NhjDej/nNXyv1CXVycvwrGwhXD5+dEe+XR4zN8pt
   2Y5rqu3rElqti4zfmGay6nuQblIwQdp9dUQuppmilBlS/YF5xav6u+8T4
   /zh9AV8QAy1IV6HmwIzF1yEB+UJDsaV9Jh5tniEdFmoX8oGdVN69joaRN
   rlAgXz30BDL4U4gtRsonFgArkpPflbKrQntgmvCUwfMMt+XZjnmdZxO1m
   NWZzGYhO7kiaoFsgaHKIvLouTQ6ZnqFSI2sSteLsX1DUbvaBcmICJtVp/
   2wGCBikHLcayL75rqNW9jePdjn/KqRDdLeN4gjUpt1WWZ8OZy8fcHJLkg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279291316"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279291316"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 03:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="673804771"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 03:15:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o13a0-000Lm5-U6;
        Tue, 14 Jun 2022 10:15:24 +0000
Date:   Tue, 14 Jun 2022 18:15:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 1407/3797]
 net/openvswitch/flow_netlink.o: warning: objtool:
 ovs_nla_free_nested_actions()+0x56: unreachable instruction
Message-ID: <202206141802.RwIEdKtZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   a554a1e2ef7fa48cebd9cc2349804974247c0958
commit: 53bce9d19b0a9d245b25cd050b81652ed974a509 [1407/3797] net: openvswitch: fix leak of nested actions
config: x86_64-randconfig-r026-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141802.RwIEdKtZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=53bce9d19b0a9d245b25cd050b81652ed974a509
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 53bce9d19b0a9d245b25cd050b81652ed974a509
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/openvswitch/flow_netlink.o: warning: objtool: ovs_nla_free_nested_actions()+0x56: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

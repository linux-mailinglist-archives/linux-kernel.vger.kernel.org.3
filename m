Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93A55C78E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiF0LHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiF0LHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:07:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4A064D0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656328065; x=1687864065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0iekNPM+c47kF7MNkUcOlBcOvoSu/MWELLtsfXRow64=;
  b=I+DYOhNvggV/wPAAthBsVl/Np6RccAjZqC0sChRGo8xM5yErF8+ZPbXh
   G3DQFZB1/sAM8/dDzW2X/YPuX5zqh4REao+IYrI1h3eD0Z1eVD4Ax+VIh
   IIbOqRCwjgGAgcLc98rZ5/DcW5VZHfoUYmdTekGfST3ussDTjLE2rY6mM
   gsvQsau3JctcWARTXbBt+CRoWKGYxgVO8yy1B9kbSbgcIWwosQeyqGZvT
   FgFLa0iqVAmTETXoyxyHpSAXXHE6DPDYhaB0vZeZZVn6B2GGGd49MKC8V
   YKGOjjMWzCLfDTd8JTz75crVrAnxtXp1gs8z24GgMwuATsQnrlv8pGjpb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282158190"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="282158190"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 04:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="622516807"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2022 04:07:43 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5mak-0008Sr-K4;
        Mon, 27 Jun 2022 11:07:42 +0000
Date:   Mon, 27 Jun 2022 19:06:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool:
 vmw_port_hb_in+0xc3: return with modified stack frame
Message-ID: <202206271843.ojKYNPyR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03c765b0e3b4cb5063276b086c76f7a612856a9a
commit: c25e1c55822f9b3b53ccbf88b85644317a525752 kbuild: do not create *.prelink.o for Clang LTO or IBT
date:   4 weeks ago
config: x86_64-randconfig-r014-20220627 (https://download.01.org/0day-ci/archive/20220627/202206271843.ojKYNPyR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c25e1c55822f9b3b53ccbf88b85644317a525752
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c25e1c55822f9b3b53ccbf88b85644317a525752
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_in+0xc3: return with modified stack frame
>> drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_out+0xc3: return with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4250DF05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiDYLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiDYLnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:43:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5282F3A5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650886797; x=1682422797;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cKkY3NP2nSwczfAMdBIM47Qg1x0nzWEJN4rmAmfMcb4=;
  b=ActjDTlg+5sEb2JmnRYPYcjrnsbOgJj0K85xCPx7DjpBiMzqK4dGh0BZ
   lVJmLpTUPSBFa0FIzK5ZhIzodKX7ZDSx40mMo3hAjsnB+H1giNhhi+IQm
   um13CFQd0uhCBwO3cVo8O4zk1nonzLHOHNSfIz69SNWLBY6p6lookMdYe
   aGWJ4Cum6ijyMVpb5OO8IZoHfNSlwsV4TAEbDQnLHTYgDWTDAOh7qKXwf
   r2rBap8E55a7L9LNqL0tJHGmUVrLP5512+abMJiFO6ru71FlSnMAeEsJC
   SNUPoVnS79tuD9RWtjWwZWHum2eYJsZHGFK5FeS7bkQrFW2xyqtdq0FfQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="262821639"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="262821639"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="872562906"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2022 04:39:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nix4N-0002SZ-Cd;
        Mon, 25 Apr 2022 11:39:55 +0000
Date:   Mon, 25 Apr 2022 19:39:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:objtool/merge 10/22]
 arch/x86/crypto/crc32c-intel.prelink.o: warning: objtool: crc_pcl+0x7c:
 missing int3 after indirect jump
Message-ID: <202204251911.2U695rHT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/merge
head:   f9f7e4ba3c52f40e0567cf909abba71f955d1b97
commit: 4804bfa24cc3a1d0f6ae97a549b2f2f95cea21f9 [10/22] objtool: Extricate sls from stack validation
config: x86_64-randconfig-p002-20220425 (https://download.01.org/0day-ci/archive/20220425/202204251911.2U695rHT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4804bfa24cc3a1d0f6ae97a549b2f2f95cea21f9
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue objtool/merge
        git checkout 4804bfa24cc3a1d0f6ae97a549b2f2f95cea21f9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/crypto/crc32c-intel.prelink.o: warning: objtool: crc_pcl+0x7c: missing int3 after indirect jump

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631F3528747
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbiEPOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiEPOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:42:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA32DD4C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652712155; x=1684248155;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uokgEubVQ9i6ZsvjgXaoP93pmMIsQrs/2gbc1dQeuNQ=;
  b=iORNAeVZtATqe/x2j7LN2jHujPzNO839G2oA8AaITXSAygJgBFD/J2Ay
   c1Tz37XyJtDD98Mg2gsssL7TkP8eIILpCmaRBusyBDlCm3BCxsa8yO9ll
   GN1g1PVEdStjvUkvVf/cuoTkha7WPXUZdndmBj12d38sDGEhKG7LOixVP
   KmYE0WissxrzsJDbvjmF8GrQWNcCf+g9cYE1+MbThYY8SomoKp6mBnLjR
   EyOdnYN4UqRp0k2T/ig+yWmyLYZD9pbtTyBx1a3ABsOz9aMUXab8z3sID
   0/adlYqPI32V9YmMxCqYRuXwazyLpK5l7GeZ0QPgIaq4XNYjasHAw8dcl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="296121529"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="296121529"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 07:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="699565857"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2022 07:42:33 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqbvc-00006f-ID;
        Mon, 16 May 2022 14:42:32 +0000
Date:   Mon, 16 May 2022 22:42:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: __fentry__()+0x8d: call without frame
 pointer save/setup
Message-ID: <202205162241.fTWJlbRp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42226c989789d8da4af1de0c31070c96726d990c
commit: ed53a0d971926e484d86cce617ec02a7ee85c3fe x86/alternative: Use .ibt_endbr_seal to seal indirect calls
date:   9 weeks ago
config: x86_64-randconfig-c022-20220516 (https://download.01.org/0day-ci/archive/20220516/202205162241.fTWJlbRp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed53a0d971926e484d86cce617ec02a7ee85c3fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ed53a0d971926e484d86cce617ec02a7ee85c3fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ibt_selftest()+0x11: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: __fentry__()+0x8d: call without frame pointer save/setup
   vmlinux.o: warning: objtool: ibt_selftest()+0x1e: return with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

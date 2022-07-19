Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178325797CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiGSKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGSKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:39:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10803AB3F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658227190; x=1689763190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AH6u2SqPuDc0ZSfUwnzFcTuchyvVaMSRomRWCzwbamY=;
  b=auqbRngh95VRr7xaHLSlIFe3UrwBP+iYLvNwpDCtWwBhZRLcj4K2uTsT
   MO+iWqWdg9pAMlZdTaCb0p6V0rujwey+Iw20vgTvD2Mm0S9mDrtarlIYq
   yCQJlMh+2z1GKY1UPJNmsIJ9DXNPyIFh1lhit+SiA7NhV3J+D5tWLQDt6
   TrXNrQALKfUgvZ2LmIBjE5+cytT7yCtNKz/NLGRkZ6fZsKFQj+JElRiy/
   rVbvBXcyt/gAQvpRI6nghUFuwwUOWgIDPYYo5ksFnujsHXqWv/Nlqdybw
   GG63sffvFv11sTzTvzJceDj2t8NlqJ1Zp1cLL/tJI+aq4YRXWWcGuFMzW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312143771"
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="312143771"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 03:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="572800499"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2022 03:39:49 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDkdo-0005ZK-En;
        Tue, 19 Jul 2022 10:39:48 +0000
Date:   Tue, 19 Jul 2022 18:39:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: cmsg_sender.c:149:36: warning: excess elements in struct initializer
Message-ID: <202207191852.s2Owu7Iz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: 4d397424a5e0e130d5e8d0023776f0aa2e791f51 selftests: net: cmsg_sender: support setting SO_TXTIME
date:   5 months ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   cmsg_sender.c: In function 'cs_write_cmsg':
   cmsg_sender.c:148:24: error: variable 'so_txtime' has initializer but incomplete type
     148 |                 struct sock_txtime so_txtime = {
         |                        ^~~~~~~~~~~
   cmsg_sender.c:149:26: error: 'struct sock_txtime' has no member named 'clockid'
     149 |                         .clockid = CLOCK_MONOTONIC,
         |                          ^~~~~~~
>> cmsg_sender.c:149:36: warning: excess elements in struct initializer
     149 |                         .clockid = CLOCK_MONOTONIC,
         |                                    ^~~~~~~~~~~~~~~
   cmsg_sender.c:149:36: note: (near initialization for 'so_txtime')
   cmsg_sender.c:148:36: error: storage size of 'so_txtime' isn't known
     148 |                 struct sock_txtime so_txtime = {
         |                                    ^~~~~~~~~
   cmsg_sender.c:153:48: error: 'SO_TXTIME' undeclared (first use in this function)
     153 |                 if (setsockopt(fd, SOL_SOCKET, SO_TXTIME,
         |                                                ^~~~~~~~~
   cmsg_sender.c:153:48: note: each undeclared identifier is reported only once for each function it appears in
   cmsg_sender.c:167:35: error: 'SCM_TXTIME' undeclared (first use in this function)
     167 |                 cmsg->cmsg_type = SCM_TXTIME;
         |                                   ^~~~~~~~~~
>> cmsg_sender.c:148:36: warning: unused variable 'so_txtime' [-Wunused-variable]
     148 |                 struct sock_txtime so_txtime = {
         |                                    ^~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

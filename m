Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875B25295F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiEQAUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiEQAUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:20:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1CC4614B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652746800; x=1684282800;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RAKtHpxnO63k2u5Hg8G0usU4BU1kONxht9kfRZB89Cg=;
  b=axFF7o6SpgOP8D8ovck6PifPp8DMcSsTm9P8zUzBhi345MNFch4C7HID
   f3QjEfy3UTrF21eus1ra/e8tchRWq3kgRf3lbiABaMBei7f2CkIU4U+sz
   8cP7kXDYsZyXVVwmVcAdgvC0cgh5pjuZuqMec7MS1OYpC7v4RxwCluOAU
   RVZwWXykOZANuvdBE8Zi43Lmbf88fyhp0vVxdhWsttBYxnnDKjE8a//HQ
   8P3FycY99Lx+Md1HxTXg7b2CSRHQEmKvsfPDc/i0z3DnNqiLaNoKgvhv6
   FqGRfeQ21mpKHZ8QvrahJ2hoTdiXJ26InV2ZdfegdXXR8aBIinIjiFRdH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258564116"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="258564116"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 17:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="544611645"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 May 2022 17:19:57 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqkwO-0000RN-Og;
        Tue, 17 May 2022 00:19:56 +0000
Date:   Tue, 17 May 2022 08:19:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 765/2373] drivers/iio/accel/mma8452.o:
 warning: objtool: mma8452_write_raw()+0x4d: unreachable instruction
Message-ID: <202205170814.FXKeCNQL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   e1382731ef4e5e1634896596ebe74e48b9ed2b73
commit: 0646c782086f2a6081186a9898d40ea8886b8ade [765/2373] iio: mma8452: Fix probe failing when an i2c_device_id is used
config: x86_64-randconfig-r011-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170814.FXKeCNQL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=0646c782086f2a6081186a9898d40ea8886b8ade
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 0646c782086f2a6081186a9898d40ea8886b8ade
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/ net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/mma8452.o: warning: objtool: mma8452_write_raw()+0x4d: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

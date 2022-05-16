Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA01527D57
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiEPGDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiEPGDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:03:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D7D286CB;
        Sun, 15 May 2022 23:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652681024; x=1684217024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1v0gXTVWzrv1Ak0hvGpAZxVte7No78o5+bvzTZpAf4=;
  b=nhF1v3HU2rBnjImULPdZFpikTa78CLL5jxyMUjv4XGJQq432MWN4T1FO
   mruEkplEp2vdo8eLIY2NVIpnoPRWPhB3ns7Mz0I+Xbd98yFu0Gqy2pp4d
   FLQdPeOYT+Q585Utow6JsjwQKdKJWQCevSdaTPyyhqWKA1vltXHWWI2QZ
   0yJ1nUC7NflmfGCJcLYWODXs864PQdZK424Z/zwYL+5BVxP3rWsEzsPzR
   ldBMyX70wb4wJS3sGoY9D/LIvI6NT19avRR1xQ9CtqTS9DjnkDaYE1BEu
   4KmpyysyX7tZMVdf80i98LkqaFLH0Ib1O/JHaVYYm3P9MaYvJcnvCF50f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="269564394"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="269564394"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 23:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="699393422"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2022 23:03:41 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqTpU-0002C1-99;
        Mon, 16 May 2022 06:03:40 +0000
Date:   Mon, 16 May 2022 14:02:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [v2 1/2] kbuild: move scripts/mod/ build to modules_prepare
Message-ID: <202205161340.DscM2Rht-lkp@intel.com>
References: <20220514040207.282910-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514040207.282910-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on linux/master linus/master v5.18-rc7 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-move-scripts-mod-build-to-modules_prepare/20220514-120519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: s390-randconfig-m031-20220514 (https://download.01.org/0day-ci/archive/20220516/202205161340.DscM2Rht-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e538a965b373cb35813fd55f75b7646c4fb92a8d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/kbuild-move-scripts-mod-build-to-modules_prepare/20220514-120519
        git checkout e538a965b373cb35813fd55f75b7646c4fb92a8d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> /bin/bash: line 1: scripts/mod/modpost: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

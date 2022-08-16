Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D82596564
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiHPWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiHPWSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:18:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E29019C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660688285; x=1692224285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pHNRsmO3TscJoYhtn5ldO7gjZHTEK8owm0e2rym4/s=;
  b=hXfkwJgwMhCvgUm2WxgNjFktD8XFYlz6+U3rUJ9rs6YM9K41Wyezvcuj
   nFyx9oysx8zCYndfD5VLNpM1je0J+tIoLWvxB8WidEVFzeyhfy320qAg3
   /AhO47MMu3Ad67Se8IgW+KR1LlvcmIz96W/9/N/6CjyrQG/GLQ0u95tKZ
   A7OGKUyQX7M0pSe8l2sWQS21RAEZkZS/wIMs4KTz0os573IAHB02vIr7m
   giY51f/BSUU3+dvYAkt01AT/b2tBSRrcn/HGpDIfv7QJc56r8TkHEVArZ
   9ccuw4rNQecivgaK6mcklhU5ZqALSj+B4OxVofmty+LnvtnruqNLpf7hN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272734389"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272734389"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 15:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="675395953"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 15:18:02 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO4ss-0000H2-12;
        Tue, 16 Aug 2022 22:18:02 +0000
Date:   Wed, 17 Aug 2022 06:17:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kbuild-all@lists.01.org, kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drivers: virtio: balloon - update inflated memory
Message-ID: <202208170648.gcM3nXqB-lkp@intel.com>
References: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on char-misc/char-misc-testing linus/master v6.0-rc1 next-20220816]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Atanasov/Make-place-for-common-balloon-code/20220816-184943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: i386-buildonly-randconfig-r004-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170648.gcM3nXqB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Atanasov/Make-place-for-common-balloon-code/20220816-184943
        git checkout d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "balloon_set_inflated_free" [drivers/virtio/virtio_balloon.ko] undefined!
>> ERROR: modpost: "balloon_set_inflated_total" [drivers/virtio/virtio_balloon.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

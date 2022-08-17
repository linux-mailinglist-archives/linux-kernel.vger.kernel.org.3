Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB60596869
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiHQFKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiHQFKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:10:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AEB6D9C6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660713014; x=1692249014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AvafYqkxq3og1b2wyCNF9KJ/y92RWHvhMeHMG1bWo50=;
  b=gwKMnaSmWHsbF4FXK81eEIxk09lTJMszglVWCF94PygYGWVGvwG6iIU6
   3X83EmA4mGFxalS4nP6ti5IcGo7f88yhKHK3w2SDdach0ZZ4+n8R9aH6q
   MnkAPzMQznSDLpp8eZVHDQlc3UnVaLeuV2FjtQOX5vhCs5OPJz2XjNNxo
   K9lLF3LkvSupLmDMvDgh3UZGqKrIjF/Z9zrmOj8tNYthHf13h5+gSLE2j
   5vt/tYm3oJ5USXuar8viU53oBc5ifB2sjblqrfgyVPk/btPulUI6+qRLR
   /0iLHAeqeRcU9WOnXwAbH6l+xLY8AgqkKnImbvHBpimAsEqlCsgSkEwOX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289972251"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="289972251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="557976200"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2022 22:10:11 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOBJj-0000bM-07;
        Wed, 17 Aug 2022 05:10:11 +0000
Date:   Wed, 17 Aug 2022 13:09:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drivers: virtio: balloon - update inflated memory
Message-ID: <202208171338.xAU3O9KJ-lkp@intel.com>
References: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220817/202208171338.xAU3O9KJ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Atanasov/Make-place-for-common-balloon-code/20220816-184943
        git checkout d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "balloon_set_inflated_total" [drivers/virtio/virtio_balloon.ko] undefined!
>> ERROR: modpost: "balloon_set_inflated_free" [drivers/virtio/virtio_balloon.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

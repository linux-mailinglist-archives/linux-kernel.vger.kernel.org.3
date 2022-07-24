Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F208157F229
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 02:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiGXAXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 20:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGXAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 20:23:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560A140AD;
        Sat, 23 Jul 2022 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658622197; x=1690158197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FkfucsltimmyJei0ltMaCIfrrDXHIuYViPxYpvd7rpc=;
  b=l6u+Pun/6gGsP8L2yeXVpK1pawYqgHVxgajcNweozN+BFZ+9sGpYu1h9
   8x4FWb4Z7s7M6T6wgHKlRsuWb17/A/kbJhVCiTFBaxj7g4usof1+20qNE
   9cIPWolrQ35kGcTvQYdrirYT6j+YZgxSqW5q08HK/9NeITiZgxZkbWQH6
   s3T3Cs7E/iG1r5oU5B9uk4OxLwJN+z6nxUkINea8xmuyE+mgB4e8cKYu0
   unADpiUfK1WBKFbLTuyulMObznjhrFWRaOvDIFhJGf2S1B+ceNisTVgdm
   uCf2QHWoD8o0ILM/kRYfo7w8bjOXN8a9LsI7IW4ul8A9azTNbcG4wMx63
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="270538612"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="270538612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 17:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="741434139"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2022 17:23:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFPOr-0003Hn-1y;
        Sun, 24 Jul 2022 00:23:13 +0000
Date:   Sun, 24 Jul 2022 08:22:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>, linux-iio@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <202207240827.C5K7s1KU-lkp@intel.com>
References: <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 180c6cb6b9b79c55b79e8414f4c0208f2463af7d]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220724-014146
base:   180c6cb6b9b79c55b79e8414f4c0208f2463af7d
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220724/202207240827.C5K7s1KU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/eb385b5ff634acc29a3d9f20847e62ec73484fcb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220724-014146
        git checkout eb385b5ff634acc29a3d9f20847e62ec73484fcb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [drivers/iio/pressure/bmp280.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF255AC59
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiFYULg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiFYULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:11:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA00413E9E;
        Sat, 25 Jun 2022 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656187891; x=1687723891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v0zBwBZ5Y5uFdrQf31Ecdcp8Net+EpFvhp5KLBPyt0I=;
  b=gZ5LYaup2j/EXebSC0B246ORyrFEnMTg0D6kpUd1gC0GcBSzyAR4I/Rd
   v6AwRTy+Tzrz3TbKhZvZIfuPZAFkFWHVHozyPegeUrawkQ5lUecYlGBD1
   R5hRwuMcGV9hcS1qKNVbkOVVkrX/xL79UPszDL/y6nP0CMQekKN8pw5SF
   KWJTtZg9qyKjfidTgn/2BS2hoPlW5gYRp+EAPHEHYOZiqx1gq92Gadkup
   j5Yslzb96pDdsfnLsEMW+cmpsMzYPwTZLwq50BQrEL+ScoXp9waH7mSu+
   UlkfszF4+h8JqYjyAINN38ta14yR8b+13m+ZWMQPrg2xP/xp6JcX2fVsl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="264263713"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="264263713"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 13:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="589377273"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Jun 2022 13:11:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5C7s-0006Fz-HN;
        Sat, 25 Jun 2022 20:11:28 +0000
Date:   Sun, 26 Jun 2022 04:11:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     kbuild-all@lists.01.org, Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: bmp280: Add support for BMP380 sensor
 family
Message-ID: <202206260315.GVEVwo9d-lkp@intel.com>
References: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: sh-buildonly-randconfig-r004-20220626
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/56e3f8aecddacdbe204fbe5e28032ef2befae647
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
        git checkout 56e3f8aecddacdbe204fbe5e28032ef2befae647
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/iio/pressure/bmp280-core.o: in function `bmp380_read_press':
>> bmp280-core.c:(.text+0x5f0): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

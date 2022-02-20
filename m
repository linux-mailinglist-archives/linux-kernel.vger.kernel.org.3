Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB434BD169
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiBTUU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:20:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbiBTUUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC454C787;
        Sun, 20 Feb 2022 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645388394; x=1676924394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlNCeNeRCUKG5xiQPa/coq+l8HnadNht1MDbLYfKSWk=;
  b=YjffgtgklNnK+v6RNeaa+uqVnHALHCG4LHYOnOuFtr5m/BmSzY3Nsl+x
   xGfmOFkU9QOiUafi50UJ3XvFLNJj5aSlmRAzWMliBaAcvuIV0gesFZl9+
   FvcuKEFkkS5wWbAg3qVPqZSVPimfsA8FScdwAbBTJtxlLKGPT7ZRhbJjZ
   OfMxlsiANAt2FxmwQ8n5K2UWSzXsxL2856aX/UF2PyXZUzZ8lsr5wp69A
   vN7iNysJ/vcQqf7MsaxIPhmJpM3GpzjUfExC++SdYKnbBVaI7jP6aPJQy
   WvkmZvXGARqTbwjBaUoxQCFmNkwxG7ICTXQIqQhfkuZaWQY2ZnHsDJZM3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="250219138"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="250219138"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 12:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="636447450"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2022 12:19:50 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLsgP-0000iC-RB; Sun, 20 Feb 2022 20:19:49 +0000
Date:   Mon, 21 Feb 2022 04:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] media: staging: tegra-vde: De-stage driver
Message-ID: <202202210437.dSxqXeIm-lkp@intel.com>
References: <20220220172950.3401-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220172950.3401-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I love your patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on tegra/for-next linus/master v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Osipenko/Add-V4L-stateless-video-decoder-API-support-to-NVIDIA-Tegra-driver/20220221-013333
base:   git://linuxtv.org/media_tree.git master
config: x86_64-randconfig-m001
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/dd010c4949a824dda7225b7074050b5736d3894a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dmitry-Osipenko/Add-V4L-stateless-video-decoder-API-support-to-NVIDIA-Tegra-driver/20220221-013333
        git checkout dd010c4949a824dda7225b7074050b5736d3894a
        make W=1 ARCH=x86_64  randconfig
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 distclean

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> scripts/Makefile.clean:15: drivers/staging/media/tegra-vde/Makefile: No such file or directory
>> make[5]: *** No rule to make target 'drivers/staging/media/tegra-vde/Makefile'.
   make[5]: Failed to remake makefile 'drivers/staging/media/tegra-vde/Makefile'.
   make[4]: *** [scripts/Makefile.clean:68: drivers/staging/media/tegra-vde] Error 2
   make[4]: Target '__clean' not remade because of errors.
   make[3]: *** [scripts/Makefile.clean:68: drivers/staging/media] Error 2
   make[3]: Target '__clean' not remade because of errors.
   make[2]: *** [scripts/Makefile.clean:68: drivers/staging] Error 2
   make[2]: Target '__clean' not remade because of errors.
   make[1]: *** [Makefile:1838: _clean_drivers] Error 2
   make[1]: Target 'distclean' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'distclean' not remade because of errors.


vim +15 scripts/Makefile.clean

2315c6e4227815 Sam Ravnborg   2005-07-25  12  
2a691470345a00 Sam Ravnborg   2005-07-25  13  # The filename Kbuild has precedence over Makefile
db8c1a7b2ca25f Sam Ravnborg   2005-07-27  14  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
db8c1a7b2ca25f Sam Ravnborg   2005-07-27 @15  include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
^1da177e4c3f41 Linus Torvalds 2005-04-16  16  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF85E58B39E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 05:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbiHFDxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 23:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHFDxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 23:53:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA491409F;
        Fri,  5 Aug 2022 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659758026; x=1691294026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EOrwo1+w2rYt40oWYg7x/pWgKGfaH9b92Nt/uY+i8tA=;
  b=Xw+ycoQwGTg32EQO2VtRJPJJKhRtLeZq9Gw44IV0faylS1PystKP9+fY
   mLOpiAixN2PTU6/Pswu6F0Gq/SckK2AVoEttexSvlIb4guB5jarkp1DQm
   RiFvfhAgwsvnV35e0FWu79apcmv/HdUhYyeFErCpXczTzexP2HstoOHgn
   ChhFWElpR3nbLgncRina45IkaAkwfIshAc7mtFljiRtkjQqAET0ad2OCP
   mDX7RdIlwJpGsXzo1nku8MEPycjARYuWH5b6+Uq39oUMH3qSukrQK+nBi
   MKEX+9KeCAALwEBFovJDKFjMxl1uBfhCptGN+qxjer3whIz/F0Wn9FHRI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270110861"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="270110861"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 20:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="746063365"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2022 20:53:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKAsg-000Jzj-0A;
        Sat, 06 Aug 2022 03:53:42 +0000
Date:   Sat, 6 Aug 2022 11:53:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair@alistair23.me>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shawnguo@kernel.org, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        s.hauer@pengutronix.de, andreas@kemnade.info,
        krzysztof.kozlowski+dt@linaro.org, rydberg@bitmath.org,
        dmitry.torokhov@gmail.com,
        Alistair Francis <alistair@alistair23.me>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v8 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <202208061128.pfj2DRWO-lkp@intel.com>
References: <20220802125827.34509-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802125827.34509-2-alistair@alistair23.me>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on shawnguo/for-next linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/Add-support-for-the-Cypress-cyttsp5/20220802-210032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220806/202208061128.pfj2DRWO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9c372983ef0b8eb7ad48c025a156f80943269af7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alistair-Francis/Add-support-for-the-Cypress-cyttsp5/20220802-210032
        git checkout 9c372983ef0b8eb7ad48c025a156f80943269af7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/cyttsp5.c: In function 'cyttsp5_handle_irq':
>> drivers/input/touchscreen/cyttsp5.c:254:31: warning: array subscript 'int[0]' is partly outside array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
     254 |         for (nbyte = 0, *axis = 0; nbyte < size; nbyte++)
         |                         ~~~~~~^~~
   drivers/input/touchscreen/cyttsp5.c:333:12: note: while referencing 'num_cur_tch'
     333 |         u8 num_cur_tch;
         |            ^~~~~~~~~~~
   drivers/input/touchscreen/cyttsp5.c:257:15: warning: array subscript 'int[0]' is partly outside array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
     257 |         *axis &= max - 1;
         |               ^~
   drivers/input/touchscreen/cyttsp5.c:333:12: note: while referencing 'num_cur_tch'
     333 |         u8 num_cur_tch;
         |            ^~~~~~~~~~~
   drivers/input/touchscreen/cyttsp5.c:257:15: warning: array subscript 'int[0]' is partly outside array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
     257 |         *axis &= max - 1;
         |         ~~~~~~^~~~~~~~~~
   drivers/input/touchscreen/cyttsp5.c:333:12: note: while referencing 'num_cur_tch'
     333 |         u8 num_cur_tch;
         |            ^~~~~~~~~~~
   drivers/input/touchscreen/cyttsp5.c:255:23: warning: array subscript 'int[0]' is partly outside array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
     255 |                 *axis += ((xy_data[nbyte] >> bofs) << (nbyte * 8));
         |                       ^~
   drivers/input/touchscreen/cyttsp5.c:333:12: note: while referencing 'num_cur_tch'
     333 |         u8 num_cur_tch;
         |            ^~~~~~~~~~~
   drivers/input/touchscreen/cyttsp5.c:255:23: warning: array subscript 'int[0]' is partly outside array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
     255 |                 *axis += ((xy_data[nbyte] >> bofs) << (nbyte * 8));
         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/cyttsp5.c:333:12: note: while referencing 'num_cur_tch'
     333 |         u8 num_cur_tch;
         |            ^~~~~~~~~~~


vim +254 drivers/input/touchscreen/cyttsp5.c

   248	
   249	static void cyttsp5_get_touch_axis(int *axis, int size, int max, u8 *xy_data,
   250					   int bofs)
   251	{
   252		int nbyte;
   253	
 > 254		for (nbyte = 0, *axis = 0; nbyte < size; nbyte++)
   255			*axis += ((xy_data[nbyte] >> bofs) << (nbyte * 8));
   256	
   257		*axis &= max - 1;
   258	}
   259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

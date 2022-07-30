Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128A585B47
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiG3Q0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiG3Q0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 12:26:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2E412AA8;
        Sat, 30 Jul 2022 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659198376; x=1690734376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Q+FWptKRG93qMxrxl+jm48DEZB8pTDjVw3Ayvx0u5I=;
  b=ZgHYjIUQFpq3/TlBLcou6sxcb2IZSrGt2iNGSZk8VybyQwLNr2MvoNIX
   lK6N2pF8BTbbJCn+bjkRbRJHp+5O3YNFxCfHuHEQr0WuSOO1+Na0RUBEs
   t/znM6EURRuAH+gvU30nZC0XBI8Vj+4yCcbbsQBEh3+xcWjaKU3widD6B
   hAkkxGLYSpXDh9C9r2zA/LGpfufqHbkdaT0z8nPJuwRjIDBDtLOh73T2Z
   XkkgyZo1Wr67Q6hBhrMlGRdHrVNlYsA5fjHdSl9w8Tvvf7dwRiMpxNvQG
   +EafG+rpyzKHgPPcF3MTfE4JbmpW4Vz95OD4rReVB8gl9nYwnYrng2RDk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="352932310"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="352932310"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 09:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="669574543"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2022 09:26:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHpI6-000CyZ-0a;
        Sat, 30 Jul 2022 16:26:14 +0000
Date:   Sun, 31 Jul 2022 00:25:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3] timers: Optimize usleep_range()
Message-ID: <202207310022.EWBc4pBK-lkp@intel.com>
References: <c146e183a0f0b819f8ec5ab8934905d01a642506.1659126514.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c146e183a0f0b819f8ec5ab8934905d01a642506.1659126514.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/timers-Optimize-usleep_range/20220730-131330
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git cceeeb6a6d02e7b9a74ddd27a3225013b34174aa
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/driver-api/basics:36: kernel/time/timer.c:2117: WARNING: Unknown target name: "idle".

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

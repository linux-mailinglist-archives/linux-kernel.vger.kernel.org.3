Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7254ACC7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbiFNJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbiFNJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:02:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C728D;
        Tue, 14 Jun 2022 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655197345; x=1686733345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0Lwj0WHXq5DvIM05cukc4RzsTQJxK8reJqxBhNXM9w=;
  b=GvrtWt1yhC2i2dsNiiMx2ryyFzY+Ev/2ekv2P/jI/26ty3TKRSksrZ9I
   BupC6ypmX4CspMo8PZwNchQeFKMr1JDmynFWqu++ElNYg/vNfHQj0+czm
   TdUoHdnSUdZexxV119fp7T9YjUlqqjk/S7x9glsPTNNWcV+jKLcLzALXk
   K4pYHFmgZuVqdFZ63GZnudGkbQNUFOtQlgkt1KHshx7pRz7aWBdh8zrBe
   tAa3Fta53/Lnn2AECyHUIqbX2t/HB8rwz06JMt0m+N2+O7O5wdGEvi9Ts
   SkKAyUPoUGi0/FK4Se2oWXryzIdHfcX8NaZwpe9Ex0/GeVx2iMHDeJaYq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364894313"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="364894313"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="761887848"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2022 02:02:23 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o12RK-000Lha-9y;
        Tue, 14 Jun 2022 09:02:22 +0000
Date:   Tue, 14 Jun 2022 17:01:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Message-ID: <202206141610.QsI0Qgur-lkp@intel.com>
References: <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.19-rc2 next-20220614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergei-Shtepa/blksnap-creating-non-persistent-snapshots-for-backup/20220614-025950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: openrisc-randconfig-c023-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141610.QsI0Qgur-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> block/blk-core.c:792:3-4: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

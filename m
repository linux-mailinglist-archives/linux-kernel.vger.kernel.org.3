Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069D5588039
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiHBQ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbiHBQ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:26:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08931357D1;
        Tue,  2 Aug 2022 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659457589; x=1690993589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tiBSblYW/2t/w/mFNBPrgfZNPY+zHS74rkuAv0IZzyM=;
  b=mr0O9CWyyFR4Fp+M1HSkuEFBH6ITq+hKgnnJAKkidS1OZjSDA0yqieUg
   32pGbGoD8Nv5gbQ8QjWUkriF1qZj0w3BR7+j8TaC83ARPAIjgbZ5r3z4K
   UB/bEkBXdtD+QTFvc4XhlQERNMU5uBnQWOQTSfTmCRbICg7ehE9RrpLum
   cgeDtSvQxg2QfM38GxvgtQ6OJIj8LpEvnmd1QAf+Xdxa47OKO5QeTKroe
   h3+yiafTelUw7jRnWmrTSejSzk08N+fPi4G+IsfvDXiHctWtCFjFyKZot
   7mqfuU+80E4pZX/RBCqwwlDdiNKzRSZaCQ4QixoJolJqplC/iCw8x4LbC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287016768"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="287016768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 09:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="705437155"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2022 09:26:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIuiu-000GCj-0q;
        Tue, 02 Aug 2022 16:26:24 +0000
Date:   Wed, 3 Aug 2022 00:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <chu.stanley@gmail.com>
Cc:     kbuild-all@lists.01.org, Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3] ufs: core: ufshcd: use local_clock() for debugging
 timestamps
Message-ID: <202208030016.1zdowaT3-lkp@intel.com>
References: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next linus/master v5.19 next-20220728]
[cannot apply to bvanassche/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220802-083420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-s042-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030016.1zdowaT3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/c72f82f12e7c9f361f0d13d4ab583f9834384464
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220802-083420
        git checkout c72f82f12e7c9f361f0d13d4ab583f9834384464
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/ufs/core/ufshcd.o: in function `ufshcd_print_evt':
>> ufshcd.c:(.text+0x105f): undefined reference to `__udivdi3'
   ld: drivers/ufs/core/ufshcd.o: in function `ufshcd_print_host_state':
>> ufshcd.c:(.text.unlikely+0xcf): undefined reference to `__udivdi3'
>> ld: ufshcd.c:(.text.unlikely+0x101): undefined reference to `__udivdi3'
   ld: drivers/ufs/core/ufshcd.o: in function `ufshcd_print_trs.cold':
   ufshcd.c:(.text.unlikely+0x6d9): undefined reference to `__udivdi3'
   ld: ufshcd.c:(.text.unlikely+0x712): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

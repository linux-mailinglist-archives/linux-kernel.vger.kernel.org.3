Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F12591FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 14:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiHNMID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHNMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 08:08:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EAB19C29;
        Sun, 14 Aug 2022 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660478879; x=1692014879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICs/avSZrCKg8YMmStunQeWmnebLsJDwt6iepJumIJU=;
  b=hGrqPJQytPltKAdxiJa0OCOW2akXwoYHWbCchpSGWBZV2xyq1pmx2WvB
   BASvqQwzWGnrrGJRUkIZ/O1Qp6F7iVzc1X06tUIcYD5kQiXKhoXpB3aLr
   YdsFwzwwnXskKoleLBaZP5GFnbLGPzBbfnMo9hLDzvb9/7YvH+nRygBed
   Rv6xQOgFPswMJTLvkShxajGqMv4Z1M4KMIbqkFSbG+Q5myMz6aiYZuNOf
   O9NZL7arbPgWlhf29g/PeQm2RvjcvCsuKYjuOrmrf4M4WVAVxgrw9qzhy
   erVAHTy0TRs1dPA1PuAOeP6vNwgXK4vbPzFIFQyVb3zMiTekLF0g7wrWX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317798699"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="317798699"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 05:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="674555971"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 05:07:56 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNCPM-000041-0t;
        Sun, 14 Aug 2022 12:07:56 +0000
Date:   Sun, 14 Aug 2022 20:07:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     kah.jing.lee@intel.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     kbuild-all@lists.01.org, rafael.j.wysocki@intel.com,
        tien.sung.ang@intel.com, dinh.nguyen@intel.com,
        Kah Jing Lee <kah.jing.lee@intel.com>, Zhou@vger.kernel.org,
        Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch
 to drivers
Message-ID: <202208141908.sFdK5QCc-lkp@intel.com>
References: <20220721123149.416618-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123149.416618-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on soc/for-next v5.19]
[cannot apply to char-misc/char-misc-testing linus/master next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/kah-jing-lee-intel-com/drivers-misc-intel_sysid-Add-sysid-from-arch-to-drivers/20220721-213214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 8af028c2b22bc04f5ab59cd39fa97ccf14aa8f25
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220814/202208141908.sFdK5QCc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/5e0d691312542fbb751afb99bd7b537b9a975750
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review kah-jing-lee-intel-com/drivers-misc-intel_sysid-Add-sysid-from-arch-to-drivers/20220721-213214
        git checkout 5e0d691312542fbb751afb99bd7b537b9a975750
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/misc/intel_sysid.c:66:24: sparse: sparse: symbol 'intel_sysid_attr_group' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

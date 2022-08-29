Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC325A42E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH2GE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2GEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:04:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183A40541;
        Sun, 28 Aug 2022 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661753063; x=1693289063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9QX1nGj+yCM2pSYLXNZCvw+fux2Ve7iQRsH0RGslY5w=;
  b=SIaSEfjjtBNsCChDeF3sRLdgUD+tACxWJahFnwnDWTchDjL3yg0Go+8a
   WbS+rsmbw85VuwlXFGkt4xGIRVhoEnskQ/osSEvumHy2hBnhlmoIW4Kfq
   52t+G+Xnhs1PGVqpwwL9c39S628Qh0rqPGbpxzgzIwJIR10p3wjfL3aTq
   y/yYrYn99Bk1BDXyEz/M0DL8kPiSKmiegkWUppSwsHiZeHvTkWiwGIlcg
   o4nlBVNxMMJv4pWSNqGrw+lqwzSe1h/RSmD24WEeEdj1FVz15aQUSIIZE
   RdjEcOdV7c+eGxG+73J9mJ8d6l1j1ZcbMnAmIOvkEu3GF6el2Lr8z3CeZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295593743"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295593743"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 23:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="562100039"
Received: from lkp-server01.sh.intel.com (HELO b2bbdd52f619) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2022 23:04:20 -0700
Received: from kbuild by b2bbdd52f619 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSXsh-0000Fa-1u;
        Mon, 29 Aug 2022 06:04:19 +0000
Date:   Mon, 29 Aug 2022 14:03:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     kbuild-all@lists.01.org, hdegoede@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] ACPI: s2idle: Add a new ->enter() callback for
 platform_s2idle_ops
Message-ID: <202208291354.DVB7CN3N-lkp@intel.com>
References: <20220828222121.4951-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828222121.4951-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/Add-some-extra-debugging-mechanisms-for-s0i3/20220829-062334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20220829/202208291354.DVB7CN3N-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/af6400b51370a2bc04906697aeec5a938e6ee446
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/Add-some-extra-debugging-mechanisms-for-s0i3/20220829-062334
        git checkout af6400b51370a2bc04906697aeec5a938e6ee446
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/acpi/x86/s2idle.c:426:13: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/acpi/x86/s2idle.c:426:33: sparse: sparse: restricted suspend_state_t degrades to integer
>> drivers/acpi/x86/s2idle.c:489:6: sparse: sparse: symbol 'acpi_s2idle_enter' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

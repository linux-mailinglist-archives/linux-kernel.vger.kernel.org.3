Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315105A406A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 02:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiH2Aju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 20:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2Ajs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:39:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F416FB81;
        Sun, 28 Aug 2022 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661733587; x=1693269587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/qieQDOo6+/p9ViLMatx2O13GVymXD6TsGdYxn4iX1Q=;
  b=HhVutsQ9hgirTiJPICcIfAi2423rpEPgLy/o1gMpE6Y+5XUxI/F7i0fe
   /baMHHOuPtZuo52DHzM1iVrRWJzarytxTRDZVWn3lnJ5SohrtAgiG2Dbq
   T3gxXqLjG/RELKPWmeIrop8pnOjrHc3jJbHdEeS984P8/QpGVJWvN/bt7
   Rpmch2C6t6eiXiPYjLGvksGfir79SMByEl0WOM+m6X4S7X0enK57tE0hD
   nkKlMpfhDPgg2u7TwejGvir/DDI3HzD9sc/6JQtD3pytJMlbr+gyqnmt/
   KYkkUd90argqe95s9GF/iAiY/DrA50CSL+eU/mur3+vXIKnIzSDSN0St1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="293525168"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="293525168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 17:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="644243408"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2022 17:39:44 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSSoZ-0001pN-1g;
        Mon, 29 Aug 2022 00:39:43 +0000
Date:   Mon, 29 Aug 2022 08:38:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     kbuild-all@lists.01.org, hdegoede@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] ACPI: s2idle: Add a new ->enter() callback for
 platform_s2idle_ops
Message-ID: <202208290836.C3cKDij9-lkp@intel.com>
References: <20220828222121.4951-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828222121.4951-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.0-rc2 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/Add-some-extra-debugging-mechanisms-for-s0i3/20220829-062334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220829/202208290836.C3cKDij9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/af6400b51370a2bc04906697aeec5a938e6ee446
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/Add-some-extra-debugging-mechanisms-for-s0i3/20220829-062334
        git checkout af6400b51370a2bc04906697aeec5a938e6ee446
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/x86/s2idle.c:489:6: warning: no previous prototype for 'acpi_s2idle_enter' [-Wmissing-prototypes]
     489 | void acpi_s2idle_enter(void)
         |      ^~~~~~~~~~~~~~~~~


vim +/acpi_s2idle_enter +489 drivers/acpi/x86/s2idle.c

   488	
 > 489	void acpi_s2idle_enter(void)
   490	{
   491		struct acpi_s2idle_dev_ops *handler;
   492	
   493		if (!lps0_device_handle || sleep_no_lps0)
   494			return;
   495	
   496		list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
   497			if (handler->enter)
   498				handler->enter();
   499		}
   500	}
   501	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

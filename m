Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210994F1320
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357901AbiDDKcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357109AbiDDKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:32:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD77C9FCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649068218; x=1680604218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3RN1otC0NPrOipqgJl3sDhiojlobhjW+sltWEzivqII=;
  b=jfKEJV53OhY2Br1F2paX4yqR4sRLQqzTbGTETEEhpnSCnTHgUmqmi6jn
   48yv8uR3GMqhB0SRFuk8kjJouV/D0fea6uw+OT9QIBGOELl6CQmEzs9bA
   eexqoxABrQvGUqnI+SWfmEyzQTCEoM29PEps3ZAJooq2QjVLaPN53uI86
   zpmY/mIXneH+GH2dScuJisiCoJdx2/AZss13qLRhqi4PKD1C1Eh7ex9tN
   wBsuWvoBudVMWWBs+yzoX18MAo9YAhfCq9eLbYvHzb4fxB5gWoA/vcpUq
   k+EFzUqw8ZCMhbH2wVezMk552XMX1d4qqBh0mJDMeAG5nG6HU7Qy5+Kxw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="241070993"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="241070993"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 03:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="607993640"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2022 03:30:11 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbJyM-0001y9-Jc;
        Mon, 04 Apr 2022 10:30:10 +0000
Date:   Mon, 4 Apr 2022 18:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        eauger@redhat.com, oupton@google.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 10/18] KVM: arm64: Support SDEI_PE_{MASK, UNMASK}
 hypercall
Message-ID: <202204041802.MNEvTtnJ-lkp@intel.com>
References: <20220403153911.12332-11-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-11-gshan@redhat.com>
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

Hi Gavin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc1 next-20220404]
[cannot apply to kvmarm/next kvm/master linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Gavin-Shan/Support-SDEI-Virtualization/20220403-234350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
config: arm64-randconfig-c004-20220404 (https://download.01.org/0day-ci/archive/20220404/202204041802.MNEvTtnJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/sdei.c:346:15-18: Unneeded variable: "ret". Return "SDEI_SUCCESS" on line 352

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

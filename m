Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274955158CD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381710AbiD2XJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiD2XIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:08:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1737856208;
        Fri, 29 Apr 2022 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651273529; x=1682809529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEPSNx3MNc/ZekE9s3e3pRUa0Lo8iBRO6Gpd2edzmVs=;
  b=Iy+gtWoOKb+jnbLDSOdftwfo4jqB7qTkilQiXZq0ABC7tGDOaZYeODDV
   HLLeQqBFtSucNIlSgEbMXFX3cC7UqutE4lvJ4MT6KqmpipKgECM2SeAX2
   HELiKQsqdXD6c7gh//MOVvQHA35QoyN/SO9RfHGhSAVCfntKR1FxeoEs+
   VVSLraBa1Xg3w8kRUFcrQJpC1Bay1FoHNWcKj+BGArbOCYF+nbM1Qqi8H
   Y0YTrVfv9SfFyn+3E8Ujw5ZWzqjL2xqPZWm8ghMEMKVj4XrBDro7RPvHW
   ylwvKLmy9z62SdQM+iH5mxmLvM3nLeg8LgpEUPVGWQiph0hz9xpFBjuxG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="329743140"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="329743140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 16:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="618925784"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2022 16:05:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkZfw-0006fH-6T;
        Fri, 29 Apr 2022 23:05:24 +0000
Date:   Sat, 30 Apr 2022 07:05:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     kbuild-all@lists.01.org, mka@chromium.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_saluvala@quicinc.com, quic_rjliao@quicinc.com,
        mcchou@chromium.org,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
Message-ID: <202204300657.daSC8FPf-lkp@intel.com>
References: <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on bluetooth-next/master bluetooth/master linus/master v5.18-rc4 next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Balakrishna-Godavarthi/WAR-to-handle-WCN6750-hardware-issue/20220429-193129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: m68k-randconfig-c003-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300657.daSC8FPf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/bluetooth/hci_qca.c:1633:42-44: WARNING !A || A && B is equivalent to !A || B

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

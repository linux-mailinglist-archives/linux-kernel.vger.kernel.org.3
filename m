Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019DD47B997
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhLUFit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:38:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:50036 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhLUFis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640065128; x=1671601128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zs0dPTi+r3Qe7mJ4MIOg1p3jf9i/MVTyETUJag0lPxI=;
  b=HIiy09ljumEDhQ0mjKCjTrpTrjStPAqSOzVFS2T5PM+6KGESmtreks8k
   lOYKrCh3d2fjqlI4u/u7udJmHagLc54ijiZfkzxY994r/zPrpWB8KVQUn
   b8+GEUEbtiIQCVJU1yr4VvU1w8RGQONfcIhCFozQ+aQeoQbgy0kaDj2IN
   HyOzhQ1aKX7teK2BSB3u/FAtWxl4clZoDyOmf0DpDbwXeeb8YM6jr2005
   Hmu6hLrQum7vapQDS7hL23jcVd1iA/tsoclJq67n3i/XM0xT3FGVGR5H6
   +WBB3aRf34xSl7B5qY6gvWa+uYRIRllmlb4NmftaVb9eb5nvIhA9jTWvl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240284722"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="240284722"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 21:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="684541923"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Dec 2021 21:38:46 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzXrJ-0008jh-Rf; Tue, 21 Dec 2021 05:38:45 +0000
Date:   Tue, 21 Dec 2021 13:37:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [jic23-iio:togreg 100/103] drivers/iio/adc/xilinx-ams.c:621
 ams_get_pl_scale() warn: inconsistent indenting
Message-ID: <202112211357.E8JZJON6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
head:   d37e6bb10a086d7d7695122e03e6431eb0ea503a
commit: 18834cbc79f73f2814d8388de9eea5bbaddcc3d6 [100/103] iio: adc: Add Xilinx AMS driver
config: s390-randconfig-m031-20211220 (https://download.01.org/0day-ci/archive/20211221/202112211357.E8JZJON6-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/iio/adc/xilinx-ams.c:621 ams_get_pl_scale() warn: inconsistent indenting

vim +621 drivers/iio/adc/xilinx-ams.c

   591	
   592	static int ams_get_pl_scale(struct ams *ams, int address)
   593	{
   594		int val, regval;
   595	
   596		switch (address) {
   597		case AMS_SUPPLY1:
   598		case AMS_SUPPLY2:
   599		case AMS_SUPPLY3:
   600		case AMS_SUPPLY4:
   601		case AMS_SUPPLY5:
   602		case AMS_SUPPLY6:
   603		case AMS_VCCAMS:
   604		case AMS_VREFP:
   605		case AMS_VREFN:
   606			val = AMS_SUPPLY_SCALE_3VOLT_mV;
   607			break;
   608		case AMS_SUPPLY7:
   609			regval = readl(ams->pl_base + AMS_REG_CONFIG4);
   610			if (FIELD_GET(AMS_VUSER0_MASK, regval))
   611				val = AMS_SUPPLY_SCALE_6VOLT_mV;
   612			else
   613				val = AMS_SUPPLY_SCALE_3VOLT_mV;
   614			break;
   615		case AMS_SUPPLY8:
   616			regval = readl(ams->pl_base + AMS_REG_CONFIG4);
   617			if (FIELD_GET(AMS_VUSER1_MASK, regval))
   618				val = AMS_SUPPLY_SCALE_6VOLT_mV;
   619			else
   620				val = AMS_SUPPLY_SCALE_3VOLT_mV;
 > 621						break;
   622		case AMS_SUPPLY9:
   623			regval = readl(ams->pl_base + AMS_REG_CONFIG4);
   624			if (FIELD_GET(AMS_VUSER2_MASK, regval))
   625				val = AMS_SUPPLY_SCALE_6VOLT_mV;
   626			else
   627				val = AMS_SUPPLY_SCALE_3VOLT_mV;
   628			break;
   629		case AMS_SUPPLY10:
   630			regval = readl(ams->pl_base + AMS_REG_CONFIG4);
   631			if (FIELD_GET(AMS_VUSER3_MASK, regval))
   632				val = AMS_SUPPLY_SCALE_6VOLT_mV;
   633			else
   634				val = AMS_SUPPLY_SCALE_3VOLT_mV;
   635			break;
   636		case AMS_VP_VN:
   637		case AMS_REG_VAUX(0) ... AMS_REG_VAUX(15):
   638			val = AMS_SUPPLY_SCALE_1VOLT_mV;
   639			break;
   640		default:
   641			val = AMS_SUPPLY_SCALE_1VOLT_mV;
   642			break;
   643		}
   644	
   645		return val;
   646	}
   647	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

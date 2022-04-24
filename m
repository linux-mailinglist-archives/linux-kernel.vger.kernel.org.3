Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD850D17D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiDXLao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiDXLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:30:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE074D271
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650799659; x=1682335659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f86awJir5y2qFkW7/f/0NgIk7L9zR1YS6i+/Y6Nxix4=;
  b=NOy9szBFEK7mxEPIiFs3jNxbl2fLmD5cU57CQ3kizj431PCY8c1NXmuP
   asANwgnqUZYFf0sk/UufzaqHrYTpEBL3QlKnTa6fxnvSBNmvsHjhZOyaT
   DikngLpqEZjljfMxBUmTiYyB3/oBUgS8GTH38ghfj6tjrog4m1yFr47oZ
   nc0Nr1cr4+PyajMpjSFN/zSogE4jFRKEPMDPY2GWZYs/EZFcjW9nu+XBz
   v/UYjQuFWZ++4hQvdT/M+5KznKw7PDB/CDstJKIlOi9RHUuOEXjZFEx2h
   ZPnUbfMHki6Zg/iYQNzHckslZT+MpOg1j+1BqR7Tz+ShibJDdr3f2qcty
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="264820818"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="264820818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 04:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="704184274"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2022 04:27:37 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niaOu-0001Or-Tk;
        Sun, 24 Apr 2022 11:27:36 +0000
Date:   Sun, 24 Apr 2022 19:27:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 4/5] staging: vt6655: Replace two VNSvInPortD with
 ioread64_lo_hi
Message-ID: <202204241941.XzwKN0gg-lkp@intel.com>
References: <db5ba681cea27de815b172f8b93a8fd1efa30e99.1650784817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5ba681cea27de815b172f8b93a8fd1efa30e99.1650784817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Hortmann/staging-vt6655-Replace-macro-VNSvInPortW-D-with-ioread16-32/20220424-154730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 1efba7ef1d7da5944493728c5375fef5b2130de4
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220424/202204241941.XzwKN0gg-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6e7e66f536e6d9d9eef8e7786de652b2702e1ee8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-vt6655-Replace-macro-VNSvInPortW-D-with-ioread16-32/20220424-154730
        git checkout 6e7e66f536e6d9d9eef8e7786de652b2702e1ee8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/staging/vt6655/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/vt6655/card.c: In function 'CARDbGetCurrentTSF':
>> drivers/staging/vt6655/card.c:757:23: error: implicit declaration of function 'ioread64_lo_hi' [-Werror=implicit-function-declaration]
     757 |         *pqwCurrTSF = ioread64_lo_hi(iobase + MAC_REG_TSFCNTR);
         |                       ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ioread64_lo_hi +757 drivers/staging/vt6655/card.c

   730	
   731	/*
   732	 * Description: Read NIC TSF counter
   733	 *              Get local TSF counter
   734	 *
   735	 * Parameters:
   736	 *  In:
   737	 *      priv         - The adapter to be read
   738	 *  Out:
   739	 *      qwCurrTSF       - Current TSF counter
   740	 *
   741	 * Return Value: true if success; otherwise false
   742	 */
   743	bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
   744	{
   745		void __iomem *iobase = priv->port_offset;
   746		unsigned short ww;
   747		unsigned char data;
   748	
   749		MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
   750		for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
   751			data = ioread8(iobase + MAC_REG_TFTCTL);
   752			if (!(data & TFTCTL_TSFCNTRRD))
   753				break;
   754		}
   755		if (ww == W_MAX_TIMEOUT)
   756			return false;
 > 757		*pqwCurrTSF = ioread64_lo_hi(iobase + MAC_REG_TSFCNTR);
   758	
   759		return true;
   760	}
   761	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE650D259
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiDXOou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiDXOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:44:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD6689A9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650811306; x=1682347306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3qakcHWEZbb/tE6ZLoH7UT+OIS/LUOLJ19s9X3V6mpY=;
  b=AAjLRufFmOwjNIuBMtv/AWFi44zdt+tP+yf2xfDcGNbJCBhp9RpmNsPr
   plEk45w9AudvqAUfqKBDVpdmAChii8/RUn0C+JvoQFXmhiOByt5XdwrcT
   U8tnQo6YuWa2AP2Vw61MqSz6eDi2AtX8kwAhAWjeroblzKmCOTI57N0hx
   qdfPmJyw3+kb/uUZ1liCdpxyMAl11wgx70741wwY1IDmUg5nnW4dg0yU4
   K2dZsfDsGIC+kwgdcw1I9KmGXDE5hdJxjrUXd+YZneSDsU6rjCh8Hx1Jz
   YvDsAZ1RKyjadyXR8akWg8sKLzWtpKra6wLkp25nInXEKuClaoATqwXct
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="264841045"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="264841045"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 07:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="704223679"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2022 07:41:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nidQk-0001Wr-6u;
        Sun, 24 Apr 2022 14:41:42 +0000
Date:   Sun, 24 Apr 2022 22:40:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 4/5] staging: vt6655: Replace two VNSvInPortD with
 ioread64_lo_hi
Message-ID: <202204242226.Y6Amb3he-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220424/202204242226.Y6Amb3he-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6e7e66f536e6d9d9eef8e7786de652b2702e1ee8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-vt6655-Replace-macro-VNSvInPortW-D-with-ioread16-32/20220424-154730
        git checkout 6e7e66f536e6d9d9eef8e7786de652b2702e1ee8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/vt6655/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/staging/vt6655/card.c:757:16: error: call to undeclared function 'ioread64_lo_hi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           *pqwCurrTSF = ioread64_lo_hi(iobase + MAC_REG_TSFCNTR);
                         ^
   1 error generated.


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

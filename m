Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2904E9BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiC1QMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiC1QMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:12:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB85C346
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648483860; x=1680019860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EyFL9vehGGSWjtUPI8WwMooTYrzEzpqH7Ia4FoQJCYM=;
  b=eizt9stGJU9Tfo+aLJD/bcaix8B+rgPJdCW4R654o388RHlMmJiNBo+D
   y1rh6G41F7m7sUgrO4J8BaJgpKMhrr5LDizoQ/G59JtmgPa/RCb6u0S+F
   +4STVMj6c9Iq7Zc4mpqMGdChhU7PjJVKOeqgO8Ow60hslF6iNew7mq7qu
   Rkruqfab1VKBjsSzA8ZugQAetWIT5qvCwHq87Zne9yy8/2r6C78LWY8ST
   obdhIGWIKRBT9pKLRFrcVp+cBjLb477JbdpbFEop5/rrDLVFnVS4zcON4
   eY+wL3MJqfzRmbtULMaiKZHr7wxOtLuseI29RXzasTTXVS7EUCRcmB2uK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="256615881"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="256615881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 09:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="652144977"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2022 09:10:47 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYrx8-00028y-VM; Mon, 28 Mar 2022 16:10:46 +0000
Date:   Tue, 29 Mar 2022 00:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mohan Kumar <mkumard@nvidia.com>, tiwai@suse.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz,
        ville.syrjala@linux.intel.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        Mohan Kumar <mkumard@nvidia.com>
Subject: Re: [PATCH] ALSA: hda: Avoid unsol event during RPM suspending
Message-ID: <202203290053.emhsIdTK-lkp@intel.com>
References: <20220328091411.31488-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328091411.31488-1-mkumard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on v5.17 next-20220328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohan-Kumar/ALSA-hda-Avoid-unsol-event-during-RPM-suspending/20220328-171517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: s390-randconfig-c005-20220327 (https://download.01.org/0day-ci/archive/20220329/202203290053.emhsIdTK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/80c4e21f5e97cd4b779806fa5da5bb7392e2874f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mohan-Kumar/ALSA-hda-Avoid-unsol-event-during-RPM-suspending/20220328-171517
        git checkout 80c4e21f5e97cd4b779806fa5da5bb7392e2874f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from sound/pci/hda/patch_hdmi.c:21:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from sound/pci/hda/patch_hdmi.c:21:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from sound/pci/hda/patch_hdmi.c:21:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> sound/pci/hda/patch_hdmi.c:1644:15: error: no member named 'runtime_status' in 'struct dev_pm_info'
                   (dev->power.runtime_status == RPM_SUSPENDING))
                    ~~~~~~~~~~ ^
   12 warnings and 1 error generated.


vim +1644 sound/pci/hda/patch_hdmi.c

  1620	
  1621	/* update ELD and jack state via HD-audio verbs */
  1622	static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
  1623						 int repoll)
  1624	{
  1625		struct hda_codec *codec = per_pin->codec;
  1626		struct hdmi_spec *spec = codec->spec;
  1627		struct hdmi_eld *eld = &spec->temp_eld;
  1628		struct device *dev = hda_codec_dev(codec);
  1629		hda_nid_t pin_nid = per_pin->pin_nid;
  1630		int dev_id = per_pin->dev_id;
  1631		/*
  1632		 * Always execute a GetPinSense verb here, even when called from
  1633		 * hdmi_intrinsic_event; for some NVIDIA HW, the unsolicited
  1634		 * response's PD bit is not the real PD value, but indicates that
  1635		 * the real PD value changed. An older version of the HD-audio
  1636		 * specification worked this way. Hence, we just ignore the data in
  1637		 * the unsolicited response to avoid custom WARs.
  1638		 */
  1639		int present;
  1640		int ret;
  1641	
  1642		ret = snd_hda_power_up_pm(codec);
  1643		if ((ret < 0 && pm_runtime_suspended(dev)) ||
> 1644			(dev->power.runtime_status == RPM_SUSPENDING))
  1645			goto out;
  1646	
  1647		present = snd_hda_jack_pin_sense(codec, pin_nid, dev_id);
  1648	
  1649		mutex_lock(&per_pin->lock);
  1650		eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
  1651		if (eld->monitor_present)
  1652			eld->eld_valid  = !!(present & AC_PINSENSE_ELDV);
  1653		else
  1654			eld->eld_valid = false;
  1655	
  1656		codec_dbg(codec,
  1657			"HDMI status: Codec=%d NID=0x%x Presence_Detect=%d ELD_Valid=%d\n",
  1658			codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
  1659	
  1660		if (eld->eld_valid) {
  1661			if (spec->ops.pin_get_eld(codec, pin_nid, dev_id,
  1662						  eld->eld_buffer, &eld->eld_size) < 0)
  1663				eld->eld_valid = false;
  1664		}
  1665	
  1666		update_eld(codec, per_pin, eld, repoll);
  1667		mutex_unlock(&per_pin->lock);
  1668	 out:
  1669		snd_hda_power_down_pm(codec);
  1670	}
  1671	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

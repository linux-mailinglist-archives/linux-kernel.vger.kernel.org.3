Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B4849CBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241820AbiAZN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:57:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:45170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235439AbiAZN55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643205477; x=1674741477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B9Wd84+wtnB3qCQua42Ru0uJlSQfa3tACh6ixUNsxtI=;
  b=leFchIFLQIVCeNm20zxCbRO0JMFyWhJaIkaj21HNhhz6CLiRsUErFraD
   SVoyoEHiiTVpO0BqYuVdtbIm3jalWITnpW0a07tNpJ3qH4HaOxE8IUjcL
   SznpMtKJ3MfNeN+9nHQCadKW0GaEJgcHhEKe/VSHcIIGf6JDwranoNuCw
   lKhbTEo+LT70pxHxBy/ETDdENRrrzSQ2jXKuU2F1/sno0c50xQr2qVB2g
   S5TeY0R9mutM11xJGTiVV+mWu4kI3dE9VG/KTBZrtBwwqRvQFE2P29bdS
   kVxms0f7e0f27GW2REH30RVEBDLapmyfvpKQaFuDpaBE3gK4wMMeFqzYG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309866252"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="309866252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:57:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="520802981"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2022 05:57:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCio7-000LGd-7K; Wed, 26 Jan 2022 13:57:55 +0000
Date:   Wed, 26 Jan 2022 21:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:broonie/sound/for-linus 179/181]
 sound/soc/soc-ops.c:324 snd_soc_put_volsw() warn: unsigned 'val' is never
 less than zero.
Message-ID: <202201262114.DuFfpPvs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-linus
head:   4cf28e9ae6e2e11a044be1bcbcfa1b0d8675fe4d
commit: 817f7c9335ec01e0f5e8caffc4f1dcd5e458a4c0 [179/181] ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()
config: openrisc-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220126/202201262114.DuFfpPvs-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
sound/soc/soc-ops.c:324 snd_soc_put_volsw() warn: unsigned 'val' is never less than zero.
sound/soc/soc-ops.c:337 snd_soc_put_volsw() warn: unsigned 'val2' is never less than zero.

vim +/val +324 sound/soc/soc-ops.c

   285	
   286	/**
   287	 * snd_soc_put_volsw - single mixer put callback
   288	 * @kcontrol: mixer control
   289	 * @ucontrol: control element information
   290	 *
   291	 * Callback to set the value of a single mixer control, or a double mixer
   292	 * control that spans 2 registers.
   293	 *
   294	 * Returns 0 for success.
   295	 */
   296	int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
   297		struct snd_ctl_elem_value *ucontrol)
   298	{
   299		struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
   300		struct soc_mixer_control *mc =
   301			(struct soc_mixer_control *)kcontrol->private_value;
   302		unsigned int reg = mc->reg;
   303		unsigned int reg2 = mc->rreg;
   304		unsigned int shift = mc->shift;
   305		unsigned int rshift = mc->rshift;
   306		int max = mc->max;
   307		int min = mc->min;
   308		unsigned int sign_bit = mc->sign_bit;
   309		unsigned int mask = (1 << fls(max)) - 1;
   310		unsigned int invert = mc->invert;
   311		int err;
   312		bool type_2r = false;
   313		unsigned int val2 = 0;
   314		unsigned int val, val_mask;
   315	
   316		if (sign_bit)
   317			mask = BIT(sign_bit + 1) - 1;
   318	
   319		val = ucontrol->value.integer.value[0];
   320		if (mc->platform_max && val > mc->platform_max)
   321			return -EINVAL;
   322		if (val > max - min)
   323			return -EINVAL;
 > 324		if (val < 0)
   325			return -EINVAL;
   326		val = (val + min) & mask;
   327		if (invert)
   328			val = max - val;
   329		val_mask = mask << shift;
   330		val = val << shift;
   331		if (snd_soc_volsw_is_stereo(mc)) {
   332			val2 = ucontrol->value.integer.value[1];
   333			if (mc->platform_max && val2 > mc->platform_max)
   334				return -EINVAL;
   335			if (val2 > max - min)
   336				return -EINVAL;
 > 337			if (val2 < 0)
   338				return -EINVAL;
   339			val2 = (val2 + min) & mask;
   340			if (invert)
   341				val2 = max - val2;
   342			if (reg == reg2) {
   343				val_mask |= mask << rshift;
   344				val |= val2 << rshift;
   345			} else {
   346				val2 = val2 << shift;
   347				type_2r = true;
   348			}
   349		}
   350		err = snd_soc_component_update_bits(component, reg, val_mask, val);
   351		if (err < 0)
   352			return err;
   353	
   354		if (type_2r)
   355			err = snd_soc_component_update_bits(component, reg2, val_mask,
   356				val2);
   357	
   358		return err;
   359	}
   360	EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
   361	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

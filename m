Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B249D1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiAZScO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:32:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:50041 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbiAZScM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643221932; x=1674757932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yoWFEhmoyCoPBMrIzE6GTw1UkY7MQHpJHH53vqEvjVg=;
  b=hyORT3yJm86gZdS+jZdV26fghIcVkJ4gxbRWVYxiuC4X77NgLN1YH/yd
   dJ114OhIi/bq6O+ux5U/obndUyjrAx+RtgESDs/JWVC9NwPvy8Z5maC84
   8rYWqFROf2NP9GTZRaUPFyjzfvoRt0Dm9Pn6PsbS4wtHfzMvr5ukhEEH4
   D3c5ACj88vg6Cu2v/Pwkyvr/CA2HMGUikdX0z9pcsBKlAYzi5tZ4ZZ8rJ
   DTXBC0hG9m80tdfSHq8R98wcVfOC0X1eGexdwcjgqtfbCR6N9SsuSIvgk
   nmTsDKYkXJCJaf5o1QtpQKnKe+MG9guf8KLZxqwo0RjWfwvWQog9Occjd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332972414"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="332972414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="696327795"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 10:32:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCn5V-000LVy-DA; Wed, 26 Jan 2022 18:32:09 +0000
Date:   Thu, 27 Jan 2022 02:31:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:broonie/sound/for-5.17 180/185]
 sound/soc/soc-ops.c:431 snd_soc_put_volsw_sx() warn: unsigned 'val' is never
 less than zero.
Message-ID: <202201270218.r8eL9ziw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-5.17
head:   8f2e5c65ec7534cce6d315fccf2c3aef023f68f0
commit: 4f1e50d6a9cf9c1b8c859d449b5031cacfa8404e [180/185] ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()
config: openrisc-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220127/202201270218.r8eL9ziw-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
sound/soc/soc-ops.c:431 snd_soc_put_volsw_sx() warn: unsigned 'val' is never less than zero.

Old smatch warnings:
sound/soc/soc-ops.c:324 snd_soc_put_volsw() warn: unsigned 'val' is never less than zero.
sound/soc/soc-ops.c:337 snd_soc_put_volsw() warn: unsigned 'val2' is never less than zero.

vim +/val +431 sound/soc/soc-ops.c

   399	
   400	/**
   401	 * snd_soc_put_volsw_sx - double mixer set callback
   402	 * @kcontrol: mixer control
   403	 * @ucontrol: control element information
   404	 *
   405	 * Callback to set the value of a double mixer control that spans 2 registers.
   406	 *
   407	 * Returns 0 for success.
   408	 */
   409	int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
   410				 struct snd_ctl_elem_value *ucontrol)
   411	{
   412		struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
   413		struct soc_mixer_control *mc =
   414		    (struct soc_mixer_control *)kcontrol->private_value;
   415	
   416		unsigned int reg = mc->reg;
   417		unsigned int reg2 = mc->rreg;
   418		unsigned int shift = mc->shift;
   419		unsigned int rshift = mc->rshift;
   420		int max = mc->max;
   421		int min = mc->min;
   422		unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
   423		int err = 0;
   424		unsigned int val, val_mask;
   425	
   426		val = ucontrol->value.integer.value[0];
   427		if (mc->platform_max && val > mc->platform_max)
   428			return -EINVAL;
   429		if (val > max - min)
   430			return -EINVAL;
 > 431		if (val < 0)
   432			return -EINVAL;
   433		val_mask = mask << shift;
   434		val = (val + min) & mask;
   435		val = val << shift;
   436	
   437		err = snd_soc_component_update_bits(component, reg, val_mask, val);
   438		if (err < 0)
   439			return err;
   440	
   441		if (snd_soc_volsw_is_stereo(mc)) {
   442			unsigned int val2;
   443	
   444			val_mask = mask << rshift;
   445			val2 = (ucontrol->value.integer.value[1] + min) & mask;
   446			val2 = val2 << rshift;
   447	
   448			err = snd_soc_component_update_bits(component, reg2, val_mask,
   449				val2);
   450		}
   451		return err;
   452	}
   453	EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
   454	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

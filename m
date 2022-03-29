Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383934EA6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiC2Elq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiC2Ell (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:41:41 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263BE76E38
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648528799; x=1680064799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZRc+KCsVdGPHeALwU+iymZbYFCxRAtALxQwt4Jpb0A=;
  b=FoKReBbt3RAhTUNu8KOI+fu8aO0XKl9hj0+5msW2Wh8BuI9FXmCrE3Fk
   PCGqsdAjLDhU9Vs9mYmau/yne38Gn0waZE/hTuA7OHaanaaHbhb9Jt+Fh
   DvFXkSLXaaz1qtvTHsrxzqucb4Lm/yAPwBURAGFG6ZK34z9h5iL7MYRJg
   RxTt5qxbL/KcMtXIhe5/IADkB7aDVJcjb2EFYMPvIwhx2BgtXu6P6di5B
   VysjPaBQ3EUrnz2i45pGUldRNthrIDr+FPMYB0xTS7ikyYXXY86UYkAFP
   YkB1In5VK0BPwk+ZsQs+ev63F3WKTJ0uYj1xL77EXK0g44+p/8BApNu5O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319859010"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="319859010"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 21:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="604523866"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Mar 2022 21:39:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ3e6-0002eK-Ge; Tue, 29 Mar 2022 04:39:54 +0000
Date:   Tue, 29 Mar 2022 12:39:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, tiwai@suse.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix audio regression on Mi Notebook
 Pro 2020
Message-ID: <202203291202.DT2WLVoc-lkp@intel.com>
References: <20220329001845.776776-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329001845.776776-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on v5.17 next-20220329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kai-Heng-Feng/ALSA-hda-realtek-Fix-audio-regression-on-Mi-Notebook-Pro-2020/20220329-082021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: arm64-randconfig-r036-20220327 (https://download.01.org/0day-ci/archive/20220329/202203291202.DT2WLVoc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/b86b7ea348ec9ba6c3824d7a0066968ec4fa0ce5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kai-Heng-Feng/ALSA-hda-realtek-Fix-audio-regression-on-Mi-Notebook-Pro-2020/20220329-082021
        git checkout b86b7ea348ec9ba6c3824d7a0066968ec4fa0ce5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/pci/hda/patch_realtek.c:3620:42: warning: overlapping comparisons always evaluate to true [-Wtautological-overlap-compare]
           if (codec->core.vendor_id != 0x10ec0236 ||
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
   1 warning generated.


vim +3620 sound/pci/hda/patch_realtek.c

  3594	
  3595	static void alc256_shutup(struct hda_codec *codec)
  3596	{
  3597		struct alc_spec *spec = codec->spec;
  3598		hda_nid_t hp_pin = alc_get_hp_pin(spec);
  3599		bool hp_pin_sense;
  3600	
  3601		if (!hp_pin)
  3602			hp_pin = 0x21;
  3603	
  3604		hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
  3605	
  3606		if (hp_pin_sense)
  3607			msleep(2);
  3608	
  3609		snd_hda_codec_write(codec, hp_pin, 0,
  3610				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
  3611	
  3612		if (hp_pin_sense || spec->ultra_low_power)
  3613			msleep(85);
  3614	
  3615		/* 3k pull low control for Headset jack. */
  3616		/* NOTE: call this before clearing the pin, otherwise codec stalls */
  3617		/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
  3618		 * when booting with headset plugged. So skip setting it for the codec alc257
  3619		 */
> 3620		if (codec->core.vendor_id != 0x10ec0236 ||
  3621		    codec->core.vendor_id != 0x10ec0257)
  3622			alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
  3623	
  3624		if (!spec->no_shutup_pins)
  3625			snd_hda_codec_write(codec, hp_pin, 0,
  3626					    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
  3627	
  3628		if (hp_pin_sense || spec->ultra_low_power)
  3629			msleep(100);
  3630	
  3631		alc_auto_setup_eapd(codec, false);
  3632		alc_shutup_pins(codec);
  3633		if (spec->ultra_low_power) {
  3634			msleep(50);
  3635			alc_update_coef_idx(codec, 0x03, 1<<1, 0);
  3636			alc_update_coef_idx(codec, 0x08, 7<<4, 7<<4);
  3637			alc_update_coef_idx(codec, 0x08, 3<<2, 0);
  3638			alc_update_coef_idx(codec, 0x3b, 1<<15, 1<<15);
  3639			alc_update_coef_idx(codec, 0x0e, 7<<6, 0);
  3640			msleep(30);
  3641		}
  3642	}
  3643	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

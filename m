Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2455407A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiFVCWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFVCW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:22:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430833A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655864548; x=1687400548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hgLT3oRHawdLqKpmYv8HkTRv5KUBCJZSRS2FwpeWMPE=;
  b=R38F0U3sJfHoCjF/5D06J8hmRhNV7In06jTemtSmN3kfWFmDCcKXf+tg
   9lGQM91xyH7XTm7P4ltXVMY/aAQ4EAifAaYO9XPhd38jJi6ASsPaLrx/R
   zjL3OOqB++4z9YAHflydjyFpU2LAcL2pl961wi4R929F+2sxKmGMM13vJ
   AOPvze06ZI9EPasvmCBcLkVjH8UhKlqxe1FPEusb05nZvivV4TTpqKkYk
   72ThzomKQm56qZ9f7AF4xB6V47muk2CcCZG174/626okv8QzepSPPEu0C
   4A5DCv6NtwolfrdOgZ4ZNVrNBOD3EpFEzYIrW47b9HcpK/GuX0cyyDF+1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260112605"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="260112605"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 19:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="620716476"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2022 19:22:25 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3q0e-0000iY-If;
        Wed, 22 Jun 2022 02:22:24 +0000
Date:   Wed, 22 Jun 2022 10:22:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Vitaly Rodionov <vitaly.rodionov@cirrus.com>
Subject: Re: [PATCH v6 04/14] ALSA: hda: cs35l41: Add initial DSP support and
 firmware loading
Message-ID: <202206221009.dFR3qUz0-lkp@intel.com>
References: <20220621213801.2021097-5-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621213801.2021097-5-vitalyr@opensource.cirrus.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on linus/master v5.19-rc3 next-20220621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitaly-Rodionov/ALSA-hda-cirrus-Add-initial-DSP-support-and-firmware-loading/20220622-054218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220622/202206221009.dFR3qUz0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9a9e48e89004a7f0c7f21aae4dc45d34469cc789
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vitaly-Rodionov/ALSA-hda-cirrus-Add-initial-DSP-support-and-firmware-loading/20220622-054218
        git checkout 9a9e48e89004a7f0c7f21aae4dc45d34469cc789
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from include/sound/soc.h:14,
                    from sound/pci/hda/hda_cs_dsp_ctl.c:10:
   sound/pci/hda/hda_cs_dsp_ctl.c: In function 'hda_cs_dsp_add_kcontrol':
>> sound/pci/hda/hda_cs_dsp_ctl.c:101:43: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     101 |                 dev_err(cs_ctl->dsp->dev, "Control %s: length %lu exceeds maximum %d\n", ctl->name,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/pci/hda/hda_cs_dsp_ctl.c:101:17: note: in expansion of macro 'dev_err'
     101 |                 dev_err(cs_ctl->dsp->dev, "Control %s: length %lu exceeds maximum %d\n", ctl->name,
         |                 ^~~~~~~
   sound/pci/hda/hda_cs_dsp_ctl.c:101:65: note: format string is defined here
     101 |                 dev_err(cs_ctl->dsp->dev, "Control %s: length %lu exceeds maximum %d\n", ctl->name,
         |                                                               ~~^
         |                                                                 |
         |                                                                 long unsigned int
         |                                                               %u


vim +101 sound/pci/hda/hda_cs_dsp_ctl.c

5c0e0c1e30c723 Stefan Binding 2022-06-21   92  
5c0e0c1e30c723 Stefan Binding 2022-06-21   93  static int hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl)
5c0e0c1e30c723 Stefan Binding 2022-06-21   94  {
5c0e0c1e30c723 Stefan Binding 2022-06-21   95  	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
5c0e0c1e30c723 Stefan Binding 2022-06-21   96  	struct snd_kcontrol_new *kcontrol;
5c0e0c1e30c723 Stefan Binding 2022-06-21   97  	struct snd_kcontrol *kctl;
5c0e0c1e30c723 Stefan Binding 2022-06-21   98  	int ret = 0;
5c0e0c1e30c723 Stefan Binding 2022-06-21   99  
5c0e0c1e30c723 Stefan Binding 2022-06-21  100  	if (cs_ctl->len > ADSP_MAX_STD_CTRL_SIZE) {
5c0e0c1e30c723 Stefan Binding 2022-06-21 @101  		dev_err(cs_ctl->dsp->dev, "Control %s: length %lu exceeds maximum %d\n", ctl->name,
5c0e0c1e30c723 Stefan Binding 2022-06-21  102  			cs_ctl->len, ADSP_MAX_STD_CTRL_SIZE);
5c0e0c1e30c723 Stefan Binding 2022-06-21  103  		return -EINVAL;
5c0e0c1e30c723 Stefan Binding 2022-06-21  104  	}
5c0e0c1e30c723 Stefan Binding 2022-06-21  105  
5c0e0c1e30c723 Stefan Binding 2022-06-21  106  	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
5c0e0c1e30c723 Stefan Binding 2022-06-21  107  	if (!kcontrol)
5c0e0c1e30c723 Stefan Binding 2022-06-21  108  		return -ENOMEM;
5c0e0c1e30c723 Stefan Binding 2022-06-21  109  
5c0e0c1e30c723 Stefan Binding 2022-06-21  110  	kcontrol->name = ctl->name;
5c0e0c1e30c723 Stefan Binding 2022-06-21  111  	kcontrol->info = hda_cs_dsp_coeff_info;
5c0e0c1e30c723 Stefan Binding 2022-06-21  112  	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
5c0e0c1e30c723 Stefan Binding 2022-06-21  113  	kcontrol->private_value = (unsigned long)ctl;
5c0e0c1e30c723 Stefan Binding 2022-06-21  114  	kcontrol->access = wmfw_convert_flags(cs_ctl->flags);
5c0e0c1e30c723 Stefan Binding 2022-06-21  115  
5c0e0c1e30c723 Stefan Binding 2022-06-21  116  	kcontrol->get = hda_cs_dsp_coeff_get;
5c0e0c1e30c723 Stefan Binding 2022-06-21  117  	kcontrol->put = hda_cs_dsp_coeff_put;
5c0e0c1e30c723 Stefan Binding 2022-06-21  118  
5c0e0c1e30c723 Stefan Binding 2022-06-21  119  	kctl = snd_ctl_new1(kcontrol, NULL);
5c0e0c1e30c723 Stefan Binding 2022-06-21  120  	if (!kctl) {
5c0e0c1e30c723 Stefan Binding 2022-06-21  121  		ret = -ENOMEM;
5c0e0c1e30c723 Stefan Binding 2022-06-21  122  		goto err;
5c0e0c1e30c723 Stefan Binding 2022-06-21  123  	}
5c0e0c1e30c723 Stefan Binding 2022-06-21  124  	ctl->kctl = kctl;
5c0e0c1e30c723 Stefan Binding 2022-06-21  125  
5c0e0c1e30c723 Stefan Binding 2022-06-21  126  	ret = snd_ctl_add(ctl->card, kctl);
5c0e0c1e30c723 Stefan Binding 2022-06-21  127  	if (ret)
5c0e0c1e30c723 Stefan Binding 2022-06-21  128  		dev_err(cs_ctl->dsp->dev, "Failed to add KControl: %s - Ret: %d\n", kcontrol->name,
5c0e0c1e30c723 Stefan Binding 2022-06-21  129  			ret);
5c0e0c1e30c723 Stefan Binding 2022-06-21  130  	else
5c0e0c1e30c723 Stefan Binding 2022-06-21  131  		dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol->name);
5c0e0c1e30c723 Stefan Binding 2022-06-21  132  
5c0e0c1e30c723 Stefan Binding 2022-06-21  133  err:
5c0e0c1e30c723 Stefan Binding 2022-06-21  134  	kfree(kcontrol);
5c0e0c1e30c723 Stefan Binding 2022-06-21  135  
5c0e0c1e30c723 Stefan Binding 2022-06-21  136  	return ret;
5c0e0c1e30c723 Stefan Binding 2022-06-21  137  }
5c0e0c1e30c723 Stefan Binding 2022-06-21  138  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

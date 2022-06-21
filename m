Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625AF5528CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiFUAw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiFUAwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:52:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D41AF39
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655772744; x=1687308744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lKdhkZXkI4k6wa8+uQOzhJu5OvBIf64/xrTaRZ2FKzI=;
  b=AP+GUfSNXkMLoapwv+X8JYHN3OOsenpAcTNncYTKFtgcGurlMsb3fGI4
   jT2ui9fJ9uv/pxjt44/2/Ru2qd0xEGXXuJidGlBb3tTG7NNyVX2xJG/Qm
   8jsv1rgZZfb5gu0lyEw6JmriVVd2+oz+Yo9daJqgExWlAn0PplLs5tqEl
   /f7n6wIHiqh19bwaHSli9VfNacMPnnHKovbIs1QKhcaxi2AqqA5X9zz0z
   LHFl6Y9M1Vv8TL8PWcDfmWWfAIGkRZimj2YjIzwrp2i+yxkOhIJVcRyRV
   2cApuqZWneHa2eM591R5dUg5Kedr8TX7wAD3/4E2pnudoWlCWNBqZjFlq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="277544988"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="277544988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 17:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="562150223"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2022 17:52:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3S7x-000XZb-3D;
        Tue, 21 Jun 2022 00:52:21 +0000
Date:   Tue, 21 Jun 2022 08:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Vitaly Rodionov <vitaly.rodionov@cirrus.com>
Subject: Re: [PATCH v5 04/14] ALSA: hda: cs35l41: Add initial DSP support and
 firmware loading
Message-ID: <202206210829.FlHFxgAO-lkp@intel.com>
References: <20220620205432.3809-5-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620205432.3809-5-vitalyr@opensource.cirrus.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitaly-Rodionov/ALSA-hda-cirrus-Add-initial-DSP-support-and-firmware-loading/20220621-045835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220621/202206210829.FlHFxgAO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/90a2fe69cdb8e417d88f54f2dc4f57e06041c112
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vitaly-Rodionov/ALSA-hda-cirrus-Add-initial-DSP-support-and-firmware-loading/20220621-045835
        git checkout 90a2fe69cdb8e417d88f54f2dc4f57e06041c112
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
>> sound/pci/hda/hda_cs_dsp_ctl.c:101:43: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     101 |                 dev_err(cs_ctl->dsp->dev, "Control %s: length %ld exceeds maximum %d\n", ctl->name,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/pci/hda/hda_cs_dsp_ctl.c:101:17: note: in expansion of macro 'dev_err'
     101 |                 dev_err(cs_ctl->dsp->dev, "Control %s: length %ld exceeds maximum %d\n", ctl->name,
         |                 ^~~~~~~
   sound/pci/hda/hda_cs_dsp_ctl.c:101:65: note: format string is defined here
     101 |                 dev_err(cs_ctl->dsp->dev, "Control %s: length %ld exceeds maximum %d\n", ctl->name,
         |                                                               ~~^
         |                                                                 |
         |                                                                 long int
         |                                                               %d


vim +101 sound/pci/hda/hda_cs_dsp_ctl.c

03621b0e3c3696 Stefan Binding 2022-06-20   92  
03621b0e3c3696 Stefan Binding 2022-06-20   93  static int hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl)
03621b0e3c3696 Stefan Binding 2022-06-20   94  {
03621b0e3c3696 Stefan Binding 2022-06-20   95  	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
03621b0e3c3696 Stefan Binding 2022-06-20   96  	struct snd_kcontrol_new *kcontrol;
03621b0e3c3696 Stefan Binding 2022-06-20   97  	struct snd_kcontrol *kctl;
03621b0e3c3696 Stefan Binding 2022-06-20   98  	int ret = 0;
03621b0e3c3696 Stefan Binding 2022-06-20   99  
03621b0e3c3696 Stefan Binding 2022-06-20  100  	if (cs_ctl->len > ADSP_MAX_STD_CTRL_SIZE) {
03621b0e3c3696 Stefan Binding 2022-06-20 @101  		dev_err(cs_ctl->dsp->dev, "Control %s: length %ld exceeds maximum %d\n", ctl->name,
03621b0e3c3696 Stefan Binding 2022-06-20  102  			cs_ctl->len, ADSP_MAX_STD_CTRL_SIZE);
03621b0e3c3696 Stefan Binding 2022-06-20  103  		return -EINVAL;
03621b0e3c3696 Stefan Binding 2022-06-20  104  	}
03621b0e3c3696 Stefan Binding 2022-06-20  105  
03621b0e3c3696 Stefan Binding 2022-06-20  106  	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
03621b0e3c3696 Stefan Binding 2022-06-20  107  	if (!kcontrol)
03621b0e3c3696 Stefan Binding 2022-06-20  108  		return -ENOMEM;
03621b0e3c3696 Stefan Binding 2022-06-20  109  
03621b0e3c3696 Stefan Binding 2022-06-20  110  	kcontrol->name = ctl->name;
03621b0e3c3696 Stefan Binding 2022-06-20  111  	kcontrol->info = hda_cs_dsp_coeff_info;
03621b0e3c3696 Stefan Binding 2022-06-20  112  	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
03621b0e3c3696 Stefan Binding 2022-06-20  113  	kcontrol->private_value = (unsigned long)ctl;
03621b0e3c3696 Stefan Binding 2022-06-20  114  	kcontrol->access = wmfw_convert_flags(cs_ctl->flags);
03621b0e3c3696 Stefan Binding 2022-06-20  115  
03621b0e3c3696 Stefan Binding 2022-06-20  116  	kcontrol->get = hda_cs_dsp_coeff_get;
03621b0e3c3696 Stefan Binding 2022-06-20  117  	kcontrol->put = hda_cs_dsp_coeff_put;
03621b0e3c3696 Stefan Binding 2022-06-20  118  
03621b0e3c3696 Stefan Binding 2022-06-20  119  	kctl = snd_ctl_new1(kcontrol, NULL);
03621b0e3c3696 Stefan Binding 2022-06-20  120  	if (!kctl) {
03621b0e3c3696 Stefan Binding 2022-06-20  121  		ret = -ENOMEM;
03621b0e3c3696 Stefan Binding 2022-06-20  122  		goto err;
03621b0e3c3696 Stefan Binding 2022-06-20  123  	}
03621b0e3c3696 Stefan Binding 2022-06-20  124  	ctl->kctl = kctl;
03621b0e3c3696 Stefan Binding 2022-06-20  125  
03621b0e3c3696 Stefan Binding 2022-06-20  126  	ret = snd_ctl_add(ctl->card, kctl);
03621b0e3c3696 Stefan Binding 2022-06-20  127  	if (ret)
03621b0e3c3696 Stefan Binding 2022-06-20  128  		dev_err(cs_ctl->dsp->dev, "Failed to add KControl: %s - Ret: %d\n", kcontrol->name,
03621b0e3c3696 Stefan Binding 2022-06-20  129  			ret);
03621b0e3c3696 Stefan Binding 2022-06-20  130  	else
03621b0e3c3696 Stefan Binding 2022-06-20  131  		dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol->name);
03621b0e3c3696 Stefan Binding 2022-06-20  132  
03621b0e3c3696 Stefan Binding 2022-06-20  133  err:
03621b0e3c3696 Stefan Binding 2022-06-20  134  	kfree(kcontrol);
03621b0e3c3696 Stefan Binding 2022-06-20  135  
03621b0e3c3696 Stefan Binding 2022-06-20  136  	return ret;
03621b0e3c3696 Stefan Binding 2022-06-20  137  }
03621b0e3c3696 Stefan Binding 2022-06-20  138  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

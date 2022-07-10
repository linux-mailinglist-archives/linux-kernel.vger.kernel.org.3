Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA37E56CDA6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGJHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJHkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 03:40:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE28BF74
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657438804; x=1688974804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i84PBKD4yiPMiyyXZv0Hnq0/GpchZGp48SXiptHJK+w=;
  b=LJDMuh3XAFONtZ6s1jCD8ED5lU418x8U8Q5RQ76L6j4ow7r3LbwLZqJI
   BwUx8GGRlZUUSO43fNkvRmQMAHxkLnJlsmljUUjUOo4WORfH0XSlaXnPy
   dV44FVL/OB6wMQ3QQ8nMBVyvnc3fCudGZt8wvfc+wOPGEBTyhiCApzOPJ
   e3ghYyRd0gIpEbGW5b7rlHR+vm/6WnS+l7EsjjkR4q9NUrIhkqwsS9Ih9
   kZcaQAGpNe0IQ362Lrdkakp++/7TCPyw4kmP5mdq4YYZvvnSWCNJBqj1v
   Nt4SlKVNRgGV1OQzb96zXXJcRzjNyxDWXWljpJxebZjEDr2I2lBtA+S6w
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285616706"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="285616706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 00:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="736770281"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2022 00:40:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oARXt-000PZo-LI;
        Sun, 10 Jul 2022 07:40:01 +0000
Date:   Sun, 10 Jul 2022 15:39:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhongjun Tan <hbut_tan@163.com>, perex@perex.cz, tiwai@suse.com
Cc:     kbuild-all@lists.01.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Zhongjun Tan <tanzhongjun@coolpad.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix unsigned expression compared with
 zero
Message-ID: <202207101502.ZdivUZX6-lkp@intel.com>
References: <20220706070627.16764-1-hbut_tan@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706070627.16764-1-hbut_tan@163.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhongjun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on linus/master v5.19-rc5 next-20220708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhongjun-Tan/ALSA-usb-audio-Fix-unsigned-expression-compared-with-zero/20220706-150825
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: s390-randconfig-s031-20220710 (https://download.01.org/0day-ci/archive/20220710/202207101502.ZdivUZX6-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/10d09dc3ad3a9b823d9097a68058698be90c7a74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhongjun-Tan/ALSA-usb-audio-Fix-unsigned-expression-compared-with-zero/20220706-150825
        git checkout 10d09dc3ad3a9b823d9097a68058698be90c7a74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash sound/usb/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/usb/pcm.c:782:32: sparse: sparse: incompatible types in comparison expression (different signedness):
>> sound/usb/pcm.c:782:32: sparse:    unsigned int *
>> sound/usb/pcm.c:782:32: sparse:    int *
   sound/usb/pcm.c:783:32: sparse: sparse: incompatible types in comparison expression (different signedness):
   sound/usb/pcm.c:783:32: sparse:    unsigned int *
   sound/usb/pcm.c:783:32: sparse:    int *
   sound/usb/pcm.c:791:40: sparse: sparse: incompatible types in comparison expression (different signedness):
   sound/usb/pcm.c:791:40: sparse:    unsigned int *
   sound/usb/pcm.c:791:40: sparse:    int *
   sound/usb/pcm.c:792:40: sparse: sparse: incompatible types in comparison expression (different signedness):
   sound/usb/pcm.c:792:40: sparse:    unsigned int *
   sound/usb/pcm.c:792:40: sparse:    int *

vim +782 sound/usb/pcm.c

7726dce14c5e7e Takashi Iwai 2020-11-23  761  
e5779998bf8b70 Daniel Mack  2010-03-04  762  static int hw_rule_rate(struct snd_pcm_hw_params *params,
e5779998bf8b70 Daniel Mack  2010-03-04  763  			struct snd_pcm_hw_rule *rule)
e5779998bf8b70 Daniel Mack  2010-03-04  764  {
e5779998bf8b70 Daniel Mack  2010-03-04  765  	struct snd_usb_substream *subs = rule->private;
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  766  	struct snd_usb_audio *chip = subs->stream->chip;
cab941b7e5cf05 Takashi Iwai 2020-11-23  767  	const struct audioformat *fp;
e5779998bf8b70 Daniel Mack  2010-03-04  768  	struct snd_interval *it = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
10d09dc3ad3a9b Zhongjun Tan 2022-07-06  769  	unsigned int rmin, rmax;
10d09dc3ad3a9b Zhongjun Tan 2022-07-06  770  	int i, r;
e5779998bf8b70 Daniel Mack  2010-03-04  771  
e5779998bf8b70 Daniel Mack  2010-03-04  772  	hwc_debug("hw_rule_rate: (%d,%d)\n", it->min, it->max);
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  773  	rmin = UINT_MAX;
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  774  	rmax = 0;
88766f04c4142c Eldad Zack   2013-04-03  775  	list_for_each_entry(fp, &subs->fmt_list, list) {
e5779998bf8b70 Daniel Mack  2010-03-04  776  		if (!hw_check_valid_format(subs, params, fp))
e5779998bf8b70 Daniel Mack  2010-03-04  777  			continue;
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  778  		r = snd_usb_endpoint_get_clock_rate(chip, fp->clock);
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  779  		if (r > 0) {
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  780  			if (!snd_interval_test(it, r))
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  781  				continue;
4e7cf1fbb34ecb Takashi Iwai 2021-09-29 @782  			rmin = min(rmin, r);
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  783  			rmax = max(rmax, r);
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  784  			continue;
4e7cf1fbb34ecb Takashi Iwai 2021-09-29  785  		}
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  786  		if (fp->rate_table && fp->nr_rates) {
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  787  			for (i = 0; i < fp->nr_rates; i++) {
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  788  				r = fp->rate_table[i];
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  789  				if (!snd_interval_test(it, r))
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  790  					continue;
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  791  				rmin = min(rmin, r);
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  792  				rmax = max(rmax, r);
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  793  			}
e5779998bf8b70 Daniel Mack  2010-03-04  794  		} else {
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  795  			rmin = min(rmin, fp->rate_min);
bc4e94aa8e72e7 Takashi Iwai 2020-11-23  796  			rmax = max(rmax, fp->rate_max);
e5779998bf8b70 Daniel Mack  2010-03-04  797  		}
e5779998bf8b70 Daniel Mack  2010-03-04  798  	}
e5779998bf8b70 Daniel Mack  2010-03-04  799  
7726dce14c5e7e Takashi Iwai 2020-11-23  800  	return apply_hw_params_minmax(it, rmin, rmax);
e5779998bf8b70 Daniel Mack  2010-03-04  801  }
e5779998bf8b70 Daniel Mack  2010-03-04  802  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

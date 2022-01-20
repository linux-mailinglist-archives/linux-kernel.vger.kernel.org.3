Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D219E494623
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358363AbiATD2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:28:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:58590 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235637AbiATD2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642649331; x=1674185331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B5/FzjUBtbwFrNLYg6TNbg4+9zrFPepNxQzS9vWuG7I=;
  b=kLSYbKiLexqYLbmgILWeLCyrIvsmS0nTmXztKd54TCfG7TvRTim7NFy2
   8Etpztb+B14hSGlPN6eDbucOYJrnzZFo+oIqes2aQ4QuBbX/8Rx0K3d6q
   FJcLds5jlJOdCDg7zhb1dxtrjDcYnDuRefQP1ONxg6To4xqCMfUHn/yW1
   RfBwvyw7M7pXYcDCFlmgPNSny+8d0q29Pl/XTgMwb+dLQppKOZVVFx1tB
   FmY5Iow4Vyhgh2/ixmMM1liVnWFtvdseB57OjdlUJduz+f4I7jJzuolqa
   XvjyvBSeubqjXlEXT4fNKnQAacM5dRQgw3R+onmaRg6ArwjuC0qo4NeFB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="242822985"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="242822985"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 19:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="532594612"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2022 19:28:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAO7z-000Dxl-Ib; Thu, 20 Jan 2022 03:28:47 +0000
Date:   Thu, 20 Jan 2022 11:28:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     kbuild-all@lists.01.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: usb-audio: scarlett2: Use struct_size()
 helper in scarlett2_usb()
Message-ID: <202201201043.0reWtM98-lkp@intel.com>
References: <20220120001423.GA69878@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120001423.GA69878@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Gustavo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on v5.16 next-20220118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gustavo-A-R-Silva/ALSA-usb-audio-scarlett2-Use-struct_size-helper-in-scarlett2_usb/20220120-080908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220120/202201201043.0reWtM98-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1696152f12c0a7d23ccd5e228f9d08f7bd2da83a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gustavo-A-R-Silva/ALSA-usb-audio-scarlett2-Use-struct_size-helper-in-scarlett2_usb/20220120-080908
        git checkout 1696152f12c0a7d23ccd5e228f9d08f7bd2da83a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash sound/usb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/usb/ch9.h:36,
                    from include/linux/usb.h:6,
                    from sound/usb/mixer_scarlett_gen2.c:126:
   sound/usb/mixer_scarlett_gen2.c: In function 'scarlett2_usb':
>> sound/usb/mixer_scarlett_gen2.c:1113:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1113 |                         "Scarlett Gen 2/3 USB response result cmd %x was %d "
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/usb/usbaudio.h:67:9: note: in expansion of macro 'dev_err'
      67 |         dev_err(&(chip)->dev->dev, fmt, ##args)
         |         ^~~~~~~
   sound/usb/mixer_scarlett_gen2.c:1111:17: note: in expansion of macro 'usb_audio_err'
    1111 |                 usb_audio_err(
         |                 ^~~~~~~~~~~~~


vim +1113 sound/usb/mixer_scarlett_gen2.c

1f7fa6e5afbf20 Geoffrey D. Bennett 2021-06-22  1056  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1057  /* Send a proprietary format request to the Scarlett interface */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1058  static int scarlett2_usb(
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1059  	struct usb_mixer_interface *mixer, u32 cmd,
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1060  	void *req_data, u16 req_size, void *resp_data, u16 resp_size)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1061  {
e46f2195c86b00 Geoffrey D. Bennett 2021-06-21  1062  	struct scarlett2_data *private = mixer->private_data;
1f7fa6e5afbf20 Geoffrey D. Bennett 2021-06-22  1063  	struct usb_device *dev = mixer->chip->dev;
b677b6c6d82248 Geoffrey D. Bennett 2021-06-21  1064  	struct scarlett2_usb_packet *req, *resp = NULL;
1696152f12c0a7 Gustavo A. R. Silva 2022-01-19  1065  	size_t req_buf_size = struct_size(req, data, req_size);
1696152f12c0a7 Gustavo A. R. Silva 2022-01-19  1066  	size_t resp_buf_size = struct_size(resp, data, resp_size);
b677b6c6d82248 Geoffrey D. Bennett 2021-06-21  1067  	int err;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1068  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1069  	req = kmalloc(req_buf_size, GFP_KERNEL);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1070  	if (!req) {
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1071  		err = -ENOMEM;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1072  		goto error;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1073  	}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1074  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1075  	resp = kmalloc(resp_buf_size, GFP_KERNEL);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1076  	if (!resp) {
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1077  		err = -ENOMEM;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1078  		goto error;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1079  	}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1080  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1081  	mutex_lock(&private->usb_mutex);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1082  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1083  	/* build request message and send it */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1084  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1085  	scarlett2_fill_request_header(private, req, cmd, req_size);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1086  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1087  	if (req_size)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1088  		memcpy(req->data, req_data, req_size);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1089  
1f7fa6e5afbf20 Geoffrey D. Bennett 2021-06-22  1090  	err = scarlett2_usb_tx(dev, private->bInterfaceNumber,
1f7fa6e5afbf20 Geoffrey D. Bennett 2021-06-22  1091  			       req, req_buf_size);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1092  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1093  	if (err != req_buf_size) {
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1094  		usb_audio_err(
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1095  			mixer->chip,
4be47798d76e6e Geoffrey D. Bennett 2021-06-23  1096  			"Scarlett Gen 2/3 USB request result cmd %x was %d\n",
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1097  			cmd, err);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1098  		err = -EINVAL;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1099  		goto unlock;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1100  	}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1101  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1102  	/* send a second message to get the response */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1103  
1f7fa6e5afbf20 Geoffrey D. Bennett 2021-06-22  1104  	err = scarlett2_usb_rx(dev, private->bInterfaceNumber,
1f7fa6e5afbf20 Geoffrey D. Bennett 2021-06-22  1105  			       SCARLETT2_USB_CMD_RESP,
1f7fa6e5afbf20 Geoffrey D. Bennett 2021-06-22  1106  			       resp, resp_buf_size);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1107  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1108  	/* validate the response */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1109  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1110  	if (err != resp_buf_size) {
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1111  		usb_audio_err(
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1112  			mixer->chip,
4be47798d76e6e Geoffrey D. Bennett 2021-06-23 @1113  			"Scarlett Gen 2/3 USB response result cmd %x was %d "
1696152f12c0a7 Gustavo A. R. Silva 2022-01-19  1114  			"expected %lu\n",
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22  1115  			cmd, err, resp_buf_size);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1116  		err = -EINVAL;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1117  		goto unlock;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1118  	}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1119  
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22  1120  	/* cmd/seq/size should match except when initialising
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22  1121  	 * seq sent = 1, response = 0
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22  1122  	 */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1123  	if (resp->cmd != req->cmd ||
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22  1124  	    (resp->seq != req->seq &&
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22  1125  		(le16_to_cpu(req->seq) != 1 || resp->seq != 0)) ||
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1126  	    resp_size != le16_to_cpu(resp->size) ||
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1127  	    resp->error ||
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1128  	    resp->pad) {
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1129  		usb_audio_err(
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1130  			mixer->chip,
4be47798d76e6e Geoffrey D. Bennett 2021-06-23  1131  			"Scarlett Gen 2/3 USB invalid response; "
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1132  			   "cmd tx/rx %d/%d seq %d/%d size %d/%d "
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1133  			   "error %d pad %d\n",
d8f489355cff55 Takashi Iwai        2020-02-01  1134  			le32_to_cpu(req->cmd), le32_to_cpu(resp->cmd),
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1135  			le16_to_cpu(req->seq), le16_to_cpu(resp->seq),
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1136  			resp_size, le16_to_cpu(resp->size),
d8f489355cff55 Takashi Iwai        2020-02-01  1137  			le32_to_cpu(resp->error),
d8f489355cff55 Takashi Iwai        2020-02-01  1138  			le32_to_cpu(resp->pad));
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1139  		err = -EINVAL;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1140  		goto unlock;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1141  	}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1142  
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22  1143  	if (resp_data && resp_size > 0)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1144  		memcpy(resp_data, resp->data, resp_size);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1145  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1146  unlock:
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1147  	mutex_unlock(&private->usb_mutex);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1148  error:
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1149  	kfree(req);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1150  	kfree(resp);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1151  	return err;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1152  }
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  1153  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

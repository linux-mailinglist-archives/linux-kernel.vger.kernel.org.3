Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF4E494675
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358491AbiATE35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:29:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:39618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233536AbiATE3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642652995; x=1674188995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zBZPPpHMTgU+TRACFDuOmDezIH1hCkMSxXLYLVKMJZc=;
  b=ZwSKLsnLiJZGCdUGx0w5DMIEU0pepY38cdpfUujAbQYFzW0p5AiJSVvt
   Z3QhV24r9c1tRa5SzqEYzV/1IUwDAOrllIPWDDUi68YtOVrsmky0nRAM/
   Cm2sVZ32YtL68hibcgVZaC0MTITlgS0b55Uj5TtL0OX7JXNptgMV3RB84
   smmmr4sn9eJ0oJ73x2Tj+BpEwXYJL3+J14ot5My4cvYaKLY52B7jvrgP4
   L75t+AJb6gcwie4tcYWwxOBabDk7cV2kNnNfY0nXCCTfQIzCNUs187u1g
   vJb2tXVmVmOYs7M3Q7IimMR24ICCClH+9BsU8gNs4+jopH2K5Tr7ovPkq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="308603722"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="308603722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 20:29:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="475391627"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2022 20:29:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAP52-000E03-L9; Thu, 20 Jan 2022 04:29:48 +0000
Date:   Thu, 20 Jan 2022 12:29:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: usb-audio: scarlett2: Use struct_size()
 helper in scarlett2_usb()
Message-ID: <202201201212.O8wvhLQc-lkp@intel.com>
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
config: i386-randconfig-a003-20220117 (https://download.01.org/0day-ci/archive/20220120/202201201212.O8wvhLQc-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1696152f12c0a7d23ccd5e228f9d08f7bd2da83a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gustavo-A-R-Silva/ALSA-usb-audio-scarlett2-Use-struct_size-helper-in-scarlett2_usb/20220120-080908
        git checkout 1696152f12c0a7d23ccd5e228f9d08f7bd2da83a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/usb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/usb/mixer_scarlett_gen2.c:1115:14: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                           cmd, err, resp_buf_size);
                                     ^~~~~~~~~~~~~
   sound/usb/usbaudio.h:67:36: note: expanded from macro 'usb_audio_err'
           dev_err(&(chip)->dev->dev, fmt, ##args)
                                      ~~~    ^~~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +1115 sound/usb/mixer_scarlett_gen2.c

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
4be47798d76e6e Geoffrey D. Bennett 2021-06-23  1113  			"Scarlett Gen 2/3 USB response result cmd %x was %d "
1696152f12c0a7 Gustavo A. R. Silva 2022-01-19  1114  			"expected %lu\n",
acf91b8122c7f6 Geoffrey D. Bennett 2021-06-22 @1115  			cmd, err, resp_buf_size);
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

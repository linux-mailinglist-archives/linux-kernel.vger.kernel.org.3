Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2246AED6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378102AbhLGAO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:14:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:43421 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376855AbhLGAO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:14:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218125808"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="218125808"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 16:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="542598321"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2021 16:11:24 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muO4p-000Lub-PV; Tue, 07 Dec 2021 00:11:23 +0000
Date:   Tue, 7 Dec 2021 08:10:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hui Wang <hui.wang@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Bard Liao <bard.liao@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [broonie-sound:for-linus 313/320]
 sound/soc/sof/intel/hda-codec.c:132:35: error: 'CODEC_PROBE_RETRIES'
 undeclared
Message-ID: <202112070826.L6twVlKM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus
head:   de2138b0ab8ac888a97868a08c29c2e37f8b71bd
commit: 046aede2f847676f93a2ea4f48b77909c51dba40 [313/320] ASoC: SOF: Intel: Retry codec probing if it fails
config: x86_64-randconfig-r026-20211202 (https://download.01.org/0day-ci/archive/20211207/202112070826.L6twVlKM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=046aede2f847676f93a2ea4f48b77909c51dba40
        git remote add broonie-sound https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
        git fetch --no-tags broonie-sound for-linus
        git checkout 046aede2f847676f93a2ea4f48b77909c51dba40
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/sof/intel/hda-codec.c: In function 'hda_codec_probe':
>> sound/soc/sof/intel/hda-codec.c:132:35: error: 'CODEC_PROBE_RETRIES' undeclared (first use in this function)
     132 |  } while (resp == -1 && retry++ < CODEC_PROBE_RETRIES);
         |                                   ^~~~~~~~~~~~~~~~~~~
   sound/soc/sof/intel/hda-codec.c:132:35: note: each undeclared identifier is reported only once for each function it appears in


vim +/CODEC_PROBE_RETRIES +132 sound/soc/sof/intel/hda-codec.c

   110	
   111	/* probe individual codec */
   112	static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
   113				   bool hda_codec_use_common_hdmi)
   114	{
   115	#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
   116		struct hdac_hda_priv *hda_priv;
   117		struct hda_codec *codec;
   118		int type = HDA_DEV_LEGACY;
   119	#endif
   120		struct hda_bus *hbus = sof_to_hbus(sdev);
   121		struct hdac_device *hdev;
   122		u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
   123			(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
   124		u32 resp = -1;
   125		int ret, retry = 0;
   126	
   127		do {
   128			mutex_lock(&hbus->core.cmd_mutex);
   129			snd_hdac_bus_send_cmd(&hbus->core, hda_cmd);
   130			snd_hdac_bus_get_response(&hbus->core, address, &resp);
   131			mutex_unlock(&hbus->core.cmd_mutex);
 > 132		} while (resp == -1 && retry++ < CODEC_PROBE_RETRIES);
   133	
   134		if (resp == -1)
   135			return -EIO;
   136		dev_dbg(sdev->dev, "HDA codec #%d probed OK: response: %x\n",
   137			address, resp);
   138	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

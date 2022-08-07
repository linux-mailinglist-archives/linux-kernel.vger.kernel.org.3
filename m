Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B958B9F8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiHGHGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiHGHG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 03:06:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C53AE5D
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659855987; x=1691391987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kmX7fCTXVT5lmnL9SnPqcTbya+lTv5yq3tYdStAUAA=;
  b=h/NzcTAVpPwUCDuHJ6Jj6S08hcjT4CqkRz8Rm8SNyXmF/1BZwNy5Q4/C
   jsBGPfakn9A/xQvi2EI6UZjRWDy1E/YcGmpVnbGQ0m/zzB0HIMWZ+kqaC
   l1KMqO6xdhmU3sXa4VtkGYgl46AcxfmEp4PKvdp1iZ+jIaoy7Nyvoqa+I
   Jlc6qtv+7lWgZgc6GWj0UDtyVi4wAdfwql/uXTJsBe/yMqf7szqC4/JET
   hJUeliiNQBC1eCh5jbQDDjdNce1gOQfqhHSfRg1do59JJj+CjkJqSK9lW
   lQHPMafd2nAhWrB21EphkY7XszVBtj2uOnnkXwlt33j8Ss1r3pNFSNO0F
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="289175452"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="289175452"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 00:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="672126302"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 00:06:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKaMh-000L4n-27;
        Sun, 07 Aug 2022 07:06:23 +0000
Date:   Sun, 7 Aug 2022 15:05:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     kbuild-all@lists.01.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: amd: acp: Add TDM support for acp i2s stream
Message-ID: <202208071454.7YeHuTDb-lkp@intel.com>
References: <20220805060420.813053-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805060420.813053-1-venkataprasad.potturu@amd.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkata,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master next-20220805]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Venkata-Prasad-Potturu/ASoC-amd-acp-Add-TDM-support-for-acp-i2s-stream/20220805-140248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220807/202208071454.7YeHuTDb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c603f9570621784501d7ce7f5099be37983cb810
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Venkata-Prasad-Potturu/ASoC-amd-acp-Add-TDM-support-for-acp-i2s-stream/20220805-140248
        git checkout c603f9570621784501d7ce7f5099be37983cb810
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/amd/acp/acp-i2s.c: In function 'acp_i2s_set_tdm_slot':
>> sound/soc/amd/acp/acp-i2s.c:74:29: error: 'struct acp_dev_data' has no member named 'acp_lock'
      74 |         spin_lock_irq(&adata->acp_lock);
         |                             ^~
   In file included from include/linux/kernel.h:21,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/amd/acp/acp-i2s.c:15:
   sound/soc/amd/acp/acp-i2s.c:75:43: error: 'struct acp_dev_data' has no member named 'stream_list'
      75 |         list_for_each_entry(stream, &adata->stream_list, list) {
         |                                           ^~
   include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
      18 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   sound/soc/amd/acp/acp-i2s.c:75:9: note: in expansion of macro 'list_for_each_entry'
      75 |         list_for_each_entry(stream, &adata->stream_list, list) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/amd/acp/acp-i2s.c:15:
   sound/soc/amd/acp/acp-i2s.c:75:43: error: 'struct acp_dev_data' has no member named 'stream_list'
      75 |         list_for_each_entry(stream, &adata->stream_list, list) {
         |                                           ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   sound/soc/amd/acp/acp-i2s.c:75:9: note: in expansion of macro 'list_for_each_entry'
      75 |         list_for_each_entry(stream, &adata->stream_list, list) {
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:54: error: 'struct acp_stream' has no member named 'list'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   sound/soc/amd/acp/acp-i2s.c:75:9: note: in expansion of macro 'list_for_each_entry'
      75 |         list_for_each_entry(stream, &adata->stream_list, list) {
         |         ^~~~~~~~~~~~~~~~~~~
   sound/soc/amd/acp/acp-i2s.c:75:43: error: 'struct acp_dev_data' has no member named 'stream_list'
      75 |         list_for_each_entry(stream, &adata->stream_list, list) {
         |                                           ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'


vim +74 sound/soc/amd/acp/acp-i2s.c

    47	
    48	static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mask,
    49					int slots, int slot_width)
    50	{
    51		struct device *dev = dai->component->dev;
    52		struct acp_dev_data *adata = snd_soc_dai_get_drvdata(dai);
    53		struct acp_stream *stream;
    54		int slot_len;
    55	
    56		switch (slot_width) {
    57		case SLOT_WIDTH_8:
    58			slot_len = 8;
    59			break;
    60		case SLOT_WIDTH_16:
    61			slot_len = 16;
    62			break;
    63		case SLOT_WIDTH_24:
    64			slot_len = 24;
    65			break;
    66		case SLOT_WIDTH_32:
    67			slot_len = 0;
    68			break;
    69		default:
    70			dev_err(dev, "Unsupported bitdepth %d\n", slot_width);
    71			return -EINVAL;
    72		}
    73	
  > 74		spin_lock_irq(&adata->acp_lock);
    75		list_for_each_entry(stream, &adata->stream_list, list) {
    76			if (tx_mask && stream->dir == SNDRV_PCM_STREAM_PLAYBACK)
    77				adata->tdm_tx_fmt[stream->dai_id - 1] =
    78						FRM_LEN | (slots << 15) | (slot_len << 18);
    79			else if (rx_mask && stream->dir == SNDRV_PCM_STREAM_CAPTURE)
    80				adata->tdm_rx_fmt[stream->dai_id - 1] =
    81						FRM_LEN | (slots << 15) | (slot_len << 18);
    82		}
    83		spin_unlock_irq(&adata->acp_lock);
    84		return 0;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

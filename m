Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D394C1CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbiBWT6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244570AbiBWT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:58:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D53153B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645646269; x=1677182269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldrwldCU5gsBt1seEEqjOtl356f4DibFuHjEzUZfiwg=;
  b=gEYEXGvB6x1KIy+gBgwyU+V1IeMUeBwMHo6wRHt8y6EvhZnlwFErqb2t
   RZhbHAEhgyE8l97RFNNTziFdN045Q2bx/7ZRgCL0WAT+guWN334zd33TS
   8NCiV1m0FmRRQXU38or3zKl8qH1fylHr5COIm1mcdKavNlU2VI1WeuyK7
   nl8Fk1KUf8wgQxLGOjfGWAQDfEsMvQoXVdwRMzO7CREX3EVUizb57N8S1
   ymHBT1sjuU+nqhe+DG+7YqF1Hvjh856WmJ3NZYDc93icq0ZGsCXkT3PHA
   W7M8ouscaXzKEPSMLy5Fg0iFgB6JwwKadJCMmB/ia7I12AsXy6gowhrq6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250896433"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="250896433"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="628210831"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2022 11:57:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxlh-0001lz-Ja; Wed, 23 Feb 2022 19:57:45 +0000
Date:   Thu, 24 Feb 2022 03:56:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Krishna Jha <kkishorj@codeaurora.org>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>
Subject: Re: [PATCH V1 1/1] ASoC: compress: propagate the error code from the
 compress framework
Message-ID: <202202240311.3VkBiyO2-lkp@intel.com>
References: <eda8b6cdd53576c5487422e46af20bae1a5c864f.1645618332.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda8b6cdd53576c5487422e46af20bae1a5c864f.1645618332.git.quic_rbankapu@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on linux/master broonie-sound/for-next linus/master v5.17-rc5 next-20220222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Raghu-Bankapur/ASoC-compress-propagate-the-error-code-from-the-compress-framework/20220223-215509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220224/202202240311.3VkBiyO2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6154c602c715dac9253695c89bebd921f43cc81d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Raghu-Bankapur/ASoC-compress-propagate-the-error-code-from-the-compress-framework/20220223-215509
        git checkout 6154c602c715dac9253695c89bebd921f43cc81d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/core/compress_offload.c:34:35: warning: extra tokens at end of #include directive [-Wextra-tokens]
   #include <sound/compress_driver.h>ASoC: compress: propagate the error code from the compress framework
                                     ^
                                     //
   sound/core/compress_offload.c:36:1: error: unknown type name 'Propagate'
   Propagate the error code from the compress framework for the timestamp
   ^
>> sound/core/compress_offload.c:36:14: error: expected ';' after top level declarator
   Propagate the error code from the compress framework for the timestamp
                ^
                ;
>> sound/core/compress_offload.c:112:23: error: invalid application of 'sizeof' to an incomplete type 'struct snd_compr_file'
           data = kzalloc(sizeof(*data), GFP_KERNEL);
                                ^~~~~~~
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
>> sound/core/compress_offload.c:118:25: error: incomplete definition of type 'struct snd_compr_file'
           INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
                              ~~~~^
   include/linux/workqueue.h:267:22: note: expanded from macro 'INIT_DELAYED_WORK'
           __INIT_DELAYED_WORK(_work, _func, 0)
                               ^~~~~
   include/linux/workqueue.h:252:15: note: expanded from macro '__INIT_DELAYED_WORK'
                   INIT_WORK(&(_work)->work, (_func));                     \
                               ^~~~~
   include/linux/workqueue.h:245:15: note: expanded from macro 'INIT_WORK'
           __INIT_WORK((_work), (_func), 0)
                        ^~~~~
   include/linux/workqueue.h:228:16: note: expanded from macro '__INIT_WORK'
                   __init_work((_work), _onstack);                         \
                                ^~~~~
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
>> sound/core/compress_offload.c:118:25: error: incomplete definition of type 'struct snd_compr_file'
           INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
                              ~~~~^
   include/linux/workqueue.h:267:22: note: expanded from macro 'INIT_DELAYED_WORK'
           __INIT_DELAYED_WORK(_work, _func, 0)
                               ^~~~~
   include/linux/workqueue.h:252:15: note: expanded from macro '__INIT_DELAYED_WORK'
                   INIT_WORK(&(_work)->work, (_func));                     \
                               ^~~~~
   include/linux/workqueue.h:245:15: note: expanded from macro 'INIT_WORK'
           __INIT_WORK((_work), (_func), 0)
                        ^~~~~
   include/linux/workqueue.h:229:4: note: expanded from macro '__INIT_WORK'
                   (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
                    ^~~~~
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
>> sound/core/compress_offload.c:118:25: error: incomplete definition of type 'struct snd_compr_file'
           INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
                              ~~~~^
   include/linux/workqueue.h:267:22: note: expanded from macro 'INIT_DELAYED_WORK'
           __INIT_DELAYED_WORK(_work, _func, 0)
                               ^~~~~
   include/linux/workqueue.h:252:15: note: expanded from macro '__INIT_DELAYED_WORK'
                   INIT_WORK(&(_work)->work, (_func));                     \
                               ^~~~~
   include/linux/workqueue.h:245:15: note: expanded from macro 'INIT_WORK'
           __INIT_WORK((_work), (_func), 0)
                        ^~~~~
   include/linux/workqueue.h:230:22: note: expanded from macro '__INIT_WORK'
                   lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, &__key, 0); \
                                      ^~~~~
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
>> sound/core/compress_offload.c:118:25: error: incomplete definition of type 'struct snd_compr_file'
           INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
                              ~~~~^
   include/linux/workqueue.h:267:22: note: expanded from macro 'INIT_DELAYED_WORK'
           __INIT_DELAYED_WORK(_work, _func, 0)
                               ^~~~~
   include/linux/workqueue.h:252:15: note: expanded from macro '__INIT_DELAYED_WORK'
                   INIT_WORK(&(_work)->work, (_func));                     \
                               ^~~~~
   include/linux/workqueue.h:245:15: note: expanded from macro 'INIT_WORK'
           __INIT_WORK((_work), (_func), 0)
                        ^~~~~
   include/linux/workqueue.h:231:20: note: expanded from macro '__INIT_WORK'
                   INIT_LIST_HEAD(&(_work)->entry);                        \
                                    ^~~~~
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
>> sound/core/compress_offload.c:118:25: error: incomplete definition of type 'struct snd_compr_file'
           INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
                              ~~~~^
   include/linux/workqueue.h:267:22: note: expanded from macro 'INIT_DELAYED_WORK'
           __INIT_DELAYED_WORK(_work, _func, 0)
                               ^~~~~
   include/linux/workqueue.h:252:15: note: expanded from macro '__INIT_DELAYED_WORK'
                   INIT_WORK(&(_work)->work, (_func));                     \
                               ^~~~~
   include/linux/workqueue.h:245:15: note: expanded from macro 'INIT_WORK'
           __INIT_WORK((_work), (_func), 0)
                        ^~~~~
   include/linux/workqueue.h:232:4: note: expanded from macro '__INIT_WORK'
                   (_work)->func = (_func);                                \
                    ^~~~~
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
>> sound/core/compress_offload.c:118:25: error: incomplete definition of type 'struct snd_compr_file'
           INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
                              ~~~~^
   include/linux/workqueue.h:267:22: note: expanded from macro 'INIT_DELAYED_WORK'
           __INIT_DELAYED_WORK(_work, _func, 0)
                               ^~~~~
   include/linux/workqueue.h:253:18: note: expanded from macro '__INIT_DELAYED_WORK'
                   __init_timer(&(_work)->timer,                           \
                                  ^~~~~
   include/linux/timer.h:115:19: note: expanded from macro '__init_timer'
                   init_timer_key((_timer), (_fn), (_flags), #_timer, &__key);\
                                   ^~~~~~
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
   sound/core/compress_offload.c:120:6: error: incomplete definition of type 'struct snd_compr_file'
           data->stream.ops = compr->ops;
           ~~~~^
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
   sound/core/compress_offload.c:121:6: error: incomplete definition of type 'struct snd_compr_file'
           data->stream.direction = dirn;
           ~~~~^
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
   sound/core/compress_offload.c:122:6: error: incomplete definition of type 'struct snd_compr_file'
           data->stream.private_data = compr->private_data;
           ~~~~^
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
   sound/core/compress_offload.c:123:6: error: incomplete definition of type 'struct snd_compr_file'
           data->stream.device = compr;
           ~~~~^
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
   sound/core/compress_offload.c:132:6: error: incomplete definition of type 'struct snd_compr_file'
           data->stream.runtime = runtime;
           ~~~~^
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
   sound/core/compress_offload.c:135:30: error: incomplete definition of type 'struct snd_compr_file'
           ret = compr->ops->open(&data->stream);
                                   ~~~~^
   sound/core/compress_offload.c:82:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data;
                  ^
   sound/core/compress_offload.c:148:42: error: incomplete definition of type 'struct snd_compr_file'
           struct snd_compr_runtime *runtime = data->stream.runtime;
                                               ~~~~^
   sound/core/compress_offload.c:147:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data = f->private_data;
                  ^
   sound/core/compress_offload.c:150:32: error: incomplete definition of type 'struct snd_compr_file'
           cancel_delayed_work_sync(&data->stream.error_work);
                                     ~~~~^
   sound/core/compress_offload.c:147:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data = f->private_data;
                  ^
   sound/core/compress_offload.c:156:7: error: incomplete definition of type 'struct snd_compr_file'
                   data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
                   ~~~~^
   sound/core/compress_offload.c:147:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data = f->private_data;
                  ^
   sound/core/compress_offload.c:156:34: error: incomplete definition of type 'struct snd_compr_file'
                   data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
                                              ~~~~^
   sound/core/compress_offload.c:147:9: note: forward declaration of 'struct snd_compr_file'
           struct snd_compr_file *data = f->private_data;
                  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +36 sound/core/compress_offload.c

    35	
  > 36	Propagate the error code from the compress framework for the timestamp
    37	query. This error code will be used by the client to handle the
    38	error case scenarios gracefully.
    39	
    40	/* struct snd_compr_codec_caps overflows the ioctl bit size for some
    41	 * architectures, so we need to disable the relevant ioctls.
    42	 */
    43	#if _IOC_SIZEBITS < 14
    44	#define COMPR_CODEC_CAPS_OVERFLOW
    45	#endif
    46	
    47	/* TODO:
    48	 * - add substream support for multiple devices in case of
    49	 *	SND_DYNAMIC_MINORS is not used
    50	 * - Multiple node representation
    51	 *	driver should be able to register multiple nodes
    52	 */
    53	
    54	struct snd_compr_file {
    55		unsigned long caps;
    56		struct snd_compr_stream stream;
    57	};
    58	
    59	static void error_delayed_work(struct work_struct *work);
    60	
    61	/*
    62	 * a note on stream states used:
    63	 * we use following states in the compressed core
    64	 * SNDRV_PCM_STATE_OPEN: When stream has been opened.
    65	 * SNDRV_PCM_STATE_SETUP: When stream has been initialized. This is done by
    66	 *	calling SNDRV_COMPRESS_SET_PARAMS. Running streams will come to this
    67	 *	state at stop by calling SNDRV_COMPRESS_STOP, or at end of drain.
    68	 * SNDRV_PCM_STATE_PREPARED: When a stream has been written to (for
    69	 *	playback only). User after setting up stream writes the data buffer
    70	 *	before starting the stream.
    71	 * SNDRV_PCM_STATE_RUNNING: When stream has been started and is
    72	 *	decoding/encoding and rendering/capturing data.
    73	 * SNDRV_PCM_STATE_DRAINING: When stream is draining current data. This is done
    74	 *	by calling SNDRV_COMPRESS_DRAIN.
    75	 * SNDRV_PCM_STATE_PAUSED: When stream is paused. This is done by calling
    76	 *	SNDRV_COMPRESS_PAUSE. It can be stopped or resumed by calling
    77	 *	SNDRV_COMPRESS_STOP or SNDRV_COMPRESS_RESUME respectively.
    78	 */
    79	static int snd_compr_open(struct inode *inode, struct file *f)
    80	{
    81		struct snd_compr *compr;
    82		struct snd_compr_file *data;
    83		struct snd_compr_runtime *runtime;
    84		enum snd_compr_direction dirn;
    85		int maj = imajor(inode);
    86		int ret;
    87	
    88		if ((f->f_flags & O_ACCMODE) == O_WRONLY)
    89			dirn = SND_COMPRESS_PLAYBACK;
    90		else if ((f->f_flags & O_ACCMODE) == O_RDONLY)
    91			dirn = SND_COMPRESS_CAPTURE;
    92		else
    93			return -EINVAL;
    94	
    95		if (maj == snd_major)
    96			compr = snd_lookup_minor_data(iminor(inode),
    97						SNDRV_DEVICE_TYPE_COMPRESS);
    98		else
    99			return -EBADFD;
   100	
   101		if (compr == NULL) {
   102			pr_err("no device data!!!\n");
   103			return -ENODEV;
   104		}
   105	
   106		if (dirn != compr->direction) {
   107			pr_err("this device doesn't support this direction\n");
   108			snd_card_unref(compr->card);
   109			return -EINVAL;
   110		}
   111	
 > 112		data = kzalloc(sizeof(*data), GFP_KERNEL);
   113		if (!data) {
   114			snd_card_unref(compr->card);
   115			return -ENOMEM;
   116		}
   117	
 > 118		INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
   119	
   120		data->stream.ops = compr->ops;
   121		data->stream.direction = dirn;
   122		data->stream.private_data = compr->private_data;
   123		data->stream.device = compr;
   124		runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
   125		if (!runtime) {
   126			kfree(data);
   127			snd_card_unref(compr->card);
   128			return -ENOMEM;
   129		}
   130		runtime->state = SNDRV_PCM_STATE_OPEN;
   131		init_waitqueue_head(&runtime->sleep);
   132		data->stream.runtime = runtime;
   133		f->private_data = (void *)data;
   134		mutex_lock(&compr->lock);
   135		ret = compr->ops->open(&data->stream);
   136		mutex_unlock(&compr->lock);
   137		if (ret) {
   138			kfree(runtime);
   139			kfree(data);
   140		}
   141		snd_card_unref(compr->card);
   142		return ret;
   143	}
   144	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

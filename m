Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E45C59943B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbiHSEmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiHSEmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:42:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA50B9FAD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660884158; x=1692420158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yYJbHhB9T1/nROM5p8UX5wjpfxHwWfgXFil9Wq2FgiU=;
  b=MxabTvQB5hVhpnVAklUoxodBqMVLaJkA/R9Y4QQoaYd+6kpbg3k19S4c
   n5hfrv5dNCqdtK9fgdQwDm4NSAMFfirME5PNd3IYb3wFrvUUk7VwseK+d
   1VKF4O6EktWtL9uO5Q3r+t6kPu+DtsCtoX9q4KK1gzG92PNhbniRT/eiq
   Vz+l/KOlatJ9GRO+8zMqtQjrY1JVGb5z25UngtJ0rcu6lPZkng8RsJiYN
   aDf34hCC4vPxUNNhS5xuk/eNUb+QB0Kqd8pTC/HcnsgYkDI+OoC5PjZsc
   VI5WXcedKwU8NsJ07CIWm99BZKCWqMxookeuNhgq0iAMSJXwe4jWpcQcB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="290501256"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="290501256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 21:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558809254"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 21:42:35 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOtq6-00014p-2k;
        Fri, 19 Aug 2022 04:42:34 +0000
Date:   Fri, 19 Aug 2022 12:41:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/pci/hda/hda_proc.c:774:13: warning: stack frame size (2448)
 exceeds limit (2048) in 'print_codec_info'
Message-ID: <202208191249.8quRg0bN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cezary,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4c2d0b039c5cc0112206a5b22431b577cb1c57ad
commit: b5df2a7dca1cc6c66eee0005c92094855dc2028c ASoC: codecs: Add HD-Audio codec driver
date:   2 months ago
config: mips-randconfig-r032-20220819 (https://download.01.org/0day-ci/archive/20220819/202208191249.8quRg0bN-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips64el-linux-gnuabi64
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5df2a7dca1cc6c66eee0005c92094855dc2028c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b5df2a7dca1cc6c66eee0005c92094855dc2028c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/pci/hda/hda_proc.c:774:13: warning: stack frame size (2448) exceeds limit (2048) in 'print_codec_info' [-Wframe-larger-than]
   static void print_codec_info(struct snd_info_entry *entry,
               ^
   1 warning generated.


vim +/print_codec_info +774 sound/pci/hda/hda_proc.c

7639a06c23c7d4 Takashi Iwai    2015-03-03  773  
7639a06c23c7d4 Takashi Iwai    2015-03-03 @774  static void print_codec_info(struct snd_info_entry *entry,
7639a06c23c7d4 Takashi Iwai    2015-03-03  775  			     struct snd_info_buffer *buffer)
7639a06c23c7d4 Takashi Iwai    2015-03-03  776  {
7639a06c23c7d4 Takashi Iwai    2015-03-03  777  	struct hda_codec *codec = entry->private_data;
7639a06c23c7d4 Takashi Iwai    2015-03-03  778  	hda_nid_t nid, fg;
7639a06c23c7d4 Takashi Iwai    2015-03-03  779  	int i, nodes;
e25c05f1d5cf4e Jonathan Phenix 2007-06-19  780  
7639a06c23c7d4 Takashi Iwai    2015-03-03  781  	print_codec_core_info(&codec->core, buffer);
7639a06c23c7d4 Takashi Iwai    2015-03-03  782  	fg = codec->core.afg;
7639a06c23c7d4 Takashi Iwai    2015-03-03  783  	if (!fg)
ec9e1c5c9c7350 Takashi Iwai    2005-09-07  784  		return;
cb53c626e1145e Takashi Iwai    2007-08-10  785  	snd_hda_power_up(codec);
b90d7760ea784f Takashi Iwai    2006-11-07  786  	snd_iprintf(buffer, "Default PCM:\n");
7639a06c23c7d4 Takashi Iwai    2015-03-03  787  	print_pcm_caps(buffer, codec, fg);
^1da177e4c3f41 Linus Torvalds  2005-04-16  788  	snd_iprintf(buffer, "Default Amp-In caps: ");
7639a06c23c7d4 Takashi Iwai    2015-03-03  789  	print_amp_caps(buffer, codec, fg, HDA_INPUT);
^1da177e4c3f41 Linus Torvalds  2005-04-16  790  	snd_iprintf(buffer, "Default Amp-Out caps: ");
7639a06c23c7d4 Takashi Iwai    2015-03-03  791  	print_amp_caps(buffer, codec, fg, HDA_OUTPUT);
7639a06c23c7d4 Takashi Iwai    2015-03-03  792  	snd_iprintf(buffer, "State of AFG node 0x%02x:\n", fg);
7639a06c23c7d4 Takashi Iwai    2015-03-03  793  	print_power_state(buffer, codec, fg);
^1da177e4c3f41 Linus Torvalds  2005-04-16  794  
7639a06c23c7d4 Takashi Iwai    2015-03-03  795  	nodes = snd_hda_get_sub_nodes(codec, fg, &nid);
^1da177e4c3f41 Linus Torvalds  2005-04-16  796  	if (! nid || nodes < 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  797  		snd_iprintf(buffer, "Invalid AFG subtree\n");
cb53c626e1145e Takashi Iwai    2007-08-10  798  		snd_hda_power_down(codec);
^1da177e4c3f41 Linus Torvalds  2005-04-16  799  		return;
^1da177e4c3f41 Linus Torvalds  2005-04-16  800  	}
797760ab14db4e Andrew Paprocki 2008-01-18  801  
7639a06c23c7d4 Takashi Iwai    2015-03-03  802  	print_gpio(buffer, codec, fg);
2d34e1b3bb991a Takashi Iwai    2008-11-28  803  	if (codec->proc_widget_hook)
7639a06c23c7d4 Takashi Iwai    2015-03-03  804  		codec->proc_widget_hook(buffer, codec, fg);
797760ab14db4e Andrew Paprocki 2008-01-18  805  
^1da177e4c3f41 Linus Torvalds  2005-04-16  806  	for (i = 0; i < nodes; i++, nid++) {
d01ce99fc53271 Takashi Iwai    2007-07-27  807  		unsigned int wid_caps =
9ba17b4d132f56 Takashi Iwai    2015-03-03  808  			param_read(codec, nid, AC_PAR_AUDIO_WIDGET_CAP);
a22d543a95e82e Takashi Iwai    2009-07-27  809  		unsigned int wid_type = get_wcaps_type(wid_caps);
4eea30914facd2 Takashi Iwai    2013-02-07  810  		hda_nid_t *conn = NULL;
797760ab14db4e Andrew Paprocki 2008-01-18  811  		int conn_len = 0;
3e289f16ec2e08 Takashi Iwai    2005-06-10  812  
^1da177e4c3f41 Linus Torvalds  2005-04-16  813  		snd_iprintf(buffer, "Node 0x%02x [%s] wcaps 0x%x:", nid,
^1da177e4c3f41 Linus Torvalds  2005-04-16  814  			    get_wid_type_name(wid_type), wid_caps);
c4920606757224 Takashi Iwai    2008-07-30  815  		if (wid_caps & AC_WCAP_STEREO) {
fd72d008465d45 Wu Fengguang    2009-08-24  816  			unsigned int chans = get_wcaps_channels(wid_caps);
c4920606757224 Takashi Iwai    2008-07-30  817  			if (chans == 2)
^1da177e4c3f41 Linus Torvalds  2005-04-16  818  				snd_iprintf(buffer, " Stereo");
^1da177e4c3f41 Linus Torvalds  2005-04-16  819  			else
c4920606757224 Takashi Iwai    2008-07-30  820  				snd_iprintf(buffer, " %d-Channels", chans);
c4920606757224 Takashi Iwai    2008-07-30  821  		} else
^1da177e4c3f41 Linus Torvalds  2005-04-16  822  			snd_iprintf(buffer, " Mono");
^1da177e4c3f41 Linus Torvalds  2005-04-16  823  		if (wid_caps & AC_WCAP_DIGITAL)
^1da177e4c3f41 Linus Torvalds  2005-04-16  824  			snd_iprintf(buffer, " Digital");
^1da177e4c3f41 Linus Torvalds  2005-04-16  825  		if (wid_caps & AC_WCAP_IN_AMP)
^1da177e4c3f41 Linus Torvalds  2005-04-16  826  			snd_iprintf(buffer, " Amp-In");
^1da177e4c3f41 Linus Torvalds  2005-04-16  827  		if (wid_caps & AC_WCAP_OUT_AMP)
^1da177e4c3f41 Linus Torvalds  2005-04-16  828  			snd_iprintf(buffer, " Amp-Out");
797760ab14db4e Andrew Paprocki 2008-01-18  829  		if (wid_caps & AC_WCAP_STRIPE)
797760ab14db4e Andrew Paprocki 2008-01-18  830  			snd_iprintf(buffer, " Stripe");
797760ab14db4e Andrew Paprocki 2008-01-18  831  		if (wid_caps & AC_WCAP_LR_SWAP)
797760ab14db4e Andrew Paprocki 2008-01-18  832  			snd_iprintf(buffer, " R/L");
c4920606757224 Takashi Iwai    2008-07-30  833  		if (wid_caps & AC_WCAP_CP_CAPS)
c4920606757224 Takashi Iwai    2008-07-30  834  			snd_iprintf(buffer, " CP");
^1da177e4c3f41 Linus Torvalds  2005-04-16  835  		snd_iprintf(buffer, "\n");
^1da177e4c3f41 Linus Torvalds  2005-04-16  836  
5b0cb1d850c268 Jaroslav Kysela 2009-12-08  837  		print_nid_array(buffer, codec, nid, &codec->mixers);
5b0cb1d850c268 Jaroslav Kysela 2009-12-08  838  		print_nid_array(buffer, codec, nid, &codec->nids);
3911a4c19e9277 Jaroslav Kysela 2009-11-11  839  		print_nid_pcms(buffer, codec, nid);
3911a4c19e9277 Jaroslav Kysela 2009-11-11  840  
e171613949e350 Takashi Iwai    2007-11-16  841  		/* volume knob is a special widget that always have connection
e171613949e350 Takashi Iwai    2007-11-16  842  		 * list
e171613949e350 Takashi Iwai    2007-11-16  843  		 */
e171613949e350 Takashi Iwai    2007-11-16  844  		if (wid_type == AC_WID_VOL_KNB)
e171613949e350 Takashi Iwai    2007-11-16  845  			wid_caps |= AC_WCAP_CONN_LIST;
e171613949e350 Takashi Iwai    2007-11-16  846  
4eea30914facd2 Takashi Iwai    2013-02-07  847  		if (wid_caps & AC_WCAP_CONN_LIST) {
4eea30914facd2 Takashi Iwai    2013-02-07  848  			conn_len = snd_hda_get_num_raw_conns(codec, nid);
4eea30914facd2 Takashi Iwai    2013-02-07  849  			if (conn_len > 0) {
6da2ec56059c3c Kees Cook       2018-06-12  850  				conn = kmalloc_array(conn_len,
6da2ec56059c3c Kees Cook       2018-06-12  851  						     sizeof(hda_nid_t),
4eea30914facd2 Takashi Iwai    2013-02-07  852  						     GFP_KERNEL);
4eea30914facd2 Takashi Iwai    2013-02-07  853  				if (!conn)
4eea30914facd2 Takashi Iwai    2013-02-07  854  					return;
4eea30914facd2 Takashi Iwai    2013-02-07  855  				if (snd_hda_get_raw_connections(codec, nid, conn,
4eea30914facd2 Takashi Iwai    2013-02-07  856  								conn_len) < 0)
4eea30914facd2 Takashi Iwai    2013-02-07  857  					conn_len = 0;
4eea30914facd2 Takashi Iwai    2013-02-07  858  			}
4eea30914facd2 Takashi Iwai    2013-02-07  859  		}
3e289f16ec2e08 Takashi Iwai    2005-06-10  860  
^1da177e4c3f41 Linus Torvalds  2005-04-16  861  		if (wid_caps & AC_WCAP_IN_AMP) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  862  			snd_iprintf(buffer, "  Amp-In caps: ");
^1da177e4c3f41 Linus Torvalds  2005-04-16  863  			print_amp_caps(buffer, codec, nid, HDA_INPUT);
^1da177e4c3f41 Linus Torvalds  2005-04-16  864  			snd_iprintf(buffer, "  Amp-In vals: ");
4f32456e5ed485 Michael Karcher 2012-04-06  865  			if (wid_type == AC_WID_PIN ||
4f32456e5ed485 Michael Karcher 2012-04-06  866  			    (codec->single_adc_amp &&
4f32456e5ed485 Michael Karcher 2012-04-06  867  			     wid_type == AC_WID_AUD_IN))
^1da177e4c3f41 Linus Torvalds  2005-04-16  868  				print_amp_vals(buffer, codec, nid, HDA_INPUT,
cc261738add939 Takashi Iwai    2015-03-16  869  					       wid_caps, 1);
4f32456e5ed485 Michael Karcher 2012-04-06  870  			else
4f32456e5ed485 Michael Karcher 2012-04-06  871  				print_amp_vals(buffer, codec, nid, HDA_INPUT,
cc261738add939 Takashi Iwai    2015-03-16  872  					       wid_caps, conn_len);
^1da177e4c3f41 Linus Torvalds  2005-04-16  873  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  874  		if (wid_caps & AC_WCAP_OUT_AMP) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  875  			snd_iprintf(buffer, "  Amp-Out caps: ");
^1da177e4c3f41 Linus Torvalds  2005-04-16  876  			print_amp_caps(buffer, codec, nid, HDA_OUTPUT);
^1da177e4c3f41 Linus Torvalds  2005-04-16  877  			snd_iprintf(buffer, "  Amp-Out vals: ");
9421f9543b3a0a Takashi Iwai    2009-03-12  878  			if (wid_type == AC_WID_PIN &&
9421f9543b3a0a Takashi Iwai    2009-03-12  879  			    codec->pin_amp_workaround)
9421f9543b3a0a Takashi Iwai    2009-03-12  880  				print_amp_vals(buffer, codec, nid, HDA_OUTPUT,
cc261738add939 Takashi Iwai    2015-03-16  881  					       wid_caps, conn_len);
9421f9543b3a0a Takashi Iwai    2009-03-12  882  			else
^1da177e4c3f41 Linus Torvalds  2005-04-16  883  				print_amp_vals(buffer, codec, nid, HDA_OUTPUT,
cc261738add939 Takashi Iwai    2015-03-16  884  					       wid_caps, 1);
^1da177e4c3f41 Linus Torvalds  2005-04-16  885  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  886  
e97a516701cfc3 Takashi Iwai    2007-10-26  887  		switch (wid_type) {
797760ab14db4e Andrew Paprocki 2008-01-18  888  		case AC_WID_PIN: {
797760ab14db4e Andrew Paprocki 2008-01-18  889  			int supports_vref;
797760ab14db4e Andrew Paprocki 2008-01-18  890  			print_pin_caps(buffer, codec, nid, &supports_vref);
797760ab14db4e Andrew Paprocki 2008-01-18  891  			print_pin_ctls(buffer, codec, nid, supports_vref);
e97a516701cfc3 Takashi Iwai    2007-10-26  892  			break;
797760ab14db4e Andrew Paprocki 2008-01-18  893  		}
e97a516701cfc3 Takashi Iwai    2007-10-26  894  		case AC_WID_VOL_KNB:
797760ab14db4e Andrew Paprocki 2008-01-18  895  			print_vol_knob(buffer, codec, nid);
e97a516701cfc3 Takashi Iwai    2007-10-26  896  			break;
e97a516701cfc3 Takashi Iwai    2007-10-26  897  		case AC_WID_AUD_OUT:
e97a516701cfc3 Takashi Iwai    2007-10-26  898  		case AC_WID_AUD_IN:
797760ab14db4e Andrew Paprocki 2008-01-18  899  			print_audio_io(buffer, codec, nid, wid_type);
797760ab14db4e Andrew Paprocki 2008-01-18  900  			if (wid_caps & AC_WCAP_DIGITAL)
797760ab14db4e Andrew Paprocki 2008-01-18  901  				print_digital_conv(buffer, codec, nid);
e97a516701cfc3 Takashi Iwai    2007-10-26  902  			if (wid_caps & AC_WCAP_FORMAT_OVRD) {
b90d7760ea784f Takashi Iwai    2006-11-07  903  				snd_iprintf(buffer, "  PCM:\n");
^1da177e4c3f41 Linus Torvalds  2005-04-16  904  				print_pcm_caps(buffer, codec, nid);
^1da177e4c3f41 Linus Torvalds  2005-04-16  905  			}
e97a516701cfc3 Takashi Iwai    2007-10-26  906  			break;
e97a516701cfc3 Takashi Iwai    2007-10-26  907  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  908  
797760ab14db4e Andrew Paprocki 2008-01-18  909  		if (wid_caps & AC_WCAP_UNSOL_CAP)
797760ab14db4e Andrew Paprocki 2008-01-18  910  			print_unsol_cap(buffer, codec, nid);
797760ab14db4e Andrew Paprocki 2008-01-18  911  
b7027cc29e158e Takashi Iwai    2005-11-02  912  		if (wid_caps & AC_WCAP_POWER)
797760ab14db4e Andrew Paprocki 2008-01-18  913  			print_power_state(buffer, codec, nid);
b7027cc29e158e Takashi Iwai    2005-11-02  914  
797760ab14db4e Andrew Paprocki 2008-01-18  915  		if (wid_caps & AC_WCAP_DELAY)
797760ab14db4e Andrew Paprocki 2008-01-18  916  			snd_iprintf(buffer, "  Delay: %d samples\n",
797760ab14db4e Andrew Paprocki 2008-01-18  917  				    (wid_caps & AC_WCAP_DELAY) >>
797760ab14db4e Andrew Paprocki 2008-01-18  918  				    AC_WCAP_DELAY_SHIFT);
797760ab14db4e Andrew Paprocki 2008-01-18  919  
7a624ea56222fc Mengdong Lin    2013-08-26  920  		if (wid_type == AC_WID_PIN && codec->dp_mst)
7a624ea56222fc Mengdong Lin    2013-08-26  921  			print_device_list(buffer, codec, nid);
7a624ea56222fc Mengdong Lin    2013-08-26  922  
797760ab14db4e Andrew Paprocki 2008-01-18  923  		if (wid_caps & AC_WCAP_CONN_LIST)
797760ab14db4e Andrew Paprocki 2008-01-18  924  			print_conn_list(buffer, codec, nid, wid_type,
797760ab14db4e Andrew Paprocki 2008-01-18  925  					conn, conn_len);
797760ab14db4e Andrew Paprocki 2008-01-18  926  
797760ab14db4e Andrew Paprocki 2008-01-18  927  		if (wid_caps & AC_WCAP_PROC_WID)
797760ab14db4e Andrew Paprocki 2008-01-18  928  			print_proc_caps(buffer, codec, nid);
797760ab14db4e Andrew Paprocki 2008-01-18  929  
daead538e9d8ef Takashi Iwai    2008-11-28  930  		if (codec->proc_widget_hook)
daead538e9d8ef Takashi Iwai    2008-11-28  931  			codec->proc_widget_hook(buffer, codec, nid);
4eea30914facd2 Takashi Iwai    2013-02-07  932  
4eea30914facd2 Takashi Iwai    2013-02-07  933  		kfree(conn);
e171613949e350 Takashi Iwai    2007-11-16  934  	}
cb53c626e1145e Takashi Iwai    2007-08-10  935  	snd_hda_power_down(codec);
^1da177e4c3f41 Linus Torvalds  2005-04-16  936  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  937  

:::::: The code at line 774 was first introduced by commit
:::::: 7639a06c23c7d4cda34c2546bd7290d8753849ca ALSA: hda - Move a part of hda_codec stuff into hdac_device

:::::: TO: Takashi Iwai <tiwai@suse.de>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8959C150
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiHVOGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiHVOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:06:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CA26AD6;
        Mon, 22 Aug 2022 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661177167; x=1692713167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WxpzUL26H200ZgJ78BIfcOFc7J6X4Yom54/sexDTpps=;
  b=V9dAV//gmkKFcRUhW6Pf0wfHKAetHq10jdfnzIKN074FSbcWL2IXhQVE
   OWPPTg6jsPkLNf7YyvVWw6UbMI8pWpnsQ9xg0QIYYBSRLBOpdEcbl9Rwz
   VobHP6d/hMOuPAcKIOmAlllquM62Fa6h+m4LKM66X7CNGZWK0+3Igcn0T
   kYRBLKIyLv891M0H1ZNonm82Xq1s+2JNLOJ+03lKjOaQSQNA+1f1BzukU
   1qTriRrM8U3T7ecqGvcjpxyh4Vbt/J14y83c6VMHvHwSiB/E7s4lOOnPM
   cRiIyfDa0l6JQh+PNcAipdSkqYGA5zjnpU4Orbavbp8ippBDSG615+hye
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294209617"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294209617"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 07:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="937051599"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2022 07:05:37 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ83d-0000CR-19;
        Mon, 22 Aug 2022 14:05:37 +0000
Date:   Mon, 22 Aug 2022 22:05:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: Re: [PATCH 3/6] tty: n_gsm: replace use of gsm_read_ea() with
 gsm_read_ea_val()
Message-ID: <202208222147.WfFRmf1r-lkp@intel.com>
References: <20220822072138.3123-3-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822072138.3123-3-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Starke",

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on linus/master v6.0-rc2 next-20220822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Starke/tty-n_gsm-add-enumeration-for-gsm-encodings/20220822-152532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: i386-randconfig-a003-20220822 (https://download.01.org/0day-ci/archive/20220822/202208222147.WfFRmf1r-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/66ec0ad14dba76f793ec89ecdc7e6d7b3c550873
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review D-Starke/tty-n_gsm-add-enumeration-for-gsm-encodings/20220822-152532
        git checkout 66ec0ad14dba76f793ec89ecdc7e6d7b3c550873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/n_gsm.c:1928:34: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
                   pr_debug("%d bytes for tty\n", len);
                                                  ^~~
   include/linux/printk.h:588:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/tty/n_gsm.c:1925:9: note: initialize the variable 'len' to silence this warning
           int len;
                  ^
                   = 0
   1 warning generated.


vim +/len +1928 drivers/tty/n_gsm.c

e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1907  
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1908  /**
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1909   *	gsm_dlci_data		-	data arrived
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1910   *	@dlci: channel
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1911   *	@data: block of bytes received
724ac070ffc7a1 drivers/tty/n_gsm.c  Jiri Slaby          2020-08-18  1912   *	@clen: length of received block
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1913   *
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1914   *	A UI or UIH frame has arrived which contains data for a channel
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1915   *	other than the control channel. If the relevant virtual tty is
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1916   *	open we shovel the bits down it, if not we drop them.
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1917   */
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1918  
4feb7a4a124444 drivers/tty/n_gsm.c  Tony Lindgren       2019-01-13  1919  static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1920  {
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1921  	/* krefs .. */
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1922  	struct tty_port *port = &dlci->port;
2e124b4a390ca8 drivers/tty/n_gsm.c  Jiri Slaby          2013-01-03  1923  	struct tty_struct *tty;
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1924  	unsigned int modem = 0;
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1925  	int len;
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1926  
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1927  	if (debug & 16)
2e124b4a390ca8 drivers/tty/n_gsm.c  Jiri Slaby          2013-01-03 @1928  		pr_debug("%d bytes for tty\n", len);
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1929  	switch (dlci->adaption)  {
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1930  	/* Unsupported types */
3e913eebdfbb56 drivers/tty/n_gsm.c  Gustavo A. R. Silva 2019-02-25  1931  	case 4:		/* Packetised interruptible data */
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1932  		break;
3e913eebdfbb56 drivers/tty/n_gsm.c  Gustavo A. R. Silva 2019-02-25  1933  	case 3:		/* Packetised uininterruptible voice/data */
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1934  		break;
3e913eebdfbb56 drivers/tty/n_gsm.c  Gustavo A. R. Silva 2019-02-25  1935  	case 2:		/* Asynchronous serial with line state in each frame */
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1936  		len = gsm_read_ea_val(&modem, data, clen);
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1937  		if (len < 1)
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1938  			return;
2e124b4a390ca8 drivers/tty/n_gsm.c  Jiri Slaby          2013-01-03  1939  		tty = tty_port_tty_get(port);
2e124b4a390ca8 drivers/tty/n_gsm.c  Jiri Slaby          2013-01-03  1940  		if (tty) {
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1941  			gsm_process_modem(tty, dlci, modem, len);
1adf6fee58ca25 drivers/tty/n_gsm.c  Daniel Starke       2022-04-14  1942  			tty_wakeup(tty);
2e124b4a390ca8 drivers/tty/n_gsm.c  Jiri Slaby          2013-01-03  1943  			tty_kref_put(tty);
2e124b4a390ca8 drivers/tty/n_gsm.c  Jiri Slaby          2013-01-03  1944  		}
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1945  		/* Skip processed modem data */
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1946  		data += len;
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1947  		clen -= len;
df561f6688fef7 drivers/tty/n_gsm.c  Gustavo A. R. Silva 2020-08-23  1948  		fallthrough;
3e913eebdfbb56 drivers/tty/n_gsm.c  Gustavo A. R. Silva 2019-02-25  1949  	case 1:		/* Line state will go via DLCI 0 controls only */
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1950  	default:
66ec0ad14dba76 drivers/tty/n_gsm.c  Daniel Starke       2022-08-22  1951  		tty_insert_flip_string(port, data, clen);
2e124b4a390ca8 drivers/tty/n_gsm.c  Jiri Slaby          2013-01-03  1952  		tty_flip_buffer_push(port);
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1953  	}
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1954  }
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox            2010-03-26  1955  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

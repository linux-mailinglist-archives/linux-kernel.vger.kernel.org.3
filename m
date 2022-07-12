Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64770570F21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiGLAy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGLAyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:54:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307822A721;
        Mon, 11 Jul 2022 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657587294; x=1689123294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V6w2sMs8zcctI71jT/jdZW5CM1h96l8zoH9VbyJnAnM=;
  b=Ldv7tubNo0S98EJKfEhYV3eR54b6saKYfLHbV3vcAeS9oy3Qhgq2cfLm
   8UeElwpqLa9TeD70uREOlWVLlzKi2p4LIJSyGbFuVvnRMCT//qjVMq4Gi
   zFvpZBqBd9+E6gT/CR7vUWDSSCvmfQliyAl+TruCHjRbRLhNU4ZyepbQA
   BmjnajTHw/2ERg3XllpYCHkx7Cq224BKiwCb5EZPzznHP8YbF9We9FNBL
   pwJKUXC1wtdn09W2BKbHDRm/iYb557BCcDxmuj2BJiQK7iyx/ZRC8VU83
   PBQvBI5sxqdNiNeBbrLueEDU9bsbnJXWnhkoRessmF85uy61tuaCevvYI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="265219256"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="265219256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="662759318"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2022 17:54:48 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB4Aq-0001Rz-8h;
        Tue, 12 Jul 2022 00:54:48 +0000
Date:   Tue, 12 Jul 2022 08:54:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarrett Schultz <jaschultzms@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dmitry Antipov <dmanti@microsoft.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v5 5/6] HID: add spi-hid, transport driver for HID over
 SPI bus
Message-ID: <202207120839.Ga8kjAG8-lkp@intel.com>
References: <20220707165902.3184-6-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707165902.3184-6-jaschultzMS@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarrett,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hid/for-next]
[also build test WARNING on dtor-input/next robh/for-next linus/master v5.19-rc6 next-20220711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarrett-Schultz/Add-spi-hid-transport-for-HID-over-SPI-bus/20220708-010203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220712/202207120839.Ga8kjAG8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 77a38f6839980bfac61babb40d83772c51427011)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d0121c2f2d1bb21824555c34c233dd3fbc6aee96
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jarrett-Schultz/Add-spi-hid-transport-for-HID-over-SPI-bus/20220708-010203
        git checkout d0121c2f2d1bb21824555c34c233dd3fbc6aee96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/spi-hid/ drivers/md/ drivers/net/ethernet/marvell/prestera/ drivers/vfio/pci/mlx5/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/spi-hid/spi-hid-core.c:193:20: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
   static const char *const spi_hid_power_mode_string(u8 power_state)
                      ^~~~~~
>> drivers/hid/spi-hid/spi-hid-core.c:691:4: warning: format specifies type 'unsigned short' but the argument has type '__u32' (aka 'unsigned int') [-Wformat]
                           hid->vendor, hid->product);
                           ^~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-core.c:691:17: warning: format specifies type 'unsigned short' but the argument has type '__u32' (aka 'unsigned int') [-Wformat]
                           hid->vendor, hid->product);
                                        ^~~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-core.c:1318:13: error: incompatible function pointer types initializing 'void (*)(struct spi_device *)' with an expression of type 'int (struct spi_device *)' [-Werror,-Wincompatible-function-pointer-types]
           .remove         = spi_hid_remove,
                             ^~~~~~~~~~~~~~
   3 warnings and 1 error generated.
--
   In file included from drivers/hid/spi-hid/trace.c:9:
   In file included from drivers/hid/spi-hid/./spi-hid_trace.h:194:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> drivers/hid/spi-hid/./spi-hid_trace.h:140:92: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
           TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state i:%d p:%d len i:%d o:%d r:%d flags %c",
                                                                                                    ~^
   include/trace/stages/stage3_trace_output.h:9:33: note: expanded from macro 'TP_printk'
   #define TP_printk(fmt, args...) fmt "\n", args
                                   ^~~
   include/trace/trace_events.h:203:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
           trace_event_printf(iter, print);                                \
                                    ^~~~~
   1 warning generated.


vim +/const +193 drivers/hid/spi-hid/spi-hid-core.c

   192	
 > 193	static const char *const spi_hid_power_mode_string(u8 power_state)
   194	{
   195		switch (power_state) {
   196		case SPI_HID_POWER_MODE_ON:
   197			return "d0";
   198		case SPI_HID_POWER_MODE_SLEEP:
   199			return "d2";
   200		case SPI_HID_POWER_MODE_OFF:
   201			return "d3";
   202		case SPI_HID_POWER_MODE_WAKING_SLEEP:
   203			return "d3*";
   204		default:
   205			return "unknown";
   206		}
   207	}
   208	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

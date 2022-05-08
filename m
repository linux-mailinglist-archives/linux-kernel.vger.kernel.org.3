Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3969751EF63
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiEHTII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiEHRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:20:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B115FA0;
        Sun,  8 May 2022 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652030222; x=1683566222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SYh2+SgtKmSROzESZMWbtC8pVFaTTOCqNd3grk1XfRo=;
  b=YVd4hbUjr5rX7o6c+yJ/OCbYLQkEKAu355wrJSCaSEgQizxePr8PFSiB
   JaPodj9UK8KKm5QcDuCxMqBMhuAhi2HHs1FmPL5Ikw450PeAx2u5qfJsb
   RPNxotSheBvAk9af684Xtuu9tjWv+x4E3HHnlLalbjK8T3BYfVas+FinN
   jU2D37z0/OKRecaufq6e70/Xz0t51a45juWwsByFAP1RoaPI+QimIGFiD
   RSAV6t60pBDPkYb5DAM056ohK2+1ciCOSLdJjNtP/dXNMpHammvVv+AAD
   QVIZ93c+AS0E6l4TKtjiZyyNxrdpSrwIO0e7XYIqtIcvALyFwpc3fmO6L
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="331881264"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="331881264"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 10:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="518850312"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 May 2022 10:16:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnkWg-000FeI-F3;
        Sun, 08 May 2022 17:16:58 +0000
Date:   Mon, 9 May 2022 01:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     kbuild-all@lists.01.org, benjamin.tissoires@redhat.com,
        spbnick@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanberzl@gmail.com,
        albertofanjul@gmail.com,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH for-5.19/uclogic 1/7] HID: uclogic: Move param printing
 to a function
Message-ID: <202205090129.trznWqE6-lkp@intel.com>
References: <20220508160146.13004-2-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220508160146.13004-2-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "José,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hid/for-next]
[cannot apply to v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/DIGImend-patches-part-VI/20220509-000510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220509/202205090129.trznWqE6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4c0671e4ce0687136ff71aa65539cd3a2798d99d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jos-Exp-sito/DIGImend-patches-part-VI/20220509-000510
        git checkout 4c0671e4ce0687136ff71aa65539cd3a2798d99d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-uclogic-params.c:48: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
   drivers/hid/hid-uclogic-params.c:80: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dump tablet interface frame parameters with hid_dbg(), indented with two
   drivers/hid/hid-uclogic-params.c:105: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dump tablet interface parameters with hid_dbg().


vim +48 drivers/hid/hid-uclogic-params.c

    46	
    47	/**
  > 48	 * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
    49	 *
    50	 * @hdev:	The HID device the pen parameters describe.
    51	 * @pen:	The pen parameters to dump.
    52	 */
    53	static void uclogic_params_pen_hid_dbg(const struct hid_device *hdev,
    54						const struct uclogic_params_pen *pen)
    55	{
    56		size_t i;
    57	
    58		hid_dbg(hdev, "\t.usage_invalid = %s\n",
    59			(pen->usage_invalid ? "true" : "false"));
    60		hid_dbg(hdev, "\t.desc_ptr = %p\n", pen->desc_ptr);
    61		hid_dbg(hdev, "\t.desc_size = %u\n", pen->desc_size);
    62		hid_dbg(hdev, "\t.id = %u\n", pen->id);
    63		hid_dbg(hdev, "\t.subreport_list = {\n");
    64		for (i = 0; i < ARRAY_SIZE(pen->subreport_list); i++) {
    65			hid_dbg(hdev, "\t\t{0x%02hhx, %hhu}%s\n",
    66				pen->subreport_list[i].value,
    67				pen->subreport_list[i].id,
    68				i < (ARRAY_SIZE(pen->subreport_list) - 1) ? "," : "");
    69		}
    70		hid_dbg(hdev, "\t}\n");
    71		hid_dbg(hdev, "\t.inrange = %s\n",
    72			uclogic_params_pen_inrange_to_str(pen->inrange));
    73		hid_dbg(hdev, "\t.fragmented_hires = %s\n",
    74			(pen->fragmented_hires ? "true" : "false"));
    75		hid_dbg(hdev, "\t.tilt_y_flipped = %s\n",
    76			(pen->tilt_y_flipped ? "true" : "false"));
    77	}
    78	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

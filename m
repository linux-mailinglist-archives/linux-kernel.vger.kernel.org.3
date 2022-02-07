Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4264AC030
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389171AbiBGNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388113AbiBGNqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:46:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7CDC043189
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644241592; x=1675777592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wK53JgZhBniyCgBVdS0LybEWKQeh0TXcziRebU5F5g=;
  b=boXQ3R9bPp1LomxTBJ00EenmeXGwhGBsvK1AXoFbz9ZZRq8l5Z5A2/UO
   DRy7+0nLyRFlNFCq6f4dZQDaJBxOWaoQ7AnOwXuvF1IGW2kbG3SAH1eKU
   0AzwHIxljpfaz7m3q7Blo8o1GcUvmokv0g/lI4xlRxagfmE5ytV8vSPFr
   UgbgWhjcD49eI5bgs6PAMj4wmXgz1Rs0cNA/TUzygM26J1qOjr20McWQU
   h9Y2ekEU5MYk+X7i4ad28/is5CO6r51tMn8WsKw/GlggGlCaOt+Z5lnYw
   Ja4ntZlojykwc7fvb10+14lRjJcPwQZKNxxxrc/9z8FuZbcbCRUjYjSXx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="232280777"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="232280777"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 05:46:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="700468612"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2022 05:46:30 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH4Ld-0000Zl-Rh; Mon, 07 Feb 2022 13:46:29 +0000
Date:   Mon, 7 Feb 2022 21:46:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Outline copy_overflow()
Message-ID: <202202072148.OAzMGrDo-lkp@intel.com>
References: <b9a31b025e729394e7081257870f0a0e73355a04.1644229010.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a31b025e729394e7081257870f0a0e73355a04.1644229010.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/mm-Outline-copy_overflow/20220207-190441
base:   https://github.com/hnaz/linux-mm master
config: i386-randconfig-a013-20220207 (https://download.01.org/0day-ci/archive/20220207/202202072148.OAzMGrDo-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/2ae7547d08e23e529db61b3de0cb93879630a102
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/mm-Outline-copy_overflow/20220207-190441
        git checkout 2ae7547d08e23e529db61b3de0cb93879630a102
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "copy_overflow" [drivers/usb/gadget/function/usb_f_fs.ko] undefined!
>> ERROR: modpost: "copy_overflow" [drivers/scsi/sg.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC857C81B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiGUJvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiGUJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:50:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24894BD36
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658397054; x=1689933054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBtdiK8rxibAsEgP3o4hqQ1ofzGNPEkyGhbFOLcvcog=;
  b=gB28EYZ2b0By+SPITtfKCdgCfLVLm+tk5aLEIqJBHM9jccTFEgvf/v4v
   Rjt3kz4rv1UWugEJZ2SMYspMeRdmcmQVmBE/VEFEbyVkFisMom+OtnS/M
   3uvlZq5udzOLfaIcsLAXj60tke8eivl54Tw3QPp0DaIbMkJxp8yltVVaT
   qV6r91y+OLmi3qVDxQBv9GsHIeAaiI9G4YJLIA7I8EO5bRao9w7IXywmR
   dukr4plfNPOQb9B5La6Q11d1CtwUt7e/gCS0CzjV/EbG0Z9GRLKvFqEu8
   tIWs0zqywRTrsJ8pLVUDGJqJCbk7G8YP1G8MyDcyk0UM2RK7y2K9iPZc5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="348699487"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="348699487"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 02:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="724981305"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2022 02:50:52 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oESpS-0001gv-BW;
        Thu, 21 Jul 2022 09:50:46 +0000
Date:   Thu, 21 Jul 2022 17:50:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <202207211731.9YcNa5UE-lkp@intel.com>
References: <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 9d882352bac8f2ff3753d691e2dc65fcaf738729]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Down/printk-console-Per-console-loglevels/20220721-015315
base:   9d882352bac8f2ff3753d691e2dc65fcaf738729
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-class-console:18: WARNING: Unexpected indentation.
>> Documentation/admin-guide/per-console-loglevel.rst: WARNING: document isn't included in any toctree

vim +18 Documentation/ABI/testing/sysfs-class-console

  > 18	Date:		May 2022
    19	Contact:	Chris Down <chris@chrisdown.name>
    20	Description:	Read only. The currently effective loglevel source for this
    21			console -- for example, whether it was set globally, or whether
    22			it was set locally for this console. Possible values are:
    23	
    24			local: The loglevel comes from the per-console loglevel.
    25			global: The loglevel comes from the global loglevel.
    26			ignore_loglevel: Both the per-console loglevel and global
    27					 loglevels are ignored as ignore_loglevel is
    28					 present on the kernel command line.
    29	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

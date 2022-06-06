Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73953E8B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiFFKlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiFFKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:40:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC9631521
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654512058; x=1686048058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBOINfErOJIqGGYsvJJXD3GXR9aUYfYS+goj8jwst0E=;
  b=ZehzQrIgoTzQWpr/7vg2OIP6yLHrxsY4V/N64Vytmf53G6h9VYNafplI
   73WYt60W87roSLhUlXQKL19lR5bIAp0N8eQRfnJvlPIKio3htjGC1QgYE
   NhVdNywSvt4p2u+j+c8OnL0tehsQbn5qxXQvbonOkic3IsYykP0ktAKIb
   Ap2TzZ6yHh6HzvV3CNed4BSuw+EwjqRzmoTmLhlJEopJoWPh5683wnYlX
   TPA0fuqcqr2+oma27knLJdU1/lT7MVPQf9utQrT3LqBoNb0rcKA93hfSx
   amcHrUYSirYGyEt6LzCHCfS+/7TIr27pNMG7QSbnrpHnWsFgQcuebYri0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="264527539"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="264527539"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:40:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="682198188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:40:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyAAE-000UaM-TP;
        Mon, 06 Jun 2022 13:40:50 +0300
Date:   Mon, 6 Jun 2022 13:40:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] cpumask: Fix invalid uniprocessor mask assumption
Message-ID: <Yp3ZsoPV0yx2TKo3@smile.fi.intel.com>
References: <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
 <202206060858.wA0FOzRy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206060858.wA0FOzRy-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 08:48:05AM +0800, kernel test robot wrote:
> Hi Sander,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v5.18 next-20220603]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sander-Vanheule/cpumask-Fix-invalid-uniprocessor-assumptions/20220606-004959
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: i386-randconfig-a009 (https://download.01.org/0day-ci/archive/20220606/202206060858.wA0FOzRy-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/37b3f10c4604ea299b454f39ac5ba3cad903ae16
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Sander-Vanheule/cpumask-Fix-invalid-uniprocessor-assumptions/20220606-004959
>         git checkout 37b3f10c4604ea299b454f39ac5ba3cad903ae16
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: arch/x86/kernel/cpu/cacheinfo.o: in function `__cache_amd_cpumap_setup':
>    arch/x86/kernel/cpu/cacheinfo.c:890: undefined reference to `cpu_llc_shared_map'
> >> ld: arch/x86/kernel/cpu/cacheinfo.c:895: undefined reference to `cpu_llc_shared_map'

Seems like somewhere we need stubs for UP builds for those cache related functions.


-- 
With Best Regards,
Andy Shevchenko



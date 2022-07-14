Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC53575369
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiGNQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239323AbiGNQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:50:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE21570A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657817259; x=1689353259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQbUCbTF5bN5YXlUJjBzne8YWxIltuaGpmLmTVvbbvw=;
  b=VjRGoXOxS0QTKrPyES4scmr357E6SDYPDCMfoA7bMZHaw6bew9tXFhDZ
   t8S5c6vGgR7xi88Us6qyYYc/9Ph0ypywaB7SmM5FrrnIqYCSZaCnKsmWO
   q+FPJ8e5DDevLQFQS8z54g3IVMiSOKNo+KzQfsktoZ9N3Mp0aSA5FKyHp
   GlANfqBFhrPUqLstDzQz4X/K/3Bp/MobBzd2F5H3gCDaHVIfNCP+8AM+y
   qK+LNtBkD+00FmpsffzLrAhFBiVO4FCKyFnE4AqrbyHoh56PXA8NMl9Uh
   9NU2n+LW16nEZz3qf3f2qRmJ0I/QznyZTGUC9yPZ0oZYcjFBFhAV0hzqD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268598116"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="268598116"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:47:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="600189543"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:47:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oC1zw-001DWS-08;
        Thu, 14 Jul 2022 19:47:32 +0300
Date:   Thu, 14 Jul 2022 19:47:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/bitmap: Make count and length parameters unsigned
Message-ID: <YtBIo8XnDqchGhyk@smile.fi.intel.com>
References: <20220714164207.52410-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714164207.52410-1-pmenzel@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 06:42:07PM +0200, Paul Menzel wrote:
> Counts and the length are non-negative, so make them unsigned, and adapt the
> while condition in `__bitmap_set()` and `__bitmap_clear()` accordingly.
> 
> For `__bitmap_set()` six less intstructions are used as a result:

You may check this by doing

	make allyesconfig
	make
	cp vmlinux.o old
	# apply your patch
	make
	cp vmlinux.o new
	scripts/bloat-o-meter old new

-- 
With Best Regards,
Andy Shevchenko



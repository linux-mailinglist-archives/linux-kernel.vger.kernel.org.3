Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93B4A5973
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiBAJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:46:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:20243 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235864AbiBAJqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643708803; x=1675244803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hrU8xtXromvB6osPL/I7DAiqFwYf8gTY3wavqh3LUIw=;
  b=DWNzVevhwewbwJ+QMPIIB1RxkFZNReQVk4Nsz/ulA3k6CjyqnnZ8J4ak
   F1t+gC5Owith3ng5yHAL9m8fQul0JJPR0Yjx1LxQXbubIP7ZZ+NJV9qKS
   JPYDqpnzicVwPHrrCn4BP9oxHd+N6fozGdmZpG2kmDFIXaYhEXFyaolEk
   4FBkGNn5UeZU3CD05zYFaPTEMAmP8NbRxZqeirp7NjeKgW+UzqgOAWlb5
   1dTQ2L6jtYS5CwRwCUHLdYghFwEWGvJ9hQMeBQ94SSPKQ5HW/1yI4mqDB
   w0EwAW5u9VY5pD/4oo+x9CcYnshn7XhgohSj08rN5rBlY11eljl3jIEjW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227627700"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="227627700"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:46:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="479605353"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:46:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEpjE-00HFYx-Uh;
        Tue, 01 Feb 2022 11:45:36 +0200
Date:   Tue, 1 Feb 2022 11:45:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, mbenes@suse.cz, swboyd@chromium.org,
        ojeda@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH 1/1] kallsyms: print module name in %ps/S case when
 KALLSYMS is disabled
Message-ID: <YfkBQNBEPrAJ9jKw@smile.fi.intel.com>
References: <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcas5p1.samsung.com>
 <20220201040044.1528568-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201040044.1528568-1-maninder1.s@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:30:44AM +0530, Maninder Singh wrote:
> original:
> With KALLSYMS
>                    %pS                               %ps
> [16.4200]  hello_init+0x0/0x24 [crash]        hello_init [crash]
> 
> Without KALLSYMS:
> [16.2200]      0xbe200040                         0xbe200040
> 
> With Patch (Without KALLSYMS:) load address + current offset [Module Name]
> 
> [13.5993]  0xbe200000+0x40 [crash]           0xbe200000+0x40 [crash]
> 
> It will help in better debugging and checking when KALLSYMS is disabled,
> user will get information about module name and load address of module.
> 
> verified for arm64:
> / # insmod /crash.ko
> 
> [   19.263556] 0xffff800000ec0000+0x38 [crash]
> 
> ..
> 
> [   19.276023] Call trace:
> [   19.276277]  0xffff800000ec0000+0x28 [crash]
> [   19.276567]  0xffff800000ec0000+0x58 [crash]
> [   19.276727]  0xffff800000ec0000+0x74 [crash]
> [   19.276866]  0xffff8000080127d0
> [   19.276978]  0xffff80000812d95c
> [   19.277085]  0xffff80000812f554

> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Who is (are) the author(s)?

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920D4A8287
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiBCKlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:41:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:26135 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231717AbiBCKlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643884864; x=1675420864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oLUmTfZDsAWXmEeQWmWD3Qq4JViFB1KKg28eTNl8OUs=;
  b=deKyawh0TSBHvWKS+PVaJwWwb7nOptPo4eNQAvCr3RdKyQVDgOW2SZMK
   /zTCc7dNBYcwC9D0m8VJzAgmzRHPMl/tBXDL4Z47Q5XJHYBHF7Gs0ZlRX
   UnikL6eLVMocAdn8qdvRXnV3NvP4tNdlWSF+pAeBQN3PluEzcGVoswbPV
   4m5DV1bwRyQnd0hNGC5pxtdrdkrQYpGfc+ujP7ivBL8TmN+/Q+1eBGU4x
   rah9bDYwjTepm5xzSQUsFJvDjf8bW1Fq6/IydJJMAVHLyohKx0isQePOh
   P9rXGT/2agUw+FSvwibJoXBRfvAn3xI2ItpjftqpO6X2xxC4U5cX2ZhS+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228770745"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="228770745"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:41:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="498096024"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:41:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFZWz-000NUf-6O;
        Thu, 03 Feb 2022 12:40:01 +0200
Date:   Thu, 3 Feb 2022 12:40:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tty: Drop duplicate NULL check in TTY port
 functions
Message-ID: <YfuxANmSQDfIQZO4@smile.fi.intel.com>
References: <20220202165704.5680-1-andriy.shevchenko@linux.intel.com>
 <37e31d03-eee6-7052-fe32-1f37f1b460e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e31d03-eee6-7052-fe32-1f37f1b460e1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:36:55AM +0100, Jiri Slaby wrote:
> On 02. 02. 22, 17:57, Andy Shevchenko wrote:
> > The free_page(addr), which becomes free_pages(addr, 0) checks addr against 0.
> > No need to repeat this check in the callers, i.e.  tty_port_free_xmit_buf()
> > and tty_port_destructor().
> > 
> > Note, INIT_KFIFO() is safe without that check, because it's aware of kfifo PTR
> > versus embedded kfifo.
> 
> Not sure what you mean here ^^^? But it might be one of the morning brain
> parser errors.

Or maybe my evening weren't working...

Actually INIT_KFIFO() can be outside of that check from day 1 because it
operates on a separate member and does not rely on the FIFO itself to be
allocated.

I tried to explain that, while kfifo allocation goes together with buffer,
there is no dependency to any of those allocations.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89316497FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiAXMoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:44:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:1399 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239476AbiAXMom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643028282; x=1674564282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wpyH6xBCGYGqD5iKqVi6uZSO5z87rUEfXYqTwajDbh8=;
  b=eAzSfwKyXccveLYa+QvHHBQwqJeavLcx03qUeBSOYPreQc4fxHzgWRV0
   MMxKCm83b+F/MQ/0DhXN8cXXBbk5KvghiZkXSNSiG/mfzlOI6I1GGgRQB
   dNjYwMs6wSvaAGeK8P0dL8VJPrnUWdUM9E7882qgCMp46HzHn1nebwRz0
   q4Uzotu7Lklsg/CWjXV37vR26YBtzTAKL0wmMTvOPluGL98euWf7Zi4+M
   EEhbNymx1w9Maul8fr8Z31VLWNaDh74VFMlubmzU0uFy5On++JJEyvjS9
   VM+cga5A2xzSp6EWh2n6K/mA+IYaCK2mOIyAnnQB5gGTQ1mvlRNMSyUwf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243631494"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243631494"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:44:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562645121"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:44:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nByh0-00DtEW-O1;
        Mon, 24 Jan 2022 14:43:30 +0200
Date:   Mon, 24 Jan 2022 14:43:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/54] lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge,
 lt, le} functions
Message-ID: <Ye6e8lhJ5rLm+iDl@smile.fi.intel.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-28-yury.norov@gmail.com>
 <Ye6egq/6It3LZs19@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye6egq/6It3LZs19@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 02:41:38PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 23, 2022 at 10:38:58AM -0800, Yury Norov wrote:

...

> > +	if (num > (int)nbits || num < 0)
> 
> Wonder if
> 
> 	if (abs(num) > nbits)
> 
> would be sufficient.

Scratch it. Of course it won't work.

It may be other way around:

	if ((unsigned int)num > nbits)

> > +		return -num;

-- 
With Best Regards,
Andy Shevchenko



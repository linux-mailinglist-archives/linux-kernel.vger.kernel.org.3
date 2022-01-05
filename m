Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0294850D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiAEKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:14:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:50682 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239308AbiAEKOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641377686; x=1672913686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CorOv1Uxd9lqa1qzFSeslSw5o76pB5olzkwo5qw1u3U=;
  b=LLw2oEwxgnJBYynodkel0nd5LPa7ckxSJySrPrdvkcPP0Yudmd+KquSx
   mpORvjP7ptXr0YpPjGJoENDPEhyb50C1UznYnCNwfmEwzUcRrD2XILuvt
   LI5kwCDTJZZvsKVKDQJ7YhlNq1RddtF5yk0uWpZIoFQJdirKzNoEB3ARj
   Qcv0E6pT4Ht2ctYw4mj8XgPyq7fWLkyEWbY+YF8CnqUw9k4nLnJ3zFsCp
   JPya8hLDCFti3Pal3CwGL7MQWoyVCZxZ/skoGyvBgmtpDUUndDSdTqLqO
   wlNVxbnsZV50lR/mZB+nSMWLaPqVW6hH54s6zQmw+k6IB1h1JIEDNoC/l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239952731"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="239952731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 02:14:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="688927482"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 02:14:43 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Jan 2022 12:11:11 +0200
Date:   Wed, 5 Jan 2022 12:11:11 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] thunderbolt: Check for null pointer after calling
 kmemdup
Message-ID: <YdVuv9ZvYmmW1nQX@lahna>
References: <20220105085307.2410653-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105085307.2410653-1-jiasheng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 04:53:07PM +0800, Jiasheng Jiang wrote:
> On Wed, Jan 05, 2022 at 03:30:47PM +0800, Mika Westerberg wrote:
> > This is doing two things so I suggest sending two patches instead.
> 
> Fine, I have already sent the patch for icm_handle_event() independently.

Thanks!

> > However, for the UUID part, I think it works fine if we get NULL (and I
> > think kmemdup() issues warning too).
> >
> > There are probably not needed either since the "fix" here is for pretty
> > rare case of running out of memory. I think there is not even a NULL
> > pointer dereference because UUID is optional.
> 
> As for icm_icl_set_uuid(), I think the check for kmemdup() is needed.
> Because users need to know that icm_start() fails, or they will be puzzled
> why the uuid is unsetted.
> So at least it is a cleanup.
> if so, I would like to send patch for icm_icl_set_uuid() without fixes tag.

I don't think icm_start() actually fails because if this. If the UUID is
not set tb_switch_add() will look it up from the host router vendor area
then.

We can log a warning or something like that (but I think that's already
done in kmemdup()).

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5368748C62E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354165AbiALOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:40:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:62406 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344321AbiALOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641998398; x=1673534398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t9GZHV7SchHN++tiNyzKfQqOdxyRHDm0qiBtCg+J5Dc=;
  b=YzGPXmTh5y63jY0fJ81NORS5St3/zjgE+DfW2loB5Iv17znMJin0aoSi
   aF2NWspYtNRm3mN+0EfNFnwGRu1CcatYdEwKBu6t2qKLfddaDj1oW+1wu
   AjzAHTINV8KWLdL6Ot/QlJAPid0P6vx1JZuZzGG43Iv6NLGgFor1jj03s
   jO1ro5ykbPpf7TXQxUr+N0Qb5Rh6BHgShS9YKm4bR+OEZSBENni8xDfTb
   QKw21m2bXEkd4gYU1Xo40P3h7D/UhHmHq+ejp9a5J+eeou744y9VVcJcl
   FZBRxdOYo1gJ0i3ZoMDRDDsmrxHGl/+7s0I2NzxU2jRFPqzLq2q7Razsf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243948919"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243948919"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 06:39:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="490753046"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 06:39:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7elr-009ixQ-Te;
        Wed, 12 Jan 2022 16:38:39 +0200
Date:   Wed, 12 Jan 2022 16:38:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     QiuLaibin <qiulaibin@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com, martin.petersen@oracle.com, hare@suse.de,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
Message-ID: <Yd7n7xA9ecF1/0DK@smile.fi.intel.com>
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
 <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
 <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
 <Yd7J4XbkdIm52bVw@smile.fi.intel.com>
 <3d386998-d810-5036-a87e-50aba9f56639@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d386998-d810-5036-a87e-50aba9f56639@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:51:13PM +0000, John Garry wrote:
> On 12/01/2022 12:30, Andy Shevchenko wrote:
> > > > > +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> > > > > +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
> > > > Whoever wrote this code did too much defensive programming, because the first
> > > > conditional doesn't make much sense here. Am I right?
> > > > 
> > > I think because this judgement is in the general IO process, there are also
> > > some performance considerations here.
> > I didn't buy this. Is there any better argument why you need redundant
> > test_bit() call?
> 
> I think that the idea is that test_bit() is fast and test_and_set_bit() is
> slow; as such, if we generally expect the bit to be set, then there is no
> need to do the slower test_and_set_bit() always.

It doesn't sound thought through solution, the bit can be flipped in between,
so what is this all about? Maybe missing proper serialization somewhere else?

-- 
With Best Regards,
Andy Shevchenko



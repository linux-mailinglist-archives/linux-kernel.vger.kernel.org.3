Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32EE48C40A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353150AbiALMcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:32:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:52245 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240219AbiALMb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641990717; x=1673526717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBoOKXSUj7v7gJ89NZFrmu1XUSGgJkxV+aXq1SqTpog=;
  b=QIzgEbrt+srN7jM/E+ZWGv1wXNfpVtD9v1XrcArM8xOYNypkisPLY45+
   6n1F+Sx3Brh2j7/QzTDMRqRVzI95B6D2KOeISDp/1xXlo8YcCgVXHQOJ4
   mGQYfg9GQDb7Fz/qsCSiAmHZY7BFv0YKJF8ymZJ5fqa3yuvfXysgz9YuO
   Q/pRnhuER3KJ6L8t0vG2gRmJCpqDpJK7esd2ME93aEmN3cE4D62wzFdAw
   sCFITnB1QRy08BikP+RzdIt+1i3+rch2IchTauKsF9zyvS+aFovfWmMGW
   Og4nfXtrizzWUAr9yEmztpm+WwxAmTPaBeRuazFVxRU82kOmqbI3wUeFg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243923292"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243923292"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 04:31:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="691367878"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 04:31:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7clm-009gGJ-2T;
        Wed, 12 Jan 2022 14:30:26 +0200
Date:   Wed, 12 Jan 2022 14:30:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     QiuLaibin <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, john.garry@huawei.com,
        martin.petersen@oracle.com, hare@suse.de,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
Message-ID: <Yd7J4XbkdIm52bVw@smile.fi.intel.com>
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
 <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
 <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:18:53PM +0800, QiuLaibin wrote:
> On 2022/1/11 22:15, Andy Shevchenko wrote:
> > On Tue, Jan 11, 2022 at 10:02:16PM +0800, Laibin Qiu wrote:

...

> > > +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> > > +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
> > 
> > Whoever wrote this code did too much defensive programming, because the first
> > conditional doesn't make much sense here. Am I right?
> > 
> I think because this judgement is in the general IO process, there are also
> some performance considerations here.

I didn't buy this. Is there any better argument why you need redundant
test_bit() call?

> > > +			return true;

> > >   	} else {
> > 
> > > +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
> > > +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
> > 
> > Ditto.
> > 
> > > +			return true;

> > >   	}

...

> > > +	unsigned int wake_batch = clamp_t(unsigned int,
> > > +			(sbq->sb.depth + users - 1) / users, 4U, SBQ_WAKE_BATCH);
> > 
> > 
> > 	unsigned int wake_batch;
> > 
> > 	wake_batch = clamp_val((sbq->sb.depth + users - 1) / users, 4, SBQ_WAKE_BATCH);
> > 	...
> > 
> > is easier to read, no?
> 
> Here I refer to the calculation method in sbq_calc_wake_batch(). And I will
> separate the definition from the calculation in V5.

I'm not sure I understand how it's related to the style changes I proposed.
I haven't changed any logic behind.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3448C888
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355322AbiALQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:34:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:39139 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349883AbiALQea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642005270; x=1673541270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aod0rESj2tmUNh9cIi6+7c8/Hjx+ItwzShrZRDcswhk=;
  b=EQGuLpQZGM30CypeAZ8hVJdNwOHFiOrPNRC1FvE/djJyXT1l4/IwBkSF
   OOt4589V3gI4l2WKHdaVG7we8naNA+qgKyvMJ9xBfFqqI7MextbxghmVf
   AESIu8BrB2g6+AekJSXSgRk0mQpbWyzPFq11+bRv96BdNuQQmCg0+iCPV
   RydFjUf6Bnch4xe8WIwjyzWb0PtVXp/+81z9czi7i1ASNMf+6prz0uGay
   kbLOEM8Z/lR60V8opjHd5qW2RBRPWOdcuiUuhj4ZWB1lQzki9uzFfpcVy
   xzKuJTWgKb79+7PjO9a5lWIbAtemVMPk3VmUGej1J/6iOxA38jbjN7BvI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243731263"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243731263"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 08:30:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="558757670"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 08:30:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7gV6-009lDe-RR;
        Wed, 12 Jan 2022 18:29:28 +0200
Date:   Wed, 12 Jan 2022 18:29:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     John Garry <john.garry@huawei.com>,
        QiuLaibin <qiulaibin@huawei.com>, ming.lei@redhat.com,
        martin.petersen@oracle.com, hare@suse.de,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
Message-ID: <Yd8B6F/6fW5DqxOl@smile.fi.intel.com>
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
 <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
 <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
 <Yd7J4XbkdIm52bVw@smile.fi.intel.com>
 <3d386998-d810-5036-a87e-50aba9f56639@huawei.com>
 <Yd7n7xA9ecF1/0DK@smile.fi.intel.com>
 <03a3bece-12d7-6732-9b80-a008a86320ba@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a3bece-12d7-6732-9b80-a008a86320ba@kernel.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:37:34AM -0700, Jens Axboe wrote:
> On 1/12/22 7:38 AM, Andy Shevchenko wrote:
> > On Wed, Jan 12, 2022 at 12:51:13PM +0000, John Garry wrote:
> >> On 12/01/2022 12:30, Andy Shevchenko wrote:
> >>>>>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> >>>>>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
> >>>>> Whoever wrote this code did too much defensive programming, because the first
> >>>>> conditional doesn't make much sense here. Am I right?
> >>>>>
> >>>> I think because this judgement is in the general IO process, there are also
> >>>> some performance considerations here.
> >>> I didn't buy this. Is there any better argument why you need redundant
> >>> test_bit() call?
> >>
> >> I think that the idea is that test_bit() is fast and test_and_set_bit() is
> >> slow; as such, if we generally expect the bit to be set, then there is no
> >> need to do the slower test_and_set_bit() always.
> > 
> > It doesn't sound thought through solution, the bit can be flipped in
> > between, so what is this all about? Maybe missing proper serialization
> > somewhere else?
> 
> You need to work on your communication a bit - if there's a piece of
> code you don't understand, maybe try being a bit less aggressive about
> it? Otherwise people tend to just ignore you rather than explain it.

Sure. Thanks for below explanations, btw.

> test_bit() is a lot faster than a test_and_set_bit(), and there's no
> need to run the latter if the former returns true. This is a pretty
> common optimization, particularly if the majority of the calls end up
> having the bit set already.

I don't see how it may give optimization here generally speaking.
If we know that bit is _often_ is set, than of course it sounds
like opportunistic win. Otherwise, it may have the opposite effect.

I.o.w. without knowing the statistics of the bit being set/clear it's
hard to say if it's optimization or waste of the (CPU) resources.

> Can the bit be flipped right after? Certainly! Can that happen if just
> test_and_set_bit() is used? Of course! This isn't a critical section
> with a lock, it's a piece of state. And guarding the RMW operation with
> a test first doesn't change that one bit.

-- 
With Best Regards,
Andy Shevchenko



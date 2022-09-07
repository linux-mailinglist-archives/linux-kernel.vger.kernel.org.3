Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333175B0631
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiIGONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIGONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D65AC68;
        Wed,  7 Sep 2022 07:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E892618CE;
        Wed,  7 Sep 2022 14:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577B8C433D6;
        Wed,  7 Sep 2022 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662560024;
        bh=G7sNlAT/9ttqzV5G1/k/jJxd38B3paO9wVIuwV47joc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1voks6onfsrR2ymkLhm3z1ZMMx6y/VVYD1Z+26FYPnYrxTMgy3dx2U7DGRMlrP0Y
         dttz8jmcLU5E0vdntpfBC4bMZdMDl2h2NsNsHQ5+PKCv6t+LjpvyjqIBvCiUsx4cNd
         WK5BH+gLctO4zPXor876Wtqog4a061RKOf612JKdVdFDLNfbsBFM5F/Pwa1miRyS5L
         4c2tlkFP87gO5Hys4nxD8FP/SIChW9Y+1cmEe3kkWXcX5hv8/QTn5ivVGL1ihxrmCX
         DhuykyBHUZ/uC1j+LUONzz7B/IfEffY3Y6BqVyToEL0qklFpfvSMD2EsV97Eb/ojlA
         3Hny+Uj/F944A==
Date:   Wed, 7 Sep 2022 08:13:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Message-ID: <YxinFEYRCU/QuQ5w@kbusch-mbp.dhcp.thefacebook.com>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
 <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
 <20220907102318.pdpzpmhah2m3ptbn@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907102318.pdpzpmhah2m3ptbn@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 12:23:18PM +0200, Jan Kara wrote:
> On Tue 06-09-22 15:27:51, Keith Busch wrote:
> > On Wed, Aug 03, 2022 at 08:15:04PM +0800, Yu Kuai wrote:
> > >  	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> > > -	if (wait_cnt <= 0) {
> > > -		int ret;
> > > +	/*
> > > +	 * For concurrent callers of this, callers should call this function
> > > +	 * again to wakeup a new batch on a different 'ws'.
> > > +	 */
> > > +	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
> > > +		return true;
> > 
> > If wait_cnt is '0', but the waitqueue_active happens to be false due to racing
> > with add_wait_queue(), this returns true so the caller will retry.
> 
> Well, note that sbq_wake_ptr() called to obtain 'ws' did waitqueue_active()
> check. So !waitqueue_active() should really happen only if waiter was woken
> up by someone else or so. Not that it would matter much but I wanted to
> point it out.
> 
> > The next atomic_dec will set the current waitstate wait_cnt < 0, which
> > also forces an early return true. When does the wake up happen, or
> > wait_cnt and wait_index get updated in that case?
> 
> I guess your concern could be rephrased as: Who's going to ever set
> ws->wait_cnt to value > 0 if we ever exit with wait_cnt == 0 due to
> !waitqueue_active() condition?
> 
> And that is a good question and I think that's a bug in this patch. I think
> we need something like:
> 
> 	...
> 	/*
> 	 * For concurrent callers of this, callers should call this function
> 	 * again to wakeup a new batch on a different 'ws'.
> 	 */
> 	if (wait_cnt < 0)
> 		return true;
> 	/*
> 	 * If we decremented queue without waiters, retry to avoid lost
> 	 * wakeups.
> 	 */
> 	if (wait_cnt > 0)
> 		return !waitqueue_active(&ws->wait);

I'm not sure about this part. We've already decremented, so the freed bit is
accounted for against the batch. Returning true here may double-count the freed
bit, right?
 
> 	/*
> 	 * When wait_cnt == 0, we have to be particularly careful as we are
> 	 * responsible to reset wait_cnt regardless whether we've actually
> 	 * woken up anybody. But in case we didn't wakeup anybody, we still
> 	 * need to retry.
> 	 */
> 	ret = !waitqueue_active(&ws->wait);
> 	wake_batch = READ_ONCE(sbq->wake_batch);
> 	/*
> 	 * Wake up first in case that concurrent callers decrease wait_cnt
> 	 * while waitqueue is empty.
> 	 */
> 	wake_up_nr(&ws->wait, wake_batch);
> 	...
> 
> 	return ret;
> 
> Does this fix your concern Keith?

Other than the above comment, this does appear to address the concern. Thanks!

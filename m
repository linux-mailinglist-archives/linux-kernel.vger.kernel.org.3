Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326F24EBFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbiC3L3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbiC3L3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:29:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26115B05C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE065615A5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B326BC340EC;
        Wed, 30 Mar 2022 11:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648639675;
        bh=D6D5nXz50cA2W5sgoG/DWkgMZtLYEjr7AO6I5vD8RO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4vspUpy8NMs5oyemgwq73A+GhuI4mpJqy810T/AXj6dO1mh+M+ZBxR3actWXrp0X
         Bk/WSkIzyYbxDJogDF38QNm7xnp3U9dZ+0myH4QP9XKbe7++LP+Ul3L4m+ttNVmCDN
         gPjInLCjStjWA5QUsqW0jRIQ9BJ7sGCIb0V2dx0pdXc/jhj5p3c5LJeTt8/ff8skjF
         2vZa8mGNv12Ohz6D4oOeTuGrTknHoF/MG9hd5QCwLuUMwD7DXWqP3scgnL0H9WZPAG
         tNfKFqeSaI20mSrTzUp0P54N4tmDUVDshccEQa3Qxy441feGpyElBo+Q+9pr7JPa2d
         VdUTy9u1UR/UQ==
Date:   Wed, 30 Mar 2022 13:27:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] rcu: No need to reset the poll request flag before
 completion
Message-ID: <20220330112752.GA1245830@lothringen>
References: <20220316144255.336021-1-frederic@kernel.org>
 <20220316144255.336021-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316144255.336021-3-frederic@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:42:53PM +0100, Frederic Weisbecker wrote:
> The flag allowing to requeue the polling work is reset before the
> polling even starts. However there is no point in having two competing
> polling on the same grace period. Just reset the flag once we have
> completed the grace period only.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_exp.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index b6fd857f34ba..763ec35546ed 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -911,7 +911,6 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
>  
>  	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
>  	s = rnp->exp_seq_poll_rq;
> -	rnp->exp_seq_poll_rq |= 0x1;

On a second (or actually twentieth) thought, this patch and all those following
make wrapping issues more likely:

* Before this patch, wrapping occuring *after* the 0x1 is set on the beginning
  of the workqueue is fine. The last vulnerable wrapping scenario is when
  the wrapping happens before we reach the beginning of the workqueue
  execution that sets the 0x1, so the work may happen not to be queued.


* After this patch, wrapping occuring *before* the GP completion in the
  workqueue will be ignored and fail. Still unlikely, but less unlikely than
  before this patch.

So please revert this series. Only the first patch "rcu: Remove needless polling
work requeue for further waiter" still seem to make sense.

Thanks.

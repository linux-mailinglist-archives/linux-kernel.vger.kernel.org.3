Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30B4DCA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiCQPfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiCQPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:35:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4AF1788EA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59818B81F01
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F3DC340E9;
        Thu, 17 Mar 2022 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647531236;
        bh=TMJ/fQxoE5x1D/yJMBmQ7AuOWquE2zVSEVfwHsu3aeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtLfK/S82sWqLgPnYxHtlxLH2F4vNU7EaWuxvOQqZmH39k60ZfGjkrdyzskvQsyXQ
         rTWraBRX808/yxa9867NNMxT50jSplQF3Yz0ueb8hqrpMyDkoW+V9TA+8siiGCOOit
         bW2t/VQ6pGGMiFY+kAfnUhS9iF0lyalbZTyl7rtu9tUg5q3UkCxFvOBVP2/Qm0WGIn
         z7YS675sygqiTL/Zpo5uge5QLIw3zD0rU6oTugU99MVkpZcYO8xKsWPQ6DGNKkosi/
         lz3yTCpJn7smeibQvojf8/Oleeb9iSPA67BEJDuzcMSxHLcup/luo1hUfq8TSI0to7
         UbgmyK/J6vg4w==
Date:   Thu, 17 Mar 2022 16:33:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 4/4] rcu: Name internal polling flag
Message-ID: <20220317153353.GA463481@lothringen>
References: <20220316144255.336021-1-frederic@kernel.org>
 <20220316144255.336021-5-frederic@kernel.org>
 <c0845c3d-fe96-857a-df72-c5d1e35f8e7f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0845c3d-fe96-857a-df72-c5d1e35f8e7f@quicinc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:12:17PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 3/16/2022 8:12 PM, Frederic Weisbecker wrote:
> > Give a proper self-explanatory name to the expedited grace period
> > internal polling flag.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > ---
> >   kernel/rcu/rcu.h      | 5 +++++
> >   kernel/rcu/tree.c     | 2 +-
> >   kernel/rcu/tree_exp.h | 9 +++++----
> >   3 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index eccbdbdaa02e..8a62bb416ba4 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -30,6 +30,11 @@
> >   #define RCU_GET_STATE_USE_NORMAL	0x2
> >   #define RCU_GET_STATE_BAD_FOR_NORMAL	(RCU_GET_STATE_FROM_EXPEDITED | RCU_GET_STATE_USE_NORMAL)
> > +/*
> > + * Low-order bit definitions for polled grace-period internals.
> > + */
> > +#define RCU_EXP_SEQ_POLL_DONE 0x1
> 
> From what I understood, this flag is intended for lifecycle management
> of the ->exp_seq_poll_rq; with the flag set meaning that we need to re-poll,
> which could be used for cases, where there is long gap between 2 polls, such
> that the sequence wraps around. So, maybe we can name it as
> RCU_EXP_SEQ_POLL_EXPIRED? However, my understanding could be wrong here.

It may be confusing also because this patchset slightly extends the role of this
bit.

Before the patchset, the role is indeed to deal with wrapping.
After the patchset it deals with wrapping and the polling cycle.

I would say that before the patchset, the name could be RCU_EXP_SEQ_POLLABLE,
and after the patchset it can indeed be RCU_EXP_SEQ_POLL_EXPIRED.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F256AB7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiGGTFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiGGTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:05:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0ED20F4C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:05:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c13so24137938qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lj/5GKFD5bSgxpfgMiLIINDbLK3iL7GVnVF/8eyegVw=;
        b=O4PlJ4svdXAIysmorR7JS4m/B96kCMpmsXE6LPvC+47wcLRxPPo5DtZx2M8IJ05dF1
         kxc6yI3WoB4LR6+/t0Qz3hdkwJbV66VeOVNdcOVTwMvSFNFADgM3+vgRsTnbtR/zTDoU
         UFj2njpI0lZE/VkR5wgPReMyxtuCqYX6gWYghXFMfAOY0jDs9DpzQRDgAUxPaI/Eo7LX
         xdRr/RyxdIrM16+HrUmKUliqfue1csAHy1W8/l2Z06onE9x/t1stCEo/1+9whQe3Uie5
         5SklEoeNRt2Bh8rSn6YEv7b+lGBWYMnspBuEIUOLh5SNMgL+SMBB8SvGP/8+Qb6g4PoP
         uoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Lj/5GKFD5bSgxpfgMiLIINDbLK3iL7GVnVF/8eyegVw=;
        b=5hfqvH/LfxzPo4bgNDj/Go9QpmMYgxjDLNrTEkv5pz2adkUaC7gd8YqhpComrblaDG
         DcnoFZlIDhWIJOwMvLCtFs8+WEYq+HNBOLsbkqFAmwJ9lXRbN/Jj0NV2GNA51yrl0/RD
         9aoXp+qWQOePyo8ut9RJaWs6nX1HxQtJr4SViuQ8UL69mgFWSfIDzgVdjl9ZvCWnvZeO
         C/iEExb6LTCoujpc0wMKp4IvtS8CkHoMemvW5PEPZ6q9m/I3ijSjL0bc2nPco693Qce9
         t7hxa5aPD+mxUu8FpoDM41skS4QNiuBnmL7VFNXF1kkD9xn95fqlIqsyl4QNx69sZ1vS
         TpUA==
X-Gm-Message-State: AJIora9bER1ngEgtS7QLLxNiQMFgaFhc/KvERlBLWoULGpT3uOo+r52K
        RKai9vl+1HMuagTEhymsUcM=
X-Google-Smtp-Source: AGRyM1sO8AvonfwY2omtTjp2x8IDHAvMXLJO2E4fkgdZv2PioOUj91/iavqaq166MECHSRkRtylLsA==
X-Received: by 2002:ac8:5801:0:b0:31d:4c67:6f3 with SMTP id g1-20020ac85801000000b0031d4c6706f3mr19703387qtg.46.1657220709996;
        Thu, 07 Jul 2022 12:05:09 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8124b000000b0031ea1dd67d9sm408611qtj.14.2022.07.07.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:05:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C031927C005A;
        Thu,  7 Jul 2022 15:05:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Jul 2022 15:05:08 -0400
X-ME-Sender: <xms:ZC7HYrAosqjp1aq1yXOI7lTbd7lTnmznBHmbBr_voS4G-ndF4GD6Vw>
    <xme:ZC7HYhiPn05gmxutH9ii--tw1I0k7gaI0WLCIIBz2cRbX2yXdEYH2yhiWlJecX1n5
    NnjXlv_D4SiN35Www>
X-ME-Received: <xmr:ZC7HYmnV_4XGdBnzIOYef_gUQdktfEokq8vdC8sHV1v8US3e93J0vVxa6Oxt8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeihedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ZC7HYtyfWffvZQgCciFlzclSFDbd7CyA5zaBI2UBWTPtxHghKyitgg>
    <xmx:ZC7HYgR93DkrOpgtJ6PIhsKT6qBgDH3wfaHTH9qZ6OtEkLOPl4dIiw>
    <xmx:ZC7HYgZvyfNp1dViHWX2gSrWrqUuF_ghjNIzQDaPpWCGHw20sdea8Q>
    <xmx:ZC7HYjHq4lDtekpeorg86l861XNv0KO0jyGOyI5SiVgr7dXSIUDGCA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Jul 2022 15:05:08 -0400 (EDT)
Date:   Thu, 7 Jul 2022 12:04:12 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH v3] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Message-ID: <YscuLP2PuMEnMh35@boqun-archlinux>
References: <20220706135916.980580-1-longman@redhat.com>
 <f3051cbb-313c-ba88-66c9-3f8f8d88d806@redhat.com>
 <YsckV+iWLxPC+eH5@boqun-archlinux>
 <3e43bc07-053f-80d0-7ea1-93a2897ef03e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e43bc07-053f-80d0-7ea1-93a2897ef03e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:45:10PM -0400, Waiman Long wrote:
> On 7/7/22 14:22, Boqun Feng wrote:
> > On Wed, Jul 06, 2022 at 10:03:10AM -0400, Waiman Long wrote:
> > > On 7/6/22 09:59, Waiman Long wrote:
> > > > Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
> > > > stealing") allows unlimited number of lock stealing's for non-RT
> > > > tasks. That can lead to lock starvation of non-RT top waiter tasks if
> > > > there is a constant incoming stream of non-RT lockers. This can cause
> > > > rcu_preempt self-detected stall or even task lockup in PREEMPT_RT kernel.
> > > > For example,
> > > > 
> > > > [77107.424943] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > > [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
> > > > 
> > > > Avoiding this problem and ensuring forward progress by limiting the
> > > > number of times that a lock can be stolen from each waiter. This patch
> > > > sets a threshold of 32. That number is arbitrary and can be changed
> > > > if needed.
> > > > 
> > > > Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
> > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > > ---
> > > >    kernel/locking/rtmutex.c        | 9 ++++++---
> > > >    kernel/locking/rtmutex_common.h | 8 ++++++++
> > > >    2 files changed, 14 insertions(+), 3 deletions(-)
> > > > 
> > > >    [v3: Increase threshold to 32 and add rcu_preempt self-detected stall]
> > > Note that I decided to increase the threshold to 32 from 10 to reduce the
> > > potential performance impact of this change, if any. We also found out that
> > > this patch can fix some of the rcu_preempt self-detected stall problems that
> > > we saw with the PREEMPT_RT kernel. So I added that information in the patch
> > > description.
> > > 
> > Have you considered (and tested) whether we can set the threshold
> > directly proportional to nr_cpu_ids? Because IIUC, the favorable case
> > for lock stealing is that every CPU gets a chance to steal once. If one
> > CPU can steal twice, 1) either there is a context switch between two
> > tasks, which costs similarly as waking up the waiter, or 2) a task drops
> > and re-graps a lock, which means the task wants to yield to other
> > waiters of the lock.
> 
> There is no inherent restriction on not allowing the same cpu stealing the
> lock twice or more. With rtmutex, the top waiter may be sleeping and the

Well, I'm not saying we need to restrict the same cpu to steal a lock
twice or more. Think about this, when there is a task running on CPU 1
already steals a lock once, for example:

	<lock release>
	{task C is the top waiter}

	CPU 1
	=====
	<now task A running>
	lock(); // steal the lock
	...
	unlock():
	  // set owner to NULL
	  <switch task B> // similar cost to wake up A
	  lock(); // steal the lock

, which means if a CPU steals a lock twice or more, it's almost certain
that a context happened between two steals ("almost" because there could
be a case where task A lock()+unlock() twice, but as I said, it
means that task A is willing to yield.).

Therefore if there are @nr_cpu_ids lock steals, it means either there is
a context switch somewhere or a task has been willing to yield. And I
think it's a reasonable signal to stop lock stealing.

Thoughts?

Regards,
Boqun

> wakeup latency can be considerable. By allowing another ready lock waiter to
> steal the lock for productive use, it can improve system throughput. There
> is no fairness in lock stealing and I don't believe it is a worthwhile goal
> to allow each cpu to steal the lock once. It will just complicate the code.
> 
> On the other hand, unlimited lock stealing is bad and we have a put a limit
> somehow to ensure forward progress.
> 
> Cheers,
> Longman
> 

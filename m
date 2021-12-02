Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE3466994
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376566AbhLBSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:06:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36436 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376542AbhLBSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:06:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0271B82457;
        Thu,  2 Dec 2021 18:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD41C00446;
        Thu,  2 Dec 2021 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638468201;
        bh=fLX8yTzi3C/MVxPPHtVZDC60kahx5AF+GQ/U6puoweo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXUPjA1BPkcPaei7ZKfsPCzloH6n5iPQxgfZ/u7AIq4V8VFWBB7PZ6I8AQG8Nii/A
         woMeQzLyG5FNCBXCKb7/kh1aVP14NlF0AO9H8o5jPxtl5Bbr/yx1mipIfaqMXhtoft
         WuwmHbiTI5vCPhyUPEzkAK6+xtV09hmzyjRAlZXl8oYp5X5JcKPylc4nDB97XULByc
         lDzwEa/ylvGMjkrv8TAN1EpgYsIudakWLbpQL5q6B7dkHYe80vLZFuTA/BfooS6r9G
         +fBaoPF842UoIeMKBIp3dw0rXIZjZQrKEcP+Lfgl7OYlSLpTGAfk+/lBXBj0xDU/P1
         5H5aeInfEKvTg==
Date:   Thu, 2 Dec 2021 19:03:18 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/6] rcu/nocb: Create kthreads on all CPUs if "rcu_nocb="
 or "nohz_full=" are passed
Message-ID: <20211202180318.GC648659@lothringen>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-5-frederic@kernel.org>
 <5010f7fa-faf4-1857-81d7-36cc08956f49@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5010f7fa-faf4-1857-81d7-36cc08956f49@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 02:57:18PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/23/2021 6:07 AM, Frederic Weisbecker wrote:
> > In order to be able to (de-)offload any CPU using cpuset in the future,
> > create a NOCB kthread for all possible CPUs. For now this is done only
> > as long as the "rcu_nocb=" or "nohz_full=" kernel parameters are passed
> > to avoid the unnecessary overhead for most users.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > ---
> 
> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> 
> >   kernel/rcu/tree_nocb.h | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index d8ed3ee47a67..9d37916278d4 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1229,11 +1229,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
> >   	struct rcu_data *rdp_gp;
> >   	struct task_struct *t;
> > -	/*
> > -	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
> > -	 * then nothing to do.
> > -	 */
> > -	if (!rcu_is_nocb_cpu(cpu) || rdp->nocb_cb_kthread)
> 
> As rcu_is_nocb_cpu() does not have a user, we can probably remove it?

Ah nice, I'll check that.

Thanks!

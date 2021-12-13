Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95AF472B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhLMLWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhLMLWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:22:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC81C061574;
        Mon, 13 Dec 2021 03:22:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3029CE1006;
        Mon, 13 Dec 2021 11:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9DDC34602;
        Mon, 13 Dec 2021 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639394569;
        bh=e31rACSDwO09OV+OGZVlhs9MP9neG53Vroa0SKMJkks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnv1lzRaZZWjsJ6fRNHwiwJqrcIJQC8xMnrfW3f0tYudpZ07TbSiqje0RxZdpnvTG
         bwOt3ppt/BbPcWBJN5LFpxwaiqqzbe+qVHCA5Y3f5mGbISc1exKyY79eyUQGJJP2Hh
         kuiHOcNy2AQLfEARu3R2HsNxl60gL9E32NCMrfkox6QQyQ72nNZFFQNoRiko8lB37j
         m80kIREUDpQd1I0IvzJ1KSXQGGbF/iriTK300hPvvi1Lb3CRizsRGsao+Q4AHxe0zN
         3sAVUekYmLO2I0DDUTN/c3UOcACRnf8lTOzbHANgHm6LHACL9HJVLMW5x94cVzf/us
         QqmtKLDaa+Xng==
Date:   Mon, 13 Dec 2021 12:22:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        boqun.feng@gmail.com
Subject: Re: [PATCH v2] rcu/nocb: Handle concurrent nocb kthreads creation
Message-ID: <20211213112246.GA782195@lothringen>
References: <20211211170139.27711-1-quic_neeraju@quicinc.com>
 <6c184b9ffc5c641736d53bb7598f814d6b4c3fe0.camel@infradead.org>
 <601ecb12-ae2e-9608-7127-c2cddc8038a6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <601ecb12-ae2e-9608-7127-c2cddc8038a6@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:25:30PM +0530, Neeraj Upadhyay wrote:
> Hi David,
> 
> Thanks for the review; some replies inline.
> 
> On 12/13/2021 1:48 PM, David Woodhouse wrote:
> > On Sat, 2021-12-11 at 22:31 +0530, Neeraj Upadhyay wrote:
> > > When multiple CPUs in the same nocb gp/cb group concurrently
> > > come online, they might try to concurrently create the same
> > > rcuog kthread. Fix this by using nocb gp CPU's spawn mutex to
> > > provide mutual exclusion for the rcuog kthread creation code.
> > > 
> > > Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > ---
> > > Change in v2:
> > >   Fix missing mutex_unlock in nocb gp kthread creation err path.
> > 
> > I think this ends up being not strictly necessary in the short term too
> > because we aren't currently planning to run rcutree_prepare_cpu()
> > concurrently anyway. But harmless and worth fixing in the longer term.
> > 
> > Although, if I've already added a mutex for adding the boost thread,
> > could we manage to use the *same* mutex instead of adding another one?
> > 
> 
> Let me think about it; the nocb-gp and nocb-cb kthreads are grouped based on
> rcu_nocb_gp_stride; whereas, boost kthreads are per rnp. So, I need to see
> how we can use a common mutex for both.
> 
> 
> > Acked-by: David Woodhouse <dwmw@amazon.co.uk>
> > +                       mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> > >                          return;
> > > +               }
> > >                  WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
> > >          }
> > > +        mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> > > 
> > >          /* Spawn the kthread for this CPU. */
> > 
> > Some whitespace damage there.
> 
> Will fix in next version.

I was about to ack the patch but, should we really add code that isn't going to
be necessary before a long while?

Thanks!


> 
> Thanks
> Neeraj
> 
> > 

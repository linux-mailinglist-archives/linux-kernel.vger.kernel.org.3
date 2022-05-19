Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51C52DF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiESV3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiESV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889C6E8CD
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5096182F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2ADC385B8;
        Thu, 19 May 2022 21:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652995780;
        bh=A4UO2mkv0gXLuuIYXOlq70yi5YlkbdD2b9NHw2O/2M0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kn2mVWy0gz+IH88Sj26CuNophm3JYrrgTa+fIUGETV9Fv3IiZ29oSD9xQ7zYxVuE8
         rOrgqKETiCpm3vi2cK84V2+sBSxKoSsXsqoRdJAONK/tyPXmzEJeJdyJJPILUeGdAi
         YYNgqS8rZIGv+5GTKVa9dVSFAF7OXa9LKDoUzPXdzIY5+t/JYkI8scrldI8Mjbz0+7
         wkGr+y/beCKgpc7aQDxv7v2WD1GID9eL80cdn+2IkBnbc+ELhXt+qmGopazU1xzapL
         o1g+TFUnWfDiab6cWPzJWS/0yNXqX2W6MZgqxUKNnQM05BOoOYPoeBD2Zrc5H2PDFU
         XdcgxU/Rz2Mmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 05B325C04E0; Thu, 19 May 2022 14:29:40 -0700 (PDT)
Date:   Thu, 19 May 2022 14:29:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kafai@fb.com, kpsingh@kernel.org
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <20220519212939.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220517233507.GA423@qian>
 <20220518125152.GQ3441@techsingularity.net>
 <YoUealVA1bMaSH2l@qian>
 <20220518171503.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YoZGSd6yQL3EP8tk@qian>
 <20220519191524.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <YoaxAMvQwHzDPxyi@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoaxAMvQwHzDPxyi@qian>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:05:04PM -0400, Qian Cai wrote:
> On Thu, May 19, 2022 at 12:15:24PM -0700, Paul E. McKenney wrote:
> > Is the task doing offline_pages()->synchronize_rcu() doing this
> > repeatedly?  Or is there a stalled RCU grace period?  (From what
> > I can see, offline_pages() is not doing huge numbers of calls to
> > synchronize_rcu() in any of its loops, but I freely admit that I do not
> > know this code.)
> 
> Yes, we are running into an endless loop in isolate_single_pageblock().
> There was a similar issue happened not long ago, so I am wondering if we
> did not solve it entirely then. Anyway, I will continue the thread over
> there.
> 
> https://lore.kernel.org/all/YoavU%2F+NfQIzQiDF@qian/

I do know that feeling.

> > Or is it possible that reverting those three patches simply decreases
> > the probability of failure, rather than eliminating the failure?
> > Such a decrease could be due to many things, for example, changes to
> > offsets and sizes of data structures.
> 
> Entirely possible. Sorry for the false alarm.

Not a problem!

> > Do you ever see RCU CPU stall warnings?
> 
> No.

OK, then perhaps a sequence of offline_pages() calls.

Hmmm...  The percpu_up_write() function sets ->block to zero before
awakening waiters.  Given wakeup latencies, might this allow an only
somewhat unfortunate sequence of events to allow offline_pages() to
starve readers?  Or is there something I am missing that prevents this
from happening?

							Thanx, Paul

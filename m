Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E950E4CD916
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiCDQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbiCDQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:27:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3675B1CA5DD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:26:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F6C61D95
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 16:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D54C340E9;
        Fri,  4 Mar 2022 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646411205;
        bh=KwzhSJxBdv5KQKybOKyJW0n62ByMdL3HBmqQOycpsF8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uwq46pgR1rNb1QAbr4POh0p2HWLOi752br42W3ptDZc2YHJs9a3KuZtftXMXkXd4s
         UxLG7iWNx9Jch04QPy65TByJTuQSUXhmc5eBP1EjgItQFR2T4gPJDHUW6NZCZmxOEo
         hNS66ptBc8X79NEK8A4AjbuCm3YsxvCslCxRTVT67ua1OS1jvF+7eg9HlYh2pQC51V
         7QPBSiCea/TnlIq0VQyR+sYBhmH8j1i9LHM2D0b0QhvpYhlBwDcqkvzc+xq8/BmCzl
         MSNcpPp3pSNQJUbFt9vhMA31f+N7JhE1/2RmzutfUIGctSMfCqHzqkl+Ls+ci6nUrT
         bJID6LnelUqJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D336F5C0ADD; Fri,  4 Mar 2022 08:26:44 -0800 (PST)
Date:   Fri, 4 Mar 2022 08:26:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        rostedt@goodmis.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Message-ID: <20220304162644.GO4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
 <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
 <abb789c3-0d1a-28e9-3b8d-e4a68e3f57f5@kernel.org>
 <2b47679c6248a0d113b556ed6118e8ed72c74b29.camel@redhat.com>
 <bc048c18-0ba7-1cb9-90a0-0bc049997c23@kernel.org>
 <34833549a995fa3325f4ceb9b42cd01de0921c14.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34833549a995fa3325f4ceb9b42cd01de0921c14.camel@redhat.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:55:06PM +0100, Nicolas Saenz Julienne wrote:
> On Fri, 2022-03-04 at 16:37 +0100, Daniel Bristot de Oliveira wrote:
> > On 3/4/22 16:28, Nicolas Saenz Julienne wrote:
> > > Some comments:
> > >  - You're not exiting/entering EQS on IRQ/NMI entry/exit. See
> > >    irqentry_{enter,exit}() and irqentry_nmi_{enter,exit}().
> > 
> > hummm, right!
> > 
> > >  - See this series[1], if we ever pursue this approach, it's important we got
> > >    through context tracking, instead of poking at RCU directly.
> > 
> > I had a test patch with context_tracking as well... entering and leaving using
> > it. Lemme find it.... but it basically works in the same way as for RCU (or
> > pretend to work).
> 
> Yes, agree, it's fundamentally the same.

And there is work in flight to make it even more the same.  ;-)

https://lore.kernel.org/all/20220302154810.42308-1-frederic@kernel.org/

							Thanx, Paul

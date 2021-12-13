Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61A3472CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhLMNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhLMNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:14:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F3C061574;
        Mon, 13 Dec 2021 05:14:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D075FB80EC5;
        Mon, 13 Dec 2021 13:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7A3C34601;
        Mon, 13 Dec 2021 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639401250;
        bh=OVweQvmZKFfqAuaSOIp2hmI5/sL+o0R2iimYcXG2TOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcdygRrC0K9Su4AuW6zbwv4KhXvBB09wTuw2FiPKaeiNSwf3s8Yfp4euDDDVbGim9
         439RCSaUUCm/wWLZm9saJ1LMNSuTXzOKXJ7vUgXUkGv/C+pyBZdop4IW1SqGhOF4RG
         VlFXeiT90lWsHNcWIVAHzllD43apcJOTy0N/1HnvpndnhMoRUUQcXt2r9Aswd8LtdL
         3xQZkZLcEKKpifZWyFou7uKcWba12h4tUC9bpWtuHOO9r/WbSSyfmL9P98zCV7jpTV
         Nkat7lfm9lafE9GLfOT1qcdsy7XIcV6KOm9Fp2pTuc+YJjsU66JK1VYTz+OYYedzP+
         yA4sXXLNbSo4g==
Date:   Mon, 13 Dec 2021 14:14:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        boqun.feng@gmail.com
Subject: Re: [PATCH v2] rcu/nocb: Handle concurrent nocb kthreads creation
Message-ID: <20211213131407.GD782195@lothringen>
References: <20211211170139.27711-1-quic_neeraju@quicinc.com>
 <6c184b9ffc5c641736d53bb7598f814d6b4c3fe0.camel@infradead.org>
 <601ecb12-ae2e-9608-7127-c2cddc8038a6@quicinc.com>
 <20211213112246.GA782195@lothringen>
 <984a63d4c11d04e2ee8a83fc9c61006413bf209e.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984a63d4c11d04e2ee8a83fc9c61006413bf209e.camel@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:28:45AM +0000, David Woodhouse wrote:
> On Mon, 2021-12-13 at 12:22 +0100, Frederic Weisbecker wrote:
> > I was about to ack the patch but, should we really add code that isn't going to
> > be necessary before a long while?
> 
> Yeah, I'm torn on that. In this case it's harmless enough and it makes
> the code reentrant in its own right instead of relying on the fact that
> the cpuhp code won't invoke it multiple times in parallel. So I think
> that's reasonable defensive programming.
> 

The thing is that RCU code is already quite complicated. Are we even at least
sure that we'll ever make CPU hotplug allow concurrent CPU onlining/offlining?

This will require much more thoughts and a new hotplug concurrency
infrastructure that we'll need to base RCU on. IMHO it's a bit early to handle
that on hotplug individual callbacks.

But anyway, let's see what Paul thinks about it...

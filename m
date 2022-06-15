Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0154D253
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbiFOUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiFOUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:09:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643A949FBC;
        Wed, 15 Jun 2022 13:09:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1BB0F21C30;
        Wed, 15 Jun 2022 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655323758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcdl//EGMAUfoaFcUm+i1/8R1t8519RxD7M2HpFPHLI=;
        b=gdE505su2Mj6rcFjS571YYnAQ4YCgtzHf3vnKc68vUDoY3Q7N7yz650Pm+OyV3AlYMM023
        azcEPEcbAi8UA26e5vbYFFQfCRjx72iX+NAA8JSObr99awPIxTb0qxHMjdsYKxk3jsvvf9
        xHlrNTLAKaJ9Heuab+kGd53Hpoys2NQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 72B6E2C141;
        Wed, 15 Jun 2022 20:09:17 +0000 (UTC)
Date:   Wed, 15 Jun 2022 22:09:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, frederic@kernel.org,
        Peter Geis <pgwipeout@gmail.com>, zhouzhouyi@gmail.com,
        dave@stgolabs.net, josh@joshtriplett.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rcu@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: Prevent printk kthreads from blocking direct
 console handling
Message-ID: <Yqo8bbp10BFqNmiD@alley>
References: <20220615162805.27962-1-pmladek@suse.com>
 <20220615171042.GT1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615171042.GT1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-06-15 10:10:42, Paul E. McKenney wrote:
> On Wed, Jun 15, 2022 at 06:28:03PM +0200, Petr Mladek wrote:
> > There are reports that console kthreads prevented printing
> > messages during panic() or shutdown(), see
> > BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
> > BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com
> > 
> > In both situations, printk() correctly tries to flush the consoles
> > directly but it fails to get the global console_lock(). Both
> > problems went away with these patches:
> > 
> > 1st patch blocks console kthreads so that they do not start
> > handling new messages when the direct printing is preferred
> > by the system state. It is probably enough on its own. It
> > solves the problem when the kthreads actively did
> > the wrong thing.
> > 
> > 2nd patch allows to wait for the console kthreads to release
> > the lock in any context. It should make it more reliable.
> > It would have been useful even for the legacy code.
> 
> Thank you!
> 
> For the series:
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

Thanks a lot for testing.

I have pushed it into printk/linux.git, branch rework/kthreads
to give it a spin in linux-next.

Best Regards,
Petr

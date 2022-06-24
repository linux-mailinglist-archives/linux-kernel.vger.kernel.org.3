Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42971559F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiFXQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiFXQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E611465
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA1D6232A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB87DC34114;
        Fri, 24 Jun 2022 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656089888;
        bh=53QLMwihrFJG8ktJZB0oC36i2/jPRqOGUU1Yh6BFt9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lw2wxRqgQ6NPAPTI4S+fCkToKJKyJHK9mmnqoCSSjHuCv741q7a4KSUzzJlXNBlJ5
         biQ3MfsS4HrFhf4Tvr14HLN9saWxhbZNQUGQAIXYQwx4Hh7EJT87kcOMtKsdeBqy+p
         0joObPjs8XeVsDZ4hCtsmt1NhlGTji5kkTQ+rZ2fCw8sO0Nz2YB2PpZaqx7yHaBVZF
         tW7IWABmPkcjlavnftZQSgS+T6joCX6lOT3JKPYgpDoW6PbYMv8HzpHCAkuxgCq9jj
         iMSumajLrELjS4Pagiaqh5ovOtXaVsu9/h968We3rv6+BxCjx75VFl8iXKr4H9SOTa
         mWhYhbG5VQ3FQ==
Date:   Fri, 24 Jun 2022 09:58:07 -0700
From:   Mark Gross <markgross@kernel.org>
To:     Joe Korty <Joe.Korty@concurrent-rt.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@archiver.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Message-ID: <YrXtH1z2JSmwLS7W@T470>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:16:39PM +0000, Joe Korty wrote:
> Mismatched get_uid/free_uid usage in signals in 4.9.312-rt193
> 
>      [  First attempt using mutt did not show up on the mailing lists.
>         Trying again with office365 Outlook.   Also added the 4.9-rt
>         maintainers. ]
> 
> The 4.19-rt patch,
> 
>    0329-signal-Prevent-double-free-of-user-struct.patch
> 
> needs to be ported to LAG 4.9-rt, as that release now has the Linus commit,
What does LAG stand for?

FWIW the cherry-pick within the RT-stable tree worked without conflict.
    (cherry picked from commit a99e09659e6cd4b633c3689f2c3aa5f8a816fe5b)
It compiles.
See 58a584ee59b2 signal: Prevent double-free of user struct in 
linux-stable-rt.git/v4.9-rt-next

> 
>    fda31c50292a ("signal: avoid double atomic counter increments for user accounting")
>
This was added to 4.9.y on March 20, 2020.
commit 4306259ff6b8b682322d9aeb0c12b27c61c4a548 in linux-stable.

How did you find this issue?  What is missing from my testing?

Do you have a test case that I can conferm my cherry-pick works?
Could you test the v4.9-rt-next branch to see if it fixes you issue?

--mark

> which breaks the longstanding rt patch,
> 
>    0259-signals-Allow-rt-tasks-to-cache-one-sigqueue-struct.patch
> 
> Current application status:
> 
>    4.4.302-rt232        OK      has both Linus's patch and the fix needed for rt.
>    4.9.312-rt193        BROKE   has Linus's patch but not the fix.
>    4.14.87-rt50         OK      does NOT have either Linus's patch nor its rt fix.
>    4.19.246-rt110       OK      has both Linus's patch and the fix needed for rt.
>    5.4.193-rt74         OK	has both Linus's patch and the fix needed for rt.
>    5.10.120-rt70        OK	has both Linus's patch and the fix needed for rt.
>    5.15.44-rt46         UNKNOWN no get_uid/free_uid usage in kernel/signal.c anymore.
> 
> Regards,
> Joe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF14E54CF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349876AbiFORKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbiFORKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:10:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B941633A33;
        Wed, 15 Jun 2022 10:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BC6AB820C4;
        Wed, 15 Jun 2022 17:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2297C34115;
        Wed, 15 Jun 2022 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655313043;
        bh=H3WInZezFiR4P8CKRnqvCzRSHF5GZxIMRPSwGD7BlYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I/Aze6kNbOmBPbYboiQcuW+LTeP/twbG/pvhe8xAUAZH6okfscE2CyHsBliygVNDO
         KLLXDGJx/qMKbRxKL2iwZxY49eSI7gsGR1NSmEbj1TIsa3v4x6BUHbG+j7ZMEtYzfr
         G2fL8ay6mLQQ4spywfLSgO3AkKqNZ+q+cammGu5LUM+XE9V/QTM0YN6/5psRqQnC0X
         YK/Ba46GTwzCd92RThON46g34nGmV1DgD8CJoPdSSBq3q+zBi6dONCuyYS5b4OxT4+
         TxdJ1o3TBrzqUWw54KLAu/rnRvIGgVe4ap55zFoBVd9hwzA1rinz8u7xbraMpWdGSe
         vnxaxu/MmUllA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6EC965C05B9; Wed, 15 Jun 2022 10:10:42 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:10:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <20220615171042.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220615162805.27962-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615162805.27962-1-pmladek@suse.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 06:28:03PM +0200, Petr Mladek wrote:
> There are reports that console kthreads prevented printing
> messages during panic() or shutdown(), see
> BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
> BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com
> 
> In both situations, printk() correctly tries to flush the consoles
> directly but it fails to get the global console_lock(). Both
> problems went away with these patches:
> 
> 1st patch blocks console kthreads so that they do not start
> handling new messages when the direct printing is preferred
> by the system state. It is probably enough on its own. It
> solves the problem when the kthreads actively did
> the wrong thing.
> 
> 2nd patch allows to wait for the console kthreads to release
> the lock in any context. It should make it more reliable.
> It would have been useful even for the legacy code.

Thank you!

For the series:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> More possible improvements:
> 
>   +  the waiting might be necessary also in the suspend code paths
> 
>   + convert con->mutex to con->spinlock to avoid blocking
>     the global console_lock() when sleeping with con->lock
> 
>   + at least disable preemption around console_emit_next_record()
>     in console kthread to avoid sleeping in the console driver
>     code
> 
>   + somehow change the priority of the kthread so that it gets
>     scheduled immediately when the scheduler works
> 
> Petr Mladek (2):
>   printk: Block console kthreads when direct printing will be required
>   printk: Wait for the global console lock when the system is going down
> 
>  include/linux/printk.h      |  5 +++++
>  kernel/panic.c              |  2 ++
>  kernel/printk/internal.h    |  2 ++
>  kernel/printk/printk.c      |  8 +++++++-
>  kernel/printk/printk_safe.c | 32 ++++++++++++++++++++++++++++++++
>  kernel/reboot.c             |  2 ++
>  6 files changed, 50 insertions(+), 1 deletion(-)
> 
> -- 
> 2.35.3
> 

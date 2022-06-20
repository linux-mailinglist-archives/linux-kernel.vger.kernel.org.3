Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA400552852
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347613AbiFTX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347492AbiFTX2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:28:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3447210FE8;
        Mon, 20 Jun 2022 16:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB99CB81213;
        Mon, 20 Jun 2022 23:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB13C3411B;
        Mon, 20 Jun 2022 23:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655767718;
        bh=KtJngfqgTk5wBhNhP13+KWCBf6xSwcGzo/7nqF6dp9w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C6ASf43QZiUkdJ5CxhJ/WaQ6B3tGPMVugNQ2cTUficXoqwQ89fnkhEOMf4s9N1yxR
         fzHEBRhK4uJKXGiuPQv7jc3uq8M6cRGAEIEMbXEMjrYGOaGC1W46F/3y1VElJWmVEQ
         QP0pq+6iOIj3+eqlDsh01UeSOxi0qSssQoB7euHC7jPIhLpPjaXwPFYU+mz4YkZrzs
         b1HA/qrM+4FTJ88g35lJJxjC22Lh9ZwbaaCAx9OuFqcDzWLxHVb+e4lHZ1dnLqgCAR
         C8Wbp+hYEnGpOe3tqcauvzCD0JQfWCcg8duj8ANdZhpyDCTMJrUaiMBTuyd3VZIJD3
         yUQag1fbzddkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2624E5C05B9; Mon, 20 Jun 2022 16:28:38 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:28:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 11/12] torture: Flush printk() buffers before
 powering off
Message-ID: <20220620232838.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
 <20220620225817.3843106-11-paulmck@kernel.org>
 <8735fyc42v.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735fyc42v.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 01:29:04AM +0206, John Ogness wrote:
> On 2022-06-20, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > The rcutorture test suite produces quite a bit of console output
> > at the end of a test.  This means that the new printk() kthreads
> > are likely to be in the process of flushing output at the time of
> > the torture_shutdown() function's call to kernel_power_off().
> >
> > This commit therefore invokes pr_flush(1000, true) to flush this
> > pending console output before invoking kernel_power_off().
> >
> > Fixes: 8e274732115f ("printk: extend console_lock for per-console locking")
> > Cc: John Ogness <john.ogness@linutronix.de>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thank you, John!

But given Petr's and your recent changes that are now in mainline, is
this still really needed?  (Tests now pass without it, though tests can
of course be misleading.)

							Thanx, Paul

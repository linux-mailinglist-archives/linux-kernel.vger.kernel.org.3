Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB15A59CD69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiHWAtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbiHWAsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9013D20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 139856010D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6845C433D6;
        Tue, 23 Aug 2022 00:48:26 +0000 (UTC)
Date:   Mon, 22 Aug 2022 20:48:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <20220822204825.3e88b1a4@rorschach.local.home>
In-Reply-To: <20220822183836.6b80976f@gandalf.local.home>
References: <20220822164404.57952727@gandalf.local.home>
        <20220822182850.32f91017@gandalf.local.home>
        <20220822183836.6b80976f@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 18:38:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > The warning happens with the commit, and does not for the commit just
> > before it is applied.
> >   
> 
> Nevermind, I tested the wrong kernel (the grub reboot failed to boot to the
> new kernel). But it did give me a different lockdep splat when I tested the
> right kernel :-/
> 
> I'll investigate some more.

I was close. It was this commit:

ed4ae5eff4b3 ("rcu: Apply noinstr to rcu_idle_enter() and rcu_idle_exit()")

that causes the new error message.

-- Steve

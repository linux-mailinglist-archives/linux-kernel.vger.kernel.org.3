Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C1546EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350573AbiFJUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348382AbiFJUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:50:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2238183
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99BC2B837C4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2B1C34114;
        Fri, 10 Jun 2022 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654894239;
        bh=mAmfZf4nfAu/yLsMeJo38lan3gcw/ctlhPgcoEOwNrQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=kB2PPWSA847cl8uxEh8f0Q6MBHwSj+ZZ122E2vBxnIqChHRv65mp/ZHpkQvihkrC5
         hhsH2F3LXlvZIkCyawsxGSM5CJNZhba+KMsBxjUjletiPq0WKQyi+5Jq4Dk1IaZCbB
         a4vMduyuBsC+QK+25cKpFfUgkBYf/RdTLd6HXarbayWptnEBj+qefwO7MA/stQOPUa
         faeHlO7Ik58tHg4MmPHXLifhIHfWIH0//snA6XmlC7cO2XBXGkPEIIlSsqG0878nrc
         t+xANaima+6+j2LDqR51J0ek+sshvMJ6ktZ47AwTTys2SYS3QbtwsrS8nBRTXcSqha
         mbKr1x04ht0Xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C09885C05ED; Fri, 10 Jun 2022 13:50:38 -0700 (PDT)
Date:   Fri, 10 Jun 2022 13:50:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     john.ogness@linutronix.de
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org, pmladek@suse.com
Subject: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, John,

I have started getting rcutorture shutdown-time hangs when running
against recent mainline, and bisected back to the 8e274732115f ("printk:
extend console_lock for per-console locking") commit.  These hangs go
away (or at least their probability drops dramatically) if I build with
CONFIG_PREEMPTION=n -and- CONFIG_NO_HZ=y (not n!), at least assuming
that I also boot with "nohz_full=0-N".

Attempts to debug using rcutorture's "--gdb" argument result in
"[Inferior 1 (process 1) exited normally]", but with the same truncated
console-log output as when running without "--gdb".  This suggests
that the kernel really did run to completion and halt as expected,
but that the shutdown-time printk() output was lost.  Furthermore, if I
use the gdb "hbreak" command to set a breakpoint at kernel_power_off(),
it really does hit that breakpoint.  This would not happen in the case
of a kernel hang.

So, given that I can hit that breakpoint, what should I ask gdb to
show me?

Alternatively, this reproduces on a variety of x86 platforms, so you
should be able reproduce it as follows [1]:

	git checkout v5.19-rc1
	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE01" --gdb "CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y" --trust-make

This builds a kernel, boots it, and then tells you how to launch gdb
(presumably in some other window).  Once you give launch gdb and give
it the suggested commands, the kernel runs for two minutes under qemu,
then shuts down.  I used the following gdb commands to set the breakpoint
and run the kernel:

	target remote :1234  # suggested by the rcutorture script
	hbreak kernel_power_off  # added by me
	continue  # suggested by the rcutorture script

Or leave out the "gdb" if you prefer some other debugging approach.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

[1]	The --kconfig argument is needed due to CONFIG_DEBUG_INFO Kconfig
	changes.  You can instead pull in -rcu commit f9993c8413d1
	("torture: Adjust to again produce debugging information"),
	which allows you to omit that --kconfig argument.

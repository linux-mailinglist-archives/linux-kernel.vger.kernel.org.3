Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91E154F84A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382109AbiFQNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFQNXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:23:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8B62F3A0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95DA1B82854
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69C9C3411B;
        Fri, 17 Jun 2022 13:23:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BZZvlLv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655472189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=tRP6CBQmuP9Bt+VjJuAK5G+mZBi0qlyfhbg9gs/d+FU=;
        b=BZZvlLv5OSaD4hgQ3Jzwb/nYsvsB2FBhvKd9ni+SPr6EOINBsaxDKrZynagbnYi7wjPBRu
        dw4EkMRXAcopwAVxEN25qu6+heSLf8JTZfwAN70N/uGYEUd8P+Nh6OMCsba996vKV+LA2T
        vgE6P7Q18TiZzYFhoJsSkMVHZZ1uGkM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id baf4eaae (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 17 Jun 2022 13:23:08 +0000 (UTC)
Date:   Fri, 17 Jun 2022 15:23:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org
Subject: 5.19 printk breaks message ordering
Message-ID: <YqyANveL50uxupfQ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John & folks,

In 5.19, I'm seeing some changes in message ordering / interleaving
which lead to confusion. The most obvious (and benign) example appears
on system boot, in which the "Run /init as init process" message gets
intermixed with the messages that init actually writes() to stdout. For
example, here's a snippet from build.wireguard.com:

    [    0.469732] Freeing unused kernel image (initmem) memory: 4576K
    [    0.469738] Write protecting the kernel read-only data: 10240k
    [    0.473823] Freeing unused kernel image (text/rodata gap) memory: 2044K
    [    0.475228] Freeing unused kernel image (rodata/data gap) memory: 1136K
    [    0.475236] Run /init as init process
    
    
        WireGuard Test Suite on Linux 5.19.0-rc2+ x86_64
    
    
    [+] Mounting filesystems...
    [+] Module self-tests:
     *  allowedips self-tests: pass
     *  nonce counter self-tests: pass
     *  ratelimiter self-tests: pass
    [+] Enabling logging...
    [+] Launching tests...
    [    0.475237]   with arguments:
    [    0.475238]     /init
    [    0.475238]   with environment:
    [    0.475239]     HOME=/
    [    0.475240]     TERM=linux
    [+] ip netns add wg-test-46-0
    [+] ip netns add wg-test-46-1

Before the "with arguments:" and such would print prior to the
"wireguard test suite on linux 5.19" banner. Now it shows after.

I see the same thing with "Freeing unused kernel image (text/rodata gap)
memory" printing interwoven into the console of my initramfs on my
laptop. And so forth.

But the bigger issue for me is that it makes it very confusing to
interpret CI results later on. Prior, I would nice a nice correlation
of:

[+] some userspace command
[    1.2345 ] some kernel log output
[+] some userspace command
[    1.2346 ] some kernel log output
[+] some userspace command
[    1.2347 ] some kernel log output

Now, the kernel log outputs are all over the place and out of order with
the sequence of commands. This makes debugging issues somewhat tricky,
because post hoc ergo propter hoc winds up being a good intuition to
follow when tracking down bugs, and now the post hoc part is muddled.

I assume this is mostly caused by your threaded printk patchset, which
moves some of that printing into a worker, which means it's more
dependent on the scheduler than before. This probably has important
benefits. But it certainly makes CI and related debugging a bit
trickier as a result.

So I was wondering if there was some way to boot the kernel with a
command line option or compile-time flag that always flushes printk
messages when they're made, or does something to make the ordering a bit
more faithful.

Thanks,
Jason

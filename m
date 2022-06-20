Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26983552706
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbiFTWmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiFTWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:42:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708D81276A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31C18B811EC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 22:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1082EC3411C;
        Mon, 20 Jun 2022 22:42:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XzFX3G1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655764923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXc4zdICVXyYuZT3mYGMNiXmjUFP4MgtX6ODMQRhdDc=;
        b=XzFX3G1KQjd5Wdq6qeTCBkYmYFEEywcRNIG/KDh3u+jTDhTyoIhBWn5F4+l3pOB7Nc46rl
        lHkbhOHsCjcTgJDfJoEA1riCXKRO5IG42WqlBbKb8cQ3LV136CqDPyQsi/t/S4KQ4bfJQp
        4KqtrKjnJu589j/ncvvXtoSEW/I0TGc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8ff005c1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 20 Jun 2022 22:42:03 +0000 (UTC)
Date:   Tue, 21 Jun 2022 00:41:59 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Fix signal_pending() usage
Message-ID: <YrD3jVuXC8eH+WRi@zx2c4.com>
References: <20220405163931.1108442-1-jannh@google.com>
 <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
 <YqywapDM7NPC/X+E@linutronix.de>
 <Yq0EcG9GsAkoiF3H@zx2c4.com>
 <YrAlPKeOowD5qv/B@linutronix.de>
 <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 02:00:18PM -0500, Linus Torvalds wrote:
> Handling signals is the *default* behavior. It is only regular files
> where that doesn't happen. This is not a regular file, and the "it's
> about security" is not an argument.
> 
> As mentioned, expecting an uninterruptible read is not "security". It's garbage.

Indeed, practically speaking you are right. A few months back when I was
fixing this to respect signals in the first place (because it used to be
wrongly conditioned on need_resched()), I did some global code searches
to see if I'd break anything, and basically it seemed like anything that
used huge buffers handled EINTR, and only little buffers weren't filled
iteratively. So PAGE_SIZE would seem to widely handle the real code out
there.  If this is to change as an API ease of use argument or
something, I'd expect the behavior to change across devices (/dev/zero
and such I mentioned earlier in mem.c), not just this one -- no need to
be a special snowflake -- which means convincing people to change
something pretty well established.

Jason

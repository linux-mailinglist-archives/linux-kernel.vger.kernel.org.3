Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC6547AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiFLPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiFLPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:43:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A0A2EA24
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDDE1B80BE6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C96C34115;
        Sun, 12 Jun 2022 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655048628;
        bh=QJjSQKWUP4kdWCSK3d39U/CpgCCp0tzcQRFmNhLbMds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7K32Rtqe/iSf1YAEcpejrXoDPC0hmpFxQgpQrd7FTNAu/8mOsTe1A8JpBX8gu2Q+
         18b+FZvuaXMvEhWm0GR1u00ngtF9I9CckE/3NTWGSe4iXi4JYWIiB9MS8UlgyzZlAl
         MaQ56XC3y6k9D9nkyvtrgl31x5JZyalZ75JG3oa1ZkLtEzkix50EvOS3IbVYavCkdj
         Ie5APRCbpv/fqY/Vnw/1rVlmkBv69ByHGeUJOzzomUfh+ZzUiyVcQpMOHFLqXZDaDb
         siVfBsASywYmGdeu5uujka62jyui8GttJamYjXyeU0peKmY6YMYZTz+tIFqgNfdkBw
         1/7b8kaNQ7lrw==
Date:   Sun, 12 Jun 2022 11:43:47 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Use sched_clock() for random numbers.
Message-ID: <YqYJs/NBw3mQGz3k@sashalap>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoNn3pTkm5+QzE5k@linutronix.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:16:14AM +0200, Sebastian Andrzej Siewior wrote:
>Since the rewrote of prandom_u32(), in the commit mentioned below, the
>function uses sleeping locks which extracing random numbers and filling
>the batch.
>This breaks lockdep on PREEMPT_RT because lock_pin_lock() disables
>interrupts while calling __lock_pin_lock(). This can't be moved earlier
>because the main user of the function (rq_pin_lock()) invokes that
>function after disabling interrupts in order to acquire the lock.
>
>The cookie does not require random numbers as its goal is to provide a
>random value in order to notice unexpected "unlock + lock" sites.
>
>Use sched_clock() to provide random numbers.
>
>Fixes: a0103f4d86f88 ("random32: use real rng for non-deterministic randomness")
>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>---
>
>So if the architecture does not provide sched_clock() and does not
>enabled GENERIC_SCHED_CLOCK then we use jiffies here. Most of them do
>one or the other except for alpha, csky, hexagon, ... but I don't worry
>here since arm*, power*, x86* do provide it.

I'm seeing hangs on AMD based machines with lockdep enabled, and
bisected the issue to a0103f4d86f88 ("random32: use real rng for
non-deterministic randomness").

No hangs on Intel/arm64, no hangs with lockdep disabled.

Spotted this patch on the list, and confirmed that it addresses the
issue I'm seeing.

-- 
Thanks,
Sasha

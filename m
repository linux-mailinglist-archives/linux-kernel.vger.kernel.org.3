Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A074B7791
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbiBOT7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:59:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiBOT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:59:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0813566227
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:59:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7C45B81CCB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7990DC340EB;
        Tue, 15 Feb 2022 19:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644955169;
        bh=SDqM7j7mEfwIY0ZRiphWLUUJe87XSwuNN2c+pVrVzVI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NJOUXAOkkVz53MA8gXUhWtMSW4jQgL2EsGf+Td5qutjO6kBYfKCTEFIjG/oS4pEGX
         /voy7GGUWUVWfWGdw8oAjTRvaU3ai27E8iEDhNRLKt24pabx47oyirtPrsPTpM3ufq
         zIbU7BEI75akuIN3k4JYPJIT5Rj6KuDh7jEEPZLTAgMdnvpmdV3aM6iKTLQ9b08T7c
         T829I+35D8DUvO0TnXEna1qImNt5ZKeWs5rSoBZUiJ/z6m+AyYP20id/dKVfH8fXmd
         BmoycJTvmJLE+QZa+3P+ip4xC6P4FlA39gIE8zm+SDrNpFcmP7yWT9pUgzut0wuVFS
         uYWQBQVg2GUQA==
Date:   Tue, 15 Feb 2022 20:59:24 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fb-helper: Avoid nesting spinlock_t into
 raw_spinlock_t
In-Reply-To: <87o8382j5s.fsf@jogness.linutronix.de>
Message-ID: <nycvar.YFH.7.76.2202152058300.11721@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2202151640200.11721@cbobk.fhfr.pm> <YgvLdvPihuQ9KZ6/@linutronix.de> <87o8382j5s.fsf@jogness.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, John Ogness wrote:

> >> drm_fb_helper_damage() is acquiring spinlock_t (helper->damage_lock), 
> >> while it can be called from contexts where raw_spinlock_t is held (e.g. 
> >> console_owner lock obtained on vprintk_emit() codepath).
> >> 
> >> As the critical sections protected by damage_lock are super-tiny, let's 
> >> fix this by converting it to raw_spinlock_t in order not to violate 
> >> PREEMPT_RT-imposed lock nesting rules.
> >> 
> >> This fixes the splat below.
> >> 
> >>  =============================
> >>  [ BUG: Invalid wait context ]
> >>  5.17.0-rc4-00002-gd567f5db412e #1 Not tainted
> >
> > rc4. Is this also the case in the RT tree which includes John's printk
> > changes?
> 
> In the RT tree, the fbcon's write() callback is only called in
> preemptible() contexts. So this is only a mainline issue.
> 
> The series I recently posted to LKML [0] should also address this issue
> (if/when it gets accepted).
> 
> John
> 
> [0] https://lore.kernel.org/lkml/20220207194323.273637-1-john.ogness@linutronix.de

Thanks for confirmation, seems like this problem is indeed cured by your 
series.

I still believe though that we shouldn't let 5.17 released with this 
warning being emitted into dmesg, so I'd suggest going with my patch for 
mainline, and revert it in your series on top of it.

Thanks,

-- 
Jiri Kosina
SUSE Labs


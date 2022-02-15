Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4824B7249
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiBOQXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:23:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiBOQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:23:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF127170
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:23:29 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644942208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGa3oCsCDm0R2QE32ynzHVQmQs9uQ3ubWMnYmBZfUtU=;
        b=b5AuXe/aARjeX5fjNLRuvi7BCXK1xKsBXXx8pqm9uDCmW1oSq4NPu2Ntr+cMDzooZojhRA
        Mo/BtgXQpJVQ4xvkZOhZXSZ4kA+0a/2BpGls+2efBUpHnpXJ//b4L16TynasJXnsckeJFy
        1Z/E7bVtGhTPRXYSY6TSOURJCrkCr64AE2r3nAbJ8e7/7xD91Kh7eLv8L4PD26V93M3IEL
        xRg4jafV0o8Jm+ZsJ73v37eC+81tcmET2Yo6NbJ642yyTY6W4m639aCIt4S3Sw5G3yk1zT
        J9auPgiRZwm4BbnAHxy926Ez1CsiEqwODQyEc5C/x5LbiecOT61lXAo/9tWdrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644942208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGa3oCsCDm0R2QE32ynzHVQmQs9uQ3ubWMnYmBZfUtU=;
        b=oDGLoR+EdHIqdeEfijeVg9bXDhKnweL8w/ARhGpB5nK6PhRveeKOU0KcdBtcxtWm4hbg4r
        nrsqpYR5X0nQP3AQ==
To:     Sebastian Siewior <bigeasy@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fb-helper: Avoid nesting spinlock_t into
 raw_spinlock_t
In-Reply-To: <YgvLdvPihuQ9KZ6/@linutronix.de>
References: <nycvar.YFH.7.76.2202151640200.11721@cbobk.fhfr.pm>
 <YgvLdvPihuQ9KZ6/@linutronix.de>
Date:   Tue, 15 Feb 2022 17:29:27 +0106
Message-ID: <87o8382j5s.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-15, Sebastian Siewior <bigeasy@linutronix.de> wrote:
>> From: Jiri Kosina <jkosina@suse.cz>
>> 
>> drm_fb_helper_damage() is acquiring spinlock_t (helper->damage_lock), 
>> while it can be called from contexts where raw_spinlock_t is held (e.g. 
>> console_owner lock obtained on vprintk_emit() codepath).
>> 
>> As the critical sections protected by damage_lock are super-tiny, let's 
>> fix this by converting it to raw_spinlock_t in order not to violate 
>> PREEMPT_RT-imposed lock nesting rules.
>> 
>> This fixes the splat below.
>> 
>>  =============================
>>  [ BUG: Invalid wait context ]
>>  5.17.0-rc4-00002-gd567f5db412e #1 Not tainted
>
> rc4. Is this also the case in the RT tree which includes John's printk
> changes?

In the RT tree, the fbcon's write() callback is only called in
preemptible() contexts. So this is only a mainline issue.

The series I recently posted to LKML [0] should also address this issue
(if/when it gets accepted).

John

[0] https://lore.kernel.org/lkml/20220207194323.273637-1-john.ogness@linutronix.de

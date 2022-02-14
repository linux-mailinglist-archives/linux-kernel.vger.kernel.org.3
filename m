Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629234B53C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347894AbiBNOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:53:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiBNOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:52:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8329BB84F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:52:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC3D611C3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D21DC340E9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:52:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N/9ut7Af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644850367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7X5QGsJ4Ca2FmB5FIayi0enVhwae/EyXVY8HQCkia9A=;
        b=N/9ut7Afa03fdB5y/CbQp47CLOhAOWcnPvoqs1hWJ7KELbSWW8uTYlwK57wxbFEVWajp1I
        55EEFbikMnd9oIIP31PuvszJphIJLgIBFTRfaGeAs36RYDA2zgbRmuB7cZagob7CcfzNcw
        Xjkiqam7hl3Tlz61Hfrxx8c1k4rVKUo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 378e3483 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 14 Feb 2022 14:52:47 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id e140so27580259ybh.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:52:46 -0800 (PST)
X-Gm-Message-State: AOAM532/1BI4VxFWLXSxUfMf4f1cXnHsm/exbJiX9CR9eTasT2ePHSyS
        eukypMPoNLCkfSa7fqewnSefQ4pK+7PjMvdbMOA=
X-Google-Smtp-Source: ABdhPJwuO+UdPh8GCZAnHmNAmuMINaWqlGipMHnl2Qy35fCTTzh9IZ5RVPP7hXWjJFA5G6dAQEl5e8ES/JmdZJHfawY=
X-Received: by 2002:a25:dc14:: with SMTP id y20mr12275ybe.115.1644850365166;
 Mon, 14 Feb 2022 06:52:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com> <Ygpkej/vnMvUDIlP@linutronix.de>
 <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com> <Ygpr9Xg0I+ZVzp9v@linutronix.de>
In-Reply-To: <Ygpr9Xg0I+ZVzp9v@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 15:52:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9rp+O3+yjX_q-BS8y06PigbkEgi4vn=nzLACnBAWZt-vA@mail.gmail.com>
Message-ID: <CAHmME9rp+O3+yjX_q-BS8y06PigbkEgi4vn=nzLACnBAWZt-vA@mail.gmail.com>
Subject: Re: [PATCH v2] random: set fast pool count to zero in cpuhp teardown
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 3:49 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-02-14 15:42:50 [+0100], Jason A. Donenfeld wrote:
> > Hi Sebastian,
> Hi Jason,
>
> > If we move this to startup, is there a phase during which no interrupt
> > will arrive? That is, can this happen very very early in startup, so
> > that zeroing out count happens *before* ++count?
>
> Interrupts will arrive starting with CPUHP_AP_ONLINE_IDLE from the CPU
> HP point of view. My suggestion had a check for upper most bit and only
> clear count if that bit was seen. So we wouldn't clear the counter if we
> wouldn't suspect one of the rare corner cases.

That doesn't work for the other use cases I have for this (see the other patch).

So I think it seems better to keep it before CPUHP_TIMERS_PREPARE, but
do it on startup rather than teardown. Seem reasonable? Would that
mean we zero out before IRQs are enabled?

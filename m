Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987FB4B543D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355675AbiBNPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:11:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344845AbiBNPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:11:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F754D275
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:10:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A838D61256
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007E9C340F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:10:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oeAYpuB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644851448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiHpJxXkjs+MwRu7CzpGstcpnssWU0+FrDB+V1LRRO4=;
        b=oeAYpuB/xUC6umcKR3Pf0NKsb1w4xi/Pr9L1l2ywDthe57MSaMUWVDEoa5D+4wpox3vKRm
        x+qMKoACekRiyEmy8zK/XEv/38yemb03+JCZTMVDDgPnrZxftUcuWiuq0Gg+pUCj2oruhc
        J0GTnoXY5lcTosyQo6LgqKMRPyXW3Ik=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aacb0857 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 14 Feb 2022 15:10:48 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id bt13so47092555ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:10:48 -0800 (PST)
X-Gm-Message-State: AOAM5300Dpfbspb5Osu0aA0HrY3I5mFeOhqvF1byi+mgkbYeYXRkn2N1
        e2++QzyIu+LOp4/XeShosFgSY4mwFg4lvXtD1eE=
X-Google-Smtp-Source: ABdhPJwIM3qC/XB6WQH0TwXmYcRUk4ywsdbbjaHMut37DBU85a3VNyGQnhoBt2LyjMFxmN0F0NudHgjcLqteHdH6FKs=
X-Received: by 2002:a25:dc14:: with SMTP id y20mr94918ybe.115.1644851446872;
 Mon, 14 Feb 2022 07:10:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com> <Ygpkej/vnMvUDIlP@linutronix.de>
 <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
 <Ygpr9Xg0I+ZVzp9v@linutronix.de> <CAHmME9rp+O3+yjX_q-BS8y06PigbkEgi4vn=nzLACnBAWZt-vA@mail.gmail.com>
 <Ygpv/kLWCmTzUTki@linutronix.de>
In-Reply-To: <Ygpv/kLWCmTzUTki@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 16:10:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9qrhpRCox2mR2UEStWxev2Zu14htBkpv3mdFEkVqacvVQ@mail.gmail.com>
Message-ID: <CAHmME9qrhpRCox2mR2UEStWxev2Zu14htBkpv3mdFEkVqacvVQ@mail.gmail.com>
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

Hi Sebastian,

On Mon, Feb 14, 2022 at 4:06 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> But you acked my question regarding boot-up? So the teardown callback
> won't happen during boot-up.

I'd like to do only one method here, so we can set those fields in
startup, provided it happens early enough.
> > So I think it seems better to keep it before CPUHP_TIMERS_PREPARE, but
> > do it on startup rather than teardown. Seem reasonable? Would that
> > mean we zero out before IRQs are enabled?
> I would only zero it if the upper-most bit is there.

I still don't quite understand: why can't we just unconditionally
zero, always, before CPUHP_TIMERS_PREPARE?

> And then have another one after

Two of them seems a little bit out of hand in complexity here... Let's
just find one phase where we can simply set variables without too much
fiddly logic. I'll send a v+1 of what I have in mind for the startup
path.

Jason

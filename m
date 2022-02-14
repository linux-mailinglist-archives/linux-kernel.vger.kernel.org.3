Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71F64B55DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbiBNQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:16:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiBNQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:16:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77929D48
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:15:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C64614BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B9C340EE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:15:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J3pJHqss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644855350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEj4LEQNjT5w6i+nrVdETHT6q2Q2BpQcUA4gmY11BTs=;
        b=J3pJHqssyfiYGuFmVoy3hJrMucYk3N0eRz7VEWL7xK5i0gaEbqKlHo+HjtkprzxKNTddCL
        iqzNOyX1XLwMwbkJEmiRo5CE+g9CbYTt1xct4HYXyA5jvbaFP1z4FZbPNUt7cH3znqEcM5
        Z2AGZIlaYO1bXExWCPfz89kn45MMnn8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fde401f1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 14 Feb 2022 16:15:50 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id p19so47604081ybc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:15:50 -0800 (PST)
X-Gm-Message-State: AOAM533Iwh7YdQ1SW+uf+j2Bb8eIKvQljt2l5ema5ewfgIArm5mQIhCV
        O/T2Lpl8Ev3Mjsi70/+BkldNwOCVRaS3QeD6q8s=
X-Google-Smtp-Source: ABdhPJy1kra1Qp5vQH8qSXKIQrqs5nft0TI1FHnE7Pb3ogx3kMJS0+5WcM7KjoPbr8MhaiIokNDDhnrQ+hAnGJuYmwA=
X-Received: by 2002:a81:f10b:: with SMTP id h11mr405157ywm.396.1644855348864;
 Mon, 14 Feb 2022 08:15:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com> <Ygpkej/vnMvUDIlP@linutronix.de>
 <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
 <Ygpr9Xg0I+ZVzp9v@linutronix.de> <CAHmME9rp+O3+yjX_q-BS8y06PigbkEgi4vn=nzLACnBAWZt-vA@mail.gmail.com>
 <Ygpv/kLWCmTzUTki@linutronix.de> <CAHmME9qrhpRCox2mR2UEStWxev2Zu14htBkpv3mdFEkVqacvVQ@mail.gmail.com>
 <YgpybD+PeQ5Az7CJ@linutronix.de>
In-Reply-To: <YgpybD+PeQ5Az7CJ@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 17:15:38 +0100
X-Gmail-Original-Message-ID: <CAHmME9qXE_t-O1X9yX_QeY1cQqNtWCHn12UiGYrE18vrab9Pvw@mail.gmail.com>
Message-ID: <CAHmME9qXE_t-O1X9yX_QeY1cQqNtWCHn12UiGYrE18vrab9Pvw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 14, 2022 at 4:17 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > I'd like to do only one method here, so we can set those fields in
> > startup, provided it happens early enough.
> > > > So I think it seems better to keep it before CPUHP_TIMERS_PREPARE, =
but
> > > > do it on startup rather than teardown. Seem reasonable? Would that
> > > > mean we zero out before IRQs are enabled?
> > > I would only zero it if the upper-most bit is there.
> >
> > I still don't quite understand: why can't we just unconditionally
> > zero, always, before CPUHP_TIMERS_PREPARE?
>
> If you have a rollback before CPUHP_TIMERS_PREPARE you don't notice it
> and your worker may have skipped this work because it run on the wrong
> CPU. Also, I *think* that if you happen to have 64 interrupts between
>    CPUHP_AP_ONLINE_IDLE =E2=80=A6 CPUHP_AP_WORKQUEUE_ONLINE
>
> then the scheduled worker is unbound and may run on the "wrong" CPU.

I'm talking about in the context of unconditionally zeroing during
*startup*, just before CPUHP_TIMERS_PREPARE. That's what I sent in
this patch series:
https://lore.kernel.org/lkml/20220214151415.1108141-1-Jason@zx2c4.com/t/#u

Jason

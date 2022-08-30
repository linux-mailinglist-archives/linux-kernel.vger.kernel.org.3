Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A175A6CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH3S5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3S5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:57:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BC76472
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:57:51 -0700 (PDT)
Date:   Tue, 30 Aug 2022 20:57:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661885869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nI0twHoYA12EttbwzHWDC0L+UjAQ6kYDXqqwl07jlCc=;
        b=Uf4YitVsv5sFBNUK2gzOc/uRllMkYX2/e8NE0vQm14gJ5eh2vT5Qgr4AWrRCJ5Vo840exK
        HBiMoeW4eoJML0j5p3mFNFwoLj5Twync1QhmWCWoItGDO3HovlKpqO0pVTzzRwK5tgrL1Q
        uSVYsc/qJyYJoKw58kIupT7XbyF3+9uhgrxpv0cLdZwKia6yAI73dh2dkgb3KeJfvzePmV
        J8RCeQQwL5ObTH69pDT9ibUl6GToLZmWwXf9xMLTZTZ8cLPKNc3tks6yUmUrV5siZX9rLF
        PK7qT22bGBXM/T1C+gIXtVLF3KZAV6hgjXCGTH+RGb4fJDsgo1Wj3bpl8qN7zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661885869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nI0twHoYA12EttbwzHWDC0L+UjAQ6kYDXqqwl07jlCc=;
        b=Ptp/PTS75ojT2z0t6NPxpiFfsHuNfwSfhkn4dvitXWerWH1/AB2YB0stvlQP9T24cQ7h/Z
        flp1p4baZ6ACzzDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <Yw5dqweo0bQDvPkP@linutronix.de>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de>
 <YvUQJTDREXSAA9J6@zx2c4.com>
 <Yw0XRtgh2dmSM+T1@linutronix.de>
 <Yw0Z1jvwHEQQq8Zw@zx2c4.com>
 <Yw3i2N8J7yz3jnyt@linutronix.de>
 <Yw4rsdA7xu4+UrLi@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yw4rsdA7xu4+UrLi@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-30 11:24:33 [-0400], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> On Tue, Aug 30, 2022 at 12:13:44PM +0200, Sebastian Andrzej Siewior wrote:
> > The first patch did so yes. The second simply retried in two secs and
> > this shouldn't be problematic.
>=20
> This seemed pretty bad too, because now you potentially miss up to 2
> seconds of messages AND it adds more complexity.

It is early at boot and it could be reduced to one if it helps. I
remember you had a suggestion where we would lose always the first print
out on RT you said it is okay since you can't rely on that=E2=80=A6

> I'm fine with changing things up to accommodate RT, but not when the
> result is so obviously worse than before.

I don't think it is worse. This is your opinion and I did not hear any
other feedback so far.

> In my tests I can't see any latency difference with using raw spinlocks
> in random.c. Maybe I'm doing things wrong? But I'm not seeing anything
> change...

You need to look at the maximum latency that may happen. Also the other
thing is that there is no need to add raw_spinlock_t locking if it can
be avoided.

> Jason

Sebastian

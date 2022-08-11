Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2145A58F82F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiHKHPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiHKHPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:15:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2A113DC7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:15:14 -0700 (PDT)
Date:   Thu, 11 Aug 2022 09:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660202113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QY2Yyq+du5IRo4mGCp698lCeFw2c6TfXHwQ5Vo9Wcs=;
        b=AWC4af9zUWPBiSr75m3bG39wOJpMrDkD2rxS+nJul17x5BpZ74lTYD7hl9i9HbmW7k/Xxe
        oeK6g1shMvYBYqbCfARrbgUsVe5jH5LKH6i2AR3KUL0A9BeH6S5tsJ0xsetp/MROmt74m4
        fJUcwxUgHlGnTVbgCm0147kIRUSDRIhkNtbKFFMXbKqml3J8qyy5bUrD8LE43Id0ZTVjwB
        Cc/09dM4He25MMsQjdQnIkpacSHswUaZNt6kj9vZtjV7yrtNhhQBT25X8PU8LFT0P7bmdo
        FRppnN8ENwf+TJ4DNmH/usyiztuo9PQi7kui93m4SLz8Dny/UuH/vhs3WnApog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660202113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QY2Yyq+du5IRo4mGCp698lCeFw2c6TfXHwQ5Vo9Wcs=;
        b=Nzv/t4P58nMFckrhPQSu3IgkT97nKggP37ADREugdnXcMLvv3Xs2C9zZtLgCzPKQNgnApG
        XoEHuB+azgbstcAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <YvSsf5uds7zGgWPX@linutronix.de>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YvRKm/IpbUID18FK@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-11 02:17:31 [+0200], Jason A. Donenfeld wrote:
> Hey Sebastian,
Hi Jason,

> > > Sebastian - I won't move forward with this without your Ack, obviousl=
y.
> > > What do you think of this general approach? -Jason
> >=20
> > I would need to do worst-case measurements and I've been looking at this
> > just before writting the other email and there was a local_lock_t
> > somewhere which needs also change=E2=80=A6
>=20
> Did you ever come up some measurements here? It sure would be nice if I
> could apply this, but obviously that's contingent on you saying it's
> okay latency-wise on RT.

No, I did not. But I've been thinking a little about it. The worst case
latency is important now and later.
Looking at it, all we need is one init in vsprintf at boot time and we
are done. That is the third fallout that I am aware of since the rework
of get_random_*().
We managed to get rid of all memory allocations (including GFP_ATOMIC)
=66rom preempt/IRQ-off section on PREEMPT_RT. Therefore I am not convinced
to make all locks in random core a raw_spinlock_t just to make things
work here as of now.

> Jason

Sebastian

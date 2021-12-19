Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF1E47A012
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 10:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhLSJsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 04:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhLSJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 04:48:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD49C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 01:48:17 -0800 (PST)
Date:   Sun, 19 Dec 2021 10:48:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639907294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJo5ngX//6aS070Xxb0LcQst4uSm8Z+tELD2m1er/tc=;
        b=zOywKPcwtHuPZZVNCH7B7ay6DbcY5nzK8VyAYl8HwEC+FNc10PDCkfeoI4E3GOxT6gJpEf
        1rSD7bg7UoTI5CkwFTixwa6lrzSNZWLXLsU1jVCAayxt5Kj8HerNUz2yo1rBuOq9FOJ1rd
        RJmBgpRsMJrZrzQ+jOnmK79GT2MbM4ejm+h80uHn27CM0j0UtLf/6ioUQ9YIaQSVh1lsD9
        02qwKilgSGMv8VWQsJXY0PNIEJc27VQ/8YjiBRGgRO3jrgnZghwarjtQt96FnpOtaPpnQx
        F0EU6d4Vu6MaA+zgovvrZJ7HA9Cg8skjcbnyKqjxWb6JXARJQ4d6pgRzGv7ntQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639907294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJo5ngX//6aS070Xxb0LcQst4uSm8Z+tELD2m1er/tc=;
        b=+tpQS6k+NRZeRslMdggt5OtVWSlHjywz6DX3BLGIokkLTXonxNKFJwqnvIxUkJPg54gYQA
        s4Wt8i/PMzPiAbBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Jason@zx2c4.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
        tglx@linutronix.de, peterz@infradead.org
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <Yb7/3JUcDENyYySN@linutronix.de>
References: <20211207201037.h46573oa5nfj33xq@linutronix.de>
 <20211217022338.GA19411@gondor.apana.org.au>
 <YbxRxPdBDMu8KIy6@linutronix.de>
 <20211218032409.GA11425@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211218032409.GA11425@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-18 14:24:09 [+1100], Herbert Xu wrote:
> On Fri, Dec 17, 2021 at 10:00:52AM +0100, Sebastian Andrzej Siewior wrote:
> >
> > I'm sorry, I can't connect the dots here. I was trying to explain that
> > for the lock in question it is not possible to spin-wait without
> > disabling interrupts first.
>=20
> That's precisely the problem the socket lock was designed to
> solve.
=E2=80=A6
> Take a look at lock_sock/release_sock and bh_lock_sock/bh_unlock_sock
> in net/core/sock.c.

That one. I find the semantic difficult to understand. Some BH-user
check sock_owned_by_user(), some don't.
However, a semaphore should work. The atomic user would do
down_trylock() while preemptible caller would invoke down() and sleep
until the lock is available. Let me check if that works here=E2=80=A6

> Cheers,

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297334788F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhLQKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhLQKcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:32:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E6C061574;
        Fri, 17 Dec 2021 02:32:21 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639737139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coRV5ZNBwGl6+NLPdAs+oIme2PDUbD9PhGtonVLuDvw=;
        b=1BDlVgX8TeRyaMwO5cpXdSszypkVt2mCyYhtwbbCH78PSRJYn1gBJGRvrDylDNToYvbaU8
        jTHTqiPIZMsin7T4S+zE00iFVyxOm+JfJ2s/6xzTz0E+nK7qGAke29tp/8YoGDMAof3KWX
        ArLr2SUNTZeMnkbcJs5AL6c5xwloMWG6Vum10noMVmRxcXWf98r7REuqMWnFgM2iUSpfCk
        zCEt1HM32H4UrbYOmosbxpcbG/g9VONK6Yf7rdJ99XF5VGsO6nM0S51ePffPNKmvf0ke52
        VmnE57YIkjifFNdfHvxREyrCqoqCLLWyzIL8IlpBDpDYCSVLTSGhY8BW2TFGVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639737139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coRV5ZNBwGl6+NLPdAs+oIme2PDUbD9PhGtonVLuDvw=;
        b=NFj5RtyWE8dnDFEhSTT82h+vwbEz5/IpVkvS8crpV2x0PGj5u29K8CjMIOlAetUH4pfwcM
        /QbX1qG/jpLkuEDA==
To:     fcarli@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Bug in vhost-net with RT kernels with SMP
Date:   Fri, 17 Dec 2021 11:32:07 +0100
Message-Id: <20211217103209.1122679-1-bigeasy@linutronix.de>
In-Reply-To: <CAJuRqcAc19KZYik7T_dYFoqt_wX4QPHKBsh9A8BJwYE7uxs_1A@mail.gmail.com>
References: <CAJuRqcAc19KZYik7T_dYFoqt_wX4QPHKBsh9A8BJwYE7uxs_1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-15 16:44:12 [+0100], Florent Carli wrote:
> Hello all,
Hi,
=E2=80=A6

I tried to reproduce this but nothing. However=E2=80=A6

> If we try the experiment once again, the tap will fail but we won't
> get a new backtrace.

The backtrace is meant to appear only once.

> A first analyzis was done on the #linux-rt irc channel:
> "huh, looks like the underlying issue is hitting the WARN_ON_ONCE()
> condition in eventfd_signal(), but in the bug handler (which
> apparently is preemptible), we get into print_stop_info() and try to
> use smp_processor_id() in that context, which is wrong because thigns
> are preemptible.
> I can't see the smp_processor_id() usage in mainlin (I don't have an
> RT tree to hand), but someone with more RT knowledge might want to
> look at that"

So that smp_processor_id() thingy is sad because the code changed before
it hit upstream and I didn't notice it.
Patch #1 contains the missing bits and avoids the backtrace from
WARN_ON_ONCE().
Patch #2 is a backport from upstream avoiding trigger WARN_ON_ONCE in
the first place.
Could you please try these two if they help?

> Thanks.

Sebastian



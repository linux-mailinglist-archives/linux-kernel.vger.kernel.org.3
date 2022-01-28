Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5254249FD95
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiA1QEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:04:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47730 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiA1QEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:04:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9AA461EE0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E5FC340E6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:04:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CdJcfcLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643385867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7FKobJhoy7WUzr8IQkz4Rgy6lr68RmX0KGYKnV3Jq7A=;
        b=CdJcfcLOfzJ5JEQ/fL6px0XaBMVQJ1QF8rReA5bzI5xJo3ryKXdsfBXzjn1kmtbpJHrEqB
        1udybHl1Z1HityIxnFgmhHG9iOqbzww27iykrtAPjak0dz42s///dMUnqNSJrD0bwgDhhN
        Cnld6iFAOvk0c8oxQccrVHeExW6mAwQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3223b17e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 28 Jan 2022 16:04:27 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id g14so19772291ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:04:26 -0800 (PST)
X-Gm-Message-State: AOAM5301q/iJ3G4ozOxlfo2yZBPa305LFlgkcZPB4KfYfFPhbMFJgRJw
        L9coOMpm08ysCraLmx4FHQdEpjz/l4XJnsfU7Tw=
X-Google-Smtp-Source: ABdhPJz7lBHvwJwjzcVYDzmaYorqDYCZA6cOCAlHTPjQk3rucBn0pxiKQU7dcjGChsxx5YjN+Xi4Sad+FSndrkFl294=
X-Received: by 2002:a25:bd08:: with SMTP id f8mr6053390ybk.121.1643385864960;
 Fri, 28 Jan 2022 08:04:24 -0800 (PST)
MIME-Version: 1.0
References: <YfMa0QgsjCVdRAvJ@latitude> <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
 <YfOqsOiNfURyvFRX@linutronix.de>
In-Reply-To: <YfOqsOiNfURyvFRX@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Jan 2022 17:04:13 +0100
X-Gmail-Original-Message-ID: <CAHmME9qBj2gL=spp3AUEo-Ri4r0KQq-KrR-f6dG++xXQvzcA7A@mail.gmail.com>
Message-ID: <CAHmME9qBj2gL=spp3AUEo-Ri4r0KQq-KrR-f6dG++xXQvzcA7A@mail.gmail.com>
Subject: Re: "BUG: Invalid wait context" in invalidate_batched_entropy
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian/Jonathan,

On Fri, Jan 28, 2022 at 9:35 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> This report is due to CONFIG_PROVE_LOCKING=y _and_
> CONFIG_PROVE_RAW_LOCK_NESTING=y. It reports a nesting problem
> (raw_spinlock_t -> spinlock_t lock ordering) which becomes a real
> problem on PREEMPT_RT.

Hmm, I'm still having a tough time reproducing this. I'm trying to
understand your intuition. Is the problem you see that something else
in the IRQ path uses a raw_spinlock_t, and then with that lock still
held, we call invalidate_batched_entropy(), which takes an ordinary
spinlock_t, non-raw? And taking a spinlock-t while holding a
raw_spinlock_t is illegal?

Jason

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01834A9C18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359758AbiBDPjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:39:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38852 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359680AbiBDPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:39:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05633B837ED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D308C340EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:39:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QtCqnhwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643989169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQFCILD84RvGZYVRVF0fFfu13wbdQHH6Hd2HyA76xGY=;
        b=QtCqnhwCAbYZE3hOv9MWacmHZzcts6HUNbKkhWqof/KDRnA/oVRi8sAGLvK1mUBQBUk9lj
        cnSyxv7eU4hqP0WRwjIc2ZQIXH2R5W7/Vs+lXTxnaH1/5PwRsg9TxEB3yv6Q4655S066r3
        678xR7FNFij9EK1za7SV+v8KRjunCPk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id afb43c74 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 4 Feb 2022 15:39:28 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id c6so19933758ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:39:27 -0800 (PST)
X-Gm-Message-State: AOAM5326YdgSe83Scy9FGrcKwT/fDN7HEPrXsUm0OD6Od5OUQyUcNYik
        rmUwlEawJ3ioI3Z2OMGHG1iVNv0zJrnKaWkYESI=
X-Google-Smtp-Source: ABdhPJwLnTkRbh0yc/+TMgihvowkeFD85Y33I04apOr5cmbetxoEo1zgJRRUnlmQR0lKZaIgPBNTwiHPhLbxt0qo6f0=
X-Received: by 2002:a05:6902:14d:: with SMTP id p13mr3323253ybh.638.1643989166745;
 Fri, 04 Feb 2022 07:39:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com> <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
 <Yf0JlXf3ARsBpL9K@linutronix.de> <CAHmME9r0XxX3LqNLpVeqAjDQ_OVskPf15QOwxtZYy0tb_x_7HQ@mail.gmail.com>
 <Yf0xy4kZ2Mn65yp8@linutronix.de> <CAHmME9oOMhRVybTgHXT+oOXhMkdx7FVY7oSc-rHr=6AvZCVo=w@mail.gmail.com>
 <Yf04lcQIatnGspAb@linutronix.de>
In-Reply-To: <Yf04lcQIatnGspAb@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 16:39:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9pO41uwYExSROc5X2+RE=a5tZfE=c=bAxVbhCHfa7=zSA@mail.gmail.com>
Message-ID: <CAHmME9pO41uwYExSROc5X2+RE=a5tZfE=c=bAxVbhCHfa7=zSA@mail.gmail.com>
Subject: Re: [PATCH v2] random: remove batched entropy locking
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Feb 4, 2022 at 3:30 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > What if we keep a spinlock_t there on PREEMPT_RT but stick with
> > disabling interrupts on !PREEMPT_RT? I wish there was a solution or an
> > API that amounted to the same thing so there wouldn't need to be an
> > #ifdef, but I don't know what that'd be.
>
> If it is still to much try to look for locallock_t and
> local_lock_irqsave(). This is kind of like your local_irq_save() but
> you have lockdep annotations and PREEMPT_RT has a spinlock_t like
> behaviour. It also documents in-code what the scope of your locking is.

Oh, that's terrific, thanks! Sounds like exactly what we were looking
for. I'll respin this patch with that.

Jason

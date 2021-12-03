Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C56C4675D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbhLCLEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhLCLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:03:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C9C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 03:00:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w1so9891042edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 03:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Atm6kUPFrjqhMfEA8vYU4uHaSeCYZZiREgM4UQPf+EQ=;
        b=hYkDrQLefu5ul0S+UrYKK2S0d/yanoklGeTN/ksbQrEabnQMTFNe4SYDlw3uRFyoKR
         dt9GOWzBwdfzOzupKGmZ9B4DQlL/P21QJiLlvHM7hBrnWoPQQTYcZ59KP6nn5Uvxe+av
         Dquyh4msZ7751ixJwR0ZiJS7AeI4zeUSFVIYWjDe8sDOj1bJRS+xPNlOlTmALpSZmy+H
         88U4BWhP2c0r5FpMNfC1MtVgi+ir47luWjaayL1fLsfrufPjEt/tWVW44seBp1I9W/Hs
         SNE4gfUmlll7GGZxSMBwvKap8AvTt527rek7blPInh0ZCO2Y+CKGo5g56QaUIM20DWc6
         gcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Atm6kUPFrjqhMfEA8vYU4uHaSeCYZZiREgM4UQPf+EQ=;
        b=qokdRZ/Fi/hmKc4S8O44korJO3nLv5aYFyUe2o+Szqu6hvkej2f+GId9rf3ih5uLHX
         R9VYSm1cuKUBtaGWGyZ+4oSt6INf1xa4/dYVupPrlZ6qYgqrx2oWFbIdeBhOcWN8KAYI
         VY01FOBQuaC7PoqhKlg6cK0y4TRZWNnorKWtDZ2287aLi+aIMsNG/mdcP+0PvCiQ1mba
         +6cIJTQEdN2Kxrk1gedDq9Y/2UOzhih/wTOGMpOQqJFNnwn6zrqVQZwx2Uw6989YP12Z
         kn1zjUSzi9aUUzm7OJNcs0TjErxHmBFa12Mc4vtGuCMoT++jzgaI4vDYhPKPFryWy2bx
         N7qg==
X-Gm-Message-State: AOAM531WcL7Q/xf7WcAExzk4Usfuvqm0Hitb+V28voGab0ITiMNVZz8P
        U7B6QzRV1QXKezi4L65xn+4=
X-Google-Smtp-Source: ABdhPJzusLijj9H2edDfF5wbJaBKimd55M/CoHJ3VeCm3kuAFVE19JbVcaFcGUaDEZYSltN+3j9HTA==
X-Received: by 2002:aa7:d652:: with SMTP id v18mr25392679edr.68.1638529233931;
        Fri, 03 Dec 2021 03:00:33 -0800 (PST)
Received: from localhost.localdomain (host-95-239-199-20.retail.telecomitalia.it. [95.239.199.20])
        by smtp.gmail.com with ESMTPSA id jg32sm2000794ejc.43.2021.12.03.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 03:00:33 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
Date:   Fri, 03 Dec 2021 12:00:11 +0100
Message-ID: <3017492.JFOoIcAZ2s@localhost.localdomain>
In-Reply-To: <CAHk-=wiXNJ86W=gwAHH1qd+cE9dmfk_dEKFmNa89XH19NhPNkg@mail.gmail.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <86452127-70e8-c0cf-de18-6f98e77849a6@i-love.sakura.ne.jp> <CAHk-=wiXNJ86W=gwAHH1qd+cE9dmfk_dEKFmNa89XH19NhPNkg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 2, 2021 7:35:16 PM CET Linus Torvalds wrote:
> On Thu, Dec 2, 2021 at 7:41 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > > Looking at the backtrace, I see
> > >
> > >    n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
> > >    tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
> > >    __start_tty drivers/tty/tty_io.c:806 [inline]
> > >    __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> > >
> > > and apparently it's that hdlc line discipline (and
> > > n_hdlc_send_frames() in particular) that is the problem here.
> > >
> > > I think that's where the fix should be.
> >
> > Do you mean that we should change the behavior of n_hdlc_send_frames()
> > rather than trying to make __start_tty() schedulable again?
> 
> I wouldn't change n_hdlc_send_frames() itself. It does what it says it does.
> 
> But n_hdlc_tty_wakeup() probably shouldn't call it directly. Other tty
> line disciplines don't do that kind of thing - although I only looked
> at a couple. They all seem to just set bits and prepare things. Like a
> wakeup function should do.
> 
> So I think n_hdlc_tty_wakeup() should perhaps only do a
> "schedule_work()" or similar to get that n_hdlc_send_frames() started,
> rather than doing it itself.
> 
> Example: net/nfc/nci/uart.c. It does that
> 
>         schedule_work(&nu->write_work);
> 
> instead of actually trying to do a write from a wakeup routine
> (similar examples in ppp - "tasklet_schedule(&ap->tsk)" etc).
> 
> I mean, it's called "wakeup", not "write". So I think the fundamental
> confusion here is in hdlc, not the tty layer.
> 
>               Linus
> 
This is what I understand from the above argument: do a schedule_work() to get 
that n_hdlc_send_frames() started; in this way, n_hdlc_tty_wakeup() can
return to the caller and n_hdlc_send_frames() is executed asynchronously 
(i.e., no longer in an atomic context). 

I hope that I'm not missing something. If the above summary is correct, 
please forgive a newbie for the following questions... 

Commit f9e053dcfc02 ("tty: Serialize tty flow control changes with flow_lock") 
has introduced spinlocks to serialize flow control changes and avoid the 
concurrent executions of __start_tty() and __stop_tty().

This is an excerpt from the above-mentioned commit:

->
    Introduce tty->flow_lock spinlock to serialize tty flow control changes.
    Split out unlocked __start_tty()/__stop_tty() flavors for use by
    ioctl(TCXONC) in follow-on patch.
<-

This is the reason why we are dealing with this bug. Currently we have __start_tty() 
called with an acquired spinlock and IRQs disabled and the calls chain leads to 
console_lock() while in atomic context.

In summation, my questions are... 

1) Why do we still need to protect __start_tty() and __stop_tty() with spin_lock_irq() 
if the solution to the bug is to execute n_hdlc_send_frames() asynchronously?

2) If it is true that we need to avoid concurrent executions of __start_tty() and 
__stop_tty(), can we just use a Mutex in the IOCTL's helper?

Thanks,

Fabio M. De Francesco



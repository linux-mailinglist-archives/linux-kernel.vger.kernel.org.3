Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148874669D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376618AbhLBSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhLBSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:38:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F5C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 10:35:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w1so1697623edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 10:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5n0op7WCKcxHWiREW25LxgHJF3lzy1KCTqw6Ak/eLE=;
        b=fiO6PFUqhj645PeG1SvnU2IRU7MEzQmQ+x4DMqO/KYuk+cUNxKRRL3RV4FL8Is70yQ
         GfLN1PnAzxJow2Y8F1nqooY2sv3XCr53M6Kaq4tBO+PyVVuAMIoM2Si7h971wzsBRU/l
         0uEL8BCq3qlCXYwqLzZ4Xg6z7If+h6Sb8VqZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5n0op7WCKcxHWiREW25LxgHJF3lzy1KCTqw6Ak/eLE=;
        b=F1Tbp1qMLRcx8e0WtrStPdfEKJ7Gpqp5wmq7Claf8D7y2sekKdWjpHLxU5sf5w4XVL
         RKz8xchizg34o4JWPzL/p3+3FQltDVUXJg0aJWPNYbBCNGU11rotAZZNJ/0NUFSJylLr
         IB+F04kHx19Bfra8LSM0PN07cM4HMBiqzUir2OipgaYW+C5qsK+Y1fa0n8Q21mfrMBw2
         eXq1vv4j8g//BAQUUSSL9ldkjKh3VsIWdrSfkfBLVjE3pe1FLCtAAe5KwWy39ZACAsxw
         s8k5/qDPGBjyNc0VWqILsjmfjRKDr1F+mjD5M856Z9h9h5FRfY/nxixfT0XHIvpwDYsr
         qpOQ==
X-Gm-Message-State: AOAM532rqMvpErRWonRcDQS2youM9iG/2A8lVO/SM8ztXeEDHaRT56aP
        +iiFQSXhQZ5/rujsGrA72tzUI7HjcZ5AW3pE
X-Google-Smtp-Source: ABdhPJwJFYVoOExRrv4pROeHb/PBI7XfjbZM8gEIPC+h/Q1abSvIlPNyc2Qm2MkFBEjO9ijsyoN2Ew==
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr20161460edd.314.1638470133467;
        Thu, 02 Dec 2021 10:35:33 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id ht7sm387873ejc.27.2021.12.02.10.35.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 10:35:32 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id q3so676445wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 10:35:32 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr16399753wrn.318.1638470132223;
 Thu, 02 Dec 2021 10:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <1825634.Qa45DEmgBM@localhost.localdomain> <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
 <1701119.OD4kndUEs1@localhost.localdomain> <1d05e95c-556a-a34c-99fd-8c542311e2dd@i-love.sakura.ne.jp>
 <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
 <CAHk-=wjVL_CLm-+=7qf2obF6f8D+ujysmqp5dKdAb7UEyo1cZg@mail.gmail.com> <86452127-70e8-c0cf-de18-6f98e77849a6@i-love.sakura.ne.jp>
In-Reply-To: <86452127-70e8-c0cf-de18-6f98e77849a6@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Dec 2021 10:35:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXNJ86W=gwAHH1qd+cE9dmfk_dEKFmNa89XH19NhPNkg@mail.gmail.com>
Message-ID: <CAHk-=wiXNJ86W=gwAHH1qd+cE9dmfk_dEKFmNa89XH19NhPNkg@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 7:41 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> > Looking at the backtrace, I see
> >
> >    n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
> >    tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
> >    __start_tty drivers/tty/tty_io.c:806 [inline]
> >    __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> >
> > and apparently it's that hdlc line discipline (and
> > n_hdlc_send_frames() in particular) that is the problem here.
> >
> > I think that's where the fix should be.
>
> Do you mean that we should change the behavior of n_hdlc_send_frames()
> rather than trying to make __start_tty() schedulable again?

I wouldn't change n_hdlc_send_frames() itself. It does what it says it does.

But n_hdlc_tty_wakeup() probably shouldn't call it directly. Other tty
line disciplines don't do that kind of thing - although I only looked
at a couple. They all seem to just set bits and prepare things. Like a
wakeup function should do.

So I think n_hdlc_tty_wakeup() should perhaps only do a
"schedule_work()" or similar to get that n_hdlc_send_frames() started,
rather than doing it itself.

Example: net/nfc/nci/uart.c. It does that

        schedule_work(&nu->write_work);

instead of actually trying to do a write from a wakeup routine
(similar examples in ppp - "tasklet_schedule(&ap->tsk)" etc).

I mean, it's called "wakeup", not "write". So I think the fundamental
confusion here is in hdlc, not the tty layer.

              Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9371546A3CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbhLFSLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhLFSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:11:19 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20BEC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:07:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w1so46514551edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTJiZIaQwebHRw7XLCmIswlkifktVI7qs9JypXs1rb0=;
        b=CzbYi2jqjBoHimgtG2tPMJSTHj+NXDqfAFKT9jY65tPFYvZBbG1O/xeGGyjJuF1s4Y
         CK9hCtu2ViffdxqcAd3bv+LTFIo27Ucsuq8DTk3YaWdcupV7+6kgaiqAhShq6ljRh5JV
         PbeMafZEjS+bOaxucqZ6pVwV3BxM5ZTN4tuY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTJiZIaQwebHRw7XLCmIswlkifktVI7qs9JypXs1rb0=;
        b=fPdQ/TUuS1n3NWyBGuCqoi4DojjrTW2A6OWTrp99BuQlaC7rWk95JkJMiq7WLvJOdZ
         VHzo48JD4QflP+/Oty12qzBCExIu72cn2WhR+pcpy0HPoI8vxeP8iC9pPiN5Yr/cek5X
         nm9syjeYPdANgc+fP/gNHjrJTOn39/ZPD9lr2ttqpbB8S03bA1RqCcFA4q90j+dBVdwB
         uJo5ysmWvfHmNU/rIfI/ooMLCq7dRDN14AX7qGVxZygVwWVYvvZpGBWqknIF4QpI1HhP
         BnICbUVdxUoHNTmrIqkyizv4o+B7xMrP6frAzO/hxmJrPjsF5sfyw25JqWCeWMnk+kae
         xVlw==
X-Gm-Message-State: AOAM530E8GjGUIhyApk9+3ukytO6d/eu7FBIGzWn/CNXYSihLZvjlxoV
        D6XfNq+I0dqB9E1gYwpbzlRth6h9AI0tBmJA
X-Google-Smtp-Source: ABdhPJylPA8Kl5LR/fa7wBGr7JqZKMurB/KLE0UdQXfxrHGQ7ofoHX1exfHyna5UuuXpzbO6RNoyEw==
X-Received: by 2002:a50:e102:: with SMTP id h2mr910048edl.298.1638814067828;
        Mon, 06 Dec 2021 10:07:47 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id q7sm8293884edr.9.2021.12.06.10.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 10:07:47 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso444997wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:07:46 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr142540wms.144.1638814066425;
 Mon, 06 Dec 2021 10:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <e2f074e2-b19e-da5b-9db9-c0b4142de618@i-love.sakura.ne.jp>
In-Reply-To: <e2f074e2-b19e-da5b-9db9-c0b4142de618@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 10:07:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=winHP_cXTJvJzeudgq-xCnWQPmVp0_O6wT9nFsFNQYrkQ@mail.gmail.com>
Message-ID: <CAHk-=winHP_cXTJvJzeudgq-xCnWQPmVp0_O6wT9nFsFNQYrkQ@mail.gmail.com>
Subject: Re: [PATCH] tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 3:45 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Linus suspected that "struct tty_ldisc"->ops->write_wakeup() must not
> sleep, and Jiri confirmed it from include/linux/tty_ldisc.h. Thus, defer
> n_hdlc_send_frames() from n_hdlc_tty_wakeup() to a WQ context like
> net/nfc/nci/uart.c does.

Thanks, this looks good to me.

That said, I think there's pretty much the *exact* same pattern in

    drivers/net/caif/caif_serial.c:
        write_wakeup() causes "handle_tx()", which then calls tty->ops->write().

    drivers/net/hamradio/mkiss.c
        mkiss_write_wakeup() -> tty->ops->write()

    drivers/tty/n_gsm.c:
        gsmld_write_wakeup -> gsm_data_kick() -> gsmld_output ->
gsm->tty->ops->write()

so this does seem to be a common bug pattern for code that has never
really seen a lot of testing.

The core tty stuff seems to get it right, but maybe I missed something
in my quick "grep and look for patterns".

So I think this patch is good, but I do wonder if perhaps we should
move the "work_struct" into the tty layer itself, and do the whole
"schedule_work()" at that level.

Some code never wants it (most notably the regular n_tty one), but at
least n_tty doesn't really care, I suspect. n_tty is using
write_wakeup() literally just for fasync handling, so I suspect it's
not exactly going to be performance-critical.

Of course, maybe the fix is to just fix caif_serial/mkiss and n_gsm.
Or mark them broken - does anybody use them?

              Linus

             Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD94E7E35
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiCZAiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 20:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiCZAiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:38:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111EC24059B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:36:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bt26so15933377lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcshdobGzILllMY3zNpnZ3Ex5ohCbZSLroaY3F9W/JA=;
        b=dTex8E2DlnTcTjb24xecx3Rs17SSDlOTb2q2dyGoe4UMrbGwJxoqMFipPFX1dMVeta
         WXHrs1YXfFuOjUXiXABz7YSdikeLsyKoFKm9th2ytRWjAyczdZsos502VTEaIp/Z+TxG
         Bge3mQs/tQgKvKYn5r8VcKJQjSjngfGK4Akfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcshdobGzILllMY3zNpnZ3Ex5ohCbZSLroaY3F9W/JA=;
        b=hbhLLtyRJxweIIEKzWdbfoyuFLb5EJR8Q/VFo8GoA0hYWUGq8LDM0L1LfuO9kOrrQS
         eeEHn48Ag5r61ebXxrPQV61zsMrJaagTDtaSIVoa5lTnk1zq8sq5sp7tcKQoGD4bjDBE
         7eQKWnIbwt4BQpjf3MrkYMdg769g4rYTrI5NWG6POawzsP5OPZoB/W20Ui4sYdDgwix+
         62n/EPeADnSBTKuRS/mPem0v4l64tVkc1pfmcgjBjkOvZKGYYw/YywneDEKPd8qqoARL
         emd97uiM2psCqHbsOryEQv8J/w26/iik9WPtnEmCR7nON4B/4qBy9ZrDlqZFF1G90fbt
         X58A==
X-Gm-Message-State: AOAM532l2FwWWGjoVv45gMLwkvoPIbhUXAp6Wr2nQ1pCYpL3dJgNCVxB
        j6lFQ+PVsrjlvE+nikFv7E7hkSIf//6oCOyO9Pk=
X-Google-Smtp-Source: ABdhPJyrczGHBHi7+nwL6nj76K4sT4vLcQA2u0GAWMRJypPfclFhwiFrVG+4T7YZ3KbgZ720RcIG8w==
X-Received: by 2002:a19:d61a:0:b0:43f:1a03:21ee with SMTP id n26-20020a19d61a000000b0043f1a0321eemr10085350lfg.152.1648255005038;
        Fri, 25 Mar 2022 17:36:45 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id j11-20020a056512108b00b0044a23c1e679sm868943lfg.18.2022.03.25.17.36.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 17:36:44 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id c15so12274746ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:36:43 -0700 (PDT)
X-Received: by 2002:a2e:a5c4:0:b0:249:9ec3:f2b with SMTP id
 n4-20020a2ea5c4000000b002499ec30f2bmr10061179ljp.358.1648255003631; Fri, 25
 Mar 2022 17:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220325172036.3f8f619e@gandalf.local.home>
In-Reply-To: <20220325172036.3f8f619e@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 17:36:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTL=vz2PC7=dFZVrT=9nuBtZ21j_qT8e=yHvVuXvhCdg@mail.gmail.com>
Message-ID: <CAHk-=wjTL=vz2PC7=dFZVrT=9nuBtZ21j_qT8e=yHvVuXvhCdg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Workaround fix for hard hang on guest using fifos
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 2:20 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> With the updates to change the size being passed in the splice from
> page_size to pipe_size, this never finished (it would copy around a meg or
> so). And stopped. When I killed the agent-fifo task on the guest, the guest
> hung hard.

Without knowing (or really caring) at all how virtqueue works, this
sounds very much like the classic pipe deadlock where two processes
communicate over a pair of pipes, sending each other commands, and
replying to each other with status updates.

And you absolutely cannot do that if one side can possibly want to up
fill the whole pipe.

Deadlock:

 - process A is trying to send data to process B (on 'pipe_A'), and
blocks because the pipe is full

 - process B is reads the data and everything is fine, and A gets to continue

 - but then process B sends some stratus update the other way (on
'pipe_B' - you can't use the same pipe for bidirectional, it's why you
use a pair of pipes or a socketpair) and waits for the result.

 - now A and B are both waiting for each other - A is waiting for B to
empty the big bunch of data it's sending, and B is waiting for the
result for the (small) command it sent.

and neither makes any progress.

You can find several mentions of these kinds of problems by just
googling for "bidirectional pipe deadlock" or similar.

The solution is invariably to either

 (a) make sure that nobody writes even remotely close to enough data
to fill a pipe before reading the other pipe (you can still fill up a
pipe, but at least somebody is always going to succeed and make
progress and do the read to make progress).

 (b) make sure everybody who writes to a pipe will use nonblocking IO
(and is willing to do reads in between to satisfy the other end).

That first case is basically what one of the PIPE_BUF guarantees is
all about (the other one is the atomicity it guarantees, ie you can
write a "command packet" and be guaranteed that readers will see it
without data mixed in from other writes).

I have no idea what your client/agent does and how it interacts with
the virtio pipes, but it really _sounds_ like a very similar issue,
where it used to work (because PIPE_BUF) and now no longer does
(because pipe filled).

And that virtio_console __send_control_msg() pattern very much sounds
like a "send data and wait for ACK" behavior of "process B".

              Linus

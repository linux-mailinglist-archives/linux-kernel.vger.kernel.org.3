Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EACC4ACBB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbiBGV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiBGV5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:57:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C22C06109E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:57:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B1C615D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F4AC340F1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:57:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PiMVGtX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644271070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9r/q0NAcQxwYCCZk1yFqi/sFfxTN8cr0KnX5Fg2puEk=;
        b=PiMVGtX8evEWNLiggNdjaaRdwFKBPYUdYeNV44qcisiwO4zAaLdKy8Xh8EMMzQHkWg+X/P
        UlNkqd/s4w+8AmbtcRvXxWQRveetpJ3BCJypG+10qer7o5Me6LR2jHcQLjqz/FQl86TCAb
        YZ8e39reke8yEoNQo9c01KVmEJYQQZg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3f16a0ab (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Feb 2022 21:57:50 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id bt13so20261056ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:57:49 -0800 (PST)
X-Gm-Message-State: AOAM532A+3DuHY1rWpS2l947v4Vmo9Laj6wgnD3m9Bt2Dae7dfMbuxMc
        uRLaX7dGRTPQl92XkJx1iC10Hf0mkETSFXOHl60=
X-Google-Smtp-Source: ABdhPJxnaeiBVQKmBumoZUIDMxlAwGiEOjzDfNzW8CS+7gcJX1xtKl6LXnLTeAg7OpXcXgTh1tDxnI6qm1MFelowxPQ=
X-Received: by 2002:a81:1b54:: with SMTP id b81mr2089864ywb.404.1644271068571;
 Mon, 07 Feb 2022 13:57:48 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
 <CAG48ez2P9-CAdgRizcp5T_uuoXRAt0xtodh1doiMW0fKZVX-7g@mail.gmail.com> <CAG48ez3wZOZZX1UHM-Q=KhOnnGR85Unm08q7jT_wVfOq0PW94Q@mail.gmail.com>
In-Reply-To: <CAG48ez3wZOZZX1UHM-Q=KhOnnGR85Unm08q7jT_wVfOq0PW94Q@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 7 Feb 2022 22:57:37 +0100
X-Gmail-Original-Message-ID: <CAHmME9oaj5g==Rhq6HvrxSHHfo-v1whdzwWTWFqmrDw8sBHqoA@mail.gmail.com>
Message-ID: <CAHmME9oaj5g==Rhq6HvrxSHHfo-v1whdzwWTWFqmrDw8sBHqoA@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     Jann Horn <jannh@google.com>
Cc:     pmenzel@molgen.mpg.de, "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 10:50 PM Jann Horn <jannh@google.com> wrote:
> > But the "lfsr" variable is never accessed outside the part of this
> > method that holds a global spinlock. So that can't really be it,
> > right?

Oh, hm, yea. Seems likely.

>
> There is a data race in crng_ready(), it just loads from "crng_init"
> without READ_ONCE()... maybe that's what KCSAN is noticing?

There are lots of data races in crng_ready(), which Dominik has been
fixing up gradually (which is why I CC'd him). However, crng_init is 4
bytes, and that crng_init is read first with a cmpl that will read the
whole thing. Maybe KCSAN's reporting is wrong? But it also says 0x00
-> 0x43, which isn't one of the assigned values of crng_init. Also,
0x20d seems quite far into the body of add_device_randomness, whereas
crng_ready() is checked sort of early on.

Hopefully Paul will send us his vmlinux.

Another possibility is that this is happening on the u8 read of the
buffer *input*, of what release_task->__exit_signal is passing it:

       add_device_randomness((const void*) &tsk->se.sum_exec_runtime,
                             sizeof(unsigned long long));

I haven't yet looked at the locking around tsk->se.sum_exec_runtime.

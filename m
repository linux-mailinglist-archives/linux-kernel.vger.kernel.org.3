Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584F1483508
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiACQnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiACQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:43:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E083EC061792
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 08:43:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BFB5CE11EF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A61BC36AEF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:43:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BQCjS+z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641228186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ksj+83Zg66NAd9SKdYlQT9eShZbJAxDn/skt1IfP2zQ=;
        b=BQCjS+z4uCEb+4+fqan9Wy/URftQNZS3GaEuC/vU5+ludq54XEgwmozCDL3l4wwcnBXeif
        n8v1z4CAgcvIR4DJghP0+qjp4mYR0t1vQ7K8BZa4z5rEfzec2oZ9xNyoxpyt1msYpraaIp
        dTJ9IzC/5EeS4rDkcI54JAXyXo5BRzk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7b067fc5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 3 Jan 2022 16:43:06 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id w13so66769732ybs.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:43:06 -0800 (PST)
X-Gm-Message-State: AOAM531WnglqOT5wORQdKwpo7WvJZ9myYyfxtYLvFBZc93MEC5G5qfoh
        A3PfTzdqccsZ7G7CMDgkRB/n+ULe1gF5sRAcj90=
X-Google-Smtp-Source: ABdhPJxGh1R2Kmh8/QgRzZvxLxyla3eFEHbfpN+02u8V+36rbVzZ195kT3lzsAQAkzRKXPQKKIEoJjg66GSV52tx/Mg=
X-Received: by 2002:a25:e6c5:: with SMTP id d188mr44839947ybh.638.1641228185555;
 Mon, 03 Jan 2022 08:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20220103155931.411722-1-jannh@google.com> <CAHmME9otnT=XeMPGYW5H8TOu9aLxxKi6_gT-Fnvh5Jy+WM-HGA@mail.gmail.com>
 <YdMmnnAkLpk81mYN@mit.edu>
In-Reply-To: <YdMmnnAkLpk81mYN@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 3 Jan 2022 17:42:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9rX5ZnhnO=tBWqZrXwm7xNEdQDptt4FEwzJK_-GVhyerg@mail.gmail.com>
Message-ID: <CAHmME9rX5ZnhnO=tBWqZrXwm7xNEdQDptt4FEwzJK_-GVhyerg@mail.gmail.com>
Subject: Re: [PATCH] random: Don't reset crng_init_cnt on urandom_read()
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jann Horn <jannh@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 5:39 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jan 03, 2022 at 05:03:57PM +0100, Jason A. Donenfeld wrote:
> > On Mon, Jan 3, 2022 at 4:59 PM Jann Horn <jannh@google.com> wrote:
> > > This code was inconsistent, and it probably made things worse - just get
> > > rid of it.
> >
> > Rather than adding crng_init_cnt=0 if crng_init<1 to extract_crng_user
> > and get_random_bytes, getting rid of it like this seems probably okay
> > and makes the model simpler. I'll apply this. Thank you.
>
> Ack.  It does mean that we're making a choice that an attacker who is
> carrying out a incremental state tracking attack on the CRNG will make
> /dev/urandom (and getrandom) to make the crng emit "less secure" in
> the period when crng_init is > 0 and < 2.  On the other hand, this
> allows us to get to the state of crng_init=2 faster, where as before,
> the attacker could delay getting us to the state crng_init=1 forever,
> where reads from /dev/urandom would be hence be insecure forever (and
> getrandom() would block forever).

Right. I had a few early drafts of this commit where I was trying to
protect the 0->1 transition from being bruteforced with a trickle of
entropy, and Jann's offline comment was something along the lines of,
"why do we actually care about crng_init==1? it's not secure anyway,"
which seems compelling. Plus, as you point out, letting anything reset
crng_init_cnt (like /dev/urandom reads) means unprivileged userspace
can delay crng_init==2, which seems like a bigger deal.

Jason

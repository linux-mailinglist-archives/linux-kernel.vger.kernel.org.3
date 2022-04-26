Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D9510704
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351596AbiDZSep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351442AbiDZSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:34:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F41EC6F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:31:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 17so23131439lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSl7xq4Yk/sCSUVQJxnflrAuEW8yu3ogjHhbkJ5P7LA=;
        b=dRP5kVaPhv7uXQaMU3WPjlVw8AOep2dU2/Aoe0juIbXqkm+Q1rP98k5fveXFE5Bjht
         CB0SCyJImc0f8R/QSga8jOUKsar+In/qlIh0aK5y8pyfWaXpAAu6DgnfxV9x8lztKBUS
         SFGvXhvSsS40f8/2a+WntbgrcpkIFvT2aTya4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSl7xq4Yk/sCSUVQJxnflrAuEW8yu3ogjHhbkJ5P7LA=;
        b=Gm8BKSXP6wRndii+62zmvldPRpi7s9k7DvZpl1AmAwTXwCxkLaX8yxRBMl5WhJnS1y
         AIqi3o+8O+Ocf8ha4nrQAYekEyPQ7h67YF+4CDTyjFHayRAhfDJ+gV2KAO3fRBNvgu4t
         uvA+1NwRjCYe6ejaQHmeMidqVl35exXqYA805BDUgRQeNX8O/L8dNj5PPnY98MV8s6HC
         0qDBuR22VHhlmgHasFB0g3MrcN15lGk7KZKTXyPLfN27mH3o87WQbMPNMzTxfe0c69sc
         O01IZrJBqoWv0keZra0LBiTHe3aC9/IT0R+PUyiXHPW8nramSispUWr/mdsjFryOVHLI
         lDvg==
X-Gm-Message-State: AOAM530SCdayiiIdjhxwsG6/6iCDv/X5t+HltR3RakmZJLDqx/0EUdwc
        1Rbb8ySrCz/0D3QhYLxIjHpSioppNIYtN6P8
X-Google-Smtp-Source: ABdhPJySZn6ld+hPISEkp8CK133X4/CDGb4byIi3aAdgAH1Y3VFb7bpQVSNUkMRSOA5cwJqpE01nVw==
X-Received: by 2002:a05:651c:555:b0:24f:221f:3ff5 with SMTP id q21-20020a05651c055500b0024f221f3ff5mr2410279ljp.389.1650997879199;
        Tue, 26 Apr 2022 11:31:19 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id f11-20020ac2498b000000b0047223ff0224sm97551lfl.169.2022.04.26.11.31.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 11:31:18 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id t25so33439912lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:31:18 -0700 (PDT)
X-Received: by 2002:a05:6512:1083:b0:472:1013:aad1 with SMTP id
 j3-20020a056512108300b004721013aad1mr5403728lfg.52.1650997877977; Tue, 26 Apr
 2022 11:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com>
In-Reply-To: <20220426145445.2282274-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Apr 2022 11:31:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
Message-ID: <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 7:54 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Also, note that we're fighting with a rare case of data corruption that
> seems to have been introduced by commit 00bfe02f4796 ("gfs2: Fix mmap +
> page fault deadlocks for buffered I/O"; merged in v5.16).  The
> corruption seems to occur in gfs2_file_buffered_write() when
> fault_in_iov_iter_readable() is involved.  We do end up with data that's
> written at an offset, as if after a fault-in, the position in the iocb
> got out of sync with the position in the iov_iter.  The user buffer the
> iov_iter points at isn't page aligned, so the corruption also isn't page
> aligned.  The code all seems correct and we couldn't figure out what's
> going on so far.

So this may be stupid, but looking at gfs2_file_direct_write(), I see
what looks like two different obvious bugs.

This looks entirely wrong:

        if (ret > 0)
                read = ret;

because this code is *repeated*.

I think it should use "read += ret;" so that if we have a few
successful reads, they add up.

And then at the end:

        if (ret < 0)
                return ret;
        return read;

looks wrong too, since maybe the *last* iteration failed, but an
earlier succeeded, so I think it should be

        if (read)
                return read;
        return ret;

But hey, what do I know. I say "looks like obvious bugs", but I don't
really know the code, and I may just be completely full of sh*t.

The reason I think I'm full of sh*t is that you say that the problem
occurs in gfs2_file_buffered_write(), not in that
gfs2_file_direct_write() case.

And the *buffered* case seems to get both of those "obvious bugs" right.

So I must be wrong, but I have to say, that looks odd to me.

Now hopefully somebody who knows the code will explain to me why I'm
wrong, and in the process go "Duh, but.." and see what's up.

                  Linus

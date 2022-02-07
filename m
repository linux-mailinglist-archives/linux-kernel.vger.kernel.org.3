Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28134ACBAC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbiBGVx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243125AbiBGVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:53:55 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6687FC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:53:54 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id m24so1253550vsp.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MZoxFRvZLtE78B5cO8zLm8LUZTFDo8eBlF4th5Z8TU=;
        b=nv6DeQ7eDp+p7RvS8HJJVgnP86CxRUEh4vAK7+9GxxBd97xBtdHs5xLWK6c+d8rxya
         +Ik/zpubAjruv8wOc4qkZ6VQDdb4lCPMajxYrw/k9QHrWLGdyeq7D7NNaPUO0HA+vJ4x
         uGg5XhysX+/yRN2kv/XJcw3vqHL6m5NTciHJhPUkzPJZo2RNocurL8v/DUol+OKg+wP0
         YnTvbbY+zG+dZRl6m6/86p++Nowt+kMxBKtMLIFsxV3VPVyzQUR+ymz2EdPk8dTtu/m4
         OiKt4yT2cNuh6hDx4u6B5DpkjjxzeSYt7VQfK2ONdtteRNNhyR9kGw70ueeGJYQ+ZqJO
         hHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MZoxFRvZLtE78B5cO8zLm8LUZTFDo8eBlF4th5Z8TU=;
        b=tA2h4x97I0C8st6Ez7QkTjdafG4fV3O43yRH/UYtbeYNdSBNamo6gBf0TxtAX7YrtK
         HPRUai8jUy/JTMl/UWdN9Nbe98/qvbF525NUqd8yvVtnxOJi6nSAnL7o27zSpLwVY1LJ
         MD6MoeedIWVNkORy1MEpUbCrQ89FJGXyB2q2JWs7eAm9soZ2zgeBmLyToT/5NF55j3Yk
         K2aIUcUbNtgMBH+VV3ZCHfez3HHomBk+/oOwzs2ZLD4Y4DE4K4bxAWRFEQ09S2+XShlC
         qL2vqRmze2l6O6QtYBccT06wJK69WzvwUyV4ks8VQPjI5BBbz/DWjyMJqdQPiNrrP0IF
         IS/Q==
X-Gm-Message-State: AOAM533ddzi1uDQLTzw435EUqHAc5YitbLqRfIcvxHrl1UQBOOfY8TFY
        QR1r90rIx/0EvT2j+PijhwAi9x1JdK5CE/8qR77bjQ==
X-Google-Smtp-Source: ABdhPJxxxjucXjjpy0ROP3LvftnHao4Nfpoq0deCl9IbqhO2sUZmJ4Ky6S5/FY8mXNI/nPg0ih0U900I/M9DpvT72g0=
X-Received: by 2002:a05:6102:3590:: with SMTP id h16mr583187vsu.63.1644270833471;
 Mon, 07 Feb 2022 13:53:53 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
 <CAG48ez2P9-CAdgRizcp5T_uuoXRAt0xtodh1doiMW0fKZVX-7g@mail.gmail.com> <CAG48ez3wZOZZX1UHM-Q=KhOnnGR85Unm08q7jT_wVfOq0PW94Q@mail.gmail.com>
In-Reply-To: <CAG48ez3wZOZZX1UHM-Q=KhOnnGR85Unm08q7jT_wVfOq0PW94Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Feb 2022 22:53:27 +0100
Message-ID: <CAG48ez0pWnrUpTN5rAs4zcHX4EBAWvNT1hL+MFLVxGin49Ttkg@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     pmenzel@molgen.mpg.de, "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 10:50 PM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Feb 7, 2022 at 10:45 PM Jann Horn <jannh@google.com> wrote:
> > On Mon, Feb 7, 2022 at 7:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > Thanks for the report. I assume that this is actually an old bug. Do
> > > you have a vmlinux or a random.o from this kernel you could send me to
> > > double check? Without that, my best guess, which I'd say I have
> > > relatively high confidence about, is that the "1 byte read" is
> > > actually a `movzx eax, cs:lfsr` referring to the `static u8 lfsr`
> > > here, which gets inlined into add_device_randomness:
> > >
> > > static int crng_slow_load(const u8 *cp, size_t len)
> > > {
> > >     unsigned long flags;
> > >     static u8 lfsr = 1;
> > >
> > > This was added in 2008 with dc12baacb95f ("random: use a different
> > > mixing algorithm for add_device_randomness()"). My understanding is
> > > that the race here isn't super problematic as we're in kind of a half
> > > assed "low effort" phase anyway. But I'll give it some thought. I'm
> > > CCing Jann as well who reported the original issue that motivated that
> > > change.
> >
> > But the "lfsr" variable is never accessed outside the part of this
> > method that holds a global spinlock. So that can't really be it,
> > right?
>
> There is a data race in crng_ready(), it just loads from "crng_init"
> without READ_ONCE()... maybe that's what KCSAN is noticing?

(Actually, maybe it should technically even be a smp_load_acquire()?
Or do we have anything else that ensures that we can't get ordering
issues here?)

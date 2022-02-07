Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A808E4ACB9E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiBGVut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242743AbiBGVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:50:39 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569B6C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:50:39 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id g10so1251488vss.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrJtG/4VF3TjaBbbVCMP3L8XINzF0HJUnLz1QbyH774=;
        b=OIA3HNAQMQ2qVTofuripOySnB8XsK+KrH1Fa3nCSa0GqX6xDef7u1BLlL+FtDbAOpX
         TOBvrVoolEO8RU0TDuiBwgtNLaAX3h+uRyEJD0guTIQi7rsnaHX2dGgxhyacaT2cACUT
         w+CE+BDnIKB+i3OFkxXizBi1lDvw6ooJqJI6GNAp6PCI7KgmT9MnOODe/ZWG+zp0AcU+
         u9vL9zuuVh2XLlo/dSSDdnDLB2H4wlMkeGn/Ui2yupguX5P32j2n1cr6RyP+wWeXhN7T
         qjhzdD08Y22oWbMz5/7geaSRNBDXP0zgCMA0rPJqoziREry1FzjjJF61aK09qgc7vYhC
         Jv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrJtG/4VF3TjaBbbVCMP3L8XINzF0HJUnLz1QbyH774=;
        b=Jchg7tLUwFTdtHroR2ehkOhZ8zouZFn5Jg4gn2kbPztsTogncl4tMgHnJHs2213g0f
         I5waFCEpdU/Zs3DikjaJ7cC8S6Z5K4Xnp4UovwnfdyOKaXkCsqQhyoSJyZ4B64TZEEvY
         5uGTLf45uorcw1WcHU1IBpQaOPQT6OGhlfs5REMt41we+nO6cBmaZ5jYEwRDiL0Ojl1q
         oU5zP4rYDgOEfklieoZGXsge2Bq7Sr0PWAaiD05HYqWHEszcCvBLraK5dNazPuNfZ2ND
         yBI16+5cXR+KEuweNALorPpzUVj3yHzf8efW/FrYkoUv1pKQ7O3J2TB6Vpp1AYSBxxXF
         EwZA==
X-Gm-Message-State: AOAM530d8nCXw7k3fxHfyoHQDGQ/+DARMssHax7GfOI3SlQaDYv4EnkR
        gDGb485VcDJvwSlls94ZHCvyt5z5esD+gfpo3g8uag==
X-Google-Smtp-Source: ABdhPJw2An15tX4wk6vj87vqmn3C3Le56zen1+ee6Epwhv/PcbapVScQqxoFhNHrTGgijorQ6jNfOxXFsHZMSp+P1dE=
X-Received: by 2002:a67:e08d:: with SMTP id f13mr608800vsl.78.1644270638386;
 Mon, 07 Feb 2022 13:50:38 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com> <CAG48ez2P9-CAdgRizcp5T_uuoXRAt0xtodh1doiMW0fKZVX-7g@mail.gmail.com>
In-Reply-To: <CAG48ez2P9-CAdgRizcp5T_uuoXRAt0xtodh1doiMW0fKZVX-7g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Feb 2022 22:50:12 +0100
Message-ID: <CAG48ez3wZOZZX1UHM-Q=KhOnnGR85Unm08q7jT_wVfOq0PW94Q@mail.gmail.com>
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

On Mon, Feb 7, 2022 at 10:45 PM Jann Horn <jannh@google.com> wrote:
> On Mon, Feb 7, 2022 at 7:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Thanks for the report. I assume that this is actually an old bug. Do
> > you have a vmlinux or a random.o from this kernel you could send me to
> > double check? Without that, my best guess, which I'd say I have
> > relatively high confidence about, is that the "1 byte read" is
> > actually a `movzx eax, cs:lfsr` referring to the `static u8 lfsr`
> > here, which gets inlined into add_device_randomness:
> >
> > static int crng_slow_load(const u8 *cp, size_t len)
> > {
> >     unsigned long flags;
> >     static u8 lfsr = 1;
> >
> > This was added in 2008 with dc12baacb95f ("random: use a different
> > mixing algorithm for add_device_randomness()"). My understanding is
> > that the race here isn't super problematic as we're in kind of a half
> > assed "low effort" phase anyway. But I'll give it some thought. I'm
> > CCing Jann as well who reported the original issue that motivated that
> > change.
>
> But the "lfsr" variable is never accessed outside the part of this
> method that holds a global spinlock. So that can't really be it,
> right?

There is a data race in crng_ready(), it just loads from "crng_init"
without READ_ONCE()... maybe that's what KCSAN is noticing?

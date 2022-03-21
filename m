Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B794E30C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352666AbiCUT3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352783AbiCUT32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:29:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5D01C6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:28:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o6so21285865ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAWsI2xZdjmsgkIayOAfvbXj6QSCENchL/ixb22Oojs=;
        b=c3rW/0UGu3ACc30iJVBsMNiMbzNQVmHblpaZgVZAiIePVSTXEIcKOW2Q+XXahY0+Kd
         JbFPLOElnoMBi+Bb1ynGHm6kU4aHThsTcoSsm2V4VxsqdQff/XZyZIhb5TfCaGzw49vx
         /iA/yHCnMQ7wSqspAQy69WHzmRfkTiosz91R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAWsI2xZdjmsgkIayOAfvbXj6QSCENchL/ixb22Oojs=;
        b=p4Ic6Bo18ydKviSifJoByNwKVFvmphF0DpWs3H1rCF8wkXo8wa5bxh3JqDs1XOPKNK
         txpTtj0s8VZ6CpYcWguLayzzPvQlqsfk6IAinBQGNt3beenZhjkJs2NXozDKUhcIp7kP
         lW6P0cGIcpSrhPu5sO1zJmPdESc4rfZ5O5vmOjwknrsPyJZlq2rW3wa7kS4F245btHw4
         Z31mRD8PqkL3flVTpBfWqvXwePkrd29WEMJlHa3ag2kRpswPA66GO3d6nOfRIKUJHOcX
         xxHu6ek5ybMiKSUMurZ77O/JQ9qlEImpdehG3mXVODZpHXreXIh+2PSLJ5Z5rVd0fXQI
         dyWQ==
X-Gm-Message-State: AOAM533e9Z+lm7C3M65QCY01Ajnf1XVKhhIxZrjcnEk60tScWvKkgQqb
        Xujmwt8ovtvpeM29tKSj3Kc6tA0WcbUTOhFXSfo=
X-Google-Smtp-Source: ABdhPJxeGtPBbbSNqC2v7UgN+lewkd56IZRNsd8BrZfRfGnuA32nBcfTYDRIScXUtPkyF4wCGpZsBg==
X-Received: by 2002:a2e:7f13:0:b0:247:ef72:9e8b with SMTP id a19-20020a2e7f13000000b00247ef729e8bmr16262063ljd.205.1647890878204;
        Mon, 21 Mar 2022 12:27:58 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x23-20020a056512131700b004486c863c8esm1885328lfu.257.2022.03.21.12.27.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 12:27:56 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id b5so2670591ljf.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:27:56 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr16751676ljc.506.1647890876166; Mon, 21
 Mar 2022 12:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <164786042536.122591.4459156564791679956.tglx@xen13>
 <164786043041.122591.4693682080153649212.tglx@xen13> <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 12:27:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whi5jG0PjXmG6UHvvmZm5Y0MrLeBWbC=JQma1Upm-z6rA@mail.gmail.com>
Message-ID: <CAHk-=whi5jG0PjXmG6UHvvmZm5Y0MrLeBWbC=JQma1Upm-z6rA@mail.gmail.com>
Subject: Re: [GIT pull] x86/irq for v5.18-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Mon, Mar 21, 2022 at 12:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The fix seems obvious (you don't walk every byte to 1M, you walk to 1M
> - the size of the struct, and then you also check that the number of
> entries actually fits - Dmitry can presumably test), but no way do I
> want to get this kind of clearly broken thing this merge window.

Side note: the $PIRQ case avoids this because it walks 16 bytes at a
time, so the $PIRQ signature check itself will never overflow past the
1M mark.

But that code doesn't verify that the table itself then stays inside
that range, so that code is a bit fragile too.

At the same time, at least it has properly verified that it found the
right BIOS signature marker, so if the table is then bad and crosses
the 1M mark, it's arguably a BIOS bug (not that those don't happen,
and we should catch it).

In contrat, the $IRT code will walk over the boundary just *looking*
for the signature and not finding it (and not finding it is presumably
the normal thing, since $IRT is some odd legacy AMI-only thing).

                 Linus

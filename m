Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05748A658
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346980AbiAKDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346944AbiAKDbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:31:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C97C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:31:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 30so60155056edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEXDL2d5mW4dgNlrsV8b01CLHO2/qMkqM99n3xl1TPA=;
        b=FyLvpJ1ZUoGF3g5uvFCwTOHKR079Hu87MuIs3DVN7fscUsk3tY2DUgp69HVHHHQIjU
         XUFcHY9EZzK1MmE4mpTuhjOjaNxMOMXXCJ8e2hqbrcfjja8ztfJqy1UvHsRaKd/OdCR3
         +Pdqz2jBu645swYVXmS34WWp8g8qMucxzfWhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEXDL2d5mW4dgNlrsV8b01CLHO2/qMkqM99n3xl1TPA=;
        b=xnBlb36NkNqiZtpfi9NIp/iM0w870CQz/QJ4jiFNwQGE1QPWtvLnaYvzYmTp1PKJRQ
         R3zdpXVx0xxGel63Wf9gru09V/iX+9Qwr44PuTaW2OPVBT6H9t7GEXoW0TnWXHGqyObQ
         QJYdR2lzN4d0D6+uud03G4rVcSvP2caVeQkiBUMCiWfMICvPwPtO2CTZftGc6lzTkc3O
         GKjbjKGlsqA5tf0JShEoKAH3r5I2C0uuYdPcjn8XbDXbEzSLY1Rcc+Ev3nW0yM2ZPi55
         K6G/k/MdWGrMgG4jcqHJPXKs3jxXG/wPXnxajW0KMHIol3UAXlGl1AdLWKpswuDVPNcJ
         OWrQ==
X-Gm-Message-State: AOAM533hRlLQNpaoUdO/UYovgGPLxpRwRl0t5NydOcXpqqSs/7vlsWOj
        UCez5FN3FtuacLAt8Q9jvtHZ47Oc245hUzHvE8I=
X-Google-Smtp-Source: ABdhPJwuNcAGFnNUtrcUED94+k5RCpuBzrnxzcMRBMACHijFGkna0137176ye+yrTFq8J13etgv4yw==
X-Received: by 2002:a17:907:6d1b:: with SMTP id sa27mr2120886ejc.182.1641871907525;
        Mon, 10 Jan 2022 19:31:47 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id j17sm3039267ejg.164.2022.01.10.19.31.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 19:31:47 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id e5so10087205wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:31:46 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr633357wmq.8.1641871906578;
 Mon, 10 Jan 2022 19:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20220110025203.2545903-1-kuba@kernel.org>
In-Reply-To: <20220110025203.2545903-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 19:31:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-pW=bRuRUvhGmm0DgqZ45A0KaH85V5KkVoxGKX170Xg@mail.gmail.com>
Message-ID: <CAHk-=wg-pW=bRuRUvhGmm0DgqZ45A0KaH85V5KkVoxGKX170Xg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.17
To:     Jakub Kicinski <kuba@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 6:52 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> At the time of writing we have one known conflict (/build failure)
> with tip, Stephen's resolution looks good:

Ok, the trees that trigger the conflict haven't actually hit my tree
yet, so I'll see that particular conflict later.

I assume I'll get the irq_set_affinity_and_hint() patches from Thomas
at some point - Thomas, can  you make sure to remind me of this
conflict, because this is exactly the kind of thing I would catch on
my home machine due to doing full builds, but that I will probably
miss if I'm on the road.

I'm home for a couple more days and will try to do as much of the
merge window heavy lifting as possible before my travels start, but
we'll see..

>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/5.17-net-next

Merged. But I now note that this actually triggers an error when
building with clang:

  net/netfilter/nf_tables_api.c:8278:4: error: variable 'data_size' is
uninitialized when used here [-Werror,-Wuninitialized]
                          data_size += sizeof(*prule) + rule->dlen;
                          ^~~~~~~~~

and I think clang is entirely right.

Sadly, I didn't actually notice that before having done the merge, so
I'll have to do the fixup as a separate commit.

I really wish we had more automation doing clang builds. Yes, some
parts of the kernel are still broken with clang, but a lot isn't, and
this isn't the first time my clang build setup has found issues.

I also notice that NET_VENDOR_VERTEXCOM defaults to 'n'. That's fine
by me, but it seems unusual. Normally the 'enable vendor XYZ' tend to
default to 'y'. But for unusual (and new) vendors, maybe that 'n' is
the right thing to avoid unnecessary questions.

And maybe that NET_VENDOR_xyz thing has happened many times before,
and I just haven't happened to notice...

               Linus

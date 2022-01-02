Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B684828EF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 03:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiABC0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 21:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiABC0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 21:26:31 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44FBC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 18:26:30 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q6so23532197ilt.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 18:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UG2jSb8kA9oRJcvsbOmwOU1T1yK/woIGtRAfnSrv0BY=;
        b=hC0djHOVrEa+84O6QUbROpfQ1bDQ3GvH443C9vhJ15MrfO51pItzgB11iI0ay5YTCp
         +c3B+sUngkEbu28FFQrzVQUmU8D8tMr+EI183R+E4p+WyInwMoU/xo5RSXaEz0Jd1w5c
         1nP2Ry+udLrFT9rMbmJQi3DQiwzFz81EqF+gQLWQjedpQk1ms6bW6jSLFwCg7Yp3/ZjB
         UFfrIEQSTYNlo10bxIosscfGTo1rHOdHllSypsl/eNG9QRRiuK3QEw5lAorAhtDlw/qL
         tsMRTdbnjaF1SFVhksbA2TArqvcouxCl83X6Yof1HRtxKoJJppug/JBrVorJW/SVCcx5
         X/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG2jSb8kA9oRJcvsbOmwOU1T1yK/woIGtRAfnSrv0BY=;
        b=ZwNYSR/Q7816IPtm0ndRSadCUD6s5fQUfqHAi0+f1xDWS4tNU5UcfvLi8ZvqGsm51c
         uxXaPm7GORwM2kDBtFEzYZQ/pi1qBYUsGMzvNWRpsaodsc6oNGOH4zDPfz7jTibx2mEJ
         yCMpvlZ/97lsNDdNbwjQm/h6zmHH6LTybiTS9/S41QtYsheFNc9TZKXKdsRKWGTUmzgg
         c6zFDrqw6pRr1VrGF8QxOH0ONKQB78PePAvdA6mr24WTLvDPa9CaOqoqlwB17wlLDfaG
         ng1/GNT/HBTMY5vqEDFyyBA+KADtgW/4ibfFHW8pZy6XYx0ToNP4dfpLSkSM+uCo3XT4
         ERzg==
X-Gm-Message-State: AOAM5321+kRGbTwjgYRHWrM5coq33EFWsDaxfXoy+cxnoFFSnHfQcqeC
        61tk8UFHlXePfscsWoTAMiA4lfQJ1Xo7tssn8lBOfg/V
X-Google-Smtp-Source: ABdhPJzn+BA64FdUnnW7e3SgrTulwmxJQ2lYYvohpG8R1hpf0CH1DS/Awjd3VhGM000KM4gRMZaEHFydVxnZP1oNAsk=
X-Received: by 2002:a92:1e0a:: with SMTP id e10mr18753598ile.28.1641090388894;
 Sat, 01 Jan 2022 18:26:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640891329.git.andreyknvl@google.com> <CA+fCnZd+sBzecOGBD8zR3CxXS1yjV-X3-epAb6N=ZT8rJdCU6A@mail.gmail.com>
 <20211230183054.a06a88b459b393957cb2d823@linux-foundation.org>
In-Reply-To: <20211230183054.a06a88b459b393957cb2d823@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 2 Jan 2022 03:26:18 +0100
Message-ID: <CA+fCnZfgBKMN967XfbtOpGJJmpw-5_M2M_hd4fSM7gSsqvd=bw@mail.gmail.com>
Subject: Re: [PATCH mm v5 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 3:30 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 30 Dec 2021 20:19:01 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> > Could you PTAL and consider taking this into mm?
>
> What's PTAL?

It stands for "Please take a look".

> We're at -rc7 so I'll process this after -rc1.

Sounds good, thank you!

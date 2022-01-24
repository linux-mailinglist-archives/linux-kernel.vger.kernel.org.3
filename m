Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A3498867
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbiAXSdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiAXSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:33:09 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE579C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:33:09 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i14so14656926ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+ahb+ncTkNINLBQrDuikTk5BgmagpsijNgGC5Fq2MY=;
        b=pGkU+DYDv5talYflVfdNWi7FnnPfjgLyEauehNx0zBQQPb55D+r53HFtXXn4Vqzfwk
         bRn7ROziPHYUCR98gVW/qKjDl+Pq2MgHjHuUpTMkioxQfZIH4WxxuzlTmWN7NsZtCYho
         0ye+Mfou814+5HwLORyd+S2+4patNR6nACmrMnjnCWuvY8oxPvE3b/os8MGXqvqSZuUO
         7CaSqNwCWsMaI2C9Yy0yJ5T1rsh5AxEi2Ra8FyFMXGr9ztqOKDAnpLnjmcBgK3iuQX+y
         w/XjZ67gSb/dWsRaxJt3vF78b/pPpyZMIeKscYLoIz1a85wP/yLdVDWubuX20tqBubrS
         uhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+ahb+ncTkNINLBQrDuikTk5BgmagpsijNgGC5Fq2MY=;
        b=kulNlugcmUm/ILalUKlF0mlYYwgSYx6Dv/l6n2YFN07tiCdIcbQxc9mLuRRkV7DGQE
         bil27YQNqMhdd+IX0Z8UqnxRE+3son98sTOCGK43/TRO2iih7Xr3rlTaO97ItUdY0CF/
         RvcVF0s6o8piSdrs8l0ENPbZlNP6fQZNqirM7Kp5PoOmluBzUAU5HRTdmFgyStZ9yYvO
         12WImnnZ5oqEDa0zsSSlIgG6ayAp3LQKNLrFkC95TqXEPm/uXuylvDcPSv9EpWG/FjAg
         PbdX6t/loBu8G8qHSCod4ZiTB1EyVDbCegYCNamwFyulj1rsr8YjnjcBscp4f1/2Eo7o
         m2bA==
X-Gm-Message-State: AOAM533rxNtMS/4ugqmM+S55sQ6PI3SWYntcq2N6QjZjDQdzc/DcXvr0
        4Y1rdJUNOiWadzfw4LNbU68mNFsvUcjiizC1Z5Q=
X-Google-Smtp-Source: ABdhPJze2sDkxQzD9hQA68DGJMg8/lxH8/CW/ZjU8yd6vTdPIakmMsD0/msvexpDol+iVGPwDQRx5BZOI0zWWV1F2+U=
X-Received: by 2002:a92:d2c3:: with SMTP id w3mr1032639ilg.28.1643049189234;
 Mon, 24 Jan 2022 10:33:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643047180.git.andreyknvl@google.com> <CANpmjNO2Lwq5+zy3pGj=cetMdB7qLmP0WWjbSCYucPVjEt4kWw@mail.gmail.com>
In-Reply-To: <CANpmjNO2Lwq5+zy3pGj=cetMdB7qLmP0WWjbSCYucPVjEt4kWw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 24 Jan 2022 19:32:58 +0100
Message-ID: <CA+fCnZdxFnxXJyv6rqRgZynK5NC-PS1jSpAdwqVgymr2AL+63Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 7:09 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 24 Jan 2022 at 19:02, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Hi,
> >
> > This patchset adds vmalloc tagging support for SW_TAGS and HW_TAGS
> > KASAN modes.
> [...]
> >
> > Acked-by: Marco Elver <elver@google.com>
>
> FYI, my Ack may get lost here - on rebase you could apply it to all
> patches to carry it forward. As-is, Andrew would still have to apply
> it manually.

Sounds good, will do if there is a v7.

> An Ack to the cover letter saves replying to each patch and thus
> generating less emails, which I think is preferred.
>
> My Ack is still valid, given v6 is mainly a rebase and I don't see any
> major changes.

Thanks, Marco!
